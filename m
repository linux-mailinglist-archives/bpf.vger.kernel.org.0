Return-Path: <bpf+bounces-47253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829719F6A21
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E8C16AAB6
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F115534B;
	Wed, 18 Dec 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BullUZBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843D1C2335
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536159; cv=none; b=S7Xmyap6VxBzZ7LGDJIG3uVVE/ORgT8nOpXTpfe2uXlCFqewAsMStpAyLuwo9Ph93oiWP5GZe1GhewgjKX81j3epFKXmhyL9kx2TZrkWN2TfxZjcRjepGHyEAgxKHnrFiRQDLM+wfN3O44LSzEQg/915v/EwOy3a1lchOJ4yD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536159; c=relaxed/simple;
	bh=tWJEK+8z1pKSl1RNBeNZt0HsSPsk/wkGgEmZK+I59f8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMyQhHEITUx1xRtv3e8uTcwlch5V01c51PBeyPvtMl/mzjRYycii5G6enrILLYu6y7nsN4rrmHGagpLx5hddMteFhJposrrqWBjiHrN7mCKYlN/yKHX1fDg7N2AD+S6tiONf2xL+a5glLZeesaN+g/ZmeJDk3HBNIoZnrqFHm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BullUZBB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso979197866b.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734536156; x=1735140956; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAapKQ1I7V6uytOkcP7xjeMeeEYj8q/PhY1bvR8ANNg=;
        b=BullUZBBn0i1kigE7yv8TT6aKBxKYNzDJVqni1nWmfTfwi+3gTPGV+ndhy5s1cNdP8
         zFWFynUQ55zoeB/bhshvFQkfPwgGQ8Yg+VZYaHLo96TZZ6QRlxHRAm+yGoE9n2ncA6Ln
         vh65jAXvcx/z1tSD3+ZbxJbu3JOSQy/krnzHvMl5uEaAUfLs+KfuS7wMLq+pq2rdOiim
         pX1LKaWtovw6vXLyQStOzBoOsdK4WyFQkL9Vr0muI+izv9xnL011FDcF4Tg9JfuK39LV
         Kz5BQ3/o8YhzZn6hOzHEcW+V24iWlzQeRlXjMNFN+uO/HE0cVs/xGLOnzrIxoUb+4Ul4
         TFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734536156; x=1735140956;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAapKQ1I7V6uytOkcP7xjeMeeEYj8q/PhY1bvR8ANNg=;
        b=fWhM8UcHUJqD2K9rpUNslSH/XF5ChlaHMrup8NdM7Evnjq96zPNFRJtBBabAFW6CP3
         O6LDClB98Yv/A45Bb6VA3ddeZrqFRBrjbCRfPpu4APeIwZFoaN5VO9UHMcNE7/fPr9LV
         zqwJdb2TzU9NogTVAchHqEtWtP8LchTaglJIjMvyHc0bnvm2BwX6kVqlQZPoF0T7gSvC
         tD/vYzkaVFcOhBVUtAX4UdzfoWeZ4vhFJaBYPpmLpLL0AHWMPKRPrh3Pi8zAhB4EH+/H
         aMidZbb5pSlYYOetiTU87mmUt3zi4UQdZe8YfRyXIHUAfPr53ownHItm/esF051x1Odw
         LR1A==
X-Gm-Message-State: AOJu0YxUqI0G05xTp3PGqR3wgcnpyF7zCgM1ceJDuUhaY2rGadaxiu5T
	QGyD/COBCcv4eIjimUZySuLFNWMKHvNP+uE2VmrTdN6i41uq9UD9Jw1Y93/vtQM=
X-Gm-Gg: ASbGncs75vR+NHwLtEs/A0r0d7lDsUq17BE2gAXwk47Io1nv7H1m/aQH8OVIRDZWwJf
	pIGjk2frzZbFQF5twn/pbsAuPltarvWNIvvo43oogZAXJT4ZfBKQy0JbvLPSYiBYW32uhgh13By
	7DOmY6/cm/J6OfbUkgbVgaEuA3NTgL3Co7hoITGWlUFgGZzf6ejkZPV47NT3e9VUbcSWnL18/Is
	c/BwfQPdU62cTY427+60rIXzChCFJsLe1aJ8EkuaA4g3+PMsQ==
X-Google-Smtp-Source: AGHT+IFWxaOp6gjQWNhTROZA8sKThUw4y9c0hEqFhujPDugHiwwtg+lSOqcj1TQMOFbKOfTw9NlS0g==
X-Received: by 2002:a17:906:4c9:b0:aa6:7df0:b179 with SMTP id a640c23a62f3a-aabf4771d04mr266919566b.22.1734536155807;
        Wed, 18 Dec 2024 07:35:55 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:9b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635994csm565126166b.121.2024.12.18.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:35:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  martin.lau@linux.dev,  ast@kernel.org,
  edumazet@google.com,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  song@kernel.org,  john.fastabend@gmail.com,  andrii@kernel.org,
  mhal@rbox.co,  yonghong.song@linux.dev,  daniel@iogearbox.net,
  xiyou.wangcong@gmail.com,  horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
In-Reply-To: <20241218053408.437295-2-mrpre@163.com> (Jiayuan Chen's message
	of "Wed, 18 Dec 2024 13:34:07 +0800")
References: <20241218053408.437295-1-mrpre@163.com>
	<20241218053408.437295-2-mrpre@163.com>
Date: Wed, 18 Dec 2024 16:35:53 +0100
Message-ID: <87jzbxvw9y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 18, 2024 at 01:34 PM +08, Jiayuan Chen wrote:
> 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> It works for a single stream_verdict scenario, as it also modified
> 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> Modifying tcp_read_sock() or strparser implementation directly is
> unreasonable, as it is widely used in other modules.
>
> Here, we introduce a method tcp_bpf_read_sock() to replace
> 'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
> tls_main.c). Such replacement action was also used in updating
> tcp_bpf_prots in tcp_bpf.c, so it's not weird.
> (Note that checkpatch.pl may complain missing 'const' qualifier when we
> define the bpf-specified 'proto_ops', but we have to do because we need
> update it).
>
> Also we remove strparser check in tcp_eat_skb() since we implement custom
> function tcp_bpf_read_sock() without copied_seq updating.
>
> Since strparser currently supports only TCP, it's sufficient for 'ops' to
> inherit inet_stream_ops.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  include/linux/skmsg.h |   2 +
>  include/net/tcp.h     |   1 +
>  net/core/skmsg.c      |   3 ++
>  net/ipv4/tcp.c        |   2 +-
>  net/ipv4/tcp_bpf.c    | 108 ++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 112 insertions(+), 4 deletions(-)

[...]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 99cef92e6290..4a089afc09b7 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -19,9 +19,6 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>  	if (!skb || !skb->len || !sk_is_tcp(sk))
>  		return;
>  
> -	if (skb_bpf_strparser(skb))
> -		return;
> -
>  	tcp = tcp_sk(sk);
>  	copied = tcp->copied_seq + skb->len;
>  	WRITE_ONCE(tcp->copied_seq, copied);
> @@ -578,6 +575,81 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	return copied > 0 ? copied : err;
>  }
>  
> +static void sock_replace_proto_ops(struct sock *sk,
> +				   const struct proto_ops *proto_ops)
> +{
> +	if (sk->sk_socket)
> +		WRITE_ONCE(sk->sk_socket->ops, proto_ops);
> +}
> +
> +/* The tcp_bpf_read_sock() is an alternative implementation
> + * of tcp_read_sock(), except that it does not update copied_seq.
> + */
> +static int tcp_bpf_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			     sk_read_actor_t recv_actor)
> +{
> +	struct sk_psock *psock;
> +	struct sk_buff *skb;
> +	int offset;
> +	int copied = 0;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -ENOTCONN;
> +
> +	/* we are called from sk_psock_strp_data_ready() and
> +	 * psock has already been checked and can't be NULL.
> +	 */
> +	psock = sk_psock_get(sk);
> +	/* The offset keeps track of how much data was processed during
> +	 * the last call.
> +	 */
> +	offset = psock->strp_offset;
> +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> +		u8 tcp_flags;
> +		int used;
> +		size_t len;
> +
> +		len = skb->len - offset;
> +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +		used = recv_actor(desc, skb, offset, len);
> +		if (used <= 0) {
> +			/* None of the data in skb has been consumed.
> +			 * May -ENOMEM or other error happened
> +			 */
> +			if (!copied)
> +				copied = used;
> +			break;
> +		}
> +
> +		if (WARN_ON_ONCE(used > len))
> +			used = len;
> +		copied += used;
> +		if (used < len) {
> +			/* Strparser clone and consume all input skb except
> +			 * -ENOMEM happened and it will replay skb by it's
> +			 * framework later. So We need to keep offset and
> +			 * skb for next retry.
> +			 */
> +			offset += used;
> +			break;
> +		}
> +
> +		/* Entire skb was consumed, and we don't need this skb
> +		 * anymore and clean the offset.
> +		 */
> +		offset = 0;
> +		tcp_eat_recv_skb(sk, skb);
> +		if (!desc->count)
> +			break;
> +		if (tcp_flags & TCPHDR_FIN)
> +			break;
> +	}
> +
> +	WRITE_ONCE(psock->strp_offset, offset);
> +	return copied;
> +}
> +
>  enum {
>  	TCP_BPF_IPV4,
>  	TCP_BPF_IPV6,

[...]

To reiterate my earlier question / suggestion [1] - it would be great if
we can avoid duplicating what tcp_read_skb / tcp_read_sock already do.

Keeping extra state in sk_psock / strparser seems to be the key. I think
you should be able to switch strp_data_ready / str_read_sock to
->read_skb and make an adapter around strp_recv.

Rough code below is what I have in mind. Not tested, compiled
only. Don't expect it to work. And I haven't even looked how to address
the kTLS path. But you get the idea.

[1] https://msgid.link/87o71bx1l4.fsf@cloudflare.com

---8<---

diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0dd48c1bc23b 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -95,9 +95,14 @@ struct strparser {
 	u32 interrupted : 1;
 	u32 unrecov_intr : 1;
 
+	unsigned int need_bytes;
+
 	struct sk_buff **skb_nextp;
 	struct sk_buff *skb_head;
-	unsigned int need_bytes;
+
+	int rcv_err;
+	unsigned int rcv_off;
+
 	struct delayed_work msg_timer_work;
 	struct work_struct work;
 	struct strp_stats stats;
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..8a08996429d3 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -18,6 +18,7 @@
 #include <linux/poll.h>
 #include <linux/rculist.h>
 #include <linux/skbuff.h>
+#include <linux/skmsg.h>
 #include <linux/socket.h>
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
@@ -327,13 +328,39 @@ int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
 }
 EXPORT_SYMBOL_GPL(strp_process);
 
-static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
-		     unsigned int orig_offset, size_t orig_len)
+static int strp_read_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct strparser *strp = (struct strparser *)desc->arg.data;
-
-	return __strp_recv(desc, orig_skb, orig_offset, orig_len,
-			   strp->sk->sk_rcvbuf, strp->sk->sk_rcvtimeo);
+	struct sk_psock *psock = sk_psock_get(sk);
+	struct strparser *strp = &psock->strp;
+	read_descriptor_t desc = {
+		.arg.data = strp,
+		.count = 1,
+		.error = 0,
+	};
+	unsigned int off;
+	size_t len;
+	int used;
+
+	off = strp->rcv_off;
+	len = skb->len - off;
+	used = __strp_recv(&desc, skb, off, len,
+			   sk->sk_rcvbuf, sk->sk_rcvtimeo);
+	/* skb not consumed */
+	if (used <= 0) {
+		strp->rcv_err = used;
+		return used;
+	}
+	/* skb partially consumed */
+	if (used < len) {
+		strp->rcv_err = 0;
+		strp->rcv_off += used;
+		return -EPIPE;	/* stop reading */
+	}
+	/* skb fully consumed */
+	strp->rcv_err = 0;
+	strp->rcv_off = 0;
+	tcp_eat_recv_skb(sk, skb);
+	return used;
 }
 
 static int default_read_sock_done(struct strparser *strp, int err)
@@ -345,21 +372,14 @@ static int default_read_sock_done(struct strparser *strp, int err)
 static int strp_read_sock(struct strparser *strp)
 {
 	struct socket *sock = strp->sk->sk_socket;
-	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
 		return -EBUSY;
 
-	desc.arg.data = strp;
-	desc.error = 0;
-	desc.count = 1; /* give more than one skb per call */
-
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
-
-	desc.error = strp->cb.read_sock_done(strp, desc.error);
+	sock->ops->read_skb(strp->sk, strp_read_skb);
 
-	return desc.error;
+	return strp->cb.read_sock_done(strp, strp->rcv_err);
 }
 
 /* Lower sock lock held */

