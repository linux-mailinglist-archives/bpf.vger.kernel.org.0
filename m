Return-Path: <bpf+bounces-75093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8BC702FE
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C9193C25F1
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A453350288;
	Wed, 19 Nov 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co88x2Zp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE03368288
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570013; cv=none; b=XFD5ASudqSaoYNdiooyXziiKoiFbwcbJaiDIunA3W2+c6iGYi2uOCkkQsZ4GX9MBpKu6QRKnfxo5VNXnDd5iDb5X0DEMaEOWUFDUpbFCOMkUfbgyiSdLeEPDUKXYDvqQCfrdB7pooaJTJArwVQ7HrMwCto9RF6+TWFBKtSdFf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570013; c=relaxed/simple;
	bh=w4cfnkvwZEHPsKrX0pc52wATt3wOwpFPwCaXk50FUAw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J6jEYW8Z7J9xH3qzsBf3LsyagzoOEMz5b2SM3VNNzKWmX9BTI8JgWg2RRBhueqpE6C4W1zah2bsUYilPnEZ555y46Zo3CJsl3W0VwaEB7Nq4K2dWS7XA8tsE935Bhn99PtMpBnl5aROsBlksWpfFiHhdArgZyJrWEMqqpdTAxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co88x2Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C006C116C6;
	Wed, 19 Nov 2025 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763570012;
	bh=w4cfnkvwZEHPsKrX0pc52wATt3wOwpFPwCaXk50FUAw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Co88x2ZpWHe4nPSaHZ7aJ1ETRM6myyMBgwbPxu66V/imczect3qEdEGAufo7rMLfH
	 S9avsPMsWAI8+kjGBluiFWhLPcpJRBZmFzBSHGN9zcGCsKZ8L6Anc4mzRpuc6/19lQ
	 dhSaTYDnWwb57sWLkOH0IIH6JMkW/Dc60vYxM3xzAeyZjbjvixIjcCZj8I9i4BCMPC
	 D3AqFyvH0+rrxZFzsbLZnf2Yu8F1XlBsWl4H7PqFqc1vWby6Nh7fhvbyRoK7rlmJx4
	 CTCtjrrl7aH4tldR51ob+XZhmJ1j5YJggxoOsn5NmBwbNR1KtO6iRnBAJt6Snr2YSA
	 o4JBRgt7f0xxA==
Content-Type: multipart/mixed; boundary="===============8352205405389840840=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5ca6d755d9b8e284e8c542cb5d56aab153e8626694867553532042a90442707@mail.kernel.org>
In-Reply-To: <20251119160355.1160932-4-martin.teichmann@xfel.eu>
References: <20251119160355.1160932-4-martin.teichmann@xfel.eu>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: correct stack liveness for tail calls
From: bot+bpf-ci@kernel.org
To: martin.teichmann@xfel.eu,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,martin.teichmann@xfel.eu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Nov 2025 16:33:32 +0000 (UTC)

--===============8352205405389840840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5441341f1..8d0b60fa5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -652,6 +652,7 @@ struct bpf_subprog_info {
>  	u32 start; /* insn idx of function entry point */
>  	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
>  	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
> +	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
>  	u16 stack_depth; /* max. stack depth used by this function */

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 117a2b1cf..f564150ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3555,8 +3555,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			subprog[cur_subprog].has_ld_abs = true;
>  		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
>  			goto next;
> -		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
> +		if (BPF_OP(code) == BPF_CALL)
>  			goto next;
> +		if (BPF_OP(code) == BPF_EXIT) {
> +			subprog[cur_subprog].exit_idx = i;
> +			goto next;
> +		}

[ ... ]

> +static int visit_tailcall_insn(struct bpf_verifier_env *env, int t)
> +{
> +	static struct bpf_subprog_info *subprog;
> +	struct bpf_iarray *jt;
> +
> +	if (env->insn_aux_data[t].jt)
> +		return 0;
> +
> +	jt = iarray_realloc(NULL, 2);
> +	if (!jt)
> +		return -ENOMEM;
> +
> +	subprog = bpf_find_containing_subprog(env, t);
> +	jt->items[0] = t + 1;
> +	jt->items[1] = subprog->exit_idx;
                        ^^^^^^^^^^^^^^^^^^

Can a subprogram with a tail_call have no BPF_EXIT instruction? The
verifier allows subprograms to end with an unconditional jump instead
of BPF_EXIT (see check_subprogs() which accepts BPF_JA as the last
instruction). In check_subprogs(), exit_idx is only set when a BPF_EXIT
is encountered. For subprograms ending with only jumps (like infinite
loops with tail_calls), exit_idx remains 0 from the kvzalloc() in
bpf_check().

If visit_tailcall_insn() uses exit_idx when it's 0, the jump table will
incorrectly point to instruction 0 instead of the actual exit, potentially
causing incorrect liveness analysis for stack slots.

> +	env->insn_aux_data[t].jt = jt;
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19508226347

--===============8352205405389840840==--

