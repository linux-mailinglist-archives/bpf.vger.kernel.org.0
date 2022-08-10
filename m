Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEE58F192
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiHJRaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJRaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:30:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D77D1F2;
        Wed, 10 Aug 2022 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660152601; x=1691688601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bykYbYPOP2ykVd42qMyImQ8k5A0R8hQb1xOGGxEr7Q0=;
  b=diFo+iSoQygf+C306DWMf+QT7RA3bgZGWsS4n1uqHMREZkVkWZY5BMHw
   pm+xooh72Xp6oiI/2+nQEbF7xNkqaDOW5KNS8I+FCpVWtcBp515Nr+JWk
   SO0dvKD5KCkOsvbV3EPe0YalAeI5eKGtlhu21qCBgzP45eJHPoXDOWKlS
   pZzMTrOzT2NcRFbwJ/kajii4ByoqO1OciICIpFbVZqrSTr4noNMwxJjuZ
   N0EmVkPdSVA7MKt7vVwGNVQxaOzY/C4nkzpBB1PW+DVurn+Qed9BDbqpG
   u6fIYHK/vPI/KnWCfHfLfeT5q50uD0YSfMf06sFZqbGFFSfP440pInLgt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274203150"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="274203150"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="694600860"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2022 10:29:58 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLpWn-0000XP-1N;
        Wed, 10 Aug 2022 17:29:57 +0000
Date:   Thu, 11 Aug 2022 01:28:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <202208110130.PZkeHYmL-lkp@intel.com>
References: <20220809094300.83116-2-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-2-hadess@hadess.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Bastien,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on balbi-usb/testing/next peter-chen-usb/for-usb-next linus/master v5.19 next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220811/202208110130.PZkeHYmL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6bd6f04e6d463be82fbf45585e4af84925bf1ab9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
        git checkout 6bd6f04e6d463be82fbf45585e4af84925bf1ab9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/core/devio.c: In function 'usb_revoke_for_euid':
>> drivers/usb/core/devio.c:2649:1: warning: label 'out' defined but not used [-Wunused-label]
    2649 | out:
         | ^~~


vim +/out +2649 drivers/usb/core/devio.c

  2627	
  2628	int usb_revoke_for_euid(struct usb_device *udev,
  2629			int euid)
  2630	{
  2631		struct usb_dev_state *ps;
  2632	
  2633		usb_lock_device(udev);
  2634	
  2635		list_for_each_entry(ps, &udev->filelist, list) {
  2636			if (euid >= 0) {
  2637				kuid_t kuid;
  2638	
  2639				if (!ps || !ps->cred)
  2640					continue;
  2641				kuid = ps->cred->euid;
  2642				if (kuid.val != euid)
  2643					continue;
  2644			}
  2645	
  2646			usbdev_revoke(ps);
  2647		}
  2648	
> 2649	out:
  2650		usb_unlock_device(udev);
  2651		return 0;
  2652	}
  2653	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
