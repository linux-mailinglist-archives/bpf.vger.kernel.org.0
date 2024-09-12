Return-Path: <bpf+bounces-39694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A09761EE
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC802820E7
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1818950A;
	Thu, 12 Sep 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV9hfGuG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD110FF
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124141; cv=none; b=PPz3UQvozFDDJQCbRLNLRougsOKNtRdYNoeffR7nb1dUT0KAwc4gbuY/tYoyGaN8SuRSe8PN4rXxX6L+drv2/bMftmq12x2tS1eaq5o9AycujfM0LAofz2FMSxFNjD4HnFghhiH79fiFTwUJqPQ5xZxuYNOnM9KtuU9X2pcZmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124141; c=relaxed/simple;
	bh=Z5tXEb2HUDhhVYfa0FQGNhrs6+JV7UhfuKcBKvTLwas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcaO9OmxXctdoDTIqcRyYoCY5j80+VNQUhpzdjawXAYyFtnizQTUALOUrM5MJNVs9CZ5p7q1+t30FbfiI47Zz3JmyaO6Sk9biO1Ve6H96BtjQwCKEftYHMKieTb5Xz8qLiysjQJUiXWyNqjh4ZY5By7POw8xeqyWDF1GK2mu9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV9hfGuG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726124139; x=1757660139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5tXEb2HUDhhVYfa0FQGNhrs6+JV7UhfuKcBKvTLwas=;
  b=YV9hfGuG9X3KkDQnCdqoO3zSorh+M8aXQqZ4AVttZwnh+aO9UdkFqdYe
   Q1WYCrzuSi472eqnYepCVKnmsjPyo3jtYTgHIlLA/h2/VsD3HWsGbiHIj
   4/0oR6unp1mV3M2HVp8L0IyuktNRCdRykox7Z47HHfwBxnPmWvKEXB7Sk
   QTLaikxHBz0rvQtfN71jTABYPzzubwn5SNH68aqjRGu/pSKhlvYV8TJTX
   a/X8lbDkmKQKXlGEWsvfKJmpJw+9Gt38BYj3Px6h3ARrFv5tKoImzzgCQ
   WliQcI9UwGi0ygc+/vAgovlPrryQSbFKhzOoGTmJe5LS2aM34ydObUSXY
   Q==;
X-CSE-ConnectionGUID: TnhNybGUTEyLw/YcXrE4ng==
X-CSE-MsgGUID: qqb58Ds/TxOuM2vrG+fu1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24830838"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24830838"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 23:55:38 -0700
X-CSE-ConnectionGUID: QDCr1ZviR/KE4mnr347PvA==
X-CSE-MsgGUID: z9Dv7WCmSXiXGM9csZL4lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="71983207"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2024 23:55:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sodjp-0004cY-1I;
	Thu, 12 Sep 2024 06:55:33 +0000
Date: Thu, 12 Sep 2024 14:54:47 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Zac Ecob <zacecob@protonmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Message-ID: <202409121439.L01ZquSs-lkp@intel.com>
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911044017.2261738-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/selftests-bpf-Add-a-couple-of-tests-for-potential-sdiv-overflow/20240911-124236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240911044017.2261738-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
config: x86_64-randconfig-121-20240912 (https://download.01.org/0day-ci/archive/20240912/202409121439.L01ZquSs-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409121439.L01ZquSs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409121439.L01ZquSs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/verifier.c:21184:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>> kernel/bpf/verifier.c:20538:33: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +20538 kernel/bpf/verifier.c

 20445	
 20446	/* Do various post-verification rewrites in a single program pass.
 20447	 * These rewrites simplify JIT and interpreter implementations.
 20448	 */
 20449	static int do_misc_fixups(struct bpf_verifier_env *env)
 20450	{
 20451		struct bpf_prog *prog = env->prog;
 20452		enum bpf_attach_type eatype = prog->expected_attach_type;
 20453		enum bpf_prog_type prog_type = resolve_prog_type(prog);
 20454		struct bpf_insn *insn = prog->insnsi;
 20455		const struct bpf_func_proto *fn;
 20456		const int insn_cnt = prog->len;
 20457		const struct bpf_map_ops *ops;
 20458		struct bpf_insn_aux_data *aux;
 20459		struct bpf_insn *insn_buf = env->insn_buf;
 20460		struct bpf_prog *new_prog;
 20461		struct bpf_map *map_ptr;
 20462		int i, ret, cnt, delta = 0, cur_subprog = 0;
 20463		struct bpf_subprog_info *subprogs = env->subprog_info;
 20464		u16 stack_depth = subprogs[cur_subprog].stack_depth;
 20465		u16 stack_depth_extra = 0;
 20466	
 20467		if (env->seen_exception && !env->exception_callback_subprog) {
 20468			struct bpf_insn patch[] = {
 20469				env->prog->insnsi[insn_cnt - 1],
 20470				BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 20471				BPF_EXIT_INSN(),
 20472			};
 20473	
 20474			ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
 20475			if (ret < 0)
 20476				return ret;
 20477			prog = env->prog;
 20478			insn = prog->insnsi;
 20479	
 20480			env->exception_callback_subprog = env->subprog_cnt - 1;
 20481			/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
 20482			mark_subprog_exc_cb(env, env->exception_callback_subprog);
 20483		}
 20484	
 20485		for (i = 0; i < insn_cnt;) {
 20486			if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
 20487				if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
 20488				    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
 20489					/* convert to 32-bit mov that clears upper 32-bit */
 20490					insn->code = BPF_ALU | BPF_MOV | BPF_X;
 20491					/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
 20492					insn->off = 0;
 20493					insn->imm = 0;
 20494				} /* cast from as(0) to as(1) should be handled by JIT */
 20495				goto next_insn;
 20496			}
 20497	
 20498			if (env->insn_aux_data[i + delta].needs_zext)
 20499				/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 20500				insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 20501	
 20502			/* Make divide-by-zero exceptions impossible. */
 20503			if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 20504			    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 20505			    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 20506			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 20507				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 20508				bool isdiv = BPF_OP(insn->code) == BPF_DIV;
 20509				bool is_sdiv64 = is64 && isdiv && insn->off == 1;
 20510				struct bpf_insn *patchlet;
 20511				struct bpf_insn chk_and_div[] = {
 20512					/* [R,W]x div 0 -> 0 */
 20513					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 20514						     BPF_JNE | BPF_K, insn->src_reg,
 20515						     0, 2, 0),
 20516					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
 20517					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 20518					*insn,
 20519				};
 20520				struct bpf_insn chk_and_mod[] = {
 20521					/* [R,W]x mod 0 -> [R,W]x */
 20522					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 20523						     BPF_JEQ | BPF_K, insn->src_reg,
 20524						     0, 1 + (is64 ? 0 : 1), 0),
 20525					*insn,
 20526					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 20527					BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 20528				};
 20529				struct bpf_insn chk_and_sdiv64[] = {
 20530					/* Rx sdiv 0 -> 0 */
 20531					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
 20532						     0, 2, 0),
 20533					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
 20534					BPF_JMP_IMM(BPF_JA, 0, 0, 8),
 20535					/* LLONG_MIN sdiv -1 -> LLONG_MIN */
 20536					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
 20537						     0, 6, -1),
 20538					BPF_LD_IMM64(insn->src_reg, LLONG_MIN),
 20539					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
 20540						     insn->src_reg, 2, 0),
 20541					BPF_MOV64_IMM(insn->src_reg, -1),
 20542					BPF_JMP_IMM(BPF_JA, 0, 0, 2),
 20543					BPF_MOV64_IMM(insn->src_reg, -1),
 20544					*insn,
 20545				};
 20546	
 20547				if (is_sdiv64) {
 20548					patchlet = chk_and_sdiv64;
 20549					cnt = ARRAY_SIZE(chk_and_sdiv64);
 20550				} else {
 20551					patchlet = isdiv ? chk_and_div : chk_and_mod;
 20552					cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
 20553						      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
 20554				}
 20555	
 20556				new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 20557				if (!new_prog)
 20558					return -ENOMEM;
 20559	
 20560				delta    += cnt - 1;
 20561				env->prog = prog = new_prog;
 20562				insn      = new_prog->insnsi + i + delta;
 20563				goto next_insn;
 20564			}
 20565	
 20566			/* Make it impossible to de-reference a userspace address */
 20567			if (BPF_CLASS(insn->code) == BPF_LDX &&
 20568			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 20569			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
 20570				struct bpf_insn *patch = &insn_buf[0];
 20571				u64 uaddress_limit = bpf_arch_uaddress_limit();
 20572	
 20573				if (!uaddress_limit)
 20574					goto next_insn;
 20575	
 20576				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
 20577				if (insn->off)
 20578					*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
 20579				*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
 20580				*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
 20581				*patch++ = *insn;
 20582				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 20583				*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
 20584	
 20585				cnt = patch - insn_buf;
 20586				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20587				if (!new_prog)
 20588					return -ENOMEM;
 20589	
 20590				delta    += cnt - 1;
 20591				env->prog = prog = new_prog;
 20592				insn      = new_prog->insnsi + i + delta;
 20593				goto next_insn;
 20594			}
 20595	
 20596			/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 20597			if (BPF_CLASS(insn->code) == BPF_LD &&
 20598			    (BPF_MODE(insn->code) == BPF_ABS ||
 20599			     BPF_MODE(insn->code) == BPF_IND)) {
 20600				cnt = env->ops->gen_ld_abs(insn, insn_buf);
 20601				if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
 20602					verbose(env, "bpf verifier is misconfigured\n");
 20603					return -EINVAL;
 20604				}
 20605	
 20606				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20607				if (!new_prog)
 20608					return -ENOMEM;
 20609	
 20610				delta    += cnt - 1;
 20611				env->prog = prog = new_prog;
 20612				insn      = new_prog->insnsi + i + delta;
 20613				goto next_insn;
 20614			}
 20615	
 20616			/* Rewrite pointer arithmetic to mitigate speculation attacks. */
 20617			if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
 20618			    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 20619				const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
 20620				const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
 20621				struct bpf_insn *patch = &insn_buf[0];
 20622				bool issrc, isneg, isimm;
 20623				u32 off_reg;
 20624	
 20625				aux = &env->insn_aux_data[i + delta];
 20626				if (!aux->alu_state ||
 20627				    aux->alu_state == BPF_ALU_NON_POINTER)
 20628					goto next_insn;
 20629	
 20630				isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 20631				issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
 20632					BPF_ALU_SANITIZE_SRC;
 20633				isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
 20634	
 20635				off_reg = issrc ? insn->src_reg : insn->dst_reg;
 20636				if (isimm) {
 20637					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 20638				} else {
 20639					if (isneg)
 20640						*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 20641					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 20642					*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
 20643					*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
 20644					*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
 20645					*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
 20646					*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
 20647				}
 20648				if (!issrc)
 20649					*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
 20650				insn->src_reg = BPF_REG_AX;
 20651				if (isneg)
 20652					insn->code = insn->code == code_add ?
 20653						     code_sub : code_add;
 20654				*patch++ = *insn;
 20655				if (issrc && isneg && !isimm)
 20656					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 20657				cnt = patch - insn_buf;
 20658	
 20659				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20660				if (!new_prog)
 20661					return -ENOMEM;
 20662	
 20663				delta    += cnt - 1;
 20664				env->prog = prog = new_prog;
 20665				insn      = new_prog->insnsi + i + delta;
 20666				goto next_insn;
 20667			}
 20668	
 20669			if (is_may_goto_insn(insn)) {
 20670				int stack_off = -stack_depth - 8;
 20671	
 20672				stack_depth_extra = 8;
 20673				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
 20674				if (insn->off >= 0)
 20675					insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
 20676				else
 20677					insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
 20678				insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
 20679				insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 20680				cnt = 4;
 20681	
 20682				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20683				if (!new_prog)
 20684					return -ENOMEM;
 20685	
 20686				delta += cnt - 1;
 20687				env->prog = prog = new_prog;
 20688				insn = new_prog->insnsi + i + delta;
 20689				goto next_insn;
 20690			}
 20691	
 20692			if (insn->code != (BPF_JMP | BPF_CALL))
 20693				goto next_insn;
 20694			if (insn->src_reg == BPF_PSEUDO_CALL)
 20695				goto next_insn;
 20696			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 20697				ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 20698				if (ret)
 20699					return ret;
 20700				if (cnt == 0)
 20701					goto next_insn;
 20702	
 20703				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20704				if (!new_prog)
 20705					return -ENOMEM;
 20706	
 20707				delta	 += cnt - 1;
 20708				env->prog = prog = new_prog;
 20709				insn	  = new_prog->insnsi + i + delta;
 20710				goto next_insn;
 20711			}
 20712	
 20713			/* Skip inlining the helper call if the JIT does it. */
 20714			if (bpf_jit_inlines_helper_call(insn->imm))
 20715				goto next_insn;
 20716	
 20717			if (insn->imm == BPF_FUNC_get_route_realm)
 20718				prog->dst_needed = 1;
 20719			if (insn->imm == BPF_FUNC_get_prandom_u32)
 20720				bpf_user_rnd_init_once();
 20721			if (insn->imm == BPF_FUNC_override_return)
 20722				prog->kprobe_override = 1;
 20723			if (insn->imm == BPF_FUNC_tail_call) {
 20724				/* If we tail call into other programs, we
 20725				 * cannot make any assumptions since they can
 20726				 * be replaced dynamically during runtime in
 20727				 * the program array.
 20728				 */
 20729				prog->cb_access = 1;
 20730				if (!allow_tail_call_in_subprogs(env))
 20731					prog->aux->stack_depth = MAX_BPF_STACK;
 20732				prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 20733	
 20734				/* mark bpf_tail_call as different opcode to avoid
 20735				 * conditional branch in the interpreter for every normal
 20736				 * call and to prevent accidental JITing by JIT compiler
 20737				 * that doesn't support bpf_tail_call yet
 20738				 */
 20739				insn->imm = 0;
 20740				insn->code = BPF_JMP | BPF_TAIL_CALL;
 20741	
 20742				aux = &env->insn_aux_data[i + delta];
 20743				if (env->bpf_capable && !prog->blinding_requested &&
 20744				    prog->jit_requested &&
 20745				    !bpf_map_key_poisoned(aux) &&
 20746				    !bpf_map_ptr_poisoned(aux) &&
 20747				    !bpf_map_ptr_unpriv(aux)) {
 20748					struct bpf_jit_poke_descriptor desc = {
 20749						.reason = BPF_POKE_REASON_TAIL_CALL,
 20750						.tail_call.map = aux->map_ptr_state.map_ptr,
 20751						.tail_call.key = bpf_map_key_immediate(aux),
 20752						.insn_idx = i + delta,
 20753					};
 20754	
 20755					ret = bpf_jit_add_poke_descriptor(prog, &desc);
 20756					if (ret < 0) {
 20757						verbose(env, "adding tail call poke descriptor failed\n");
 20758						return ret;
 20759					}
 20760	
 20761					insn->imm = ret + 1;
 20762					goto next_insn;
 20763				}
 20764	
 20765				if (!bpf_map_ptr_unpriv(aux))
 20766					goto next_insn;
 20767	
 20768				/* instead of changing every JIT dealing with tail_call
 20769				 * emit two extra insns:
 20770				 * if (index >= max_entries) goto out;
 20771				 * index &= array->index_mask;
 20772				 * to avoid out-of-bounds cpu speculation
 20773				 */
 20774				if (bpf_map_ptr_poisoned(aux)) {
 20775					verbose(env, "tail_call abusing map_ptr\n");
 20776					return -EINVAL;
 20777				}
 20778	
 20779				map_ptr = aux->map_ptr_state.map_ptr;
 20780				insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 20781							  map_ptr->max_entries, 2);
 20782				insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
 20783							    container_of(map_ptr,
 20784									 struct bpf_array,
 20785									 map)->index_mask);
 20786				insn_buf[2] = *insn;
 20787				cnt = 3;
 20788				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20789				if (!new_prog)
 20790					return -ENOMEM;
 20791	
 20792				delta    += cnt - 1;
 20793				env->prog = prog = new_prog;
 20794				insn      = new_prog->insnsi + i + delta;
 20795				goto next_insn;
 20796			}
 20797	
 20798			if (insn->imm == BPF_FUNC_timer_set_callback) {
 20799				/* The verifier will process callback_fn as many times as necessary
 20800				 * with different maps and the register states prepared by
 20801				 * set_timer_callback_state will be accurate.
 20802				 *
 20803				 * The following use case is valid:
 20804				 *   map1 is shared by prog1, prog2, prog3.
 20805				 *   prog1 calls bpf_timer_init for some map1 elements
 20806				 *   prog2 calls bpf_timer_set_callback for some map1 elements.
 20807				 *     Those that were not bpf_timer_init-ed will return -EINVAL.
 20808				 *   prog3 calls bpf_timer_start for some map1 elements.
 20809				 *     Those that were not both bpf_timer_init-ed and
 20810				 *     bpf_timer_set_callback-ed will return -EINVAL.
 20811				 */
 20812				struct bpf_insn ld_addrs[2] = {
 20813					BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
 20814				};
 20815	
 20816				insn_buf[0] = ld_addrs[0];
 20817				insn_buf[1] = ld_addrs[1];
 20818				insn_buf[2] = *insn;
 20819				cnt = 3;
 20820	
 20821				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20822				if (!new_prog)
 20823					return -ENOMEM;
 20824	
 20825				delta    += cnt - 1;
 20826				env->prog = prog = new_prog;
 20827				insn      = new_prog->insnsi + i + delta;
 20828				goto patch_call_imm;
 20829			}
 20830	
 20831			if (is_storage_get_function(insn->imm)) {
 20832				if (!in_sleepable(env) ||
 20833				    env->insn_aux_data[i + delta].storage_get_func_atomic)
 20834					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 20835				else
 20836					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
 20837				insn_buf[1] = *insn;
 20838				cnt = 2;
 20839	
 20840				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20841				if (!new_prog)
 20842					return -ENOMEM;
 20843	
 20844				delta += cnt - 1;
 20845				env->prog = prog = new_prog;
 20846				insn = new_prog->insnsi + i + delta;
 20847				goto patch_call_imm;
 20848			}
 20849	
 20850			/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
 20851			if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
 20852				/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
 20853				 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
 20854				 */
 20855				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
 20856				insn_buf[1] = *insn;
 20857				cnt = 2;
 20858	
 20859				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20860				if (!new_prog)
 20861					return -ENOMEM;
 20862	
 20863				delta += cnt - 1;
 20864				env->prog = prog = new_prog;
 20865				insn = new_prog->insnsi + i + delta;
 20866				goto patch_call_imm;
 20867			}
 20868	
 20869			/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 20870			 * and other inlining handlers are currently limited to 64 bit
 20871			 * only.
 20872			 */
 20873			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 20874			    (insn->imm == BPF_FUNC_map_lookup_elem ||
 20875			     insn->imm == BPF_FUNC_map_update_elem ||
 20876			     insn->imm == BPF_FUNC_map_delete_elem ||
 20877			     insn->imm == BPF_FUNC_map_push_elem   ||
 20878			     insn->imm == BPF_FUNC_map_pop_elem    ||
 20879			     insn->imm == BPF_FUNC_map_peek_elem   ||
 20880			     insn->imm == BPF_FUNC_redirect_map    ||
 20881			     insn->imm == BPF_FUNC_for_each_map_elem ||
 20882			     insn->imm == BPF_FUNC_map_lookup_percpu_elem)) {
 20883				aux = &env->insn_aux_data[i + delta];
 20884				if (bpf_map_ptr_poisoned(aux))
 20885					goto patch_call_imm;
 20886	
 20887				map_ptr = aux->map_ptr_state.map_ptr;
 20888				ops = map_ptr->ops;
 20889				if (insn->imm == BPF_FUNC_map_lookup_elem &&
 20890				    ops->map_gen_lookup) {
 20891					cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 20892					if (cnt == -EOPNOTSUPP)
 20893						goto patch_map_ops_generic;
 20894					if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
 20895						verbose(env, "bpf verifier is misconfigured\n");
 20896						return -EINVAL;
 20897					}
 20898	
 20899					new_prog = bpf_patch_insn_data(env, i + delta,
 20900								       insn_buf, cnt);
 20901					if (!new_prog)
 20902						return -ENOMEM;
 20903	
 20904					delta    += cnt - 1;
 20905					env->prog = prog = new_prog;
 20906					insn      = new_prog->insnsi + i + delta;
 20907					goto next_insn;
 20908				}
 20909	
 20910				BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
 20911					     (void *(*)(struct bpf_map *map, void *key))NULL));
 20912				BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
 20913					     (long (*)(struct bpf_map *map, void *key))NULL));
 20914				BUILD_BUG_ON(!__same_type(ops->map_update_elem,
 20915					     (long (*)(struct bpf_map *map, void *key, void *value,
 20916						      u64 flags))NULL));
 20917				BUILD_BUG_ON(!__same_type(ops->map_push_elem,
 20918					     (long (*)(struct bpf_map *map, void *value,
 20919						      u64 flags))NULL));
 20920				BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
 20921					     (long (*)(struct bpf_map *map, void *value))NULL));
 20922				BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
 20923					     (long (*)(struct bpf_map *map, void *value))NULL));
 20924				BUILD_BUG_ON(!__same_type(ops->map_redirect,
 20925					     (long (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
 20926				BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
 20927					     (long (*)(struct bpf_map *map,
 20928						      bpf_callback_t callback_fn,
 20929						      void *callback_ctx,
 20930						      u64 flags))NULL));
 20931				BUILD_BUG_ON(!__same_type(ops->map_lookup_percpu_elem,
 20932					     (void *(*)(struct bpf_map *map, void *key, u32 cpu))NULL));
 20933	
 20934	patch_map_ops_generic:
 20935				switch (insn->imm) {
 20936				case BPF_FUNC_map_lookup_elem:
 20937					insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
 20938					goto next_insn;
 20939				case BPF_FUNC_map_update_elem:
 20940					insn->imm = BPF_CALL_IMM(ops->map_update_elem);
 20941					goto next_insn;
 20942				case BPF_FUNC_map_delete_elem:
 20943					insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
 20944					goto next_insn;
 20945				case BPF_FUNC_map_push_elem:
 20946					insn->imm = BPF_CALL_IMM(ops->map_push_elem);
 20947					goto next_insn;
 20948				case BPF_FUNC_map_pop_elem:
 20949					insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
 20950					goto next_insn;
 20951				case BPF_FUNC_map_peek_elem:
 20952					insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
 20953					goto next_insn;
 20954				case BPF_FUNC_redirect_map:
 20955					insn->imm = BPF_CALL_IMM(ops->map_redirect);
 20956					goto next_insn;
 20957				case BPF_FUNC_for_each_map_elem:
 20958					insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
 20959					goto next_insn;
 20960				case BPF_FUNC_map_lookup_percpu_elem:
 20961					insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
 20962					goto next_insn;
 20963				}
 20964	
 20965				goto patch_call_imm;
 20966			}
 20967	
 20968			/* Implement bpf_jiffies64 inline. */
 20969			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 20970			    insn->imm == BPF_FUNC_jiffies64) {
 20971				struct bpf_insn ld_jiffies_addr[2] = {
 20972					BPF_LD_IMM64(BPF_REG_0,
 20973						     (unsigned long)&jiffies),
 20974				};
 20975	
 20976				insn_buf[0] = ld_jiffies_addr[0];
 20977				insn_buf[1] = ld_jiffies_addr[1];
 20978				insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
 20979							  BPF_REG_0, 0);
 20980				cnt = 3;
 20981	
 20982				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
 20983							       cnt);
 20984				if (!new_prog)
 20985					return -ENOMEM;
 20986	
 20987				delta    += cnt - 1;
 20988				env->prog = prog = new_prog;
 20989				insn      = new_prog->insnsi + i + delta;
 20990				goto next_insn;
 20991			}
 20992	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

