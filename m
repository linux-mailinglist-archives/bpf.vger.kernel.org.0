Return-Path: <bpf+bounces-70332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7FBB7E91
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FA63A8CE9
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ECC280A35;
	Fri,  3 Oct 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0jnKDuw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD427456
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517205; cv=none; b=Ga0NPtq4eHf53Lyc5AGk7mazJLd7A1FtwRPF4mFPyqrHBHRNl9jPT9BGc4Jtio4plNtGglvjDPddXRg6HSrDVSunrku0ABk+eepzasBPBpxx+FtyFCpA8j4qDJnv0VgBqq/UtgOB4RgWLrFOl5Zzv9AU4yPh5gPVHIOE1cRr+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517205; c=relaxed/simple;
	bh=iW9OeP+inO1uetU88+0/BueMH75puFbYOMH/1gmd15Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2d0bovNxosxetiRNB6gbboxnBzUDKI8sfhZEBm6QBBkBI5vVE2MsKcn4d8Gna274lBnxCCaWcG7b9xgX2B23/pAB7z2rRtNr2T0wHUlDPACY4C+a+pw6I0eyVzNJGh/d4aO4I5RRUYQTN31JXJv8FpHZHaefjtn27hFd+0UAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0jnKDuw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33255011eafso2597442a91.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517203; x=1760122003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7boW4MoaIgNUcbNnkigrxSxvHxd22J3g8D5AL65mu4=;
        b=K0jnKDuwf+4Al9WmQv5YOYazWjzQ9RjySepdZHqW+AvlGIkOHUsLYZQfxT8IAE1p4n
         IRIJ4xcZ4iwX6YNgsmcP3wZKZg3BmJe0qdl9NHshqU9M13zDn/HjFDnJ1+nzJmYSnKSa
         WYIMq5TuVJ+THjgjs/SWsvGc3Z7iSz2eOxQ7z9oCfDOTDanpFuBKsv+wjFofZDtx+v1/
         6vxeb/iACzCbplwlTbcBVVx4noLj92o567XrpjKqewnp837yXxhBvOgYicjj/IKqbEyE
         tq7UzEl6XxKOjEh0YUh93ZL20eiI1t+hl9DFggHD5moGJALN3lOIzdF9jN2jx5aQClf5
         oPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517203; x=1760122003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7boW4MoaIgNUcbNnkigrxSxvHxd22J3g8D5AL65mu4=;
        b=rTR1a2RH85wk/h22rKRhY85Os02nEsEhfTokM1s/T+2YPQ3LKqCdrttdAESYv+k5+5
         pGVONPuU1Jtwoj5G+9dDrn9beXuv6FJkhAysGwW5WYLNZ0cY5v47+5D92f8oi11+lOd7
         Yaa6LJIrDrhQZqvX4Gubg5JnA7iNHB52xjsePZPYZHPx/TfQo41JAPyl3SdGEAcEGjv9
         gKzM0TsHCKnUc8xJ6GONMHvj5Yhl8PEubGbR9W0B/2OAXyRQyA+niklVuIM7hqRxZFV8
         uZdkPaszbLzKjX2siWKI84bt48SVI4o6wapIhoK2Q3acEs2w0n5biGR4yVyQK1Vj7YPj
         qZ5g==
X-Gm-Message-State: AOJu0YyiuRg8HBJv4Z7GmAhGmHmH8h+A4HQaTsux+ZlNCgWALRx2I6PG
	XM9CL4xUUlcIt+g5hrZZwv94vrzk0uqpC76cp+9BEUFf2c3gzlmg/zYDWpyZQKlP7uMFFbDJLcW
	08ICNpmp6lnRp6oaySpJs7ZP2Ezg2eBo=
X-Gm-Gg: ASbGncuibWfKx1FE/b5fjtcQmfe146Sjtu7rrmutJbB/UzQcID61IA7IAXaUbG501je
	94cVRsCLZsYZgfLefjXNbBZbz/mPA+NMMQ3EEEsXhslrrjmSDOQG0oKtKHQmTuo9neH5a5SG2/W
	6bvM6b+xp5CYrK2fCsjtjoqdOctPBUuHuSoU43NyzNqCzm5lNnjx/CVPg4s8/oWbEFPW2Ge7lKd
	4fRCyjjfPkdSQ5/F/uPcoo5MbczGMSWKjacjpBpu7coQ2/kBEBT4fntBQ==
X-Google-Smtp-Source: AGHT+IGOpuigI01fSLMQbKCCAvEEinYQJsi+urX8ovwrmd48jIdlslBFWhxsQ+cc/bzleEonyAYIGWFxM1rTLNQl2YM=
X-Received: by 2002:a17:90b:28d0:b0:330:797a:f504 with SMTP id
 98e67ed59e1d1-339c2706797mr4976928a91.3.1759517202965; Fri, 03 Oct 2025
 11:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-5-mykyta.yatsenko5@gmail.com> <CAEf4BzZLvt1kqFsVjG2oC6yf980Y_p8zW0QXu18EWWi8-S4KjA@mail.gmail.com>
 <aea8063e-a7f6-4d25-a88e-01e4a55ee130@gmail.com>
In-Reply-To: <aea8063e-a7f6-4d25-a88e-01e4a55ee130@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:46:28 -0700
X-Gm-Features: AS18NWAMVmIYr1rOh4l38v3J2WeEDGrk_RAP74qBTJZStI0XKR5KhWPnurlEQUo
Message-ID: <CAEf4BzYZdhL6aKVCHfeOPzwSkcJr7fENAAo9oEt27ryVy3QcfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/10] lib/freader: support reading more than 2 folios
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:29=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 10/3/25 19:16, Andrii Nakryiko wrote:
> > On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> freader_fetch currently reads from at most two folios. When a read spa=
ns
> >> into a third folio, the overflow bytes are copied adjacent to the seco=
nd
> >> folio=E2=80=99s data instead of being handled as a separate folio.
> >> This patch modifies fetch algorithm to support reading from many folio=
s.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   lib/freader.c | 27 ++++++++++++++++-----------
> >>   1 file changed, 16 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/lib/freader.c b/lib/freader.c
> >> index 32a17d137b32..f73b594a137d 100644
> >> --- a/lib/freader.c
> >> +++ b/lib/freader.c
> >> @@ -105,17 +105,22 @@ const void *freader_fetch(struct freader *r, lof=
f_t file_off, size_t sz)
> >>          folio_sz =3D folio_size(r->folio);
> >>          if (file_off + sz > r->folio_off + folio_sz) {
> >>                  int part_sz =3D r->folio_off + folio_sz - file_off;
> > AI suggests this should be size_t or u64, it's not strictly necessary,
> > probably better to have all the offsets and sizes of the same bitness
> >
> >> -
> >> -               /* copy the part that resides in the current folio */
> >> -               memcpy(r->buf, r->addr + (file_off - r->folio_off), pa=
rt_sz);
> >> -
> >> -               /* fetch next folio */
> >> -               r->err =3D freader_get_folio(r, r->folio_off + folio_s=
z);
> >> -               if (r->err)
> >> -                       return NULL;
> >> -
> >> -               /* copy the rest of requested data */
> >> -               memcpy(r->buf + part_sz, r->addr, sz - part_sz);
> >> +               size_t dst_off =3D 0, src_off =3D file_off - r->folio_=
off;
> >> +
> >> +               do {
> >> +                       memcpy(r->buf + dst_off, r->addr + src_off, pa=
rt_sz);
> >> +                       sz -=3D part_sz;
> >> +                       if (sz =3D=3D 0)
> >> +                               break;
> >> +                       /* fetch next folio */
> >> +                       r->err =3D freader_get_folio(r, r->folio_off +=
 folio_sz);
> >> +                       if (r->err)
> >> +                               return NULL;
> >> +                       folio_sz =3D folio_size(r->folio);
> >> +                       src_off =3D 0; /* read from the beginning, sta=
rting second folio */
> >> +                       dst_off +=3D part_sz;
> >> +                       part_sz =3D min_t(u64, sz, folio_sz);
> >> +               } while (sz);
> > it's a bit sloppy that we have sz check twice, what if we rewrite it a =
bit
> >
> > u64 part_sz =3D r->folio_off + folio_size(r->folio) - file_off, off;
> >
> > /* copy the part that resides in the first folio */
> > memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
> > off =3D part_sz;
> >
> > while (off < sz) {
> >      /* fetch next folio */
> >      r->err =3D freader_get_folio(r, file_off + off);
> >      if (r->err)
> >          return NULL;
> >
> >      part_sz =3D min(u64, file_off + sz - r->folio_off, folio_ssize(r->=
folio));
> >      memcpy(r->buf + off, r->addr, part_sz);
> >
> >      off +=3D part_sz;
> > }
> That'll do, the choice is to check size twice or memcpy twice.
> Let's do as you suggest, also helps dropping src_off variable.


First memcpy is "a special case" in this regard, as it does not copy
from the start of folio, so I think it makes sense to have it as
hard-coded first step before the loop

> >
> >>                  return r->buf;
> >>          }
> >> --
> >> 2.51.0
> >>
>

