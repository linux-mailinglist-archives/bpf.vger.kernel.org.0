Return-Path: <bpf+bounces-38584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A3966867
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422101C239A9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C881BB6A3;
	Fri, 30 Aug 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDy+/Y+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC814A4EA
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040295; cv=none; b=FoOhCjhdqtDuba6dOYRx+Wksy2BLKn6gRSYQ6zDuOD0BIr3tDdPbhx9mybZhQoFspZZeSw0Lgfn1b3jnVIerUtCzfrSp4O3Y6d9+E+M22IhQzTd118OJLmZV1KVU4vylMAr/J6nrisVf7RA0bgfk1KJr2lX0W8Hq43SD7UTowko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040295; c=relaxed/simple;
	bh=OFj2h3xPq9EKnWmzB64sWF8jI4mHN6rePSTm08Q6ajY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBB1sLTwnxx2pM7ijUA+ty3BCjPjAM14jVGTr1PdqCAlCLKfxdYysmmctgMemlv7PyJ66TyTs3XqmQ6UYZirc9LaK7/RfnSaBwDXr8Iq4vsfkWXhq6pK/XLV4B6ectG0RLISWjpYRK1LJYhGPLlNAcJ/30+2HZLzfORVuwJC3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDy+/Y+D; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d41b082ab8so1604332a91.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040293; x=1725645093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usKBbmsfUWuRqfzcd+tA6ftXTbdtGXcjlSRuc1oncRA=;
        b=XDy+/Y+DQYXPYnPuFCsPbcAJtCUt1C5UVvzQ57bmHn3dqMNAr74WNH3zwE9c43BjF8
         50BrViWuuO04eNKs3MCDDkPAKGstvg8Cmr2l5WrdTc8dE81+dVPg4SzP1XPsLlzviHnF
         s8r57cQl+UXLNtyDCagj+r3rf8FgjzlCBvwCRjo8ppwfZmhMoz9TfJ12J1wh8tluOkQi
         bqjmo4TWgeUXm0gJQfHg1FSIvFQHL/Dwc0I+U8eozrfLOyh+ksbZPR7gV/24nJTOusLs
         HMfZ70cSn2kP2fcFSQzhqOvT0kHF0IEDaYjH4fn/FQ43pUYVty/cjckd2JjmZzFpMd+K
         dytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040293; x=1725645093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usKBbmsfUWuRqfzcd+tA6ftXTbdtGXcjlSRuc1oncRA=;
        b=GpYeFlmCGvkEcylkRiR/k0tf7fkO+pBmCEZxBZU5B9Zq6lvXaAsnCmjOgRFnDNbveU
         7s4fHJbg3ClXvPx7pG1f/GVVoZU95h/NaEKg1mhbhorTSLXSdwHpSK4rwFfqWVsniqWi
         f2qSUtAvshCjlfDU0PpSfWyQk2zSrYnFeq0sCQcM+Y/gtoYU1nZF19VlJxPILw84wK1P
         CiRwwv67QchPJEaScfAlTwwjICtw5wqP5Hkf0oYMCAmct5FdF7XpXpocjOB2TKUUuOEk
         chwAwW3+AFIBFt6JDNfvEt/FKuMpSmfjmY5wdhoGgvPTG58NYUanPO80olYnUodv0Fio
         2qjQ==
X-Gm-Message-State: AOJu0YznULozEMToJSevJL4SLHH0Sb6UVI0rQutFN9psRbuvKHbtBj4L
	w5n9nmzL1WDvFL9yAQxOw8ee431ZjvA3ZP/WjEr+v7qTO1RYkDBN+eusirRaArUSe1NhiV4IjMr
	MJSiRpq8Y1Uh/f2sI6hprDNyIRWk=
X-Google-Smtp-Source: AGHT+IEycvyO2Tm892ZK6nqj0Usadz7oJpPaSQOHyIrZFqmH2nOuhU811798q3ooV8RWcapUKPmLFwm7mI8LLr6aw8U=
X-Received: by 2002:a17:90a:b898:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2d8904c6ed8mr172297a91.7.1725040293569; Fri, 30 Aug 2024
 10:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
 <20240830095150.278881-1-tony.ambardar@gmail.com> <CAEf4BzYCgP8Y63Y5wjA=7mRHCMMYa-XBXqhyVTzwk94AhqLKCQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYCgP8Y63Y5wjA=7mRHCMMYa-XBXqhyVTzwk94AhqLKCQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 10:51:20 -0700
Message-ID: <CAEf4BzYCS2qzrD5bsKgcJcP=bkWQYgYrCaVcWAgTW04yQCGv2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit input endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:00=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 30, 2024 at 2:52=E2=80=AFAM Tony Ambardar <tony.ambardar@gmai=
l.com> wrote:
> >
> > The pahole master branch recently added support for "distilled BTF" bas=
ed
> > on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong =
byte
>
> there is no libbpf v1.5 release, are we talking about using unreleased
> master branch?
>
> > order (e.g. on s390x BPF CI), which then lead to kernel Oops when loade=
d.
> >
> > Fix by updating libbpf's btf__distill_base() and btf_new_empty() to ret=
ain
> > the byte order of any source BTF objects when creating new ones.
> >
> > Reported-by: Song Liu <song@kernel.org>
> > Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5ea=
5f8.camel@gmail.com/
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >

Also added

Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
Fixes: 58e185a0dc35 ("libbpf: Add btf__distill_base() creating split
BTF with distilled base BTF")

> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 064cfe126c09..7726b7c6d40a 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -996,6 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
> >                 btf->base_btf =3D base_btf;
> >                 btf->start_id =3D btf__type_cnt(base_btf);
> >                 btf->start_str_off =3D base_btf->hdr->str_len;
> > +               btf->swapped_endian =3D base_btf->swapped_endian;
> >         }
> >
> >         /* +1 for empty string at offset 0 */
> > @@ -5554,6 +5555,10 @@ int btf__distill_base(const struct btf *src_btf,=
 struct btf **new_base_btf,
> >         new_base =3D btf__new_empty();
> >         if (!new_base)
> >                 return libbpf_err(-ENOMEM);
> > +       err =3D btf__set_endianness(new_base, btf__endianness(src_btf))=
;
> > +       if (err < 0)
> > +               goto done;
>
> This error check is really unnecessary and paranoid, because the only
> way btf__set_endianness() can fail is if the provided endianness enum
> is corrupted (some invalid int cast to enum). But in this case we are
> getting it from libbpf itself, which will always be correct. So I
> think I'll drop the error check while applying.
>
> > +
> >         dist.id_map =3D calloc(n, sizeof(*dist.id_map));
> >         if (!dist.id_map) {
> >                 err =3D -ENOMEM;
> > --
> > 2.34.1
> >

