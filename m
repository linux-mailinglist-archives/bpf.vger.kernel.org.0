Return-Path: <bpf+bounces-21840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E433852FFC
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816A71C217DF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AA383B2;
	Tue, 13 Feb 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUDwLAm8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D414383B9
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825683; cv=none; b=cw4xS4xWgP1zgjvoM8TYh+i5rwrsAZKDPLtUUgYCW7vienlzSdVx7xVmWTQRMzjIdOif910DgcFnOo37ILhVT3qfePAirNQNIFx2cxVkY4Di8nNH2K8R9qAgTJCDYHwYdsqkvyBkGhOr5d9l8r1fny0oZxBChZh4FYJmj//uOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825683; c=relaxed/simple;
	bh=2NGhDIskYMOM8G7MM5rUf2STjd75pFIgYrl55pxzqHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaMtAzSXjPY3wjyJ5CqVsbNPvV/+pnJjvuL8+USAvO5vRVMBIX/9Z8njKSpqx7lk4SkBreM5S0EvMORPrxS908JqOZEz2jmyW1zyL+zfOHTWsrHHr3qIWdLj/D7WmWHJ3HGwcLrOrVG47R26BWIgmGCHvlRNHE+mGpqVf+GBUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUDwLAm8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so550078766b.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707825679; x=1708430479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OG1r0NtLTO7Nq37a+qBaAqxHHKm+oftf3Z3AGoZnsYQ=;
        b=mUDwLAm8NehvktLWxeUzjS7ZjierThVI6DvkiM8d5tjoVjhaHUK9yXkPQCB2qJLR5X
         GyYTyyx9Ov4rlsL22hVRy1FsZHBzhmf/gtwe7lotCud+/uN11CbB/YhlpuPXuIoe5m04
         /UXNLU8bWUJeGY3+aOitLYGkzWM2cpRAPuEqxkHLtGpcgLm1P9ga4g0Bqp9Q+R7NJCht
         Vu6epuhI4bxjO/1RxX2LCVzhGub0wtu4PH94Q/g3ya4pydMUZNZKeaCKcIBnQ9AdZ8BF
         HG/wcjyFzLOspsjyrVHOjwcBP9bxQoksA/oNydZApPi400coMysrVH65RaxINZVHrov2
         rv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825679; x=1708430479;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OG1r0NtLTO7Nq37a+qBaAqxHHKm+oftf3Z3AGoZnsYQ=;
        b=GsDyWxZq7bFv1roo8efN6a3c0XhTcEpWUdcIUy5IoXmLxRB6AzziR0J+fm1JG6wLDD
         mLn/xhHIjoq8/WnMtmhHPe4YM7hji5qd6UY58Se5OfVumxhDMSAV6NpspAGCWDtW4QdL
         O2XsivYCFOzKlPJn6g0h5Ya1OIL6MZrNh8v2a+BYR2Mz7L18TFPA323UFrx7al1NPUwN
         2T076C2pCGLMtIX+92s5uC0EpU0qXT077O07vTSPSB5EnPJiFNCoORLBERhYnov0f8Ar
         liebSreV4Pj51ILjtZP3CM/ogsO7+icRK6+hj95zBV4MDkLhW5Lf2grVK5GAXgUTWcwz
         lINQ==
X-Gm-Message-State: AOJu0Yw177XT4gQxuSAny6kaYt9KWDTilE9kuSM7Q57hxj9ZORp98KU2
	NWkqqBuIZ/hbFvVil3ohiDJ/JC3fHgxhFB5/s/7AwAR1OgDj44nO
X-Google-Smtp-Source: AGHT+IGVq/FGBVTOMmd5u4Bo+rLXidfbF6tQJXQNKFoq1kNboQ4ummkLLalYQL6X5h1LYBkvBX/Ltg==
X-Received: by 2002:a17:906:488:b0:a38:107a:94f6 with SMTP id f8-20020a170906048800b00a38107a94f6mr864045eja.71.1707825679173;
        Tue, 13 Feb 2024 04:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUvdWZXM74bJB4Rm9is6EK8VXw0yMKJKBtt86Ip5QfFLyeVGqzL55Ok3sdvvtBmkJwVD+J43coQurJBxoVyoVJ1XDVZ10V5U7TBi2JREafSU/a1gF+aT30mEOa3PDoV2R+2pP3CqkykOxsBd9NQ/we9Rkqns0S2yMVji4vNuLHOxlGb2sq61KySZByPq0s2iS5jcFFhUyVpZmfPHc4tvWfOJntk1E3wy7EAB52UdvpbF8QDi7djjomjhba+WUcLPIxYfYt7K3eDLL+p8HccfjJQQJ0Vw1Cupin+Qyy8qpVY550VFLZn2026t8EP+zQ3157j6oOqwJwA5GqqIgcv8MOk5eoCAJwoMVbXEpwBwqhYpHT4mnjP4ZpGA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gz3-20020a170906f2c300b00a3793959b4asm1216026ejb.134.2024.02.13.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:01:18 -0800 (PST)
Message-ID: <845fb766bbe90865e2859af347ace76593e42c66.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/20] bpf: Recognize cast_kern/user
 instructions in the verifier.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,  Barret Rhoden
 <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Tue, 13 Feb 2024 14:01:18 +0200
In-Reply-To: <CAADnVQKfJsq6abdL5ShmmzOUKyBard4-9CH_j_V-yARfdn31qA@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-10-alexei.starovoitov@gmail.com>
	 <ed656ef900c33cb1bf9ffb06d0f4f59d7708e29c.camel@gmail.com>
	 <CAADnVQKfJsq6abdL5ShmmzOUKyBard4-9CH_j_V-yARfdn31qA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 18:58 -0800, Alexei Starovoitov wrote:

[...]

> Yes. Casting anything is fine.
> I don't think we need to enforce anything.
> Those insns will be llvm generated. If src_reg is somehow ptr_to_ctx
> or something it's likely llvm bug or crazy manual type cast
> by the user, but if they do so let them experience debug pains.
> The kernel won't crash.

Ok, makes sense.

[...]

> > > @@ -18235,6 +18272,31 @@ static int resolve_pseudo_ldimm64(struct bpf=
_verifier_env *env)
> > >                               fdput(f);
> > >                               return -EBUSY;
> > >                       }
> > > +                     if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
> > > +                             if (env->prog->aux->arena) {
> >=20
> > Does this have to be (env->prog->aux->arena && env->prog->aux->arena !=
=3D map) ?
>=20
> No. all maps in used_maps[] are unique.
> Adding "env->prog->aux->arena !=3D map" won't make any difference.
> It will only be confusing.

Right, sorry, I missed the loop above that checks if map had been
already seen.

