Return-Path: <bpf+bounces-16673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2A804344
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DF21C20C1A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4418802;
	Tue,  5 Dec 2023 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0j3Ju91"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D038B109;
	Mon,  4 Dec 2023 16:23:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2776725a12.1;
        Mon, 04 Dec 2023 16:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735820; x=1702340620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBlBHRLoC77S9p08O8sqxBJOBgbNm/0SvRxJBxYrhAk=;
        b=i0j3Ju91+9IWfSGUlJ5k8HC3NXvY75ob69n81N9YoHB+O4PSs4SRUpIWWkpNMNVbSz
         HvLvpxk09wdGw0vDkGPwN6c2N9vkQ5yS4ffQimutmgUzE9ytmSyftc2SqszimQZWS5/6
         vXt7R/O8RFzZKDDmQU4mJAgFZ1bA6dVX7Y39QLKmfH+umHqgbI11IXca1z2xjDB0G9tf
         xah5SWc8QgkaOPXpqc60ej7OrWGrOfRd0RpVJgLMniCTnIS/3O0fOqKGuMmveosFe7Jk
         N3xqKDsOaNJlQGu7q7rYnKQrGzvdilwY1In7lmEw74F5P/V8u1XoP7r+IyuShB9bsUvT
         tcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735820; x=1702340620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HBlBHRLoC77S9p08O8sqxBJOBgbNm/0SvRxJBxYrhAk=;
        b=UI8UB5jR58e9pN8UlAdJIf7yQmYF2bQE8Lub05jxuSEhHKwaLkAhnaoj9McuISwI6M
         YLAKcvZwxCeMsalAnSa7rOOBtf0SblESumNlyCyaQ1GHNCXRN3EiEoluZukxPDDhwC5Y
         oVnsF/3+KfFm9SckfoGQxb7LYiCYenT8R+plPVtRofYnfHbVZiYc9//Qw5kpz+q0kjjn
         JHXc6PHogIs3OUG8KwyaPMeUrolVeUXczT4fd9IFn+T+or1/tZ5vpvkkYnOffE+99FGA
         8l4/aGRBGzIGWkoBLtF3qeQDb5C87kUqt7ugmxqULAnXzCr1mPc5LXNg7lN/muxtsSHj
         GpmA==
X-Gm-Message-State: AOJu0YyLJlr9g+lXRXJDZGEOpn2sHb3PM1CogaqQvWpGlsgk+P2qOaXb
	reE/LPetaj2BS+sLNKaqSdz6I0gy4o94fQ==
X-Google-Smtp-Source: AGHT+IH0FB1lPhJtaLAG7TkNGvlUylGmZaYyv2UkF5UxdPr188zLKdgs4TCFW8JPz9qVXxQigct5ZQ==
X-Received: by 2002:a05:6a20:938e:b0:18f:97c:9775 with SMTP id x14-20020a056a20938e00b0018f097c9775mr7030595pzh.93.1701735820177;
        Mon, 04 Dec 2023 16:23:40 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id be5-20020a656e45000000b005897bfc2ed3sm7011411pgb.93.2023.12.04.16.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:23:39 -0800 (PST)
Date: Mon, 04 Dec 2023 16:23:38 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Pengcheng Yang <yangpc@wangsu.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Message-ID: <656e6d8a5e592_1ee50208e1@john.notmuch>
In-Reply-To: <1700565725-2706-2-git-send-email-yangpc@wangsu.com>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
 <1700565725-2706-2-git-send-email-yangpc@wangsu.com>
Subject: RE: [PATCH bpf-next v2 1/3] skmsg: Support to get the data length in
 ingress_msg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengcheng Yang wrote:
> Currently msg is queued in ingress_msg of the target psock
> on ingress redirect, without increment rcv_nxt. The size
> that user can read includes the data in receive_queue and
> ingress_msg. So we introduce sk_msg_queue_len() helper to
> get the data length in ingress_msg.
> 
> Note that the msg_len does not include the data length of
> msg from recevive_queue via SK_PASS, as they increment rcv_nxt
> when received.
> 
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  include/linux/skmsg.h | 26 ++++++++++++++++++++++++--
>  net/core/skmsg.c      | 10 +++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 

This has two writers under different locks this looks insufficient
to ensure correctness of the counter. Likely the consume can be
moved into where the dequeue_msg happens? But, then its not always
accurate which might break some applications doing buffer sizing.
An example of this would be nginx.

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c1637515a8a4..423a5c28c606 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -47,6 +47,7 @@ struct sk_msg {
>  	u32				apply_bytes;
>  	u32				cork_bytes;
>  	u32				flags;
> +	bool				ingress_self;
>  	struct sk_buff			*skb;
>  	struct sock			*sk_redir;
>  	struct sock			*sk;
> @@ -82,6 +83,7 @@ struct sk_psock {
>  	u32				apply_bytes;
>  	u32				cork_bytes;
>  	u32				eval;
> +	u32				msg_len;
>  	bool				redir_ingress; /* undefined if sk_redir is null */
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
> @@ -311,9 +313,11 @@ static inline void sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
>  	spin_lock_bh(&psock->ingress_lock);
> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> +	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		list_add_tail(&msg->list, &psock->ingress_msg);
> -	else {
> +		if (!msg->ingress_self)
> +			WRITE_ONCE(psock->msg_len, psock->msg_len + msg->sg.size);

First writer here can be from

  sk_psock_backlog()
    mutex_lock(psock->work_mutex)
    ...
    sk_psock_handle_skb()
      sk_psock_skb_ingress()
        sk_psock_skb_ingress_enqueue()
          sk_psock_queue_msg()
             spin_lock_bh(psock->ingress_lock)
               WRITE_ONCE(...)
             spin_unlock_bh()

> +	} else {
>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
>  	}
> @@ -368,6 +372,24 @@ static inline void kfree_sk_msg(struct sk_msg *msg)
>  	kfree(msg);
>  }
>  
> +static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len)
> +{
> +	WRITE_ONCE(psock->msg_len, psock->msg_len - len);
> +}
> +
> +static inline u32 sk_msg_queue_len(const struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	u32 len = 0;
> +
> +	rcu_read_lock();
> +	psock = sk_psock(sk);
> +	if (psock)
> +		len = READ_ONCE(psock->msg_len);
> +	rcu_read_unlock();
> +	return len;
> +}
> +
>  static inline void sk_psock_report_error(struct sk_psock *psock, int err)
>  {
>  	struct sock *sk = psock->sk;
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 6c31eefbd777..f46732a8ddc2 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -415,7 +415,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  	struct iov_iter *iter = &msg->msg_iter;
>  	int peek = flags & MSG_PEEK;
>  	struct sk_msg *msg_rx;
> -	int i, copied = 0;
> +	int i, copied = 0, msg_copied = 0;
>  
>  	msg_rx = sk_psock_peek_msg(psock);
>  	while (copied != len) {
> @@ -441,6 +441,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			}
>  
>  			copied += copy;
> +			if (!msg_rx->ingress_self)
> +				msg_copied += copy;
>  			if (likely(!peek)) {
>  				sge->offset += copy;
>  				sge->length -= copy;
> @@ -481,6 +483,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		msg_rx = sk_psock_peek_msg(psock);
>  	}
>  out:
> +	if (likely(!peek) && msg_copied)
> +		sk_msg_queue_consumed(psock, msg_copied);

Second writer,

   tcp_bpf_recvmsg_parser()
     lock_sock(sk)
     sk_msg_recvmsg()
       sk_psock_peek_msg()
         spin_lock_bh(ingress_lock); <- lock held from first writer.
         msg = list...
         spin_unlock_bh()
       sk_psock_Dequeue_msg(psock)
         spin_lock_bh(ingress_lock)
         msg = ....                     <- should call queue_consumed here
         spin_unlock_bh()

    out:
      if (likely(!peek) && msg_copied)
        sk_msg_queue_consumed(psock, msg_copied); <- here no lock?


It looks like you could move the queue_consumed up into the dequeue_msg,
but then you have some issue on partial reads I think? Basically the
IOCTL might return more bytes than are actually in the ingress queue.
Also it will look strange if the ioctl is called twice once before a read
and again after a read and the byte count doesn't change.

Maybe needs ingress queue lock wrapped around this queue consuned and
leave it where it is? Couple ideas anyways, but I don't think its
correct as is.
       
>  	return copied;
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
> @@ -602,6 +606,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  
>  	if (unlikely(!msg))
>  		return -EAGAIN;
> +	msg->ingress_self = true;
>  	skb_set_owner_r(skb, sk);
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
>  	if (err < 0)
> @@ -771,9 +776,12 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  

purge doesn't use the ingress_lock because its cancelled and syncd the
backlog and proto handlers have been swapped back to original handlers
so there is no longer any way to get at the ingress queue from the socket
side either.

>  	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
>  		list_del(&msg->list);
> +		if (!msg->ingress_self)
> +			sk_msg_queue_consumed(psock, msg->sg.size);
>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
>  	}
> +	WARN_ON_ONCE(READ_ONCE(psock->msg_len) != 0);
>  }
>  
>  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> -- 
> 2.38.1
> 

