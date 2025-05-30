Return-Path: <bpf+bounces-59343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31CAAC883A
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACA6A254B6
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CDC1FECC3;
	Fri, 30 May 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnO4bld0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D929125D6;
	Fri, 30 May 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586617; cv=none; b=o4GVIzNrA8uAnE/wnexoYXWb0I03ogNrssg/C6OqQlc1osqRlaELzV0KfprJjF/96NoTyOCJsA2B3TQQLRCjqJ56Mz6ccDjWOIBnNyUDmjWko3m1HCF2M/zZqAssVJBqpmveSd5kgDH+ltRp4BPZ38yv+1XLrjKEx9a1n4ECdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586617; c=relaxed/simple;
	bh=sKvXicb32pe3GzjnNLo8RSw+9Ys48hdotCKWMvLi7A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyWeUWu4PrYYW/D2zgfwl7gfylI7W2i4lwTCOLa814o8/9dJM+FvxMTtrXa9wxa4GgvDWwwqisJyLvx42YFm/9UWfqf9l5B7S9Xlzbl+1mLv6xlsZovBvlbs8Z1gRfs0J0lXjpcO/Av8AskEDiaawLSj9w77cN+XZ/Xq1CqyW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnO4bld0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2320d06b728so15660415ad.1;
        Thu, 29 May 2025 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748586615; x=1749191415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyuLdEneac7v7fIMVVlyOJeFB1d97Dk3ked7QoQ2Pfs=;
        b=LnO4bld02Fi+MTytiHBmndKccs8eIHhIBHDF8tQ+0Bp3xlprJc4pGEUbsjUg77fpHf
         wyPhdyPaQK29vOqajML1Br/qUujJ+iY/IvZji3gLRjnppy0FsLsFEgDTM8HcnHLjCa66
         zeFC0fQRcSb7x4k7gFdPMz/7OBdA6xqsoR0nsrriaHxHKO4APvQ1w86ubfnsHojH/XqG
         LO5T8uc3BYQp5taXIfIC4gKookChdpqRJVK+IXh/wb0M3Go8K5ceB8zD84mBYFd7Tmwm
         57mrWd21owIdnLi4V0ygAwzk8xlnLvQXKjG7Hjua0kFS8we5nO8/LJkqJdTIeFJc8v+w
         sTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748586615; x=1749191415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyuLdEneac7v7fIMVVlyOJeFB1d97Dk3ked7QoQ2Pfs=;
        b=k1LWeReydWL7Wgb3RYx/GF/9jC4Ox866oCJvqJ9/f5Wwi5LmKacIW33dTuAT16qPtn
         KaChUf3znb0y5KfPbLVvWjurA/juzudf2ycDwwlfPXW6GMJeEDSko6oOsP5XHC/GlL2J
         UMcF05qzFdC4EV0fDkefQW5so2njLp4S+mTcECx2SdqdCyasuQchBRiBy1uwwc8nhZiP
         bVln+gyLA6HH5Q7b882VpG0p+6BVCYjBrQMsylIsB27MlnH8Ed/rJwFA3j/REwQeR0fF
         /B93FvEqzjJ1KMDbxrIJv1/xVXkWjCO6HWdsew478rTkA1UnBzqmOqYtYPhB1iv4CE/T
         qVbg==
X-Forwarded-Encrypted: i=1; AJvYcCWp3Ay3YUkLjZriydfEyIt/72BKD4EOu46TrWe+gGOa4fgg624X7uWw0Fh4xi0jJxMQWek=@vger.kernel.org, AJvYcCX/UIoWYXD1zyrpQR4Ix/WyEO6FISU3kRJElh8/RWMDqyMzLoqDm1FWzijFaDCw5O5sgz+wUmnH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TFJzvmrgufTaFfPTxnj3R+YZQ65qvcu/x1xxnw7OgVrrAshS
	05CH27B3eKdbKfMxqTFkCIH9l5Abfxo6JGirSAWgQWKw/bmn2AbTgk+x
X-Gm-Gg: ASbGncvjYc2e5xh67chr+SCYF/ALRwkBNKXOzoXFlGPkf4PgTXxBwAzQRYdZQ8nTL4w
	a2l2XfETs7bDyYV8OzB3uxfAdAW9/IjY5R3P8FUynuoOsh1nrReyxfbdJvElkm68Pi6LFVtoYhs
	JyUyHke9X/zedawxvYTb6WOhYzlQ6us/X5AFR514jG44t6+lUEEC4eXRf68wQ9Lg24S0TpInbO3
	7YnfX33vW3bxU5CErTL7JskRd891SIv2KY7/iQWdajuuGtUtuuozngjf5xZ+8CJGrAzoRHDAqPH
	X8tn2U/Sc8+8Y70UiY9zkkr+/DYA3bT5Noz0lHgv/gedoDSQMJM=
X-Google-Smtp-Source: AGHT+IFMdcy0H6xfnuJuoqGMMfHh6XB0ob9CaqB2xpeNUrgqvcbxzRuO8pkOphiWfPmw1DVMvZZVvQ==
X-Received: by 2002:a17:902:d58b:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23528fee497mr39251195ad.1.1748586615208;
        Thu, 29 May 2025 23:30:15 -0700 (PDT)
Received: from gmail.com ([98.97.45.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd96eesm21698055ad.73.2025.05.29.23.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:30:14 -0700 (PDT)
Date: Thu, 29 May 2025 23:30:11 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Zijian Zhang <zijianzhang@bytedance.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 2/4] skmsg: implement slab allocator cache
 for sk_msg
Message-ID: <20250530063011.cqubbcehgnraasmx@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-3-xiyou.wangcong@gmail.com>
 <20250529000348.upto3ztve36ccamv@gmail.com>
 <c66ac1f6-1626-47d6-9132-1aeedf771032@bytedance.com>
 <aDipm6P+RWGD8j4M@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDipm6P+RWGD8j4M@pop-os.localdomain>

On 2025-05-29 11:38:19, Cong Wang wrote:
> On Wed, May 28, 2025 at 05:49:22PM -0700, Zijian Zhang wrote:
> > On 5/28/25 5:04 PM, John Fastabend wrote:
> > > On 2025-05-19 13:36:26, Cong Wang wrote:
> > > > From: Zijian Zhang <zijianzhang@bytedance.com>
> > > > 
> > > > Optimizing redirect ingress performance requires frequent allocation and
> > > > deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
> > > > sk_msg to reduce memory allocation overhead and improve performance.
> > > > 
> > > > Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> > > > Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> > > > ---
> > > >   include/linux/skmsg.h | 21 ++++++++++++---------
> > > >   net/core/skmsg.c      | 28 +++++++++++++++++++++-------
> > > >   net/ipv4/tcp_bpf.c    |  5 ++---
> > > >   3 files changed, 35 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > > > index d6f0a8cd73c4..bf28ce9b5fdb 100644
> > > > --- a/include/linux/skmsg.h
> > > > +++ b/include/linux/skmsg.h
> > > > @@ -121,6 +121,7 @@ struct sk_psock {
> > > >   	struct rcu_work			rwork;
> > > >   };
> > > > +struct sk_msg *sk_msg_alloc(gfp_t gfp);
> > > >   int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
> > > >   		  int elem_first_coalesce);
> > > >   int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
> > > > @@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> > > >   		   int len, int flags);
> > > >   bool sk_msg_is_readable(struct sock *sk);
> > > > +extern struct kmem_cache *sk_msg_cachep;
> > > > +
> > > >   static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> > > >   {
> > > >   	WARN_ON(i == msg->sg.end && bytes);
> > > > @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
> > > >   	kfree_skb(skb);
> > > >   }
> > > > +static inline void kfree_sk_msg(struct sk_msg *msg)
> > > > +{
> > > > +	if (msg->skb)
> > > > +		consume_skb(msg->skb);
> > > > +	kmem_cache_free(sk_msg_cachep, msg);
> > > > +}
> > > > +
> > > >   static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> > > >   				      struct sk_msg *msg)
> > > >   {
> > > > @@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> > > >   		ret = true;
> > > >   	} else {
> > > >   		sk_msg_free(psock->sk, msg);
> > > > -		kfree(msg);
> > > > +		kfree_sk_msg(msg);
> > > 
> > > Isn't this a potential use after free on msg->skb? The sk_msg_free() a
> > > line above will consume_skb() if it exists and its not nil set so we would
> > > consume_skb() again?
> > > 
> > 
> > Thanks to sk_msg_free, after consuming the skb, it invokes sk_msg_init
> > to make msg->skb NULL to prevent further double free.
> > 
> > To avoid the confusion, we can replace kfree_sk_msg here with
> > kmem_cache_free.
> > 
> 
> Right, the re-initialization in sk_msg_free() is indeed confusing, maybe
> it is time to clean up its logic? For example, separate sk_msg_init()
> out from sk_msg_free().
> 
> I can add a separate patch for this in next update, if people prefer.
> 
> Thanks!

OK so its not a problem we have the init there. So ACK for this patch.
Perhaps a follow up to clean up the different types of 'frees' would be
useful. Move into sk_msg_free+kfree_sk_msg into a single call. But,
I'm not completely convinced its worth the churn.

Acked-by: John Fastabend <john.fastabend@gmail.com>

