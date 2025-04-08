Return-Path: <bpf+bounces-55450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDCA80059
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FE43AB671
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B5268FD0;
	Tue,  8 Apr 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhVDrRXy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B190268C62
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111402; cv=none; b=Jijq0z3srYBCbsy6ZjvAHG0JWURc1M71XrFV92y8DKK0CLlnMUM3Bvz3XWqRBeE0oEc683IdvBo9MNvMfx9lS2EpJBkHHJ0EUIe8/IXdlycBQ9KeXD97cZwB0qp9KEdFZyrAShN6whGlRkQFeE4jjt1z22wD3Xs/57VIi4177hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111402; c=relaxed/simple;
	bh=7A2lFzcQs0+kGJmrB/0J9hzShIqQ79RoYmh3PkC/16A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFevxj0mjsT8Rt2ZR9IAN6NRj+wghqJ5WCacCH73rvTX/Q9oyw9Bf6nQdRA75SI5vPII7tI/8dVJbwftx7FzR8kvZCoJqNpS3vZJkB1iWCaAHzqopulrGZ0rLpEcjffMZo2jGFb1nN1obKzBn9TgQlC7+i20B6qa1IBS+nqEGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhVDrRXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744111399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUXxs671hXHelnn2s2t/j+j0/bqL54JMdDbZl2m1VKM=;
	b=KhVDrRXytyWSNm1ZnbnIwpdVP7xuJmaY+AilDKduSt6u5BzweHQWdyDEFF9C7Khrd4I9Rq
	08xpH47YhdtZ7B2zVCYqd8SXrQ3RGMcp42DaCqAtHpZWvyh+IGB47GOv7xy3biOdM/pNwd
	t2AGX9gEs+CwzOa1IVjb4PyhN+EGBus=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-K4ps4fz7OM6fZrWJDgdxHg-1; Tue, 08 Apr 2025 07:23:18 -0400
X-MC-Unique: K4ps4fz7OM6fZrWJDgdxHg-1
X-Mimecast-MFC-AGG-ID: K4ps4fz7OM6fZrWJDgdxHg_1744111397
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bff0c526cso28509411fa.0
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 04:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111396; x=1744716196;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUXxs671hXHelnn2s2t/j+j0/bqL54JMdDbZl2m1VKM=;
        b=Aw41ZIJF/pgwbM2qLnNIEUp11MDM1oQUgBxxgXwjQWa89zVIfv/pfrzCSvv1qxahQP
         FUTZxNEfxZkMJvGbiAAHxR7XYg+ZStzt3kfoU+5kzGEyxi6ECI1WMyCZoSdDSETzAz4Q
         LqQCfISQgYXHmSI2Hh8b8+ox0CZyEaT0rdSuv1AB8w9P8Kipsh07dyMMC62zLNB1TdY4
         Ol7qrxyqa48Z9S2HKbWLvBZF9diSNe1AofGGgdN1bRIfWzV8XGVDvKSjX09Ks9AuooIe
         xkQ/WK1eATdhipwModAaoul+Jjk8K/eoF9MkY/nctJ7VtZ74k4n5bcKJf9/eNTml50XL
         Aa2g==
X-Gm-Message-State: AOJu0YxVjVCy84aDVDyiUFCLolRxfp4ITjZEJD8ZAl5wqOPBCZRB5tV0
	ruccQI2ZoR/CZ4mAZ2zKvnbaX40C/pe59SA1pvbKlZEGhruhv+nSt7JutOIl1nsZW9Td76w2kG1
	h2h8YsXqF0FPYN9ecuyEOE/63LeR9M0DWRKYB7fTPimjqXmWbrw==
X-Gm-Gg: ASbGncut3nfNpT4lZUb+QYRaiWWPSedg3Wnl8ZKH7Ambqfkj6aujyllspYzjuvj4naE
	1uaUw3RpXcOC2LCwtzhoRsRX6LRP0s8yrIhk5K1DQe/elE4tAw2Qmd88tlsmZ0+v5YwpFQCVMZl
	Al4WsDie9exM5IYB+OpWrvtbsO3MvZcMNt4HjG6ftZHkUtiTgRdg1q3i2HjcB4GswcXWOgj4JcL
	TLJUZ/LO0oCCbJZ7rZNuqz2vRE1PVM8YNxdQ7luJxysHmGsCppn0XkLP7SDC5OfmPLoYVfftIJ6
	lSEIGTwir12sxTafoLjMGFyHmRbhoDsF1jfIZb4g
X-Received: by 2002:a05:651c:2210:b0:30b:b8e6:86d7 with SMTP id 38308e7fff4ca-30f0bf4e0f8mr43961391fa.22.1744111396587;
        Tue, 08 Apr 2025 04:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHugZrZBe1olwpKjHjP12g8dE7uL7NLACvHaa6+imASaWUZ8UVY2RIoJIIgvMdOJVMZDs2+lg==
X-Received: by 2002:a05:651c:2210:b0:30b:b8e6:86d7 with SMTP id 38308e7fff4ca-30f0bf4e0f8mr43961321fa.22.1744111396226;
        Tue, 08 Apr 2025 04:23:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f03141cddsm18444941fa.41.2025.04.08.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:23:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A7841991DF5; Tue, 08 Apr 2025 13:23:14 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
 <87a58sxrhn.fsf@toke.dk> <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Apr 2025 13:23:14 +0200
Message-ID: <87h62yx5gd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 4/7/25 3:15 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
>>> +{
>>> +	struct Qdisc *q;
>>> +
>>> +	q =3D rcu_dereference(txq->qdisc);
>>> +	if (q->enqueue)
>>> +		return true;
>>> +	else
>>> +		return false;
>>> +}
>>=20
>> This seems like a pretty ugly layering violation, inspecting the qdisc
>> like this in the driver?
>
> vrf driver has something very similar - been there since March 2017.

Doesn't make it any less ugly, though ;)

And AFAICT, vrf is doing more with the information; basically picking a
whole different TX path? Can you elaborate on the reasoning for this (do
people actually install qdiscs on VRF devices in practice)?

-Toke


