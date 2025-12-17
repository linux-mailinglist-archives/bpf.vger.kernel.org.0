Return-Path: <bpf+bounces-76803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F968CC5D09
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CC0030039E6
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D623D263F52;
	Wed, 17 Dec 2025 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJfpLvf+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F62B9B7
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939636; cv=none; b=gMx90Csx23IGQ3zQ3O/cHB+KRboohfeGpxCKnMZzMi0bax076QI3Fqz4ryMLWnevNB5adx3bW9F5fgPoSDjfwL0V3tFw94WS70AccFB8zaww1YTfKxIHTxIg1r9WzbOahmFqbBbI+VWYXBqcw/DsDB4K24yRgseT6ENmR4qJQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939636; c=relaxed/simple;
	bh=nq8BSrkYv1OtTVyhG5B1QNiTY7uKYgONI945kuCdrDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL0xtP2AvNgitigQ42QjQQv0rDFvZmJRXOP64KZa861yNC/tgS3JW0a6mMAAc4MDnH6/mk8Xdvvp4l7kAODETDemMyBclyTkd7UTIAGTdU6+BKKkTrJuk9sVlBZFYbZpaOBbFN4oKwLjTx0GWZFOmOjXkSA+G0A3yLiePk6jh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJfpLvf+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-649e28dccadso3449091a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939631; x=1766544431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLKqtFSOlUwDLoz02gorNwvCiSZLGT/DS91QS1cmetU=;
        b=bJfpLvf+cdAMyfLn0FBkPZc9nRZUpA/+QKiM6jTbhnhd9ZtX5GuOi6NrlYSWmf8mwG
         kCDBWoG985WKO72BuMsI5c0PA2UyypEZsQUQ/dW8PcuP+uNf1TwaXynsNkFuYUl7EAK1
         bXq29zCPrJpaJGYLZQ4Th7LeZiDkFtvu/kKNvTA3RJzddHcaXHFlJofUHxx+t51GEuI9
         UrvH0PkZ/KKJ0I3YbDhguXzWV4KelopqWmKN8xStnmTEpoUpE9+3OHcc+OzArYVA0PnO
         OY6XJkjyEnCKY74WeJ+MXKyNg7fc1J/b9+No4APeu4UAOwVol3Lzp6awmVZxcj/6cuID
         I7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939631; x=1766544431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLKqtFSOlUwDLoz02gorNwvCiSZLGT/DS91QS1cmetU=;
        b=sxeXN3hviX9DtCaqVR20y9iMHJdAEC7AsVPyrP6ukF2YS1Tma3F7o0NAANFy6d5AcU
         3lrmLkMsEUpm1vCHzlOm1T8OJmWeWpK3oNrsGivB5H+WLnhv5PpOnViz0veGJqKT75z3
         ar0gFB2z8RQxoxrMCcaZOLc70JhPIbtmDFXzpFWQOlzBLMOGDN5m44zsqBTbGjoJIxRV
         Bkscj2Ql4qimgPaBmgBJRtKBdSO8zb0VpGVLGLjF/zcOhTQSU+WT9s7lhtK83ycsNlhv
         bl9A1kgS2VeGTchTDVooqsvNf0HET/cg6U0dlNQvGSNmxKmJHuWb86Q8T0SCh7BNWMfv
         I+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwN2aqsohGu3HOEqFx/JGgtN0ogHyeqQCRBMF3xFCSYHMrimO+QnU/Dhi1uvwqBOw9vY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/1Dr6VXxMJ8QYfxJGHu6w88lHZzdrsH7Kp7zRdwa5XgXFH/V
	UgRsXJKVVs1ZhvX5TKJvvU1E0GD24UUS+GTl2nBgJLLf7aeJLERLnwMiyTdcD8aS4qfE3ftfdoA
	HPOAE+PjekIhvp4CTKn4Kl9rkCMMj/2I=
X-Gm-Gg: AY/fxX53RI2niDFXEfd/znCF3RTBR5hiaf9xPmOWIwgzwxmzpjqL9QrJ/vPoHw5PZ+p
	UH1YRybuBjWN5zoz4GwWJgBFxcN2Cx0eTQmAQ29qVhKKqoX8lDa3lvzBei1BEmY7YM7AQxh1EBn
	eHYMKqeXXxSnHeL8hzOGSkZYdZB6tpkplk5arsZHXcwLtIlaWu+O7cIKAQvUoIPM20yeFkwNPzE
	jGp/RKai9oCfWOsFdbjSQVOjd4j0m1GYJEqTVlKCinlxly28qc+9dKbpBSflI6xVvL1DkXx
X-Google-Smtp-Source: AGHT+IGWUJKnxDFx9edVKvk1wSQCV+a18/qLubE1r3mXDJk0ZgKDcp6i6arT0Rs2wgVgKAA1xhbbTRxKZHjyZ/UMOI4=
X-Received: by 2002:a17:907:728f:b0:b7c:e320:5232 with SMTP id
 a640c23a62f3a-b7d23619fc0mr1763914266b.5.1765939630605; Tue, 16 Dec 2025
 18:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-5-dolinux.peng@gmail.com> <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
 <9fbd1b7714fcd549d5d9c1aea47d50d93297ca26.camel@gmail.com>
In-Reply-To: <9fbd1b7714fcd549d5d9c1aea47d50d93297ca26.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 10:46:58 +0800
X-Gm-Features: AQt7F2plH2dS7Perkpm9AgAkzYHd0_c4RgqkIDilp0nMj2T1W-OuAjIffr7_mxE
Message-ID: <CAErzpmuNbJo0z_Bij_3Eejury=0pXWRb=dOMiKxK-xv7=DYWhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:43=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 15:38 -0800, Eduard Zingerman wrote:
> > On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> >
> > [...]
> >
> > Lgtm, one question below.
> >
> > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_=
id,
> > >                                const char *type_name, __u32 kind)
> > >  {
> > > -   __u32 i, nr_types =3D btf__type_cnt(btf);
> > > +   const struct btf_type *t;
> > > +   const char *tname;
> > > +   __s32 idx;
> > > +
> > > +   if (start_id < btf->start_id) {
> > > +           idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > > +                   type_name, kind);
> > > +           if (idx >=3D 0)
> > > +                   return idx;
> > > +           start_id =3D btf->start_id;
> > > +   }
> > >
> > > -   if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > > +   if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
> > >             return 0;
> > >
> > > -   for (i =3D start_id; i < nr_types; i++) {
> > > -           const struct btf_type *t =3D btf__type_by_id(btf, i);
> > > -           const char *name;
> > > +   if (btf->sorted_start_id > 0) {
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> Also, previous implementation worked for anonymous types, but this one
> will not work because of the 'max(start_id, btf->sorted_start_id)', right=
?

Yes.

> Maybe check that type is not anonymous in the condition above?

Thanks, I will add the check in the next version.

>
> > > +           __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > +
> > > +           /* skip anonymous types */
> > > +           start_id =3D max(start_id, btf->sorted_start_id);
> > > +           idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
, end_id);
> > > +           if (unlikely(idx < 0))
> > > +                   return libbpf_err(-ENOENT);
> > > +
> > > +           if (unlikely(kind =3D=3D -1))
> > > +                   return idx;
> > > +
> > > +           t =3D btf_type_by_id(btf, idx);
> > > +           if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > > +                   return idx;
> > > +
> > > +           for (idx++; idx <=3D end_id; idx++) {
> > > +                   t =3D btf__type_by_id(btf, idx);
> > > +                   tname =3D btf__str_by_offset(btf, t->name_off);
> > > +                   if (strcmp(tname, type_name) !=3D 0)
> > > +                           return libbpf_err(-ENOENT);
> > > +                   if (btf_kind(t) =3D=3D kind)
> >                             ^^^^^^^^^^^^^^^^^^^
> >                 Is kind !=3D -1 check missing here?
> >
> > > +                           return idx;
> > > +           }
> > > +   } else {
> > > +           __u32 i, total;
> > >
> > > -           if (btf_kind(t) !=3D kind)
> > > -                   continue;
> > > -           name =3D btf__name_by_offset(btf, t->name_off);
> > > -           if (name && !strcmp(type_name, name))
> > > -                   return i;
> > > +           total =3D btf__type_cnt(btf);
> > > +           for (i =3D start_id; i < total; i++) {
> > > +                   t =3D btf_type_by_id(btf, i);
> > > +                   if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > > +                           continue;
> > > +                   tname =3D btf__str_by_offset(btf, t->name_off);
> > > +                   if (tname && strcmp(tname, type_name) =3D=3D 0)
> >
> > Nit: no need for `tname &&` part, as we found out.
> >
> > > +                           return i;
> > > +           }
> > >     }
> > >
> > >     return libbpf_err(-ENOENT);
> > >  }
> > >
> > > +/* the kind value of -1 indicates that kind matching should be skipp=
ed */
> > > +__s32 btf__find_by_name(const struct btf *btf, const char *type_name=
)
> > > +{
> > > +   return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
> > > +}
> > > +
> > >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *=
type_name,
> > >                              __u32 kind)
> > >  {
> >
> > [...]

