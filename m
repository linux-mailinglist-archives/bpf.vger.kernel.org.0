Return-Path: <bpf+bounces-28119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6ED8B5F1C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6B1C21038
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258685636;
	Mon, 29 Apr 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9qwbbxu"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309978529D
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408376; cv=none; b=Bucxl5HfdDnvwFsaPb9Zjim2QulWWsQfwp/t6tjkTcSr6e/CEHm2V86gDFWbrVamyRAkdBqHshPbTyizsyc8bnMXpAdegtYZwdfaKtvs+jExyNBibOBKFnmFSWYCFnljx+HTpXAaE/k3Wws2JKWTDTOschoWFhkKagbyFO560TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408376; c=relaxed/simple;
	bh=8AkCyXLhGbhAPfe1Fra3H6gfQHWqPwM5vCPFufZalE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlH/6O27TZcWOkxVhVf8dF0FXake78eRxkzzfn09Kq092taGxzEwuwl1NWXJNZ1cLEMYGS3GGiiE8X3Q9ZIxMTHzOB1Bw/Aqd/Pdu5cxNo5I2mPK0ANPh+yz+QgletTM+n59/bvI5up6/s8ARHxmMz+Pe1ujzfb4xs/o8XZt+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9qwbbxu; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4b2cdf7-0978-4e72-a833-a809655fa84f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714408372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xqRRksfZH3+TxHoB8IrPWCFSMHIVx/UlnL5Owp+bOQ=;
	b=V9qwbbxuVp0mIk3UyE5MQqiseBLGck4twhTLCIJT2TPkXI4kO0rG6+9oDWy5JPiH923xt9
	UDE3tnCD38A4+gf0UkjRvqdSHHZL1/gMPvogKKTnfj1vqwfImv48M4E3qjfjPHJdFhREL/
	S25Bu6NLgc9+WJYuAki/SeIysjnpQiU=
Date: Mon, 29 Apr 2024 09:32:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fold LSH and ARSH pair to a single MOVSX
 for sign-extension
Content-Language: en-GB
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20240429152036.3411628-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240429152036.3411628-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 8:20 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> As shown in the ExpandSEXTINREG function in [1], LLVM generates SRL and
> SRA instruction pair to implement sign-extension. For x86 and arm64,
> this instruction pair will be folded to a single instruction, but the
> LLVM BPF backend does not do such folding.

With -mcpu=v4, sign-extention will be generated and in selftest
test_progs-cpuv4 will test with -mcpu=v4. The cpu v4 support
is added in llvm18, and I hope once llvm18 is widely available, we
might be able to make test_progs-cpuv4 as the default test_progs.

So I think this optimization is not needed.

>
> For example, the following C code:
>
> long f(int x)
> {
> 	return x;
> }
>
> will be compiled to:
>
> r0 = r1
> r0 <<= 0x20
> r0 s>>= 0x20
> exit
>
> Since 32-bit to 64-bit sign-extension is a common case and we already
> have MOVSX instruction for sign-extension, this patch tries to fold
> the 32-bit to 64-bit LSH and ARSH pair to a single MOVSX instruction.
>
> [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/LegalizeVectorOps.cpp#L1228
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   include/linux/filter.h |  8 ++++++++
>   kernel/bpf/verifier.c  | 46 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7a27f19bf44d..7cc90a32ed9a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -173,6 +173,14 @@ struct ctl_table_header;
>   		.off   = 0,					\
>   		.imm   = 0 })
>   
> +#define BPF_MOV64_SEXT_REG(DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +
>   #define BPF_MOV32_REG(DST, SRC)					\
>   	((struct bpf_insn) {					\
>   		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4e474ef44e9c..6bcee052d90d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20659,6 +20659,49 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
>   	return 0;
>   }
>   
> +static bool is_sext32(struct bpf_insn *insn1, struct bpf_insn *insn2)
> +{
> +	if (insn1->code != (BPF_ALU64 | BPF_K | BPF_LSH) || insn1->imm != 32)
> +		return false;
> +
> +	if (insn2->code != (BPF_ALU64 | BPF_K | BPF_ARSH) || insn2->imm != 32)
> +		return false;
> +
> +	if (insn1->dst_reg != insn2->dst_reg)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* LLVM generates sign-extension with LSH and ARSH pair, replace it with MOVSX.
> + *
> + * Before:
> + * DST <<= 32
> + * DST s>>= 32
> + *
> + * After:
> + * DST = (s32)DST
> + */
> +static int optimize_sext32_insns(struct bpf_verifier_env *env)
> +{
> +	int i, err;
> +	int insn_cnt = env->prog->len;
> +	struct bpf_insn *insn = env->prog->insnsi;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (i + 1 >= insn_cnt || !is_sext32(insn, insn + 1))
> +			continue;
> +		/* patch current insn to MOVSX */
> +		*insn = BPF_MOV64_SEXT_REG(insn->dst_reg, insn->dst_reg, 32);
> +		/* remove next insn */
> +		err = verifier_remove_insns(env, i + 1, 1);
> +		if (err)
> +			return err;
> +		insn_cnt--;
> +	}
> +	return 0;
> +}
> +
>   static void free_states(struct bpf_verifier_env *env)
>   {
>   	struct bpf_verifier_state_list *sl, *sln;
> @@ -21577,6 +21620,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>   	if (ret == 0)
>   		ret = optimize_bpf_loop(env);
>   
> +	if (ret == 0)
> +		ret = optimize_sext32_insns(env);
> +
>   	if (is_priv) {
>   		if (ret == 0)
>   			opt_hard_wire_dead_code_branches(env);

