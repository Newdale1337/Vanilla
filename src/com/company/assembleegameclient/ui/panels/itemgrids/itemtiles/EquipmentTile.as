﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile

package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.ColorMatrixFilter;

import kabam.rotmg.constants.ItemConstants;

public class EquipmentTile extends InteractiveItemTile 
    {

        private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x363636));

        public var backgroundDetail:Bitmap;
        public var itemType:int;
        private var minManaUsage:int;

        public function EquipmentTile(_arg_1:int, _arg_2:ItemGrid, _arg_3:Boolean)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function canHoldItem(_arg_1:int):Boolean
        {
            return ((_arg_1 <= 0) || (this.itemType == ObjectLibrary.getSlotTypeFromType(_arg_1)));
        }

        public function setType(_arg_1:int):void
        {
            var _local_2:BitmapData = ItemConstants.itemTypeToBaseSprite(_arg_1);
            if (_local_2 != null)
            {
                this.backgroundDetail = new Bitmap(_local_2);
                this.backgroundDetail.x = BORDER;
                this.backgroundDetail.y = BORDER;
                this.backgroundDetail.scaleX = 4;
                this.backgroundDetail.scaleY = 4;
                this.backgroundDetail.filters = [greyColorFilter];
                addChildAt(this.backgroundDetail, 0);
            }
            this.itemType = _arg_1;
        }

        override public function setItem(_arg_1:int):Boolean
        {
            var _local_2:Boolean = super.setItem(_arg_1);
            if (_local_2)
            {
                this.backgroundDetail.visible = (itemSprite.itemId <= 0);
                this.updateMinMana();
            }
            return (_local_2);
        }

        private function updateMinMana():void
        {
            var _local_1:XML;
            this.minManaUsage = 0;
            if (itemSprite.itemId > 0)
            {
                _local_1 = ObjectLibrary.xmlLibrary_[itemSprite.itemId];
                if (((_local_1) && (_local_1.hasOwnProperty("Usable"))))
                {
                    if (_local_1.hasOwnProperty("MultiPhase"))
                    {
                        this.minManaUsage = _local_1.MpEndCost;
                    }
                    else
                    {
                        this.minManaUsage = _local_1.MpCost;
                    }
                }
            }
        }

        public function updateDim(_arg_1:Player):void
        {
            itemSprite.setDim(((_arg_1) && ((_arg_1.mp_ < this.minManaUsage) || ((this.minManaUsage) && (_arg_1.isSilenced())))));
        }

        override protected function beginDragCallback():void
        {
            this.backgroundDetail.visible = true;
        }

        override protected function endDragCallback():void
        {
            this.backgroundDetail.visible = (itemSprite.itemId <= 0);
        }

        override protected function getBackgroundColor():int
        {
            return (0x454545);
        }


    }
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles

