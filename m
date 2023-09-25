Return-Path: <bpf+bounces-10808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09127AE1FD
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D32D2816D8
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464B241F0;
	Mon, 25 Sep 2023 22:58:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683D26281
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:58:50 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C312A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:58:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b0168a9e05so679109266b.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695682726; x=1696287526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA6XEkQgOq/FHsnaCqNm9nLw1wk0J/a9DxGlG1Jzw/M=;
        b=AB4eT5mSjtPBwryKs2kg9L082iF7Ue16+cvv387jLjiWe153B068KoM3yFBJeXE5t8
         p4IjXr8FbYC4YhZjc8VyG8O5RXnTbo/YNtVuFUqmAO9zNTHwkoisvaz8RBqJRUMJOjAc
         Zy1G6bmx27cLirI425JiSiLTGquOo1Ix6K+NPNSh/QW6ZOUpOK+dZOdsJUlJgVtrpd83
         LC3cXZt+jQtdPMFhw8FBKBhhvR9AzR6DK/mgVuZ0FQOPnAIn8kjfMJmJ4X9KOvlL7ryX
         8YMeZg47amAyFhLiF0OzNdyDYDu86qW1ZDMEWbO6WnTZL2wylm7UZKEci805yC2uiYI7
         hGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682726; x=1696287526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA6XEkQgOq/FHsnaCqNm9nLw1wk0J/a9DxGlG1Jzw/M=;
        b=G9p3IinLcdU5gl4t/uv4s51Y0HkdS8YUtS02pTm1WRKUANCYDiwdQ4H1xHPhWPkO44
         goY5QGt03FuInF6Gwg/b4X6WtqiOOgtV3rZF8pgdM4+3hvH/K2+3iT9BrkIP9+bwyXAP
         jHvl11BsFGoWJDdMUKH4RZCgkWQVDUpx4lRsl0PsumgydY5CxZ+HEAbNOPKSawVDhxFi
         RyRZ5r+DdOuck7J0X3wHSVz4cmDEGwpQ8Y+2858cg1SGETDsgiDPbeDye0QhBqLRCmv3
         h4yZkpF4m8FPy2OiNdLXkMrhwy9OWvO9Y9SQbjcnPSf2xxCN4jN21tx473W1XMY0b4ez
         FSsw==
X-Gm-Message-State: AOJu0YymVGEy+WKkaLlBDruxb3F9ZieTapOKNO467iwSpmP6wS6+Bi9A
	F3vyPXSo33BhiTHb0/UpvS7c+74fSEz5ss12i4l4ULjG5Ck=
X-Google-Smtp-Source: AGHT+IEhKE7uesKSum1vgDwhQi9UucUj9mg0mTBm7qPp/np0zGtUtY8SyxhfJynxIxs3gtCujh/UHX+mad4vOzY2K1Y=
X-Received: by 2002:a17:906:da86:b0:9ae:5db5:149 with SMTP id
 xh6-20020a170906da8600b009ae5db50149mr8421424ejb.35.1695682726075; Mon, 25
 Sep 2023 15:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920155923.151136-1-thinker.li@gmail.com> <20230920155923.151136-9-thinker.li@gmail.com>
In-Reply-To: <20230920155923.151136-9-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Sep 2023 15:58:34 -0700
Message-ID: <CAEf4BzbZgR9yEGn41NeCk=sgTAUQ4N241SZBEF0359TFPnm8ag@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 08/11] bpf: pass attached BTF to find correct
 type info of struct_ops progs.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:00=E2=80=AFAM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> The type info of a struct_ops type may be in a module.  So, we need to kn=
ow
> which module BTF to look for type information.  The later patches will ma=
ke
> libbpf to attach module BTFs to programs. This patch passes attached BTF
> from syscall to bpf_struct_ops subsystem to make sure attached BTF is
> available when the bpf_struct_ops subsystem is ready to use it.
>
> bpf_prog has attach_btf in aux from attach_btf_obj_fd, that is pass along
> with the bpf_attr loading the program. attach_btf is used to find the btf
> type of attach_btf_id. attach_btf_id is used to identify the traced
> function for a trace program.  For struct_ops programs, it is used to
> identify the struct_ops type of the struct_ops object a program attached
> to.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  4 ++++
>  kernel/bpf/bpf_struct_ops.c    | 12 +++++++++++-
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/bpf/verifier.c          |  4 +++-
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  5 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..178d6fa45fa0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1390,6 +1390,10 @@ union bpf_attr {
>                  * to using 5 hash functions).
>                  */
>                 __u64   map_extra;
> +
> +               __u32   mod_btf_fd;     /* fd pointing to a BTF type data
> +                                        * for btf_vmlinux_value_type_id.
> +                                        */

we have attach_btf_obj_fd for BPF_PROG_LOAD command, so I guess
consistent naming would be "<something>_btf_obj_fd" where <something>
would make it more-or-less clear that this is BTF for
btf_vmlinux_value_type_id?

>         };
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 8b5c859377e9..d5600d9ad302 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -765,9 +765,19 @@ static struct bpf_map *bpf_struct_ops_map_alloc(unio=
n bpf_attr *attr)
>         struct bpf_struct_ops_map *st_map;
>         const struct btf_type *t, *vt;
>         struct bpf_map *map;
> +       struct btf *btf;
>         int ret;
>
> -       st_ops =3D bpf_struct_ops_find_value(attr->btf_vmlinux_value_type=
_id, btf_vmlinux);
> +       /* XXX: We need a module name or ID to find a BTF type. */
> +       /* XXX: should use btf from attr->btf_fd */

Do we need these XXX: comments? I think you had some more in previous patch=
es

> +       if (attr->mod_btf_fd) {
> +               btf =3D btf_get_by_fd(attr->mod_btf_fd);
> +               if (IS_ERR(btf))
> +                       return ERR_PTR(PTR_ERR(btf));
> +       } else {
> +               btf =3D btf_vmlinux;
> +       }
> +       st_ops =3D bpf_struct_ops_find_value(attr->btf_vmlinux_value_type=
_id, btf);
>         if (!st_ops)
>                 return ERR_PTR(-ENOTSUPP);

should we make sure that module's BTF is put properly on error?

>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85c1d908f70f..fed3870fec7a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1097,7 +1097,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
>         return ret;
>  }
>
> -#define BPF_MAP_CREATE_LAST_FIELD map_extra
> +#define BPF_MAP_CREATE_LAST_FIELD mod_btf_fd
>  /* called via syscall */
>  static int map_create(union bpf_attr *attr)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 99b45501951c..11f85dbc911b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19623,6 +19623,7 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
>         const struct btf_member *member;
>         struct bpf_prog *prog =3D env->prog;
>         u32 btf_id, member_idx;
> +       struct btf *btf;
>         const char *mname;
>
>         if (!prog->gpl_compatible) {
> @@ -19630,8 +19631,9 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
>                 return -EINVAL;
>         }
>
> +       btf =3D prog->aux->attach_btf;
>         btf_id =3D prog->aux->attach_btf_id;
> -       st_ops =3D bpf_struct_ops_find(btf_id, btf_vmlinux);
> +       st_ops =3D bpf_struct_ops_find(btf_id, btf);
>         if (!st_ops) {
>                 verbose(env, "attach_btf_id %u is not a supported struct\=
n",
>                         btf_id);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 73b155e52204..178d6fa45fa0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1390,6 +1390,10 @@ union bpf_attr {
>                  * to using 5 hash functions).
>                  */
>                 __u64   map_extra;
> +
> +               __u32   mod_btf_fd;     /* fd pointing to a BTF type data
> +                                        * for btf_vmlinux_value_type_id.
> +                                        */
>         };
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> --
> 2.34.1
>

