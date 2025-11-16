Return-Path: <bpf+bounces-74669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB4C60E81
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 02:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9345E3564D8
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA461AF0BB;
	Sun, 16 Nov 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyHQ+hFp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B477B3E1
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763255777; cv=none; b=t5QLZHJVnraS//L9ieHX+8uwj8rZGazRE+2ICxhr1MNprqo4/0GUm2SVKNcCv1BYNxPyI9KmCqCxYcqPvyAhCDKB6vsdM+Uyg3ZnjqShwqQeEjjkV61bgw8wPAXzhcQcptYA8pcmEvIp9HOknXxP+4d3tZL/FUBrInW7cvo2FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763255777; c=relaxed/simple;
	bh=PkqQtbP20f96o7zB8Sd2IMmI3AkgpOG/z7IfaJfRKDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8eVLCPkXEfafSvp+tZw18iU1ka+kJukbwR4siYPR+Tppvs976xzWZABEHsTzVpUopOx/m24hHsssmw00I+IYmyr03HCeMIjkRRQGDTWuqlorYSDavD9gVt1nvc707LpESnw3bP5H2lSbqbOlOqkIlB507HhfWRC/6Yj3NJ9N6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyHQ+hFp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763255776; x=1794791776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkqQtbP20f96o7zB8Sd2IMmI3AkgpOG/z7IfaJfRKDo=;
  b=lyHQ+hFpbuTs0iieH8LYhuMlLKs54zOdcLjwnc2XkFclCdaqDyqr/rBq
   TbsqrbazZ1B/MN8O7rkHy2mGBFJb8aSDnz6Ai/1cshrFwN/hAFU+qAjdR
   3tvRv0v508RVasfkgKGotIXnfXX4uu22DA2/+023ZLfKU6jW7L4mKb1bo
   V7E3ALhvM0UQsFRgwsDj2352I750zPe98i/wP/C46J1qlkQNWF5XYR1Wg
   BRLJr6BkTjeg9MNEv9G6FXKx/i53coOyNEmdzLbzN8PvwC3AsUAm+Jb08
   xsw32OVpcZjdLd5d6w4XI11qdqpMLBEQMstAjrQXQEEJIPNpmClQcxKM4
   g==;
X-CSE-ConnectionGUID: h8eZQMdmRTSdbfK67brBOQ==
X-CSE-MsgGUID: FadHUToXQyuLoWPZhW+Gng==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="65185025"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="65185025"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 17:16:15 -0800
X-CSE-ConnectionGUID: HXIirKQrQ8mEcSyWVNUyIg==
X-CSE-MsgGUID: EQrKehA+SdCqMM1uEPvkfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="189430241"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Nov 2025 17:16:12 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKRNC-0008OX-0b;
	Sun, 16 Nov 2025 01:16:10 +0000
Date: Sun, 16 Nov 2025 09:15:59 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any
 context safe
Message-ID: <202511160836.5Ca6PimB-lkp@intel.com>
References: <20251114111700.43292-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114111700.43292-4-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arena-populate-vm_area-without-allocating-memory/20251114-192509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251114111700.43292-4-puranjay%40kernel.org
patch subject: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any context safe
config: sh-randconfig-r071-20251115 (https://download.01.org/0day-ci/archive/20251116/202511160836.5Ca6PimB-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511160836.5Ca6PimB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511160836.5Ca6PimB-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: kernel/bpf/verifier.o: in function `fixup_kfunc_call':
>> kernel/bpf/verifier.c:22428:(.text+0x7748): undefined reference to `bpf_arena_free_pages_non_sleepable'
   sh4-linux-ld: drivers/net/phy/air_en8811h.o: in function `en8811h_resume':
   drivers/net/phy/air_en8811h.c:1178:(.text+0x544): undefined reference to `clk_restore_context'
   sh4-linux-ld: drivers/net/phy/air_en8811h.o: in function `en8811h_suspend':
   drivers/net/phy/air_en8811h.c:1185:(.text+0x56c): undefined reference to `clk_save_context'
   sh4-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_probe':
   drivers/media/i2c/tc358746.c:1585:(.text+0x1408): undefined reference to `devm_clk_hw_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
   Selected by [y]:
   - GPIO_TB10X [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC_PLAT_TB10X || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for GPIO_SYSCON
   Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF [=n]
   Selected by [y]:
   - GPIO_SAMA5D2_PIOBU [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF_GPIO [=y] && (ARCH_AT91 || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +22428 kernel/bpf/verifier.c

d2dcc67df910dd Dave Marchevsky         2023-04-15  22392  
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22393  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22394  			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22395  {
d869d56ca84841 Mykyta Yatsenko         2025-10-26  22396  	struct bpf_kfunc_desc *desc;
d869d56ca84841 Mykyta Yatsenko         2025-10-26  22397  	int err;
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22398  
a5d8272752416e Kumar Kartikeya Dwivedi 2021-10-02  22399  	if (!insn->imm) {
a5d8272752416e Kumar Kartikeya Dwivedi 2021-10-02  22400  		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
a5d8272752416e Kumar Kartikeya Dwivedi 2021-10-02  22401  		return -EINVAL;
a5d8272752416e Kumar Kartikeya Dwivedi 2021-10-02  22402  	}
a5d8272752416e Kumar Kartikeya Dwivedi 2021-10-02  22403  
3d76a4d3d4e591 Stanislav Fomichev      2023-01-19  22404  	*cnt = 0;
3d76a4d3d4e591 Stanislav Fomichev      2023-01-19  22405  
1cf3bfc60f9836 Ilya Leoshkevich        2023-04-13  22406  	/* insn->imm has the btf func_id. Replace it with an offset relative to
1cf3bfc60f9836 Ilya Leoshkevich        2023-04-13  22407  	 * __bpf_call_base, unless the JIT needs to call functions that are
1cf3bfc60f9836 Ilya Leoshkevich        2023-04-13  22408  	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22409  	 */
2357672c54c3f7 Kumar Kartikeya Dwivedi 2021-10-02  22410  	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22411  	if (!desc) {
0df1a55afa832f Paul Chaignon           2025-07-01  22412  		verifier_bug(env, "kernel function descriptor not found for func_id %u",
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22413  			     insn->imm);
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22414  		return -EFAULT;
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22415  	}
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22416  
2c52e8943a437a Mykyta Yatsenko         2025-10-26  22417  	err = specialize_kfunc(env, desc, insn_idx);
d869d56ca84841 Mykyta Yatsenko         2025-10-26  22418  	if (err)
d869d56ca84841 Mykyta Yatsenko         2025-10-26  22419  		return err;
d869d56ca84841 Mykyta Yatsenko         2025-10-26  22420  
1cf3bfc60f9836 Ilya Leoshkevich        2023-04-13  22421  	if (!bpf_jit_supports_far_kfunc_call())
1cf3bfc60f9836 Ilya Leoshkevich        2023-04-13  22422  		insn->imm = BPF_CALL_IMM(desc->addr);
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22423  	if (insn->off)
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22424  		return 0;
36d8bdf75a9319 Yonghong Song           2023-08-27  22425  	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
36d8bdf75a9319 Yonghong Song           2023-08-27  22426  	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22427  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18 @22428  		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22429  		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22430  
36d8bdf75a9319 Yonghong Song           2023-08-27  22431  		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && kptr_struct_meta) {
0df1a55afa832f Paul Chaignon           2025-07-01  22432  			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
36d8bdf75a9319 Yonghong Song           2023-08-27  22433  				     insn_idx);
36d8bdf75a9319 Yonghong Song           2023-08-27  22434  			return -EFAULT;
36d8bdf75a9319 Yonghong Song           2023-08-27  22435  		}
36d8bdf75a9319 Yonghong Song           2023-08-27  22436  
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22437  		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22438  		insn_buf[1] = addr[0];
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22439  		insn_buf[2] = addr[1];
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22440  		insn_buf[3] = *insn;
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22441  		*cnt = 4;
7c50b1cb76aca4 Dave Marchevsky         2023-04-15  22442  	} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
36d8bdf75a9319 Yonghong Song           2023-08-27  22443  		   desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] ||
7c50b1cb76aca4 Dave Marchevsky         2023-04-15  22444  		   desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22445  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22446  		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22447  
36d8bdf75a9319 Yonghong Song           2023-08-27  22448  		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] && kptr_struct_meta) {
0df1a55afa832f Paul Chaignon           2025-07-01  22449  			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
36d8bdf75a9319 Yonghong Song           2023-08-27  22450  				     insn_idx);
36d8bdf75a9319 Yonghong Song           2023-08-27  22451  			return -EFAULT;
36d8bdf75a9319 Yonghong Song           2023-08-27  22452  		}
36d8bdf75a9319 Yonghong Song           2023-08-27  22453  
f0d991a070750a Dave Marchevsky         2023-08-21  22454  		if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
f0d991a070750a Dave Marchevsky         2023-08-21  22455  		    !kptr_struct_meta) {
0df1a55afa832f Paul Chaignon           2025-07-01  22456  			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
f0d991a070750a Dave Marchevsky         2023-08-21  22457  				     insn_idx);
f0d991a070750a Dave Marchevsky         2023-08-21  22458  			return -EFAULT;
f0d991a070750a Dave Marchevsky         2023-08-21  22459  		}
f0d991a070750a Dave Marchevsky         2023-08-21  22460  
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22461  		insn_buf[0] = addr[0];
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22462  		insn_buf[1] = addr[1];
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22463  		insn_buf[2] = *insn;
ac9f06050a3580 Kumar Kartikeya Dwivedi 2022-11-18  22464  		*cnt = 3;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22465  	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
d2dcc67df910dd Dave Marchevsky         2023-04-15  22466  		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
d2dcc67df910dd Dave Marchevsky         2023-04-15  22467  		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
f0d991a070750a Dave Marchevsky         2023-08-21  22468  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22469  		int struct_meta_reg = BPF_REG_3;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22470  		int node_offset_reg = BPF_REG_4;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22471  
d2dcc67df910dd Dave Marchevsky         2023-04-15  22472  		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
d2dcc67df910dd Dave Marchevsky         2023-04-15  22473  		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
d2dcc67df910dd Dave Marchevsky         2023-04-15  22474  			struct_meta_reg = BPF_REG_4;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22475  			node_offset_reg = BPF_REG_5;
d2dcc67df910dd Dave Marchevsky         2023-04-15  22476  		}
d2dcc67df910dd Dave Marchevsky         2023-04-15  22477  
f0d991a070750a Dave Marchevsky         2023-08-21  22478  		if (!kptr_struct_meta) {
0df1a55afa832f Paul Chaignon           2025-07-01  22479  			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
f0d991a070750a Dave Marchevsky         2023-08-21  22480  				     insn_idx);
f0d991a070750a Dave Marchevsky         2023-08-21  22481  			return -EFAULT;
f0d991a070750a Dave Marchevsky         2023-08-21  22482  		}
f0d991a070750a Dave Marchevsky         2023-08-21  22483  
d2dcc67df910dd Dave Marchevsky         2023-04-15  22484  		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
d2dcc67df910dd Dave Marchevsky         2023-04-15  22485  						node_offset_reg, insn, insn_buf, cnt);
a35b9af4ec2c7f Yonghong Song           2022-11-20  22486  	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
a35b9af4ec2c7f Yonghong Song           2022-11-20  22487  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
fd264ca020948a Yonghong Song           2022-11-20  22488  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
fd264ca020948a Yonghong Song           2022-11-20  22489  		*cnt = 1;
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22490  	}
81f1d7a583fa1f Benjamin Tissoires      2024-04-20  22491  
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22492  	if (env->insn_aux_data[insn_idx].arg_prog) {
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22493  		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22494  		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22495  		int idx = *cnt;
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22496  
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22497  		insn_buf[idx++] = ld_addrs[0];
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22498  		insn_buf[idx++] = ld_addrs[1];
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22499  		insn_buf[idx++] = *insn;
bc049387b41f41 Kumar Kartikeya Dwivedi 2025-05-13  22500  		*cnt = idx;
958cf2e273f092 Kumar Kartikeya Dwivedi 2022-11-18  22501  	}
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22502  	return 0;
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22503  }
e6ac2450d6dee3 Martin KaFai Lau        2021-03-24  22504  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

