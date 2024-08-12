Return-Path: <bpf+bounces-36878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536294E942
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B81B2186E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D516C852;
	Mon, 12 Aug 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFq+ZSw/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D116D4E6
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453601; cv=none; b=rtIgluUwefMjBx8gcA/zcq2SX06tS24BCpGMf6PEhBiYa2LCBNsNXI49oxv9JiYcfR1N5vEUDtm7JRAsDRwXGzUMJJdz7WtQCEzn5r9C9PrhpsSPIl3uKFHiDNp1ZSeuShoS849WksZuS7EdBSEBVW0/zKRP7UOtWwROkOPcrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453601; c=relaxed/simple;
	bh=4903o0Gxm9S2KRs2tL3qBkHRdHaKxdPP61YxuBSYSok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEPN0jyuTyMrM78P7il+j5QAbjM0kKRzcnC4o147Net0lb8woCvLr2rEii3kPwqZ6TOdc/TZooyaafd8hTNmUmQTLmmMuUf/+x+QaUTOHLj7DJ1eKHi75Uxc68nJEK1pvHg8o4k944ATsszlkU1VR0gDgGDgFRv2H/2uboJ6+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFq+ZSw/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
	b=PFq+ZSw/RCuwIBPgdHqjcTV0Gw11zLE6JNmVBKVAglA5ZbHYdPjM9vA6lQWH7uln9FiZ90
	ZSZOHM/O2if6X7inkUEYmDbaUkEqbiUnMpm2KtaQI5iY6eYywBeLvek0io0LGl+dl2e+R9
	gpMlPmOHyzdkLctOt+6Xl3Z4fwVF8HM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-V6ZpTQWXNSuYz8uhzbcT_w-1; Mon, 12 Aug 2024 05:06:33 -0400
X-MC-Unique: V6ZpTQWXNSuYz8uhzbcT_w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef23ec8dceso40615571fa.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 02:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453592; x=1724058392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
        b=QAkGrglj9aaew9Yt+cjYmuvBZRfXqGY5iYMzmiHbgu8To9/IFGdtogW1PaMGu/rmIm
         xsAhz/u3RrtjRMBUXLouPRFNiv7X4bptgFkkS0qa9oqWYsRBAdjMyPJQbfxk59tqZY+y
         TRMcST94ssWPcJxB7b9L6BpA3PdiqCUTnAS+uxvsmLidICYafpi4LSiDBICV8t9QJw6p
         zlCLQR+eOpLMklsZCkSLfJW4+asZwfYMBBuOjpBJZ3b0qdD3+l6H5G41Lgtz9u55nDYb
         VLqDEjRquO9J7W9I0nIu47uRMx6Izzseo6ndfOW2ewixiO2au648Dc4pa8snVw27Y1DV
         0W/w==
X-Forwarded-Encrypted: i=1; AJvYcCU+HReLIPBPvYQtQIo64QY8dmdNqTm6h7KRgcOgx2h0l8iOtOmXF9g905U+6d5SmvvY8mcVFEN1X7AfS2MvFbMlZ47h
X-Gm-Message-State: AOJu0YxjhPvANR+9MEbOPk/ntL6sS1W+30Ro+E7CSugosewXc3MsuxJI
	JWzamMD7wtfOahTS/MB0fghG247DphIX0nUa8vyi/mOxkoNJy5jMD43MnyYmW6gSwcrsadLA/xm
	4kP0ycVEui3nAJ6jZkJSCWvy9GIxNF01Q6yhMhE5ibj8gUUGOHg==
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180585e87.11.1723453591584;
        Mon, 12 Aug 2024 02:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDiJnYt6CnszI4XqFKJUcy5IhAQ8K4wWN1bwE7aP4/eaq/ZWMytHZunrBfn3on4sNHZzKmPw==
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180540e87.11.1723453590576;
        Mon, 12 Aug 2024 02:06:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:d1a0:5d86:9899:95ec:4118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea09sm6908779f8f.71.2024.08.12.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:06:29 -0700 (PDT)
Date: Mon, 12 Aug 2024 05:06:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	virtualization@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>,
	syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix recursive ->recvmsg calls
Message-ID: <20240812050620-mutt-send-email-mst@kernel.org>
References: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812022153.86512-1-xiyou.wangcong@gmail.com>

On Sun, Aug 11, 2024 at 07:21:53PM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After a vsock socket has been added to a BPF sockmap, its prot->recvmsg
> has been replaced with vsock_bpf_recvmsg(). Thus the following
> recursiion could happen:
> 
> vsock_bpf_recvmsg()
>  -> __vsock_recvmsg()
>   -> vsock_connectible_recvmsg()
>    -> prot->recvmsg()
>     -> vsock_bpf_recvmsg() again
> 
> We need to fix it by calling the original ->recvmsg() without any BPF
> sockmap logic in __vsock_recvmsg().
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h    |  4 ++++
>  net/vmw_vsock/af_vsock.c  | 50 +++++++++++++++++++++++----------------
>  net/vmw_vsock/vsock_bpf.c |  4 ++--
>  3 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 535701efc1e5..24d970f7a4fa 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -230,8 +230,12 @@ struct vsock_tap {
>  int vsock_add_tap(struct vsock_tap *vt);
>  int vsock_remove_tap(struct vsock_tap *vt);
>  void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
> +int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +				int flags);
>  int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			      int flags);
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags);
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 4b040285aa78..0ff9b2dd86ba 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1270,25 +1270,28 @@ static int vsock_dgram_connect(struct socket *sock,
>  	return err;
>  }
>  
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
> +	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +}
> +
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags)
>  {
>  #ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
>  	const struct proto *prot;
> -#endif
> -	struct vsock_sock *vsk;
> -	struct sock *sk;
>  
> -	sk = sock->sk;
> -	vsk = vsock_sk(sk);
> -
> -#ifdef CONFIG_BPF_SYSCALL
>  	prot = READ_ONCE(sk->sk_prot);
>  	if (prot != &vsock_proto)
>  		return prot->recvmsg(sk, msg, len, flags, NULL);
>  #endif
>  
> -	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +	return __vsock_dgram_recvmsg(sock, msg, len, flags);
>  }
>  EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>  
> @@ -2174,15 +2177,12 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>  }
>  
>  int
> -vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> -			  int flags)
> +__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			    int flags)
>  {
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	const struct vsock_transport *transport;
> -#ifdef CONFIG_BPF_SYSCALL
> -	const struct proto *prot;
> -#endif
>  	int err;
>  
>  	sk = sock->sk;
> @@ -2233,14 +2233,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_BPF_SYSCALL
> -	prot = READ_ONCE(sk->sk_prot);
> -	if (prot != &vsock_proto) {
> -		release_sock(sk);
> -		return prot->recvmsg(sk, msg, len, flags, NULL);
> -	}
> -#endif
> -
>  	if (sk->sk_type == SOCK_STREAM)
>  		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>  	else
> @@ -2250,6 +2242,22 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	release_sock(sk);
>  	return err;
>  }
> +
> +int
> +vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			  int flags)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
> +	const struct proto *prot;
> +
> +	prot = READ_ONCE(sk->sk_prot);
> +	if (prot != &vsock_proto)
> +		return prot->recvmsg(sk, msg, len, flags, NULL);
> +#endif
> +
> +	return __vsock_connectible_recvmsg(sock, msg, len, flags);
> +}
>  EXPORT_SYMBOL_GPL(vsock_connectible_recvmsg);
>  
>  static int vsock_set_rcvlowat(struct sock *sk, int val)
> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index a3c97546ab84..c42c5cc18f32 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -64,9 +64,9 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
>  	int err;
>  
>  	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> -		err = vsock_connectible_recvmsg(sock, msg, len, flags);
> +		err = __vsock_connectible_recvmsg(sock, msg, len, flags);
>  	else if (sk->sk_type == SOCK_DGRAM)
> -		err = vsock_dgram_recvmsg(sock, msg, len, flags);
> +		err = __vsock_dgram_recvmsg(sock, msg, len, flags);
>  	else
>  		err = -EPROTOTYPE;
>  
> -- 
> 2.34.1


