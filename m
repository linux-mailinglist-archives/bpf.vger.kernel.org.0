Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317104BAA15
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 20:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiBQTrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 14:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245349AbiBQTrU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 14:47:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F732654C;
        Thu, 17 Feb 2022 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127224; x=1676663224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSCKqfDMdMI/r89h9i7FEF/tyXYo2PHT5q86Bt1G8+0=;
  b=TqYOpVdXJ9E2l92O79IeNLH5ZMU4IVsHp/AeiVxzOOsbnIbfnCrvtlll
   8bpZVmbLRPfvAHvvYoA83gjunRE5ven0IKXagKKdZnWwjC5VPKIyw8rbC
   WXdzejcz/sXdX7QJJ5R2lI+ln2wi5nPOX/gwizbvfWUdS+jN9gywGScY8
   S75l5In9dYbwQ7REyZvNcCYDlUtEBxEOcDSx258QCu9ttbo+FamVS56if
   P+jmgo0OTxwp5hwOV1o9PtceX1G8VXbmn40r/6Dn5Y2M4v3F/GyDiLHRz
   /HjvP4ku9oOQ2zmdw+Y3vnbiA0g6nF51LpIYW7Mv/O4HCBcTeepR+b9Q1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="249794921"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="249794921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="571969855"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000U9-6S; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, Nicholas Piggin <npiggin@gmail.com>,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/ftrace: Reserve instructions from function
 entry for ftrace
Message-ID: <202202180014.IWuzQ9al-lkp@intel.com>
References: <8843d65ac0878232433573d10ebee30457748624.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8843d65ac0878232433573d10ebee30457748624.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi "Naveen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 1b43a74f255c5c00db25a5fedfd75ca0dc029022]

url:    https://github.com/0day-ci/linux/commits/Naveen-N-Rao/powerpc-ftrace-Reserve-instructions-from-function-entry-for-ftrace/20220217-200314
base:   1b43a74f255c5c00db25a5fedfd75ca0dc029022
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180014.IWuzQ9al-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6a1891335e377e5def312e7c182aef676f04c926
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Naveen-N-Rao/powerpc-ftrace-Reserve-instructions-from-function-entry-for-ftrace/20220217-200314
        git checkout 6a1891335e377e5def312e7c182aef676f04c926
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/trace/ftrace.c:504:5: warning: no previous prototype for 'ftrace_location_get_offset' [-Wmissing-prototypes]
     504 | int ftrace_location_get_offset(const struct dyn_ftrace *rec)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ftrace_location_get_offset +504 arch/powerpc/kernel/trace/ftrace.c

   502	
   503	#if defined(CONFIG_MPROFILE_KERNEL) || defined(CONFIG_PPC32)
 > 504	int ftrace_location_get_offset(const struct dyn_ftrace *rec)
   505	{
   506		if (IS_ENABLED(CONFIG_MPROFILE_KERNEL))
   507			/*
   508			 * On ppc64le with -mprofile-kernel, function entry can have:
   509			 *   addis r2, r12, M
   510			 *   addi  r2, r2, N
   511			 *   mflr  r0
   512			 *   bl    _mcount
   513			 *
   514			 * The first two instructions are for TOC setup and represent the global entry
   515			 * point for cross-module calls, and may be missing if the function is never called
   516			 * from other modules.
   517			 */
   518			return ((unsigned long)rec->arch.mod & 0x1) ? FUNC_MCOUNT_OFFSET_PPC64_GEP :
   519								      FUNC_MCOUNT_OFFSET_PPC64_LEP;
   520		else
   521			/*
   522			 * On ppc32, function entry always has:
   523			 *   mflr r0
   524			 *   stw  r0, 4(r1)
   525			 *   bl   _mcount
   526			 */
   527			return FUNC_MCOUNT_OFFSET_PPC32;
   528	}
   529	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
