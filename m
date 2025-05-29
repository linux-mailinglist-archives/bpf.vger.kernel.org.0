Return-Path: <bpf+bounces-59317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B0AC8241
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B70A1C05A8F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E323183F;
	Thu, 29 May 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpUAHXJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F622D4F0;
	Thu, 29 May 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543902; cv=none; b=Z0CI85ORl/8qMMiRrXRBocIuptbaGI/0w+mu7uLHKQgh9hKwbmzB5dI/Rggypl1LfsieC8jJCgLM77UMCBaIKRo9EvjtybtGMXGBXAOlS0J+0nvzGIPuvt/Ds1HObx5zYHM2OSYcmlDopVhx+hdemPbi/0PWNu9U2OCD/Y2yoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543902; c=relaxed/simple;
	bh=J7oa/5hP27LugL5IgPi1bvQAwOS2h2/7Si531ggOGYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZA1Yko5asTTcRlWJ+5Oi2OwYC0+HEf/m88Q25fmGkOpgr7cAAOp6juXCb3/XO/zvqpbt32RepcbxDad3qfqxO7OzhJIejCgWqxWPwngcH+s4DyXY8r8XkT5COZ9icn6TmfP+02LKU9FYUesjKlvPDE79xLgF9WzJJrUFblU4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpUAHXJZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2351ffb669cso5544955ad.2;
        Thu, 29 May 2025 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748543900; x=1749148700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xovIQZn3YQTyYV3/H7wuOXp388nJWq7YYeTeqG5/Sl4=;
        b=GpUAHXJZ55gxKjKNSocqB4HFWPXDciyBztkD9ZeS1iFF+1Re5mldd2CVjRb5fUo2F9
         Fr7SrqHOWK1/JCpGZ/Wjk7JHuo9AZeaz1rl9zqZ3IytzmJEy77FIabhhqsadQsJQx6I6
         uBWVG7QTQ5hWQT06yncJH/Bf7kVMIaXuI/P9o1suFqCCz4TWaqA/HhaQCXULhNiXKBag
         ilnaO5aAUnQ2Y+MDeo8ZIWhxnm/p7V6csbWej/Eo1aMk/hhcD9vIsd+R4wSViJ74bB1C
         nsmxLX1nZ98UthAm8lNLQqLIk0QnzewZs2O3lUg9aWWJue2mNdwVII8PrrGyceQxsqtV
         7Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748543900; x=1749148700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xovIQZn3YQTyYV3/H7wuOXp388nJWq7YYeTeqG5/Sl4=;
        b=tTsqv7VHbkFtd/tD/XkmRf5/7p4wBwcTf7N/oKpmv8TT3Kkz29fQ0nmq+C/FEL3UNo
         3yvOOJh7rZbots61vhTlwfA3R3TL4WZx5t9qelR2R4IKEdR8779uC1Nvoc+6djLIz3Qh
         cu3brDAXpK59kIIKN5tO0SYcFbydKkNz0do99G8S3fESQLbbDseXTu/30L1HaEJNJ4Mq
         0FiAGCuofoAdKugJMQ/Ioo6pDG6eC2ueP0jkV+H2vhubAUDOiZX48MoysxvCvxQtIOCr
         GeEpbMM2M/l/H+czP4m92SKKE1js97TqhXn4n93jPjdh78Lh7Hb1ko4wn3MYAQBJvMOJ
         Hqzg==
X-Forwarded-Encrypted: i=1; AJvYcCU/X93gU8DbhPKpbaTwy0TE4KUEupHzvfezffMAQdlFJNDeZu7o0fIQCTIDvpQZnUc6u0hDmNn9@vger.kernel.org, AJvYcCUM7A5wZhpPIEpucJz8KBSSWMGMr/KIPc4vsZubW1K0N1tirrmPoEnT1D1C/5JmFCEkXJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjj7cguwmHOLWcS5m9HSOtKec83jP4RrVSOPj9r4D4wab3Fyzr
	cvmQBamOQYjbPFyJ2ogpTRxgFzPPK9PhRB/xn5a6AMgRwqw2Ihr0nvyV
X-Gm-Gg: ASbGncv+nfqyASt1q3QzMYXXI8Vz04rsotZrTu+d5me09NpwfdxVDvvlxKU/Vr9ScCY
	eulYbSR3LrzP4F7IYgl4tFYVpHWg+OXU1zMclcsblOZWw5xUoA8pwDVsBBekiTonHSbh46qn599
	N4WYSomlZa1GzPoOYaL7BMvR5sgZgHZWfLT4LlpZAjB9pqWu352sSat+aE4z9BWGcgRqw/Bkkmi
	WdefBjM4zwtSJadOyTFizfZ0uOpreQn0eTimFARh/giLweMW4K6WbVbR75z4cNENoV3Yf63mmbe
	U6bs7RA9nzDrkFuqckMg16JTi7GYP/443Kc8gFk0zSiK0t3Q/n92ysY=
X-Google-Smtp-Source: AGHT+IGY0XduAU+L9wttkINgVF16jQYQl+QvqQmcL7EkRupXJEb0+P/UxaSztaLkg2NzNGo9Qr0FJA==
X-Received: by 2002:a17:902:ec88:b0:234:adce:3ebc with SMTP id d9443c01a7336-2352a17fa26mr7265705ad.52.1748543900443;
        Thu, 29 May 2025 11:38:20 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd75e1sm15326985ad.112.2025.05.29.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 11:38:19 -0700 (PDT)
Date: Thu, 29 May 2025 11:38:19 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 2/4] skmsg: implement slab allocator cache
 for sk_msg
Message-ID: <aDipm6P+RWGD8j4M@pop-os.localdomain>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-3-xiyou.wangcong@gmail.com>
 <20250529000348.upto3ztve36ccamv@gmail.com>
 <c66ac1f6-1626-47d6-9132-1aeedf771032@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66ac1f6-1626-47d6-9132-1aeedf771032@bytedance.com>

On Wed, May 28, 2025 at 05:49:22PM -0700, Zijian Zhang wrote:
> On 5/28/25 5:04 PM, John Fastabend wrote:
> > On 2025-05-19 13:36:26, Cong Wang wrote:
> > > From: Zijian Zhang <zijianzhang@bytedance.com>
> > > 
> > > Optimizing redirect ingress performance requires frequent allocation and
> > > deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
> > > sk_msg to reduce memory allocation overhead and improve performance.
> > > 
> > > Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> > > Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> > > ---
> > >   include/linux/skmsg.h | 21 ++++++++++++---------
> > >   net/core/skmsg.c      | 28 +++++++++++++++++++++-------
> > >   net/ipv4/tcp_bpf.c    |  5 ++---
> > >   3 files changed, 35 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > > index d6f0a8cd73c4..bf28ce9b5fdb 100644
> > > --- a/include/linux/skmsg.h
> > > +++ b/include/linux/skmsg.h
> > > @@ -121,6 +121,7 @@ struct sk_psock {
> > >   	struct rcu_work			rwork;
> > >   };
> > > +struct sk_msg *sk_msg_alloc(gfp_t gfp);
> > >   int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
> > >   		  int elem_first_coalesce);
> > >   int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
> > > @@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> > >   		   int len, int flags);
> > >   bool sk_msg_is_readable(struct sock *sk);
> > > +extern struct kmem_cache *sk_msg_cachep;
> > > +
> > >   static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> > >   {
> > >   	WARN_ON(i == msg->sg.end && bytes);
> > > @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
> > >   	kfree_skb(skb);
> > >   }
> > > +static inline void kfree_sk_msg(struct sk_msg *msg)
> > > +{
> > > +	if (msg->skb)
> > > +		consume_skb(msg->skb);
> > > +	kmem_cache_free(sk_msg_cachep, msg);
> > > +}
> > > +
> > >   static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> > >   				      struct sk_msg *msg)
> > >   {
> > > @@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> > >   		ret = true;
> > >   	} else {
> > >   		sk_msg_free(psock->sk, msg);
> > > -		kfree(msg);
> > > +		kfree_sk_msg(msg);
> > 
> > Isn't this a potential use after free on msg->skb? The sk_msg_free() a
> > line above will consume_skb() if it exists and its not nil set so we would
> > consume_skb() again?
> > 
> 
> Thanks to sk_msg_free, after consuming the skb, it invokes sk_msg_init
> to make msg->skb NULL to prevent further double free.
> 
> To avoid the confusion, we can replace kfree_sk_msg here with
> kmem_cache_free.
> 

Right, the re-initialization in sk_msg_free() is indeed confusing, maybe
it is time to clean up its logic? For example, separate sk_msg_init()
out from sk_msg_free().

I can add a separate patch for this in next update, if people prefer.

Thanks!

