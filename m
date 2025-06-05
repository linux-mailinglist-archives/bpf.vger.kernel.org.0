Return-Path: <bpf+bounces-59765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EAACF3E5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4438189765C
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DB1E25E3;
	Thu,  5 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2m58g95"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DF1624F7
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140128; cv=none; b=oYbqAEk0RWBEUFaarNFW3EjAV9Ah4PW/XHL5wNu8Wz/hUavtaUooxd2adTKLWZQEvSzINKPnhYSZVu/MzYdZPqq32RDUcEAZhILJHaVcxiqE6wVja86akPO6DQ7bSKVkcPGsqB3IfrCHUIs5WlH57ZFdkW1jd3SSYZTJlQGml0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140128; c=relaxed/simple;
	bh=5YRfXPx9urXs5R9JeRsxMZW2JAsNkY5U5iQs48ngJ1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjGXjYRJzb+rIdJwkqrMS7Q9I07krcy4z01hO7gBbSAcGiYuPlzI2AzUaldChOPLk3rlE1IfBEsxoULSZoKflhY8HlkF5Pg5VO9+jesJsTuJV8fjOGfmHIU9UGNAHSVPhwrHxOKymHve7og8Nrb0mdPpE1P81sNtx1BGTulCswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2m58g95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749140125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oBJwL5i85fvyuh1/EIGr7LIagSUnBICErVA++ejqYk=;
	b=e2m58g95HkT0N0JYxdRVU2aiBFdSv/mWJubu7OJx8Oc54sgQ5EUF9TChS6zsd6WqgSWHgc
	U2Ur0MSUvIF1tTtTFGgQytaAh3oaPufiZ9OJm4EkiSfIHXyqcjwdJZlgPYzGQIFgceH8/Z
	BmZuQkz9xIjURJdbLue0bR8htWXMtp4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-OrDv4OGxPL2A3_w13mQlkg-1; Thu, 05 Jun 2025 12:15:23 -0400
X-MC-Unique: OrDv4OGxPL2A3_w13mQlkg-1
X-Mimecast-MFC-AGG-ID: OrDv4OGxPL2A3_w13mQlkg_1749140122
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5532a0f21e4so557664e87.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140122; x=1749744922;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oBJwL5i85fvyuh1/EIGr7LIagSUnBICErVA++ejqYk=;
        b=Y6chTqP5pKVdhIl4m9ae83YFG4wcW2r+Ajrm9P16NSGUFG1qwLG5FVqT2NyBVp91Ah
         XN9ViiGPNsfrwLqJC4nFnfq1rLvB/OfDGh42kMtalh4MCicTkvs846RH9RUpreu2hk/V
         oHpM6d4FmN59RuFtMcrHnKhxqXM5U+Pz8p/n9erNHf0eoe1KM2ce2x4cXxCP8wkvVAnx
         ahLrJEYI9Y29nKYCtWtXZY+GX028SKRrBOLd7hN5HMtfPjosSPHnDp4CXMgD8BJuQH8f
         yo+WHBNJolD6ZuuLlVIw+J93UzyfkM6DDK1L/5H1wR1l+ItLMLqJT9iPJeb8aQvrEirq
         rwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMglHjAbo33gklTrgMou9hSOhTln4MHiAmV8/D0bJAqxG75tj6/lMKsVKqs0dLtmx1X38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaz74c/u+e1Mt3lyTlXEDb4uzx1h8axyw86d85ApUHkDAGCp+z
	7+2/jFeNl4WdOyIe46KOZl8DDLPOk6NdmHeYTRfVAQGGKysz8NqvBYVemflZYxwRxjHiMAjD0A9
	qZYnafxcGCIsAP/sJ1sqDb6+1hxUqYKyNe6cSJfjBKdC3Aq8+SrLg/w==
X-Gm-Gg: ASbGncvoMKLSby1wqcpSQ+J5pMkoEcMZcwcPTmvGevN4oYPqb7JGUrsIHJ4L6d9PeR6
	TXvg0oKVimjmt8Uxa4qZ+0l0IHKTK3bKJZtP6dhmi79ZE3fp5YdtWRpJCIRJCTmYFHJB+NxtFst
	cDVEmtB9vdA1V5ioIZSm3HS6zG/Lz5gFQJDfV1UBwbKGfrTuPYXHsYXj2P+JQgpAwws0R4er5xF
	DNHys6afEGj0JspTLt2Cz+pyUYGTwDH+f0VJ7eLQz6v8R+Z952/nQbKCo5kdBZnr7VNvkRqO2NL
	i4rxLgHRK2XoWc6Aevc=
X-Received: by 2002:a05:6512:1195:b0:553:2633:8a63 with SMTP id 2adb3069b0e04-55356bf0810mr2550095e87.17.1749140121796;
        Thu, 05 Jun 2025 09:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyEGbTPkSKROw9FM9QAr8F2/I2JIMKK1z9Bn5SHjSwSvXY3jUXjSWANlqa0vsJXPbGPEkgrA==
X-Received: by 2002:a05:6512:1195:b0:553:2633:8a63 with SMTP id 2adb3069b0e04-55356bf0810mr2550079e87.17.1749140121308;
        Thu, 05 Jun 2025 09:15:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a13d2sm2650604e87.74.2025.06.05.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:15:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 60FF81AA92F7; Thu, 05 Jun 2025 18:15:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, Jesper Dangaard
 Brouer <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
In-Reply-To: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Jun 2025 18:15:18 +0200
Message-ID: <87zfemtbah.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:

> Hi,
>
> while experimenting with XDP_REDIRECT from a veth-pair to another interface, I
> noticed that the veth-pair looses lots of packets when multiple TCP streams go
> through it, resulting in stalling TCP connections and noticeable instabilities.
>
> This doesn't seem to be an issue with just XDP but rather occurs whenever the
> NAPI mode of the veth driver is active.
> I managed to reproduce the same behavior just by bringing the veth-pair into
> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even without
> XDP")) and running multiple TCP streams through it using a network namespace.
>
> Here is how I reproduced it:
>
>   ip netns add lb
>   ip link add dev to-lb type veth peer name in-lb netns lb
>
>   # Enable NAPI
>   ethtool -K to-lb gro on
>   ethtool -K to-lb tso off
>   ip netns exec lb ethtool -K in-lb gro on
>   ip netns exec lb ethtool -K in-lb tso off
>
>   ip link set dev to-lb up
>   ip -netns lb link set dev in-lb up
>
> Then run a HTTP server inside the "lb" namespace that serves a large file:
>
>   fallocate -l 10G testfiles/10GB.bin
>   caddy file-server --root testfiles/
>
> Download this file from within the root namespace multiple times in parallel:
>
>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
>
> In my tests, I ran four parallel curls at the same time and after just a few
> seconds, three of them stalled while the other one "won" over the full bandwidth
> and completed the download.
>
> This is probably a result of the veth's ptr_ring running full, causing many
> packet drops on TX, and the TCP congestion control reacting to that.
>
> In this context, I also took notice of Jesper's patch which describes a very
> similar issue and should help to resolve this:
>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
>   reduce TX drops")
>
> But when repeating the above test with latest mainline, which includes this
> patch, and enabling qdisc via
>   tc qdisc add dev in-lb root sfq perturb 10
> the Kernel crashed just after starting the second TCP stream (see output below).
>
> So I have two questions:
> - Is my understanding of the described issue correct and is Jesper's patch
>   sufficient to solve this?

Hmm, yeah, this does sound likely.

> - Is my qdisc configuration to make use of this patch correct and the kernel
>   crash is likely a bug?
>
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> index 65535 is out of range for type 'sfq_head [128]'

This (the 'index 65535') kinda screams "integer underflow". So certainly
looks like a kernel bug, yeah. Don't see any obvious reason why Jesper's
patch would trigger this; maybe Eric has an idea?

Does this happen with other qdiscs as well, or is it specific to sfq?

-Toke


