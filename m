Return-Path: <bpf+bounces-73687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45544C37514
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52E7C4E4A60
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853F280339;
	Wed,  5 Nov 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1HKACS2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8842836AF
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367556; cv=none; b=rCRlI1AMHrVgZxxNTdqLO5T1xs3yueTDuL+h51G1cZOvH0KZF/qmMBHebAUmtlR1ZUCkXhNV+OOpcf0U7GRkA/BZg2I4lCcw0SdhxkxnSKt3pb1Ny2seovJSPdbsq+yB7Zdj561l0+pTP27ZtEsOQWkJezvo1Umom+oJ12+Ynsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367556; c=relaxed/simple;
	bh=/S6Ci3pUH2wLTjfufkCBgUgaUVowTaFjTMCx7d0Jx2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYnV6WCOYbNH5jozXvxsUIDq3jluqXY1/MKBMFFZAgDbi8Qx6flLiFy+p2WPqaKTb72yyOy6SlHByoM2Utr/DyFSVKOJMTTMe1rbbO1gSYwnEat6it+O86pv/zrFLnysvVNcX88ClmLLrflVje7rbuG/lwRoVUtV+sqUv9IBNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1HKACS2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-294fc62d7f4so1493455ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762367554; x=1762972354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48QNHOxuFB7f1ta2HsTdFAzgUHS5qr08hO3EC+FRbJY=;
        b=K1HKACS2Vv1fEyA9xT0ynLMDb/PSTaERBfErfqVCUBALpy+/+ssOz8aNQD/pcrB90w
         75JEJ8fIwBwmT6+N95wAd3S+fPDOr4GvLsyElaX+7upuhIEW+DaUpSALYIyKB48+YnMn
         JuPeU1f9TlT57oNboCfd7ndl4LCCy3+xetkGeaTLNdYuUyRs5qB2UB7HeL6BR66AuOnA
         HxeraVJca3jFZcRdfLMF+aooCVBzNtJ6Oldqu2JO6UAkqUDk0c8mX2bSVTi9goqeSBKG
         /u49srHvsHEkwQedDXvoVOF8YufBxaicHtDXkmXFxuxFIGuy4KBBngZvR844TbOLRvp4
         4bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367554; x=1762972354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48QNHOxuFB7f1ta2HsTdFAzgUHS5qr08hO3EC+FRbJY=;
        b=j7mAdp1OS9B2U747nqWQcQxFZBdJYBmhiyczf2YSy/kw00U9mHfFsMAZLeQzSU3sz7
         pO9eAC2CxrSwLi87rDZxJ73Zmen9yct5HUYdlpxcZk+GKUIHIRMDF4AGf6eHaFCnBw0s
         WL8I7gYQvAwvmeeCuVibToS16sEW+qkVMNjxgvDNFXA962NCImAdzbUSmD8G6bqq9M8c
         KabduVurdkae9YfUwvq40Ztir1c4Qzg1Y3joprQ30xEryucc71Kdnr79q7Cl5zPhhDeh
         KdbX3cbIEuo+1MmkFTzbCpVSvKS0vTRwjTDt5ZnGQAepnrjVj7ONSfri4etf6rs7g5k/
         D2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQlw3GFBoQs7Vu5edPCJmBO0znYuS+tZ657l/NWQw5c3V3MEXY3m0g0hcpG4qRHsstWbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6hA0GHhWaKcDdff+xfHPbTvWJ9APK6Dctd9j0PC+tblDNGbm
	l0VE0Yo4U0GXgqHd0dRj5R3JFb81OHhXuS/dsP/q77njQaZL3Hanag1aEt7mXFu5T+Zjz1NoZLx
	ipRsPOcqIpZuWwm0woVm/BKBkLTkkhGI=
X-Gm-Gg: ASbGncthyVPo/SyOX3z2tVe248WIphlGCUpcFoNqzjtbC7FZ2qIJ0EdgFpBLB2wnc8T
	n3DxGB0IbP9C4bqGFamx8rV+tMnBvEHcrHjBseeT77VppbDxGpgj5dHVPqcQIyIltyUWo9GawZp
	LPuGyZmMTGdyfapciZaSvkVLE8+uNpY6lhZAEB5Hmc0HABOeVok0FvGmI0peDMqXt4AG4xE6Ey9
	LufJV4GyVIgyJFKBchCy2ttObbAserqgWGuWy0yQciRKAATithr+bsuhrPv
X-Google-Smtp-Source: AGHT+IFjhxfNf2rNVnwHdXpaAeokTRVopVmd0rnu0zeRgxzbkhseGNHC1oIQNKpyObJDKx1NzdQ6YzZqXosXQeNA+mc=
X-Received: by 2002:a17:903:2347:b0:276:76e1:2e84 with SMTP id
 d9443c01a7336-2962adb29b7mr59358165ad.3.1762367554106; Wed, 05 Nov 2025
 10:32:34 -0800 (PST)
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
 <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com> <CAErzpmsS4nMqyNUOEsYFBN4y45hi7bCxV6RicXyKxB6FRuQvsA@mail.gmail.com>
In-Reply-To: <CAErzpmsS4nMqyNUOEsYFBN4y45hi7bCxV6RicXyKxB6FRuQvsA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 10:32:20 -0800
X-Gm-Features: AWmQ_bmUHPWaHrWuMRzKDVofEGzL8KvpST_ohDkVJBQcnbNK2pXxgdEjix79R0I
Message-ID: <CAEf4Bzb5BPT5jViiyEv3nbcuXE-oZmuCg63Y2hjUbwv1qq_6eQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:19=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Nov 5, 2025 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
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
> Thank you. I also favor the sequence interface approach.
> if I understand correctly, using the ID mapping method would require
> creating an additional ID array to cache the ordering for each type,
> which appears more complex. Furthermore, generating an ID map might
> not be straightforward for end users in the sorting scenario, IMO.

Additional array on user side or inside libbpf's implementation? But
even if on the user side, a few temporary extra kilobytes to sort BTF
doesn't seem like a big limitation (definitely not for pahole, for
example).

