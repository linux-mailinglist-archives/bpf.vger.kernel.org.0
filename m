Return-Path: <bpf+bounces-39753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEF976EF6
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B641C23C5A
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12C81AC884;
	Thu, 12 Sep 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IEbXUT/0"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FD1AB6CA
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159400; cv=none; b=jwb82jjVVWI+HgZ0VjcEVF3JDTormfVKGTEJy9KEWL8dWdzvblAAz8GA/duzD12Y6ipAGzA2YxmC1hW8MgWr4j619AavUBusx8gLwm1rDL4/tUUImqfdErZWtiNxTxpAzjG2IqfB1X9GbVqvbKbIC3a/bDyKG0PARrKj0XCxcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159400; c=relaxed/simple;
	bh=t12txK/zSsW2WJzxa7ZdWFAWVpWW/7PsuErRLUTJ5nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvHyYE36P+8yxaLbtUuoRrflQCWNRiEADE3Z05qOOMGK1/kPT/nw7K9TMEiO66qQ+XqCx6YQIegkZ36uFFBsAfBczHFoCvHZU7qD206p2c+qnj+Gp5UxBktzjf5t16wWR6t+mKmIFPnyD6CmtIKS3pP78YCARC1iMsmJ38F9HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IEbXUT/0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b327cfaf-97d7-4d7a-9d74-27927ef564ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726159396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkvHVPhu3GPSHUwVnN1nW2kl61d5EJQvDoc9XO2AyOQ=;
	b=IEbXUT/0gx6oTDVscv7xMo0YxFUp66OdF03gEY+MCr2rTto0H4gqi6UCfvtiJRX6hnu+I1
	K5MWqsRjrlllTAmJV55/aCWfSdYRpKAYxelAlzO2aqJib4MM7dLewH0qL+d5G17J2zLnt8
	D+yvAiLcGay9ex7bo5h7P1AkKtS1IP8=
Date: Thu, 12 Sep 2024 09:43:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
 <202409121439.L01ZquSs-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <202409121439.L01ZquSs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/11/24 11:54 PM, kernel test robot wrote:
> Hi Yonghong,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/selftests-bpf-Add-a-couple-of-tests-for-potential-sdiv-overflow/20240911-124236
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20240911044017.2261738-1-yonghong.song%40linux.dev
> patch subject: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
> config: x86_64-randconfig-121-20240912 (https://download.01.org/0day-ci/archive/20240912/202409121439.L01ZquSs-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409121439.L01ZquSs-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409121439.L01ZquSs-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>     kernel/bpf/verifier.c:21184:38: sparse: sparse: subtraction of functions? Share your drugs
>     kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>>> kernel/bpf/verifier.c:20538:33: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
>     

The above is expected. See below macro definition in include/linux/filter.h

/* BPF_LD_IMM64 macro encodes single 'load 64-bit immediate' insn */
#define BPF_LD_IMM64(DST, IMM)                                  \
         BPF_LD_IMM64_RAW(DST, 0, IMM)

#define BPF_LD_IMM64_RAW(DST, SRC, IMM)                         \
         ((struct bpf_insn) {                                    \
                 .code  = BPF_LD | BPF_DW | BPF_IMM,             \
                 .dst_reg = DST,                                 \
                 .src_reg = SRC,                                 \
                 .off   = 0,                                     \
                 .imm   = (__u32) (IMM) }),                      \
         ((struct bpf_insn) {                                    \
                 .code  = 0, /* zero is reserved opcode */       \
                 .dst_reg = 0,                                   \
                 .src_reg = 0,                                   \
                 .off   = 0,                                     \
                 .imm   = ((__u64) (IMM)) >> 32 })


So (__u32) (IMM) will cause a truncation and may cause a warning,
but it is expected for bpf.

> include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
>     include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>
> vim +20538 kernel/bpf/verifier.c
>
>   20445	
>   20446	/* Do various post-verification rewrites in a single program pass.
>   20447	 * These rewrites simplify JIT and interpreter implementations.
>   20448	 */
>   20449	static int do_misc_fixups(struct bpf_verifier_env *env)
>   20450	{
>   20451		struct bpf_prog *prog = env->prog;
>   20452		enum bpf_attach_type eatype = prog->expected_attach_type;
>   20453		enum bpf_prog_type prog_type = resolve_prog_type(prog);
>   20454		struct bpf_insn *insn = prog->insnsi;
>   20455		const struct bpf_func_proto *fn;
>   20456		const int insn_cnt = prog->len;
>   20457		const struct bpf_map_ops *ops;
>   20458		struct bpf_insn_aux_data *aux;
>   20459		struct bpf_insn *insn_buf = env->insn_buf;
>   20460		struct bpf_prog *new_prog;
>   20461		struct bpf_map *map_ptr;
>   20462		int i, ret, cnt, delta = 0, cur_subprog = 0;
>   20463		struct bpf_subprog_info *subprogs = env->subprog_info;
>   20464		u16 stack_depth = subprogs[cur_subprog].stack_depth;
>   20465		u16 stack_depth_extra = 0;
>   20466	
>   20467		if (env->seen_exception && !env->exception_callback_subprog) {
>   20468			struct bpf_insn patch[] = {
>   20469				env->prog->insnsi[insn_cnt - 1],
>   20470				BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
>   20471				BPF_EXIT_INSN(),
>   20472			};
>   20473	
>   20474			ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
>   20475			if (ret < 0)
>   20476				return ret;
>   20477			prog = env->prog;
>   20478			insn = prog->insnsi;
>   20479	
>   20480			env->exception_callback_subprog = env->subprog_cnt - 1;
>   20481			/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
>   20482			mark_subprog_exc_cb(env, env->exception_callback_subprog);
>   20483		}
>   20484	
>   20485		for (i = 0; i < insn_cnt;) {
>   20486			if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
>   20487				if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
>   20488				    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
>   20489					/* convert to 32-bit mov that clears upper 32-bit */
>   20490					insn->code = BPF_ALU | BPF_MOV | BPF_X;
>   20491					/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
>   20492					insn->off = 0;
>   20493					insn->imm = 0;
>   20494				} /* cast from as(0) to as(1) should be handled by JIT */
>   20495				goto next_insn;
>   20496			}
>   20497	
>   20498			if (env->insn_aux_data[i + delta].needs_zext)
>   20499				/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
>   20500				insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
>   20501	
>   20502			/* Make divide-by-zero exceptions impossible. */
>   20503			if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
>   20504			    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
>   20505			    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
>   20506			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>   20507				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>   20508				bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>   20509				bool is_sdiv64 = is64 && isdiv && insn->off == 1;
>   20510				struct bpf_insn *patchlet;
>   20511				struct bpf_insn chk_and_div[] = {
>   20512					/* [R,W]x div 0 -> 0 */
>   20513					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>   20514						     BPF_JNE | BPF_K, insn->src_reg,
>   20515						     0, 2, 0),
>   20516					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>   20517					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>   20518					*insn,
>   20519				};
>   20520				struct bpf_insn chk_and_mod[] = {
>   20521					/* [R,W]x mod 0 -> [R,W]x */
>   20522					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>   20523						     BPF_JEQ | BPF_K, insn->src_reg,
>   20524						     0, 1 + (is64 ? 0 : 1), 0),
>   20525					*insn,
>   20526					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>   20527					BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>   20528				};
>   20529				struct bpf_insn chk_and_sdiv64[] = {
>   20530					/* Rx sdiv 0 -> 0 */
>   20531					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>   20532						     0, 2, 0),
>   20533					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>   20534					BPF_JMP_IMM(BPF_JA, 0, 0, 8),
>   20535					/* LLONG_MIN sdiv -1 -> LLONG_MIN */
>   20536					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>   20537						     0, 6, -1),
>   20538					BPF_LD_IMM64(insn->src_reg, LLONG_MIN),

the warning is triggered here.

>   20539					BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
>   20540						     insn->src_reg, 2, 0),
>   20541					BPF_MOV64_IMM(insn->src_reg, -1),
>   20542					BPF_JMP_IMM(BPF_JA, 0, 0, 2),
>   20543					BPF_MOV64_IMM(insn->src_reg, -1),
>   20544					*insn,
>   20545				};
>   20546	
[...]

