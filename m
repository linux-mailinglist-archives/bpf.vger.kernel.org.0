Return-Path: <bpf+bounces-68712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274CB81FFD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F364A59E2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AD30DD39;
	Wed, 17 Sep 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0FiPC7a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8630DD1E
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145155; cv=none; b=MTTwrjj0yO+eUX2JR4NRIkWVVHOpow+wb6rRgaRSLT7eU0ilXv1TYsikOIdzGdSbkS0FTWYwCvV+JO2gKExfyp551LQTOoX4/cbYbaxXubf4AInykoA7O47ef0itXWS2IEgA9QZwh+0kphYUVaMwYoHK/5ehPy2K3xTx7RJ/yKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145155; c=relaxed/simple;
	bh=gzknyvUO5M74I4iQK8q0uAB24YEVPTB9FuHICYpBx3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD58VlNmG9FVfhVLNGZWlZ834nv0RLcvChnuxsOsW6eoO0Bi/rEsMr09ZitIAIo1vojgF86WBTFfod23vFebsmL9RRKg8/gulKLzpEMTQrYA3etmdOmS7uIyvyGezTaG5vTVbdFw11YXF24gnz6ChnsrUexyePhKWgiBpxteip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0FiPC7a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25d44908648so3852965ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758145153; x=1758749953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsr8iZxYw8rKrs2rImHuMoO5aNph+DUNt9hqhvBJwmU=;
        b=K0FiPC7aDBWP+jz6UZtDkno8YlmKmbP4vL5IIz88ZP7MfaN/ESjMkdsN9lg38w13I3
         yX9p1rws1X0/h84L+ewR4Cywvs7QlGSYOLZiAiPhX+LlzRwWf6iKyxlZhKVoeQHtQC08
         Cld/WP/smbsQBEF5jJLvMwZRbUqarPpKbOFXt/n7pkLoYO3mPu5FB8TT9Z9Nk8aE0T+E
         T66oKWEmPRbmRbn4djoA7MQ5F0mA0DlIWZE/QbYYo7ayqLG8aTxHVlIgeMWClNnE3D6t
         filCQPMPHgs8mAJ8vZ40pJ38rDRTssttE24GNamEiCl0iE0lHdURplRr2o9AqYiu5zXD
         GqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145153; x=1758749953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsr8iZxYw8rKrs2rImHuMoO5aNph+DUNt9hqhvBJwmU=;
        b=SRqMBFBv4x/lYhYU4lz3FYlPEQxgONrAlmLA41YmdYgWse2uIEQKR4wTUy1hdxK6tZ
         GDr7ElySU/XEN81OhK9Xp/pfupSubh6SLpt4eZy53a/T7qIQg28Elw1LbE8JIYNg8Wo0
         P3e2+i/2JvqGVx43c03Q4WWBbSH63RTko3EEMgoIncDctCqSWaY5O7bGxrTIJD4pdcRg
         NyaUcTpQqHWnQsusnIW/5oL/2XTMrQ9RpyS43Qk+qPs6YA15X++m+nigLxuwxEObppC1
         Ku3vRJ5O4ZVSxGhvvZQBGWNzxF9M1sx6ef1A1BwilGJOygFzrkNcMIJD3IQYWriIbtK1
         oxhA==
X-Gm-Message-State: AOJu0YyrhLV6be0GJFaTJVO7EDB4oLTv0ht4x39lQiMC7waRjhdniGra
	jzqwa4pEzTlkFvTj6LlZTx1iiIWgIQlU4pgVtkw+68IFigCIa+mXbDN1uUNYq5Y51MI0aHvtf+p
	sb5pTvYTCdg3JBM3+AGhX4wLtbVFDMho=
X-Gm-Gg: ASbGncuqN3IkCnk4ScfrxGWWJm1orBsJcMN2ub+xiQTahNVqMs+Om6f9AeQuzun+KAL
	YWKPoGhd/9CFjykbnDEYujh972GwOuode7LJ6VFvV91jGjOllnFg5OEoPar3zP4+/r2ic/srcqm
	DV224uB9GOlt9ZRYGkXmLctD2Yn5lkFsm8N9n1WCv3Yoq72Aw+56paMnJVVH1EMKW7KAS6Dxzy0
	75A7rDOoXPJxPQeuzvSHaI=
X-Google-Smtp-Source: AGHT+IGpSq0dGAt566/Lmox3CuiYfPR2M0atrvcyvM0HZ2vE1SsS2GErzgYzSYjWFp/WSG6/eRIEC7o/NZmosRtrJUk=
X-Received: by 2002:a17:903:1b63:b0:269:8404:9a6b with SMTP id
 d9443c01a7336-26984049ba2mr5975145ad.57.1758145152598; Wed, 17 Sep 2025
 14:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-5-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:39:00 -0700
X-Gm-Features: AS18NWB-OoRYz3XKeB8EuGEntJRIgbYF37N4FLzG-DZNomYp-glze3Vs_yqF7YM
Message-ID: <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Currently, many 'BPF_MAP_CREATE' failures return '-EINVAL' without
> providing any explanation to user space.
>
> With the extended BPF syscall support introduced in the previous patch,
> detailed error messages can now be reported. This allows users to
> understand the specific reason for a failed map creation, rather than
> just receiving a generic '-EINVAL'.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 82 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 63 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e5cf0262a14e..2f5e6005671b5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1340,12 +1340,13 @@ static bool bpf_net_capable(void)
>
>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>  /* called via syscall */
> -static int map_create(union bpf_attr *attr, bool kernel)
> +static int map_create(union bpf_attr *attr, bool kernel, struct bpf_comm=
on_attr *common_attrs)
>  {
> +       u32 map_type =3D attr->map_type, log_true_size;
> +       struct bpf_verifier_log *log =3D NULL;
>         const struct bpf_map_ops *ops;
>         struct bpf_token *token =3D NULL;
>         int numa_node =3D bpf_map_attr_numa_node(attr);
> -       u32 map_type =3D attr->map_type;
>         struct bpf_map *map;
>         bool token_flag;
>         int f_flags;
> @@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>         if (err)
>                 return -EINVAL;
>
> +       if (common_attrs->log_buf) {
> +               log =3D kvzalloc(sizeof(*log), GFP_KERNEL);
> +               if (!log)
> +                       return -ENOMEM;
> +               err =3D bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr=
(common_attrs->log_buf),
> +                                   common_attrs->log_size, NULL);
> +               if (err) {
> +                       kvfree(log);
> +                       return err;
> +               }
> +       }

what if we keep bpf_verifier_log on stack? It's 1KB, should be still
fine to be on kernel stack, no?


> +
>         /* check BPF_F_TOKEN_FD flag, remember if it's set, and then clea=
r it
>          * to avoid per-map type checks tripping on unknown flag
>          */
> @@ -1363,16 +1376,24 @@ static int map_create(union bpf_attr *attr, bool =
kernel)
>
>         if (attr->btf_vmlinux_value_type_id) {
>                 if (attr->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> -                   attr->btf_key_type_id || attr->btf_value_type_id)
> -                       return -EINVAL;
> +                   attr->btf_key_type_id || attr->btf_value_type_id) {
> +                       bpf_log(log, "Invalid use of btf_vmlinux_value_ty=
pe_id.\n");

I don't know how far we want to go here, but I'd split the original
check into map type check and key_type/value_type check, and log a bit
more meaningful error:

a) btf_vmlinux_value_type_id can only be used with struct_ops maps.

and

b) btf_vmlinux_value_type_id is mutually exclusive with
btf_key_type_id and btf_value_type_id

> +                       err =3D -EINVAL;
> +                       goto put_token;

there is no token just yet, add new label for finalizing log?

> +               }
>         } else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
> -               return -EINVAL;
> +               bpf_log(log, "Invalid btf_value_type_id.\n");
> +               err =3D -EINVAL;
> +               goto put_token;

ditto about token

>         }
>
>         if (attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER &&
>             attr->map_type !=3D BPF_MAP_TYPE_ARENA &&
> -           attr->map_extra !=3D 0)
> -               return -EINVAL;
> +           attr->map_extra !=3D 0) {
> +               bpf_log(log, "Invalid map_extra.\n");
> +               err =3D -EINVAL;
> +               goto put_token;
> +       }
>
>         f_flags =3D bpf_get_file_flag(attr->map_flags);
>         if (f_flags < 0)
> @@ -1380,17 +1401,26 @@ static int map_create(union bpf_attr *attr, bool =
kernel)
>
>         if (numa_node !=3D NUMA_NO_NODE &&
>             ((unsigned int)numa_node >=3D nr_node_ids ||
> -            !node_online(numa_node)))
> -               return -EINVAL;
> +            !node_online(numa_node))) {
> +               bpf_log(log, "Invalid or offline numa_node.\n");


nit: just "invalid numa_node" ?

> +               err =3D -EINVAL;
> +               goto put_token;
> +       }
>
>         /* find map type and init map: hashtable vs rbtree vs bloom vs ..=
. */
>         map_type =3D attr->map_type;
> -       if (map_type >=3D ARRAY_SIZE(bpf_map_types))
> -               return -EINVAL;
> +       if (map_type >=3D ARRAY_SIZE(bpf_map_types)) {
> +               bpf_log(log, "Invalid map_type.\n");
> +               err =3D -EINVAL;
> +               goto put_token;
> +       }
>         map_type =3D array_index_nospec(map_type, ARRAY_SIZE(bpf_map_type=
s));
>         ops =3D bpf_map_types[map_type];
> -       if (!ops)
> -               return -EINVAL;
> +       if (!ops) {
> +               bpf_log(log, "Invalid map_type.\n");
> +               err =3D -EINVAL;
> +               goto put_token;
> +       }
>
>         if (ops->map_alloc_check) {
>                 err =3D ops->map_alloc_check(attr);
> @@ -1399,13 +1429,20 @@ static int map_create(union bpf_attr *attr, bool =
kernel)
>         }
>         if (attr->map_ifindex)
>                 ops =3D &bpf_map_offload_ops;
> -       if (!ops->map_mem_usage)
> -               return -EINVAL;
> +       if (!ops->map_mem_usage) {
> +               bpf_log(log, "map_mem_usage is required.\n");


this is kernel bug, actually, so let's log "bug: " prefix? same above
with the second "Invalid map_type." message?

and actually, given these are kernel bugs and shouldn't happen, I
wonder if we should log anything here at all?

> +               err =3D -EINVAL;
> +               goto put_token;
> +       }
>
>         if (token_flag) {
>                 token =3D bpf_token_get_from_fd(attr->map_token_fd);
> -               if (IS_ERR(token))
> -                       return PTR_ERR(token);
> +               if (IS_ERR(token)) {
> +                       bpf_log(log, "Invalid map_token_fd.\n");
> +                       err =3D PTR_ERR(token);
> +                       token =3D NULL;
> +                       goto put_token;

ditto, no token

> +               }
>
>                 /* if current token doesn't grant map creation permission=
s,
>                  * then we can't use this token, so ignore it and rely on
> @@ -1487,8 +1524,10 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>
>         err =3D bpf_obj_name_cpy(map->name, attr->map_name,
>                                sizeof(attr->map_name));
> -       if (err < 0)
> +       if (err < 0) {
> +               bpf_log(log, "Invalid map_name.\n");
>                 goto free_map;
> +       }
>
>         preempt_disable();
>         map->cookie =3D gen_cookie_next(&bpf_map_cookie);
> @@ -1511,6 +1550,7 @@ static int map_create(union bpf_attr *attr, bool ke=
rnel)
>
>                 btf =3D btf_get_by_fd(attr->btf_fd);
>                 if (IS_ERR(btf)) {
> +                       bpf_log(log, "Invalid btf_fd.\n");
>                         err =3D PTR_ERR(btf);
>                         goto free_map;
>                 }
> @@ -1565,6 +1605,10 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>         bpf_map_free(map);
>  put_token:
>         bpf_token_put(token);
> +       if (err && log)
> +               (void) bpf_vlog_finalize(log, &log_true_size);

so we'll just drop this size on the floor and never report it to the user?


a) let's either teach bpf_vlog_finalize that log_true_size pointer can
be NULL (and optional),
or b) let's report it back to user through that same commont_attrs
struct, just like we do it for verifier and btf logs?


Also, what if complicating error handling with this goto jumping, can
we make use of __cleanup() attribute to do this automatically? Then
we'd just allocate (or see above, maybe just init on the stack) log
struct, and declare it with cleanup callback that will do this
vlog_finalize and, maybe, report back the log actual size?

> +       if (log)
> +               kvfree(log);
>         return err;
>  }
>
> @@ -6020,7 +6064,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>
>         switch (cmd) {
>         case BPF_MAP_CREATE:
> -               err =3D map_create(&attr, uattr.is_kernel);
> +               err =3D map_create(&attr, uattr.is_kernel, &common_attrs)=
;
>                 break;
>         case BPF_MAP_LOOKUP_ELEM:
>                 err =3D map_lookup_elem(&attr);
> --
> 2.50.1
>

