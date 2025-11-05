Return-Path: <bpf+bounces-73629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB223C35CDC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 14:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E6C5607E6
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E531BCAA;
	Wed,  5 Nov 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej3JUQjJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6131B825
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348770; cv=none; b=hy9RjZZ80vhgTs85acHLtJ0X5f69n/MOlE19WVgFxAmhxJJNYXfYprGsiQ9VF+AeilF3FUygcXo+1FpCOGinRQtq7naT1IbYfg7983i1UXuKvTfixUeCgnTWY13oNYAMafXLQ5M/DSTKlcBJpLv86BNVd12v5irhTiDiQcX+zTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348770; c=relaxed/simple;
	bh=n6EAd5xNkf4cy/btjHmo9INFAafy+JlwmtCVzH8kqfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaGiJn2apc5ak9/usTwgWSsJkl9I8AP048eN3GaGXRuX2K7WXQvuRC4BV+fH+fd5jiu06H4iRRSyvF2gyg+QLNom2jBJpyHyBIvmTFmPdoQGEbZ/9iBO3MbmH7kfXeyaL/y9Jdvp+0HaXJw9Lkk8QR/Uxf5A975dmwcKoFXvbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej3JUQjJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1306588766b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 05:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762348767; x=1762953567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhBPStdE5QO33mfXxr+yFo031Fup8h45fzxxvPOQDI0=;
        b=ej3JUQjJ71jWMxlca6UKLrWw1jRt9K/z+BLqViRtLpKlG1+uoNclMZGS2Y4uk5B925
         Ch+bP4uWSunMgGPCA16KmX55bAAapp5FOxq9Z3THc5U9wwCo2FfiS4+R6NtvDI2/h7dV
         w7eTHvSB9p9iEHFNh5rJQSVyaxzfJlT7uZ9RxKLOW8kpcCXQ9SFPXSzJa88xfvuWdHxs
         5iD9vK2cf6X+L8C17lDEU9N8okWik2AVO1EpcnPTTyZESJp1zJIDgvYhLC/A4bQIJryu
         X5eIggmc6aZzfMb2FbeEIwMRRvGZXYGKwVBLCCi20geDODsgZG44E1Uopo0vCjqPh6PL
         omVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762348767; x=1762953567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhBPStdE5QO33mfXxr+yFo031Fup8h45fzxxvPOQDI0=;
        b=lw93ZJJkJci6N998flVK3Oe53RFmLU5qFQi0OrGo4aAXo7G78KNwS6bBkNA+EpKvJp
         0hxiZNo0jdTVxU16wNn6usQEqds2UEIB450oQBgnVMr9lqms7Oz4rEGxipSvEvQ//R71
         JmKC9cjIlWb19VBO81YyBozdZgx4ABXuDrvmsOrQnZHnXHRHVbi6bgVF0TKlRbStug1y
         NzWLyacw9/LXOfpSb2yODdVL1+2Spn6s11f6hreEMGqegx96V1MtQNwR2MD4gbo9GwjQ
         iC2f1p5EyNjpIIhixmzAwTbkIy1fO35B0FbBGp1npgwQOv7quyGegFjBtdJYh/NptYJO
         KFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkItwx5dI9W7L6QLIHALsase4oTieusbXbBzX7wx/rLS28A7v6Ce1N5DFBfwKxI9RN/+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzX8KskTTT0r2TU0TqkbO7ajFN1d7+CyVTdmREtX/FEyIrOi7O
	rPYeHZKhzbWt/gH6z/H83kb7jv5EyIch0NRyIftn59F8T13J0AhAFM62jZXDXW9cK/on+dgGZOF
	4S8CJ19aSUwKkvJwk7i60AKFpi4NnCFjhG/uR3pgZag==
X-Gm-Gg: ASbGncu7HrtSFlEoCVM4E8YTCo2nhSctotlbZfGfWNfGxItz/7Iw3hLp2L39iR1zTBA
	b3MjEBuooKRLV1savWMvjtKhp+TR/DW++J0xaNDboIEwe36IM5c/nVx9fGgLIbfQz2LR0i5J5QL
	Ffj2RuEQT4fTS4Qrv+bwncSFxYveXtaH3sXUd8yDWQWtH5ZgmnOuy166B6BUMEQoD6RS3Dc6u2o
	Zn79GlT2UIO4EP6NP+TGRENeQWDGAOAqSbCvTvFkvOTJd/u3dbZsv7N7uI2BmWXxA/UjGQB
X-Google-Smtp-Source: AGHT+IHJk4zSfMOclxD/AbSCzbSM3XcIUEGaFT+Wx29eVoMBEXKGDiugd+6qUOUla9ujhq8cPil9OZqxGEfGqjtOIVc=
X-Received: by 2002:a17:906:d553:b0:b70:d149:c33c with SMTP id
 a640c23a62f3a-b726529e5fcmr280822366b.22.1762348767114; Wed, 05 Nov 2025
 05:19:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com> <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
In-Reply-To: <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 5 Nov 2025 21:19:14 +0800
X-Gm-Features: AWmQ_bmCM72GB5-qTf2_xcWFch54EPznU_1ZyApWlTOid2uFja7sq_zh5ltGs10
Message-ID: <CAErzpmsS4nMqyNUOEsYFBN4y45hi7bCxV6RicXyKxB6FRuQvsA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > > > > +{
> > > > > +       struct btf_permute *p =3D ctx;
> > > > > +       __u32 new_type_id =3D *type_id;
> > > > > +
> > > > > +       /* skip references that point into the base BTF */
> > > > > +       if (new_type_id < p->btf->start_id)
> > > > > +               return 0;
> > > > > +
> > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > >
> > > > I'm actually confused, I thought p->ids would be the mapping from
> > > > original type ID (minus start_id, of course) to a new desired ID, b=
ut
> > > > it looks to be the other way? ids is a desired resulting *sequence*=
 of
> > > > types identified by their original ID. I find it quite confusing. I
> > > > think about permutation as a mapping from original type ID to a new
> > > > type ID, am I confused?
> > >
> > > Yes, it is a desired sequence, not mapping.
> > > I guess its a bit simpler to use for sorting use-case, as you can jus=
t
> > > swap ids while sorting.
> >
> > The question is really what makes most sense as an interface. Because
> > for sorting cases it's just the matter of a two-line for() loop to
> > create ID mapping once types are sorted.
> >
> > I have slight preference for id_map approach because it is easy to
> > extend to the case of selectively dropping some types. We can just
> > define that such IDs should be mapped to zero. This will work as a
> > natural extension. With the desired end sequence of IDs, it's less
> > natural and will require more work to determine which IDs are missing
> > from the sequence.
> >
> > So unless there is some really good and strong reason, shall we go
> > with the ID mapping approach?
>
> If the interface is extended with types_cnt, as you suggest, deleting
> types is trivial with sequence interface as well. At-least the way it
> is implemented by this patch, you just copy elements from 'ids' one by
> one.

Thank you. I also favor the sequence interface approach.
if I understand correctly, using the ID mapping method would require
creating an additional ID array to cache the ordering for each type,
which appears more complex. Furthermore, generating an ID map might
not be straightforward for end users in the sorting scenario, IMO.

