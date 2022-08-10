Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530458F20D
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiHJSAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiHJSAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 14:00:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974E6C113;
        Wed, 10 Aug 2022 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660154404; x=1691690404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fyz/5NQriJw7zDpiMUgJgMy7EUYhj2aqcm/VIEiNRmc=;
  b=jg7jXsNr2m2fO+5y6BjhMJLroBReUgH81xCI8nQaxnGOAKyP5b6eSYLC
   0sggZjJNmjmSs7O6/Bl0dj8UzKIAKBBotUQ9P/YXx9k2JQcdceZM5fUpD
   zOkTyCoK7B1TfddZJ18auzE6kQ+cN8DG/a+iAgFClzd4BUfjmnbjSiVH1
   YrnKAZBYZ9CmaoBP+7h5mwTv94GDIUHDDIYogNo1L0AGRH38UoCwaJGTI
   quZGXN3SFY9ORNkAseNunPNVqxGYAbN2l2zWye7jMbcsRIFKr/Uh0ve0S
   9sUDjGLgeeLYDbyksYxmk3SR6wYsnA5LYlAgJgHyTrGbF2C7kHIugB7au
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271538747"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271538747"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="747523447"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2022 11:00:00 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLpzr-0000Z3-1x;
        Wed, 10 Aug 2022 17:59:59 +0000
Date:   Thu, 11 Aug 2022 01:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
Message-ID: <202208110101.rbONyPek-lkp@intel.com>
References: <20220809094300.83116-3-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-3-hadess@hadess.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Bastien,

I love your patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on balbi-usb/testing/next peter-chen-usb/for-usb-next linus/master v5.19 next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm64-randconfig-r001-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110101.rbONyPek-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b8d37bab24eee13dfbbb947c6a44f5f363c6bb7a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bastien-Nocera/USB-core-add-a-way-to-revoke-access-to-open-USB-devices/20220809-174609
        git checkout b8d37bab24eee13dfbbb947c6a44f5f363c6bb7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/usb/core/usb.c:465:1: warning: no previous prototype for function 'usb_revoke_device' [-Wmissing-prototypes]
   usb_revoke_device(int busnum, int devnum, unsigned int euid)
   ^
   drivers/usb/core/usb.c:464:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline int
            ^
            static 
>> drivers/usb/core/usb.c:1050:3: error: field designator 'check_set' does not refer to any field in type 'const struct btf_kfunc_id_set'
           .check_set = &usbdev_kfunc_ids,
            ^
   1 warning and 1 error generated.


vim +1050 drivers/usb/core/usb.c

  1047	
  1048	static const struct btf_kfunc_id_set usbdev_kfunc_set = {
  1049		.owner     = THIS_MODULE,
> 1050		.check_set = &usbdev_kfunc_ids,
  1051	};
  1052	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
