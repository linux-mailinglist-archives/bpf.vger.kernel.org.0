Return-Path: <bpf+bounces-2489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F972DBF5
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 10:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59242811AE
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683035CBB;
	Tue, 13 Jun 2023 08:03:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D452581
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:03:58 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB14170E
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686643436; x=1718179436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8VB2fSbfG7bVXnvN2SMewZux4+XqMyV3m8Nsf25Mv74=;
  b=ij+lHJmT6Mb2m72wMIhz/Ggd8BIKuesp++eE5jlzgOkqng5ThA6SDi/q
   F9P4zpziv+laV4A+IUsOvoYlubILAtR9q0e09FrXakaEkUmj+HShMY7vf
   QQVFjU4JYnBH7QWOwytI0FvxUpO2zl5hW7/zagPgmi6jgnW1d99YEfsT7
   kM5hcnDwBsRImt2N19YzbgNrFTZeSlx5MB4+OZzC0IqP08TzzRNrPnwnQ
   iqnQ8wiUQg8yaDviwdNrCgEHlU5r/U2d6PjwSdAFqabCI896+twb39nQC
   bEDtdTWs1zSF/EzwPl7OA+ho8Dp75GroYtx6t9mTbsB5zQghZCXdyVTlE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361630666"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="361630666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="958317069"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="958317069"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2023 01:03:42 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q8z09-00017W-2p;
	Tue, 13 Jun 2023 08:03:41 +0000
Date: Tue, 13 Jun 2023 16:02:55 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
Message-ID: <202306131550.U3M9AJGm-lkp@intel.com>
References: <20230612160801.2804666-4-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612160801.2804666-4-eddyz87@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-use-scalar-ids-in-mark_chain_precision/20230613-001651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230612160801.2804666-4-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v5 3/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230613/202306131550.U3M9AJGm-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
        git fetch bpf-next master
        git checkout bpf-next/master
        b4 shazam https://lore.kernel.org/r/20230612160801.2804666-4-eddyz87@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131550.U3M9AJGm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:10:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:254:
>> include/linux/fortify-string.h:430:4: warning: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
                           __write_overflow_field(p_size_field, size);
                           ^
   1 warning generated.


vim +/warning +430 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  411  
28e77cc1c06866 Kees Cook      2021-06-16  412  __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
28e77cc1c06866 Kees Cook      2021-06-16  413  					 const size_t p_size,
28e77cc1c06866 Kees Cook      2021-06-16  414  					 const size_t p_size_field)
a28a6e860c6cf2 Francis Laniel 2021-02-25  415  {
28e77cc1c06866 Kees Cook      2021-06-16  416  	if (__builtin_constant_p(size)) {
28e77cc1c06866 Kees Cook      2021-06-16  417  		/*
28e77cc1c06866 Kees Cook      2021-06-16  418  		 * Length argument is a constant expression, so we
28e77cc1c06866 Kees Cook      2021-06-16  419  		 * can perform compile-time bounds checking where
fa35198f39571b Kees Cook      2022-09-19  420  		 * buffer sizes are also known at compile time.
28e77cc1c06866 Kees Cook      2021-06-16  421  		 */
a28a6e860c6cf2 Francis Laniel 2021-02-25  422  
28e77cc1c06866 Kees Cook      2021-06-16  423  		/* Error when size is larger than enclosing struct. */
fa35198f39571b Kees Cook      2022-09-19  424  		if (__compiletime_lessthan(p_size_field, p_size) &&
fa35198f39571b Kees Cook      2022-09-19  425  		    __compiletime_lessthan(p_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  426  			__write_overflow();
28e77cc1c06866 Kees Cook      2021-06-16  427  
28e77cc1c06866 Kees Cook      2021-06-16  428  		/* Warn when write size is larger than dest field. */
fa35198f39571b Kees Cook      2022-09-19  429  		if (__compiletime_lessthan(p_size_field, size))
28e77cc1c06866 Kees Cook      2021-06-16 @430  			__write_overflow_field(p_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  431  	}
28e77cc1c06866 Kees Cook      2021-06-16  432  	/*
28e77cc1c06866 Kees Cook      2021-06-16  433  	 * At this point, length argument may not be a constant expression,
28e77cc1c06866 Kees Cook      2021-06-16  434  	 * so run-time bounds checking can be done where buffer sizes are
28e77cc1c06866 Kees Cook      2021-06-16  435  	 * known. (This is not an "else" because the above checks may only
28e77cc1c06866 Kees Cook      2021-06-16  436  	 * be compile-time warnings, and we want to still warn for run-time
28e77cc1c06866 Kees Cook      2021-06-16  437  	 * overflows.)
28e77cc1c06866 Kees Cook      2021-06-16  438  	 */
28e77cc1c06866 Kees Cook      2021-06-16  439  
28e77cc1c06866 Kees Cook      2021-06-16  440  	/*
28e77cc1c06866 Kees Cook      2021-06-16  441  	 * Always stop accesses beyond the struct that contains the
28e77cc1c06866 Kees Cook      2021-06-16  442  	 * field, when the buffer's remaining size is known.
311fb40aa0569a Kees Cook      2022-09-02  443  	 * (The SIZE_MAX test is to optimize away checks where the buffer
28e77cc1c06866 Kees Cook      2021-06-16  444  	 * lengths are unknown.)
28e77cc1c06866 Kees Cook      2021-06-16  445  	 */
311fb40aa0569a Kees Cook      2022-09-02  446  	if (p_size != SIZE_MAX && p_size < size)
28e77cc1c06866 Kees Cook      2021-06-16  447  		fortify_panic("memset");
28e77cc1c06866 Kees Cook      2021-06-16  448  }
28e77cc1c06866 Kees Cook      2021-06-16  449  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

