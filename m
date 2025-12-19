Return-Path: <bpf+bounces-77128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF8CCE7E1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FCEB302037C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3F2BEFFD;
	Fri, 19 Dec 2025 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNkbaDIL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91D23AB9D
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121027; cv=none; b=Dlgwup4BS7QZBhvbobIFmAoriB59antOrD8c/sEUPkjsDZBmMtqBbWiLQHJYSsYDfnnHJ9S2G/fAXpMnlZfTlyvnLbv+y/Q23QRQ6xk6oKB+42xqxQhx5MwPyVfhEMMSiT6V/F+Er1/clyRMmopns+5Xb2/R/zNkItJwR4ZsGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121027; c=relaxed/simple;
	bh=ZJ+SKIB2RKxseRRKYp6Lxa9vKFo7Ohi7N8X/+82Ix90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tISEto9MvA3OgPR0JG+aWJ0A+NJ4/IOWS9YIqwBDPmUIJW3bAf3zzYPzT7B9wXQwHZIInNTcdPdBT+kfmPW8ptS5Z2CUiJmNs+sVg16EHBsichSZS6ZnlaHNrU7fh4slZfAFS7O4kROypdOdnLNIwe8pKn45evX8U1FbhDhNpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNkbaDIL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cee045187so228143066b.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766121024; x=1766725824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TEgh/IGVHzWJD+Grw6Q0MED/Bma31/wysbjmfikqF8=;
        b=MNkbaDILd5rbkXdw1CERCQUIz593e8VRcw8W+R3wFZpvuTP2265y9YAsKwQBQ0w1oR
         CKgiRWaWinlnt0NMf0vGy4OJSwQfdtl3lgO9o+fG86WxJKGElxN9sZ1Zn9JXDAhI1eiy
         QYL2kVkbbTwXHpFzXTuTBoNQPvH+XVYP1QQn6W7vMfN4g04y0hd2L4uEnJOkYLwc47LN
         hj0Rx9tKYd2CYrMeUm0Ydp/wIevxKMme/TI1ONo7QhgTZQh9efelRmpgdwN5PqjZetts
         hZlivWNVJcmf+vwwnwO0V8R4ZALwJWWfzIOKvcEa+0ywhC7ciskOWcuSlDtkKm4ZC0Fg
         hXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766121024; x=1766725824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TEgh/IGVHzWJD+Grw6Q0MED/Bma31/wysbjmfikqF8=;
        b=RfubReYTxCodC8FA5z5lXewB+d/mVa7ziuxRSbhxFqQeZSPEC++somhel+BLg2ZIq9
         7yZLTJZYu0xliZZPQIr/HJ0gGFh32orbfvGzbIVC5O6VEdqQtebpyWAa0o4RyLb8ko7y
         SLCfDuGTRBAiuDqWJlzKu5ayvLVQ1pbziOJixsS+U2ydw4XgRfjDFicAVbnasEapVvpe
         9TLmKTlyZSVifwEt3udHhj4AAhk1dcbornTcspMNyLQVxvfqEx4+LHo1ATc6mh/RG4Qs
         9oWtEwP0uNcoc6nNDl7looJWa+dWAuFwrb64RqfdNLkIeziIg8GBNn5PhqwyQaFu1ZRO
         ShcA==
X-Forwarded-Encrypted: i=1; AJvYcCWDVCqSVFgErnbzntbFz33wlsmRJptp8jofl3xybJUxHuYNEbG2iY5mkBYTXSgWC51Xq94=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywca5agEBvagIKXpVCZrdElZ16h+DEGxuRPbsEzjVh+HBuLD/cX
	3syPl7tQJChflwnvyAE6w/NHvp5kQNkHxWRtZTqDI22zHWjPdJAtGB3awsUMTP3tawtqlt2rRla
	1ewjNmLnXiTSR7EvCqrxDeFGE2mQafI0=
X-Gm-Gg: AY/fxX5+ae+rcxB7rCbhyk2x5oiZprNEvPAtQIr6wKFQNIJu/Jc6+70T90qBKvYa9zX
	jrugxpjinh1W8bK12Mvg6DHKRahxluI4chg2503XcklGJLX46JnLFM2JtsKAC/6htVjxBlP8dFw
	im1HC8OT2prTrbFbOhMQ8rChOdzBrPCPmMBV0dzZ4sbbmLDUJTgjv28WhhheIYTaIWp/QFa2mP/
	m0kJzXS7e8TZtZNXwjfWEV6yGclfCfHB3t/F5+Uri1vX3TqJKjvHJasMdwOVHxvUNJl9UdYIRLu
	aqWHvBM=
X-Google-Smtp-Source: AGHT+IHuj6eCmSwXJak0ooxJMCKDP3O0wVo2fbs96Q9M35SVg1HRbsaPtHxLly+re6s13k0MyDcTiPPUbpawnorwthA=
X-Received: by 2002:a17:906:ef09:b0:b6d:5dbb:a1e1 with SMTP id
 a640c23a62f3a-b80355b2500mr206863266b.5.1766121023768; Thu, 18 Dec 2025
 21:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-8-dolinux.peng@gmail.com> <1a9c0b5c22b2ecd8a8df531b1ed9441ab926415b.camel@gmail.com>
In-Reply-To: <1a9c0b5c22b2ecd8a8df531b1ed9441ab926415b.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:10:11 +0800
X-Gm-Features: AQt7F2qgKAQbJ0x0gSRJHQx1CLnKNQm-6kTqoVsbeaK6pVHU8wh23Uqpt-pGkZI
Message-ID: <CAErzpmtvZPvXcebBk5Q=EUL-_+gLO2iqEyoA2Pth=mQLLHqY-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/13] btf: Verify BTF Sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:43=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > This patch checks whether the BTF is sorted by name in ascending order.
> > If sorted, binary search will be used when looking up types.
> >
> > Specifically, vmlinux and kernel module BTFs are always sorted during
> > the build phase with anonymous types placed before named types, so we
> > only need to identify the starting ID of named types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
>
> Lgtm, but please take a look at a few nits.
>
> >  kernel/bpf/btf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0394f0c8ef74..a9e2345558c0 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +/*
> > + * Assuming that types are sorted by name in ascending order.
> > + */
> > +static int btf_compare_type_names(u32 *a, u32 *b, const struct btf *bt=
f)
>
> Nit: no need for 'a' and 'b' to be pointers.

Thank you. I will remove this function in the next version, as
suggested by Adrill.

>
> > +{
> > +     const struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > +     const struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > +     const char *na, *nb;
> > +
> > +     na =3D btf_name_by_offset(btf, ta->name_off);
> > +     nb =3D btf_name_by_offset(btf, tb->name_off);
> > +     return strcmp(na, nb);
> > +}
> > +
> > +/* Note that vmlinux and kernel module BTFs are always sorted
> > + * during the building phase.
> > + */
> > +static void btf_check_sorted(struct btf *btf)
> > +{
> > +     const struct btf_type *t;
> > +     u32 sorted_start_id;
> > +     u32 i, n, k;
> > +
> > +     if (btf_is_kernel(btf) && !btf_is_module(btf)) {
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Nit: there is a btf_is_vmlinux() helper, which does the same thing.

Good catch.

>
> > +             for (i =3D btf_start_id(btf); i < n; i++) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (t->name_off) {
> > +                             btf->sorted_start_id =3D i;
> > +                             return;
> > +                     }
> > +             }
>
> Nit: return here?

Agreed.

>
> > +     }
> > +
> > +     if (btf->nr_types < 2)
> > +             return;
> > +
> > +     sorted_start_id =3D 0;
> > +     n =3D btf_nr_types(btf);
> > +     for (i =3D btf_start_id(btf); i < n; i++) {
> > +             k =3D i + 1;
> > +             if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
> > +                     return;
> > +
> > +             if (sorted_start_id =3D=3D 0) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (t->name_off)
> > +                             sorted_start_id =3D i;
> > +             }
> > +     }
> > +
> > +     if (sorted_start_id)
> > +             btf->sorted_start_id =3D sorted_start_id;
> > +}
> > +
> >  static s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
> >                                   s32 start_id, s32 end_id)
> >  {
> > @@ -6296,6 +6350,7 @@ static struct btf *btf_parse_base(struct btf_veri=
fier_env *env, const char *name
> >       if (err)
> >               goto errout;
> >
> > +     btf_check_sorted(btf);
> >       refcount_set(&btf->refcnt, 1);
> >
> >       return btf;
> > @@ -6430,6 +6485,7 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
> >       }
> >
> >       btf_verifier_env_free(env);
> > +     btf_check_sorted(btf);
> >       refcount_set(&btf->refcnt, 1);
> >       return btf;
> >

