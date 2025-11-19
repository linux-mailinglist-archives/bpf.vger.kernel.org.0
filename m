Return-Path: <bpf+bounces-75106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C90C70E49
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 519C73515BF
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259636C0DD;
	Wed, 19 Nov 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwkPEa+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9A314A7E
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581674; cv=none; b=nV3EMJcHQO4jTQV1iDJpIlbAhEjQTsdb9Azflb877BgRNQXTgKzUF+cN8UFlE7lxzWILyQ1PPDufcdlgZ1xGdNejJztvS0U7sXbO0IeXH3T6oVwNm62mPL/OVN2ImSnVfemq/j02Ga/8B6X6Cbif+H0yP6MR5wjSuMBnbgurc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581674; c=relaxed/simple;
	bh=bsoc8lO2ASxVUv5VnfmMy5oVlydIKxqIaDmTjldR52o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me4pYPAVnKguGCiVc9k4GzcsiqksaiFxzl5AMTYpQP4d+z35Iea3U+0WMwA3SlnmcetMkHh36ZOeQCtZts2A3yXH0Uvv2VOQFAy4baZlivf75YQaEgQJpDl6x7An4CxYOhVKonrCunFqFtip7zv+SSIkbC4QM70gEYOuVRx1PC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwkPEa+w; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3434700be69so45157a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763581671; x=1764186471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMehWEzsChioD/n+GiGtHlkf7h+H/uO6D+LztILkmLs=;
        b=hwkPEa+wzeKuTp+mQauN+xrwZZLQ4r+z11nMlk2Ph2VvE8yOkdH6eOVk180aXLZNq0
         LnXwg/xeJxqf8ARdkHCKKdgoVUO+dP/6TgBvUZ/Sxnv7J1tZ4AJ73WBuGv2Tc9MFrH2w
         Dbdy+BFuOSLrE7Pc0RfNVbcKvRu+Y3eU7EjhU59Jy/gaPZgjOW1A1F6PzMUP6Ys+OKNB
         baYCcaKJtZMissnZ+LLSp39QMXYydeV0ArYDxWSJ2xyI0T9XtI5wA4uhF6ug4HXNnT4y
         NXpM3PvrKzK48oKl6n7KBipagU23TkH6cIcPUiHO7ptXPj42HVh+OZXqroiZ1IdSJPqq
         4F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581671; x=1764186471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMehWEzsChioD/n+GiGtHlkf7h+H/uO6D+LztILkmLs=;
        b=eIhH4BsxpwVU2EOItf+mlkFP+FTykuORqwZl8ajH9GpfN2vQ7D+r6edPdYRUF3qyTv
         znrz5OnedRqKbJa6QnFo+dCiKj9DLXCzkn+zBJ0xoM5HmlYhUJoBJyeijslDt6j4jZX2
         UrCUiqQ6e7ZPE5RzTqLdA7boGTJXNB7F1vA9WJXzblnY56fg9zKqzGF1ZK5e44T58xzM
         xB445MDm9oTObqqBDyew0d8jqci0GwsdacVglMl6wwBLf0r8AhsxKYqJ2HKvlrUYTegB
         GT1NFXmDDm0WQ4AycCerpgC3mmotnaEtNh1vzC7HiG7LYZqgn3CwSPleqNFBVl96p326
         KVIA==
X-Forwarded-Encrypted: i=1; AJvYcCXTwEWez+w0uEeaxQOFHs6YgzyzytvUtH+v6Ya17DiFXgP9iSMz/ubKAlTemJ4cbGPBClo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgw9Pf0ZfcEgNeVFhGUij843GZ9faXZQ0kSZdDE2pv8RHBUe5k
	+dZCpRqVLLxJpiAU+u7CfHonpKxfO+oqNdrF5RgHqRlWFdd9jTvBLElFns1GRsSOnAUlhLgV1eK
	OALa00GCxykXMVN0kVPbA1VqqxdECNB8=
X-Gm-Gg: ASbGncs+VEaDjikL/Adbuks3VGB2KUKcqaQqIY0wE1lLtFrxsKKEbAgQKaRyA1K8FNx
	Ewm4XxvYoIdbgPhvRBnGoyOk9k2CiAKXGhhh1xA3lJ5cdaQQA4yjQ7gr1Ti8F4w4g264KyRgP5q
	u8EJyldjVyNuc6k01p99tzY5YqJ/odob/+U5lCtXpEi5CRKybwDaBA9oOZWE4jFhxES5LMYGMfV
	rXwXjUAc9aMHtl/t5zllVyKEdmuBST0y/3qZJ9u7pfs7Tm4vpgkOF4a1X2klZgQrR0sQt6XtKkH
	vl+UxMO6slmoTBsVUXBYnQ==
X-Google-Smtp-Source: AGHT+IF7CsHCwDvCWNCR//KNWQlHloELy/XEWRZ/dc/oPasc0IQpZR26FyOwxMe4Q4HRpwFob9472erhXwF9lBueuHc=
X-Received: by 2002:a17:90b:280d:b0:340:bde5:c9e8 with SMTP id
 98e67ed59e1d1-34727c4b62amr316870a91.22.1763581670879; Wed, 19 Nov 2025
 11:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com> <20251119031531.1817099-5-dolinux.peng@gmail.com>
In-Reply-To: <20251119031531.1817099-5-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Nov 2025 11:47:38 -0800
X-Gm-Features: AWmQ_bnrpfHbKFnCfoc6l4AgZlLI_NW1FnamL0_p_p1EmKUQlgeLi3PL7ZokCP0
Message-ID: <CAEf4BzaT0RR=iVpgnBOXQpHN++6Soz4ECAYex6bpd2zficSCRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 4/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted type names. For unsorted BTF
> or when nr_sorted_types is zero, the implementation falls back to
> the original linear search algorithm.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 104 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 81 insertions(+), 23 deletions(-)
>

[...]

> +       const struct btf_type *t;
> +       const char *tname;
> +       int err =3D -ENOENT;
> +
> +       if (start_id < btf->start_id) {
> +               err =3D btf_find_type_by_name_kind(btf->base_btf, start_i=
d,
> +                       type_name, kind);

nit: align wrapped args on the second line

also, we expect that err will be set to -ENOENT if we didn't find a
match in the base BTF, right? I'm a bit uneasy about this, I'd rather
do explicit err =3D -ENOENT setting for each goto out

> +               if (err > 0)
> +                       goto out;
> +               start_id =3D btf->start_id;
> +       }
> +
> +       if (btf->nr_sorted_types > 0) {
> +               /* binary search */
> +               __s32 end_id;
> +               int idx;
> +
> +               end_id =3D btf->start_id + btf->nr_sorted_types - 1;
> +               idx =3D btf_find_type_by_name_bsearch(btf, type_name, sta=
rt_id, end_id);
> +               for (; idx <=3D end_id; idx++) {
> +                       t =3D btf__type_by_id(btf, idx);
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, type_name))

nit: please add explicit !=3D 0 here

also, why not just `return -ENOENT;`?

> +                               goto out;
> +                       if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
> +                               return idx;
> +               }
> +       } else {
> +               /* linear search */
> +               __u32 i, total;
>
> -               if (name && !strcmp(type_name, name))
> -                       return i;
> +               total =3D btf__type_cnt(btf);
> +               for (i =3D start_id; i < total; i++) {
> +                       t =3D btf_type_by_id(btf, i);
> +                       if (kind !=3D -1 && btf_kind(t) !=3D kind)
> +                               continue;
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (tname && !strcmp(tname, type_name))

nit: let's do explicit =3D=3D 0 for strcmp, please

> +                               return i;
> +               }
>         }
>
> -       return libbpf_err(-ENOENT);
> +out:
> +       return err;
>  }
>
>  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
>                                    const char *type_name, __u32 kind)
>  {
> -       __u32 i, nr_types =3D btf__type_cnt(btf);
> -
>         if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
>                 return 0;

this is the only thing that btf_find_by_name_kind() does on top of
what btf_find_type_by_name_kind(), right? Any reason we can't merge
those and keep only btf_find_by_name_kind()?

>
> -       for (i =3D start_id; i < nr_types; i++) {
> -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> -               const char *name;
> -
> -               if (btf_kind(t) !=3D kind)
> -                       continue;
> -               name =3D btf__name_by_offset(btf, t->name_off);
> -               if (name && !strcmp(type_name, name))
> -                       return i;
> -       }
> +       return libbpf_err(btf_find_type_by_name_kind(btf, start_id, type_=
name, kind));
> +}
>

[...]

