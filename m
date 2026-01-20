Return-Path: <bpf+bounces-79522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FFBD3BC5F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD497303ACC9
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D2DDAB;
	Tue, 20 Jan 2026 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgTTFhFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9E7261A
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868675; cv=none; b=kBHq9pyT1t1tmk0JCJLJpUrw2l7WsRrCI3fakaZDTVuIggnz6dF4N7kwdJw2XgNXmRJM0wNtSsy+VBnjr+92Usxua22mZA2GGpbAvNRNUBRq6GdZoGl2SmQCLokpiev7zIAlWWUUEPJONLbIJ5TT0ODMnCGCurwaSaK0JslW514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868675; c=relaxed/simple;
	bh=w2H1YPVYtudUWltYXZ41qh5f0rKjF7tgzBkZiRvPNNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJ9tkoToUKL+bAvd8g4YWOYxDYI1rcmX13jIDh1ywxj21O3MLJCt93oWQRZu1hGzr+KVRwBdG8bkOGBVImzAMmCK5r/xFKBRI8QSRMZxx1Zp5l7NMgqtJRD9tQOPc2IWgrjKRFUiCTtThC6M9hJTWdZOe+zSNBDnkF1IlfftDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgTTFhFO; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6bfb0004aso6633686eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768868673; x=1769473473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ugODr4tJzWtUG5ArCmSAiLBMI2Kv5mSCkYy+oirIgik=;
        b=LgTTFhFOIQwGhfxWPzIO6P661MiNRHjAU7027FxJBHqYUT3G70BGgAGIohS8has05E
         jJAZIUHceMseEpuWU6nmY4c1KHd6pX3Kejg/3F2FnmEPg0bv0Trs6Ap09cBHq2M4XC+o
         uYwuNSRi8wOtVvWFojw3MUPZXWFL8k+SrW9hPibs9lNyt0uVpb772hKM//ExhQ9SgU5d
         d8pxv95xar/Fs9WsiTKI3kexZ+zJo3R5Uy+h0g3TpnxDX9ZZQo71AZUhlchZ23Zqj+WT
         WyogexAM8h+wHHUyEQ47/J7u6uiRGF5OXXczeklVyjOtF/Bo4NWhg9evaGjG+pyeTrpr
         A0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768868673; x=1769473473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugODr4tJzWtUG5ArCmSAiLBMI2Kv5mSCkYy+oirIgik=;
        b=qS6oWNMxn9xO1k9tVGzj2b7fLdAk22Q8uxESbP4L4JtXyMMF8GTtCw0kc1PyBCOW4O
         dm7FmJQJFRQNgCCo0khmkpeU6u5FUHyFHY+M87XU92jGJeIC/fkNdkz3CUbptOvUdOSL
         CWFRYAtYIXO3g7wLoq1c0FqEeihoMZpw2rBvvneGvgBAsDwXUHNgo7/0me7XV3N5dyfr
         84PzPO9b0mpqZeup/0f+ZE0nNXQRjpH2bAoDSqPqZCPqDg6UsKQSKHFp7Jycq5Agc3oU
         OOCkifdTfhWLNeQQWgGmP8546WrdqzZOAla7ae46NLJe4qJ9Pxf/RotOpEyk5St1vsP5
         F2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXTDnAaUh0B4o7PAcDuPD37+cMTG+NWa3JPk0udPalGtbirr2iqTwlNnP/QilV3f213Bw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRmzOCJ6CA+H14ElOBVOeRRzd6Yhl6u4KOmJ24GA3v+8zGWAB
	NWPyJTI6r64tweNO9ZZOyzvdiEzrrwgWo6SwQv+3rBEcXyDZ56mpnsAA
X-Gm-Gg: AZuq6aIPJEFsZv9JA3I59bQZC9YjnXeExt17LJwzAWNy+hDVO104ra1KeAISpE8Tvg/
	7dgzCLZEqdCkd1O2edFe0XoQ+YLEJoRW0gNzPB6lkNOBq8MMhZz14/kCCVf/UdXu6teLbzDONOp
	CTfQNhe+9OWTQg2fYAFrqLUFTH/lkxF2jy/lOwTmM3CwekHhhURl+DqG48GsOXOvMGqWehlhdcy
	lqeKLkNvVeHYKS1fPOOcZNKXdT8h85vSU+igF3CMy/11sj5rSHryxoz9YxOn6rUvpOO8enhoy1t
	f09zwTCpfAcHEOHhb7QI0pb6/iH0nXxCEgMv/LnnZo+OIJBqnOOaIDUPh1ViUvLDjY986s3xllq
	BhemLdzmYaPxrOEcm4lONWH83xNc9ddbJvTPy8tRqktUuLQ5yXFJEdoxVn7lsE57EOHnXgSQxxo
	7Qri3GBaPj7m455cJMR8rhbR7zkf5ib0XJ+NDqIzvPQCnbPBvMZlee4i/UF020bSDPuyJTe+oqm
	eU/
X-Received: by 2002:a05:7300:a507:b0:2ae:5664:8110 with SMTP id 5a478bee46e88-2b6b414aba3mr7857799eec.38.1768868673097;
        Mon, 19 Jan 2026 16:24:33 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c122bsm14877286eec.5.2026.01.19.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:24:32 -0800 (PST)
Message-ID: <c3a04c5063cc9b68f9719c27ab1acb01b199ca3b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Mykyta Yatsenko <yatsenko@meta.com>,  Tejun Heo
 <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires
	 <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, Amery Hung	
 <ameryhung@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:24:30 -0800
In-Reply-To: <aff3f58f-aa81-44a3-ae5f-078befeceb39@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-6-ihor.solodrai@linux.dev>
	 <CAEf4BzbG=GMh0-1tT_2gdMtc-ZuV3X7hgoJZpt1RLCYgPMM3oQ@mail.gmail.com>
	 <aff3f58f-aa81-44a3-ae5f-078befeceb39@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 22:36 -0800, Ihor Solodrai wrote:

[...]

> > > +static int collect_decl_tags(struct btf2btf_context *ctx)
> > > +{
> > > +       const u32 type_cnt =3D btf__type_cnt(ctx->btf);
> > > +       struct btf *btf =3D ctx->btf;
> > > +       const struct btf_type *t;
> > > +       u32 *tags, *tmp;
> > > +       u32 nr_tags =3D 0;
> > > +
> > > +       tags =3D malloc(type_cnt * sizeof(u32));
> >=20
> > waste of memory, really, see below
> >=20
> > > +       if (!tags)
> > > +               return -ENOMEM;
> > > +
> > > +       for (u32 id =3D 1; id < type_cnt; id++) {
> > > +               t =3D btf__type_by_id(btf, id);
> > > +               if (!btf_is_decl_tag(t))
> > > +                       continue;
> > > +               tags[nr_tags++] =3D id;
> > > +       }
> > > +
> > > +       if (nr_tags =3D=3D 0) {
> > > +               ctx->decl_tags =3D NULL;
> > > +               free(tags);
> > > +               return 0;
> > > +       }
> > > +
> > > +       tmp =3D realloc(tags, nr_tags * sizeof(u32));
> > > +       if (!tmp) {
> > > +               free(tags);
> > > +               return -ENOMEM;
> > > +       }
> >=20
> > This is an interesting realloc() usage pattern, it's quite
> > unconventional to preallocate too much memory, and then shrink (in C
> > world)
> >=20
> > check libbpf's libbpf_add_mem(), that's a generic "primitive" inside
> > the libbpf. Do not reuse it as is, but it should give you an idea of a
> > common pattern: you start with NULL (empty data), when you need to add
> > a new element, you calculate a new array size which normally would be
> > some minimal value (to avoid going through 1 -> 2 -> 4 -> 8, many
> > small and wasteful steps; normally we just jump straight to 16 or so)
> > or some factor of previous size (doesn't have to be 2x,
> > libbpf_add_mem() expands by 25%, for instance).
> >=20
> > This is a super common approach in C. Please utilize it here as well.
>=20
> Hi Andrii, thanks for taking a quick look.
>=20
> I am aware of the typical size doubling (or whatever the multiplier
> is) pattern for growing arrays. Amortized cost and all that.
>=20
> I don't know if this pre-alloc + shrink is common, but I did use it in
> pahole before [1], for example.
>=20
> The chain of thought that makes me like it is:
>   * if we knew the array size beforehand, we'd simply pre-allocate it
>   * here we don't, but we do know an upper limit (and it's not crazy)
>   * if we pre-allocate to upper limit, we can use the array without
>     worrying about the bounds checks and growing on every use
>   * if we care (we might not), we can shrink to the actual size
>=20
> The dynamic array approach is certainly more generic, and helpers can
> be written to make it easy. But in cases like this - collect something
> once and then use - over-pre-allocating makes more sense to me.
>=20
> Re waste we are talking <1Mb (~100k types * 4), so it's whatever.
>=20
> In any case it's not super important, so I don't mind changing this if
> you insist. Being conventional has it's benefits too.
>=20
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c?h=3Dv1.31#n2182

In my test kernel there are ~70K types and ~300 decl tags.
Allocating an array of 70K elements to store 300 seem to be quite an overki=
ll.
I'd move to what Andrii suggests just to reduce the surprise factor for the=
 reader.

[...]

