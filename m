Return-Path: <bpf+bounces-22336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4085C4E6
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 20:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1F1F25214
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B614601B;
	Tue, 20 Feb 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4ak81ii"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C1137C2B
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457641; cv=none; b=qeaAYOMIZfLzoh6KQUxVpz3rlYRaWeh408RuISL1LjS+DlV8/RpCi7psaOfaq3pxu8FuIhCVscCj1hhJ9lMFL6e4VSfBqHMlsGa02F7ViygMT6UR+/+Hlqn0fYfCHPalZDog08j8IrYOeZwN2yQNECS9kaQYlWtJN1dAP/hMlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457641; c=relaxed/simple;
	bh=MSsWNZbrSA8jmwOTwY01KkTTLNM6KGirzTg57mM/DHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDTAWPE/IlD7rjLt3ouXYTyFGEeK/4q4eAbQPTYAsauWGl8o0Jpp+zH1ospFLjmR1AVWJjiHXOZajaFDe5hNERxcxu5oBywsqNCxvlD4+9JDOBPj/VLCDeU+Nl1wEnoDJaiHuztyRc0z7ZNRCjUM45Tg8er4Pf95SOcel3Ed6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4ak81ii; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708457638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2+K9SYZnDq2b2vxFoXzss6f5L3wcHVChuNq2JQkC0k=;
	b=W4ak81iiUroQCB+SEnxHqZc8n2HvxeZ0BW0QS+R25uazlr4Us9p5HAqGDAuXV1h4/hE3j2
	Etx7L69lE0/Npnk12Zfxvvs7OHuofy7BNKuCDs6HxTc20Ru9PnNcxcCewV/sxqQxbA4lMu
	IYUpCZ4L0i0oKGPiUybCVP3yISzqKVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-JIJ0L6OgNSyyGHu_FFoXXA-1; Tue, 20 Feb 2024 14:33:56 -0500
X-MC-Unique: JIJ0L6OgNSyyGHu_FFoXXA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a30f9374db7so698554366b.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 11:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708457635; x=1709062435;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2+K9SYZnDq2b2vxFoXzss6f5L3wcHVChuNq2JQkC0k=;
        b=kGffwZlajSbZrceEHzQKU1/aBXsKL9rdQGQu710yZVKslfzxfPEz4dFvyVgr6fxmLz
         owDxMdbQ8Wc14MCN+W5SeyAzK0BG60K4RKIYCyBNwJicqRKjHPZQzIoNIoEbsBVPvJWH
         ZR3nW0bN+7B5JXwAgrptR0W9ay1zjMQnCPyHWWNyh2QWtvQF706d1pSG0gn1DYEYkhVr
         jnV5+pn8/588py0DFSkXPKdEqEuULK55kCr0YS+sHx+qzHWc/EUutuEib5Jv4NKrDgpC
         BIDbtbzjtroycWWiM7ehumS/zgqV+dCPj7gCen/chD4dhJrT4hcaT2nyW7g5+S5sZWOQ
         iNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxvpzXWPS1xDP2a9o0sng00SAvBtyPE5VBo8dBtQcbNd63AGXHiH5yppenSYYrOJW3IBCt7RiZ8/8u/JJv74wg88hO
X-Gm-Message-State: AOJu0Yx6KnvkqOww9//1XcDFI9QI7RHR6NRTF6O7rJo/YSCvbgxoqbxh
	YO5CQI7qTaOKPL7QbMFRLTHzdPwi+mT7PCxhSt1pLTZYxKt/Dfw3HnrH5jxo2LhVTtlcHttCGhE
	/8iXA/nYCJNbqYRTUHtNDkHbBaDU89d13WicKWI0m2pRWDGEfQw==
X-Received: by 2002:a17:907:7ea9:b0:a3e:b57f:2b8a with SMTP id qb41-20020a1709077ea900b00a3eb57f2b8amr6030590ejc.10.1708457635356;
        Tue, 20 Feb 2024 11:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbxIJ1yuGOFI6iLmW9ulpsaRCDfsBBUAz1piwEm4OhcKvAQVntnoQjtfgklYIhoIN0YmrB+Q==
X-Received: by 2002:a17:907:7ea9:b0:a3e:b57f:2b8a with SMTP id qb41-20020a1709077ea900b00a3eb57f2b8amr6030569ejc.10.1708457635000;
        Tue, 20 Feb 2024 11:33:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id pk27-20020a170906d7bb00b00a3ee20b00d0sm1254310ejb.4.2024.02.20.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:33:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E1A010F63D2; Tue, 20 Feb 2024 20:33:53 +0100 (CET)
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
In-Reply-To: <83e7faeb4a241a00053fc71dbb18d1dbc7c0fac6.camel@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <20240215132634.474055-3-toke@redhat.com>
 <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
 <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
 <87frxn1dnq.fsf@toke.dk>
 <83e7faeb4a241a00053fc71dbb18d1dbc7c0fac6.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 20:33:53 +0100
Message-ID: <877ciz0w2m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On Tue, 2024-02-20 at 14:14 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>=20
>> > On Tue, 2024-02-20 at 10:06 +0100, Daniel Borkmann wrote:
>> > > On 2/15/24 2:26 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > > The BPF_TEST_RUN code in XDP live frame mode creates a new page po=
ol
>> > > > each time it is called and uses that to allocate the frames used f=
or the
>> > > > XDP run. This works well if the syscall is used with a high repeti=
tions
>> > > > number, as it allows for efficient page recycling. However, if use=
d with
>> > > > a small number of repetitions, the overhead of creating and tearin=
g down
>> > > > the page pool is significant, and can even lead to system stalls i=
f the
>> > > > syscall is called in a tight loop.
>> > > >=20
>> > > > Now that we have a persistent system page pool instance, it becomes
>> > > > pretty straight forward to change the test_run code to use it. The=
 only
>> > > > wrinkle is that we can no longer rely on a custom page init callba=
ck
>> > > > from page_pool itself; instead, we change the test_run code to wri=
te a
>> > > > random cookie value to the beginning of the page as an indicator t=
hat
>> > > > the page has been initialised and can be re-used without copying t=
he
>> > > > initial data again.
>> > > >=20
>> > > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > >=20
>> > > [...]
>> > > > -
>> > > >   	/* We create a 'fake' RXQ referencing the original dev, but wit=
h an
>> > > >   	 * xdp_mem_info pointing to our page_pool
>> > > >   	 */
>> > > >   	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
>> > > > -	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL;
>> > > > -	xdp->rxq.mem.id =3D pp->xdp_mem_id;
>> > > > +	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL; /* mem id is set per-f=
rame below */
>> > > >   	xdp->dev =3D orig_ctx->rxq->dev;
>> > > >   	xdp->orig_ctx =3D orig_ctx;
>> > > >=20=20=20
>> > > > +	/* We need a random cookie for each run as pages can stick around
>> > > > +	 * between runs in the system page pool
>> > > > +	 */
>> > > > +	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
>> > > > +
>> > >=20
>> > > So the assumption is that there is only a tiny chance of collisions =
with
>> > > users outside of xdp test_run. If they do collide however, you'd lea=
k data.
>> >=20
>> > Good point. @Toke: what is the worst-case thing that could happen in
>> > case a page is recycled from another pool's user?
>> >=20
>> > could we possibly end-up matching the cookie for a page containing
>> > 'random' orig_ctx/ctx, so that bpf program later tries to access
>> > equally random ptrs?
>>=20
>> Well, yes, if there's a collision in the cookie value we'll end up
>> basically dereferencing garbage pointer values, with all the badness
>> that ensues (most likely just a crash, but system compromise is probably
>> also possible in such a case).
>>=20
>> A 64-bit value is probably too small to be resistant against random
>> collisions in a "protect global data across the internet" type scenario
>> (for instance, a 64-bit cryptographic key is considered weak). However,
>> in this case the collision domain is only for the lifetime of the
>> running system, and each cookie value only stays valid for the duration
>> of a single syscall (seconds, at most), so I figured it was acceptable.
>>=20
>> We could exclude all-zeros as a valid cookie value (and also anything
>> that looks as a valid pointer), but that only removes a few of the
>> possible random collision values, so if we're really worried about
>> random collisions of 64-bit numbers, I think a better approach would be
>> to just make the cookie a 128-bit value instead. I can respin with that
>> if you prefer? :)
>
> I must admit that merging a code that will allow trashing the kernel -
> even with a very low probability - is quite scaring to me.
>
> How much relevant is the recycle case optimization? Could removing
> completely that optimization be considered?

Did a quick test of this, and skipping the recycling eats ~12.5%
performance, so I don't think getting rid of it is a good solution.

However, increasing the cookie size to 128 bits makes no performance
difference (everything stays in the same cache lines). If we do that,
the collision probability enters "won't happen before the heat death of
the universe" territory, so I don't think there's any real concern that
this will happen.

I'll respin with the bigger cookie size (and add that patch Olek
suggested to remove the init callback from the page pool code).

-Toke


