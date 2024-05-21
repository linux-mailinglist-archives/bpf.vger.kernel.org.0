Return-Path: <bpf+bounces-30100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9728CAC28
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6104C1C21860
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380587F46B;
	Tue, 21 May 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH/sUGn8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF873531
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286755; cv=none; b=c4Jt39ZZ26LO0QccJkjZKhyl4cnq+7Cb1HZYoquvZIO0Eov1+oeP34iBsSUXM/YPTFsO7L+lRTd5RgMqGhgwSQYSNri8Kqmbl6W2d3KHP9qgkOv7sATfw1au9p0SMFjJStwJv1IOrz/mRiU7+4IfR9ySlUTElw2ovXx0a7EbkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286755; c=relaxed/simple;
	bh=m/BnOv9IyIknk0taxfZ9in2qMKbBmTm62BEIyazTekA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1LJDD3/ecxc/98vRT0YuyAoe4k4u6XJQEsyRFAOXXxmq+ywx936ICRxsEM/konKrXvZLIeREoq4rnqSmoS/wkx9/5LRdgMaoyHEC/FxFizVAYTlBA7FIMcPZ/BsXTNToUuQ4aWxVOkD+2QOCj021f9rlDKBYyzbfw+5LMN6ZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH/sUGn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716286753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDN4wBeS+zyaK3mckFLu3ekq1g2jhLMHXCljitfNdOI=;
	b=ZH/sUGn8K2YAspUoGR+gQSTolGOc20+vCPs/g2soRpUTAaYRQTtWGt0sUOfFtHHFiT+epV
	MAJjlG3sJYvYRws0G+0WYPi/1SCd6EC4LENX8YpITH6ZQakQkTkuRoQiJxoXmiSefdSs/h
	hHM5L+Jxs/eLI0ugbu0pGP2KaMqYVGI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-VPD-E8vDNZSvzRh5vyhDgQ-1; Tue, 21 May 2024 06:19:12 -0400
X-MC-Unique: VPD-E8vDNZSvzRh5vyhDgQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ed057cc183so147323805ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286751; x=1716891551;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDN4wBeS+zyaK3mckFLu3ekq1g2jhLMHXCljitfNdOI=;
        b=e3g7bBHiuhvZWhv+1i7KgeeFFpa86hSbAdpwS08sZcfmxnxJaVAn2w5o4uOyWnbqZ7
         uRzF/PzZ3ii0tMCFXetrkaoCxnJ8xibx4xXrz0/TgmnUx3fnwGWqjiUULvX+YBw/d9kj
         28vtYtp1Ob+kpDAtZFWSB1aDxgrsEG4z/qhIbvVuZq8eGnF97P8SwEm4Mzql9LOgoPMV
         /OeAKZ89FxZGWvjl87n5v6iU6Rp6ddlInaRD3bnd4IdqrIqt8NPYR+vuW2vuDXw5Wt8f
         zGmQCKCpgVGxCCq2Vzd4tFuZ3h5GiGbEY0dZyhvPqP/ibjAAFluJFLZdOqiKZp474pki
         jyCQ==
X-Gm-Message-State: AOJu0Yy1u42hFeonkZx9A3d8jJNknwgUGyCYiHwEobte3kqOB5zRhBh3
	lBVJN+POtz1uqc8NYtduGibE14LwKTUjfGJNCE9KaxnDHm66/YgQQYSsRCmAOeq4Oq8YYZR7nKW
	t+fxfkCWyjTtcfpadkTVROalBjwvy6KeczcPSCxtrlSHS8AgAFA==
X-Received: by 2002:a17:902:ec83:b0:1f2:f0d3:db30 with SMTP id d9443c01a7336-1f2f0d3e367mr98973325ad.64.1716286750956;
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvvHcjqOjtYCqzf1Shk/DnxCibhC9dkl7mU3+4cXSE2zbcJWmISDdAei0dLnJPKrfutGYx0w==
X-Received: by 2002:a17:902:ec83:b0:1f2:f0d3:db30 with SMTP id d9443c01a7336-1f2f0d3e367mr98973045ad.64.1716286750535;
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm217542135ad.295.2024.05.21.03.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B10B312F75B4; Tue, 21 May 2024 12:19:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netfilter-devel
 <netfilter-devel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Florian Westphal
 <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman
 <horms@kernel.org>, donhunte@redhat.com, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] samples/bpf: Add bpf sample to offload
 flowtable traffic to xdp
In-Reply-To: <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
References: <cover.1716026761.git.lorenzo@kernel.org>
 <8b9e194a4cb04af838035183694c85242f78e626.1716026761.git.lorenzo@kernel.org>
 <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 21 May 2024 12:19:05 +0200
Message-ID: <87ttira2na.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
>>
>> Introduce xdp_flowtable_offload bpf sample to offload sw flowtable logic
>> in xdp layer if hw flowtable is not available or does not support a
>> specific kind of traffic.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>  samples/bpf/Makefile                     |   7 +-
>>  samples/bpf/xdp_flowtable_offload.bpf.c  | 591 +++++++++++++++++++++++
>>  samples/bpf/xdp_flowtable_offload_user.c | 128 +++++
>>  3 files changed, 725 insertions(+), 1 deletion(-)
>>  create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
>>  create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
>
> I feel this sample code is dead on arrival.
> Make selftest more real if you want people to use it as an example,
> but samples dir is just a dumping ground.
> We shouldn't be adding anything to it.

Agreed. We can integrate a working sample into xdp-tools instead :)

-Toke


