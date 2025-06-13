Return-Path: <bpf+bounces-60620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA2AD93B4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24553A1CF0
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABE223324;
	Fri, 13 Jun 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzFs6YL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED0221D94
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835300; cv=none; b=PU63HzDd0yEMy0sEPjW+KL+WRckGEX7xUHk++tipJS1gL4Fs97Hsd0JKRmqdTLIUIN3vDqI/SXPUD3y6f4GyGXcb7XqXdPJnla5rvbO+3TEPsPm5cftYUht5Vma/x2CWsDADYIesFnrHB/LdZ0AWLEfx6tWLqJkVhFkKSq8oXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835300; c=relaxed/simple;
	bh=cRsTY6tBqo+TEDNURDB4Eh7le5paE6fF31ly1M8Ee8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3GRLmcaDpMvWRuchwGyzE9kOkP3jJvDPuQ3hFPBrqDdbTYjh/bYlM59043OofJNrV5Ml1FdnNCi+CHRKNGjJ+K9MtvUK5lOg2Zau1d/lFOMqNpT3vNyqA/LYRV4oihEi/fi/RoVCJJKLwbxIKxJLuAScNk4+m7OijGasFnI5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzFs6YL/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so2133648a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749835298; x=1750440098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY1mHLi8uYv9Ftwy4erUDfT1f4kpN3SFueRBAPuuz8w=;
        b=NzFs6YL/BQ/duwySrd8CSni5BtFyBLOMbU4hF6OXYbQrnKJ3NG8xv1Wq2+Se40sRWA
         Bp5YAAgOXZx926zNNZTjTpfFhkKQyS952+f8hn41hgI4SY4tUBltTPun7YVG74dOlvJ8
         gkVQFQIfrJbQcmMfP87Qi2hRZ2JzizDtg+79ZEumIop5bm63Kzc8Dm0zyXz9GPa4o9Xd
         FFyPgfTcEROKucPKyHZcZg2GVJc61JrknnPNFdDinQdfhtUYRFJBGTKwrj2/GH6DhFIk
         jin+YGJ4L161U0xUkDk+K1PQ9rjaTmcL5PBkySKiX44+1bAlXOdxD4P5TSBaGzPrT+0s
         bNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749835298; x=1750440098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY1mHLi8uYv9Ftwy4erUDfT1f4kpN3SFueRBAPuuz8w=;
        b=VtK5xWPdho8c16u2GdBSwma8NIaN0JmuAeOca5aGHN7uhK2GUl6YQe1NFs3KUw01e5
         o64SnRTUkp+d2KWdA73D6Za48OchcNyWZsaK6iSnhDzM5gmsmoQJCeVDBLhNRdMvqWai
         rREFV58kkI6vKK1ynL5b+N0YCzXOrPV4+KspB0nyGz7CjxCAO7/nt0BEb9PThPW30GTC
         38GtzJ2bRg+fwCjFJr7PrHaCY9QXq6k6Z0MMTggn+5abN+2XzkbiBElKJaciTDZT0i6f
         CypZFe7nLun53cvDUtvm8U2FZ4E2MJybbuD4F+fwMyyzOCPxdB23fr+87M0PgM/BDLyo
         oc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/MAdtu6kxAUvnAWY9iE3HBjaOQyNBtUSmgYzt4W6fRLMtsF/el6NxzABDXwXom9N4n3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBG1WDz8CA7GuP4e2lTe4vYhbOjHd9g4PzoyWULhZ+Ry1oKUML
	4xHST/fqqMWoMVbh+TdjBUutmbH9GLrbyxRic/bLGUTBHh/bDWEDOeN1lDVmP3tZ1e1Tc4UJDvz
	Mq0QvwjRL8JIfHR/0eev7Uq+aJd74CNg=
X-Gm-Gg: ASbGncsaAaELYb/W2VwQQSEyKYxRnHqEpfqzqTp2wrlwSLCGyvlTpNkspu3H4ptR4QM
	jMv7xIFsIskOf3XHpQraVR+D5ONIpTlvWZqxVNfAV6FlDSIr2lBRlflW1DdAVG8C0NB+jvifvUD
	o/icuvz3h21ZNC0iy2rdApNwC87OiAEAsbSRlrtaexI0UFhDwKMGSvkERiOh1xHzbzlO0wNQ==
X-Google-Smtp-Source: AGHT+IHu1irFqibEqDz+w3CrKfQcG/NC+9jrDv8gNl7428z8WbEkmb1zDdZ7oW1p0km6qlpZCO06o4UzAQSqGixamC4=
X-Received: by 2002:a05:6a00:22cd:b0:740:afda:a742 with SMTP id
 d2e1a72fcca58-7489ccee906mr356351b3a.0.1749835298284; Fri, 13 Jun 2025
 10:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com> <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com> <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
 <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com>
 <cb96c155c563cd8998fb8c8683a4b53497b373cf.camel@gmail.com>
 <CAEf4BzYLGcKvFWTP1sOOSsJwyP54F2oFq0COKUaKeSg1zZb0+w@mail.gmail.com> <bd1458d3166ecac6bb88e15bf2fd69a3e47f18ea.camel@gmail.com>
In-Reply-To: <bd1458d3166ecac6bb88e15bf2fd69a3e47f18ea.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 10:21:26 -0700
X-Gm-Features: AX0GCFvMm5DnmRKp4Cf42gc2-tcwwjxatIuzmlZESuzbAQ6YDZr7Q9Wb_QX35sk
Message-ID: <CAEf4BzYW_denf41UcSFWb66T8STMiu1RFAJaMNs-p-aXrqu5_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-06-13 at 09:59 -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 13, 2025 at 9:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2025-06-13 at 09:34 -0700, Andrii Nakryiko wrote:
> > > > On Wed, Jun 11, 2025 at 5:21=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > What do you think about a more recursive representation for prese=
ts?
> > > > > E.g. as follows:
> > > > >
> > > > >   struct rvalue {
> > > > >     long long i; /* use find_enum_value() at parse time to avoid =
union */
> > > > >   };
> > > > >
> > > > >   struct lvalue {
> > > > >     enum { VAR, FIELD, ARRAY } type;
> > > > >     union {
> > > > >       struct {
> > > > >         char *name;
> > > > >       } var;
> > > > >       struct {
> > > > >         struct lvalue *base;
> > > > >         char *name;
> > > > >       } field;
> > > > >       struct {
> > > > >         struct lvalue *base;
> > > > >         struct rvalue index;
> > > > >       } array;
> > > > >     };
> > > > >   };
> > > > >
> > > > >   struct preset {
> > > > >     struct lvalue *lv;
> > > > >     struct rvalue rv;
> > > > >   };
> > > > >
> > > > > It can handle matrices ("a[2][3]") and offset/type computation wo=
uld
> > > > > be a simple recursive function.
> > > > >
> > > >
> > > > Why do we need recursion, though? All we should need is an array sp=
ecs
> > > > of one of the following types:
> > > >
> > > >   a) field access by name
> > > >     a.1) we might want to distinguish array field vs non-array fiel=
d
> > > > to better catch unintended user errors
> > > >   b) indexing by immediate integer
> > > >   c) indexing by symbolic enum name (or we can combine b and c,
> > > > whatever works better).
> > > >
> > > > And that's all. And it will support multi-dimensional arrays.
> > > >
> > > > We then process this array one at a time. Each *step* itself might =
be
> > > > recursive: finding a field by name in C struct is necessarily
> > > > recursive due to anonymous embedded struct/union fields. But other
> > > > than that, it's a simple sequential operation.
> > > >
> > > > So unless I'm missing something, let's not add data recursion if it=
's
> > > > not needed.
> > >
> > > Recursive representation I simpler in a sense that you need only one
> > > data type. W/o recursion you need to distinguish between container
> > > data type that links to each constituent.
> >
> > So you have this tagged union of three different types some of which
> > are self-referential (struct lvalue *). Is that what is simpler than
> > an array of a similarly tagged union, but with no `struct lvalue *`
> > recursive data pointers? How so?
>
> The following:
>
>   struct rvalue {
>     long long i;
>     const char *enum;
>   };
>
>   struct field_access {
>     enum { FIELD, ARRAY } type;
>     union {
>       struct {
>         char *name;
>       } field;
>       struct {
>         struct rvalue index;
>       } array;
>     };
>   };
>
>   struct preset {
>     struct field_access *atoms;
>     int atoms_cnt;
>     const char *var;
>     struct rvalue rv;
>   };
>
> Is logically more complex data structure, because it has two levels
> for expression computation: to compute single offset and to drive a
> loop for offset accumulation.

Perhaps it's subjective? I find an array of field_access structs
simpler. Maybe because we have a similar approach with resolving CO-RE
relocation spec strings (I think it's in bpf_core_spec_match()).

I do prefer simpler non-recursive data structures.

>
> > > Plus in a computation function you need to distinguish first step fro=
m
> > > all others.  Recursive organization simplifies both data types and
> > > computation function.
> >
> > Not sure I follow. You have two situations, and it doesn't matter
> > whether it's a first or not first element. It's either lookup by field
> > name or indexing using integer or enum. In the latter case we should
> > have an active "current type" of array kind we are working with (so
> > yes, we need error checking, but just like with a recursive approach).
> >
> > Maybe I'm slow, but I don't see how recursivity is making anything
> > simpler, sorry.

