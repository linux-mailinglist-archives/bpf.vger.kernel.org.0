Return-Path: <bpf+bounces-45328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ACB9D476D
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67972B20952
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A11C75F9;
	Thu, 21 Nov 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+TFzSjn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFA019CCFC;
	Thu, 21 Nov 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732169243; cv=none; b=Jknl483q0nwf1La/fxCyu8rrGAl1xN1lra6bllP81CpkYOSR9rVZsvDwG5OVL1qe9pOvsgY9UQEpiTLZL1bBG/vQW20z53FJ5TTIXKMLa3JOiM7CO9EP8GHghNcZniDQOMLXQR4zjbw+vgr692B4kLmxkglDeAQNs3+JfK5+RgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732169243; c=relaxed/simple;
	bh=HNcWevmyjvD6PUWYzF/nuFfQrIXVqRFWbTp/qbXXJy4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VUVxF00Ah9MwqmJ05NSHp1hILsWmkCdOnBoetWk0NrjRzV8cIvB5xRyTSfwlrEgW990a2g8+C+AMtYIrkKPucwRqYmdoRBG27mUdBmO1Di63fOXh4cz97UZdS7afpOb42M7aFfKvztMUUAi2yBhder84ly0H3ws8i3AtsX7w5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+TFzSjn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1308188a12.1;
        Wed, 20 Nov 2024 22:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732169241; x=1732774041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+d8yjjDtwsbo5Fny4q4OpwEW4wZnjIwS92lZ/6zcjg=;
        b=G+TFzSjnAjbjON8ZmyBQOOh9ZlNpodU3XxIg7mkq/cBnqoXL1oZEgIMq8BMwg9jhDN
         yhRYM9iyB2Is6ZaVMwS5VJu80y1vpoLMjiMf99Dkm8PgZL3V9yjapU18yVEtth1bhA0I
         yS6LyYKEGjjrvMIuHLx//DP5t0KIt9jjXIpzG21etr1U9eAZLIOhstoDzpYwJCdQVb0W
         7hEnYrTsCFkc8oB+X2o6w8nPSRhm4wLEsu06QDUCx2jHa6zTQpsbTltLF2u0Kc2cfQAc
         chy67q6UZMnXTBWfA3E83kO2V9RCEPt+b6cCId35upfekRIvnBeoVeVApYbE03pYTxok
         VrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732169241; x=1732774041;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+d8yjjDtwsbo5Fny4q4OpwEW4wZnjIwS92lZ/6zcjg=;
        b=trQ3i2mSC87zIsLZ0s8CabmHZx4ykjINJSsBWuyhH38m6/ajjaQjff62GnuJAOZJp3
         lAF524ketSUPtElC6MUM2zk1QW4kxcQdgsB+4I9p8SUU33xoSfEYCNuPxBFC1cdOSnEH
         W7Vib2N4gBIxkCcWFvDQNd8TxwbWhB9Ehstwlk0H8mfQG2fYmJd3MVgOrY/YJm+6cvl9
         sqq/4cYQN8dMRkcpAEwUGX37rReFZ7JyGE9n/0D4h/eGQV1CX68mdMM+27ctB2RZQVfU
         94EYu7Xo99M8xkqLx3xVE/wqd6Gou6wIR5EUlRCOpz6pHWpNUA/Aq8qwLDSUEANPLn6s
         yH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6lLvR4X6GNBGIXlxXS4FuHO9seWiQ3WlGIaj5LpffafhYMKOJJbV04bLheBgRCxhKK0Rnh1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLI84ydP3BLz1WKtqhYphDhC/ipIbPT6XeXdaqTA6TEV210gq
	xI1R6qkX2tAzKlXT7uNzyRZyIX9+yIOWqvRoVEqoAIp54++1AzSG
X-Google-Smtp-Source: AGHT+IGc2l0NbyejoOL0VG3q9BRM3lv5Rr4EZDlw52WZAzOoy5S4jZjjTzlxGoX8E/MK27qFuVysJg==
X-Received: by 2002:a05:6a20:728d:b0:1cf:2d22:564e with SMTP id adf61e73a8af0-1df9c805ba5mr3307989637.6.1732169241407;
        Wed, 20 Nov 2024 22:07:21 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb65a2380sm544007a12.74.2024.11.20.22.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:07:20 -0800 (PST)
Date: Wed, 20 Nov 2024 22:07:19 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 cong.wang@bytedance.com
Message-ID: <673ece17df5d6_157a20815@john.notmuch>
In-Reply-To: <1016b317-d521-4787-80dc-3b92320f2d19@bytedance.com>
References: <20241017005742.3374075-1-zijianzhang@bytedance.com>
 <20241017005742.3374075-3-zijianzhang@bytedance.com>
 <Zy2N48atzfYYTY6X@pop-os.localdomain>
 <1016b317-d521-4787-80dc-3b92320f2d19@bytedance.com>
Subject: Re: [External] Re: [PATCH bpf 2/2] tcp_bpf: add sk_rmem_alloc related
 logic for ingress redirection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zijian Zhang wrote:
> 
> On 11/7/24 8:04 PM, Cong Wang wrote:
> > On Thu, Oct 17, 2024 at 12:57:42AM +0000, zijianzhang@bytedance.com wrote:
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> Although we sk_rmem_schedule and add sk_msg to the ingress_msg of sk_redir
> >> in bpf_tcp_ingress, we do not update sk_rmem_alloc. As a result, except
> >> for the global memory limit, the rmem of sk_redir is nearly unlimited.
> >>
> >> Thus, add sk_rmem_alloc related logic to limit the recv buffer.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> ---
> >>   include/linux/skmsg.h | 11 ++++++++---
> >>   net/core/skmsg.c      |  6 +++++-
> >>   net/ipv4/tcp_bpf.c    |  4 +++-
> >>   3 files changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> >> index d9b03e0746e7..2cbe0c22a32f 100644
> >> --- a/include/linux/skmsg.h
> >> +++ b/include/linux/skmsg.h
> >> @@ -317,17 +317,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
> >>   	kfree_skb(skb);
> >>   }
> >>   
> >> -static inline void sk_psock_queue_msg(struct sk_psock *psock,
> >> +static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> >>   				      struct sk_msg *msg)
> >>   {
> >> +	bool ret;
> >> +
> >>   	spin_lock_bh(&psock->ingress_lock);
> >> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> >> +	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
> >>   		list_add_tail(&msg->list, &psock->ingress_msg);
> >> -	else {
> >> +		ret = true;
> >> +	} else {
> >>   		sk_msg_free(psock->sk, msg);
> >>   		kfree(msg);
> >> +		ret = false;
> >>   	}
> >>   	spin_unlock_bh(&psock->ingress_lock);
> >> +	return ret;
> >>   }
> >>   
> >>   static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
> >> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >> index b1dcbd3be89e..110ee0abcfe0 100644
> >> --- a/net/core/skmsg.c
> >> +++ b/net/core/skmsg.c
> >> @@ -445,8 +445,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >>   			if (likely(!peek)) {
> >>   				sge->offset += copy;
> >>   				sge->length -= copy;
> >> -				if (!msg_rx->skb)
> >> +				if (!msg_rx->skb) {
> >>   					sk_mem_uncharge(sk, copy);
> >> +					atomic_sub(copy, &sk->sk_rmem_alloc);
> >> +				}
> >>   				msg_rx->sg.size -= copy;
> >>   
> >>   				if (!sge->length) {
> >> @@ -772,6 +774,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
> >>   
> >>   	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
> >>   		list_del(&msg->list);
> >> +		if (!msg->skb)
> >> +			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
> >>   		sk_msg_free(psock->sk, msg);
> > 
> > Why not calling this atomic_sub() in sk_msg_free_elem()?
> > 
> > Thanks.
> 
> sk_msg_free_elem called by sk_msg_free or sk_msg_free_no_charge will
> be invoked in multiple locations including TX/RX/Error and etc.
> 
> We should call atomic_sub(&sk->sk_rmem_alloc) for sk_msgs that have
> been atomic_add before. In other words, we need to call atomic_sub
> only for sk_msgs in ingress_msg.
> 
> As for "!msg->skb" check here, I want to make sure the sk_msg is not
> from function sk_psock_skb_ingress_enqueue, because these sk_msgs'
> rmem accounting has already handled by skb_set_owner_r in function
> sk_psock_skb_ingress.
> 

Assuming I read above correct this is only an issue when doing a
redirect to ingress of a socket? The other path where we do a
SK_PASS directly from the verdict to hit the ingress of the
current socket is OK because all account is done already through
skb. Basically that is what the above explanation for !msg->skb
is describing?

Can we add this to the description so we don't forget it and/or
have to look up the mailing list in the future.

Thanks,
John

