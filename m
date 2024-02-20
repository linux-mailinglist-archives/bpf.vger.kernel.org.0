Return-Path: <bpf+bounces-22319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CC85BCEB
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 14:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9841F24335
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B286A038;
	Tue, 20 Feb 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl03WB01"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0966A01A
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434850; cv=none; b=JjD2HVSzrtA9oAhjz5L2CMFsQI5SzfO9s9MdrkccbL15dnlq6nzXHCtbNe3dzHTB/12bQTvr5LEdMi97CFZ3wzK3mPsYb2YJO97HRzTjiYPem4jPGRCHaQiArZ0XKpsi1Rjc8HoTxnjlC/rGQv2e4q2e87UQc1K7sRemCRIMV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434850; c=relaxed/simple;
	bh=9P+qGZ09vKP1bVu9xDA/zAFHdQr1RJe/fY/2APMl9sI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8q8IIPB7SO2l4kBpAFjRjWRVUIresOCIPt2cSXKj9uCAG0QlBlBBUFOgKfB7IyiylsYAWT3RhKRaB7Ile8FF6EE8PlMErshnBX/q4YISxhCPZ1Oun8Qp7CEq8SQtujMuiE6mXYkbNG5gM7k9B5MZ4N4Upuc4aU7e1KVQcnk9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl03WB01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708434847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpefqOp0oZS0+OYDrex40+aBinTmwsqS3fR+A5/fHEk=;
	b=Cl03WB01iuT1/BuE+qogAAP2n66ZCzMSEUPzr5/SoC2JPjFLt4NJe9TSlG8yDa+XjG5ZP3
	RvrORDm6tw5bPDN8T4VoMht7q9YhinHmjQ9z4NVOe7B1Wm0WnReXdqn7t6IkGqxcsa1sIP
	cENRKkpbpfyN9BD0amX4Pn0uczDYzlE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-V7-QmqmAPQ6-g2H3T9QITA-1; Tue, 20 Feb 2024 08:14:05 -0500
X-MC-Unique: V7-QmqmAPQ6-g2H3T9QITA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512a5c6465bso2478034e87.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 05:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434843; x=1709039643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpefqOp0oZS0+OYDrex40+aBinTmwsqS3fR+A5/fHEk=;
        b=wSURCTigPZ4y+e+2m87+SCSeJAbnphRKTRgzeqQiuLsINrijWO9oI3PY6lfS80OhVf
         /rtkor/ii5omC9RZWZ8KLex7l39Qvxl8bw3TGmli2dsz2alXRUGYVyTa7F895D3L1k1p
         5T55NgiwkKvsVrJeuLvfbwGWwaEjTYed43Hs0Mew9TXwlRHzV06W+TcjCsGExqbkS5DU
         0+DWIDcXsbrpoG0jrrH5Hxr2zWVoN4ZHWJOnkMiabq5/okEPdQbstKXSWVpbhDBRJyHJ
         qksOvGfjtyhzQABB8u9Cyqdjb7S0OV0rDVIS1cid/ZpdLwrUueb04ov2Ye+c+if+aWKz
         /cwg==
X-Forwarded-Encrypted: i=1; AJvYcCVmH51uLuCz7VqHtcOlXTiVkPmx9nkvjaKN/ORsxioAQi42r9/+PPKioc7oJRdJXx1E0YOGKnq8py6gX9wgBGORLXPr
X-Gm-Message-State: AOJu0Yxsg3QMcoVeujNUmlUuOsyyiaBUruSEZ6VXF1V31jDuz5lvNdqs
	MbDHE2jtpaDUdHmw3jajlJnKIF73ReGMOYITwJi8zvtaH//UFwCxhFEQRxCfGAA94P09b+FqTPI
	vDTk3jVIRLcoJqPxCiyCdMZ31jSlZagHy517c3aui+mjz85506Y28iGAd+g==
X-Received: by 2002:a05:6512:1244:b0:512:bf7e:ca25 with SMTP id fb4-20020a056512124400b00512bf7eca25mr2175377lfb.20.1708434842773;
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8GOsb9PCUAoG+xTokA/O/bJ8lqnvFxihET48bAH7rH5bSJopZDtx4usFA3e5/XmG7h0DGbQ==
X-Received: by 2002:a05:6512:1244:b0:512:bf7e:ca25 with SMTP id fb4-20020a056512124400b00512bf7eca25mr2175339lfb.20.1708434842396;
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090624d000b00a3efce660c2sm561653ejb.198.2024.02.20.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 83DF410F6365; Tue, 20 Feb 2024 14:14:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bpf: test_run: Use system page pool for
 XDP live frame mode
In-Reply-To: <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <20240215132634.474055-3-toke@redhat.com>
 <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
 <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 14:14:01 +0100
Message-ID: <87frxn1dnq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On Tue, 2024-02-20 at 10:06 +0100, Daniel Borkmann wrote:
>> On 2/15/24 2:26 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
>> > each time it is called and uses that to allocate the frames used for t=
he
>> > XDP run. This works well if the syscall is used with a high repetitions
>> > number, as it allows for efficient page recycling. However, if used wi=
th
>> > a small number of repetitions, the overhead of creating and tearing do=
wn
>> > the page pool is significant, and can even lead to system stalls if the
>> > syscall is called in a tight loop.
>> >=20
>> > Now that we have a persistent system page pool instance, it becomes
>> > pretty straight forward to change the test_run code to use it. The only
>> > wrinkle is that we can no longer rely on a custom page init callback
>> > from page_pool itself; instead, we change the test_run code to write a
>> > random cookie value to the beginning of the page as an indicator that
>> > the page has been initialised and can be re-used without copying the
>> > initial data again.
>> >=20
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> [...]
>> > -
>> >   	/* We create a 'fake' RXQ referencing the original dev, but with an
>> >   	 * xdp_mem_info pointing to our page_pool
>> >   	 */
>> >   	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
>> > -	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL;
>> > -	xdp->rxq.mem.id =3D pp->xdp_mem_id;
>> > +	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL; /* mem id is set per-frame=
 below */
>> >   	xdp->dev =3D orig_ctx->rxq->dev;
>> >   	xdp->orig_ctx =3D orig_ctx;
>> >=20=20=20
>> > +	/* We need a random cookie for each run as pages can stick around
>> > +	 * between runs in the system page pool
>> > +	 */
>> > +	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
>> > +
>>=20
>> So the assumption is that there is only a tiny chance of collisions with
>> users outside of xdp test_run. If they do collide however, you'd leak da=
ta.
>
> Good point. @Toke: what is the worst-case thing that could happen in
> case a page is recycled from another pool's user?
>
> could we possibly end-up matching the cookie for a page containing
> 'random' orig_ctx/ctx, so that bpf program later tries to access
> equally random ptrs?

Well, yes, if there's a collision in the cookie value we'll end up
basically dereferencing garbage pointer values, with all the badness
that ensues (most likely just a crash, but system compromise is probably
also possible in such a case).

A 64-bit value is probably too small to be resistant against random
collisions in a "protect global data across the internet" type scenario
(for instance, a 64-bit cryptographic key is considered weak). However,
in this case the collision domain is only for the lifetime of the
running system, and each cookie value only stays valid for the duration
of a single syscall (seconds, at most), so I figured it was acceptable.

We could exclude all-zeros as a valid cookie value (and also anything
that looks as a valid pointer), but that only removes a few of the
possible random collision values, so if we're really worried about
random collisions of 64-bit numbers, I think a better approach would be
to just make the cookie a 128-bit value instead. I can respin with that
if you prefer? :)

-Toke


