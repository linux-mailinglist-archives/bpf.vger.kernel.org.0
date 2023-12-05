Return-Path: <bpf+bounces-16724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471AF8052CA
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 12:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FA5B208B4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED46978B;
	Tue,  5 Dec 2023 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAip40gw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D12D60
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701775592; x=1733311592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kR7XgPa/DY6vDp0IPDn9ThXN3rwHUZrx8uk/wh+rHJY=;
  b=MAip40gwQbwSpWmYJmjmKwbHnb9DF8xFVK4Eo6XX2mizKMX7lf1fHbY4
   fXFpdchGqqUYNhnyfLcXYZW1lSOO9qu1pR4LM1QOmQqsaISwvMhENljwL
   wpRAdc03nfp5n6xoEmS0pnksllRlvhYyuJ+kLYAaBDFgYo5//QC0eLaBp
   zjKU4keQvLeqV92yW0gktuz0ZFcYgzi1hhfa/f77Ppy7SKlwnNmug0TwS
   XcQPXG2xn7Qk0Mm5mPbhizYxew4r2pI5FSl2R41f0CS2pUTj7A0bsqHcg
   YKSvNnueFLPYAOzvo7xU7T354OKO1nWl8lZh4saxxWqmfXFwpQTbVwiq0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12596676"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12596676"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764298776"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="764298776"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 03:26:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rATZJ-0008rZ-1F;
	Tue, 05 Dec 2023 11:26:25 +0000
Date: Tue, 5 Dec 2023 19:25:44 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing logic
 for subprog call checks
Message-ID: <202312051916.zf1FwihO-lkp@intel.com>
References: <20231204233931.49758-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233931.49758-10-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-log-PTR_TO_MEM-memory-size-in-verifier-log/20231205-074451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231204233931.49758-10-andrii%40kernel.org
patch subject: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing logic for subprog call checks
config: alpha-randconfig-r122-20231205 (https://download.01.org/0day-ci/archive/20231205/202312051916.zf1FwihO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051916.zf1FwihO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051916.zf1FwihO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/verifier.c:5083:5: sparse: sparse: symbol 'check_ptr_off_reg' was not declared. Should it be static?
   kernel/bpf/verifier.c:7268:5: sparse: sparse: symbol 'check_mem_reg' was not declared. Should it be static?
   kernel/bpf/verifier.c:8254:5: sparse: sparse: symbol 'check_func_arg_reg_off' was not declared. Should it be static?
>> kernel/bpf/verifier.c:9291:5: sparse: sparse: symbol 'btf_check_subprog_call' was not declared. Should it be static?
   kernel/bpf/verifier.c:19733:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +/btf_check_subprog_call +9291 kernel/bpf/verifier.c

  9283	
  9284	/* Compare BTF of a function call with given bpf_reg_state.
  9285	 * Returns:
  9286	 * EFAULT - there is a verifier bug. Abort verification.
  9287	 * EINVAL - there is a type mismatch or BTF is not available.
  9288	 * 0 - BTF matches with what bpf_reg_state expects.
  9289	 * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  9290	 */
> 9291	int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
  9292				   struct bpf_reg_state *regs)
  9293	{
  9294		struct bpf_prog *prog = env->prog;
  9295		struct btf *btf = prog->aux->btf;
  9296		u32 btf_id;
  9297		int err;
  9298	
  9299		if (!prog->aux->func_info)
  9300			return -EINVAL;
  9301	
  9302		btf_id = prog->aux->func_info[subprog].type_id;
  9303		if (!btf_id)
  9304			return -EFAULT;
  9305	
  9306		if (prog->aux->func_info_aux[subprog].unreliable)
  9307			return -EINVAL;
  9308	
  9309		err = btf_check_func_arg_match(env, subprog, btf, btf_id, regs);
  9310		/* Compiler optimizations can remove arguments from static functions
  9311		 * or mismatched type can be passed into a global function.
  9312		 * In such cases mark the function as unreliable from BTF point of view.
  9313		 */
  9314		if (err)
  9315			prog->aux->func_info_aux[subprog].unreliable = true;
  9316		return err;
  9317	}
  9318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

