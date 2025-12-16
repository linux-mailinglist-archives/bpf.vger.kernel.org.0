Return-Path: <bpf+bounces-76750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3220CC4F94
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60833035D32
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D03242D8;
	Tue, 16 Dec 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF1o765S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1022D7386
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912106; cv=none; b=igupy8qqTgOv19KEy07JFpEGva0Hu1TdrKAbKhxa/LF/Ty0yQjPHeEsRE+Cm+pvvrxAG+BFoOWXxhpSSiTwexgG6ZjjWXd3F84xRo+QsCgAmq1gL6aUH8i0YV4SvhDwWRBYHlr2B1gNS/FLsKqJqb6D0gLJDAYxWxzSp6LRnUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912106; c=relaxed/simple;
	bh=Oz421mBfc+nd/9J8B6Ilvjq8JK3tVbtGnajxx1qZ0pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H78qV91zhy0EPbuhfQvWHAwBIfuAEjx1IRTKxoZVhyX16Hi2MTZ/1iWzj6B3roQ5cTeHPAcPOAuMXk4n04JFpBMVm7mOZUTZ2xAgvpBAJM+KNlJ8wyf58xjfd0d6DcyBwlZk5mDgm7hjCn+dkJmX/QhgJpmhat+9unE4IqU0nRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF1o765S; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a102494058so12448445ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765912104; x=1766516904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2gi4EBUfZC1iIQ5EjeNLXG6e++zWRaNtj8SUktILo8=;
        b=hF1o765S0yWLTpueVV63nF2nfuUS0XAmdbVkYiy/2yj4BT0z7jrBGo22pAlbiz0qri
         1lv5QKwHO2bS64OxnhqndqcyE0PfcWPhVuGf/UduC9TmyrV+HECE1BtJ3VF53VakU6Mt
         dS3Wkoh9TQg6E4MWGTaDIOO9i/0I/H9CW5dmNpx4GV0Tv/pejeMGZ0jeEk61uMt8gq70
         yP9oOeDjsT6prbQVW0KiPrGdQ/sqQHtAR1P83K2wGxc6WnFfx4c7l8M4f8l5u5JUAPz4
         99bbn31q9hzLcDvDgGw/EUWAwIpda6OziUrS9be99/14yBFTKvTjf3jw2JaZTliBCvN4
         98TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765912104; x=1766516904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2gi4EBUfZC1iIQ5EjeNLXG6e++zWRaNtj8SUktILo8=;
        b=Buk/lHQHUqvvoZbllTZckY/DV9tjxxW/AKunCtri2YrzY+jVTKujfDDcmGBrPODiu1
         pHUFxhKYZnF7JloEOzvY+E6IXUJKBtQdGr9+hJDh+5Bt+oOjWezo6WXbCIojA3xXisn0
         jf56NqxIy+P9SRmfGa3mM990dOKA3+Q3hFzSkZgfLlEGf4TbQBU3PvfiXTmICFwZWkH9
         ur4DvxkuAAxZ1ebCsJmCwctHYrzXik7lOplm06O2udRihjfOawBhiq0KM+IY32Kt0j1U
         qD7+RkpBUS8j8WzT+eZXcIl9YHf8+JtAML4Bdmg/VrTS5JxKZtuYUaOWVSG+cEqRDPEo
         hcGg==
X-Forwarded-Encrypted: i=1; AJvYcCVdtelWJqVFOvjgrPlxy03eJRBoWPr2SCmlp3id/ciE0XSMex40SBenYJjoVAmgYQ0cIAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRajcwhF0P0Ke4/ptVlD/9UVbHsyrtKrKcCg5KvfdV6ZuNSFx
	gIHvoBPDvwhGn/KnjeDuhzHILPQMmZqkCHEoAkDY6Na+YTAnvHpo6LdIJhSo+WeXPI/hx2A0+Bi
	7rAU7AN0bfRTITq5KCpPRLtxa7Ehf1XQ=
X-Gm-Gg: AY/fxX74kUZaRPQqDG47jVNekulHlSEmJll4VMQsOOySL7d4sv0NOpjDVsLnbgpPNnN
	J8nDzMbIjrGhDwtF4JcSNjDHITXZT4RLNVD5FMEvlEWn31v1VvpM7kg7U5ZkZQcl5EUNf2BzijZ
	HpcU312EKg1+QRo5ckhKRLKUow24NJfxaI5qb3pp0d+lRwdfCZ+257dBXhGihnVBN/sO0rPOdz7
	b3/tcuP2g0N+7loAAsaFi2oDQq6DTJxso9F3ugbmAOHQUOqwu+ufDSCShheOzeuaoFvBGRJv1XL
	Nfub2UovRCo=
X-Google-Smtp-Source: AGHT+IHWaB5QBIi/BO98cksS6WIHpOCqi1T+c5+gAn6G/7I9XZPRtqtspMi1xspLsUG8gVFN8nF8Ya5JYe1hHFMlLiE=
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id
 d9443c01a7336-29f24800550mr171810685ad.0.1765912104205; Tue, 16 Dec 2025
 11:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
In-Reply-To: <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:08:11 -0800
X-Gm-Features: AQt7F2qtO9dZkkOkoJVY0XIVgMeb7rH6184opRrSVnjo1NAR4ssvg0PW-iUPg-Y
Message-ID: <CAEf4BzaAY-zGN2t62=j_bX334XXn4Mo1bgwmhRhh2N5S-DAtRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, qmo@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-12-16 at 17:18 +0000, Alan Maguire wrote:
>
> [...]
>
> > @@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct btf=
_dump *d,
> >               case BTF_KIND_UNION:
> >                       btf_dump_emit_mods(d, decls);
> >                       /* inline anonymous struct/union */
> > -                     if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
> > +                     if (t->name_off =3D=3D 0 && !d->skip_anon_defs) {
> >                               btf_dump_emit_struct_def(d, id, t, lvl);
> > -                     else
> > +                     } else if (decls->cnt =3D=3D 0 && !fname[0] && d-=
>force_anon_struct_members) {
> > +                             /* anonymize nested struct and emit it */
> > +                             btf_dump_set_anon_type(d, id, true);
> > +                             btf_dump_emit_struct_def(d, id, t, lvl);

Alan, please check that you are handling padding at the end of struct
that you are inlining artificially. I suspect you'll need some special
handling, because btf_dump_emit_bit_padding() (as far as I remember)
is trying to minimize unnecessary explicit padding. But it does so
under the assumption that we have a self-contained struct definition,
so there will be no more fields at the end of struct.

That's not the case anymore here, so I suspect we'll have improper
field offsets in some corner cases. Let's add appropriate tests and
make sure all this works.

> > +                             btf_dump_set_anon_type(d, id, false);
>
>
> Hi Alan,
>
> I think this is a solid idea.
>
> It seems to me that with current implementation there would be a
> trouble in the following scenario:
>
>   struct foo { struct foo *ptr; };
>   struct bar {
>     struct foo;
>   }
>
> Because state for 'foo' will be anonymize =3D=3D true at the moment when
> 'ptr' field is printed.
>
> Maybe pass a direct parameter to btf_dump_emit_struct_def()?

+1, that seems like a bit more robust approach.

>
>
> > +                     } else {
> >                               btf_dump_emit_struct_fwd(d, id, t);
> > +                     }
> >                       break;
> >               case BTF_KIND_ENUM:
> >               case BTF_KIND_ENUM64:
>
> [...]
>

I'll reply here just to not split discussion. I have two things I want
to discuss.

1. I don't like unnecessary options. I don't think this anon struct
field embedding should be an option, it should just happen.

2. The above would work even better if we can actually support both
-fms-extensions and -fno-ms-extensions mode transparently.

AI tells me that -fms-extensions should be detectable at compilation
time with #ifdef __MS_EXTENSIONS__. I haven't checked, but please do.

Assuming that works, we can (and probably should?) emit

#ifdef __MS_EXTENSIONS__
    struct inner;
#else
    <inlined struct inner fields here>
    <whatever explicit padding we need to preserve layout>
#endif


This way #1 is a no-brainer, emitted definition will work correctly
everywhere. Please check if that's possible.

pw-bot: cr

