Return-Path: <bpf+bounces-73930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D99C3E439
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 957B14E90C7
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 02:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF12EB847;
	Fri,  7 Nov 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O26aZ+LJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDE2D641D
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482995; cv=none; b=VAQiKKDeBImD4Ld6KuZ6SpqwrI1J74Kpc9TRGuXw9OoJXwH8ghSfeetYPR/LZsjiEIHU7ucepoZa3jP50FYtE/gHx/pnQxW0Jz7aKYvHdba5PNziJSxrNnv56/rHhnMdTvWVfJPGXPmAtecYhV3o+bpD2ZKr8ElUxRTtiazSa20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482995; c=relaxed/simple;
	bh=obxXb/Sl+apJBp3bZ8Ve+Md8+bBG988BSB2EhmE/87A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MesjJI9QXIoMphtdHN3x9BQiQTZ6IJ3I8joGokLXZvkQNQmxWWNPlAVYEQ7SSubk30AnMJKwNRkdwMyDKjrGxZBMnLT8BJRhoALJgyDFAwtQjT7N9z5Pp2U1XW/P53ghhAN4xbdttiSUFwpb7RDIIZ/ohOhM3mGvfxcudK+MHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O26aZ+LJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b710601e659so42292966b.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 18:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762482991; x=1763087791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdERvUA4LmeniL9/JIYnkGzfArowf4bPxPQNGJRmaVE=;
        b=O26aZ+LJlH45mhbkAYf1bad3LRtgG3LUbCUMMjbePgPzTwejFNrsL58GyBeNMqqrav
         wl98GToDQChFFWjbAcXmNmpvHEB+T1SdaP8eejO5nS6j/ynA6o84mhuRDFHVM8DXSXzU
         6dBHn9Q/ykovQIvEMiusJQs4Gj2ioiyEinq9HXrgl7KLSFfCTLkXVqw5dtI0WocKPygB
         pD2QVn325E6brqM+b+8bx8DtU3RG20NKSV0Lb+X2a3K1TsiDuGbo6Pk+CPDss2NecQyk
         XGc4XT47gku2n2MjA4jF0NupTzQnJwDO+ZL6sTgRVKDlgI7HWm33yl+9EwsbSlz5vTgu
         r0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482991; x=1763087791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdERvUA4LmeniL9/JIYnkGzfArowf4bPxPQNGJRmaVE=;
        b=q3VSW0lMYY9aZnJ6dNfZtcEJQ27sfbSsdC23VY5HxjWZuqAUUVuQtO2XtG0939rYAl
         LUQjYB+njcahwdu5WIvIv/fjr/7gITwp/RaWiTjdCK2F/uyvGwnFZUrPyYzrlvGFsbnL
         dDX77hCaCzwO2zxFmX3OciGKSBhX642ED/COXZsur0iwqxKc9+sARd+8OrxceOJgVAvT
         7uNx/CM/b5sRLrmRxtoKBGErOWlxd6/hmeCwV5bU+TQzouMEpig2rcpIriQ34FGC5apb
         +JsO2DHGY73AnWpra1GvTWMRW9ZMxGEDQPJjpYGHEEjC5qsLhJUSSIXiiCJ0Y66wpPcB
         mH5g==
X-Forwarded-Encrypted: i=1; AJvYcCWN5MC0iyqJHc33EmlZ7p7qUu8BraVJDVUDOQ0yqKWzP3iKtn9f3FM89P3Q7jE0PI4mIiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzowOX+jkyWhq9UjxWPPBYIvPciKtmlz8047ONNZkllTFQre2Ly
	iIJRJ8Lr6Xq9mK5ZmdGrGy7JNL7jkBlSq0rv45Y2toOHZrB+bMvTwTEcuGYeCJUvifaHQrlGFsV
	WrqlRh4RS8JuGrjEw6asjXFMExx+x6nM=
X-Gm-Gg: ASbGnctOzcLLlY8IeBBPsU8laPv/A06dEAEcedxTLqz46LhNmcl9+LdYruuP7bJP9+I
	1ZIiLhMqlVbgn7hRm3tGa2sDljecz+8VsUfQYlx3FVQ60VZ9IAcPYJnFs2eqHcbALVSUIHfOPx3
	wWoeO3zk9r/9zl1wnrORjAmkOL+uMs+mFzZ8OUyKUGrzc6hPgwJq7AHD4/BMJcCeLCCBB0H/X7K
	LhZvSpGg3LjSsRwRHIgX9ss8DXgzUybmnUi/G0yK+KcRX3ksT51dHpNHA1IfA==
X-Google-Smtp-Source: AGHT+IHXtlNc753Qr5SE/fnZhaHM5SfepL+al077WyOeg9vKvZFZ4c7IsSSRVEtfyyipKLWSFV235QJiug0Y+ylpwno=
X-Received: by 2002:a17:907:3f1f:b0:b72:7dbd:3bf with SMTP id
 a640c23a62f3a-b72c0acb10fmr165942766b.43.1762482990612; Thu, 06 Nov 2025
 18:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
 <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com> <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 10:36:18 +0800
X-Gm-Features: AWmQ_blgR_6cyeubnJxR3DoIN2XVi-L-3p_U5g3NyquseylECfY43V3FKJ-xti8
Message-ID: <CAErzpmtnLcVXvcWCY39YHN3VWmLKbM3NJtZhRqi8BQrLCqRemA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:23=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > >
> > > > [...]
> > > >
> > > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx=
)
> > > > > > +{
> > > > > > +       struct btf_permute *p =3D ctx;
> > > > > > +       __u32 new_type_id =3D *type_id;
> > > > > > +
> > > > > > +       /* skip references that point into the base BTF */
> > > > > > +       if (new_type_id < p->btf->start_id)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > > >
> > > > > I'm actually confused, I thought p->ids would be the mapping from
> > > > > original type ID (minus start_id, of course) to a new desired ID,=
 but
> > > > > it looks to be the other way? ids is a desired resulting *sequenc=
e* of
> > > > > types identified by their original ID. I find it quite confusing.=
 I
> > > > > think about permutation as a mapping from original type ID to a n=
ew
> > > > > type ID, am I confused?
> > > >
> > > > Yes, it is a desired sequence, not mapping.
> > > > I guess its a bit simpler to use for sorting use-case, as you can j=
ust
> > > > swap ids while sorting.
> > >
> > > The question is really what makes most sense as an interface. Because
> > > for sorting cases it's just the matter of a two-line for() loop to
> > > create ID mapping once types are sorted.
> > >
> > > I have slight preference for id_map approach because it is easy to
> > > extend to the case of selectively dropping some types. We can just
> > > define that such IDs should be mapped to zero. This will work as a
> > > natural extension. With the desired end sequence of IDs, it's less
> > > natural and will require more work to determine which IDs are missing
> > > from the sequence.
> > >
> > > So unless there is some really good and strong reason, shall we go
> > > with the ID mapping approach?
> >
> > If the interface is extended with types_cnt, as you suggest, deleting
> > types is trivial with sequence interface as well. At-least the way it
> > is implemented by this patch, you just copy elements from 'ids' one by
> > one.
>
> But it is way less explicit and obvious way to delete element. With ID
> map it is obvious, that type will be mapped to zero. With list of IDs,
> you effectively search for elements that are missing, which IMO is way
> less optimal an interface.
>
> So I still favor the ID map approach.

Hi Andrii,

I've submitted v5 implementing the sequence-based approach, and I plan
to introduce
the ID map approach in v6. However, I have a few remaining questions that n=
eed
clarification:

1. ID Map Array Semantics:

   -  When the ID map array specifies `[2] =3D 4`, does this indicate
that the original type
      at `start_id + 2` should be remapped to position `start_id + 4`?
Should the following
      mapping attempts be rejected:
      a) If the target index `4` exceeds the total number of types (`nr_typ=
es`)?
      b) If multiple source types map to the same target location
(e.g., both `[1] =3D 3`
          and `[2] =3D 3`)?

   - If [3] =3D 0, does this indicate that the type at start_id + 3 should
     be dropped?

   - Does this also imply that the VOID type (ID 0) cannot be remapped
     and must always remain unchanged?


2. ID Map Array Size:

   - Must the ID map array size  <=3D  the number of BTF types? If the arra=
y
     is smaller, should any missing types be automatically dropped?

