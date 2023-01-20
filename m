Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14606751A0
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 10:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjATJvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjATJvP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 04:51:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E2A7335;
        Fri, 20 Jan 2023 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674208263; x=1705744263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+NODKpXGgRWPolcUM1Qi5uoz45kJmv9lNTStOllz+go=;
  b=PX3RvUeLYhQMRv/pCqTcWWrxnszkXkn22f+DmiPuRCySt7MnqRHYjkqR
   m9KUozaeiak0AGJgPY2ZjYXKfRsqrxhQT/cFHIygu9N21fhxHQ0jrfDZw
   S5FVUQnHIAw/ogWys4wsvW6/tOC5pDi/8sPRdhXSq6JjgqAgiM8hi+0Mx
   jhmwVmqR/vWPf3pHvh+n+zzYZteK54poJmOoW2bCBha9RiqnULx5HXDrx
   W40ReqxYYMpEVtWg1GcdvTaQO8zJYebtHVl6gSbO2rbLj9YjCnFj9ob1c
   k3e4nbfrKKQJUzk1Hk2XcJuDYiWbmZghkTJy20nP02uBzpWTgw0uWk4DA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309120726"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="309120726"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="660533288"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="660533288"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2023 01:50:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIo2v-0002SC-1V;
        Fri, 20 Jan 2023 09:50:53 +0000
Date:   Fri, 20 Jan 2023 17:50:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH RESEND bpf-next 2/4] security: Generate a header with the
 count of enabled LSMs
Message-ID: <202301201738.WShrQVx6-lkp@intel.com>
References: <20230120000818.1324170-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: s390-randconfig-r044-20230119 (https://download.01.org/0day-ci/archive/20230120/202301201738.WShrQVx6-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/831b06220bb29c6db171467b13903dac0ef2faa5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230120-133309
        git checkout 831b06220bb29c6db171467b13903dac0ef2faa5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/security/gen_lsm_count.c:13:
>> include/linux/kconfig.h:5:10: fatal error: 'generated/autoconf.h' file not found
   #include <generated/autoconf.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
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
