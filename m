Return-Path: <bpf+bounces-73442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7493C315CB
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215AA4F80A7
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DE32ABFE;
	Tue,  4 Nov 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz3/NXuY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE032AADA
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264691; cv=none; b=XbwSmzQjjrM8uO6wEtdeT9HSjzY1d1cNSU7sHbcFCra/KGt/QFbW38XH0KlyJFzKIOjJkBle9xvcNRSJ5pV6JK8/HYwCzB1pmrV8sv3ZdIgLqCXyD+eLnp7YcX8612vVSgxc6CazOcADRQdIswWkyYK/ydmp+Jus2SxuMYhvyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264691; c=relaxed/simple;
	bh=uMs7GshsEcy8MUMCLltGvsKj4H1TudNFRk7vbV8WNzY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jid2TxqdfoWLJnGfWiGXA7rSM25/LrRbvKfeBWGmV1WbvzjVfiTh2hSM0TwXOT9v65MUDUTnA9zPorDK0+x2KHK32lVQMqWN2uun0nL+sBsPZ0b/ffyTzOWdW57RzZNnOSw68gO0EK04KUe0ccnYCVYcOdP+XzaEMghVUve+RXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz3/NXuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3BEC4CEF7;
	Tue,  4 Nov 2025 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264691;
	bh=uMs7GshsEcy8MUMCLltGvsKj4H1TudNFRk7vbV8WNzY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Fz3/NXuYyv1nQKQkseUF9gZ5iQPTctMoW/YfP1zP4qT8uft3fmWkA1NDzBmKDAGql
	 uQMhfJ49FxANzSfSLelY4WTZXuQt44L1rPMBsquAP20lxSjG+E2nWyDJvRYzCx5vWq
	 VZdF4XQeMd3wtgXjwn8BOYFy458iBykaoFQirG5FpsxVcolv2WHRNHcx0wzqaqWdNs
	 irrTvOdYReZEeHWxlhezj2befhgpGSQYFOOyuv5KEku/IW2013u457FVrPs3VpK1Ps
	 tYDkWg6bHhrAoHTVSx+HEjRLgTgatDYQ7v/3Zv1uNHqS+NvJ9g2po7Qp16qLOy39IX
	 85IX5jsNJtqlA==
Content-Type: multipart/mixed; boundary="===============0395455770530490440=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <866547a682b6a159bcbd46a58068c723654e1fcf72b2a09b24d19d927c4f1415@mail.kernel.org>
In-Reply-To: <20251104133004.2559222-1-martin.teichmann@xfel.eu>
References: <20251104133004.2559222-1-martin.teichmann@xfel.eu>
Subject: Re: [PATCH v2 bpf] bpf: properly verify tail call behavior
From: bot+bpf-ci@kernel.org
To: martin.teichmann@xfel.eu,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,martin.teichmann@xfel.eu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 13:58:11 +0000 (UTC)

--===============0395455770530490440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff40e5e65..4b7439a48 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11884,6 +11888,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		env->prog->call_get_func_ip = true;
>  	}
>
> +	if (func_id == BPF_FUNC_tail_call) {
> +		if (env->cur_state->curframe) {
> +			struct bpf_verifier_state *branch;
> +			mark_reg_scratched(env, BPF_REG_0);
> +			branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +			if (IS_ERR(branch))
> +				return PTR_ERR(branch);

Can push_stack() return an ERR_PTR? Looking at the push_stack()
function in verifier.c, it returns NULL on all error paths (allocation
failure at line 2095, copy failure at line 2105, and stack overflow at
line 2110). Every other call site in the verifier checks for NULL:

  - cluster_alloc_swap_entry() at line 9017: if (!queued_st)
  - push_callback_call() at line 10608: if (!callback_state)
  - check_reference_leaks_function() at line 13852: if (!branch)
  - check_cond_jmp_op() at line 14314: if (branch && insn)
  - check_iter_next_call() at line 16739: if (!queued_st)
  - do_check() at line 16858: if (!other_branch)

If push_stack() returns NULL due to memory pressure, IS_ERR(NULL)
evaluates to false, so the error check won't trigger and the code will
continue with a NULL branch pointer.

> +			clear_all_pkt_pointers(env);
> +			mark_reg_unknown(env, regs, BPF_REG_0);
> +			err = prepare_func_exit(env, &env->insn_idx);
> +			if (err)
> +				return err;
> +			env->insn_idx--;
> +		} else {
> +			changes_data = false;
> +		}
> +	}
> +
>  	if (changes_data)
>  		clear_all_pkt_pointers(env);
>  	return 0;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19070634029

--===============0395455770530490440==--

