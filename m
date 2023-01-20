Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD2675220
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjATKLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 05:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATKLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 05:11:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE218B326;
        Fri, 20 Jan 2023 02:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674209464; x=1705745464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zke/P6VKYbLURYoSo0MzL+Ho/FFPmy06GgD48i/evLY=;
  b=QrRGUg6JBykPkWbxCMupA+DYViqCmTW7L+mbUnvFfknkDRc0g40RgZnD
   FFj/QJ0ux5yU0C611ETB20iqi632KTB3eNUfRBLr1vg0q09TvoRuTyaaA
   K/ejNQ0aTW7je6kFCHkbEWBJ38hpQTvA9OrYuoG86h5S5GzDnFVPSuwff
   d4GOCsHd9j++A42YbcLIm6ffno+f24l47kOHkG9Hkfhfem5x5wHXuYatT
   4cM9Cv4B/CbMUHYqkPjns3r7TGPx6Fw7BCkS6OPxfEUMdgsUbiUcRU3Hb
   Axy0wVGiwlgCKOlLiZUO/1javFANEum8jvgtLJsQDm5v+awgNxAlLm7MR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327641537"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="327641537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 02:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989358665"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="989358665"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 02:11:00 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIoMJ-0002T1-0L;
        Fri, 20 Jan 2023 10:10:55 +0000
Date:   Fri, 20 Jan 2023 18:10:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, jackmanb@google.com, renauld@google.com,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
Message-ID: <202301201833.YM7Hr62n-lkp@intel.com>
References: <20230120000818.1324170-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi KP,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230120000818.1324170-4-kpsingh%40kernel.org
patch subject: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook calls with static calls
config: arc-randconfig-r043-20230119 (https://download.01.org/0day-ci/archive/20230120/202301201833.YM7Hr62n-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1dfb90849b42d8af6e854cd6ae8cd96d1ebfc50a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
        git checkout 1dfb90849b42d8af6e854cd6ae8cd96d1ebfc50a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bpf_lsm.h:12,
                    from kernel/bpf/syscall.c:31:
>> include/linux/lsm_hooks.h:36:10: fatal error: generated/lsm_count.h: No such file or directory
      36 | #include <generated/lsm_count.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +36 include/linux/lsm_hooks.h

    34	
    35	/* Include the generated MAX_LSM_COUNT */
  > 36	#include <generated/lsm_count.h>
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
