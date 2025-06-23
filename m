Return-Path: <bpf+bounces-61321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FAAE55AE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37751BC48E4
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28822652D;
	Mon, 23 Jun 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4wlPUBW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F77223DD0
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716763; cv=none; b=bYkJOomXsCmGjowk50LG9fkmYH6sywRYqN5k/3aC/llA9k7OJrfYtk0t7EVxtAFgFxz74RpSiphBYAsBZFr3r3HtKJB+rg2LvXWcmDHQQLIpj88+lzOGHMIUIjCqHlZDGNLHZjVQRUhrS0Y0r7vuYO1lz2vz1Rjy/O7QI4AoFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716763; c=relaxed/simple;
	bh=l5p9g/mNd3MrHwEauwdB61F3WKy4DSTF2ETkr5A0NvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnjmWdPQFXG4klFgn9nkNS3P39eFnw2YwSzkcPqeZgPS8+9qenb7x1wEGc+dFpIbRKgRWrd98bR1hLD+lgHU9GYWrsVA5HVbvV0BT71JPUIKM7YR9hmsBgS2FtBAiK7YDiK3TaBkscrUgEul4x669DbgYdXCIAw8rqTTkdiI2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4wlPUBW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122a63201bso3375963a91.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750716761; x=1751321561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5p9g/mNd3MrHwEauwdB61F3WKy4DSTF2ETkr5A0NvY=;
        b=e4wlPUBWE9YjD7DIYyF1Cn8DEAK53GVgOL0IDlBSp52rfssKJABeddjbjDgA3QUtbL
         5iOvEg4rGApd8DiTAYdN8tPVx7gdLJaNXsfeX6r7Pzp7fJb/gX74iWJJG9AE+HSM87pB
         o+dDwXRTMsJ42Xs5eaNwrSS9KhNNfB4IVTNJH4NEcUVHs7vbp5KoS1xzqsmvVjU1mb5J
         71R/00i7Kwu1/QRHlw9MLJCWLUoFQlOc+rmad46HKGl1oZ9pgGO/nu/kOeZshBhvE40R
         0PIHPiFZWqgdL/4gyxmv7gCEta1Gde/11QVq9AYSAH8mnbDtJ5P8fd2NIB5DXLGm4Aup
         t0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716761; x=1751321561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5p9g/mNd3MrHwEauwdB61F3WKy4DSTF2ETkr5A0NvY=;
        b=d19a7mrMbV/lG9T8DxVfgcsXoepOuHXPRK01wAT6OhzfHpfa+r/ECNNw6tf/+SSKZq
         frf2MEL/7mjVtaOTKXtYq7KkU1sDwhrBdegAmCC2r27tBWzEu2Pac19EjustIbNiSEyy
         bOmlMFkgBrIMqSP59iiyCb1ROuHtA8Ka+8spucoN9qe0pO4aXsP0jwCywbW+u0bXag/W
         6pf+MjoBlGyGr+GwzwuiIhr13UsunVy9amPtrhmbZX+lhygzDHAhXK0e55ElI+vKLF/V
         6NtLuVdEdjkPtfIEfYywteenOxn9UUW/EBlEWkxed9OYyLamDPHlSUKLfaA3pE7WaAn5
         Vtsw==
X-Forwarded-Encrypted: i=1; AJvYcCVs/v9zBo6oIHksC2WAdft9YwJWv9s5YCA56sAWkY31kpi3IcYzu4hUizSdg1RXhqwt8RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVkM0po1GQFkBaeEjepXD+qznST1c2RuLTsNRJRtyImsKIPb1
	qSLR7ojO3PNOMNzoQ8UzgntC0abFdW5YhTepUOYU2fxTrM+eiFJZOXtgufpidqumyVHX+MELfea
	s3ASnXNc7FnnLJx6gaZAi5PGylmoat6M=
X-Gm-Gg: ASbGncs3VxAot5fjdWqUlZMHAc9tIJNRXBkwk1KJP/c4tboSzIc7jhJGNBs5IqwUDm6
	lXH004EPuMsPjB6snZUpSXnLk4VFX+WgzAJL3qsD2raqZaIXcHmJ4HhercruiGqdNPPyh8kDBXI
	3HERoopCaDZAuFe5IwDAhLCfDIanzYVn4BJoHMyzYd5BuU0U93sJTYkcZFZcHndaukG1jr9A==
X-Google-Smtp-Source: AGHT+IHDarZ3s3GMD0Z6dvOcYCDwKgjh/Ko8WLRmMj1/iS8y14fl3bn8sh1sZQomoNCb2AcVwuaSHOjzXBvoppC0X2E=
X-Received: by 2002:a17:90b:2dd0:b0:311:b3e7:fb31 with SMTP id
 98e67ed59e1d1-3159d570072mr26033070a91.0.1750716761401; Mon, 23 Jun 2025
 15:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618223310.3684760-1-isolodrai@meta.com> <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev> <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev> <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
 <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev> <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
 <a64d331ff474e9896c7d6c071e027c34fc8c2966.camel@gmail.com>
 <CAEf4BzYZBMOexPSM9=utpn22W=XMsztiE_X9AxO9CSSb1yv7LA@mail.gmail.com> <59e7ca59c4c0ac455aa05c7ebd0ecd67871a5b47.camel@gmail.com>
In-Reply-To: <59e7ca59c4c0ac455aa05c7ebd0ecd67871a5b47.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 15:12:28 -0700
X-Gm-Features: AX0GCFvZM2gTuQ3t3GrNc00zek1W8BCMM5DSy8snDjwxTOrhYA84IxV0ilRKe3E
Message-ID: <CAEf4Bzb2Lt4Y2GrVGkiX3RWujaeO=HyRiKC0Vv=Ys_NKRuBRKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-06-23 at 14:38 -0700, Andrii Nakryiko wrote:
> > On Thu, Jun 19, 2025 at 11:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Thu, 2025-06-19 at 11:13 -0700, Eduard Zingerman wrote:
> > >
> > > [...]
> > >
> > > > Also, what's the plan if you'd like to memset only a fragment of th=
e
> > > > memory pointed-to by dynptr?
> > >
> > > Oh, I see, there is bpf_dynptr_adjust(), sorry for the noise.
> > >
> >
> > Even though we do have bpf_dynptr_adjust() for maximum generality and
> > flexibility, for most dynptr-based APIs we try to pass also additional
> > offset into dynptr to avoid unnecessary overhead. So it's not a bad
> > idea to add this to bpf_memset(), IMO.
> >
> > bpf_memset(struct bpf_dynptr *dptr, u32 off, u8 val, u32 n) ?
> >
> > a bit unfortunate that we have 3 integers that you need to be careful
> > to not swap accidentally, but even with just val and n you'd have to
> > be careful. For other APIs we normally have offset to follow dynptr
> > pointer, so hopefully this arrangement won't that surprising.
> >
> > Thoughts?
>
> Unfortunate indeed.
> The off and n being separated looks weird, tbh.
> For dynptr funcs we actually have "dptr, off, size" everywhere, maybe
> do the same here?

yep, fine by me. I never liked libc's memset() order anyways :)

