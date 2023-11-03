Return-Path: <bpf+bounces-14143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CF7E0AF3
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9F4281F5C
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014842420F;
	Fri,  3 Nov 2023 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4ko1I2d"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CC24209
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:07:25 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1ED6B
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:07:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4237901a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049242; x=1699654042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAOEeYu9Y5b58jCwpGeHFSWpd6B5Ki35hB3NAClanDs=;
        b=K4ko1I2dkoeAHHpqdwY9kAr5okIoZhrbXDk8DVM89RFNVd+RLOYJ4jOvT4ZtP3cXMT
         4cvfnqcZb7XeXcbsZ5ZbSDv/kBssa+6Kbj5hwwXCuamGVdTjo5eqyx1CoZ9lPL1j8kI6
         LlW/sZ42hYFkbC5/YfKkA2CX2Tz2/jMN9ZL8e0netJHXTSvd26DinxEIMtXO4PEHLclL
         2LOgkRD0vhez4eni67gqn46uAQzLuxbeaTsSzklAgtVlWWH9V0qU1mjS5QH+Z6QUPo95
         Gbz/jnEsQXaXhZrrxEswsoTliH1jXEk5ntsJ8sBggi+Y0YKV6HU8uzSQKLWpztyzI0W4
         X+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049242; x=1699654042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAOEeYu9Y5b58jCwpGeHFSWpd6B5Ki35hB3NAClanDs=;
        b=wt2pVwWVpLX7jDMfU/kviGDnwEIiqNdc1Y6ISwfJV80gaTq29Tai27kbDLuLkLzBWd
         EptrSp2hkUfp1Hwqp4mgonif3rT9+evdcByut+s3Ar6DgYjlfqc8Px1AHYai/pjGpf4G
         4iYaZMzz6MKVy77/PWX5cefjcL50/jcBFsDV0x8+cs3miEf44qEBp3XvgKy+6bbSU1ht
         3j6dMhcWyj7KuA0zclDNZJsgxphGyP3LOq/S1kgdA54dv6th9Zqg+Gq8Tcyahu74tCy3
         HxQ/slMv7ZCgXXblgQylzGGgv448YyY+rjgQU2lWqoPor3SXahhNTj4NOJoPC6UnURYw
         kZew==
X-Gm-Message-State: AOJu0YxLqwG9ZaFCA33kUEfMjVpJWZoruIiS7jhKAscN8roKOm4u8MF7
	8jGO6mDhm3+g42PMcWfTz5KyAIgOFAeauFa/LUI=
X-Google-Smtp-Source: AGHT+IEEqBakZImmRNxFwt5EuhT7UQQz7k7ryZ78AvzBVKojbm/oN3zGreLMEdbDQuxm3fbja3hrIQ8zyZtlPv1qg1o=
X-Received: by 2002:a17:907:2d2b:b0:9b2:a7db:9662 with SMTP id
 gs43-20020a1709072d2b00b009b2a7db9662mr9245859ejc.12.1699049242163; Fri, 03
 Nov 2023 15:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-4-song@kernel.org>
In-Reply-To: <20231103214535.2674059-4-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:07:11 -0700
Message-ID: <CAEf4Bza2WO4y75ffU0F9XOYXebjfZ=Zp=K0VUZc0UAirPPmdBw@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Similar to ARG_PTR_TO_CONST_STR for BPF helpers, KF_ARG_PTR_TO_CONST_STR
> specifies kfunc args that point to const strings. Annotation "__str" is
> used to specify kfunc arg of type KF_ARG_PTR_TO_CONST_STR. Also, add
> documentation for the "__str" annotation.
>
> bpf_get_file_xattr() will be the first kfunc that uses this type.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
>  kernel/bpf/verifier.c        | 19 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0d2647fb358d..bfe065f7e23c 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -137,6 +137,30 @@ Either way, the returned buffer is either NULL, or o=
f size buffer_szk. Without t
>  annotation, the verifier will reject the program if a null pointer is pa=
ssed in with
>  a nonzero size.
>
> +2.2.5 __str Annotation
> +----------------------------
> +This annotation is used to indicate that the argument is a constant stri=
ng.
> +
> +An example is given below::
> +
> +        __bpf_kfunc bpf_get_file_xattr(..., const char *name__str, ...)
> +        {
> +        ...
> +        }
> +
> +In this case, ``bpf_get_file_xattr()`` can be called as::
> +
> +        bpf_get_file_xattr(..., "xattr_name", ...);
> +
> +Or::
> +
> +        const char name[] =3D "xattr_name";  /* This need to be global *=
/
> +        int BPF_PROG(...)
> +        {
> +                ...
> +                bpf_get_file_xattr(..., name, ...);
> +                ...
> +        }
>
>  .. _BPF_kfunc_nodef:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fefe3eafccb9..6d382f20674d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10803,6 +10803,11 @@ static bool is_kfunc_arg_nullable(const struct b=
tf *btf, const struct btf_param
>         return __kfunc_param_match_suffix(btf, arg, "__nullable");
>  }
>
> +static bool is_kfunc_arg_const_str(const struct btf *btf, const struct b=
tf_param *arg)
> +{
> +       return __kfunc_param_match_suffix(btf, arg, "__str");
> +}
> +
>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>                                           const struct btf_param *arg,
>                                           const char *name)
> @@ -10946,6 +10951,7 @@ enum kfunc_ptr_arg_type {
>         KF_ARG_PTR_TO_RB_ROOT,
>         KF_ARG_PTR_TO_RB_NODE,
>         KF_ARG_PTR_TO_NULL,
> +       KF_ARG_PTR_TO_CONST_STR,
>  };
>
>  enum special_kfunc_type {
> @@ -11090,6 +11096,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>         if (is_kfunc_arg_rbtree_node(meta->btf, &args[argno]))
>                 return KF_ARG_PTR_TO_RB_NODE;
>
> +       if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
> +               return KF_ARG_PTR_TO_CONST_STR;
> +
>         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[bas=
e_type(reg->type)])) {
>                 if (!btf_type_is_struct(ref_t)) {
>                         verbose(env, "kernel function %s args#%d pointer =
type %s %s is not supported\n",
> @@ -11713,6 +11722,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                 case KF_ARG_PTR_TO_MEM_SIZE:
>                 case KF_ARG_PTR_TO_CALLBACK:
>                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> +               case KF_ARG_PTR_TO_CONST_STR:
>                         /* Trusted by default */
>                         break;
>                 default:
> @@ -11984,6 +11994,15 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                         meta->arg_btf =3D reg->btf;
>                         meta->arg_btf_id =3D reg->btf_id;
>                         break;
> +               case KF_ARG_PTR_TO_CONST_STR:
> +                       if (reg->type !=3D PTR_TO_MAP_VALUE) {
> +                               verbose(env, "arg#%d doesn't point to a c=
onst string\n", i);
> +                               return -EINVAL;
> +                       }
> +                       ret =3D check_reg_const_str(env, reg, regno);
> +                       if (ret)
> +                               return ret;
> +                       break;
>                 }
>         }
>
> --
> 2.34.1
>

