Return-Path: <bpf+bounces-16714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B27804BAE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3108AB20D9C
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3D3A260;
	Tue,  5 Dec 2023 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzerKh4b"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB611F
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701763364; x=1733299364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QIOkhm0gALKjGzbgLxGsPjX2kcP68mlAYfB69wuLqwg=;
  b=lzerKh4bUrJw+5Qe4BypSM/P3cxmU8TUpBCnAh1EYxbrW88+U3lVshDA
   j/nM/NpkzCBjQ25kkwC4JxR4JBieW2P5CaEuyIw51MhL7Yvhpds9vOYg+
   q3XDGbODmqu6OHoN9eCZs5jdPDSC580EwhPAJgoNlE8RFdeCIJBObs5qy
   o8mHabXfWp1ejvngcQFjboj0TcFJbIoHZF8Csls/mMlUZw+4Mb/dSkcZ+
   Ppo8SZ6Hq1ckm2y3YyzN+NEboRXOm+KSdfDnSNQKbnWp1Scv94VffscZW
   Fi2B1Zav8DkwRpcPY44Xd7JKCg0i5KwkNX+lg4UZmB52sTH+Yx29eNOwh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12575210"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="12575210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 00:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="18871583"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2023 00:02:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAQNg-0008Xc-0u;
	Tue, 05 Dec 2023 08:02:12 +0000
Date: Tue, 5 Dec 2023 16:01:20 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/13] bpf: move subprog call logic back to
 verifier.c
Message-ID: <202312051530.hEAmx5zj-lkp@intel.com>
References: <20231204233931.49758-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233931.49758-9-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-log-PTR_TO_MEM-memory-size-in-verifier-log/20231205-074451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231204233931.49758-9-andrii%40kernel.org
patch subject: [PATCH bpf-next 08/13] bpf: move subprog call logic back to verifier.c
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051530.hEAmx5zj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051530.hEAmx5zj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051530.hEAmx5zj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:5083:5: warning: no previous prototype for 'check_ptr_off_reg' [-Wmissing-prototypes]
    5083 | int check_ptr_off_reg(struct bpf_verifier_env *env,
         |     ^~~~~~~~~~~~~~~~~
>> kernel/bpf/verifier.c:7268:5: warning: no previous prototype for 'check_mem_reg' [-Wmissing-prototypes]
    7268 | int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
         |     ^~~~~~~~~~~~~
>> kernel/bpf/verifier.c:8254:5: warning: no previous prototype for 'check_func_arg_reg_off' [-Wmissing-prototypes]
    8254 | int check_func_arg_reg_off(struct bpf_verifier_env *env,
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/check_ptr_off_reg +5083 kernel/bpf/verifier.c

e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5082  
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15 @5083  int check_ptr_off_reg(struct bpf_verifier_env *env,
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5084  		      const struct bpf_reg_state *reg, int regno)
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5085  {
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5086  	return __check_ptr_off_reg(env, reg, regno, false);
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5087  }
e9147b4422e1f3 Kumar Kartikeya Dwivedi 2022-04-15  5088  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

