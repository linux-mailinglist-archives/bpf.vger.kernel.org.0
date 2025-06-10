Return-Path: <bpf+bounces-60142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11747AD3417
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5736188B7F5
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244A28C5AB;
	Tue, 10 Jun 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WLkKEXua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E061A2564
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552797; cv=none; b=R5abCoHvGpA8o9LATy5sKOIiDvStYE3crl+3Z7IRM+tw7il/HK7G/bkN579Tc4xtKdQ1wHFgp+KAEiEUaeUAXtf3l35RbtzZ4kzOHaCtNbEGcVHcediKt6GkA8oYWFKl89OQgjQKH8BXkwUNpeRD+BFkOnRHxrkJi6Otys1dnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552797; c=relaxed/simple;
	bh=kb9FsIXnJ7Zs65QK4qmWfNoy4AKHnchxO1dJYLhVcQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6FIol0f3c/XBG7y9yn9UEum1yjtxBT+qRdNxz6+a2+pFbqPEIrycKjHNUCt03+kGhN2ocvhOnzAGL/Va9jTHMOkhZ4rWJSGIlI7dRXii03/rHUgdAK1ZPTakTSNg4Nbt5zM5aRXz5GA1WqxeFY5lQH+6sz0iX2kExlfenSfRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WLkKEXua; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a365a6804eso3327003f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749552794; x=1750157594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kb9FsIXnJ7Zs65QK4qmWfNoy4AKHnchxO1dJYLhVcQI=;
        b=WLkKEXuabRnRgaTAg0hp/hvj+4YP56gFPllPTFAXoP38jiW2lPtjAIb4vMAQNFEBxT
         iODKUZWkb8V1b39EQoEZRTLRJjOO8AC3SaAOPMe2j4t2wOa5rxNVuAdugv0xtSADxDE3
         cBVZ+Pn5Bqb7RScsyDb0tET9mRI2YllCmaSAe9iseIsZsG8ullsYqRXwYdbXfWYE9aOX
         CsiuX/5yigp3VIKL2jk5InVty1ZYXlRuh+vg8FG3iA++ogGSG0rYiNPIYgEJ+VeQWT4T
         9ad1838FeiSQBf9hQjVoG5Kr6JMJbFRbxMsvPqA7P5AejQ97oBX4vCqnM/q4fQ+d7aFq
         5bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552794; x=1750157594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb9FsIXnJ7Zs65QK4qmWfNoy4AKHnchxO1dJYLhVcQI=;
        b=R1OZnCBHoRRtkgnMZrmVwsry7oW3Tr4qB0Kv/PmHIO/CFnKjxxwF5fncy293r6iMLx
         H4LCWyIXFXQ0w9wY8yPRguURZW2ihg7lkD2AsWYeYON0mqX4Lq0uaKO59kfLj3bQbDPu
         3SoxLg6YKezehtsrfTZdtWtwrGhBppEhSpTrUAFtVF4jNP6XslZQ9ChDiQBSZisjkZdV
         xn55UYVoZZMzFvRJkagGC2sLYmeKdC+Kty/PVPEPr4hK3pTH+g0LedSQjC7tkrGXfEV3
         t8YyNOw+i/fVsK9oIOL455J1oYgIr2QrQGMLxoP3f8WisD3xh0Mr3aBO2FcYG/Pbg2u/
         dYuA==
X-Forwarded-Encrypted: i=1; AJvYcCXufRUgGyZRQKT3byFcop53aUZEsJ+MhvpiknWGYgSlvOhfWIm8I3JALA1DqoFQxYUqDdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfomJFdlgRDz65IwFvhygmFd+fssBoXQzP0F5SUAiGhk02Sum
	uFkX4SxkmarHaS5/EpXzolLwBbU32buj10PNxMNPmPSy9ZXQJpu8oS4KN9wCvfPJPFM=
X-Gm-Gg: ASbGncs407E37W+wR0lQbX8PvW1C1f0EY1QNokid4uJkPMoKjcr1VC2wrJusRPmhFBF
	74gpOOOknAh2TiQOGwNPAgGKrZH03gXY2BHhC1N4HFa4JharKqH+SZfDZrKMrTx8EwTqQaEVqlj
	sWAfvH7UTcMRip2HgoqqZbe/W7su2q2/jJdx+Q9rmo3bCeue31JZNZpDWEpVSZY6LaPVyyetlks
	TOcUn8UiH5Ao2YUq5SwGxcYWolNpetGsyVhfdOK+jNjzz2FVDHstrdK8riNAp1AXD6XwgrcNNPW
	LVLLIrMXcx9/sWOhvRXUHxPQoB0XdNgE/l/lYrQdgRGI4YnB69VOqj5p//QLckMf
X-Google-Smtp-Source: AGHT+IG7aHxSVUxADrCF91C0+/IRFPYkWaPeRGLciBBd/1yGe6tbmHfOBJniaA2BzrZmLitj8vaxyg==
X-Received: by 2002:a05:6000:2403:b0:3a4:f939:b53 with SMTP id ffacd0b85a97d-3a55229bdf4mr1373065f8f.38.1749552794192;
        Tue, 10 Jun 2025 03:53:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532461211sm11767637f8f.86.2025.06.10.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:53:13 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:53:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
Message-ID: <rtgbcuvajr6oql5xfe5qp7cman2ucatnohux47upknwfoduc5q@63ywqn4tg3jr>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzf4dlmbab6bfzcb"
Content-Disposition: inline
In-Reply-To: <20250609225611.3967338-1-shakeel.butt@linux.dev>


--wzf4dlmbab6bfzcb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
MIME-Version: 1.0

On Mon, Jun 09, 2025 at 03:56:08PM -0700, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> BPF programs can run in nmi context and may trigger memcg charged memory
> allocation in such context. Recently linux added support to nmi safe
> page allocation along with memcg charging of such allocations. However
> the kmalloc/slab support and corresponding memcg charging is still
> lacking,
>=20
> To provide nmi safe support for memcg charging for kmalloc/slab
> allocations, we need nmi safe memcg stats and for that we need nmi safe
> css_rstat_updated() which adds the given cgroup state whose stats are
> updated into the per-cpu per-ss update tree. This series took the aim to
> make css_rstat_updated() nmi safe.

memcg charging relies on page counters and per-cpu stocks.
css_rstat_updated() is "only" for statistics (which has admiteddly some
in-kernel consumers but those are already affected by batching and
flushing errors).

Have I missed some updates that make css_rstat_updated() calls critical
for memcg charging? I'd find it useful to explain this aspect more in
the cover letter.

Thanks,
Michal

--wzf4dlmbab6bfzcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaEgOigAKCRB+PQLnlNv4
CCyuAQDQlmXIUda/Zc5IPRULm+/1VBWxj2JIW9BfHZ2Iz/EeBwEAyJpChyqsQ9vH
QuSlPcSnjJUVEQ52+dsLL5MHYOTnXQQ=
=qmK3
-----END PGP SIGNATURE-----

--wzf4dlmbab6bfzcb--

