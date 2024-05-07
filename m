Return-Path: <bpf+bounces-28944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E78BEC72
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CEA289382
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0316DEBD;
	Tue,  7 May 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMkVTNNv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D81E534;
	Tue,  7 May 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109505; cv=none; b=HnA+vyea6UVEn5i3ObIZ7H9DOTgMTXmKHE9fYzLHB3G+ktNMqPxbCLTNiJL81coRtrhKUEks4W3yca6ii9aAfMBpEm24awb2Vf1NjoU72HZIKwbgAeTXS0/pTEGtYF/YUf0oKorVrIwYqsttRt1ow8xCyQlx/Jh8GMxuZXVba0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109505; c=relaxed/simple;
	bh=L10iW1XnYAr019F5MAAWEsx7pIjc8LRWcQ1HoQdQV0g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uyksxJ6wAEcleK6aRAKsyjTm8Qbv/tsTqILVFctzaGDYgtIiDX+cy9np+hyVEgJVfqIQfTNaP18jkMQyTbxhJVMIFfJl2epcz2CxsSlTdYEUy8xQZwoZaSm79SFttJaCXDd0pHodMGYaWkUkVbR2ePLkzZSZEk4cCQIFYwRhA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMkVTNNv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-434c3d21450so12950791cf.0;
        Tue, 07 May 2024 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715109503; x=1715714303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnFaPLp90E21WYAiuGhKeevnSOSTstIAB4WFXm8KCZo=;
        b=kMkVTNNvhX+rL3ttTKaWtaADU29HSWVG6r6usyE2INyEWZbaYTa0Zgwf7kzgm7D2EH
         IpeqFJ5GevugKUn6nDbsucdpiwT7piCIK/Ytn8yF0DQbSHzwAU6QmS9a/+3K8dUo5Z3v
         bjEOupREQ5iEab+BXfgdZa3/b6UjSebK7JAsYMjpFZuTAYAh++dp3NQNeAjGL/x2CuCa
         GrqXnGj9M9HpzyUj0AgMsWyMeiYMS0n1Uqa5ipZf6HhXb6YUxH+5dDWsR/+iNjk/DCx2
         /UiMWoltmnS7Jx00/C6bOPURB7Y5DxUBWnrxEuRAQ8HwE0+OIX73j/dMiCX5kQsgAFgF
         1Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109503; x=1715714303;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YnFaPLp90E21WYAiuGhKeevnSOSTstIAB4WFXm8KCZo=;
        b=aPWD0SwMGHIEFUHa/vWK+Mc+MXOBYADEZN8zTiIbsEFAH0L8Xw1DaT+oozo8aY+Dkx
         oT9c8kS+Msoy5Xlufbj5FUd6K+dZunGymojULK4/uKkRPMv6moCJX7dz13RHRlaXUsk6
         /08FzExpRbKJ2BEeBaBhpvxgeYgAdqxnWcD+8KwpqkLMLGMB02fRJCTCP9mIhEwHhLg7
         vnZhYl9VuUSsWNu6y+t7rAF/ogGYwwhKhMo0E54CBn1ObuVwXwwEGvm1dGmNXOnxSHst
         ah8EpCMLDEHjqcr/+fDl3TDsoVXVtny5+jE729+4z6O9kfLgzng6kZvGnDN6+pGLuuMQ
         LUJg==
X-Forwarded-Encrypted: i=1; AJvYcCXjd5x2E5Rd0wjD7JzZTFagyoFWM6KDOW1xi0jqkvnkQR2MfTmbVpIKMc89dnUafFRf45AfjfIjakmmgIlTZB9gAJY72tHnSdPvI1wtOUtX/eUFA+h1tDAfzdVFokrJ3vA3vREGC88eLNhGa9oBtGxR2JjuEF8cwOIE
X-Gm-Message-State: AOJu0Yx990DFa0EEs7W0qI45sxBz0axcuYi/A8l1v2XGKghTH/mvbMWi
	vX/TWpv6GjCvi8yjxN332IiCDouHpc6hSY1v4dx37sdf9RBn/FAX
X-Google-Smtp-Source: AGHT+IGBAmYjbwhToFiq6jwky+6txEoPz0UEsWtAY2wtqPyg7rJlQlTyID7vMECvdG4ZSAxrXQREfA==
X-Received: by 2002:ac8:5805:0:b0:437:9875:9905 with SMTP id d75a77b69052e-43dbf5101a4mr6806571cf.27.1715109502847;
        Tue, 07 May 2024 12:18:22 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b00436510ddc5esm6695624qtb.34.2024.05.07.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:18:22 -0700 (PDT)
Date: Tue, 07 May 2024 15:18:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>, 
 kernel@quicinc.com
Message-ID: <663a7e7e1f5b5_cc75c294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <fc8334a6-6961-41f4-affc-28bdfc3dd697@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
 <cab0c7ba-90bf-49e2-908d-ecd879160667@linux.dev>
 <663a12f089b81_726ea29426@willemb.c.googlers.com.notmuch>
 <fc8334a6-6961-41f4-affc-28bdfc3dd697@quicinc.com>
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

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 5/7/2024 4:39 AM, Willem de Bruijn wrote:
> > Martin KaFai Lau wrote:
> >> On 5/3/24 8:13 PM, Abhishek Chauhan wrote:
> >>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >>> index fe86cadfa85b..c3d852eecb01 100644
> >>> --- a/net/ipv4/ip_output.c
> >>> +++ b/net/ipv4/ip_output.c
> >>> @@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >>>   
> >>>   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
> >>>   	skb->mark = cork->mark;
> >>> -	skb->tstamp = cork->transmit_time;
> >>> +	if (sk_is_tcp(sk))
> >>
> >> This seems not catching all IPPROTO_TCP case. In particular, the percpu 
> >> "ipv4_tcp_sk" is SOCK_RAW. sk_is_tcp() is checking SOCK_STREAM:
> >>
> >> void __init tcp_v4_init(void)
> >> {
> >>
> >> 	/* ... */
> >> 	res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
> >> 				   IPPROTO_TCP, &init_net);
> >>
> >> 	/* ... */
> >> }
> >>
> >> "while :; do ./test_progs -t tc_redirect/tc_redirect_dtime || break; done" 
> >> failed pretty often exactly in this case.
> >>
> > 
> > Interesting. The TCP stack opens non TCP sockets.
> > 
> > Initializing sk->sk_clockid for this socket should address that.
> > 
> Willem, Are you suggesting your point from the previous patch ? 
> 

No, just for this custom socket to initialize the sk_clockid. It is
not a TCP socket, but only used by TCP.

