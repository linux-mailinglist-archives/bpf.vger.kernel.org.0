Return-Path: <bpf+bounces-47013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A59F28D1
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 04:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF621887695
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FA153BE4;
	Mon, 16 Dec 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK54ucVv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5825760;
	Mon, 16 Dec 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319929; cv=none; b=LNyruoi2A9rJAg1/ltY1HcCOOLjpS3J++DKYPUaS9LdS58WPS/+fm4JyVfC9W49WMhFX1WdBlYjov5AuQyD7+N/w0ldpGMopDUQ91Z54semCkWmJhMXO1Itah2C2XAmEa8pjiqx+cEDdAymjE/yfSYtHrQHHHvzwhjkNGzN6UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319929; c=relaxed/simple;
	bh=S2vQcu2RlyXhfyFLl5hUwkaHAA+c0PBHHGEC+2Ep8F0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PX8Q9y5DC2UvJbKcTd9kis1pHGg0QOE2lFtiRv1mN0gEjETCd4LLb2kaFjw74wW85BX/sa0C6j/GsWEUTpxrGgFf8gpCpcGOo1n5ezBzQhAyINbIekfGvZlCPNL1bhmmT9OXMMzAtHF5VVD5tJDCl+/jxOXzHImQPBKnM5qV/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK54ucVv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2165cb60719so26828865ad.0;
        Sun, 15 Dec 2024 19:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734319927; x=1734924727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNOXfbpXdv41m/bOJkFcObz3huwlsENpJ7Jf000ZPk4=;
        b=ZK54ucVvBmKbylAIVLES0EivGAW3xCm10Av0HfPM3k90Vcy4Cb2ZVzWgIqazXqK0/8
         oRmDR9lUrJySx4MXzp8HWpEXlS86mSrqsLFzIMNX+Kp1RBM51yqwuZaYtJSi/6trv3Mv
         maMVYeIf1rQl0WFQlZNrvoyLIjGjEnzdBvWtb5hsKjXOTgI4FYc0P0uCXr4JiTnmfwvE
         8IX6QVV5t+OhX9+BxvwzErGvHFJ3RrC7l29mg0SNj1j5DsGSaB7z4MJXkGbtqLPE3MQa
         0AXSNwTw4bh7hy7eRX/1R8wE67FF4rzVrrKRdY6Pu/UUCafXFMQEPc+LoFiGWFRxv+C9
         yvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734319927; x=1734924727;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nNOXfbpXdv41m/bOJkFcObz3huwlsENpJ7Jf000ZPk4=;
        b=TNZqXDaiwGalhKig6MbHeHXM4uMXNtnMoeZmmXd6E8B3kqKA9HbVrkritjNVcz6X0t
         n0CxQfm0ZKwGuh+edmc1op1sSTAvreFD+Ttq+Zry6do5ggcYiE7aAEoajQPYcqXKx9x/
         jvR5m4tyEDIuZG535qZvewLd0QNm7QSbssidOuwuZgwF7ZqCJ5mK03Nhzvr0UPGV+vTw
         Jlfok2VzlLiI/+GaObG0b+lv6kn2xe6MC2s3yaBeJ6bPpykIoRjxaj/Eb0Y/2lDBJ0Ph
         9wJOxg3zLJP8UUXc8v//lkrsgYFH1LADTYoJfFjga3a04bYG+xOvM7egBR0v9c5nAO9y
         3nOg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJd7xdCma/B15wXcGN10Gce562ZA9hUqqyzrYsesz4ly1EIDbQFsxm1q5fjKSUjQj2513mrq9I65GcrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrI1vFaYWDZL9txQAlYo2L/TE7Ljgg1UNpfbS893Uokz1D6Z/v
	hFQkaJ7hOxHqTyVi64UBh0RP+D6xuRhMFD8rv9R1V+2NMzG8WnE3
X-Gm-Gg: ASbGncuxdMSp16sau8VfCvNgxhoriS/XSCSea+BtlbQb7dqcLt3wfw+qBEyH5eLTm4a
	JmIXZ1LsRYJ5UrTdsTebLuYbp0XaAFfwapZWsfGyrtsm7ogPFwvL5tYkHCYGPy//MER8bwFCNtJ
	8VHPDYzp0+yIImCqnANumtRfyE5bbh+SMFOCqgOprAw5kOtJaf26VM9XQiQiQY95JMemXTQeyaI
	tjMe3JTHTRYrfpQ00pI6u9gvostgH5M0DSuPG8PzW8lX+6Vdbn3Jc3rYQ==
X-Google-Smtp-Source: AGHT+IEY417LiHa8XKzorTrI7WgocgIKDLhiY2qmsRvZtrCi2a9JHVe/oB79usdGBJ1xjM6YnatJyA==
X-Received: by 2002:a17:902:f64a:b0:215:522d:72d6 with SMTP id d9443c01a7336-21892a20f38mr156206615ad.38.1734319926721;
        Sun, 15 Dec 2024 19:32:06 -0800 (PST)
Received: from localhost ([98.97.40.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d1b1sm32268655ad.204.2024.12.15.19.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:32:06 -0800 (PST)
Date: Sun, 15 Dec 2024 19:32:01 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <mrpre@163.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 martin.lau@linux.dev, 
 ast@kernel.org, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 song@kernel.org, 
 andrii@kernel.org, 
 mhal@rbox.co, 
 yonghong.song@linux.dev, 
 daniel@iogearbox.net, 
 xiyou.wangcong@gmail.com, 
 horms@kernel.org
Message-ID: <675f9f3184dfe_159ba20815@john.notmuch>
In-Reply-To: <xtsolkbkdecvlbqx4zjtvd74c45lg5kqx2ojgdvovxrjgaghij@ld4wjwi7imvy>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
 <6758f4ce604d5_4e1720871@john.notmuch>
 <f2pur5raimm5y3phmtwubf6yf3sniphwgql4c4k7md25lxcehm@3qwyp4zibnrd>
 <675b8f8f65e28_ff0720890@john.notmuch>
 <xtsolkbkdecvlbqx4zjtvd74c45lg5kqx2ojgdvovxrjgaghij@ld4wjwi7imvy>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiayuan Chen wrote:
> On Thu, Dec 12, 2024 at 05:36:15PM -0800, John Fastabend wrote:
> [...]
> > > > I think easier is to do similar logic to read_sock and track
> > > > offset and len? Did I miss something.
> > > 
> > > Thanks to John Fastabend.
> > > 
> > > Let me explain it.
> > > Now I only replace the read_sock handler when using strparser.
> > > 
> > > My previous implementation added the replacement of read_sock in
> > > sk_psock_start_strp() to more explicitly require replacement when using
> > > strparser, for instance:
> > > '''skmsg.c
> > > void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
> > > {
> > >     ...
> > >     sk->sk_data_ready = sk_psock_strp_data_ready;
> > >     /* Replacement */
> > >     sk->sk_socket->ops->read_sock = tcp_bpf_read_sock;
> > > }
> > > '''
> > > 
> > > As you can see that it only works for strparser.
> > > (The current implementation of replacement in tcp_bpf_update_proto()
> > > achieves the same effect just not as obviously.)
> > > 
> > > So the current implementation of recv_actor() can only be strp_recv(),
> > > with the call stack as follows:
> > > '''
> > > sk_psock_strp_data_ready
> > >   -> strp_data_ready
> > >     -> strp_read_sock
> > >       -> strp_recv
> > > '''
> > > 
> > > The implementation of strp_recv() will consume all input skb. Even if it
> > > reads part of the data, it will clone it, then place it into its own
> > > queue, expecting the caller to release the skb. I didn't find any
> > > logic like tcp_try_coalesce() (fix me if i miss something).
> > 
> > 
> > So here is what I believe the flow is,
> > 
> > sk_psock_strp_data_ready
> >   -> str_data_ready
> >      -> strp_read_sock
> >         -> sock->ops->read_sock(.., strp_recv)
> > 
> > 
> > We both have the same idea up to here. But then the proposed data_ready()
> > call
> > 
> > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> > +		u8 tcp_flags;
> > +		int used;
> > +
> > +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> > +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> > +		used = recv_actor(desc, skb, 0, skb->len);
> > 
> > The recv_actor here is strp_recv() all good so far. But, because
> > that skb is still on the sk_receive_queue() the TCP stack may
> > at the same time do
> > 
> >  tcp_data_queue
> >   -> tcp_queue_rcv
> >      -> tail = skb_peek_tail(&sk->sk_receive_queue);
> >         tcp_try_coalesce(sk, tail, skb, fragstolen)
> >          -> skb_try_coalesce()
> >             ... skb->len += len
> > 
> > So among other things you will have changed the skb->len and added some
> > data to it. If this happens while you are running the recv actor we will
> > eat the data by calling tcp_eat_recv_skb(). Any data added from the
> > try_coalesce will just be dropped and never handled? The clone() from
> > the strparser side doesn't help you the tcp_eat_recv_skb call will
> > unlik the skb from the sk_receive_queue.
> > 
> > I don't think you have any way to protect this at the moment.
> 
> Thanks John Fastabend.
> 
> It seems sk was always locked whenever data_ready called.
> 
> '''
> bh_lock_sock_nested(sk)
> tcp_v4_do_rcv(sk)
>    |
>    |-> tcp_rcv_established
>    	|-> tcp_queue_rcv 
>    		|-> tcp_try_coalesce
>    |
>    |-> tcp_rcv_state_process
>    	|-> tcp_queue_rcv
>    		|-> tcp_try_coalesce
>    |
>    |-> sk->sk_data_ready()
> 
> bh_unlock_sock(sk)
> '''
> 
> other data_ready path:
> '''
> lock_sk(sk)
> sk->sk_data_ready()
> release_sock(sk)
> '''
> 
> I can not find any concurrency there. 

OK thanks, one more concern though. What if strp_recv thorws an ENOMEM
error on the clone? Would we just drop the data then? This is problem
not the expected behavior its already been ACKed.

Thanks,
John

