Return-Path: <bpf+bounces-77067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F4CCE04C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5085D302B155
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C55CDF1;
	Fri, 19 Dec 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS9e04RT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777F72606
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102630; cv=none; b=ftm0NxZRu0OYsYluHECem7va2L1dyoPaT+P420bK3pk07WuWI6Ga9yKBR5dIj5+iTEjI6gjvLD39ZtWnD//2GSnuMdmFu3OCqM3RU7cdKbnL2Ug7Qh2tozS3J/2uE6lOOwPgy3TJzl4+7XWiyFC4G5y6XjF+MGDtnpMysZ2rHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102630; c=relaxed/simple;
	bh=YJe2f3ELQWyUGFUMhiVMYCoZn5L8FD/MZ/F1/8jNuNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJJOqxoP27rOpVO4nIYgRPiXmp/zP1JJQfJxVDtbdocu4YKJ+zFAzoBW0KJZlLsus2N6NajPlcC9SGaqHVRgND8bHoT53TiulKXX40R1DbEA0rqSoa7r4Ok1JaPmAAZ8biVpDfqZL5URLkZNiYgZyoTUWdHcjy+2HOiPhPSF/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS9e04RT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso890203a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102628; x=1766707428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS/+TmzAD4fFprMc4hNkIuJ5derYB1tWR7rNePa28Zg=;
        b=CS9e04RT54QbKXrMACkX63tE1n9jvisaCBbeWXFvqdsm8hfRXiIT5MjZsNgLdZyZEK
         dzx+Vaevk9j0EM1Xq4k10e5BHyqKPMnDPC9CxPgr97oK7FdV8BKkbGD0YXV57r6teM49
         ySSkRAVt1q/YiqK6k0842x7I2ID3L1fVEzPAs6/AoLErhJwHeGDWCow3sPJnsgK/Z/yW
         yibn6GcY0NpTJCrfPweFfhDRY2wHU64YAmx14jHiwE0q0niUwRBvwv6qoL+w1OWdl83I
         eBvmcr7bXVIIO8MSoWHoiPr6inaDQLHDnQgjE3jRag6laTgrhZWQtwp9ML4HDGoEsfVy
         Grgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102628; x=1766707428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uS/+TmzAD4fFprMc4hNkIuJ5derYB1tWR7rNePa28Zg=;
        b=ouLWNYPN/i5htbiF1m8H0SLdsbnC+AMSDGylkvEdpemptqnmo0aI7yK2f/9tVOca88
         8tzO6jZF/6xGZE3BVRteUtIM9T3QomuVncbMZhtTbIM0Od6jeETSOss85Wx7G5tRdbrB
         Z/ZUpjcrcX87r+kOsNUq6iqjv2uj7A3QVUUy8xaw3GBB7xq3FvaVzG6eq+fBCem7ihO3
         gCsEEc27VitfCs/jHiPpH0+mGPgvHeUhg85DDpcEKioyOqBvUIZ5+5RqkDtQrmNsiloZ
         hOSOm2o0do00uVaX/9DL8TcwO41QHicH9lSL8FlMCgJsm1/IyalKSNADN8NlkBnN9qSC
         JTVA==
X-Forwarded-Encrypted: i=1; AJvYcCWLOd5s48oJ28CgxhOKUGu6qpUW2mKdaWSqosuWCOnDyrezFrfShNi+DT8QdSiDWgeZX1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL43v4MYW9UwyeHvXB7BGO1sibw4uEgrGHlkI4cvhL+2brVdS
	wGpbpcWAnLEyur91Kbf4p8AnFScQ0v2lWl0Ne4nIEa/nqphrtl8RJuJR27ehrj9mvWadUPYqj9z
	Ic8cnVAgESCCmcZN2C+GljyOcZP4bHxw=
X-Gm-Gg: AY/fxX4Ge25sa6G7TQUWTo83EjDMnH2cjMkwNa80CwLFnU7xA87fL6IUgVCDJVNW14f
	O1j4c79ChvsmDy7JIVPxTns1kxD3pqjY4oMlNzmfUJnRtpuqFt/MX/204OJShGSjTgd/pBtrSgb
	zrdb4iNHo4v7MG2Qz81LLaoQVHuYx4+Z6fGp05w41zsiMYcP8tYVkbHOd/wGALRbvrn/yLefLdp
	8SCJfwtQ/m/pOt9yJBUVGT1oCH2EiuU/6kKOviBOCnTU5R0vqwRL9zhiSEC9x3j+yvScugCQiWE
	BuJdla4p238=
X-Google-Smtp-Source: AGHT+IF7o6GKLEzW2Qz3B+zIvKkEAJd5H64RhFSOEQEKncVi3z6pXSutk2y0skkOPPHzwyqi2XLzMR5ehynpkJ/ozy4=
X-Received: by 2002:a17:90b:548c:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34e921e8a0fmr746840a91.32.1766102628017; Thu, 18 Dec 2025
 16:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-11-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-11-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:03:35 -0800
X-Gm-Features: AQt7F2pk3q1nd28BWdlv-HrjwmIL00Lyl6u3XdHrk0G9582x7GlijOgxdYgIFw4
Message-ID: <CAEf4BzZG9i9uVSyPq=6=t7KDgxvXX6GgDkKA4fCd11Un5HQJhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 10/13] libbpf: Optimize the performance of determine_ptr_size
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Leverage the performance improvement of btf__find_by_name_kind() when
> BTF is sorted. For sorted BTF, the function uses binary search with
> O(log n) complexity instead of linear search, providing significant
> performance benefits, especially for large BTF like vmlinux.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>

nice and clean

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index c63d46b7d74b..b5b0898d033d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *btf=
)
>                 "int long unsigned",
>         };
>         const struct btf_type *t;
> -       const char *name;
> -       int i, j, n;
> +       int i, id;
>
>         if (btf->base_btf && btf->base_btf->ptr_sz > 0)
>                 return btf->base_btf->ptr_sz;
>
> -       n =3D btf__type_cnt(btf);
> -       for (i =3D 1; i < n; i++) {
> -               t =3D btf__type_by_id(btf, i);
> -               if (!btf_is_int(t))
> +       for (i =3D 0; i < ARRAY_SIZE(long_aliases); i++) {
> +               id =3D btf__find_by_name_kind(btf, long_aliases[i], BTF_K=
IND_INT);
> +               if (id < 0)
>                         continue;
>
> +               t =3D btf__type_by_id(btf, id);
>                 if (t->size !=3D 4 && t->size !=3D 8)
>                         continue;
>
> -               name =3D btf__name_by_offset(btf, t->name_off);
> -               if (!name)
> -                       continue;
> -
> -               for (j =3D 0; j < ARRAY_SIZE(long_aliases); j++) {
> -                       if (strcmp(name, long_aliases[j]) =3D=3D 0)
> -                               return t->size;
> -               }
> +               return t->size;
>         }
>
>         return -1;
> --
> 2.34.1
>

