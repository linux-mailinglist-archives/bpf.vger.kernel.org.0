Return-Path: <bpf+bounces-61075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5483AE05A3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932833BFD38
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E74253951;
	Thu, 19 Jun 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk74tioi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10F23E352
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335791; cv=none; b=YRiTEsJ7itmAZ6CiMX/ydTaw8dupvKcuPw81MgqGQtIGs1FriQnBbwq+QzwPnn93zW0HChLQbg2hrxP+VKmvMEpUmuRhwjN8Vo1t55MrZQY16bS4xfgCDJW9gqJ4q9GF+e1Bq9rTjTnfOKC3+Pbdov74ALzLDTkd+q+8zFrVheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335791; c=relaxed/simple;
	bh=MIKtY0BvtPRI4kc9quUsIW7X5PfhYEFyxPZ0dKgQPX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvboKzFwjY6MX5r/Ffcm/G3pwzmNSyYpwRykQyRzoFLexZxVp21ccJlD0bf5etz62DKcJ5DqSygO1LqEivKguoZ/4FJavAL9z6Z7EumJN6mOGALKBf6qT6x2BRnlS2kY4243xv2AhosUWCWjxcSDT4LJG7BhV47I1DBCWn40Dws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk74tioi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750335785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KpYzqUd7ABNQiXSwViTJe4TJ5xM7gccbgQGODhfMxA=;
	b=Lk74tioiO5TX8msg/BkbskImfjp6xM09RECZ+m3CHkO2UtsoBkmMNIvmaDXoQeEAwYwN/6
	2gIi0Car0IZQxYLAVyodyJn8vF/5y8qd8Vzo4Zw/zb+iT8BQtxiOZqZ86ZqbefKiVsMCt3
	0jpDySfVrtwA7y3kMWKgJPBaw+BhLeg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-eZLk54xVPO-F1HE1r8b-3A-1; Thu, 19 Jun 2025 08:23:04 -0400
X-MC-Unique: eZLk54xVPO-F1HE1r8b-3A-1
X-Mimecast-MFC-AGG-ID: eZLk54xVPO-F1HE1r8b-3A_1750335783
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50b9cso67903766b.1
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 05:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335783; x=1750940583;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KpYzqUd7ABNQiXSwViTJe4TJ5xM7gccbgQGODhfMxA=;
        b=NkHdeC4y0GQwNFv1GzyjcUbV83eXpPcEs6GAvHHHINapgXOGY4VY7bW8/bPm2sqv7R
         REGYJd1leZZOWg22KTjc41FsSvzIKdme+HXbGI6dFmDnVEzYMDbqgYPx6fu/dc548ptw
         +7+ReBiIc5cCIJndd0waT3cpLOuHIe/ZodNa1gZCJ8gkra5wsx+e7vr7sgcK1/ug9rHa
         I+N4NtPq7hZ4KCeg4St9aXK09xUHRLCS2odGmD9ZRo1rLwKH9xhOAWpV+JEYH0Qv6Z4X
         8scQr+gJkF1tScif9Q2xIGeRy7wbNVcoUSsTgA0fchn0E7VfDBTVKLbtKqyj/Jl1Re/s
         J0/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJFWIQdOlC5jsXxNJSMp96ubhFfgk5nax565sogR5FHP3Gywkq0KwHRqO5NKSWLKDBFn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJffMWsjkRECqYrgQaTMi6JMnunsiynj7aV8uqQB3/EpNDCkeV
	mcZisitSoST2yhKm+Y2vfUgdJNsAloyNI4Y/Q4ClU+Dj6qIJcTKaxULWOAed2v+tNSnhR+R9Lug
	X8+MjUuciv/dxAYShKd3RfDYQtKPaTn0tlhL+XaOrN0wNn1873GmVXQ==
X-Gm-Gg: ASbGncvLwHX8D4bfkkkIlfT3ewguqSF8WzA/q8bWpb9wPXavpTkE3G1JovMzZrc8Zr4
	bjQrhn2QVMxpzJGokIiP1thdqIVToIQl77n3ABKS93NajhvLpH5BYYXVdPdtsCahex6XaDEiWt2
	La8PzMuAPSw29RrsCrVsYajDNymwbEgUHP6pD1nIy1V1l7QY4uH2LAZ6u/ofQ6vxIDHX7jzAu7C
	mY9HFVG0+w4ExOqYAPWC+Qg6lDicObKuKURispZmRHNXLYgTKLafXpaXTs8Ccnv2+gxgKaUxzko
	XkdI/87QQBnTkwi7UD0=
X-Received: by 2002:a17:907:6088:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-adfad5a09f1mr1950020066b.44.1750335783127;
        Thu, 19 Jun 2025 05:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdUZpMZoEiEL3xKFyHM/vo4NfGyuSlw67YC11LIaoKw4eni2OhhMoNfujt2lmufd+7RzEBsw==
X-Received: by 2002:a17:907:6088:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-adfad5a09f1mr1950017166b.44.1750335782611;
        Thu, 19 Jun 2025 05:23:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf60967c9csm1104353166b.33.2025.06.19.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:23:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0EBC01B3727C; Thu, 19 Jun 2025 14:23:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Willem Ferguson
 <wferguson@cloudflare.com>, Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: Performance impact of disabling VLAN offload [was: Re: [PATCH
 bpf-next V1 7/7] net: xdp: update documentation for xdp-rx-metadata.rst]
In-Reply-To: <cd4f2982-00ff-4e7b-88e1-6f6697da2c2f@kernel.org>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
 <87h60e4meo.fsf@toke.dk> <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
 <875xgu4d6a.fsf@toke.dk> <cd4f2982-00ff-4e7b-88e1-6f6697da2c2f@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 19 Jun 2025 14:23:01 +0200
Message-ID: <87cyazc44a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 17/06/2025 17.10, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Later we will look at using the vlan tag. Today we have disabled HW
>>> vlan-offloading, because XDP originally didn't support accessing HW vlan
>>> tags.
>>=20
>> Side note (with changed subject to disambiguate): Do you have any data
>> on the performance impact of disabling VLAN offload that you can share?
>> I've been sort of wondering whether saving those couple of bytes has any
>> measurable impact on real workloads (where you end up looking at the
>> headers anyway, so saving the cache miss doesn't matter so much)?
>>=20
>
> Our production setup have two different VLAN IDs, one for INTERNAL-ID
> and one for EXTERNAL-ID (Internet) traffic.  On (many) servers this is
> on the same physical net_device.
>
> Our Unimog XDP load-balancer *only* handles EXTERNAL-ID.  Thus, the very
> first thing Unimog does is checking the VLAN ID.  If this doesn't match
> EXTERNAL-ID it returns XDP_PASS.  This is the first time packet data
> area is read which (due to our AMD-CPUs) will be a cache-miss.
>
> If this were INTERNAL-ID then we have caused a cache-miss earlier than
> needed.  The NIC driver have already started a net_prefetch.  Thus, if
> we can return XDP_PASS without touching packet data, then we can
> (latency) hide part of the cache-miss (behind SKB-zero-ing). (We could
> also CPUMAP redirect the INTERNAL-ID to a remote CPU for further gains).
>   Using the kfunc (bpf_xdp_metadata_rx_vlan_tag[1]) for reading VLAN ID
> doesn't touch/read packet data.
>
> I hope this makes it clear why reading the HW offloaded VLAN tag from
> the RX-descriptor is a performance benefit?

Right, I can certainly see the argument, but I was hoping you'd have
some data to quantify exactly how much of a difference this makes? :)

Also, I guess this XDP-based early demux is a bit special as far as this
use case is concerned? For regular net-stack usage of the VLAN field,
we'll already have touched the packet data while building the skb; so
the difference will be less, as it shouldn't be a cache miss. Which
doesn't invalidate your use case, of course, it just makes it different...

-Toke


