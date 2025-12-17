Return-Path: <bpf+bounces-76801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489CCC5C6A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484363034EFB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA7260580;
	Wed, 17 Dec 2025 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl+VDsaB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3A3A1E67
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938791; cv=none; b=Gn0iMZQ5OW/huSxa/nkJyny8tkiVIi+05mzZ/GarpE7Gq478VVa09GSN+pOmROrdSdS74XytN/amnThdCtztigd1Xf0gS8G/JT8kjR3Vmz0ph0GQWe11wcXTPhO2iQZ8DKZ6qahzMBJd59WWk2UFWzV42gQ/snOiGzJI2RJlBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938791; c=relaxed/simple;
	bh=7rY4qNIg45pVJ92542nf3RA0X3nkXzQ5t3Hm2+6nYM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghtf8rRGxFCehx72SLauucY4EPj/L+uhGFCOpckGVAANdzNniZf8+IkHvGuw4UCuwBbT993lzFtT/v3pGg5vvRS4U1EplkVxnrY2dIXV/sXsJUpCOTWFYJIQ9Zt/RvgYmETTAJQZg01fX0M+aDvRbKugc2WAsaHnr13LHRxe0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl+VDsaB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so7096972a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765938787; x=1766543587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhk2AtmswYDlkYk05s9fG8bKb2x5w5mWzzqHGlLDS1I=;
        b=Yl+VDsaB+xI9MzSgac/1GgvrsKWwmbzZywEr0o661GD0UcZDSh+jKdFUd18LZHxEQC
         IeH1e5jHgl1GlSaf7BVel4gpcFsl6t/O1OWsDdWEKtVXm6HJKzf5NqsSR7WjbCvIdW9C
         pdNoYpKfzeHQDh3aoPVemceFcZ9yuZ6qZo7y4eP5pU1xC3naFiiPf6RJlYbXo8caU9Gq
         DHsrICDi0w/j11YgrgTPHS0ERzIdoz4PxthUiTfUn+xolKMdwrIf+AAmKvKAApt2VgBa
         SpGY7iF8P3u8MbsGjD4pisB7K7i1MqlelSyeseC4qfdcAzPxhxxIV6k+80A/SwHBYcKU
         jJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765938787; x=1766543587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yhk2AtmswYDlkYk05s9fG8bKb2x5w5mWzzqHGlLDS1I=;
        b=nDjdAmwi6cQB9ld7UkG2v1aTh2+gqROmjtf67WXY3BCYCdsqaHzWMDEvDOYfTu7t2W
         T4vRpsQsXrqwo+quyQ++TuErYN/AJXUz0YxDokwSCvoDVzjQUjiyUQC64FE7cL9C5uYo
         5km3tLPp8X/eUjfYJrtYNQ3bnrR7lQuYGeYaK6wFue9U6b0rIUcG/6dUzmWa3vsmyhue
         qgqw0rrXu9G+B0kDQPb7ph+5NiQ+U9jNWehE6+EI6zGagiRFFJC1uJmehsXjO3NzQnZJ
         lfRrqpeqt0//9KVTt/u+EgngfhxlNRNr91+U3AOREYgOnObXJAQHlGb5pTY/1gdH4tCA
         bWsg==
X-Forwarded-Encrypted: i=1; AJvYcCXKsgbiWhFLUh2YvT7Rmzd+FhBK+WJfa2Nn1qoxDs0ovydrdox4Lehxe3juLNuPs526xZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtuCum2eDkop4zYT+r9VO2QzMt9hVYQehjoHr22nLpfDdzhsF
	LWY6hZJPlrTENAJzbx7hIIV4iOFaYFoCaWep+WJwx6wsjYnpBcP1LTx2YlGqQ/E6G+H80k8MQdY
	hP/I0NEBtMdk4Zo14RW8uHgnFJt2T7f8=
X-Gm-Gg: AY/fxX4e8aWZKXtepug07JtHXnIvG7OkQRDdv7Zl9/YRjweA5rQtnv/z5fLwxkrMyGn
	Dtj4Sli5MeiMaxf1+DDMl4gQH1OCJ8weJFQr8AK5Cy/L6lwiw4mcLw0c6D6dUTjL2nCpzAhVlH6
	P6+Ww0EQoROWUk8idMuJ5bwcGIg4x6b/JS9CVonTKBXlzX5HzqER90L/M7SgtGGfD0SUyWkjaIW
	IfPEYSFKoUKHMFhKxl8AkS9vS61dGk3a4nJ5MK7HLt/HR6UAwnk7LqC+SnskUxjotf+6lwM2HBU
	zuM+ufA=
X-Google-Smtp-Source: AGHT+IFmk5wn2REF94XVVOYLOb+9dh7MCTc+IqSTrNJ2trnAZpghQbkm7zWvF1oZS8gltazwpguEhOnEKpV2ftc9IAg=
X-Received: by 2002:a17:907:d23:b0:b76:7e90:713f with SMTP id
 a640c23a62f3a-b7d235c83f4mr2008133666b.10.1765938786906; Tue, 16 Dec 2025
 18:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-5-dolinux.peng@gmail.com> <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
In-Reply-To: <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 10:32:55 +0800
X-Gm-Features: AQt7F2odJqb8H1VcmYU_VMCdvTwzcXJsEXEKvsHA9pXGhg_M_K78pvVWUeWhq3I
Message-ID: <CAErzpmtLMd6pS9OfeS1=_VTyUqPNfNa4J7d1m_ydC=u4_k8Cbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
>
> [...]
>
> Lgtm, one question below.
>
> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> >                                  const char *type_name, __u32 kind)
> >  {
> > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     __s32 idx;
> > +
> > +     if (start_id < btf->start_id) {
> > +             idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > +                     type_name, kind);
> > +             if (idx >=3D 0)
> > +                     return idx;
> > +             start_id =3D btf->start_id;
> > +     }
> >
> > -     if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +     if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
> >               return 0;
> >
> > -     for (i =3D start_id; i < nr_types; i++) {
> > -             const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -             const char *name;
> > +     if (btf->sorted_start_id > 0) {
> > +             __s32 end_id =3D btf__type_cnt(btf) - 1;
> > +
> > +             /* skip anonymous types */
> > +             start_id =3D max(start_id, btf->sorted_start_id);
> > +             idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
, end_id);
> > +             if (unlikely(idx < 0))
> > +                     return libbpf_err(-ENOENT);
> > +
> > +             if (unlikely(kind =3D=3D -1))
> > +                     return idx;
> > +
> > +             t =3D btf_type_by_id(btf, idx);
> > +             if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > +                     return idx;
> > +
> > +             for (idx++; idx <=3D end_id; idx++) {
> > +                     t =3D btf__type_by_id(btf, idx);
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (strcmp(tname, type_name) !=3D 0)
> > +                             return libbpf_err(-ENOENT);
> > +                     if (btf_kind(t) =3D=3D kind)
>                             ^^^^^^^^^^^^^^^^^^^
>                 Is kind !=3D -1 check missing here?

The check for kind !=3D -1 is unnecessary here because it has already been
performed earlier in the logic, after btf_find_by_name_bsearch successfully
returned a valid idx. In v8, the implementation of btf_find_by_name_bsearch
was refined for better performance, and when idx > 0, it guarantees that th=
e
name has been matched.

Thank you for the review.
Donglin

>
> > +                             return idx;
> > +             }
> > +     } else {
> > +             __u32 i, total;
> >
> > -             if (btf_kind(t) !=3D kind)
> > -                     continue;
> > -             name =3D btf__name_by_offset(btf, t->name_off);
> > -             if (name && !strcmp(type_name, name))
> > -                     return i;
> > +             total =3D btf__type_cnt(btf);
> > +             for (i =3D start_id; i < total; i++) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > +                             continue;
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (tname && strcmp(tname, type_name) =3D=3D 0)
>
> Nit: no need for `tname &&` part, as we found out.
>
> > +                             return i;
> > +             }
> >       }
> >
> >       return libbpf_err(-ENOENT);
> >  }
> >
> > +/* the kind value of -1 indicates that kind matching should be skipped=
 */
> > +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +{
> > +     return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
> > +}
> > +
> >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *ty=
pe_name,
> >                                __u32 kind)
> >  {
>
> [...]

