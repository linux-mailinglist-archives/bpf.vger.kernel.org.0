Return-Path: <bpf+bounces-76809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44847CC5E68
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AFAC302175C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E22C0F68;
	Wed, 17 Dec 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8v4P3dn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5D3595D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942022; cv=none; b=J5DEGcJ/90mdhgwx/PXeiCjtV2z2/XAl+cFL+ydQ5L57ppJjvyc/ky8Op54JPiIYKCwJAE/C3KieQk9VPt9ZrtxE0ZIKDosJLxYX4Xrj809Z3oz5jBM6TUzHf5tM4TMwR8IxLaKSQVX0L0AfIGjT10YW9AdtF5CUgx9kxhiwMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942022; c=relaxed/simple;
	bh=R9UM9K/o4W6aB+gNKV2s2LvhqyAlxqG83pyJ+ltxyRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV7bheP2uaHL42Qach7Avb0YCPCI49DJysbQs785msmhVx1JPD7NolS+Y/PvMUiuHyeIgccXuR5hh2tuQk0fvPABvcjSAKgnEIRVUb9v5XCD6ZylBb9k8w9uIZTklYZOY5ug1YAlpC+6M2rzmVfKeZM7K46Fp4UcFeRsE8d8huA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8v4P3dn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-649784c8967so7141336a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765942019; x=1766546819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdTuYvWYFUgDleC3pDEKoYs/MYkm1qzSha7w2HnKSz8=;
        b=W8v4P3dnngKZNBqOpT61gm8cRPBk/hlillupcFKQX8Kcqcx7i8H3SQoa0D/ShYp8rs
         4TBEY5/redvSVJVz0MAb+gIRglCHAEPvEr8TRQjIhuvWuPCj3bqZD61hDIKymJTyOLe+
         CFIjakH07tKPUUaIrSjfM1tKj2IAubuvrwPCtaZDzCeLZF9D9HEWk0QLOF4XNu5NslKI
         sgpPedq1fD4EFRi0tL5aYMtkZddXIwIMEeStpolRtXnGyDj29ll/5Xhj+kxMONaf0dtk
         s1af2ncV6XGj8dUJJKxccBC8y0sKAvLD88xT60i94Ip0gZQYvSdfXz4LiXY2D2gZ5kzH
         qc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765942019; x=1766546819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdTuYvWYFUgDleC3pDEKoYs/MYkm1qzSha7w2HnKSz8=;
        b=e2TBBOvJ+UnmQ5A0skvWDvfTwQE/7GwQ8VQ+1+J87CQCDhz/T60W1w4C6/ssTPkC2g
         Gcrbei9Niw7ZGL7jJM+oUFA0i3kepH/tWIOxH8AYSX5ovaA792diwUAtHatTHoFXPMa1
         613f0zHKpnKZc2J9Vu9Vm2Lvo9CYH0AWfo5ovwBxzxHDVObVsGEPaPIC3LsPpNTYCzW8
         Ky1+FJ9rZjK+sNhnTvs4J+G+1RJyfN63Oyy8RZ6FmCvXrVGS7pOmKCl0aFABJDriGq8U
         sHI45WlM5bBIxTwr1UDmy8lijKKIboKXfL1UGqsOOXusiemn0+bTgy9fm1MoeoC6zmIM
         kGng==
X-Forwarded-Encrypted: i=1; AJvYcCXMX5iZDDKyHRvczikejQltSF4Y+B8GNfhluhhrFd5cG5EC4DfdiRidZOdsDSePIqgpfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZjSe1AqUwS0yJ/xzCuQ7lFbWrqY9ReKJIDrwblF0Lvy3zl+y
	zqbalZR59YYxr5gCkBdRAO1moX7E9FAZQzMlXQ6a1Vk2zhORClMKRSFwCFJEQsYFOsmDL+z4L23
	Tm41FjTRT7Mjo+sHCRmCQAxL/Nb1JNH8=
X-Gm-Gg: AY/fxX6GVIdVwKasC2OZcbjZ9Z3fyr0ZsmgsZg8Og9qiJiTKRdbEFMRGPBGvm+eExMA
	Tn1dK++mguOHcMSgz7pgzdYgHJuuezFc/gKmc7itpE+egV9oEnHgqJWxFjAEgwyb3F3rkAG9YyY
	CdNL1fBjL0r1wJi8XSZr83D0s3ybX5ERRO9dTIPU2THKJTbnxE1DQMBsR23t35b5rDIBqwwg3id
	+90eQYgRCiWv3qGFYNEfvvIpGNnz36aWEbfG6VPtlpqkmLoPfipWj2F5KCany7ATXz4bcOv
X-Google-Smtp-Source: AGHT+IHgYsTmZ0dZf9hOtsOK1XnRBTt0L47dRoIUtd2RdIjoW7sDy7DBaej7PYqkUyfDaY8K8gulXrHXif6zNM7Xba0=
X-Received: by 2002:a17:906:794e:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b7d23a1bc9bmr1628298966b.29.1765942018864; Tue, 16 Dec 2025
 19:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-8-dolinux.peng@gmail.com> <6eb163ae1dbe8bb44e47f1c1ebc37de34c6b7df5.camel@gmail.com>
In-Reply-To: <6eb163ae1dbe8bb44e47f1c1ebc37de34c6b7df5.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 11:26:47 +0800
X-Gm-Features: AQt7F2o3eIPb1nkJi2Z2iNEVo_QBU6agYhDrk4CCbvmlogLZyTn5i0rQK-TdTnU
Message-ID: <CAErzpmvhMwKLT4r-MTMiqe3TVyc2ttdsndpVhbM1eLzRCiZOtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 07/10] btf: Verify BTF Sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
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
> >  kernel/bpf/btf.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 842f9c0200e4..925cb524f3a8 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +/*
> > + * Assuming that types are sorted by name in ascending order.
> > + */
> > +static int btf_compare_type_names(const void *a, const void *b, void *=
priv)
> > +{
> > +     struct btf *btf =3D (struct btf *)priv;
> > +     const struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +     const struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
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
> > +     bool skip_cmp =3D btf_is_kernel(btf);
>
> Nit: maybe just do a separate loop when btf_is_kernel(btf) =3D=3D true?

Thanks, I agree and it will make the code much cleaner.

>
>   for (i =3D 0, n =3D btf_nr_types(btf); i < n, i++) {
>     t =3D btf_type_by_id(btf, i);
>     if (t->name_off) {
>       btf->sorted_start_id =3D i;
>       return;
>     }
>   }
>   return;
>
> > +     u32 sorted_start_id =3D 0;
> > +     int i, n, k =3D 0;
> > +
> > +     if (btf->nr_types < 2)
> > +             return;
> > +
> > +     n =3D btf_nr_types(btf) - 1;
> > +     for (i =3D btf_start_id(btf); i < n; i++) {
> > +             k =3D i + 1;
> > +             if (!skip_cmp &&
> > +                     btf_compare_type_names(&i, &k, btf) > 0)
> > +                     return;
> > +
> > +             if (sorted_start_id =3D=3D 0) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (t->name_off) {
> > +                             sorted_start_id =3D i;
> > +                             if (skip_cmp)
> > +                                     break;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (sorted_start_id =3D=3D 0) {
> > +             t =3D btf_type_by_id(btf, k);
> > +             if (t->name_off)
> > +                     sorted_start_id =3D k;
> > +     }
> > +     if (sorted_start_id)
> > +             btf->sorted_start_id =3D sorted_start_id;
> > +}
> > +
> >  static s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
> >                                   s32 start_id, s32 end_id)
> >  {
> > @@ -5889,6 +5943,8 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >       if (err)
> >               goto errout;
> >
> > +     btf_check_sorted(btf);
> > +
> >       struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
> >       if (IS_ERR(struct_meta_tab)) {
> >               err =3D PTR_ERR(struct_meta_tab);
> > @@ -6296,6 +6352,7 @@ static struct btf *btf_parse_base(struct btf_veri=
fier_env *env, const char *name
> >       if (err)
> >               goto errout;
> >
> > +     btf_check_sorted(btf);
> >       refcount_set(&btf->refcnt, 1);
> >
> >       return btf;
> > @@ -6430,6 +6487,7 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
> >       }
> >
> >       btf_verifier_env_free(env);
> > +     btf_check_sorted(btf);
> >       refcount_set(&btf->refcnt, 1);
> >       return btf;
> >

