Return-Path: <bpf+bounces-43065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393509AED08
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD11C23071
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3F1F8195;
	Thu, 24 Oct 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rs2Y+AlW"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A033EA
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789300; cv=none; b=oTiGK9ngRD4FV1yelAP4rQU+jaQEZPGCcAuNUPzbhXjWyDL+dqljONBsSzAwlNCB0xMZlRCLXqqXLk0qbQWwcz4xCBHTyZS27+yiQq62S/s4y2jecHybDZHEMfLvRwG+v5RcryQ2lLGG85IzYhDR6h7SNDf4w/rrxr0BYxS459s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789300; c=relaxed/simple;
	bh=Bt7R8jlMbgsXTOq+Q5Jed+YefwuO5yK5e01yiMyGk+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmT4x7hYyGu3aI9K4H9Z27oZSKGBuYf1hZlWAjkDI3bnjPebE+WguN1mxQfeFSI4ZP4MIxWq/pCv2ZUYHCcMcfBHNGBd+My6z4JsP/JOspbTlCxaHL9MFLfWBRkifqGK1tfhDU9MjPwTlnUbfy2Fx1En3HyENrnZIvp6PTY8AX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rs2Y+AlW; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7774e2a-2f36-4275-afb8-08e40a789b5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729789295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0WIhlcaQ9lZWUk5krbyBEpDHAFxdxE3ELl5QfPYSzw=;
	b=rs2Y+AlWZEjgb4kmF7UMmLZXy4zgAlu+uT36JRrp9IetbS70jGMSDV5/HJVHrfWEpXIhQY
	098FHEwOzM8UlJGqNPlyhvAdGNOn8qcxs5LnU3KKjDwjoKBPqpicuJiRRZ/erwkjmGn0+0
	XNun7X9K3ug94FFdpVOjXNjs1z5hSto=
Date: Thu, 24 Oct 2024 10:01:28 -0700
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

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

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

The comment can be simplied as
	/* Indicate whether callee is tail call
reachable or not */

>   	}
>   
>   	err = bpf_prog_alloc_jited_linfo(prog);

