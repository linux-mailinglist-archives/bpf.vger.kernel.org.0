Return-Path: <bpf+bounces-77459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A393CE03B0
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB95301FC33
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF91F0E25;
	Sun, 28 Dec 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx4+LWhW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC213C918;
	Sun, 28 Dec 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766882630; cv=none; b=BMxAuaaPK7HS0cXuM6VXEScrxZhZ7zS5ZmN65oF0bbK+P4phVyQ7zDaHv6eeq46xaEjv9r4YAeLbX0lbVEKAgjHH0iJhhaYY5HbJoD1KWfbq8G01TMq+JBs6kkea3UA3TcdC/4KSESGb3LHMa+35A0y8KIO6aHwgqNEhtZJefsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766882630; c=relaxed/simple;
	bh=7xDIzn+jrAOhaUM4MJ5T/e62FQADndfdlRXU3iFE7DY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eE9kvOkXJ0e988TRFGb4f4D40EeOWlBf170b1B3KhQ6yoCtkHJAH+u41MCFosyCGRuPsN1lT4jNDlmN8ViZI1dDU4L2AoiSIoF6h1P6iFqJg/sChS1208fKlUU8IAh+MVU130L9WnoEh/uQ2sKC3xwd1+YQVDWtB7gCRZvJYHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx4+LWhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E9C4CEF1;
	Sun, 28 Dec 2025 00:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766882628;
	bh=7xDIzn+jrAOhaUM4MJ5T/e62FQADndfdlRXU3iFE7DY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Nx4+LWhW3F40c7GB9hUUlojbcTix5QBmE3vaOw0DZjZ//Cdp/KnC61AkFBdHFqYB4
	 mNnTM26+BT1fXClLLfziPYUJb0vr4LjeUPzr8hayTk2KJFgSbqJtVirWY97UkELa/p
	 /hO9UE6HifY3PDsb8Sy0NaPdRBHEZewUacXNnWIFJR7CffoW5RorGyroVoGRO4VEZM
	 d5nazinnUmSkdMV0vrPQu9ynObo3cmmuX4TOheAvx8q+/hagmtd3HrSy/0sWXnz+hC
	 Br+5EovTi1NK90D6DwOhz6qbiql0OZyfch/OkO/mQ2qWKWvqBGD783lnQY859rM2H8
	 FNzVnIQcvr+gA==
Content-Type: multipart/mixed; boundary="===============0114110605579493139=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2206317c33d383383c0c77387d847a4f32afbe056490245ad13863c6b3ae293@mail.kernel.org>
In-Reply-To: <20251228002219.1183459-3-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-3-xiyou.wangcong@gmail.com>
Subject: Re: [Patch bpf-next v5 2/4] skmsg: implement slab allocator cache for sk_msg
From: bot+bpf-ci@kernel.org
To: xiyou.wangcong@gmail.com,netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,bpf@vger.kernel.org,zijianzhang@bytedance.com,cong.wang@bytedance.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 28 Dec 2025 00:43:47 +0000 (UTC)

--===============0114110605579493139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 84ec69568bb7..61e2c2e6840b 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h

[ ... ]

> @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>
> +static inline void kfree_sk_msg(struct sk_msg *msg)
> +{
> +	if (msg->skb)
> +		consume_skb(msg->skb);
> +	kmem_cache_free(sk_msg_cachep, msg);
> +}

[ ... ]

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 0812e01e3171..45ff311ccf49 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -503,16 +505,17 @@ bool sk_msg_is_readable(struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_is_readable);
>
> -static struct sk_msg *alloc_sk_msg(gfp_t gfp)
> +struct sk_msg *sk_msg_alloc(gfp_t gfp)
>  {
>  	struct sk_msg *msg;
>
> -	msg = kzalloc(sizeof(*msg), gfp | __GFP_NOWARN);
> +	msg = kmem_cache_zalloc(sk_msg_cachep, gfp | __GFP_NOWARN);
>  	if (unlikely(!msg))
>  		return NULL;
>  	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
>  	return msg;
>  }
> +EXPORT_SYMBOL_GPL(sk_msg_alloc);

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index a0a385e07094..ed049a912a23 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -38,7 +38,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
>  	struct sk_msg *tmp;
>  	int i, ret = 0;
>
> -	tmp = kzalloc(sizeof(*tmp), __GFP_NOWARN | GFP_KERNEL);
> +	tmp = sk_msg_alloc(GFP_KERNEL);
>  	if (unlikely(!tmp))
>  		return -ENOMEM;

The allocation is converted to sk_msg_alloc() which uses kmem_cache_zalloc(),
but the error path in bpf_tcp_ingress() still uses kfree(tmp). Since sk_msg
objects are now allocated from sk_msg_cachep, should this be kfree_sk_msg(tmp)
instead? Freeing a kmem_cache object with kfree() can corrupt slab metadata.

> @@ -406,8 +406,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  	    msg->cork_bytes > msg->sg.size && !enospc) {
>  		psock->cork_bytes = msg->cork_bytes - msg->sg.size;
>  		if (!psock->cork) {
> -			psock->cork = kzalloc(sizeof(*psock->cork),
> -					      GFP_ATOMIC | __GFP_NOWARN);
> +			psock->cork = sk_msg_alloc(GFP_ATOMIC);
>  			if (!psock->cork) {
>  				sk_msg_free(sk, msg);
>  				*copied = 0;

Similarly, psock->cork is now allocated via sk_msg_alloc(). However, in the
__SK_REDIRECT case when cork is true, the code path through
tcp_bpf_send_verdict() uses kfree(msg) to free the cork object. Should this
also be kfree_sk_msg(msg) to match the new allocation method?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20546413613

--===============0114110605579493139==--

