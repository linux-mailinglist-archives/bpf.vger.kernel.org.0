Return-Path: <bpf+bounces-78096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02186CFF65E
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31B083001622
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0133E36F;
	Wed,  7 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TP/eXHNw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468A33E347
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795836; cv=none; b=LQW+pDoQnXDucQdlkWtjqCIHEmn4uRbKDlkDMnbGN9444NfW/j33ya+ZHmYUZfB3f/eFNJNF4kK7NNus5YEcUYdovOMaFX6fl9ygIQ9Dx9E2e6knIG7JYc+jOY7qljCWaorQhIIZ7MZUdeP2g1sjMBz1kJ6PX0kVrtqGJROpRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795836; c=relaxed/simple;
	bh=a8vDcpbPYMfbNysE7qf6k6fF4jGeW3i+glF02ZVNNhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pz3yrUtfz23TvjGnvwzYaa9871rmpzxDK8l4Jn+Bj07e8figGuYHXToI4xJp6lY9llQwJnXUQ4NfOQA0hR1AaVn3fvFfwIR1fu4MGg3bYFjLq9d6050Zw0H+IY2zdoa4/dB3k4tUuccryQwvqOkV1kcdkRVuMZIOv/EBll6+l20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TP/eXHNw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so2942180a12.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767795832; x=1768400632; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBVMBb/APMLSOerd9JPa7bBGnobTH7lXEbSuGohgvIA=;
        b=TP/eXHNwpgZvLQ9l77YQjZBya+B/7bsYdALv1HLBTbDzb9onGIya4yJYZbdKX7ob6o
         jEhgJSrvI0ZmIFVCb5gGooZnlPf0OSD8sxvnRHUChpyzAvkLHcWMJO96ml+NHTsou3Z3
         09nuIGNviVakE45u3Q5fK2sZ+ZlFSnSrjlDlf51cxdjLCk0ulPNFOvB7RNzQsyu+FAXV
         KtlokiofBPoLCGKP0SlNOzzV5X4HuHAeHcbvOLHd1f4uIBHTzIV1fpV1lBdZckG8g0XM
         2uf98hD5mAYIK/vpuPeqc7ATVut4ZIzZXSL8Xw07aQ6Uo1bjxs/AResPWpEAti/xWeWu
         ax6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795832; x=1768400632;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBVMBb/APMLSOerd9JPa7bBGnobTH7lXEbSuGohgvIA=;
        b=v5RBnCfWKZivvHYOBez18b1gxPV2yu6q4jpvWPoZv2Dq4wq1YTICFZsH0p3roXwT4f
         SzLQHnA4jfGFcrFSDtL6H5Rxz+WA5lPZLSMYpeY0EFDaC+8kFZPwkr4e5jKMVtn18NAp
         sqO8Gc2bqUq7lNdyXX2mCo2WSrC7WSdhBciNm2Zw7EfUFeOxnp778gPEnV3uuXyRA1KF
         Ra5lPKnBmhaM+GFOEpwazdxEGjwhFYJzRAHuNtAeMbVBDUrXezVNc0tDhts7xDXcleBX
         O1GldAbDdRXR/hXNDiqW1Ex6QG2J+prTqdp7XrYWOyPVwuG8R4M8bsxRZ2NbNB98wnUb
         cCgA==
X-Gm-Message-State: AOJu0Yyd1u1TiuijWqAadpLjM4ggZrNnkZwtRQ/yEqlx+Uz/SN4jMRZC
	hCpigGdQ/Y9MBjLydQfabueOihOc4KOLftNCprff+VUyvccVJeMBa1u1mcOPss0hLEk=
X-Gm-Gg: AY/fxX6C2J4IrjBEJ7Zfvg+1uloQcXC5egyL7Klgtq9jq+GXdSG7JS/hQ0BOqP7zcSF
	PrrTFPb7wxi+hthtqSb1uhFZQ9wBYcpgEqeZTOiCptw66qsfSf/jZM2vWzQD129V5IuVBq67LVd
	ji/+2gLkKIa91g7rUy0I670W4Ti3TdRC5j9Ih4H966Nk/qTPzaOzyp66YswGtroeEdWvPOZIlJq
	qK2rsT32ofdl6Y5jzEs96Mv5kxAKGJDdVcOiU//018aQREJ//XZYA1mUJZgDXYwEtLgD78e10mb
	zpnyqV1QhkvsLwHCbR/n92klqNlsMBqJFP2tQoH0XYxmnfIgUQwyNTfMBA3OlxEbgPvi0xUGAwa
	clvb+2hIIctjc8cyXehnahR3lP7g3GRalxgSPW0f2J6BNC2JbFsF/9R8bKUELKU8YYCVIb+b4sn
	4tn7tFn4z8/oSy7HxDKvzaUihYcsb6TugB2yE4ivAVgwU/VaysGBba7yiMBHs=
X-Google-Smtp-Source: AGHT+IHC3TOcqtbVoxe1Wynwn2n01sOMbR1eyayRz1nHq97srelpzusiLnmdeLMvuwyovffayj+MRA==
X-Received: by 2002:aa7:d710:0:b0:649:b4d8:7946 with SMTP id 4fb4d7f45d1cf-65097e5d9e2mr1891900a12.23.1767795832061;
        Wed, 07 Jan 2026 06:23:52 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4454sm4857073a12.3.2026.01.07.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:23:51 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Stefano Garzarella <sgarzare@redhat.com>,  Michal
 Luczaj <mhal@rbox.co>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <20260106051458.279151-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 6 Jan 2026 13:14:28 +0800")
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
	<20260106051458.279151-3-jiayuan.chen@linux.dev>
Date: Wed, 07 Jan 2026 15:23:50 +0100
Message-ID: <87ikddijrd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 06, 2026 at 01:14 PM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new ingress_size field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations. While Unix
> and VSOCK also support sockmap and have similar FIONREAD calculation
> issues, fixing them would require more extensive changes
> (please let me know if modifications are needed). I believe it's not
> appropriate to include those changes under this fix patch.

Nit: These last two lines don't really belong in the commit message.
Side notes for reviewers can be added after the "---" marker.

> Previous work by John Fastabend made some efforts towards FIONREAD support:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastabend,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                      FD1:read()
>                                                      --  FD1->copied_seq++
>                                                          |  [read data]
>                                                          |
>                                 [enqueue data]           v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h | 67 +++++++++++++++++++++++++++++++++++++++++--
>  net/core/skmsg.c      |  3 ++
>  net/ipv4/tcp_bpf.c    | 21 ++++++++++++++
>  net/ipv4/udp_bpf.c    | 25 +++++++++++++---
>  4 files changed, 110 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 0323a2b6cf5e..1fa03953043f 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -97,6 +97,7 @@ struct sk_psock {
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
>  	spinlock_t			ingress_lock;
> +	ssize_t				ingress_size;

The name is not great because we also already have `ingress_bytes`.
I suggest to rename and add a doc string. Also we don't expect the count
to ever be negative. Why ssize_t when we store all other byte counts
there as u32?

        /** @msg_tot_len: Total bytes queued in ingress_msg list. */
        u32                             msg_tot_len;

>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;
> @@ -321,6 +322,27 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>  
> +static inline ssize_t sk_psock_get_msg_size_nolock(struct sk_psock *psock)
> +{
> +	/* Used by ioctl to read ingress_size only; lock-free for performance */
> +	return READ_ONCE(psock->ingress_size);
> +}
> +
> +static inline void sk_psock_inc_msg_size_locked(struct sk_psock *psock, ssize_t diff)
> +{
> +	/* Use WRITE_ONCE to ensure correct read in sk_psock_get_msg_size_nolock().
> +	 * ingress_lock should be held to prevent concurrent updates to ingress_size
> +	 */
> +	WRITE_ONCE(psock->ingress_size, psock->ingress_size + diff);
> +}
> +
> +static inline void sk_psock_inc_msg_size(struct sk_psock *psock, ssize_t diff)

Not sure about this function name. "inc" usually means increment by one.
Was that modeled after some existing interface?

If not, I'd switch rename to sk_psock_msg_len_add(..., int delta)

Following the naming convention from sk_forward_alloc_add(),
skb_frag_size_add(), skb_len_add(), etc.

> +{
> +	spin_lock_bh(&psock->ingress_lock);
> +	sk_psock_inc_msg_size_locked(psock, diff);
> +	spin_unlock_bh(&psock->ingress_lock);
> +}
> +
>  static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> @@ -329,6 +351,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  	spin_lock_bh(&psock->ingress_lock);
>  	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		list_add_tail(&msg->list, &psock->ingress_msg);
> +		sk_psock_inc_msg_size_locked(psock, msg->sg.size);
>  		ret = true;
>  	} else {
>  		sk_msg_free(psock->sk, msg);
> @@ -345,18 +368,25 @@ static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
>  
>  	spin_lock_bh(&psock->ingress_lock);
>  	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> -	if (msg)
> +	if (msg) {
>  		list_del(&msg->list);
> +		sk_psock_inc_msg_size_locked(psock, -msg->sg.size);
> +	}
>  	spin_unlock_bh(&psock->ingress_lock);
>  	return msg;
>  }
>  
> +static inline struct sk_msg *sk_psock_peek_msg_locked(struct sk_psock *psock)
> +{
> +	return list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +}
> +
>  static inline struct sk_msg *sk_psock_peek_msg(struct sk_psock *psock)
>  {
>  	struct sk_msg *msg;
>  
>  	spin_lock_bh(&psock->ingress_lock);
> -	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +	msg = sk_psock_peek_msg_locked(psock);
>  	spin_unlock_bh(&psock->ingress_lock);
>  	return msg;
>  }
> @@ -523,6 +553,39 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
>  	return !!psock->saved_data_ready;
>  }
>  
> +/* for tcp only, sk is locked */
> +static inline ssize_t sk_psock_msg_inq(struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		inq = sk_psock_get_msg_size_nolock(psock);
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}
> +
> +/* for udp only, sk is not locked */
> +static inline ssize_t sk_msg_first_length(struct sock *sk)

s/_length/_len/

> +{
> +	struct sk_psock *psock;
> +	struct sk_msg *msg;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		spin_lock_bh(&psock->ingress_lock);
> +		msg = sk_psock_peek_msg_locked(psock);
> +		if (msg)
> +			inq = msg->sg.size;
> +		spin_unlock_bh(&psock->ingress_lock);
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}
> +
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
>  
>  #define BPF_F_STRPARSER	(1UL << 1)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index d73e03f7713a..c959d52a62b2 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -455,6 +455,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
>  					atomic_sub(copy, &sk->sk_rmem_alloc);
>  				}
>  				msg_rx->sg.size -= copy;
> +				sk_psock_inc_msg_size(psock, -copy);
>  
>  				if (!sge->length) {
>  					sk_msg_iter_var_next(i);
> @@ -819,9 +820,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  		list_del(&msg->list);
>  		if (!msg->skb)
>  			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
> +		sk_psock_inc_msg_size(psock, -((ssize_t)msg->sg.size));

Cast won't be needed after you switch param type to `int`.

>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
>  	}
> +	WARN_ON_ONCE(psock->ingress_size);
>  }
>  
>  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 6332fc36ffe6..a9c758868f13 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -10,6 +10,7 @@
>  
>  #include <net/inet_common.h>
>  #include <net/tls.h>
> +#include <asm/ioctls.h>
>  
>  void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -332,6 +333,25 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	return copied;
>  }
>  
> +static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	bool slow;
> +
> +	/* we only care about FIONREAD */

Nit: This comment seems redundant. The expression is obvious.

> +	if (cmd != SIOCINQ)
> +		return tcp_ioctl(sk, cmd, karg);
> +
> +	/* works similar as tcp_ioctl */
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -EINVAL;
> +
> +	slow = lock_sock_fast(sk);
> +	*karg = sk_psock_msg_inq(sk);
> +	unlock_sock_fast(sk, slow);
> +
> +	return 0;
> +}
> +
>  static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			   int flags, int *addr_len)
>  {
> @@ -610,6 +630,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
>  	prot[TCP_BPF_BASE].close		= sock_map_close;
>  	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
>  	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
> +	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
>  
>  	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
>  	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 0735d820e413..cc1156aef14d 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -5,6 +5,7 @@
>  #include <net/sock.h>
>  #include <net/udp.h>
>  #include <net/inet_common.h>
> +#include <asm/ioctls.h>
>  
>  #include "udp_impl.h"
>  
> @@ -111,12 +112,28 @@ enum {
>  static DEFINE_SPINLOCK(udpv6_prot_lock);
>  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
>  
> +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	/* we only care about FIONREAD */
> +	if (cmd != SIOCINQ)
> +		return udp_ioctl(sk, cmd, karg);
> +
> +	/* works similar as udp_ioctl.
> +	 * man udp(7): "FIONREAD (SIOCINQ): Returns the size of the next
> +	 * pending datagram in the integer in bytes, or 0 when no datagram
> +	 * is pending."
> +	 */

Not sure we need to quote man pages here.

> +	*karg = sk_msg_first_length(sk);
> +	return 0;
> +}
> +
>  static void udp_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
>  {
> -	*prot        = *base;
> -	prot->close  = sock_map_close;
> -	prot->recvmsg = udp_bpf_recvmsg;
> -	prot->sock_is_readable = sk_msg_is_readable;
> +	*prot			= *base;
> +	prot->close		= sock_map_close;
> +	prot->recvmsg		= udp_bpf_recvmsg;
> +	prot->sock_is_readable	= sk_msg_is_readable;
> +	prot->ioctl		= udp_bpf_ioctl;
>  }
>  
>  static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)

