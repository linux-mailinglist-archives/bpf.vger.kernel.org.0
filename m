Return-Path: <bpf+bounces-75107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C836C70E67
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 20:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7418B4E1D8A
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8898371DF9;
	Wed, 19 Nov 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+kUnErw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174F348865
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581842; cv=none; b=keElA8Ig2DjUCVlvw+OISuZz+OGnWLQJNSR42ghl2/w+WmB3JAIqumlxFALwatx3xMBnqIy4NBuPelOXDcRXs7IrkDQu5wpepH/t7mMK7Lca/UccgHwGQxRbQpJiay3cz9CnJqeFW2ewCcKukp1li4OBFGRiJKWf8WjmZP3K4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581842; c=relaxed/simple;
	bh=XEiVZypuIrdWVSdJAQwrhrWG2Cpziq1gj3kBNsA1h6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjY3hWBSYyhT/qe5VX2xVj1XWiS0M6f3aUOfQD58aSnUDQHoeulhhA6SUWP9EiK4WaS/bT1lPCCX/NCNh+gfBEcBIqKckwZ9Dy54nLEkdTWSkCqs35zUd994kY4ZP/bb4Pv70daOsDd2DWwfs0xSFnnMDP22sAt2Wuew9BjQIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+kUnErw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34585428e33so34105a91.3
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763581840; x=1764186640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toMLiHC2ccBpYt1K8vCHCNPZFkfzM5CXmueQjOky0ZE=;
        b=N+kUnErwjCwXh8UZJ9EvbK4Bp5CP8yzjO3UU6mxlR8YaklX78rMsd+ITSvunpu/7TK
         a20NIiXwaaAU69mGyYXWdpQJxm2WRV+wwRBBkodqXbZeiQNmRVkOg1FljW5SZYluSkCf
         hN0BeTuCrfDuXZcnakoug3/4zffWd/GRPEQlnLpHj+t7sUWBblK0Bzf4qWfNUOL1CME6
         QNCiFmSzVPePWHNd0FJ3vz8gq6hO6GvVPyLgsrwzJgsc2OiBZZ0KgHPX+3ZiWyY7/5s4
         7lRoss0SvTVWV+mjJ8yP3pPGdNHvJ6nlvUnguAin/UoYO3V2sN5FQcYdGEFJVqGu9A7v
         V6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581840; x=1764186640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toMLiHC2ccBpYt1K8vCHCNPZFkfzM5CXmueQjOky0ZE=;
        b=RLDbleI91WLWunYdBCA5sRzDBy7Zg6VGKdU3PLHUD+raBr/lRvqVGb+nzAOROCfunC
         mlM0y0l2W7/eD7KYKs4H0Yjl611WTbcJrWtHhCwYQOrSMaEeRO59iXLzK/KDjxwm9ZzJ
         /0SMGwsjc2VgPx4VYGHy9dcGLbo+OCmSeL9agXyQlwH7XrbdAXY/n3uhM04GKXbPxA/e
         +L65fDpg9u/pJaSHkk9OnaW5K1fHIkn4piRQQk9vUBoBV3Uvl2mDWzY2kt9bILt7sOW6
         C8Nkm7vTjGbcevric/lX2GWWIjnpD+yS2G3W9lByucHiRz0r4QTR0c4Df/y/1oZRXAQe
         80YA==
X-Forwarded-Encrypted: i=1; AJvYcCUoU+yeDi6YbUUeTJzt3M/CLouEavkBZWm/KwZYt1HZ73RXxtDmDetHCjLYUJR7zBj9o9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2k7BPZoRQ7VJWifVkkh0rTZYr33+ctxRBu1/gIvEm2LyvUz4
	vMlyaUIFwmPLikuLf8QHdNaBIuTA92DgJbav9RZeCBfD6vd1JekL91ARA1ZKlC7UMYQ/SoQFylR
	8xKksUqSHT42NAL2/VXoQvqEOVstv5mI=
X-Gm-Gg: ASbGncuTnkOyjZQScFywNdB7rNhdY9moIkkNE7sJaYqJDMdW66FuKeKgTDQGZvW9MLZ
	36Fy0YcEiiZS0zlLF0dNBTa+z9ZSeT0IKFfKGx4MotBPH6U2ojo5fUhrJ3ptKFikIh2TgG7vOnx
	K/YCRl8SA4saeqpBGVFlw1UZmERcJmM/hsiOGz0efrG+lnm3DUGEp5+T3lVLyPxcOYNg7IdDNP4
	MEyOG7IugYBtjh/glyG1H5YsXfNbC9/kKDQKeO2J6/q+rbUwO7TipwXPZVGJlIGg57Ys9WG6F8r
	SboFK92G7ZQrCgXrlm7G1A==
X-Google-Smtp-Source: AGHT+IGPIzhWDQKVayD2OOX1Q8gyY8HHW+NagxWlTtoNzhT3VkU2L0XEomrq+J11lFcMVSu8NxoJV6ZcliQttmfbWaE=
X-Received: by 2002:a17:90b:35c8:b0:340:ff7d:c2e with SMTP id
 98e67ed59e1d1-34727c5a420mr303936a91.29.1763581839724; Wed, 19 Nov 2025
 11:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com> <20251119031531.1817099-6-dolinux.peng@gmail.com>
In-Reply-To: <20251119031531.1817099-6-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Nov 2025 11:50:27 -0800
X-Gm-Features: AWmQ_bnI8xYKLex_FU_0RFx44vOSOg5OzCo8eiVpoAetNtA0Lg64XnRo2bb_sC0
Message-ID: <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
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
> This patch adds validation to verify BTF type name sorting, enabling
> binary search optimization for lookups.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 1d19d95da1d0..d872abff42e1 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>         return type_id;
>  }
>
> +/* Anonymous types (with empty names) are considered greater than named =
types
> + * and are sorted after them. Two anonymous types are considered equal. =
Named
> + * types are compared lexicographically.
> + */
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +       struct btf *btf =3D (struct btf *)priv;
> +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +       const char *na, *nb;
> +       bool anon_a, anon_b;
> +
> +       na =3D btf__str_by_offset(btf, ta->name_off);
> +       nb =3D btf__str_by_offset(btf, tb->name_off);
> +       anon_a =3D str_is_empty(na);
> +       anon_b =3D str_is_empty(nb);
> +
> +       if (anon_a && !anon_b)
> +               return 1;
> +       if (!anon_a && anon_b)
> +               return -1;
> +       if (anon_a && anon_b)
> +               return 0;

any reason to hard-code that anonymous types should come *after* named
ones? That requires custom comparison logic here and resolve_btfids,
instead of just relying on btf__str_by_offset() returning valid empty
string for name_off =3D=3D 0 and then sorting anon types before named
ones, following normal lexicographical sorting rules?

[...]

