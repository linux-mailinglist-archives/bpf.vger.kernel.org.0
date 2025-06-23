Return-Path: <bpf+bounces-61319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F31AE52B4
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BEB7AE8F1
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC5226D04;
	Mon, 23 Jun 2025 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMbH3G5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC0223DE5
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715141; cv=none; b=GzhYIQgPmYm6KkNCMqNFvBcu4BjPOSonyPPPi9u5A6NhStYXpqIA8XMivVpBNvETfew1MZ7lx8tuARc7auLeRjX0txaV5ebG6V+Al4uWmR58ayyDqNWmKmJKi/MyECY0e2/JLD7+Hcc9XCrODmNIJXwlS8LEmJARI5lmCTNCy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715141; c=relaxed/simple;
	bh=JFPGlMO8pvzU+iev+MFbDhUoCDGlcLoubKAixNgorNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OeRvkyPGBDcPLpMcu+RnlTvlrZ3r+70WNtWBy2aHi7w9upBgaTm6QdFFIc6iWCbLmArxn14O82xZJZCOdyGD9gwoVuiqazhAmskRXsImjjeR03n0oUEWUcUvoVkcxktaJbArvUEgALPn69GBYKO1aETPuPAxoJXgnbqQ5I5QtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMbH3G5e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e1d710d8so62813955ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750715138; x=1751319938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFPGlMO8pvzU+iev+MFbDhUoCDGlcLoubKAixNgorNU=;
        b=SMbH3G5egCMBuB4AtzXJl1QtwpDDrU3bL/G8mfsGFG5gWuFhLh9JqqLtV6nGHwPEUh
         MgaHWfSBMM8fTrrLtBynis9sQDDOfeIV7FP5kO7Z4RG8OvFfLWRKE3eV68Ynr9py/GKn
         7NjKbdGCx/p3057VWLxgWAXLZMRuoy/AUZtO1uX1PWJRYZiH6odTYd56CM0S6iexw9qg
         EQ6kspbf+wC95Nr1avUUM6uOZNXyedyHeRvT6Z3b0tWBcS5lqvjMVGjvOOMNP2PaNMZ8
         vm+nsjKNjOUjus4E4BKrOU1O9OocvYCDGB/WnEKqqqmxaELWBKrD/lMAL9igAdJVeUqk
         ZHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715138; x=1751319938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFPGlMO8pvzU+iev+MFbDhUoCDGlcLoubKAixNgorNU=;
        b=S9cUpQU1tpW61nHHAE0EOzQ85jn0E7F04JaJOmp0+/+El8+L3VJiMD3yACoA0ZJckC
         iRL8MbqnIzORirbbnL+8Chow/jjadVtgADN74TiWi/b9z+4qkCwoDKhMdVJ7zWizgRLq
         grrSi9OM7ed00EaaZew87awCuhRN9jtK6gE6JEC4tE2a1XAMLH0it3Z5d1WUYYLpHBBe
         iZvLAvpGBAUsBuNHryJTsvBnIQLb8NUwOpiQEardcL+u9h2uig7D6x/uovnE0Ebcb64+
         5ILkRJHZl8sWoLpzBo8r+G3UeIw7eNiwfmCUUnhCjCt1dYQxDPdX4jvREZGyzyM6lMhT
         kc6w==
X-Forwarded-Encrypted: i=1; AJvYcCXBcKJ2pqor5S3Bmu2tPtet6iXqT5AJVjx9eDxt4q/OPTmgLtzp5rmtebeb6ilEnG4COZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIzR/qRqFhZSbJxVTbv0xzmZQDPq4BC3uSpsaxj6Uio0Bn3TX
	9Km9lw9UjB8SDRrDbRM1drzLwOAADnFoC4TGVC95XBLM/Na1q8N2OXaL
X-Gm-Gg: ASbGnctwhMdnTqx0PdQRzZ/yM5ZgFwY2fsoiATbu4fLxz8tAA1CjdmAqVF9qjTF/7XI
	qdJz8mJ6IuxtyLaxRBUJhh0js/300er094uaFT6MqOzWkpRHVUhjh6iXHGgjXG8A49PA1jE1/+Q
	QUj6lds7GAWtCGewxLpSJ5llJ90Rj5GvwfaG0aNahrkqZVCwp5C2UEqXBcB8RPRRiNnyt2DY0Aa
	v7XVG4JYwHJ6kZE7EiQqR6uXwMY3uNohFHXfqW+xForjxK16hTa6D3eUG64iuDBeg39QiPzzgdi
	QYqzaihKWOkbEWDkjATxSlnK+7PPYqNplNl9MfQ1+ywMTxmIA5GfFAU09pUNL8HjQhH9Zx0ZJry
	WY9GZFlsT8RNLxiwOh8QT
X-Google-Smtp-Source: AGHT+IGI0SaLn0W3qPZBMVUEgS7H+sLIWXqot0tP8mcruMja0DCsmChd+UJD7kRoIN9xtQ+RsBrRiw==
X-Received: by 2002:a17:903:2f0f:b0:234:8e54:2d53 with SMTP id d9443c01a7336-237d99815bamr201551745ad.45.1750715137794;
        Mon, 23 Jun 2025 14:45:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c6ac:4d8a:d8e2:c836? ([2620:10d:c090:500::5:8b4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241f20sm8726707a12.45.2025.06.23.14.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:45:37 -0700 (PDT)
Message-ID: <59e7ca59c4c0ac455aa05c7ebd0ecd67871a5b47.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>, andrii@kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com, kernel-team@meta.com
Date: Mon, 23 Jun 2025 14:45:35 -0700
In-Reply-To: <CAEf4BzYZBMOexPSM9=utpn22W=XMsztiE_X9AxO9CSSb1yv7LA@mail.gmail.com>
References: <20250618223310.3684760-1-isolodrai@meta.com>
	 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
	 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
	 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
	 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
	 <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
	 <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev>
	 <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
	 <a64d331ff474e9896c7d6c071e027c34fc8c2966.camel@gmail.com>
	 <CAEf4BzYZBMOexPSM9=utpn22W=XMsztiE_X9AxO9CSSb1yv7LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-23 at 14:38 -0700, Andrii Nakryiko wrote:
> On Thu, Jun 19, 2025 at 11:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Thu, 2025-06-19 at 11:13 -0700, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > Also, what's the plan if you'd like to memset only a fragment of the
> > > memory pointed-to by dynptr?
> >=20
> > Oh, I see, there is bpf_dynptr_adjust(), sorry for the noise.
> >=20
>=20
> Even though we do have bpf_dynptr_adjust() for maximum generality and
> flexibility, for most dynptr-based APIs we try to pass also additional
> offset into dynptr to avoid unnecessary overhead. So it's not a bad
> idea to add this to bpf_memset(), IMO.
>=20
> bpf_memset(struct bpf_dynptr *dptr, u32 off, u8 val, u32 n) ?
>=20
> a bit unfortunate that we have 3 integers that you need to be careful
> to not swap accidentally, but even with just val and n you'd have to
> be careful. For other APIs we normally have offset to follow dynptr
> pointer, so hopefully this arrangement won't that surprising.
>=20
> Thoughts?

Unfortunate indeed.
The off and n being separated looks weird, tbh.
For dynptr funcs we actually have "dptr, off, size" everywhere, maybe
do the same here?

