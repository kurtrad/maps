///////////////////////////////////////////////////////////////////////////
// Copyright © 2015 Republic Services Inc. All Rights Reserved.
//
// Licensed under the Apache License Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Description: check to see if the user has cleared cach since loading a previous version
// if not they are redirected to the version.html page
//
///////////////////////////////////////////////////////////////////////////////
// Code Changes                                                              //
// <USERID> <Change ID> <DATE> <DESCRIPTION>                                 //
// handeka  US642 Feb 11/2016 initial version                                //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

define([
      "dojo/_base/declare"

], function (
    declare
) {
    return declare(null, {
        checkLocalStorageVersion: function () {
            var versionlocalStorage;
            var blnReturn = true
            var versionKey = "1";
            var currentVersion = "1";

            // This checks the browser for Local Storage support - if not supported the unsupported version check will forward user to upgrade page
            if (typeof (Storage) !== "undefined") {
                var versionlocalStorage = localStorage.getItem(versionKey);
                if (app.util.isNull(versionlocalStorage)) {
                    //nothing in the cache just set the version
                    versionlocalStorage = currentVersion;
                    localStorage.setItem(versionKey, versionlocalStorage);
                }

                if (!("1" == versionlocalStorage)) {
                    //new version, user must clear the cache
                    blnReturn = false
                }

            }
            return blnReturn;
        }
    });
});