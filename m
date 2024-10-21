Return-Path: <bpf+bounces-42670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D19A715A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB7EB22136
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1FC1F7091;
	Mon, 21 Oct 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+pR6ZMh"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863831F131C
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532954; cv=none; b=sg8hFYUOKdunxGmjvqQKtdN4c1+JpD+VtgBuoPLYnbpH5yHABiZUA++5JNRPlPIAzr7jQTRyV3Ic4t3B63ezko8efOHWYYql5SuUSLNl12kJY3kuNXr0tyhrBvL/EXo9ZGVyn33t8LakOKwi3DGKXHm2wr+AmYd8Fm3xfhwGFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532954; c=relaxed/simple;
	bh=xpGSAnis5mgPSfa+9LKXaeNm1q+E9Q7gPKFE6kePS3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMtRQSQXAsttKSjMv27870taVmrXkZqbMjZzAv4dTPyNwXfkdBxNriFos+ZsKFsE55Wzh2j7jY/8dx4JKZKPvtz7ipoRT7b3gID/0kHQJlwBWeqASqLjVMmELt46Rt3lYqO8fYmAiNlKXXiGZpNEoa9N1Nz2/1/BGjMyPwWRG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+pR6ZMh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87faf17b-51aa-487f-8d49-bf297a64ffa6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729532949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mL7LUy4tyvw9qW3qPJB6kcp5+G+BhZNJVvxCWEkLPCs=;
	b=G+pR6ZMhK16NyXg2Ro7n4pXeCr01wn0jTUJK6wPnJVr18n2cE5Xya4ZbSl/NlkxA8nFM2Y
	KZC6IOR9g9Udu8XEu1dWX/c8dDkOdkG0wEA3nMpV7ss90WFwdJbFsFioCDnOONdGZW8DR+
	LkVC+7kRYlNN+hpX80Sxf9ZY9z4HzDs=
Date: Mon, 21 Oct 2024 10:49:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-2-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241021133929.67782-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 6:39 AM, Leon Hwang wrote:
> In the x86_64 JIT, when calling a function, tailcall info is propagated if
> the program is tail_call_reachable, regardless of whether the function is a
> subprog, helper, or kfunc. However, this propagation is unnecessary for
> not-tail_call_reachable subprogs, helpers, or kfuncs.
>
> The verifier can determine if a subprog is tail_call_reachable. Therefore,
> it can be optimized to only propagate tailcall info when the callee is
> subprog and the subprog is actually tail_call_reachable.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   arch/x86/net/bpf_jit_comp.c | 4 +++-
>   kernel/bpf/verifier.c       | 6 ++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa57..6ad6886ecfc88 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2124,10 +2124,12 @@ st:			if (is_imm8(insn->off))
>   
>   			/* call */
>   		case BPF_JMP | BPF_CALL: {
> +			bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
> +			bool subprog_tail_call_reachable = dst_reg;
>   			u8 *ip = image + addrs[i - 1];
>   
>   			func = (u8 *) __bpf_call_base + imm32;
> -			if (tail_call_reachable) {
> +			if (pseudo_call && subprog_tail_call_reachable) {

Why we need subprog_tail_call_reachable? Does
	tail_call_reachable && psueudo_call
work the same way?

>   				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>   				ip += 7;
>   			}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba8..6e7e42c7bc7b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19990,6 +19990,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   			insn[0].imm = (u32)addr;
>   			insn[1].imm = addr >> 32;
>   		}
> +
> +		if (bpf_pseudo_call(insn))
> +			/* In the x86_64 JIT, tailcall information can only be
> +			 * propagated if the subprog is tail_call_reachable.
> +			 */
> +			insn->dst_reg = env->subprog_info[subprog].tail_call_reachable;
>   	}
>   
>   	err = bpf_prog_alloc_jited_linfo(prog);

