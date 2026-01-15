Return-Path: <bpf+bounces-79144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BCD283C9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEF0930101D6
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF530FC19;
	Thu, 15 Jan 2026 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebjx0oLh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5F28136F;
	Thu, 15 Jan 2026 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506592; cv=none; b=slmk7vZh3j79i4zVHJC/Gy+210wjMvnk0PrZRXchV6AHFXyxX94pxkMI8qVvFiW4bt4y2yFu5P7VfhzHOyLs/FpOSD2PhDEIH1vjZFPMt8avhsmR6ID5TAJX6jvWov/DA6HZS6YC1EE+JBT1EUrghs3l0f5GG2bFGGL8avQYFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506592; c=relaxed/simple;
	bh=bv1rsFac9qAyhinlecq3WEIhsjUSeBNb6oigM2rIAhY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dpoo//60trqPBCIVBODzVLzJ+Q8LhzyWPFoLkECo8wNOyZw/u1uiztqSJWKZjVSnIOSgyH38Nw8Kiy7qsa7SxvabogBolvRCoKQGdlf89xrol9RCXd3uD3bKLAqUC9+Q8LjxjxYwfTjjcWBL9QZgNgv74VIuvh0Cz84+mYC6JgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebjx0oLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B795C116D0;
	Thu, 15 Jan 2026 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768506591;
	bh=bv1rsFac9qAyhinlecq3WEIhsjUSeBNb6oigM2rIAhY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ebjx0oLhNmCTa2svxANxpqWNbE6xfc2uwYjiGz2X4qLOMShOKUdK1PQ7/TMr+G0VF
	 Y5mZrJ3TT+lo0Q/lC6Ab5ocHI7J43PCdcepAG0rGe/cJEOCVkvwHv1RKZqnJxzodiP
	 bHcfZLwslZw5N0vG4zuX0/PwmRdMK2uaDMEh1NEK7Hi3qQMkq/9/reqODJoOCEB+y8
	 buVECf6LkdCJpqt6hYBKj4U7xBos25vvXCpDwxzszfM8sJp88wn9z1Hw2cpJewOvR2
	 f7xomgpxX3xzJE+Zeb3NyQjKu1fUetWkdnqbx7fPTmJNIm8J7oR8av0VrsCcJCogzK
	 NxpeYOFczcsIQ==
Content-Type: multipart/mixed; boundary="===============8947843973836263620=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c6092a23ab1e465df632ab4d5757c60a8bf0be121eec277ced123726fef893d@mail.kernel.org>
In-Reply-To: <20260115192737.743857-5-xiyou.wangcong@gmail.com>
References: <20260115192737.743857-5-xiyou.wangcong@gmail.com>
Subject: Re: [Patch bpf-next v6 4/4] tcp_bpf: improve ingress redirection performance with message corking
From: bot+bpf-ci@kernel.org
To: xiyou.wangcong@gmail.com,netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,zijianzhang@bytedance.com,bpf@vger.kernel.org,amery.hung@bytedance.com,cong.wang@bytedance.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 15 Jan 2026 19:49:51 +0000 (UTC)

--===============8947843973836263620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 45ff311ccf49..b9954cd2b8cc 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> +static void __sk_psock_purge_backlog_msg(struct sk_psock *psock)
> +{
> +	struct sk_msg *msg, *tmp;
> +	LIST_HEAD(tmp_list);
> +
> +	spin_lock(&psock->backlog_msg_lock);
> +	list_splice_init(&psock->backlog_msg, &tmp_list);
> +	spin_unlock(&psock->backlog_msg_lock);
> +
> +	list_for_each_entry_safe(msg, tmp, &tmp_list, list) {
> +		struct sock *sk_from = msg->sk;
> +		bool slow;
> +
> +		list_del(&msg->list);
> +		slow = lock_sock_fast(sk_from);
> +		sk_wmem_queued_add(sk_from, -msg->sg.size);
> +		sock_put(sk_from);
> +		sk_msg_free(sk_from, msg);
> +		unlock_sock_fast(sk_from, slow);
                         ^^^^

Can this trigger a use-after-free? The sock_put(sk_from) call appears
before sk_msg_free() and unlock_sock_fast(). If sock_put() drops the
last reference to sk_from, the socket will be freed while the lock is
still held, and the subsequent sk_msg_free() and unlock_sock_fast()
calls would access freed memory.

The reference taken by sock_hold() in tcp_bpf_ingress_backlog() when
queueing messages (tmp->sk = sk; sock_hold(tmp->sk)) could be the last
reference if the sender socket has closed before the receiver's psock
is destroyed.

Would moving sock_put(sk_from) to after unlock_sock_fast() fix this?

> +		kfree_sk_msg(msg);
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21044016298

--===============8947843973836263620==--

