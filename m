Return-Path: <bpf+bounces-78785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3888D1BCE0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C6B30124C2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6C1EFF80;
	Wed, 14 Jan 2026 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQvK26Bl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DB1DC198
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350593; cv=none; b=QRH2+xNNvzhHTz093p/6gQ2pyL0PNBUn/UMj+AG9ROrrcBDKPuJTQ6rXJZ5XOuVvweSHNKsmryM2wWcuCTo+AePrK+5nCqlQe6iLv4ETuVq820TiikHAH1UABWnWyXKAK8D8pXO92dFkslW3/BHF+jeUN5H6NSEkQfRPBOwcvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350593; c=relaxed/simple;
	bh=vgfrFxA1W6DejlVlqh4bTQsya03yMspUy9lN1fpc6t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4dEB4PMbu3roPbW88sgyoPodB2D2/0w9IE/70I43gPU8bqyYh8YSE5nz2Pi0Ee8Yav4gvJTUtnRpjClYdLEvDO2n0BgOQ/YLakWEqnynGXUG4M8HwWgYA/6e1uKc5fE+xSocx40JABIXQyMnxRrnvhppml0oSjEGcmkgvZ/jlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQvK26Bl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c565b888dso6827393a91.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350591; x=1768955391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDPvpt3a95PnmgZ3LcwpoDIpq6tsxRVJYZtZJbntiyE=;
        b=hQvK26Bl0C++cpRkj794w99RQpjIKYCkL5J3JeZGPGBoQRiMTertKbhHb5gfPCiEbT
         myBRzPm5FpvwbUwmo0gvbLjJ++3bURG5+Etsr6rV62c7z22xTWVDmQ/U7wqmZ774tF1L
         HoXuk4QUVt65T/BY8GPOEw0f4U9mmswZcuXjjzUTHJWbzFmUy2IUz+ecvgBj9xvKg6J5
         sGlAw+4FVWoT1d6SAgaiVO7JsMEhD2MNOLtNeCS2hQlcbwwJiiuvyeFYh9dFP7lrmxfM
         Ua+OFBKpdISr9kkawWgZF21EBxsuQTnDjIMHKPG+PRdMwtfhmnFHCyNKzOUnXvK9cszm
         z4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350591; x=1768955391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDPvpt3a95PnmgZ3LcwpoDIpq6tsxRVJYZtZJbntiyE=;
        b=Xy9Mp1R6V1XDZndq+tFNRn5aQD1oCT86pR7iejpQFevLQknVUoCaMesIaHE0Jzxn7V
         TSYo/DwvnS+KHo1pJ89oEr9x+FCbyp3/u0bvkc+RlTLe350gAokJ5QVPgnbqrosnSa7P
         xnFr8P41zUd9ZxihFmna+rXN90ZOqqwhlJbzk8rlT79Bo+jLYBdvI4gTdFfuqrDPN2Jj
         XKqBtjWZgsA7fXdJZ042r4FeT2/66xHbNemxGQLQxYgXNhmfStGVR0quuDEfvy/76qWF
         HAU2sSZ110YJ/FJyNFJDi+4eYr0DGbBXqnCSYkrMYeK00ru3y0YC7DA0mwXy1UGA1Qiz
         GPUg==
X-Forwarded-Encrypted: i=1; AJvYcCWMAllI7ece/HGvhoJncSG6wnCpsaPpAoNMOPREXe1ATXO/QUdgbfi3oXHQ7+/ihiMwKNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYfa0JOCgX7aJGcRgvh/0Ju7vkK0kGTocGpOef6lHhhggbBFs
	0Em5PG4CJUag2NSdCheoPtrGP44ibtspfA4z8U/1oSScBMXLXAl6zuCO5ssGFlup/dknbUPcgff
	H8QvbAufGYrmEpAlE1LdJxxD9accOnY8=
X-Gm-Gg: AY/fxX6wL2Rri7X7lfNdWGYjEE1Gz26gY64Fh3376wCGJLKB8f0RVN71naQSUQZUpy7
	Cfnlv7lPOIa9T6ghfvFCpf3zHuZUyn0G7zsMtUK8pf6ZZrt61tydxRwe3PIosfIz7k2WsOZEobN
	ojC47IGYYUenZUT1aHP3ggXH1ZJ/crNz72BVEm9oTEu+v9dwlVRidJnysj5+IFovYXkw/UP9MPO
	H4ZyKVCFNpKMNh3zIAvnP3xQVHwpKrFANw46mYGYpB+gIqe0lOcQt6fMou/zqmhqK9AddpdAiWs
	AfYGDHAx+ms=
X-Received: by 2002:a17:90b:4c48:b0:341:8ae5:fde5 with SMTP id
 98e67ed59e1d1-3510b12927fmr195134a91.18.1768350591378; Tue, 13 Jan 2026
 16:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com> <20260109130003.3313716-5-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-5-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 16:29:35 -0800
X-Gm-Features: AZwV_QiG3i4aIweSU1ssSg3SgPM2wzjFOd5Tr7SJm_vEEBpT5YmLHQCyORCaqhg
Message-ID: <CAEf4BzZkNdZuSWb+G98LDSn3gL22p+g7-dHqFVH6jcqUsrKYVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 04/11] libbpf: Optimize type lookup with
 binary search for sorted BTF
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
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted types. For unsorted BTF, the
> implementation falls back to the original linear search.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 90 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 24 deletions(-)
>

[...]

>  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
> -                                  const char *type_name, __u32 kind)
> +                                  const char *type_name, __s32 kind)
>  {
> -       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       const struct btf_type *t;
> +       const char *tname;
> +       __s32 idx;
> +
> +       if (start_id < btf->start_id) {
> +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> +                                           type_name, kind);
> +               if (idx >=3D 0)
> +                       return idx;
> +               start_id =3D btf->start_id;
> +       }
>
> -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
>                 return 0;
>
> -       for (i =3D start_id; i < nr_types; i++) {
> -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> -               const char *name;
> +       if (btf->named_start_id > 0 && type_name[0]) {
> +               start_id =3D max(start_id, btf->named_start_id);
> +               idx =3D btf_find_type_by_name_bsearch(btf, type_name, sta=
rt_id);
> +               for (; idx < btf__type_cnt(btf); idx++) {

I hope the compiler will optimize out btf__type_cnt() and won't be
recalculating it all the time, but I'd absolutely make sure by keeping
nr_types local variable which you deleted for some reason. Please
include in your follow up.

> +                       t =3D btf__type_by_id(btf, idx);
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, type_name) !=3D 0)
> +                               return libbpf_err(-ENOENT);
> +                       if (kind < 0 || btf_kind(t) =3D=3D kind)
> +                               return idx;
> +               }
> +       } else {
> +               __u32 i, total;
>
> -               if (btf_kind(t) !=3D kind)
> -                       continue;
> -               name =3D btf__name_by_offset(btf, t->name_off);
> -               if (name && !strcmp(type_name, name))
> -                       return i;
> +               total =3D btf__type_cnt(btf);

and here you have a local total pre-calculated. Just move it outside
of this if/else and use in both branches

(I adjusted this trivially while applying, also unified idx,i -> id


> +               for (i =3D start_id; i < total; i++) {
> +                       t =3D btf_type_by_id(btf, i);
> +                       if (kind > 0 && btf_kind(t) !=3D kind)
> +                               continue;
> +                       tname =3D btf__str_by_offset(btf, t->name_off);
> +                       if (strcmp(tname, type_name) =3D=3D 0)
> +                               return i;
> +               }
>         }
>

[...]

