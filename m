Return-Path: <bpf+bounces-28808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB458BE117
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE441C21A2A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479E152DE7;
	Tue,  7 May 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6QMOun+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E36522E;
	Tue,  7 May 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081971; cv=none; b=RXKPuG1qve3GlXBpbCmugbH+z6UN4uaAocsycXpPLitmXJYxE7bOluGh8EfeM1QV0iQlPOXSoaMwhBkUMI96R2QtOecGw4h7hbRT4/WWLAZdSSvX9zBE4XfB9RfAVjZwgoHvngky4Bbgjn/ETqFwvvFDJdIQKucgZQFp8OIu/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081971; c=relaxed/simple;
	bh=QWRglvQC+Ilxa+wYRcwzz9FMw6bA6Z/0j3tXMZ1TDSM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q/lGK1+F7KuF9P0ItlhC1NHUOOKwp1HJbiKGK8DiWgShRsIqPkD0lhtNs0wWXvmVLFV0B+QCm8Y9A+g4qMpc9C6+QYz/VTOr5s3fxxCNnz8J2YpRis4b1ZW7TbUehwAaflV/HAC0qJ/td7+ivTcZ5b8whz0xBUlMzaP8uIL7uTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6QMOun+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43b06b803c4so20435271cf.1;
        Tue, 07 May 2024 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715081969; x=1715686769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc2Fh6vr9HEHKy+AiZntTDAKa/QuaWvCqXRib6VLhHw=;
        b=K6QMOun+SSSrGpJzlvMhU23ylUYSG2c0tdyw/O0E3Kwcya2bke5YQazo9EGKSmOe8j
         6l70QSXWCivLUeeRZtzmpQApXuw9PCbc8HoR1bL8XVEl8Tav1qS78/cHBeUcJtShQ6j5
         9HWBl82uUVuBU230UfAEZyHGSE25XPvh5P1/Ty0yk77D63VdsRxJpDOfpihnglLoMSsH
         JRVPcyBg7XFxobjJZsyse55L5esqzJi+IV/tiHDeVCkuaSX9Gcgtx+e7vGT9XLgQ9icV
         rnDzR9+QVRhf5oRkpgSoLdvoVB6Sh2fGeVwfRv8yElMaz0yUJobZQ1ABDroLFLaANv2p
         RcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081969; x=1715686769;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bc2Fh6vr9HEHKy+AiZntTDAKa/QuaWvCqXRib6VLhHw=;
        b=i/u69gyZXQuPwmyz/bGLAWutoshkQM7RvSReX6b8QuJJWQ6TqouAP7ue9klaGnco3w
         JzG2yvAOYgk2JJeDhy+c4G5093TY3/gKGpLy1BgsybiGos6GN6ZX0pZ1aWFWbAOiSekF
         IWKq9ABw4QyXDdcAingzkLFaBevVtgzutBsuwLTVtzqjwphhAq+kNZPEJuYCPGEgc6m2
         pjIYBJQgtULobNAnmx37Oua6FW9gYQTwJ2PaRXO4t61QiJfMzLzddvtMGpB73HUL1tGV
         eQU5BpotFBoCQx48dAiCEbeB6rF01nBXSZBwwhvVxC6b/hbn2wsgvt5tQFLIuPRvhnOJ
         4+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUG/KuANAgr7rQGxsMBF8MwLOmYbIT5GHjLAUJ7IaRx++jo19qC4X0JjNUaGV4nwtAQzr9HdkXeahGqUNSEICQqd08K6KzX+5f5xgW56DHrKcOdtfiuHpkxLX7VsQG+7C9CNQxLAVJTH/30DLJ5hc/7kEtIuvW50t4y
X-Gm-Message-State: AOJu0YxTXs8lkR9Xwunj2eZRInZcsl82TYWBYw88NW24WGuQzjJEPdd9
	pBuSRfy1W/nClOZfGhB8Eg9XQh+dpLtYu7P4ZW5EK3+hGxNDfxd2
X-Google-Smtp-Source: AGHT+IEYa1mU6Tp3WBhIuUW/Dh9bS9a+VEaM8HEHI4XcFgssU84GL0HCwzAqkeL25nS4PeYPzFRieg==
X-Received: by 2002:a05:622a:2989:b0:43a:dcd6:6507 with SMTP id hd9-20020a05622a298900b0043adcd66507mr17632581qtb.50.1715081969095;
        Tue, 07 May 2024 04:39:29 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id er5-20020a05622a5e8500b0043cd93be06asm5598868qtb.62.2024.05.07.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:39:28 -0700 (PDT)
Date: Tue, 07 May 2024 07:39:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>, 
 kernel@quicinc.com
Message-ID: <663a12f089b81_726ea29426@willemb.c.googlers.com.notmuch>
In-Reply-To: <cab0c7ba-90bf-49e2-908d-ecd879160667@linux.dev>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
 <cab0c7ba-90bf-49e2-908d-ecd879160667@linux.dev>
Subject: Re: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support
 clockid_t timestamp type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 5/3/24 8:13 PM, Abhishek Chauhan wrote:
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index fe86cadfa85b..c3d852eecb01 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >   
> >   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
> >   	skb->mark = cork->mark;
> > -	skb->tstamp = cork->transmit_time;
> > +	if (sk_is_tcp(sk))
> 
> This seems not catching all IPPROTO_TCP case. In particular, the percpu 
> "ipv4_tcp_sk" is SOCK_RAW. sk_is_tcp() is checking SOCK_STREAM:
> 
> void __init tcp_v4_init(void)
> {
> 
> 	/* ... */
> 	res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
> 				   IPPROTO_TCP, &init_net);
> 
> 	/* ... */
> }
> 
> "while :; do ./test_progs -t tc_redirect/tc_redirect_dtime || break; done" 
> failed pretty often exactly in this case.
> 

Interesting. The TCP stack opens non TCP sockets.

Initializing sk->sk_clockid for this socket should address that.


