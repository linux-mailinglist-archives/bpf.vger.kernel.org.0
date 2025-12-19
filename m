Return-Path: <bpf+bounces-77073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32184CCE0E3
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E91C13031068
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C721F0995;
	Fri, 19 Dec 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoTiPeDF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617A1EBFF7
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103903; cv=none; b=h6PbJA76sutHSicG9rFuojNEkx6qeQtmQZLA8xTrb9Aq9EKaLBgVp5eczBvXJMy1C7O3rJMwk+KBzdBm8ccTukttckVYOIAulcVo4zpC/GC/e2NONN7L1Dhx60dtXqy5t4NrGDf1x4EiTpKr1R2HIIW90vWp4bCIVOjQzYb+G8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103903; c=relaxed/simple;
	bh=HPdAm7fMRrMZKrr4OQD5M+LI78+T7U2fioARtnCSm1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oa0wFe0NtYKRvnOiDBrQ++wSz+u0pK2U9i1wSgh176c1ZUOFf1BVshuBe3v59NMD4qToqKBlLZsmVxDQxpeE94EH1y6em3ucl3Anhyez051fE6s5NwjsBAoxu7/EkdbmpiWtsgcVNvgpiMtw6g2Ug9rqGYmUFXDMokfEoFZCS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoTiPeDF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so738077a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103901; x=1766708701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/vajcf/oqHo4VAnhI/xQHTdaHk3f4wxr7/OVCvKJH4=;
        b=XoTiPeDFZY9FVEg6QBx9ruSywF8p2yMVWazrtXvy9QK3MXNpGWqnNiHz0L+qZb3mbq
         QZk+dzoO7rHFN3fJqas3Btt8T1OawGDfxgvocFQwV/6XiljbUuPkxaZaTaX5VroI+TBc
         bLBPwofVjdoSVqxsi0So1Bd+1oWDnxT1PCF8JvfA5sXBKvrmExP6JUwMbQt3ThEcanhr
         3ApvYmbm/1TscazMlAWqdKuzGbUrF1/iSci1NGjgVlu6cexxGLyOgegjqoY9tHT+UNtO
         JjiEYgae7Qk89/6fg9ELYjDClh9hYnzQWgY6KBgopxNzNMK4jiEEEcYbbETMkHS9uGdb
         Xczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103901; x=1766708701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/vajcf/oqHo4VAnhI/xQHTdaHk3f4wxr7/OVCvKJH4=;
        b=WnpEjsZQnjAkfUTqynNVfXdCIIvqSeLbo5Jd4JNFSme+hm4H2WcFGof6NSrPv27bAT
         GXED8ArqeC13l4i0upPUcaCm+ofXPsOgKzFx82nW5kvPXctozJRmkteKrJje41SVEViY
         0n1kkveSwInx4GzO0T/lQqsyxXlSHYG38kIWal4hbMuMTMG8VSkDEYE7L1qr0xg3z+zC
         eebvH5rqVO3vwTC9TaBPk7txwRmQQ53iYEiWZS0MWt68WrhSzhejDAJWYVP7xWOBppJK
         xQ2n+b/hlUZ+RFINWWwO4W6Z/yZJtPYXW/eWoxurIM/st61a4GyAz9dJlo2wHPpANJKq
         6Yng==
X-Forwarded-Encrypted: i=1; AJvYcCU1tT0PDbzd+xNdCJrKozCFHD7E+K/QU5jScE+IZVSIp7aZ+U6u5bYxo4nAd9OrsqO4YME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQc6lBCOGMevUCh9wKsDvcRdQcjBCbmBraiCgvnYWrsbJmEH3Q
	cP53xSJFlx5qb+N+t2z75YlJaRRRIP9MeVP6c4TfkRqLbQW8vaPydYoo
X-Gm-Gg: AY/fxX6Q6amsAKyFQXwnsm+O85AoB6Mw3dNzr/L0h0cMQHuhMAyK9tgtzWD8Oap4H0h
	mHmhkteHohZslCmMIDI0r4WfKm5t2JzHnDVsSLAUhuwwn7RKTyejqJhu4cbtBk5XV1xRVvymnUb
	WPdhXNOVYpBoF5WobhXJ/tJLQi8GQZan8jwep8rsKpdwJXkwvw627KzXIHRZtw7YObqTbJ8i9Zi
	HKIRyq2f1Q0BxxF0c6iKnGLeP7G7q5cmcYsxIHi+vf13p4lwgBuZ5460aOnvIRpLmnIFih3CIJL
	74cnMx5ugb7CRXeJnRKkgm40u52F8zXr8h7O3we9pmd4L/tayedYwerkTplOxm4Vh3FCctLCBCb
	FHwsojgHtCWS6p5efZyTDaiRWL7o8iDNr+RKNyE9WgFfx918eZuC3q31IfDVy6dEurg+2WC8cMK
	bPbQF4iDC70KpGdUOi5H2SlSFEXbdK097+OQqL
X-Google-Smtp-Source: AGHT+IH13ngxpc428+JJsDJWJ/wpSJd4O5CSNbA4QSStAz17JAzgU/Y2JWo7Dp+gfLoRFFRvyZDKnw==
X-Received: by 2002:a05:7022:3806:b0:119:e55a:9be4 with SMTP id a92af1059eb24-12172136750mr1123308c88.0.1766103900587;
        Thu, 18 Dec 2025 16:25:00 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfa2csm2319981c88.3.2025.12.18.16.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:25:00 -0800 (PST)
Message-ID: <e2690b163b823d82565ce2dc6e58fa23c0bf7935.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev,
 linux-kernel@vger.kernel.org, 	bpf@vger.kernel.org, pengdonglin
 <pengdonglin@xiaomi.com>, Alan Maguire	 <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 16:24:58 -0800
In-Reply-To: <CAEf4Bzamgpk7Dj2uMrCmVEijvyHKqUguWJU7h+12pSr3S7F1hQ@mail.gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-5-dolinux.peng@gmail.com>
	 <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
	 <d161fb1f8b7a3b994fe3ed4a00e01fc1f1af3513.camel@gmail.com>
	 <CAEf4Bzamgpk7Dj2uMrCmVEijvyHKqUguWJU7h+12pSr3S7F1hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 16:19 -0800, Andrii Nakryiko wrote:
> On Thu, Dec 18, 2025 at 4:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2025-12-18 at 15:29 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int star=
t_id,
> > > >                                    const char *type_name, __u32 kin=
d)
> > >=20
> > > kind is defined as u32 but you expect caller to pass -1 to ignore the
> > > kind. Use int here.
> > >=20
> > > >  {
> > > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > +       const struct btf_type *t;
> > > > +       const char *tname;
> > > > +       __s32 idx;
> > > > +
> > > > +       if (start_id < btf->start_id) {
> > > > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_=
id,
> > > > +                                           type_name, kind);
> > > > +               if (idx >=3D 0)
> > > > +                       return idx;
> > > > +               start_id =3D btf->start_id;
> > > > +       }
> > > >=20
> > > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void")=
)
> > > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > > >                 return 0;
> > > >=20
> > > > -       for (i =3D start_id; i < nr_types; i++) {
> > > > -               const struct btf_type *t =3D btf__type_by_id(btf, i=
);
> > > > -               const char *name;
> > > > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > > +
> > > > +               /* skip anonymous types */
> > > > +               start_id =3D max(start_id, btf->sorted_start_id);
> > >=20
> > > can sorted_start_id ever be smaller than start_id?
> >=20
> > sorted_start_id can be zero, at two callsites for this function
> > start_id is passed as btf->start_id and 1.
>=20
> Can it with the check above?
>=20
>   if (btf->sorted_start_id > 0 && type_name[0]) {
>=20
>=20
> This branch is a known sorted case. That's why all these start_id
> manipulations look weird and sloppy.

Oops, it cannot.
But still it feels strange to pass a 'start_id' parameter to a
function and rely at exact values passed at callsites. Replace the
parameter with boolean 'own'?

> >=20
> > >=20
> > > > +               idx =3D btf_find_by_name_bsearch(btf, type_name, st=
art_id, end_id);
> > >=20
> > > is there ever a time when btf_find_by_name_bsearch() will work with
> > > different start_id and end_id? why is this not done inside the
> > > btf_find_by_name_bsearch()?
> > >=20
> >=20
> > [...]

