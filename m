Return-Path: <bpf+bounces-12486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25147CCF81
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 23:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7271C20CC0
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7942E2F50E;
	Tue, 17 Oct 2023 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRPAaQP8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795B430F4
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 21:49:40 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DEB0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:49:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so10288704a12.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697579375; x=1698184175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0ekjQIVp3S9zunYSWCPfBOiMI3XfO/hB0wsCilhAek=;
        b=TRPAaQP8befB2PAJ8hwT+Eq5yKn6Stj+fGsoqDZHNGfhzBLwza1PTuiyVlmzmfBkJK
         9atu23lQSkj+4Fg/ogpjAfKbhvFlfcZzu+hSpFioyXQRBPLWlHywn2MCIpKUw+vfxCGl
         gFXgQHED52IkLff6PPUn37ExxXkfuMyyaccb5WBKRX9brfI49OHkpcuoch2qe8FrT3H2
         cQINRJqgSbsDU+hPQT3JOi193Ua2QfRq0gUJX0ShG0Pq85ezS5b7jFTJKS22I85evbko
         K7zS7fViXZDMrfi7I8eGVJ4WPqNnbsCbbB8qb+QYzFc/yK/KX5lTBknBgtG/0JRiqV3G
         +XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579375; x=1698184175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0ekjQIVp3S9zunYSWCPfBOiMI3XfO/hB0wsCilhAek=;
        b=kfV2mA1TtqCZ7Ex3ohbiz0xP00rZFKOCBBzQb1qClP29GlyjhFhh4n+ChGLVtDtOP4
         BF1h8CGXmLYAaS+MHVNkEjv8hMJB2MJexe8h/mgq0BYLPZ1vJjmG2/OUbwfjiBFjP93y
         qYUEfaZy757Z8OIdA+2BFOWMpkWquU78FVB0rz2fvI/2T9VJb6ds6api+rJMCUT7yJ5j
         XGuIWoQapZz2NJcBociieXgGasPmhrm4ryJrPG/o748N+aeMqsC69898rzT7bK+bsPiS
         WE4NMOaMchkbHf6+cw0FeWmw9VGCSoOTB2NSbx7iUMn/7BBIFez5VYKMkkf9XZwyhCxh
         x1YA==
X-Gm-Message-State: AOJu0Ywj1JRf0U5h5AS5nrWVktBTw4QRcgc+QJGvzSLpyrewjfmpr4uz
	8u1mQ+eeUbV3Yxov0fvWANd2EZH3iZSqD/lw3J8=
X-Google-Smtp-Source: AGHT+IHhB0kNVZTVdKIQyvmuFtcOl4GicX3RGW0dfMkI0NO06nrcMq3A4eskEXTm84HX/8EaLOVotFN/vXj1l5EvxLU=
X-Received: by 2002:a05:6402:27ca:b0:53e:1825:d547 with SMTP id
 c10-20020a05640227ca00b0053e1825d547mr3054446ede.24.1697579375319; Tue, 17
 Oct 2023 14:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017162306.176586-1-thinker.li@gmail.com> <20231017162306.176586-8-thinker.li@gmail.com>
In-Reply-To: <20231017162306.176586-8-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 14:49:24 -0700
Message-ID: <CAEf4BzY9jYfK4Z7bAhmX458mZcGi+SLgGe4VK3WQYz2toOgdOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, drosen@google.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 9:23=E2=80=AFAM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Locate the module BTFs for struct_ops maps and progs and pass them to the
> kernel. This ensures that the kernel correctly resolves type IDs from the
> appropriate module BTFs.
>
> For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
> reference to the module BTF. The FD of the module BTF is passed to the
> kernel as mod_btf_fd when the struct_ops object is loaded.
>
> For a bpf_struct_ops prog, attach_btf_obj_fd of bpf_prog is the FD of a
> module BTF in the kernel.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/bpf.c    |  4 ++-
>  tools/lib/bpf/bpf.h    |  5 +++-
>  tools/lib/bpf/libbpf.c | 68 +++++++++++++++++++++++++++---------------
>  3 files changed, 51 insertions(+), 26 deletions(-)
>

I have a few nits, please accommodate them, and with that please add
my ack on libbpf side of things

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b0f1913763a3..af46488e4ea9 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -169,7 +169,8 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    __u32 max_entries,
>                    const struct bpf_map_create_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_extra);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr,
> +                                          value_type_btf_obj_fd);
>         union bpf_attr attr;
>         int fd;
>
> @@ -191,6 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.btf_key_type_id =3D OPTS_GET(opts, btf_key_type_id, 0);
>         attr.btf_value_type_id =3D OPTS_GET(opts, btf_value_type_id, 0);
>         attr.btf_vmlinux_value_type_id =3D OPTS_GET(opts, btf_vmlinux_val=
ue_type_id, 0);
> +       attr.value_type_btf_obj_fd =3D OPTS_GET(opts, value_type_btf_obj_=
fd, 0);
>
>         attr.inner_map_fd =3D OPTS_GET(opts, inner_map_fd, 0);
>         attr.map_flags =3D OPTS_GET(opts, map_flags, 0);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 74c2887cfd24..1733cdc21241 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -51,8 +51,11 @@ struct bpf_map_create_opts {
>
>         __u32 numa_node;
>         __u32 map_ifindex;
> +
> +       __u32 value_type_btf_obj_fd;
> +       size_t:0;
>  };
> -#define bpf_map_create_opts__last_field map_ifindex
> +#define bpf_map_create_opts__last_field value_type_btf_obj_fd
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a6108e3238b..d8a60fb52f5c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -519,6 +519,7 @@ struct bpf_map {
>         struct bpf_map_def def;
>         __u32 numa_node;
>         __u32 btf_var_idx;
> +       int mod_btf_fd;
>         __u32 btf_key_type_id;
>         __u32 btf_value_type_id;
>         __u32 btf_vmlinux_value_type_id;
> @@ -893,6 +894,8 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_=
Data *sec_data,
>         return 0;
>  }
>
> +static int load_module_btfs(struct bpf_object *obj);
> +

you don't need this forward declaration, do you?

>  static const struct btf_member *
>  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>  {
> @@ -922,22 +925,29 @@ find_member_by_name(const struct btf *btf, const st=
ruct btf_type *t,
>         return NULL;
>  }
>

[...]

>         if (obj->btf && btf__fd(obj->btf) >=3D 0) {
>                 create_attr.btf_fd =3D btf__fd(obj->btf);
> @@ -7700,9 +7718,9 @@ static int bpf_object__read_kallsyms_file(struct bp=
f_object *obj)
>         return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>
> -static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_nam=
e,
> -                           __u16 kind, struct btf **res_btf,
> -                           struct module_btf **res_mod_btf)
> +static int find_module_btf_id(struct bpf_object *obj, const char *kern_n=
ame,
> +                             __u16 kind, struct btf **res_btf,
> +                             struct module_btf **res_mod_btf)

I actually find "find_module" terminology confusing, because it might
not be in the module after all, right? I think "find_ksym_btf_id" is a
totally appropriate name, and it's just that in some cases that kernel
symbol (ksym) will be found in the kernel module instead of in vmlinux
image itself. Still, it's a kernel. Let's keep the name?

>  {
>         struct module_btf *mod_btf;
>         struct btf *btf;

[...]

