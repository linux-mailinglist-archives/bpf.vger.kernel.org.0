Return-Path: <bpf+bounces-74642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E14C5FF8F
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 04:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB46D35FE1C
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CA2248B0;
	Sat, 15 Nov 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTq3kK1X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9379E571
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763178597; cv=none; b=ULpTPAsmOEcgjp+PaLVSAbF9QeLVyqNdsfh0JaRYEshY3RZ9e58X62Le/hlTeYlJdmQ3k5fMwe/fKIv3032mOl/6b2cXO4Bkf/EMDtsIVdjjpUKnv/zACCDSXbqHYSqBH4zdh2mKiDwoxcdsOfdnrPjac1qpUFTaPdTEnBkzrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763178597; c=relaxed/simple;
	bh=IDfr9/7XZ++ucV9F9b0eUFMzy4V0RmZFZAHrgnLquyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f3FvV8drEqdxIbGqPmCRMQAHL8AvDwkhK5D6opbfKgMrn5fncTkdWKddw94kuMO1vhA5zMEQw0ltI70Sh3P508PUZn9kVYlnHSdC9w0Jjcz1S062uN4I8Ln+8Ody3QPhVHDJt4Yqidmy8uEeUfB20ARFxz2TWPbGZpp5FMbXSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTq3kK1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF2FC116B1;
	Sat, 15 Nov 2025 03:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763178597;
	bh=IDfr9/7XZ++ucV9F9b0eUFMzy4V0RmZFZAHrgnLquyQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lTq3kK1XENsf/VrQITsPN0R5qwebf4SSYuFft5FMVxo7Yfudc6/A+dAB04amWVykn
	 wxZDosRXGfAnUMpH5XlOMBr+dtqKOBMPykJ6AYFoLPPCuTmxgmbFGZlEXRb3bF7XRI
	 BSUK4tR99j9qEZESnMltfc3iX8M6o+ziiRf6ToTaP5yhlCwzYSY2AMBjRDiUFt83cj
	 LXZaIWdCajSNDS59OMTl8wzySm2sIxndA+ZV0XGCga4WD+K8l/R12rHpmLUXAvYpwP
	 T5MjnZJH21WMlh8p++yyXGqyD0hqJfP4f1UIQdlU1hspsKRBJdwNBmm1fiexkPfb9r
	 Rppk37IcIPsew==
Content-Type: multipart/mixed; boundary="===============0989518159406727954=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69d65ed9afeed95bbdb054a20182feb220a1799c37b4cc8a2ce935c949ef2722@mail.kernel.org>
In-Reply-To: <20251115032609.2126206-1-pulehui@huaweicloud.com>
References: <20251115032609.2126206-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v4] bpf: Fix invalid mem access when update_effective_progs fails in __cgroup_bpf_detach
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,alan.maguire@oracle.com,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Nov 2025 03:49:56 +0000 (UTC)

--===============0989518159406727954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 973233b82..569de3b14 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -712,11 +712,13 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>  		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>
>  		duration = sched_clock() - start;
> -		stats = this_cpu_ptr(prog->stats);
> -		flags = u64_stats_update_begin_irqsave(&stats->syncp);
> -		u64_stats_inc(&stats->cnt);
> -		u64_stats_add(&stats->nsecs, duration);
> -		u64_stats_update_end_irqrestore(&stats->syncp, flags);
> +		if (likely(prog->stats)) {
> +			stats = this_cpu_ptr(prog->stats);
> +			flags = u64_stats_update_begin_irqsave(&stats->syncp);
> +			u64_stats_inc(&stats->cnt);
> +			u64_stats_add(&stats->nsecs, duration);
> +			u64_stats_update_end_irqrestore(&stats->syncp, flags);
> +		}

Does bpf_prog_inc_misses_counter() need the same NULL check? The
dummy_bpf_prog.prog can be inserted into trace event and network
namespace prog_arrays via bpf_prog_array_delete_safe(). When recursion
is detected, bpf_prog_inc_misses_counters() iterates these arrays and
calls bpf_prog_inc_misses_counter() on each prog, including
dummy_bpf_prog. In kernel/bpf/syscall.c bpf_prog_inc_misses_counter():

    stats = this_cpu_ptr(prog->stats);
    flags = u64_stats_update_begin_irqsave(&stats->syncp);

This dereferences prog->stats without checking if it's NULL.

Call chain example: trace recursion detected -> kernel/trace/bpf_trace.c
trace_call_bpf() -> bpf_prog_inc_misses_counters(call->prog_array) ->
iterates array items -> bpf_prog_inc_misses_counter(&dummy_bpf_prog.prog)
-> dereferences NULL prog->stats.

>  	} else {
>  		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19383775400

--===============0989518159406727954==--

