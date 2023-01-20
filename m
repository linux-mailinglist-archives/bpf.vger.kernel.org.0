Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0967519D
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjATJvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 04:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjATJvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 04:51:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701479E86;
        Fri, 20 Jan 2023 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674208258; x=1705744258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+bJJSwTXBPjXTdDFdJCpuZm2//lzZ8dGj92rVDsGIw=;
  b=SjmEDy1jVE7DDjZzHY0K2gjfbWDR8xsVv1Xmsjtx6y0F+HyLdmNFkShZ
   XRJwupwjgu4ubTJ2eu4dtOXWpJmi4ItsJTkG74nfb+zP1rcXMZriE2ROp
   VwfojJsHID51ocCxQ+ciYPq8SSyNT6VHAziWApuyoP4w+EiIAGI5xBFIx
   yHGeTd12iwudsZ2josIW7BgUsV+nrVzMMndjzZrUh+OtHhl8NPAtX4iE/
   d0MAwRGkODXxYls5sdneBu52e/Il2Iu+/nAc+U48Q7o/JMfj+9Kc2YQjY
   Qyt4aMCxGDnTYTMprWqevBTOKow6vAMBGDgdBIRPBcaPWoeIX8q+RxCsF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326822931"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="326822931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905910297"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="905910297"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2023 01:50:54 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIo2v-0002SA-1Q;
        Fri, 20 Jan 2023 09:50:53 +0000
Date:   Fri, 20 Jan 2023 17:50:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, jackmanb@google.com, renauld@google.com,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH RESEND bpf-next 2/4] security: Generate a header with the
 count of enabled LSMs
Message-ID: <202301201746.Q5765zQF-lkp@intel.com>
References: <20230120000818.1324170-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230120000818.1324170-3-kpsingh%40kernel.org
patch subject: [PATCH RESEND bpf-next 2/4] security: Generate a header with the count of enabled LSMs
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230120/202301201746.Q5765zQF-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/831b06220bb29c6db171467b13903dac0ef2faa5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
        git checkout 831b06220bb29c6db171467b13903dac0ef2faa5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/security/gen_lsm_count.c:13:
>> include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No such file or directory
       5 | #include <generated/autoconf.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.host:111: scripts/security/gen_lsm_count] Error 1
   make[3]: Target 'scripts/security/' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:504: scripts/security] Error 2
   make[2]: Target 'scripts/' not remade because of errors.
   make[1]: *** [Makefile:1270: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:242: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +5 include/linux/kconfig.h

2a11c8ea20bf85 Michal Marek 2011-07-20  4  
2a11c8ea20bf85 Michal Marek 2011-07-20 @5  #include <generated/autoconf.h>
2a11c8ea20bf85 Michal Marek 2011-07-20  6  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
