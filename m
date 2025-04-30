Return-Path: <bpf+bounces-57090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D515AA549F
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB134A6CC1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCC226988C;
	Wed, 30 Apr 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jy/N7ZZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0862609E7
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040798; cv=none; b=VdrnGmXw1FuNOS8SQryuIWxLqI0Lrn9lcmekk2Nqh/oyz6lbbdrV9aQMypguESVittrv1107Lc9/cgXwMenmrHDwR39MWGKjFluZYSm73y00yi/48Egjib83UlXJzKY9ZaLbr4xf0VY/55id47yGzVgm/oLofbV24TR0rHvC8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040798; c=relaxed/simple;
	bh=YPGb8orVplzGnjnESqlgmgnu8BGnCi4sxA7Tu7rueN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+z3R+8ZmoNOlcfHJ98+8pLXBSeJPfS5zH3ECehztVDLCRTrHLVGBr2NcC3OQoPsrhGKJg3jebva27x51T23JxJ1lH+44ygqreeI1+UszosuDozB1CeR03FUIiUYK1mwgCFMQ3ZwZ9a4/tOAL28fGCCrZLCrwZdZS7ctm7a8WwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jy/N7ZZK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so310560a12.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746040795; x=1746645595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kpEwqfDzBbGKQdnSl3yMorTl0nsw+Xb/pGmM7auwuo=;
        b=Jy/N7ZZK/tiBMPi1nhym/IElAspxpkLaL0kvT6wcvuhsY+qtz4/lOZCbta/N79qzDe
         BLDm71nWnDuLnQgLp6YGLBtmJv4ffjL7b8LYDinA9I+OCABJXFEvlAWoXH90XjTo01rW
         Yx5nf4Q0VyDqzgnOFfQN/PrQAANvZUJJh4H+L7PDgTZwcsXb8VdmsWrEaRU5gGnHLVJ0
         FyX35aoCsahIenCiYTzRjvscPMqM1oJixlK9gNeSkPF+xcM3ijn0M+jyoTDOs+H8/G5n
         UkrwfgNSpaXbWDWWBPB1nw5m0a1a1jNQ8EkPf5X/55C7SXqXFgjhugwVUTZglbC/1LKx
         R+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746040795; x=1746645595;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kpEwqfDzBbGKQdnSl3yMorTl0nsw+Xb/pGmM7auwuo=;
        b=O9QmiQVpylZMr6vZkA4G2atpTOrTct84u7RdY6DzGDDkOIqQJPqyV7a6NnJyNXI/iU
         1278rq6Lvrls4zbOAD44n9J9Oywc21aMiRh5UEQ5vrqmgQsMOELOoXuHWky7lWaaFNnh
         ZpOEuYx0HYdcQ3nQH1QWpNLjgJKA4JnbmqpgL+tv5ABdYIbznvJOY7Qzu1eXIJj5uEN2
         0bSHjrppX0QMJRIN3AASt+E6lp2usmUWSX0kbwcM97A1mzK/YZX1EooveBxwbLskfdl4
         Z0Li7/B3/qMEF6KcCTsAjGGS86EGO2bro0H+De/kWcXe6WpmJcHtWrdp8uKbjtNzm8pm
         v0CA==
X-Forwarded-Encrypted: i=1; AJvYcCUomwyJX8GnJeBS5e5tE1grWg4kIRYkdB4K8t4fF5xA39TLrLvIbPgEZg404ZYhJzDpA7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u4k6/eaixX7Wvj+LrOLv5h7/fU43hfGSabzs9iVadPjkZxOF
	rscVISjcXwd/l45wcHOpl/q2BCconzq7FtCK0aQmMtToKUWtj+Y4/gtKby0bSeE=
X-Gm-Gg: ASbGnctqvfV42kfTInt5Z5H+RPz+noqiEM/GS98/DAQ5ylIY+DwSHWUdS2YDvB3heLU
	Osu+VNFRk1D5HfBhooOlU8NzjyIXeZA86dySI8mamO1Wriuv5KGJqZJqPtnUKNmawI6KxRleEyc
	NR1ESnC52WF3RJM6/g4wfm1M9BW6zUphmdweF+ZqH1uh2a+BUqO4d4NC4Qpkp1gNVJWacaYUeWS
	doLXuqDyfI+GFyfOfBlk0AqQ8dybWjytB6Pqrrk3Pcd42tlogS8OMatH8KmDrJXnV1rCXH48ZbY
	eBTwNPfmbOuqoPdFezTeqVcc5lYZEstazuiv4/5uR8wx
X-Google-Smtp-Source: AGHT+IEd0NEegRoc/fcA5y5/hIIqYPu0koxO5Y7C6jpUVjF9Jb63DctkspNIVv1+JF8b0/hlKFDG9A==
X-Received: by 2002:a05:6402:5205:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5f8af09ae61mr2965964a12.23.1746040794653;
        Wed, 30 Apr 2025 12:19:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:b5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f6770sm9236861a12.43.2025.04.30.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:19:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Arthur Fabre
 <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,  Yan
 Zhai <yan@cloudflare.com>,  jbrandeburg@cloudflare.com,
  lbiancon@redhat.com,  Alexei Starovoitov <ast@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <87frhqnh0e.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Wed, 30 Apr 2025 11:19:29 +0200")
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
	<20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
	<CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
	<D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
	<CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
	<87frhqnh0e.fsf@toke.dk>
Date: Wed, 30 Apr 2025 21:19:51 +0200
Message-ID: <87ikmle9t4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfabr=
e.com> wrote:
>>>
>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfa=
bre.com> wrote:

[...]

>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>>   (via kfuncs).
>>>   But that doesn't expose them to the rest of the stack.
>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>   kernel to access and modify them (for example to into account
>>>   decapsulating a packet).
>>
>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
>> with bpf prog in skb layer via that "trait" format.
>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>> The kernel doesn't need to know how to parse that format.
>
> Yes it does, to propagate it to the skb later. I.e.,
>
> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
> CPUMAP: build skb, read hash from traits, populate skb hash
>
> Same thing for (at least) timestamps and checksums.
>
> Longer term, with traits available we could move more skb fields into
> traits to make struct sk_buff smaller (by moving optional fields to
> traits that don't take up any space if they're not set).

Perhaps we can have the cake and eat it too.

We could leave the traits encoding/decoding out of the kernel and, at
the same time, *expose it* to the network stack through BPF struct_ops
programs. At a high level, for example ->get_rx_hash(), not the
individual K/V access. The traits_ops vtable could grow as needed to
support new use cases.

If you think about it, it's not so different from BPF-powered congestion
algorithms and scheduler extensions. They also expose some state, kept in
maps, that only the loaded BPF code knows how to operate on.

