Return-Path: <bpf+bounces-73972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E091DC4122A
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D37188CDFA
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA403376A5;
	Fri,  7 Nov 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKYRFBi5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F026336ECF
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537450; cv=none; b=HjlCv6g6FGrRHOTnDTiXpAoofaDp47DwUh58qEsjZVDaqjQ4rM36yKXhndHEXhLLfA1THxxCQx58WzbRPzVASUBD2LI3JcNid6M6W15QrElOjul6tMs5acx5w3qRzUManUeHkP8wm2JdKPT5FUT3ka8xxS+/hTngVrSKhBs7NGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537450; c=relaxed/simple;
	bh=gf0l6JphSC45++jh/l/NcwDRHSom2Kf9ZMm8/TbpCjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+Fv4agpZW70JyEJQWy/RCHxAJBthWXN4DRtvkBqmug8ba25GEph2/NulRBqS2K3kQ+5H2f/f9b/FKGtxq2zWrYkU5940oDbJEIJbRR3tOC1uoDR8b8DJogR+98id5XF0fKDPLuIX+IFTV3b6UwpMShiLwX0NacqU0nIv7J6wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKYRFBi5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so829960a91.2
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537448; x=1763142248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gytpHvgcd7XKnQeia/W2QSEvlqw4E93JDTWduCN6+0=;
        b=hKYRFBi5CYSrINwS2wbWidt2iOIsR7hj0l95nuslDcWD8sSrThMK5ST4r++AvbGWJQ
         QtPQBrX9Th8trR2vpiXWVaeYL1JMpNj6MBEoeAGZtKpAVm+HNZ0I3Ajlf694ZTW/j479
         IoWStvJxTNka0emFEXLkirNs+7Y9xCwbt+ZYx+8Z9dxTpUl5F55bjhVwaWYUQiOOBWVO
         6siTJ9Eh4A+vwHrI9OftPSjA0QNI4DC40jiBrDxQ0a5hImTxPaYjaJItRa9uM04ZXv40
         7SyrvbX/ZJKpEY8pfbxffQ1rDKgMiMOKo4h80GU3+Kdeax1jclRB20zQ1P1GWog6vsXW
         BRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537448; x=1763142248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gytpHvgcd7XKnQeia/W2QSEvlqw4E93JDTWduCN6+0=;
        b=LB5kcGejfwJXeCAZxQ4vEraGXBWlM0acVMONMHbiNpfXIC0Ji/xVSeP/vcJndCrx9o
         ZukF21DZvnoSXtkibuHZOjOoWNWyFvwvrGjcjdDaShggZngdYJb/fNhXN3nKnUFWecR1
         VhL1ApHKjJ8tzQi2Aq/VNYmTP1Ny7O8sZtQtoZavYjuV9FB5BwcVF4IYSeywURM58S07
         jo3MIaZRd2+1qSZ0LroxEWHASgwX6MIiYGQpZk1Zg16P4gJO72z8rF1UnSS2xlvmD4f+
         7vVGSQvaXshUppdKo959t76dvy0FFX+5It7OUuxQFVcQJVf6E0uBhl3t3S7c8xqpIECB
         sIoA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+r1EQEe22box9dsWva3tNT7luNNL/lVcHue/NYeEodqV9NFpFBDTggMcSCGvdlkvdBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SiwjntieWNytwknpzeV8J20dco6EPkGFFcrkXFnNfLJAg+jp
	BS0ZjOdx20boJ2BRKtW29XcaYpY763MfCgy86yTt3VvDGih/0OwgJ+AZnC7unaKk8AOheWKQv9E
	TTc96CFeq1DBBk314jh6n5OGibSD4d/4=
X-Gm-Gg: ASbGnctaX2AuNJd5v8HoWzvosKxiPEW3CA+7vBgnCFBLqvA99cEfyuTMYRhBZOx2twC
	Oyv/LBC7C+mrsQAzVZDtZTnIwMaHZijIP4tP+3WQKEh5b4sMoCldAWr42d4Gl9ys7CAZmNjKUJG
	j67yRP8cg01Z953s4dNCkwoRSdQY1/XrZkWzWnV3eUZUP7jX462pbGQ+LHYPkWRVb/Hp2y9Ys2M
	T9riplW8f7S5H0Wp3VqZD2748EGJuCwrQfJkFycj/z9Y6EEwwOtkdp6OnixmUmrfyxlMjuL16eQ
X-Google-Smtp-Source: AGHT+IFxP1rG8EXQd58nFA6ag900h3V3UtY/stl7aRRovAIClvQrijIP0ylrJdKTUURp5+6DJSYk5iDyqHnu3xcKpME=
X-Received: by 2002:a17:90b:55cf:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-3434c548d7emr3911414a91.23.1762537447658; Fri, 07 Nov 2025
 09:44:07 -0800 (PST)
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
 <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
 <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com> <CAErzpmtnLcVXvcWCY39YHN3VWmLKbM3NJtZhRqi8BQrLCqRemA@mail.gmail.com>
In-Reply-To: <CAErzpmtnLcVXvcWCY39YHN3VWmLKbM3NJtZhRqi8BQrLCqRemA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Nov 2025 09:43:53 -0800
X-Gm-Features: AWmQ_bnxdmL-MIkVALPlbickAdlfDYj6hXbeVyBqOIA9Cme_jOJ8UX_rlNxe4Qo
Message-ID: <CAEf4BzayHtTppa8GLFViRQRBW-dkYQ6JyVvG7HY1DBy8j_-OBg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:36=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Thu, Nov 6, 2025 at 2:23=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *c=
tx)
> > > > > > > +{
> > > > > > > +       struct btf_permute *p =3D ctx;
> > > > > > > +       __u32 new_type_id =3D *type_id;
> > > > > > > +
> > > > > > > +       /* skip references that point into the base BTF */
> > > > > > > +       if (new_type_id < p->btf->start_id)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > > > >
> > > > > > I'm actually confused, I thought p->ids would be the mapping fr=
om
> > > > > > original type ID (minus start_id, of course) to a new desired I=
D, but
> > > > > > it looks to be the other way? ids is a desired resulting *seque=
nce* of
> > > > > > types identified by their original ID. I find it quite confusin=
g. I
> > > > > > think about permutation as a mapping from original type ID to a=
 new
> > > > > > type ID, am I confused?
> > > > >
> > > > > Yes, it is a desired sequence, not mapping.
> > > > > I guess its a bit simpler to use for sorting use-case, as you can=
 just
> > > > > swap ids while sorting.
> > > >
> > > > The question is really what makes most sense as an interface. Becau=
se
> > > > for sorting cases it's just the matter of a two-line for() loop to
> > > > create ID mapping once types are sorted.
> > > >
> > > > I have slight preference for id_map approach because it is easy to
> > > > extend to the case of selectively dropping some types. We can just
> > > > define that such IDs should be mapped to zero. This will work as a
> > > > natural extension. With the desired end sequence of IDs, it's less
> > > > natural and will require more work to determine which IDs are missi=
ng
> > > > from the sequence.
> > > >
> > > > So unless there is some really good and strong reason, shall we go
> > > > with the ID mapping approach?
> > >
> > > If the interface is extended with types_cnt, as you suggest, deleting
> > > types is trivial with sequence interface as well. At-least the way it
> > > is implemented by this patch, you just copy elements from 'ids' one b=
y
> > > one.
> >
> > But it is way less explicit and obvious way to delete element. With ID
> > map it is obvious, that type will be mapped to zero. With list of IDs,
> > you effectively search for elements that are missing, which IMO is way
> > less optimal an interface.
> >
> > So I still favor the ID map approach.
>
> Hi Andrii,
>
> I've submitted v5 implementing the sequence-based approach, and I plan
> to introduce
> the ID map approach in v6. However, I have a few remaining questions that=
 need
> clarification:
>
> 1. ID Map Array Semantics:
>
>    -  When the ID map array specifies `[2] =3D 4`, does this indicate
> that the original type
>       at `start_id + 2` should be remapped to position `start_id + 4`?

I'd say that 4 should be "absolute type ID" for simplicity. Because
that's what users work with. I'd say the position ([2]) should also
map to type ID for non-split case. So for base BTF I'd require [0]=3D0,
i.e., id_map count should be btf__type_cnt() sized. (I can be
convinced that's wrong and inconvenient) For split BTF the situation
is of course more complicated, because requiring btf__type_cnt()-sized
array for just split BTF would be super wasteful. So for split BTF [2]
would be as you say 3rd type within split BTF, that is type
#(btf__start_id() + 2), yes.

> Should the following
>       mapping attempts be rejected:
>       a) If the target index `4` exceeds the total number of types (`nr_t=
ypes`)?

yes

>       b) If multiple source types map to the same target location
> (e.g., both `[1] =3D 3`
>           and `[2] =3D 3`)?

yes (at least for now, we can lift this if we ever have a good reason
by adding some option)

>
>    - If [3] =3D 0, does this indicate that the type at start_id + 3 shoul=
d
>      be dropped?

yes, but let's not worry about deletion right now and just reject
this. I'd like to keep this option for the future, but right now we
should reject such case.

>
>    - Does this also imply that the VOID type (ID 0) cannot be remapped
>      and must always remain unchanged?

yes, it must be always be zero, it's baked into BTF

>
>
> 2. ID Map Array Size:
>
>    - Must the ID map array size  <=3D  the number of BTF types? If the ar=
ray
>      is smaller, should any missing types be automatically dropped?

no, it's an error, id_map size should match the number of types. For
base it should be btf__type_cnt(), for split BTF it should be
`btf__type_cnt() - btf__type_cnt(btf__base_btf(split_btf))`. (That's
one of the reasons I think we should have [0] =3D 0 for base, to keep
this consistent).

