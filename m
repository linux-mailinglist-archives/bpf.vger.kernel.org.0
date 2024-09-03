Return-Path: <bpf+bounces-38797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC796A4DB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E50A287358
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33518BC3B;
	Tue,  3 Sep 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO27XMGc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0C18B49A
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382295; cv=none; b=jYjIpAx6x4ZzKmHAlhLh9qeFABeQgdcAPWY4Bo1UYk+aaw+QV58L3ctZsquHNdn0gJseOyuIHai8V+GpX4KAPP+j9i5w4zs8wJHFQfv2wrXKk78DjY9IX9WAbrw9690T9KZjR2gnvSISSKJTmUhJD0ME/QNZK9+zbXKV/oErVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382295; c=relaxed/simple;
	bh=c73ayQr7Zfsad3Z61HVujyKJHjiyT95khZVu2WfxZqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3DFDXAC8XwMtBtYlv7ToUz/unHbr+smlp+a4AJQLTGaRegQDU6AeHSYqOXrHlHCLGOoWkouVDyj9bCzabx5Z35IWKcuYvvCrs3G5zQ8N3p+M9+xvSkFAUeJkh04HR0aL8mjUY7UuXOPZE5EEPUsbinZ2RShD8FXN5pWOI0R6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO27XMGc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so2153351a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725382293; x=1725987093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnlSH43JVn1Es3oVmSZPXjJsvT6RRjh+9zUkVE/oA8Q=;
        b=GO27XMGcwt5ndPOb2J4vZgp/ch5XKBhcQVYqr0s0rKwY18yiHzdg/tbsS+HqcjjbAO
         pOCnVEHB9EaAwnXhrpa9bxBHWKJcVXxX8SUvj7pptO/2pSWmb5ytlH+Mqd5fdbuJ3h3b
         n+TxKmQRBLWlcR8qOqwnvGwF3TqiNy0mDw2Emeq2vZnKYpKUKIm/UbPLfReCbOMXYO9G
         WIgBCPdB+bplzx9mL8NZiY7RuQ5iDseWkUuqjF+JkTARZ1ax8qv1y7bb32JGw0/mbqw6
         w434Ed2eJMmcoGGz0QGBekBdqzl9M6LLaTzmXIN+d1sNY2FF+rMQEvpcG1R4KkE95uFY
         T1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725382293; x=1725987093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnlSH43JVn1Es3oVmSZPXjJsvT6RRjh+9zUkVE/oA8Q=;
        b=sZZbCo3iUL+iiC6Txs+epYUyfe4fjynZL7czpoJhrcsaFPKAKo8GxkT/Yge/h7rTsy
         BSvySbUda9Y9OJKngvTLtW6tqZLKlq0aRASJGJ+YT4Cox6CnWC1R2Owrh+2OWgOFub3u
         9t9UzN/4420qK5MW+jdrCLorM3bk47IPXLEtVSoD9/HmFMjQnYO281NQaftu8F2+Le1d
         bua+RIcsiFtHFtGIgk74e6M1Znn28JID/t/ooJ8HO/TtjGktt85TMzg2SEGE/gdb1+dN
         u9L1HY6+Y+B9uVSwDvYLI3YmWMpgWcNg+xFI0jQEe07ylYXtyxJJz+Esyl6D+GWWP2Z2
         HvFg==
X-Gm-Message-State: AOJu0Yzm6sw0EGY+UBMQGfs1b/Oe0E1WYYYUyn0Utis+sIXwLphf03Gx
	y9V2rani5fHZvaVH79RZtUEgiKGn+09ZDrK7oQsHn8WqaC5gJ1TDcb756WSO6SeMaZYGQ2PwgYx
	ITYiAT7gpKYmyoLcFMW4C4A1sphA=
X-Google-Smtp-Source: AGHT+IGA3kCrhL33aHVqhL8NJfdf9JMH8IA/SWFqzJ6DCrlbVH8i1XF01pTT9Ud1PzpH6kNiMf2CN1r5QW3cBuW6prc=
X-Received: by 2002:a17:90b:350d:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2da55a77e52mr3804504a91.36.1725382293509; Tue, 03 Sep 2024
 09:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901213040.766724-1-yatsenko@meta.com> <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
In-Reply-To: <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 09:51:20 -0700
Message-ID: <CAEf4BzZ-_3AyvZN_0tbqYswax4Xx3fPrv_renMuxY_QLcNhcuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:22=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 9/1/24 11:30 PM, "Mykyta Yatsenko mykyta.yatsenko5"@gmail.com wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Wrong function is used to access the first enum64 element.
> > Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >   tools/bpf/bpftool/btf.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 6789c7a4d5ca..b0f12c511bb3 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -557,16 +557,23 @@ static const char *btf_type_sort_name(const struc=
t btf *btf, __u32 index, bool f
> >       const struct btf_type *t =3D btf__type_by_id(btf, index);
> >
> >       switch (btf_kind(t)) {
> > -     case BTF_KIND_ENUM:
> > -     case BTF_KIND_ENUM64: {
> > +     case BTF_KIND_ENUM: {
> >               int name_off =3D t->name_off;
> >
> >               /* Use name of the first element for anonymous enums if a=
llowed */
> > -             if (!from_ref && !t->name_off && btf_vlen(t))
> > +             if (!from_ref && !name_off && btf_vlen(t))
> >                       name_off =3D btf_enum(t)->name_off;
> >
> >               return btf__name_by_offset(btf, name_off);
> >       }
>
> Small nit, could we consolidate the logic into the below? Still somewhat =
nicer
> than duplicating all of the rest.
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6789c7a4d5ca..aae6f5262c6a 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -562,8 +562,10 @@ static const char *btf_type_sort_name(const struct b=
tf *btf, __u32 index, bool f
>                  int name_off =3D t->name_off;
>
>                  /* Use name of the first element for anonymous enums if =
allowed */
> -               if (!from_ref && !t->name_off && btf_vlen(t))
> -                       name_off =3D btf_enum(t)->name_off;
> +               if (!from_ref && !name_off && btf_vlen(t))
> +                       name_off =3D btf_kind(t) =3D=3D BTF_KIND_ENUM64 ?

Just fyi for the future (I don't think we need to fix this or anything
like that), but using BTF_KIND_xxx constants in btf_kind(t)
comparisons should be rare. Libbpf provides a full set of shorter
btf_is_xxx(t) helpers for this. So this would be just
`btf_is_enum64(t)`. What you did is not wrong, it's just more
open-coded and verbose.

> +                                  btf_enum64(t)->name_off :
> +                                  btf_enum(t)->name_off;
>
>                  return btf__name_by_offset(btf, name_off);
>          }
>
> Thanks,
> Daniel

