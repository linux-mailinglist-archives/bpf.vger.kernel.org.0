Return-Path: <bpf+bounces-53859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785AA5D13F
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA505189B359
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C67264A89;
	Tue, 11 Mar 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU2HAxfA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A61EEA42;
	Tue, 11 Mar 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726487; cv=none; b=QCrpBfYImeK3rGfK0aol1FswIxiHapLk1HNpc/9bISjV8wE3/ZxTKkUaU9XP8lOgMkKIBPnlOcX0QXeuOCrfwHLMzo6mhdUWt+GdkoPMUBAUouazYpzkK9YeV+J9FQatElLi3ttGGj8UIg5Yk2g51Niun/9Kbnr67CX2WigkaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726487; c=relaxed/simple;
	bh=35N0I1s+kRsmEnv0ZZIWl76RzE7IQN0lPJlMDitUf1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj5yjKpDM44iX832YyhXh9HFanoErlTWiLM0cE/ah+vqP4mbIDD/e4Q4jFm5pWDm61I2R8r/wQDhEZimMRdqYLvcvNkk3pK7PhmKnzikHtkI3qpnIAiIDag7zhQepqpJOK9ZVeUME4GmnOyHM18borkzAiIHkL/nkQNLO+iKWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU2HAxfA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so12643467a91.1;
        Tue, 11 Mar 2025 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741726485; x=1742331285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J285DLL4Eyer7avSgJIM/ejnfAFqAM8ijHBJjMmzNTg=;
        b=ZU2HAxfA8b2wtnNtyLWnEGni5IIdL+xz6Cu25MzI1vHHueHB9tFyheK6Sx/JEnspSL
         KgEO71PN2q8U7c86bIBQZoramJADUCVafRovv4ZEWQzBQpwskvveRcXZPv9lvowOsOYa
         GQ+R9B11nbiv5FLA3rbyb8NzE4W/lYAm7GOkSn4f8DpIyhVdr0NmzsBRVlkPwN6Cn5NV
         BC5yJVpjQDGFrteNU65Fko9zAqplzDQ5uvVb0Zp1CvSlicHvbGmTeM6Vgrn/4pAfvItR
         fkhLa4x+71g62dYoDrjYOMot2V9wMoUT59B/CTzTV/asqlEjUocq1xqxeZdu1Iuok8ma
         tnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741726485; x=1742331285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J285DLL4Eyer7avSgJIM/ejnfAFqAM8ijHBJjMmzNTg=;
        b=k+fPKYV5sD8oQSocEXiVxAzihzkxDwF5b3AYSWZjfhTdVvNvm5uD7LnQmmxPHt1QC/
         Ef+FgIxpJcxJkEchUdbEbP+V5oAuGayCW2bww4uUbXJPouIrp+/WjD2vI7RnvdS/Bdvb
         6yho8Ykbvic0FTeQErAtP+wvHt0+ZIQZjLiUa8GdkVVQLlXAxKxyXQOWjLCsLm4Z+fst
         An7LTXFJbOcurcCt+a/8pWcjZ0bcwLZzLsXSDSqPK+bWmBgA4teEjQmiBAYamUyJFdQp
         8y3lAfn9FPHSM8t3jFlUV9lAgsVibwfQIbejGXxy7oh5PtN018iLzcBxgUxn77FYysEH
         kdcA==
X-Forwarded-Encrypted: i=1; AJvYcCXjJ2+23IiPd3lW/+vSDDaA2zAQcjQw9f4Te9mjEQpNx1zKYkmaEuNnyJr7CA08p7+VByE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2egYYTX3FdenARUggWLhg1xQ5zr10EWjQp1UewJYvS/WJGSP
	sc3Ht5r/DjH5nKptxpy4GX5txvKntt2mX2sVq1Ak+t7fHjco2T9q
X-Gm-Gg: ASbGnctRavr30T0TGIeGwjRT4ss39GUHoAQ82UR34l/E1CCcrkUNTtaIkvqrLqp4lN/
	XZIBgrnzfHPwg3ual6ovIveuZg3LhpxQtWv/ZMPqCO2iC8RfzrVysou/0wllnxmWYuD0mgP7E3Q
	LLbsLLYoeql5V4Z+0H2PQhFnt+6uoTWiBF9R8rwlRxR4gk958RK8MN4f6aj2ttzW/8FsNKouFrO
	1rUfx7cG/bKcwB+yl3v8A0UKR+l1wHfe+6kNb704Ex0taHeeBLhXYThr7BJH5K+uGimBHZQhJ/8
	RTBRTJXkci0IR5VulZQ9RKNAHlyOaoWvQ9DXd7MJRxDd+g==
X-Google-Smtp-Source: AGHT+IEIcdmeJ7Ek+fSgtqLkvfkE+PsqYl1LuPYpcDUJ0UBOqdVNmdcG1IO8ZIQ7iSRB/3X4iRW2hA==
X-Received: by 2002:a17:90a:ec87:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2ff7cf4cf61mr33421160a91.33.1741726485471;
        Tue, 11 Mar 2025 13:54:45 -0700 (PDT)
Received: from gmail.com ([98.97.37.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30118249577sm39247a91.21.2025.03.11.13.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:54:44 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:54:26 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	zhoufeng.zf@bytedance.com, Zijian Zhang <zijianzhang@bytedance.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v2 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
Message-ID: <20250311205426.h3rvfakthoa6usgr@gmail.com>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
 <20250306220205.53753-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306220205.53753-5-xiyou.wangcong@gmail.com>

On 2025-03-06 14:02:05, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The TCP_BPF ingress redirection path currently lacks the message corking
> mechanism found in standard TCP. This causes the sender to wake up the
> receiver for every message, even when messages are small, resulting in
> reduced throughput compared to regular TCP in certain scenarios.

Agreed this is annoying.

> 
> This change introduces a kernel worker-based intermediate layer to provide
> automatic message corking for TCP_BPF. While this adds a slight latency
> overhead, it significantly improves overall throughput by reducing
> unnecessary wake-ups and reducing the sock lock contention.

Great. Couple questions below.

> 
> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  include/linux/skmsg.h |  19 ++++
>  net/core/skmsg.c      | 139 ++++++++++++++++++++++++++++-
>  net/ipv4/tcp_bpf.c    | 197 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 347 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 7620f170c4b1..2531428168ad 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -15,6 +15,8 @@
>  
>  #define MAX_MSG_FRAGS			MAX_SKB_FRAGS
>  #define NR_MSG_FRAG_IDS			(MAX_MSG_FRAGS + 1)
> +/* GSO size for TCP BPF backlog processing */
> +#define TCP_BPF_GSO_SIZE		65536
>  
>  enum __sk_action {
>  	__SK_DROP = 0,
> @@ -85,8 +87,10 @@ struct sk_psock {
>  	struct sock			*sk_redir;
>  	u32				apply_bytes;
>  	u32				cork_bytes;
> +	u32				backlog_since_notify;
>  	u8				eval;
>  	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
> +	u8				backlog_work_delayed : 1;
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> @@ -97,6 +101,9 @@ struct sk_psock {
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
>  	spinlock_t			ingress_lock;
> +	struct list_head		backlog_msg;
> +	/* spin_lock for backlog_msg and backlog_since_notify */
> +	spinlock_t			backlog_msg_lock;
>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;
> @@ -117,11 +124,13 @@ struct sk_psock {
>  	struct mutex			work_mutex;
>  	struct sk_psock_work_state	work_state;
>  	struct delayed_work		work;
> +	struct delayed_work		backlog_work;
>  	struct sock			*sk_pair;
>  	struct rcu_work			rwork;
>  };

[...]

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
> +
> +	/* At this point, the data has been handled well. If one of the
> +	 * following conditions is met, we can notify the peer socket in
> +	 * the context of this system call immediately.
> +	 * 1. If the write buffer has been used up;
> +	 * 2. Or, the message size is larger than TCP_BPF_GSO_SIZE;
> +	 * 3. Or, the ingress queue was empty;
> +	 * 4. Or, the tcp socket is set to no_delay.
> +	 * Otherwise, kick off the backlog work so that we can have some
> +	 * time to wait for any incoming messages before sending a
> +	 * notification to the peer socket.
> +	 */

I think this could also be used to get the bpf_msg_cork_bytes working
directly in receive path. This also means we can avoid using
strparser in the receive path. The strparser case has noticable
overhead for us that is significant enough we don't use it.
Not that we need to do it all in one patch set.

> +	nonagle = tcp_sk(sk)->nonagle;
> +	if (!sk_stream_memory_free(sk) ||
> +	    tot_size >= TCP_BPF_GSO_SIZE || ingress_msg_empty ||
> +	    (!(nonagle & TCP_NAGLE_CORK) && (nonagle & TCP_NAGLE_OFF))) {
> +		release_sock(sk);
> +		psock->backlog_work_delayed = false;
> +		sk_psock_backlog_msg(psock);
> +		lock_sock(sk);
> +	} else {
> +		sk_psock_run_backlog_work(psock, false);
> +	}
> +
> +error:
> +	sk_psock_put(sk_redir, psock);
> +	return ret;
> +}
> +
>  static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  				struct sk_msg *msg, int *copied, int flags)
>  {
> @@ -442,18 +619,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			cork = true;
>  			psock->cork = NULL;
>  		}
> -		release_sock(sk);
>  
> -		origsize = msg->sg.size;
> -		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> -					    msg, tosend, flags);

The only sticky bit here that is blocking folding this entire tcp_bpf_sendmsg_redir
logic out is tls user right?

> -		sent = origsize - msg->sg.size;
> +		if (redir_ingress) {
> +			ret = tcp_bpf_ingress_backlog(sk, sk_redir, msg, tosend);
> +		} else {
> +			release_sock(sk);
> +
> +			origsize = msg->sg.size;
> +			ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> +						    msg, tosend, flags);

now sendmsg redir is really only for egress here so we can skip handling
the ingress here. And the entire existing sk_psock_backlog work queue because
its handled by tcp_bpf_ingress_backlog?

> +			sent = origsize - msg->sg.size;
> +
> +			lock_sock(sk);
> +			sk_mem_uncharge(sk, sent);
> +		}

I like the direction but any blockers to just get this out of TLS as
well? I'm happy to do it if needed I would prefer not to try and
support both styles at the same time.

