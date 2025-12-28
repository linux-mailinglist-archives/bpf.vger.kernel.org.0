Return-Path: <bpf+bounces-77460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20922CE03AD
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76CE9300530E
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662F1FCFEF;
	Sun, 28 Dec 2025 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaqBQVUB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD613C918;
	Sun, 28 Dec 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766882632; cv=none; b=mxXgBENFwLkoR+c9N87+KR/3h1Y+umYjk6+f/e6SPVWc2eqO9QXBCJYVkDcaP/G+fg+N99DpuYYAhbeteC6Gu1F/Eo3C5q1A9C+Omc4ErQs6PuUNLgMrthc71n58ZqgpCPUt16C6E0eeKeGrB/7MHESIr2QjFXTA3UEcIoJdP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766882632; c=relaxed/simple;
	bh=SamE5VriQ9r8AoC6RxcKwYHPb5e6ovDGc4ogU86lv3M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y2VA2xKSIQnT7/fgwatfNAFDTlUq+OcVD24GsbAlBTB4w7VK+URAthFZPfCO64h/r4ZpT5+WaXbuhIxSh9OM09og7dty7C66b5nLg+BfO2Vd8m84Vl44BqCztioawqNG9BwQY3o6krHQXLNyvorBgcjsNnIST1lEBmPWPySIM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaqBQVUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868C2C116C6;
	Sun, 28 Dec 2025 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766882631;
	bh=SamE5VriQ9r8AoC6RxcKwYHPb5e6ovDGc4ogU86lv3M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RaqBQVUBj6s/GGqztpLGNUINcOiywpzrSYBCkQXBdmNPMK/1ux9/6b5t5KcplXGf0
	 n+AZwLnK+b/oUU/oYOXXs5yv//DBMZppfFUMSvTylvIZtZTXL3Syv9mtmjKUl+GBV8
	 ErMB7F8cTTFlAokiiXXzOTydEDHXyAzrcYTbyAZLqheVv8PM0s1wJmq70yOYRoW4VM
	 Dm7pC7vVU9yyx532i1SigMzz0ul4SxgrlVqzNKT7wRY58icv0hzSA0HF2+z3T92++U
	 mVMa4HoT5owT4vdQoTbjsSAYHAPK40YuEtQgFjajoF7AkJoFuOKoTf4K9JaEH7Dhvc
	 4VvVYCZdSSkew==
Content-Type: multipart/mixed; boundary="===============1203078364354006054=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8ffd9bb3fd24376adf963a6e7137f10b95db761b084a29ec3efa0eb7f305296@mail.kernel.org>
In-Reply-To: <20251228002219.1183459-5-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-5-xiyou.wangcong@gmail.com>
Subject: Re: [Patch bpf-next v5 4/4] tcp_bpf: improve ingress redirection performance with message corking
From: bot+bpf-ci@kernel.org
To: xiyou.wangcong@gmail.com,netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,bpf@vger.kernel.org,zijianzhang@bytedance.com,amery.hung@bytedance.com,cong.wang@bytedance.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 28 Dec 2025 00:43:50 +0000 (UTC)

--===============1203078364354006054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 45ff311ccf49..2dd4ade35b11 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> +static void __sk_psock_purge_backlog_msg(struct sk_psock *psock)
> +{
> +	struct sk_msg *msg, *tmp;
> +
> +	spin_lock(&psock->backlog_msg_lock);
> +	list_for_each_entry_safe(msg, tmp, &psock->backlog_msg, list) {
> +		struct sock *sk_from = msg->sk;
> +		bool slow;
> +
> +		list_del(&msg->list);
> +		slow = lock_sock_fast(sk_from);
                       ^^^^^^^^^^^^^^^^^^^^^^

Can lock_sock_fast() be called while holding backlog_msg_lock spinlock?
lock_sock_fast() contains might_sleep() and can call schedule() via
__lock_sock() when the socket is contended. This would result in
"scheduling while atomic" since we're holding the spinlock.

The call chain is: sk_psock_destroy() -> __sk_psock_purge_backlog_msg()
which runs in workqueue context where sleeping would normally be fine,
but not while holding a spinlock.

> +		sk_wmem_queued_add(sk_from, -msg->sg.size);
> +		sock_put(sk_from);
> +		sk_msg_free(sk_from, msg);
> +		unlock_sock_fast(sk_from, slow);
> +		kfree_sk_msg(msg);
> +	}
> +	spin_unlock(&psock->backlog_msg_lock);
> +}

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index ed049a912a23..d0e03e7df8e3 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> +static int tcp_bpf_ingress_backlog(struct sock *sk, struct sock *sk_redir,
> +				   struct sk_msg *msg, u32 apply_bytes)
> +{
> +	bool ingress_msg_empty = false;
> +	bool apply = apply_bytes;
> +	struct sk_psock *psock;
> +	struct sk_msg *tmp;
> +	u32 tot_size = 0;
> +	int ret = 0;
> +	u8 nonagle;
> +
> +	psock = sk_psock_get(sk_redir);
> +	if (unlikely(!psock))
> +		return -EPIPE;
> +
> +	spin_lock(&psock->backlog_msg_lock);
> +	/* If possible, coalesce the curr sk_msg to the last sk_msg from the
> +	 * psock->backlog_msg.
> +	 */
> +	if (!list_empty(&psock->backlog_msg)) {
> +		struct sk_msg *last;
> +
> +		last = list_last_entry(&psock->backlog_msg, struct sk_msg, list);
> +		if (last->sk == sk) {
> +			int i = tcp_bpf_coalesce_msg(last, msg, &apply_bytes,
> +						     &tot_size);
> +
> +			if (i == msg->sg.end || (apply && !apply_bytes))
> +				goto out_unlock;
> +		}
> +	}
> +
> +	/* Otherwise, allocate a new sk_msg and transfer the data from the
> +	 * passed in msg to it.
> +	 */
> +	tmp = sk_msg_alloc(GFP_ATOMIC);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		spin_unlock(&psock->backlog_msg_lock);
> +		goto error;
                  ^^^^^^^^^^

When tcp_bpf_coalesce_msg() partially succeeds (adds data to last->sg and
increments tot_size) but then sk_msg_alloc() fails, the error path jumps
to 'error' label which skips the sk_wmem_queued_add(sk, tot_size) call at
out_unlock.

However, the coalesced data is now in the backlog (in 'last'), and when
backlog_xfer_to_local() later processes it, it will call
sk_wmem_queued_add(msg->sk, -msg->sg.size) for the full size including
the coalesced portion. Since sk_wmem_queued was never incremented for
that coalesced portion, this would underflow sk_wmem_queued.

> +	}
> +
> +	tmp->sk = sk;
> +	sock_hold(tmp->sk);
> +	tmp->sg.start = msg->sg.start;
> +	tcp_bpf_xfer_msg(tmp, msg, &apply_bytes, &tot_size);
> +
> +	ingress_msg_empty = list_empty(&psock->ingress_msg);
> +	list_add_tail(&tmp->list, &psock->backlog_msg);
> +
> +out_unlock:
> +	spin_unlock(&psock->backlog_msg_lock);
> +	sk_wmem_queued_add(sk, tot_size);

[ ... ]

> +error:
> +	sk_psock_put(sk_redir, psock);
> +	return ret;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20546413613

--===============1203078364354006054==--

