Return-Path: <bpf+bounces-65829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF8B2900D
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D683CAA43C9
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144772036E9;
	Sat, 16 Aug 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGr45UL3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B08301497
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368105; cv=none; b=HRt7mOZj3dUAIofUcQGAtcC7sED6Ao5DPM+AzoyNXeWfNbIzXuVkrsXo3G8GucZNklQwNFNtmBcjK+g8+WdTbVS6RCxiXVHJveLOGbP98Qje9yuet+5zJAYxxB5Ljj5LLIl2aph+9iezz7DXy5xINa3ADSt/3OxsN6DQnmBUJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368105; c=relaxed/simple;
	bh=rWI6IshLucmadkLI60Ojz9rvR1swCy3K5RS2qjR9g4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw0OVNQA0gRCFVibWzVT/lyfx0ZJ9ZoAdW3jfulNWqE37yBmUFm9TFPE8SvrdfDCC+i04CwBTWGoKu4NMrUooqarU9cawb5Cj4uLhHmsI3MDvGrvQZB1q3gJzzfxUEYCls3IC/oWsowOhda+HLx/1SXKIX8Sk2iRPPqJvdX3+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGr45UL3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755368104; x=1786904104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWI6IshLucmadkLI60Ojz9rvR1swCy3K5RS2qjR9g4w=;
  b=aGr45UL3AHmWB+ZTsCjr7PQVAqLoKVQnIUTFV37mIEW8+uHV2qU7TGtP
   AjLb5gauyZkD2g6Y7D9956JkYbKPuIvo4DvBwNh+W+1XnuvpR3Pjco4yV
   8DSeKtuzcJcF+K/yp/cjDH9bUDGIA8v9c1XD/ailqMguH6gvBtOOoWHji
   hmLkhwIQeuRyCKto2FeevtSMvuw0Y9AUcc6i0VqqibuhGYfIMhKQ8yr51
   Te2mE8GdkvKpFTgGaXBTis3P45KD1YSYdMaTLP3LcVaEqvVlnM1GpKA5Z
   KwzL/iB9kFfFImQEgc7gLt0s2CngGbnOHBnFkYhyuvT00NfaYUHL9AfMO
   w==;
X-CSE-ConnectionGUID: khUxkdq4SLyw59XJ3O4oMw==
X-CSE-MsgGUID: Ovv0uP4rR9qH6XsJ3RIjEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="61489699"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61489699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 11:15:04 -0700
X-CSE-ConnectionGUID: q6yTj+6cTpSsKBsmDGKmkw==
X-CSE-MsgGUID: dzSWC1ArS8a113n/8DzCfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166427772"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Aug 2025 11:15:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unLQf-000D5M-34;
	Sat, 16 Aug 2025 18:14:57 +0000
Date: Sun, 17 Aug 2025 02:14:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
Message-ID: <202508170152.F0lX7DFM-lkp@intel.com>
References: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>

Hi Mykyta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mykyta-Yatsenko/bpf-bpf-task-work-plumbing/20250816-032308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250815192156.272445-4-mykyta.yatsenko5%40gmail.com
patch subject: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
config: riscv-randconfig-r122-20250816 (https://download.01.org/0day-ci/archive/20250817/202508170152.F0lX7DFM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce: (https://download.01.org/0day-ci/archive/20250817/202508170152.F0lX7DFM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508170152.F0lX7DFM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c:2471:18: sparse: sparse: symbol 'bpf_task_release_dtor' was not declared. Should it be static?
   kernel/bpf/helpers.c:2501:18: sparse: sparse: symbol 'bpf_cgroup_release_dtor' was not declared. Should it be static?
   kernel/bpf/helpers.c:3367:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3367:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3367:17: sparse:     got char *
   kernel/bpf/helpers.c:3368:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3368:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3368:17: sparse:     got char *
   kernel/bpf/helpers.c:3407:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3407:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3407:17: sparse:     got char *
   kernel/bpf/helpers.c:3461:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3461:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3461:17: sparse:     got char *
   kernel/bpf/helpers.c:3493:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3493:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3493:17: sparse:     got char *
   kernel/bpf/helpers.c:3526:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3526:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3526:17: sparse:     got char *
   kernel/bpf/helpers.c:3576:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3576:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3576:17: sparse:     got char *
   kernel/bpf/helpers.c:3580:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3580:25: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3580:25: sparse:     got char *
   kernel/bpf/helpers.c:3620:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3620:17: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3620:17: sparse:     got char *
   kernel/bpf/helpers.c:3624:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3624:25: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3624:25: sparse:     got char *
   kernel/bpf/helpers.c:3666:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3666:25: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3666:25: sparse:     got char *
   kernel/bpf/helpers.c:3669:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char * @@
   kernel/bpf/helpers.c:3669:25: sparse:     expected void const [noderef] __user *from
   kernel/bpf/helpers.c:3669:25: sparse:     got char *
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/helpers.c:3856:27: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/bpf/helpers.c:2965:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2970:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +/__rcu +3856 kernel/bpf/helpers.c

  3838	
  3839	static struct bpf_task_work_context *bpf_task_work_context_acquire(struct bpf_task_work *tw,
  3840									   struct bpf_map *map)
  3841	{
  3842		struct bpf_task_work_context *ctx, *old_ctx;
  3843		enum bpf_task_work_state state;
  3844		struct bpf_task_work_context __force __rcu **ppc =
  3845			(struct bpf_task_work_context __force __rcu **)&tw->ctx;
  3846	
  3847		/* ctx pointer is RCU protected */
  3848		rcu_read_lock_trace();
  3849		ctx = rcu_dereference(*ppc);
  3850		if (!ctx) {
  3851			ctx = bpf_task_work_context_alloc();
  3852			if (!ctx) {
  3853				rcu_read_unlock_trace();
  3854				return ERR_PTR(-ENOMEM);
  3855			}
> 3856			old_ctx = unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIALIZER(ctx)));
  3857			/*
  3858			 * If ctx is set by another CPU, release allocated memory.
  3859			 * Do not fail, though, attempt stealing the work
  3860			 */
  3861			if (old_ctx) {
  3862				bpf_mem_free(&bpf_global_ma, ctx);
  3863				ctx = old_ctx;
  3864			}
  3865		}
  3866		state = cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING);
  3867		/*
  3868		 * We can unlock RCU, because task work scheduler (this codepath)
  3869		 * now owns the ctx or returning an error
  3870		 */
  3871		rcu_read_unlock_trace();
  3872		if (state != BPF_TW_STANDBY)
  3873			return ERR_PTR(-EBUSY);
  3874		return ctx;
  3875	}
  3876	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

