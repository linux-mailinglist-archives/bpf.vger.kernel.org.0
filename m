Return-Path: <bpf+bounces-73538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84FC33724
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 951A34F629D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80390238D3A;
	Wed,  5 Nov 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcS9jbRY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C723185E
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301514; cv=none; b=N00h0k98Aemivxu61vkNrlbB5azG2Ks8IQE3Igqf6cbmg1cDPWlsKBchhmJrtxqE4PC9sKCNmW8CSJUbJ82myr3SAev9M8GHqIRaqT7YdgDEMtcddcZoPyiqcR/LEqjUpLIjSZDG8Hdb5YwG7dzPPR+Mn/CrgOk+V6xN7KKGiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301514; c=relaxed/simple;
	bh=egApfFk13KJcnOMuBl7XQXyD2R2emCM7KSm4uD1h+h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVN2qw2ceK13ETS+CGtkK3N88ZgzzLKA6wYNIa/iH9wLqIv4/M98fLDoJNpRbWUzn9YAic2AH0Buq+2vrt+E5BvjSV6B/M2Z9st1QidbERL/1UulU1kR9zowG/vUuXDHAHe7HxdMNyXuZWolp4zQwh1bBWG+RcOiGv/mzNtrX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcS9jbRY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294fb21b068so70202665ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301512; x=1762906312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtWfTJRPCw7anAtGgSIQB0yO/0AIyh3oLVZfL/RYThw=;
        b=VcS9jbRYDVQzoR4GdtPdyKAQiCOCgFOJxqgJsns/BDs7mjvP6v3ihOuItaldIn48gm
         sVz1vTOAzVsf0nlFKfmUkc1TOFS2oU0Lo4/RP1wQyFBiTklNuPrbDfa88aih4/ymJfAg
         tpl1m5uuSTqKLPzLElN7mTJNDYhWmB7/Wccv62UQuCCLTvGAlJ2zUm3Z1YrshJhnHgVD
         mZ2YaAzyAV2FrXNoqozQ/1uxmDVjjQCsMeH/mQ6wSL8msjcOVZTf3tdHB+4I8BEVwXc2
         kHYWMUbBk226PhGWemJToJZAJhXcrOqmq0IhwxLspdv6Y1jsLm9QMi48oeSX2vijJLQB
         hteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301512; x=1762906312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtWfTJRPCw7anAtGgSIQB0yO/0AIyh3oLVZfL/RYThw=;
        b=qK5L0Itrnxe4NAgOK+LxKEdctEpccude2RqK2UryFrZkwlwlWEvbuPRFZ0cz324BJt
         NV9z7bhRfa9JKxYsavoabi5JxdibawyIKQSotS0MqJNZ/zP27GCbSEb6RbSnLXwYZkfT
         lGGaYCiOHf764e08hhXfBvloUJnQJm9otCrSs1JdlyyAi9ZhTJLRoFrdXO5PWbdoSam4
         PD5yZd+J4w0gbk6EFs09CDeq9F4K+h4jKFGQ8Uqd4HizD32DHbwGwTREmz21QuMpOEWl
         CRJLWiuseWMVA2XL7llZDMJ1EOEJUTnE5d7sDYhWLdx2hZBoMB56MvgVFRaYMYpnahf3
         HYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXoCtbnVVHjRhjDUOv8L56LJA1RzGT/eL7fIJbhDyb5fKTnNk2UKGyZbx694/3oUjbp/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0kIwVWjyMzIpiPfgMt4LsSIaoWxIrIVUqUi2BO8iCt+ptlqJ
	KMkpwkZyNJPYG8TzrV+DTfZR7aau344+z8FrYli03PNLt1pGjOvpNb8fKXG4+ZZ9lJizDkQcxkb
	NexD2ZI2INO1UFSlxCpS5nlFqaM7y0rE=
X-Gm-Gg: ASbGncsdU5dEoZtZa097Mt6YkeIgn0wnNuZ50vDzny1iD3CVUwAk9v0bncMiP1f+iZB
	GtFS194AbfyuYMLsjO04Ou3OBC0YK98eV3rA5caV5ZRL4dwFEW3+HIkGtKoFlMt82ksYp0f0qL0
	XpGQ2108l+aYmSIF2PhwVXKlEVADtsOFZDkSjM32Rj8GMNqP3qIzcez2jZkkuSbJYpZtAf8d0kn
	Fo100TOsUkdjFIHGXmdR6iAAqL/LW7mZ4NM7gXtrrDoCON6Cr9Zkyhj48KGugpsq3UWTXcKGsw4
X-Google-Smtp-Source: AGHT+IEhjTh/ZHI4iUJDdgOVprEO3BpQW6eiDMY6bUkLMJswioiYcUn1kIFEW75KNONN2oRBsZ3KLYI3t0DN2b20NKY=
X-Received: by 2002:a17:902:da84:b0:290:a3b9:d4c7 with SMTP id
 d9443c01a7336-2962ae1098dmr18996845ad.30.1762301511853; Tue, 04 Nov 2025
 16:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-4-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:11:36 -0800
X-Gm-Features: AWmQ_blQWORGG8pOOv8yg8w-WgvnMq2ZFiRlQ9TP4A1w_-607aYq6uqmsxXVUJ0
Message-ID: <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
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
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 142 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 119 insertions(+), 23 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3bc03f7fe31f..5af14304409c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -92,6 +92,12 @@ struct btf {
>          *   - for split BTF counts number of types added on top of base =
BTF.
>          */
>         __u32 nr_types;
> +       /* number of sorted and named types in this BTF instance:
> +        *   - doesn't include special [0] void type;
> +        *   - for split BTF counts number of sorted and named types adde=
d on
> +        *     top of base BTF.
> +        */
> +       __u32 nr_sorted_types;

we don't need to know the count of sorted types, all we need is a
tristate value: a) data is sorted, b) data is not sorted, c) we don't
know yet. And zero should be treated as "we don't know yet". This is
trivial to do with an enum.

>         /* if not NULL, points to the base BTF on top of which the curren=
t
>          * split BTF is based
>          */
> @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
>         return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +/*
> + * Find BTF types with matching names within the [left, right] index ran=
ge.
> + * On success, updates *left and *right to the boundaries of the matchin=
g range
> + * and returns the leftmost matching index.
> + */
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const =
char *name,
> +                                               __s32 *left, __s32 *right=
)

I thought we discussed this, why do you need "right"? Two binary
searches where one would do just fine.


Also this isn't quite the same approach as in find_linfo() in
kernel/bpf/log.c, that one doesn't have extra ret =3D=3D 0 condition

pw-bot: cr

>  {
> -       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       const struct btf_type *t;
> +       const char *tname;
> +       __s32 l, r, m, lmost, rmost;
> +       int ret;
> +

[...]

