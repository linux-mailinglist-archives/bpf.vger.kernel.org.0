Return-Path: <bpf+bounces-34184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA892ADC6
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 03:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC061F223BB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914442BAE5;
	Tue,  9 Jul 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW0u2twX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9231FA1;
	Tue,  9 Jul 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488253; cv=none; b=jMm+alZiy2GiMWbXtEkeknlwWNZO0mQUpxNncqxTwf5tfx7BYqkiWydnuEFRtBP6uUulTk1Rf+sqDFlRdcMnFeXOQrcCla9A4mLfgntMvzXK9Cp1dpiULHFkW7eGeCNJ4jWcxPn0zBYMHRIjkK2YxhSTvyeEY1vO2PJem6+vo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488253; c=relaxed/simple;
	bh=lEtixa07+RUJAtKBJsg+gVwNeRwl/kAxLHxDaZOtyBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GT02zNLhLL4LyT1D/j0cAXqsZrZ7afNODIlBuzqTXLeuGQ/e4F01B2VInvd8b6LW33a/wDzTaRLhk82ybfYQTBiH6Gw9PwsAyhnX3pOOAaSsE1FyOZRNgMbKkBuNTe7syUkcUEYqAi9+QGieF+HTcBpcXBvCfIuKRdqtre5kQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW0u2twX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso18655905ad.0;
        Mon, 08 Jul 2024 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720488250; x=1721093050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j32VYAlsuK3/jNbvHCaSgNRDqiz9cqS48fKSFKyyisg=;
        b=kW0u2twX+VFqsTFO15BewePKAqaLuWCifmH8wS6Wy/cdkidOocsgFZTo1NhDZS5sbX
         +oXsP3dIVHXHMuGKJGQ2agj3cuL+ULBSWx1JnvykihLei/pY4MVbPYWwR87wgzoAC/VE
         EJNqR8nLZqSXSeAKhtSvuvL7iG/DXFVNrf1ez6EBVEtbB2r3KIwmpl9V2shuI30HZOmm
         GucHQxLmvqN4NnEZyUCFLyRVzM2naFaiI7rqEhfXAF433FXXCgbH3fFYf03H/yb3PlcU
         ECQ5ue2AGcSlGep1sR4Xl2coKbXzMygqXEMIjaf1KXqdUwuFymHWFgwfE7cvEJ+IS+5u
         HUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720488250; x=1721093050;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j32VYAlsuK3/jNbvHCaSgNRDqiz9cqS48fKSFKyyisg=;
        b=Y/ePHyrMtN591MEapUfjDK6/ETFUcqymRBA7Xrwuwbwo4OYpocRSILdb+PhNV2of7P
         XM85+a3PYZI6TJWBz/C3OL/KS4x00iCIxtYYXHJ/SnHunMvSeBhUueBHzD5CGDu3Boa1
         tkmQSGF9ZndLwGlyEJL0GYJq9ada0kPp76KtBzxiq1hKgdG4GBVOglgjboLEmPapGsWM
         8evKcp/ZQe13yCiWFFE5Jy9JwRHZGVPOzkxwHibw9E6OdwTY9apknL392uTB/OGxvj5M
         rR3+Ya2JwdKhORk80LK82QUz8PIQuTNpN2sy4A6OH7K2O2Scg/pTM+Y7ZvB3UP/3dooX
         QLAA==
X-Forwarded-Encrypted: i=1; AJvYcCVEqyYE5fqbSvyhy261tLkU/sctONqYGys3ObRxI3X3Q3Oa6SwlXowO8KljL8IcaPDt8ggJ8ku6GRLMY0FeuqWfN6LY4UQEEQfGtzIqLkhenanZjguD88Sro9p8
X-Gm-Message-State: AOJu0Yyn+RL8ubd5mEKsR61zBclfOUOvfVJhR7orEz4QcfU4bFod/3oW
	yVWRco00IdsD/mlM+XefkYcS1ose62dvwYi01r9te1841S2LnNXZRCcoMQ==
X-Google-Smtp-Source: AGHT+IGd9SsKvaiwytVNuNwMiS1lxE3xnM6kDjIqPA7QoodzrYTEMUqV6/sjV5+BiL4ED9bplPS4nQ==
X-Received: by 2002:a17:903:11d1:b0:1fa:2760:c3f3 with SMTP id d9443c01a7336-1fbb6d252a9mr9620375ad.13.1720488250411;
        Mon, 08 Jul 2024 18:24:10 -0700 (PDT)
Received: from localhost ([98.97.32.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a28f8esm4814595ad.64.2024.07.08.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:24:08 -0700 (PDT)
Date: Mon, 08 Jul 2024 18:24:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 mhal@rbox.co
Cc: Rao.Shoaib@oracle.com, 
 bpf@vger.kernel.org, 
 cong.wang@bytedance.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <668c9132195f6_d7720840@john.notmuch>
In-Reply-To: <20240708193820.3392-1-kuniyu@amazon.com>
References: <20240707222842.4119416-2-mhal@rbox.co>
 <20240708193820.3392-1-kuniyu@amazon.com>
Subject: Re: [PATCH bpf v3 1/4] af_unix: Disable MSG_OOB handling for sockets
 in sockmap/sockhash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Sun,  7 Jul 2024 23:28:22 +0200
> > AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> > with an `oob_skb` pointer. BPF redirecting does not account for that: when
> > an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> > results in a single skb that may be accessed from two different sockets.
> > 
> > Take the easy way out: silently drop MSG_OOB data targeting any socket that
> > is in a sockmap or a sockhash. Note that such silent drop is akin to the
> > fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
> > 
> > For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
> > 
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 

Why does af_unix put the oob data on the sk_receive_queue()? Wouldn't it
be enough to just have the ousk->oob_skb hold the reference to the skb?

I think for TCP/UDP at least I'll want to handle MSG_OOB data correctly.
For redirect its probably fine to just drop or skip it, but when we are
just reading recv msgs and parsing/observing it would be nice to not change
how the application works. In practice I don't recall anyone reporting
issues on TCP side though from incorrectly handling URG data.

From TCP side I believe we can fix the OOB case by checking the oob queue
before doing the recvmsg handling. If the urg data wasn't on the general
sk_receive_queue we could do similar here for af_unix? My argument for
URG not working for redirect would be to let userspace handle it if they
cared.

Thanks.

> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Thanks!
> 
> 
> > ---
> >  net/unix/af_unix.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  net/unix/unix_bpf.c |  3 +++
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 142f56770b77..11cb5badafb6 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2667,10 +2667,49 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  
> >  static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  {
> > +	struct unix_sock *u = unix_sk(sk);
> > +	struct sk_buff *skb;
> > +	int err;
> > +
> >  	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
> >  		return -ENOTCONN;
> >  
> > -	return unix_read_skb(sk, recv_actor);
> > +	mutex_lock(&u->iolock);
> > +	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
> > +	mutex_unlock(&u->iolock);
> > +	if (!skb)
> > +		return err;
> > +
> > +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > +	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
> > +		bool drop = false;
> > +
> > +		unix_state_lock(sk);
> > +
> > +		if (sock_flag(sk, SOCK_DEAD)) {
> > +			unix_state_unlock(sk);
> > +			kfree_skb(skb);
> > +			return -ECONNRESET;
> > +		}
> > +
> > +		spin_lock(&sk->sk_receive_queue.lock);
> > +		if (likely(skb == u->oob_skb)) {
> > +			WRITE_ONCE(u->oob_skb, NULL);
> > +			drop = true;
> > +		}
> > +		spin_unlock(&sk->sk_receive_queue.lock);
> > +
> > +		unix_state_unlock(sk);
> > +
> > +		if (drop) {
> > +			WARN_ON_ONCE(skb_unref(skb));
> > +			kfree_skb(skb);
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +#endif
> > +
> > +	return recv_actor(sk, skb);
> >  }
> >  
> >  static int unix_stream_read_generic(struct unix_stream_read_state *state,
> > diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> > index bd84785bf8d6..bca2d86ba97d 100644
> > --- a/net/unix/unix_bpf.c
> > +++ b/net/unix/unix_bpf.c
> > @@ -54,6 +54,9 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> >  	struct sk_psock *psock;
> >  	int copied;
> >  
> > +	if (flags & MSG_OOB)
> > +		return -EOPNOTSUPP;
> > +
> >  	if (!len)
> >  		return 0;
> >  
> > -- 
> > 2.45.2



