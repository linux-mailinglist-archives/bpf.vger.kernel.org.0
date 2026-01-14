Return-Path: <bpf+bounces-78786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A6D1BCEF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64913054671
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF71FE47C;
	Wed, 14 Jan 2026 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYvqrdiS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1451F4CB3
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350598; cv=none; b=YvthdwAAntUI91vGKXNTHeQL8MJB9Nexj18fqTEIbYnKWGhriyvup405vl4vNqngBe/NKQCLkuCBr3G7l0sLSdIiAr8vC7crB7psi5LM2T2iAhIlpMXv2Jg8VQiHDSbBE2eMdBi7+CPFMoLmLWXoBJZy8Hbw8Xp+G+jKiBqr5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350598; c=relaxed/simple;
	bh=PUTgKiVFSN6ExjlByifSwhCRINk8/iTXr8SpFcDj44c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjJVfYVRW9eVmVjok2xktkHWdO9jbFXJ3RAuHs0/VmTzUrTJNY6m2hEb0qW2YQJ/2sb6e2oyop9Wn0xENjnqQd2giVE82imLcwdla/k2Zghd5jd5I7NzDwyCGB08BX+9PdFxTh9065UgarbFVGTsTc5bsp2YwWX7tC9vniVLIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYvqrdiS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34f0bc64a27so3855645a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350596; x=1768955396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ9/6Mvd6LyQNxjCnzKcQY+IfvT/HFW90+0QjS/Hhns=;
        b=XYvqrdiSiuMhHagbgN2yGegfFewLKnpYUNdLZpqycf9SzATCIAtxAU54PAsE1ljSKv
         U/rGhcEf7zw7kDe76RY0jiaAad8+kuUFaXjl1T0+OnyJPQjzO7UckrCfFTidLTCCZbuQ
         2SjDYtnZgstulXoagfOPRGlOzgKbaQx/mlMu0nsPXOiUfG+bs39FJi4M4U5VkkyJrGqd
         zlkPijcIvIdch0QS/kELBWlgPXCxwwN6PF0BSIAGBOb1t6OFj8o/BlO8zbzHKemk8xG5
         vbAP6KaGq6yxNlxyEPNqwixn0/LLxsTtv915C7qkkNvPcktG5osz8XejF+YFTzt1a/kv
         6YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350596; x=1768955396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZ9/6Mvd6LyQNxjCnzKcQY+IfvT/HFW90+0QjS/Hhns=;
        b=CGcew+/QLqSMzq4xU/PXNhjgrP5AaMz3IrjvdK5HFHq2gRR0jbZx9qtfsJsvA83ASp
         PGg+V1P4xNR9BcoifeJCnSmD806o2t04GtxYQWtxfskhKbLWMjYOViTmIHwPwwbonJig
         JB5SoBwln5x43jp0hM0Q4ptp2OCrse5IBYzQUPwIsdeA7qibKsev3KTQjwzbA/yHlAJr
         dGtoXbK5ope1oj5Wy0xh3q0QluWSgn8C72JHwZSD+dZJORIwZhdVpYjhSZ0CSgKVG95G
         i1JxYhPSLxMHirls1tw08Ejn7zPxza+UxMiADKYpWC6wo8WPM1EMe2JP81YS8pERhy7N
         19gg==
X-Forwarded-Encrypted: i=1; AJvYcCXEEV61F5SzJprS86U+/ujgxGHwk19VtD0l28KytKE9lIku5J07SApMi+FXwKzM6w8coaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ga3w/3F0BJyWqGSYlYwBdFOX8bBjRWqTGFZp2ygPqjGUdht0
	2kv1Qh9Zi4t/1VcKu9u7DmKpXajRGKIGH7ZTtDZd7/vzTRhFZ/Lvmydl1HzR1O8PTknlslG7uuW
	2pUAkgDd+fYU0NOSXcrB9ByFVLaC47T4=
X-Gm-Gg: AY/fxX4zVNFvMCN+05cP5FqmxBSrbolAWFGtP0lEEnYjVtqQ5X5krizc0snw2QI3S1P
	8ubuJGYHNHWn7sLONvfrkE1gss30qJafIwnL4TMniDs+ojxGebGpXsRWO6a37oCkEaHs0at9UNy
	ZijaR1G6WJBuF+1L57KdrpRK0rODez+GDh8tlYFmkvIk+7fgMOiEoj1YslnFL4vpehZ4Y55tFcf
	rBp2Iw+McTVPfXAqcDa2IM3iIO7ira5g9mUjzhQKUuPQFCbLGzeuaZR18rM0Q+19+6AQvWs4pEA
	MEz9+VEkkHE=
X-Received: by 2002:a17:90b:4c45:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-3510913e893mr752865a91.28.1768350596242; Tue, 13 Jan 2026
 16:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com> <20260109130003.3313716-7-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-7-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 16:29:39 -0800
X-Gm-Features: AZwV_Qh5GzO6V-KNHQjmthp7HOfIbiXd_hYZ5RNTyJ9mavjxX3gj5KFIaPhR6zA
Message-ID: <CAEf4BzZfm=AxAC6TB_OLcKZeH=M=Z=AFftSoCZg-pJ7ChQyZYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 06/11] btf: Optimize type lookup with binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> Improve btf_find_by_name_kind() performance by adding binary search
> support for sorted types. Falls back to linear search for compatibility.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  include/linux/btf.h |  1 +
>  kernel/bpf/btf.c    | 91 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 83 insertions(+), 9 deletions(-)
>

[...]

>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
>  {
> +       const struct btf *base_btf =3D btf_base_btf(btf);
>         const struct btf_type *t;
>         const char *tname;
> -       u32 i, total;
> +       s32 idx;
>
> -       total =3D btf_nr_types(btf);
> -       for (i =3D 1; i < total; i++) {
> -               t =3D btf_type_by_id(btf, i);
> -               if (BTF_INFO_KIND(t->info) !=3D kind)
> -                       continue;
> +       if (base_btf) {
> +               idx =3D btf_find_by_name_kind(base_btf, name, kind);
> +               if (idx > 0)
> +                       return idx;
> +       }
>
> -               tname =3D btf_name_by_offset(btf, t->name_off);
> -               if (!strcmp(tname, name))
> -                       return i;
> +       if (btf->named_start_id > 0 && name[0]) {
> +               idx =3D btf_find_by_name_kind_bsearch(btf, name);
> +               for (; idx < btf_nr_types(btf); idx++) {

same nit about inconsistent btf_nr_types() usage between two branches:
compute once early and use in both branches

(fixed up similarly to libbpf implementation; also fixed up comment style )

> +                       t =3D btf_type_by_id(btf, idx);
> +                       tname =3D btf_name_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, name) !=3D 0)
> +                               return -ENOENT;
> +                       if (BTF_INFO_KIND(t->info) =3D=3D kind)
> +                               return idx;
> +               }

[...]

