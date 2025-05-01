Return-Path: <bpf+bounces-57126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB26AA5D64
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43ADF1BC5847
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97115221DB4;
	Thu,  1 May 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwNJAdbr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1C21D583
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746096195; cv=none; b=aZoZgYqCW1d8mou/BBhbxPeJMPmle33bALRogrkXuZJpcZk8+jXMYQ7fSmj/9KIsEm5w4sfgt+uAfI+MKEi6exQO+IbT5YVTW+i+nx3/7Y2/lz7J0By685f1PueyyNwmRPm0zu2QTYTAaX+670RmpU7is6ghDLkARquOh6bRilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746096195; c=relaxed/simple;
	bh=uFwiqbBT7QiRct0/SRVF+W9Nz3gjwIgP+qqQUe/60xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AG1XL0exFxJQRxA/MlvxsusJ69Xg2SvWLi3UrufgXWgyQnK2OvsEQUyILkSPPcZZnixNkR2gLknu6llzPKRTyAL1ahhRDyunaPBeBdH+imXvhTAEXWCKCRfGGB5LG2PH3SbdfYYQ5zrh+0/zLWJruVnxpPHDLLZqanUaXSlftBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwNJAdbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746096193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiDFoQOB+YriU47Yf7CEanBcEHOAtpPsQZhUMA1nA84=;
	b=IwNJAdbrwHE1I6TOjo9VCEKVc0YfUNzvuh9ZKMVWGxdxksAtDCKpO0gfBGH0mNfY9lngLC
	mRse8op7N2Rt2NKFejwPhf1ciAgABglH6Gcv5LYCsd9NbnOuPtME/njsaAsSYvpQg4M6Zq
	PcxBJBwny1t013ad7ZSpiu3TS3sC3Us=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6ae-Q8TePGuE-_GNzjyWfA-1; Thu, 01 May 2025 06:43:12 -0400
X-MC-Unique: 6ae-Q8TePGuE-_GNzjyWfA-1
X-Mimecast-MFC-AGG-ID: 6ae-Q8TePGuE-_GNzjyWfA_1746096191
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54c0a1ca4f7so367325e87.3
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 03:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746096190; x=1746700990;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiDFoQOB+YriU47Yf7CEanBcEHOAtpPsQZhUMA1nA84=;
        b=ojoIbl5+Ye18GrUDsZ4U9vD0vHwQHAXdvUeNe9ddkqTGoSDY/0jIR2mZnTw9XTIgwp
         g42ub1BgjAzswBQxn5UBOj0kz3mMicM47epbngt5NEaSMEQDE7boop9L8Nh2AzCqncn+
         MQsXEwEwGniYh6dg5saTWZBkWu/T41gW48SWjZr+VoxFsvX2xCVNsDrznYpqMZ+avLAi
         jlILVpDClA2A6A6Bc+GXPTT51sdAZK6yoSI+xzfxQ2b99vfKa3elcSuw3V0hOz6OcZCU
         YcQsZdObb6vAR1Ha4EJVaywM4n0/qBvj+vHWBCIgf4ZtNR+bMY7/JrxAEzMAIe+m4aHt
         g2ew==
X-Forwarded-Encrypted: i=1; AJvYcCVxAZ+sOQJcIQXFmPvlw8C+krD4zwPKlpyYYkQUJTx0HBwsj4sjmGo1umSbFQV+MhtdilY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+efZFoIFdDvsKLQGCNoaS7JFVIOBgvr3QAWkt15dkHSzimwq
	T2L+AlPRS/5uVpm+TsGcNn09u5N2A88Bda1yxysDQ80MhS/7ojTjq1SQV47MfcCF/Mvc8CKKEZJ
	dfIkC06iMBi8kUFYbwjRNekn1kr/cThzadZkwBEfO1UxAR9yiEA==
X-Gm-Gg: ASbGncu4bSEdys7fptxXVQx4XQIFeLAOlnYxlmk82zG2xifnNoGKHJXg005yLyk0MSJ
	dCeI2NmMcNzBxPK9HWHSOOo9fBwXedX5DcmwnrhUqPpY+t8AU0z2MkFAunxynRkyJmCNynhR7QN
	npNZgE+kk6RzN0a9KbFTxWjsIflNGxs6bVTtJL+RFCfDtNF1zqYoyJjhPnwWuK8H0V+RgYjPl24
	3b1Ldj85A/KIQJ42z4G4bnXDhoXInwOIinYpsCDRywX2dgXRlGmFFE1c84G4onQPlOg1769qstk
	q54nNlgc/5IdZ71+/rp6QcN019syh0D17EUP
X-Received: by 2002:a05:6512:23a3:b0:549:66c9:d0d9 with SMTP id 2adb3069b0e04-54ea33b45f7mr2109626e87.53.1746096190497;
        Thu, 01 May 2025 03:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHngkBRxO36POnN4Us1uA3Ii4VPY1PcVyxolJIqXZfmRksIwyZrazkF5hMgJ4+LQ7HoOSyNXQ==
X-Received: by 2002:a05:6512:23a3:b0:549:66c9:d0d9 with SMTP id 2adb3069b0e04-54ea33b45f7mr2109614e87.53.1746096190075;
        Thu, 01 May 2025 03:43:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c08e7sm62779e87.73.2025.05.01.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:43:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3EF91A0825C; Thu, 01 May 2025 12:43:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>,
 jbrandeburg@cloudflare.com, lbiancon@redhat.com, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <87ikmle9t4.fsf@cloudflare.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
 <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
 <87frhqnh0e.fsf@toke.dk> <87ikmle9t4.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 May 2025 12:43:07 +0200
Message-ID: <875xik7gsk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki <jakub@cloudflare.com> writes:

> On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfab=
re.com> wrote:
>>>>
>>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurf=
abre.com> wrote:
>
> [...]
>
>>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>>>   (via kfuncs).
>>>>   But that doesn't expose them to the rest of the stack.
>>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>>   kernel to access and modify them (for example to into account
>>>>   decapsulating a packet).
>>>
>>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
>>> with bpf prog in skb layer via that "trait" format.
>>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>>> The kernel doesn't need to know how to parse that format.
>>
>> Yes it does, to propagate it to the skb later. I.e.,
>>
>> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
>> CPUMAP: build skb, read hash from traits, populate skb hash
>>
>> Same thing for (at least) timestamps and checksums.
>>
>> Longer term, with traits available we could move more skb fields into
>> traits to make struct sk_buff smaller (by moving optional fields to
>> traits that don't take up any space if they're not set).
>
> Perhaps we can have the cake and eat it too.
>
> We could leave the traits encoding/decoding out of the kernel and, at
> the same time, *expose it* to the network stack through BPF struct_ops
> programs. At a high level, for example ->get_rx_hash(), not the
> individual K/V access. The traits_ops vtable could grow as needed to
> support new use cases.
>
> If you think about it, it's not so different from BPF-powered congestion
> algorithms and scheduler extensions. They also expose some state, kept in
> maps, that only the loaded BPF code knows how to operate on.

Right, the difference being that the kernel works perfectly well without
an eBPF congestion control algorithm loaded because it has its own
internal implementation that is used by default.

Having a hard dependency on BPF for in-kernel functionality is a
different matter, and limits the cases it can be used for.

Besides, I don't really see the point of leaving the encoding out of the
kernel? We keep the encoding kernel-internal anyway, and just expose a
get/set API, so there's no constraint on changing it later (that's kinda
the whole point of doing that). And with bulk get/set there's not an
efficiency argument either. So what's the point, other than doing things
in BPF for its own sake?

-Toke


