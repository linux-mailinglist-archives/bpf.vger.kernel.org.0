Return-Path: <bpf+bounces-77931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B6CF6EB7
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 07:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD083019BD6
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31353220698;
	Tue,  6 Jan 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihsU4iCr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5307263B
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681928; cv=none; b=MdwRI9N9H6N3VI80+tlSdh7n6zkoERtCSh0/ywMc/jSWCKmHtgEe5A4lfDCBtusqSlLBx3qhQ1/YL6NmKV8ObjmeAyM67pI62L12B3JcoFuSaWH/ddOyBMek1X2kfrRlM1HDdzZ+X5wlg7yTBn5xGpwL2V6CTxUZ1nBgBhTP6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681928; c=relaxed/simple;
	bh=+BeVj1NIYppmiudPtlCyxYcsyGUJoVLBDf6ohm+EwRw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qoZ+KeGdZvxcwyjD1l6k4rLV8RnBLpmlpYT08WFa+ym23m9XMSnOp7zL5cntvK6Q+hTQntlt+/SI1/1PWTRuzIgIdh97prbiqOdLsL8obhWyyBU2FsZBm94AMJVnSuqz2LmGlJg9pYZY8KwW1i3hjJS3h48ZQvYIly6kONpLDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihsU4iCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0376C116C6;
	Tue,  6 Jan 2026 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767681928;
	bh=+BeVj1NIYppmiudPtlCyxYcsyGUJoVLBDf6ohm+EwRw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ihsU4iCr6xermrVkpMv2Py2wTulFalyLc+81idVHHJ2TBji5VkRwoLQyryDA/bAxD
	 t0CTsMCDxpZi/Y8ZWHKQ+B8oFsOOv7fynBlXQlzPq+uTVbSz7erpdyffWwIOLeRopO
	 wKGvHevbK5NweBa0sjQDhWwDGozAyBRJ9FhawlVs+iNXskqWmlLYMpuApAjr6KYbRl
	 /n+ZHADTwxFO16L9glfEdv3DUozUM/UBm2+3Nbg3k3Wz12z4gCcf0v1RJrmr14ZuTF
	 Oza65y06KS9NPJKpAr6fspZnHlMxC9fi+/2tXCZA1kw97E7RXN5/+lbZdeIl2FaosD
	 VFgR03U/8ntPw==
Content-Type: multipart/mixed; boundary="===============8237786503116864346=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org>
In-Reply-To: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
References: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
Subject: Re: [PATCH 1/2] bpf/verifier: allow calls to arena functions while holding spinlocks
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  6 Jan 2026 06:45:27 +0000 (UTC)

--===============8237786503116864346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9394b0de2ef0..9b3067b16507 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
>  }
>
> +static bool is_bpf_arena_kfunc(u32 btf_id)
> +{
> +	return btf_id == special_kfunc_list[KF_bpf_arena_alloc_pages] ||
> +	       btf_id == special_kfunc_list[KF_bpf_arena_free_pages] ||
> +	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
> +}
> +
>  static bool kfunc_spin_allowed(u32 btf_id)
>  {
>  	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
> -	       is_bpf_res_spin_lock_kfunc(btf_id);
> +	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id);
>  }

Can this cause sleeping in atomic context when calling bpf_arena_free_pages()
while holding a BPF spinlock?

When bpf_spin_lock() is held, IRQs are disabled. The call path is:

  bpf_arena_free_pages() [sleepable=true]
    -> arena_free_pages()
       -> raw_res_spin_unlock_irqrestore() [releases arena lock]
       -> zap_pages()
          -> guard(mutex)(&arena->lock)  <-- mutex acquisition!

The arena's rqspinlock is released before zap_pages(), but the BPF program's
spinlock is still held with IRQs disabled (the arena lock's irqrestore
restores to IRQs-disabled state). The zap_pages() function then tries to
acquire arena->lock which is a mutex, calling might_sleep().

Looking at in_sleepable_context() in verifier.c:

    static inline bool in_sleepable_context(struct bpf_verifier_env *env)
    {
        return !env->cur_state->active_rcu_locks &&
               !env->cur_state->active_preempt_locks &&
               !env->cur_state->active_irq_id &&
               in_sleepable(env);
    }

This does not check active_locks, so when holding a BPF spinlock the
verifier won't set non_sleepable=true, meaning bpf_arena_free_pages_non_sleepable()
won't be selected instead of bpf_arena_free_pages().

Should in_sleepable_context() also check env->cur_state->active_locks to
ensure the non-sleepable variant is used when calling arena kfuncs while
holding a BPF spinlock?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20740151468

--===============8237786503116864346==--

