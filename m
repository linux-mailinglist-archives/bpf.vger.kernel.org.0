Return-Path: <bpf+bounces-22985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171AE86BE0B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B27A1C22FF4
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7822D048;
	Thu, 29 Feb 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE9+CK/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAE2E84B
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168596; cv=none; b=JbmlwmNEpopMuJVoGyMgLnuKSbc8CHyzumIpFvrg0FywwygUMKUqjRHuX6WvyXiPT/+Bjhfe0Va8HCBSOGb4bIeww/JkmvKrRDi4rCz80pB/OPhh58R6vr8RTEjcFKONn1H4ATr9uaZtB+9xNeW7oGiI4+6yVDIatYsgiq4oSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168596; c=relaxed/simple;
	bh=C/nXnPeR2k8FpvfrY14osq+v+fspbLK/N9GU1oBNF7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSgFDvL8oC2jXUobwX8yEPXonju9nFGhC/N2zvrjBUzwAaeFa4NR5rOfKhEnc0pE81H4MxXT953vDulpDOdAV+WJUmcqsY4pUzuXMpXu5b6PmSamJeZv5wwJ4QTdBZX0xeIbor9ZUU19/G+aoQ7mxyVgkNW0omdjqHDVq7s9TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE9+CK/n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcd6a3da83so1992365ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709168594; x=1709773394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we+rMXuQNnICKOxKgjAw95c+gBzjrH6WX4ZiZJTtCTI=;
        b=WE9+CK/nAtMlbxHH85uHnAU1Wu0V7u+bG16Tk7iPJqJH9s0he6FRvULkqxOoS4TURh
         KaaBw069qOj2egHdVPeq14D2QFB7fbEl+CWXWFgNXtkbOp/M6dqqhhQZ+ztBRvgCCc1p
         vY1kMfwqbBU2gb399TDBykyB5qWKOoQTt6+cdBY1maUk1lyWSieCZlPoegJWndVwpdcZ
         uYWbxSuRnwQNQUywGikvQlUgdcKpgd/fggrB3G95NO6QD0dn5LJGjLP2g4HXusolSBrB
         LYdA6HBDEwpS+tK3c7n7LmIoQEF2BKQ+u00rVs7xlt7soOpxoGiyv0Cs19NhOKxpc1gq
         9Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168594; x=1709773394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we+rMXuQNnICKOxKgjAw95c+gBzjrH6WX4ZiZJTtCTI=;
        b=VwDylEabNVa5dmwOHVqMG9Ga/JIvR6Dmd6OmC+tyvF5QVXPMF+nNW4JSvVd2Z9LUQx
         UMzMKCKBlWmUpuaocz/6yCnVXrst6cIVFe33fAU3XrMvxY2wLhxAU8mvL28VSjXFMNOj
         oNkwi8T+c9SNoEkrDt8jRD9ma5faBrOnSsSHzsoTFOqudtgtu9QpcJyEhIMWMSryKXhi
         ZdZ7t7Wbpc0H31vyr0PeZwakh2CBjl8wjQeH7UIUNiCG+0q7DDVmcM9UgVkhA27CbbKv
         khPWMmB42K1/0BYad46CxeTs1eMorxQV4PAW3KvhuCDq4qVhWpI2o6cuRzvtwenbOG9/
         M41Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPioeI4wkEpRbECdGx4w2YGdT6SUJo072lXEucNLG/prlRe6MHu4NMSsa+4HfJxRF3FhyYdFTQNdWF0LWQb1sqFta5
X-Gm-Message-State: AOJu0YzL2kdscm2qIb9nCt22YAaKLJ9lLB229lvFj7XQXKD/Kylzqt2v
	UrUupMytlyyk0Pdf2qGahyQEFhtZXiuov+C4eClKFFIDMTXC0+yyoMN/UnPn8hhpdVnuJDsRxeZ
	FOdEmPNnXdMGAqdMudsptZ+7p94E=
X-Google-Smtp-Source: AGHT+IGaMg36xXWj2DEW8P7i1cPmuHPVQ/w8vhdlfXpurQo8X00daqfHpu2I62nRn1ekbDy51xXPmbhwUDJK7mWKl34=
X-Received: by 2002:a17:902:9002:b0:1db:ceb0:2022 with SMTP id
 a2-20020a170902900200b001dbceb02022mr667423plp.27.1709168594232; Wed, 28 Feb
 2024 17:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
 <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com> <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
 <CAEf4BzZSx7XJ4gmq=omjuw0u=CZpQFS=u1iHipOHg+PQN899Xw@mail.gmail.com> <63fb7cb7-e884-472f-a81f-182d5867d1d4@gmail.com>
In-Reply-To: <63fb7cb7-e884-472f-a81f-182d5867d1d4@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 17:03:02 -0800
Message-ID: <CAEf4BzZYeSCk+vO1GXYej3m7JzWrudojs7gRZTow6KVkOCY_UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, quentin@isovalent.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:44=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/28/24 16:09, Andrii Nakryiko wrote:
> > On Wed, Feb 28, 2024 at 2:28=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 2/28/24 13:21, Kui-Feng Lee wrote:
> >>> Will fix most of issues.
> >>>
> >>> On 2/28/24 10:25, Andrii Nakryiko wrote:
> >>>> On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gma=
il.com>
> >>>> wrote:
> >>>>>
> >>>>> + * type. Accessing them through the generated names may unintentio=
nally
> >>>>> + * corrupt data.
> >>>>> + */
> >>>>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ide=
nt,
> >>>>> +                                 const struct bpf_map *map)
> >>>>> +{
> >>>>> +       int err;
> >>>>> +
> >>>>> +       printf("\t\tstruct {\n");
> >>>>
> >>>> would it be useful to still name this type? E.g., if it is `struct
> >>>> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this o=
ne
> >>>> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
> >>>> similar pattern for bss/data/rodata sections, having names is useful=
.
> >>>
> >>> If a user defines several struct_ops maps with the same name and type=
 in
> >>> different files, it can cause name conflicts. Unless we also prefix t=
he
> >>> name with the name of the skeleton. I am not sure if it is a good ide=
a
> >>> to generate such long names. If a user want to refer to the type, he
> >>> still can use typeof(). WDYT?
> >>
> >> I misread your words. So, you were saying to prefix the skeleton name,
> >> not map names. It is doable.
> >
> > I did say to prefix with skeleton name, but *that* actually can lead
> > to a conflict if you have two struct_ops maps that use the same BTF
> > type. On the other hand, map names are unique, they are forced to be
> > global symbols, so there is no way for them to conflict (it would be
> > link-time error).
>
> I avoided conflicts by checking if the definition of a type is already
> generated.
>
> For example, if there are two maps with the same type, they would looks
> like.
> struct XXXSekelton {
>      ...
>      struct {
>          struct struct_ops_type {
>               ....
>          } *map1;
>          struct struct_ops_type *map2;

It's kind of non-uniform. I think we are overengineering this, let's
just do <skel>__<map>__<type> and see how it goes? No checks, no
nothing, pure string generation.

>      } struct_ops;
>    ...
> };
>
> WDYT?
>
> >
> > How about we append both skeleton name, map name, and map's underlying
> > BTF type? So:
> >
> > <skel>__<map>__bpf_struct_ops_tcp_congestion_ops
> >
> > ?
> >
> > Is there any problem with having a long name?
>
> No a big problem! Just not convenient to use.
>
> >
> >>
> >>>
> >>>>
> >>>>> +
> >>>>> +       err =3D walk_st_ops_shadow_vars(btf, ident, map);
> >>>>> +       if (err)
> >>>>> +               return err;
> >>>>> +
> >>>>> +       printf("\t\t} *%s;\n", ident);
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +

