Return-Path: <bpf+bounces-31263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0A8E0025
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF31A28AFBC
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419913C3F5;
	Mon,  3 Jun 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIGOnWDt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940B13C3EB
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450093; cv=none; b=SvmkhktQ0kgbE+UMqSVigLXvxISmNqahdzvWziJCjjDQ2cSHgYn7r9bm30m1xWfCX+wl/ytMocKnmelyPvFrdynAb/RFDtrVEDemd5KxIidQLOtO6lYQBmtfNB4Qlo8/jO74p6yjz94H1mFo8apC12EQYiVYlpnBfSfyNeK90uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450093; c=relaxed/simple;
	bh=vWNBfcLurLUiGAV6VfUdDDhkjyW72gQ/QRDbYdx1K+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuSzycEnfZ9Se9Xdbo6pdG6DM2sNkSX+3GEN+7DlEWZkSwy5tpm2+nbKhE7I9YBRgaWKuMUzuRhVdkXBHlh3oxxR1RV3GwPaZt+yJNLN4c5OC6mp678rQRfiFPh26h1C+AdYBmiqK2gbJI3DcLgK91BEC+Z0zOc2UjN0orLqADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIGOnWDt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681953ad4f2so3607736a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717450091; x=1718054891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLpic3nkdu36ZzEzLDQ4Legrv+wA9sJFqGyoWH6k0dg=;
        b=cIGOnWDtHUU41pPF2w1yTpfovoDSZVvlF0WuM5f51qxaNeVM6tdzLCiwyGKvBb2dzp
         +Zsq8i+gfLq0M01sJNjviPeAF7A7+EoudHvI02DCW6KWeBxYKHgmKaWNauy53gCasTGQ
         fb//H4MvkggrS5JW2IwqJlrjdVV5UTvcrlH62KLVYWEIhr0lJqeDaaZwmmSHKLyY8Y++
         FaWk9MsnzykqOiKuISc3v757mfoaqj/Wy5CkRIwfRDsw+B8cX0JnUNIAdklFQnH1KESQ
         R1iUSpDgwoEpW/L90Ta0Bw9Jcg8DLmzBZS2G5prFp6QW2kPd5zyOk6+fW+6RBSMqD+Xr
         0A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450091; x=1718054891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLpic3nkdu36ZzEzLDQ4Legrv+wA9sJFqGyoWH6k0dg=;
        b=rjd0pnhT8Jf5dCkZ1Fq6vquhRAvUVCFxUiN5DFzPsNq++SzlmcpGjViYXMDXupgRKV
         DH3PK711E+yONS0dgk9FPc9jtQRi+CwKqsFlz8ra1Mf3SiPPfjDTtMnrf1mYe9X0fgoK
         VwcS+sLZPiVy75vmVmKZt/L+V0J30PQfWWFdM2CXgGlzdiTSEKsIjClPQtMZUt0PpZyR
         N+3WfPFVf54UZpp/kE3/2ZrNF5N2PLrJM60uM4iDcFvVAOpxPfvDJQ/ImhYi9QqZhTbE
         dqM3jLRT0i3sKRudAuto9QUbcTKVI/8wSz09MKCL04xW01SEwACWzZ9/3PueQLhF7LQw
         Hohw==
X-Forwarded-Encrypted: i=1; AJvYcCWphAsUoGyXIYIYF1NRg5izruwjnNc+Bhjn0btk6FNlFH3vF9JEMybXuXKy1vIDQ0KaLHJy3mPLvyXylS1abxH1XxUA
X-Gm-Message-State: AOJu0YykvWpUpjbDgBqJSZhs1EqauJ8Gb0+sAa5KL7/Ymmybv3a64KTk
	Nx6wI3H8Wd5OCtHvEmoSzGe7VSIw+cHd1xPY2cTZSqmevtngkBxieuekZfa85sXOJmZra1xN1LW
	LMyS+kGDtBpQAPpqtbvJwAy90ibA=
X-Google-Smtp-Source: AGHT+IGqPlj0swq6oJYMXKhThhyC3myutFEvmZNeVi+XCmV670C605epdMnTxpnbaonVy4Yg0bS6rSvIMm+WC30fqyE=
X-Received: by 2002:a17:90a:fe12:b0:2c2:93b:cb2f with SMTP id
 98e67ed59e1d1-2c2093bcba8mr5530500a91.31.1717450091324; Mon, 03 Jun 2024
 14:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601014505.3443241-1-andrii@kernel.org> <ZlxobN6wOiXgifAB@krava>
In-Reply-To: <ZlxobN6wOiXgifAB@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Jun 2024 14:27:58 -0700
Message-ID: <CAEf4BzbTzjh_1oYqHTsB=VpJS-fSpxz0VtSJX7o4yQg_0pszBg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next] libbpf: implement BTF field iterator
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:41=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, May 31, 2024 at 06:45:05PM -0700, Andrii Nakryiko wrote:
> > Switch from callback-based iteration over BTF type ID and string offset
> > fields to an iterator-based approach.
> >
> > Switch all existing internal use cases to this new iterator.
> >
> > We have .BTF.ext fields iteration, those could be switched to
> > iterator-based implementation as well, but this is left as a follow up.
> >
> > We also convert bpftool's use of this libbpf-internal API.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/bpf/bpftool/gen.c         |  17 +-
> >  tools/lib/bpf/btf.c             | 334 ++++++++++++++++++--------------
> >  tools/lib/bpf/libbpf_internal.h |  26 ++-
> >  tools/lib/bpf/linker.c          |  55 +++---
> >  4 files changed, 253 insertions(+), 179 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index b3979ddc0189..7b9c0255a2cf 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -2379,15 +2379,6 @@ static int btfgen_record_obj(struct btfgen_info =
*info, const char *obj_path)
> >       return err;
> >  }
> >
> > -static int btfgen_remap_id(__u32 *type_id, void *ctx)
> > -{
> > -     unsigned int *ids =3D ctx;
> > -
> > -     *type_id =3D ids[*type_id];
> > -
> > -     return 0;
> > -}
> > -
> >  /* Generate BTF from relocation information previously recorded */
> >  static struct btf *btfgen_get_btf(struct btfgen_info *info)
> >  {
> > @@ -2466,11 +2457,13 @@ static struct btf *btfgen_get_btf(struct btfgen=
_info *info)
> >
> >       /* second pass: fix up type ids */
> >       for (i =3D 1; i < btf__type_cnt(btf_new); i++) {
> > +             struct btf_field_iter it;
> >               struct btf_type *btf_type =3D (struct btf_type *) btf__ty=
pe_by_id(btf_new, i);
> > +             __u32 *type_id;
> >
> > -             err =3D btf_type_visit_type_ids(btf_type, btfgen_remap_id=
, ids);
> > -             if (err)
> > -                     goto err_out;
> > +             btf_field_iter_init(&it, btf_type, BTF_FIELD_ITER_IDS);
>
> lgtm, should we check return value from btf_field_iter_init?

yeah, it should never fail, but if BTF is corrupted it might, so
better safe than sorry, I'll add checks

>
> jirka
>
> > +             while ((type_id =3D btf_field_iter_next(&it)))
> > +                     *type_id =3D ids[*type_id];
> >       }
> >
> >       free(ids);
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2d0840ef599a..0c39f9b3f98b 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1739,9 +1739,8 @@ struct btf_pipe {
> >       struct hashmap *str_off_map; /* map string offsets from src to ds=
t */
> >  };
> >

[...] (trimming is good)

