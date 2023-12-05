Return-Path: <bpf+bounces-16728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E941F805352
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 12:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250EA1C20BB5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFA58AA8;
	Tue,  5 Dec 2023 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PX2b4XNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA29C3
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701776858; x=1733312858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Et+Xza31FNtHe5uhFOn7Lea9bEswFiKoJ5m6yuAIHhY=;
  b=PX2b4XNJXUdaYPzmOYCCy7ZGt6FFxJY29XRHOUSfy+6pNF1KKNglESHk
   0Wy6FE9u90CWSPK+Qe2mgwGzZAhBhuTW/nQDaTmv9ePGzSe8B2ZNr+rBc
   kaUJ6mYvZjdXU1Rjjikw2ARGEPwulENu8lqDX0HHfnFTBpQMRL1cXzPF5
   CbRE7V5UQQy2SrHgraC+OHG5sNb90Fm/+NjDQdAcrCa4YKn4TPs7FJLpW
   Vdwq83QBsFzOUvyTQWbaEBBFo1tu9xmVCqUH5kSpA1MrQlQUSCs4l8N4X
   bGYDL00jmdH7ySydEI2bU45PF7tJQ4tPmFcOBO+608zhxmRNW56yPNijE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="397778077"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="397778077"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764304062"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="764304062"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 03:47:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rATtk-0008uS-34;
	Tue, 05 Dec 2023 11:47:32 +0000
Date: Tue, 5 Dec 2023 19:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/13] bpf: move subprog call logic back to
 verifier.c
Message-ID: <202312051900.XRWfHJW0-lkp@intel.com>
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
config: x86_64-randconfig-004-20231205 (https://download.01.org/0day-ci/archive/20231205/202312051900.XRWfHJW0-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051900.XRWfHJW0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051900.XRWfHJW0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:5083:5: warning: no previous prototype for function 'check_ptr_off_reg' [-Wmissing-prototypes]
   int check_ptr_off_reg(struct bpf_verifier_env *env,
       ^
   kernel/bpf/verifier.c:5083:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int check_ptr_off_reg(struct bpf_verifier_env *env,
   ^
   static 
>> kernel/bpf/verifier.c:7268:5: warning: no previous prototype for function 'check_mem_reg' [-Wmissing-prototypes]
   int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
       ^
   kernel/bpf/verifier.c:7268:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
   ^
   static 
>> kernel/bpf/verifier.c:8254:5: warning: no previous prototype for function 'check_func_arg_reg_off' [-Wmissing-prototypes]
   int check_func_arg_reg_off(struct bpf_verifier_env *env,
       ^
   kernel/bpf/verifier.c:8254:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int check_func_arg_reg_off(struct bpf_verifier_env *env,
   ^
   static 
   3 warnings generated.


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

