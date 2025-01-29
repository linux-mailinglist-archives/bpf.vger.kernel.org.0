Return-Path: <bpf+bounces-50050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C69A223B3
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5743A4C82
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACE1E1A20;
	Wed, 29 Jan 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY03Zad5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCF1ACEC8
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174544; cv=none; b=flqtad8CSClcnvILtd0WSfekISiGk2ClJ1iXr7NtaElD6mfB+QWu/+TuA8K53eSwgoZFJUWkj+0i1mH8CMd2cShUu49mXUWJhgFuRJif/tm+5IbQfguk3bnm1I8nZX9gskPoLpyr8ErojDJ3tGq2N6QzNq3Muh4X89l8SthelYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174544; c=relaxed/simple;
	bh=v2SiZKw8IUmu3usyNq6Lh26nZGfb4khaxeZF9tFAe0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc9hH+z1F0wmbd3YYAcsrH4VdPz1TztFEE06haIFIAui5pl4K+Eaf7nSerDASEygMWgXXZlRiKsMptJufPVukn5Ij+2y+RtRJuwKL1pPYisxmPyrjUmMd8kufKne/mut2bUP8BLvp6Emr342mjt9Hd8NafHSeq2u4YtEM2gtGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY03Zad5; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3a26de697fso10710012276.3
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738174541; x=1738779341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGiHXYg7e8z8VMa1sVF4V/w7Xn7ktfxkRf2PjsUHEV0=;
        b=KY03Zad5F2s3rbn1hifNHk26EvB+HIa/WACS8k/T20MQ46hGKAflmUeKtL8ECgqZGg
         7DWv0NHgGvBl7vO1TCYKVp+E0v/Js/qNjQAt/3QT+gpNgoIMgXNjVAKjZUxs2M8+BmBt
         gRbGzeSJdKEW1DGjLbdTl0uPySTiYWQng6EMVp1WaEOOdqCtRkLfyp5Qdb5SxllkaYQc
         WI5IHyHqr+bl3DAHeyKpZtAY273S6nIDCLfQ8rdKCiq8jI6C/qV2oyonn4Uot1sDzuNN
         62bKmwG2PatHfrYnbhP7bLTyR+jAxfh+ZKKN1XeE/F5tIguI9zOhLpiuQnpDrm5f3deG
         aBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174541; x=1738779341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGiHXYg7e8z8VMa1sVF4V/w7Xn7ktfxkRf2PjsUHEV0=;
        b=AoGDKMQEqRpoPuWsuR/RPQeJONa/Fv2N4zb/xqNQXKZuesA4b13AjBwRLeYFFPUVod
         MHrQa86pjTm+ud22v8IIcvdz8afpgX4buWjVzN4qA+Vqf1PbJpyVbeNujoF/uOEHP6cs
         S2MbqSYw3ppjxbPCOX4xqBcBB2XoHh4QAeOQmxRcT0uJrPdoaJM6Y8BiNPeNZH0xbPoc
         oOer+GoChjhcoGl43K1rvQg9gbL4TQGYeodHVPZiCOmIT6xMXBDWm48SwHWIbYNBSrjQ
         h41YYCJlk8XFW1w47LyKNep2XfOzmpZ87/20t8uIO7BQk27pb+ujGxFf0HOpAHqjgFgZ
         Im+w==
X-Gm-Message-State: AOJu0YzeaeU8//AaEXlse3Ke40zZmPfgCLeSiYrmAIf7OX6CTfI0DKdZ
	eJOIbfZ/SJkne+cHubAkqTiFquKUUOr6jaCtpaZvIamW7qf3HL7N2EVH7Kfq2/lQWzwYSwcGxfs
	HKR7RX9nnt5ygPEdZeM2QbVt13V8=
X-Gm-Gg: ASbGncu2/hHYx9kDXfN0Fnv3R60aViU083l1aSdiUZw3NP52xGeJPbpl007D0XXoUhE
	Z4zmh6a9nRpGpo0enN7g/gGzKOENiE1dTwws+8p8pocUjeWEK8Od+Xh7hhzhhdMtkRHZN7u8w
X-Google-Smtp-Source: AGHT+IF5U9/QGqPkXZk7myKWBGY03gRfRB/YaJO+h2s8Ib9LIPQcJy52H5USv1IrUQ1XIX/Qj0l4IHAnDzKaPu6ow8E=
X-Received: by 2002:a05:690c:4902:b0:6ef:57ad:9d91 with SMTP id
 00721157ae682-6f7a840711emr34227197b3.24.1738174541251; Wed, 29 Jan 2025
 10:15:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127222719.2544255-1-martin.lau@linux.dev>
In-Reply-To: <20250127222719.2544255-1-martin.lau@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 Jan 2025 10:15:30 -0800
X-Gm-Features: AWEUYZmtHV2V_NE3p1yJUhWRponrBWhf7p_SG4WIJKbHVHlK0pN8qE2zp7rb2Pk
Message-ID: <CAMB2axMhL1Q_5agCwVURiuET70XEReLmGPY4G2rcqYZNwpbUdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use kallsyms to find the function name of a
 struct_ops's stub function
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com, 
	Tejun Heo <tj@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In commit 1611603537a4 ("bpf: Create argument information for nullable ar=
guments."),
> it introduced a "__nullable" tagging at the argument name of a
> stub function. Some background on the commit:
> it requires to tag the stub function instead of directly tagging
> the "ops" of a struct. This is because the btf func_proto of the "ops"
> does not have the argument name and the "__nullable" is tagged at
> the argument name.
>
> To find the stub function of a "ops", it currently relies on a naming
> convention on the stub function "st_ops__ops_name".
> e.g. tcp_congestion_ops__ssthresh. However, the new kernel
> sub system implementing bpf_struct_ops have missed this and
> have been surprised that the "__nullable" and the to-be-landed
> "__ref" tagging was not effective.
>
> One option would be to give a warning whenever the stub function does
> not follow the naming convention, regardless if it requires arg tagging
> or not.
>
> Instead, this patch uses the kallsyms_lookup approach and removes
> the requirement on the naming convention. The st_ops->cfi_stubs has
> all the stub function kernel addresses. kallsyms_lookup() is used to
> lookup the function name. With the function name, BTF can be used to
> find the BTF func_proto. The existing "__nullable" arg name searching
> logic will then fall through.
>
> One notable change is,
> if it failed in kallsyms_lookup or it failed in looking up the stub
> function name from the BTF, the bpf_struct_ops registration will fail.
> This is different from the previous behavior that it silently ignored
> the "st_ops__ops_name" function not found error.
>
> The "tcp_congestion_ops", "sched_ext_ops", and "hid_bpf_ops" can still be
> registered successfully after this patch. There is struct_ops_maybe_null
> selftest to cover the "__nullable" tagging.
>

The patch looks good to me. Also tested with selftests in the qdisc
set and they passed.

Reviewed-by: Amery Hung <ameryhung@gmail.com>


> Other minor changes:
> 1. Removed the "%s__%s" format from the pr_warn because the naming
>    convention is removed.
> 2. The existing bpf_struct_ops_supported() is also moved earlier
>    because prepare_arg_info needs to use it to decide if the
>    stub function is NULL before calling the prepare_arg_info.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  kernel/bpf/bpf_struct_ops.c | 98 +++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 54 deletions(-)
>
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 040fb1cd840b..9b7f3b9c5262 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -146,39 +146,6 @@ void bpf_struct_ops_image_free(void *image)
>  }
>
>  #define MAYBE_NULL_SUFFIX "__nullable"
> -#define MAX_STUB_NAME 128
> -
> -/* Return the type info of a stub function, if it exists.
> - *
> - * The name of a stub function is made up of the name of the struct_ops =
and
> - * the name of the function pointer member, separated by "__". For examp=
le,
> - * if the struct_ops type is named "foo_ops" and the function pointer
> - * member is named "bar", the stub function name would be "foo_ops__bar"=
.
> - */
> -static const struct btf_type *
> -find_stub_func_proto(const struct btf *btf, const char *st_op_name,
> -                    const char *member_name)
> -{
> -       char stub_func_name[MAX_STUB_NAME];
> -       const struct btf_type *func_type;
> -       s32 btf_id;
> -       int cp;
> -
> -       cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
> -                     st_op_name, member_name);
> -       if (cp >=3D MAX_STUB_NAME) {
> -               pr_warn("Stub function name too long\n");
> -               return NULL;
> -       }
> -       btf_id =3D btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FU=
NC);
> -       if (btf_id < 0)
> -               return NULL;
> -       func_type =3D btf_type_by_id(btf, btf_id);
> -       if (!func_type)
> -               return NULL;
> -
> -       return btf_type_by_id(btf, func_type->type); /* FUNC_PROTO */
> -}
>
>  /* Prepare argument info for every nullable argument of a member of a
>   * struct_ops type.
> @@ -203,27 +170,42 @@ find_stub_func_proto(const struct btf *btf, const c=
har *st_op_name,
>  static int prepare_arg_info(struct btf *btf,
>                             const char *st_ops_name,
>                             const char *member_name,
> -                           const struct btf_type *func_proto,
> +                           const struct btf_type *func_proto, void *stub=
_func_addr,
>                             struct bpf_struct_ops_arg_info *arg_info)
>  {
>         const struct btf_type *stub_func_proto, *pointed_type;
>         const struct btf_param *stub_args, *args;
>         struct bpf_ctx_arg_aux *info, *info_buf;
>         u32 nargs, arg_no, info_cnt =3D 0;
> +       char ksym[KSYM_SYMBOL_LEN];
> +       const char *stub_fname;
> +       s32 stub_func_id;
>         u32 arg_btf_id;
>         int offset;
>
> -       stub_func_proto =3D find_stub_func_proto(btf, st_ops_name, member=
_name);
> -       if (!stub_func_proto)
> -               return 0;
> +       stub_fname =3D kallsyms_lookup((unsigned long)stub_func_addr, NUL=
L, NULL, NULL, ksym);
> +       if (!stub_fname) {
> +               pr_warn("Cannot find the stub function name for the %s in=
 struct %s\n",
> +                       member_name, st_ops_name);
> +               return -ENOENT;
> +       }
> +
> +       stub_func_id =3D btf_find_by_name_kind(btf, stub_fname, BTF_KIND_=
FUNC);
> +       if (stub_func_id < 0) {
> +               pr_warn("Cannot find the stub function %s in btf\n", stub=
_fname);
> +               return -ENOENT;
> +       }
> +
> +       stub_func_proto =3D btf_type_by_id(btf, stub_func_id);
> +       stub_func_proto =3D btf_type_by_id(btf, stub_func_proto->type);
>
>         /* Check if the number of arguments of the stub function is the s=
ame
>          * as the number of arguments of the function pointer.
>          */
>         nargs =3D btf_type_vlen(func_proto);
>         if (nargs !=3D btf_type_vlen(stub_func_proto)) {
> -               pr_warn("the number of arguments of the stub function %s_=
_%s does not match the number of arguments of the member %s of struct %s\n"=
,
> -                       st_ops_name, member_name, member_name, st_ops_nam=
e);
> +               pr_warn("the number of arguments of the stub function %s =
does not match the number of arguments of the member %s of struct %s\n",
> +                       stub_fname, member_name, st_ops_name);
>                 return -EINVAL;
>         }
>
> @@ -253,21 +235,21 @@ static int prepare_arg_info(struct btf *btf,
>                                                     &arg_btf_id);
>                 if (!pointed_type ||
>                     !btf_type_is_struct(pointed_type)) {
> -                       pr_warn("stub function %s__%s has %s tagging to a=
n unsupported type\n",
> -                               st_ops_name, member_name, MAYBE_NULL_SUFF=
IX);
> +                       pr_warn("stub function %s has %s tagging to an un=
supported type\n",
> +                               stub_fname, MAYBE_NULL_SUFFIX);
>                         goto err_out;
>                 }
>
>                 offset =3D btf_ctx_arg_offset(btf, func_proto, arg_no);
>                 if (offset < 0) {
> -                       pr_warn("stub function %s__%s has an invalid tram=
poline ctx offset for arg#%u\n",
> -                               st_ops_name, member_name, arg_no);
> +                       pr_warn("stub function %s has an invalid trampoli=
ne ctx offset for arg#%u\n",
> +                               stub_fname, arg_no);
>                         goto err_out;
>                 }
>
>                 if (args[arg_no].type !=3D stub_args[arg_no].type) {
> -                       pr_warn("arg#%u type in stub function %s__%s does=
 not match with its original func_proto\n",
> -                               arg_no, st_ops_name, member_name);
> +                       pr_warn("arg#%u type in stub function %s does not=
 match with its original func_proto\n",
> +                               arg_no, stub_fname);
>                         goto err_out;
>                 }
>
> @@ -324,6 +306,13 @@ static bool is_module_member(const struct btf *btf, =
u32 id)
>         return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
>  }
>
> +int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 mo=
ff)
> +{
> +       void *func_ptr =3D *(void **)(st_ops->cfi_stubs + moff);
> +
> +       return func_ptr ? 0 : -ENOTSUPP;
> +}
> +
>  int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>                              struct btf *btf,
>                              struct bpf_verifier_log *log)
> @@ -387,7 +376,10 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_d=
esc *st_ops_desc,
>
>         for_each_member(i, t, member) {
>                 const struct btf_type *func_proto;
> +               void **stub_func_addr;
> +               u32 moff;
>
> +               moff =3D __btf_member_bit_offset(t, member) / 8;
>                 mname =3D btf_name_by_offset(btf, member->name_off);
>                 if (!*mname) {
>                         pr_warn("anon member in struct %s is not supporte=
d\n",
> @@ -413,7 +405,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_d=
esc *st_ops_desc,
>                 func_proto =3D btf_type_resolve_func_ptr(btf,
>                                                        member->type,
>                                                        NULL);
> -               if (!func_proto)
> +
> +               /* The member is not a function pointer or
> +                * the function pointer is not supported.
> +                */
> +               if (!func_proto || bpf_struct_ops_supported(st_ops, moff)=
)
>                         continue;
>
>                 if (btf_distill_func_proto(log, btf,
> @@ -425,8 +421,9 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_de=
sc *st_ops_desc,
>                         goto errout;
>                 }
>
> +               stub_func_addr =3D *(void **)(st_ops->cfi_stubs + moff);
>                 err =3D prepare_arg_info(btf, st_ops->name, mname,
> -                                      func_proto,
> +                                      func_proto, stub_func_addr,
>                                        arg_info + i);
>                 if (err)
>                         goto errout;
> @@ -1152,13 +1149,6 @@ void bpf_struct_ops_put(const void *kdata)
>         bpf_map_put(&st_map->map);
>  }
>
> -int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 mo=
ff)
> -{
> -       void *func_ptr =3D *(void **)(st_ops->cfi_stubs + moff);
> -
> -       return func_ptr ? 0 : -ENOTSUPP;
> -}
> -
>  static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>  {
>         struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map =
*)map;
> --
> 2.43.5
>

