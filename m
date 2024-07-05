Return-Path: <bpf+bounces-33954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3092896F
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E873B1F23776
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703314B957;
	Fri,  5 Jul 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMZ0wTLA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB6148FFB
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185521; cv=none; b=ssabFUECdjqDCO4r4v/Z3EHtAAy55G34gvM8D8XQ0gI3gKjz7uEwOnDohgBGcK3CYv7NWwQEQ0QxfBMO0f7aj8dg/lD5NHQAasGe5za+9nJBD8mNup/v0/T3WARlBjmBZSKciDtgk3q4SHsstsvinZRVEouI4jICSSfd3S6FrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185521; c=relaxed/simple;
	bh=XabRrceFxcF0KBIJc9MbE+XTnegGGAzIgYPWZjAd71I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekFDSv+hKSz1ACWOxvvy+VjlqNDkczIUZU6VN1teBR7/RG1fpcdbALP7MBkon2xHm/EQBr9wHFbamrhpF6vntmMZJGojl2rYr24HBNqEeG36lvFx1t3U+5QvBBkBd60XK0Dv8TLUuzNZFlcUXyjcSNPaOD7oiJgWGXEnZGjS0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMZ0wTLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720185518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62aYuvlj0aJrfftHw3OdTbReRjrfxK3xjdMTv0VrPgI=;
	b=PMZ0wTLA0Q73V85WsF4WzwrjNZVUjiMuTRWHAuW0YieBThSjmv/lXC9aEcJmP5BWBRFfSp
	ZCSzs8fa6Ot25uONkwgCzTQ+ztQmlQsY8HdU4MPQLzxpt+NJwEzVa4oWwW+6Udr9J4WetR
	kaPQjyWrdpeuK1wNcXZJsuFs9ahqV5c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-acgvPzsSNbOKb3ba-MdebQ-1; Fri, 05 Jul 2024 09:18:37 -0400
X-MC-Unique: acgvPzsSNbOKb3ba-MdebQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77b2edfe06so130989166b.0
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 06:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185516; x=1720790316;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62aYuvlj0aJrfftHw3OdTbReRjrfxK3xjdMTv0VrPgI=;
        b=CkK/Et3+R3klt0aioz1I7M4SYGiltGOx8GRy4+X6qkIcXJEDt/eOn8fKuft1zSSG5/
         mgrnEAaViwixwEFfXMH79arDLodEJDpZC+JHk6Kh0fHav/u5SRC03qguvNG5NRJJ32kW
         M1D+oqmJzYDj0Q3i3VPaIT5faxRn1FJ6zwv9ZPG597sx8QViaDIsGdU6qcwZE+733fpV
         GkZsSBejlELoLpHabmtu/TJvuXlRAHkLJ8JLeKNIpurA5SzuKinG3xiHkb021Q1K91Kn
         DS6H2Qyj8o6yAjXycFQS4xjGfyUTJESCwaMuvPgOWn1rLiDtnMJsFCPH5YkV64P/U3+k
         NsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIqB+UxY3xgnoHUGuvJ7LGNkeLnJbJXpDpXG64TsdqJz3TYmjHoFjvDiHFY+NVtsi0q0PKqtFnnnRUN6ghoVBS8Ih/
X-Gm-Message-State: AOJu0YxmEkWB4tdqz6/Leuz4jk0DxBSbz8+mn7W55WquS54v5RjPADpT
	rqPEWqXfqFy1h1aZ6Cxkwo8YeJCXRA1cNfKQP3wT4/hvu+rHjxkAtoPQeSWbO2eBh41YIuUZTx4
	wqJA655/AoUqeDsRy6vGpfqnP9RZzdmpiWOQE5ARi6WO0z1W0tQ==
X-Received: by 2002:a17:906:c9c6:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a77ba70e46bmr325709866b.37.1720185516240;
        Fri, 05 Jul 2024 06:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb9mUZwv0LhDRrdW6Gq2ToasHLSkXTvO7pDP+kDNwoiP/yJeMD+4Nmr3QADNVIspVclQSnJQ==
X-Received: by 2002:a17:906:c9c6:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a77ba70e46bmr325706366b.37.1720185515818;
        Fri, 05 Jul 2024 06:18:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c2aee010sm103537566b.102.2024.07.05.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:18:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A1F313FDC48; Fri, 05 Jul 2024 15:18:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 xdp-newbies@vger.kernel.org
Subject: Re: [PATCH] bpf: provide map key to BPF program after redirect
In-Reply-To: <987c3ca8-156b-47ed-b0b6-ed6d7d54d168@linutronix.de>
References: <20240705103853.21235-1-florian.kauer@linutronix.de>
 <87zfqw85mp.fsf@toke.dk>
 <987c3ca8-156b-47ed-b0b6-ed6d7d54d168@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 05 Jul 2024 15:18:35 +0200
Message-ID: <87wmm07z9w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> On 7/5/24 13:01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Florian Kauer <florian.kauer@linutronix.de> writes:
>>=20
>>> Both DEVMAP as well as CPUMAP provide the possibility
>>> to attach BPF programs to their entries that will be
>>> executed after a redirect was performed.
>>>
>>> With BPF_F_BROADCAST it is in also possible to execute
>>> BPF programs for multiple clones of the same XDP frame
>>> which is, for example, useful for establishing redundant
>>> traffic paths by setting, for example, different VLAN tags
>>> for the replicated XDP frames.
>>>
>>> Currently, this program itself has no information about
>>> the map entry that led to its execution. While egress_ifindex
>>> can be used to get this information indirectly and can
>>> be used for path dependent processing of the replicated frames,
>>> it does not work if multiple entries share the same egress_ifindex.
>>>
>>> Therefore, extend the xdp_md struct with a map_key
>>> that contains the key of the associated map entry
>>> after performing a redirect.
>>>
>>> See
>>> https://lore.kernel.org/xdp-newbies/5eb6070c-a12e-4d4c-a9f0-a6a6fafa41d=
1@linutronix.de/T/#u
>>> for the discussion that led to this patch.
>>>
>>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>>> ---
>>>  include/net/xdp.h        |  3 +++
>>>  include/uapi/linux/bpf.h |  2 ++
>>>  kernel/bpf/devmap.c      |  6 +++++-
>>>  net/core/filter.c        | 18 ++++++++++++++++++
>>>  4 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index e6770dd40c91..e70f4dfea1a2 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -86,6 +86,7 @@ struct xdp_buff {
>>>  	struct xdp_txq_info *txq;
>>>  	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom=
*/
>>>  	u32 flags; /* supported values defined in xdp_buff_flags */
>>> +	u64 map_key; /* set during redirect via a map */
>>>  };
>>>=20=20
>>>  static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
>>> @@ -175,6 +176,7 @@ struct xdp_frame {
>>>  	struct net_device *dev_rx; /* used by cpumap */
>>>  	u32 frame_sz;
>>>  	u32 flags; /* supported values defined in xdp_buff_flags */
>>> +	u64 map_key; /* set during redirect via a map */
>>>  };
>>=20
>> struct xdp_frame is size constrained, so we shouldn't be using precious
>> space on this. Besides, it's not information that should be carried
>> along with the packet after transmission. So let's put it into struct
>> xdp_txq_info and read it from there the same way we do for egress_ifinde=
x :)
>
> Very reasonable, but do you really mean struct xdp_frame or xdp_buff?
> Only the latter has the xdp_txq_info?

Well, we should have the field in neither, but xdp_frame is the one that
is size constrained. Whenever a cpumap/devmap program is run (in
xdp_bq_bpf_prog_run() and dev_map_bpf_prog_run_skb()), a struct
xdp_txq_info is prepared on the stack, so you'll just need to add
setting of the new value to that...

-Toke


