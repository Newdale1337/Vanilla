﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.core.commands.ConfigureSpamFilterCommand

package kabam.rotmg.core.commands
{
import kabam.rotmg.chat.control.SpamFilter;

import robotlegs.bender.bundles.mvcs.Command;

public class ConfigureSpamFilterCommand extends Command
    {

        [Inject]
        public var data:XML;
        [Inject]
        public var spamFilter:SpamFilter;


        override public function execute():void
        {
            this.spamFilter.setPatterns(this.data.FilterList.split(/\n/g));
        }


    }
}//package kabam.rotmg.core.commands

