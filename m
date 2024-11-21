Return-Path: <bpf+bounces-45421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408209D55A2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05FAB223B6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973291DDC1F;
	Thu, 21 Nov 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3LCZNUL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC31DD9D3
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229227; cv=none; b=T53WfCrFqOVcuo/7Efge6x0l+LO28jwoiNhMyfQQH85vRZvFZq7CP70ShjMkqWTbj/dfLuFbGUXEZmVWzutJTB9dfhD0ziZMTVANPYiDfO68yW5APv9IgojE7CstYuY27LB6SgK+IotOE3gWJxAlqk45LpJ2HEV7BO1+5rVxJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229227; c=relaxed/simple;
	bh=ir4zajrbJeu2RA4mnREFMFtzcS79RAof4IlnZJJBNr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggZiYq0ZxSvLa+Rahwucf0Nql4za5Pj7EdUssVEM040nTvtlSQD/PLPXlYtPtg40ggX4U2n5/OMc4TyepdZd9WQuLmGE0yf3wSW1xiZ4gYXfop7E91W52nWWEvVC5a/NRLpG9oyPkAWa1TYWSfLFNP0bXctCCCiaps+44cGL7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3LCZNUL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732229226; x=1763765226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ir4zajrbJeu2RA4mnREFMFtzcS79RAof4IlnZJJBNr4=;
  b=A3LCZNULkbvT31F0PqF1v5UGxqly/Q3WJ/n5S7Po/9ltJwM2KH4uOxHO
   15t/rbKYAeqvMCxI0lOmGg3OmoIknfCaMQK5q38YaVle2/GbTDDTcgC9t
   j49EPx0Ir1/YKplL0doUkW5U+uQ1yIlee/tEsdMRFmT+oG7gi3VWO3S4k
   l34yXUXrgGakOoevzzUCRQ4OplLQMq4qz/buEVy9M47sM2RQqfekFCaKu
   0QzHKUHg1o6XIkLQezOcKrNFThq+vg9mgcT4Bf50he7b4tuYzlWqrZ2lj
   0P6yzmzBMiJOfTuy6nPmByTBuQSYkO/lkw0FA2g80NEK7UMwDbFD8NXyA
   Q==;
X-CSE-ConnectionGUID: 0/crffxQRhuBdy73hB0U3Q==
X-CSE-MsgGUID: 82W12dhCRUu7XAnZBctaiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36150204"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="36150204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 14:47:05 -0800
X-CSE-ConnectionGUID: 2f0CeNnpQIOk+0JbFpdU1w==
X-CSE-MsgGUID: NN+rqOkjQ6+XZQ2PxYF47A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95194871"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Nov 2024 14:47:02 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEFwy-0003Qx-1M;
	Thu, 21 Nov 2024 22:47:00 +0000
Date: Fri, 22 Nov 2024 06:46:38 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
Message-ID: <202411220652.mArtMRmI-lkp@intel.com>
References: <20241121005329.408873-6-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121005329.408873-6-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/for-next]
[also build test WARNING on bpf-next/master linus/master next-20241121]
[cannot apply to bpf/master v6.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Refactor-and-rename-resource-management/20241121-140722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git for-next
patch link:    https://lore.kernel.org/r/20241121005329.408873-6-memxor%40gmail.com
patch subject: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
config: arc-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220652.mArtMRmI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220652.mArtMRmI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220652.mArtMRmI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'process_irq_flag':
>> kernel/bpf/verifier.c:11964:32: warning: variable 'irq_restore' set but not used [-Wunused-but-set-variable]
   11964 |         bool irq_save = false, irq_restore = false;
         |                                ^~~~~~~~~~~


vim +/irq_restore +11964 kernel/bpf/verifier.c

 11959	
 11960	static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 11961				     struct bpf_kfunc_call_arg_meta *meta)
 11962	{
 11963		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 11964		bool irq_save = false, irq_restore = false;
 11965		int err;
 11966	
 11967		if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save]) {
 11968			irq_save = true;
 11969		} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore]) {
 11970			irq_restore = true;
 11971		} else {
 11972			verbose(env, "verifier internal error: unknown irq flags kfunc\n");
 11973			return -EFAULT;
 11974		}
 11975	
 11976		if (irq_save) {
 11977			if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 11978				verbose(env, "expected uninitialized irq flag as arg#%d\n", regno);
 11979				return -EINVAL;
 11980			}
 11981	
 11982			err = check_mem_access(env, env->insn_idx, regno, 0, BPF_DW, BPF_WRITE, -1, false, false);
 11983			if (err)
 11984				return err;
 11985	
 11986			err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx);
 11987			if (err)
 11988				return err;
 11989		} else {
 11990			err = is_irq_flag_reg_valid_init(env, reg);
 11991			if (err) {
 11992				verbose(env, "expected an initialized irq flag as arg#%d\n", regno);
 11993				return err;
 11994			}
 11995	
 11996			err = mark_irq_flag_read(env, reg);
 11997			if (err)
 11998				return err;
 11999	
 12000			err = unmark_stack_slot_irq_flag(env, reg);
 12001			if (err)
 12002				return err;
 12003		}
 12004		return 0;
 12005	}
 12006	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

