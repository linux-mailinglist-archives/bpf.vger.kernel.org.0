Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2D322620
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBWHEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 02:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhBWHEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 02:04:48 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A1C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 23:04:08 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id f4so15466316ybk.11
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 23:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d6DASgly1oMd58PNIXa0ecpVhe9zq3yTzO1kUCZSxU=;
        b=vBlN/8z8+E5DfUPfpzBFvRRjdGEU9h2mfHeFPvGtBoNTfjbzOk9PJJ3A/gH96Skbb3
         Obju6ERswz0yZtTPgCBGema5z+H8uNXemtGIgeqEHNnDOy2wazQCuHBFRleriDM3S/cm
         xvL3bQjQdFr8tu8EM79yVJ7STpz39+eSBO5FkEnRX/vfLChB1j1Qh4+dswjQEkh/m9OQ
         qwOkYhN17z1jFghwdp2HBegdrKekVgSfndDggOHg83/QkyMZp7UeHeUebRGs3amIwRNJ
         pnPIo75vswjNLPcx0Zx4BDYjufUNUlj8cGDYnZu2cjdqT+3LG1f8scRu0UAPZDpuIeH0
         ODvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d6DASgly1oMd58PNIXa0ecpVhe9zq3yTzO1kUCZSxU=;
        b=DV+w5ju/5evKd5nIbFT5v6uy/DDvSQyQKJEvTL27zrBkp8GHLLogyz32RjtV/5OlBQ
         tMuqrHD/p8gDt7hEvIrjgAwfoQAkxrZq+ZB5eOu62C4vwGp+aU4+U3RjmeuqixpECx6I
         tzgBU80Bk2Hma6ugoTogtD5Hg9uavuONHcB0qfrwJiHDsb5ZxrGtrq9vDoF5uexnxcxB
         h8inNhbUTV1UCz1ZkyNMeE1PGumrOkK1nUijLv/3BUJPm2PkeJ3OcLCmS/51Z+JgbBD6
         MOGLzgCBX6qoW4cPCp1pEnV5LZH24ej4/wQbK/GNzU0qmYi7vWIJMmzHJIKSyKoRQpgK
         GSsw==
X-Gm-Message-State: AOAM531DNyZIwq4Mkj+aH0WNPY79xBDKBDWhQN/dujSF99lLovP4U2py
        up1OTd4yM1P6rPfDBXa2gwXK9IFSXC0E2mjuddg=
X-Google-Smtp-Source: ABdhPJySfCPOM1YFMBfFeDiVeDfAskjmFSIfEM3mY/rn41AHctnrCWEygvVdjYf4+OJLT+s2rauQE2gPV/xI6AkZV1Q=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr37543074ybi.425.1614063847565;
 Mon, 22 Feb 2021 23:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20210222214917.83629-1-iii@linux.ibm.com> <20210222214917.83629-3-iii@linux.ibm.com>
In-Reply-To: <20210222214917.83629-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Feb 2021 23:03:56 -0800
Message-ID: <CAEf4Bzav=QQwOfjQsosYWYt6YLXUV19Zswy2pddRDYgZEXCgbg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/7] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 1:50 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with BTF_KIND_CONSTs pointing to
> equally-sized BTF_KIND_ARRAYs on older kernels, for example, the
> following:
>
>     [4] FLOAT 'float' size=4
>
> becomes the following:
>
>     [4] CONST '(anon)' type_id=10
>     ...
>     [8] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>     [9] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>     [10] ARRAY '(anon)' type_id=9 index_type_id=8 nr_elems=4
>

I liked Yonghong's initial suggestion to replace it with PTR to VOID.
The only concern was that if this type was used from VAR, then
sizeof(void *) != sizeof(float) on 64-bit architectures, which might
theoretically mess up DATASEC layout. But is this a real concern? BPF
programs don't really support floats, so there is no point in
declaring float variables. I'd rather stick to a simple FLOAT -> PTR
substitution than extend generated BTF.

Alternatively, was FLOAT -> anonymous empty STRUCT with desired size
considered? Any problems with that?

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf.c             | 44 +++++++++++++++++
>  tools/lib/bpf/btf.h             |  8 ++++
>  tools/lib/bpf/btf_dump.c        |  4 ++
>  tools/lib/bpf/libbpf.c          | 84 +++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.map        |  5 ++
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  6 files changed, 142 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index fdfff544f59a..1ebfcc687dab 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -292,6 +292,7 @@ static int btf_type_size(const struct btf_type *t)
>         case BTF_KIND_PTR:
>         case BTF_KIND_TYPEDEF:
>         case BTF_KIND_FUNC:
> +       case BTF_KIND_FLOAT:
>                 return base_size;
>         case BTF_KIND_INT:
>                 return base_size + sizeof(__u32);
> @@ -339,6 +340,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>         case BTF_KIND_PTR:
>         case BTF_KIND_TYPEDEF:
>         case BTF_KIND_FUNC:
> +       case BTF_KIND_FLOAT:
>                 return 0;
>         case BTF_KIND_INT:
>                 *(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
> @@ -579,6 +581,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
>                 case BTF_KIND_UNION:
>                 case BTF_KIND_ENUM:
>                 case BTF_KIND_DATASEC:
> +               case BTF_KIND_FLOAT:
>                         size = t->size;
>                         goto done;
>                 case BTF_KIND_PTR:
> @@ -622,6 +625,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>         switch (kind) {
>         case BTF_KIND_INT:
>         case BTF_KIND_ENUM:
> +       case BTF_KIND_FLOAT:
>                 return min(btf_ptr_sz(btf), (size_t)t->size);

well this won't work for 12-byte floats, would it?

>         case BTF_KIND_PTR:
>                 return btf_ptr_sz(btf);
> @@ -2400,6 +2404,42 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
>         return btf_commit_type(btf, sz);
>  }
>
> +/*
> + * Append new BTF_KIND_FLOAT type with:
> + *   - *name* - non-empty, non-NULL type name;
> + *   - *sz* - size of the type, in bytes;
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
> +{
> +       struct btf_type *t;
> +       int sz, name_off;
> +
> +       /* non-empty name */
> +       if (!name || !name[0])
> +               return -EINVAL;
> +

check byte_sz here?


> +       if (btf_ensure_modifiable(btf))
> +               return -ENOMEM;
> +
> +       sz = sizeof(struct btf_type);
> +       t = btf_add_type_mem(btf, sz);
> +       if (!t)
> +               return -ENOMEM;
> +
> +       name_off = btf__add_str(btf, name);
> +       if (name_off < 0)
> +               return name_off;
> +
> +       t->name_off = name_off;
> +       t->info = btf_type_info(BTF_KIND_FLOAT, 0, 0);
> +       t->size = byte_sz;
> +
> +       return btf_commit_type(btf, sz);
> +}
> +
>  /*
>   * Append new data section variable information entry for current DATASEC type:
>   *   - *var_type_id* - type ID, describing type of the variable;
> @@ -3653,6 +3693,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
>                 case BTF_KIND_FWD:
>                 case BTF_KIND_TYPEDEF:
>                 case BTF_KIND_FUNC:
> +               case BTF_KIND_FLOAT:
>                         h = btf_hash_common(t);
>                         break;
>                 case BTF_KIND_INT:
> @@ -3749,6 +3790,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
>                 break;
>
>         case BTF_KIND_FWD:
> +       case BTF_KIND_FLOAT:
>                 h = btf_hash_common(t);
>                 for_each_dedup_cand(d, hash_entry, h) {
>                         cand_id = (__u32)(long)hash_entry->value;
> @@ -4010,6 +4052,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>                         return btf_compat_enum(cand_type, canon_type);
>
>         case BTF_KIND_FWD:
> +       case BTF_KIND_FLOAT:
>                 return btf_equal_common(cand_type, canon_type);
>
>         case BTF_KIND_CONST:
> @@ -4506,6 +4549,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
>         switch (btf_kind(t)) {
>         case BTF_KIND_INT:
>         case BTF_KIND_ENUM:
> +       case BTF_KIND_FLOAT:
>                 break;
>
>         case BTF_KIND_FWD:
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 1237bcd1dd17..c3b11bcebeda 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -132,6 +132,9 @@ LIBBPF_API int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz
>  LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>                                          __u32 offset, __u32 byte_sz);
>
> +/* float construction APIs */
> +LIBBPF_API int btf__add_float(struct btf *btf, const char *name, size_t byte_sz);

nit: can you please put it right after btf__add_int() and drop the comment?

> +
>  struct btf_dedup_opts {
>         unsigned int dedup_table_size;
>         bool dont_resolve_fwds;

[...]

>  static bool kernel_supports(enum kern_feature_id feat_id)
> @@ -4940,6 +5010,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
>                 local_id = btf_array(local_type)->type;
>                 targ_id = btf_array(targ_type)->type;
>                 goto recur;
> +       case BTF_KIND_FLOAT:
> +               return local_type->size == targ_type->size;

we don't enforce this for INTs, so maybe let's not do this for FLOATs as well?

But really, FLOAT is not supported by BPF programs, so we should
probably just error out on FLOAT relo.

>         default:
>                 pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
>                         btf_kind(local_type), local_id, targ_id);
> @@ -5122,6 +5194,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
>                 skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
>                 goto recur;
>         }
> +       case BTF_KIND_FLOAT:
> +               return local_type->size == targ_type->size;

ditto


>         default:
>                 pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
>                         btf_kind_str(local_type), local_id, targ_id);

[...]
