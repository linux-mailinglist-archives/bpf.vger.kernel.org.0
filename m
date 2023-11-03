Return-Path: <bpf+bounces-14142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF07E0AEE
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3CAB2141B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC82420C;
	Fri,  3 Nov 2023 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKuxU/q6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA824206
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:04:44 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1EED55
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:04:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d2c54482fbso401546466b.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049081; x=1699653881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTgE2eS9oykyIWjbGevy2EKuclr90Btlm3fY6muwlMs=;
        b=OKuxU/q6Tlb3vxqApA4qklU71rFcXyyKw9Q9SkCOT2FwW5lVlLOst+dJDtBx+gh+jK
         kXRfPit0wCZRWZcfexXSnKP94C/2777yp9bZGEJcLtX2Lfox5Z3YA/xZrK5XLs1jZlFy
         YzpSC344leCRpN1LDu3eYGwOG/IzcGXHxlv0kO4f7Lw3mgCtBLyge34J8qfwZZkXfJCT
         tS68LQC6jWpPKhsKKJ1v16sKPaMDp5xkGDVf86NmNWc5mtuHUrXqI7CjgtMQSfwb18qn
         e5eqv0A/8BwHtTi9Cvt3e2MoCR6nniLSNcH+NwJfeGKRjXkxm4WoSry3UmdOLExaw4b9
         Jitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049081; x=1699653881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTgE2eS9oykyIWjbGevy2EKuclr90Btlm3fY6muwlMs=;
        b=t+iCM8IW5DkC1BpWInhGFeYlSAgoC3KuROgzCk2C4bI3+exdFyvQ98LZv5XBPufz/Z
         CSBt3AzvKbQCnuuagSToP5PODWPdlghOE3McjyGsjqV/9JzjnBp/agPtOKzGbwixPXfX
         YGtJ3evNzXUFgXtqADn+KQUc2HgK/qB6HYyK/u1NLU5GAXXoksMV9G18NwI7lbNQNzDQ
         Vp1rxl5l2MD0JkTCVobnCXSgFGuFUx24TbUb0h2oVUTCusefnAjWpZ+nxsloCSPLvagM
         wJwvI6f9oiqdAaYXPhw97Mbl3FvBlxCEykjKiEa0OoKQdEe0OfGOxl0xIoYt4nrMqnsr
         6bzg==
X-Gm-Message-State: AOJu0YzArowWBeJdUV8iQMHHwWt8CnLTibfk2v76BpMomRzDyHATf36I
	6QXpu3RnSTCHZfKvZeFyc+e6oOQKChuePIjKaGP5rT6QTYs=
X-Google-Smtp-Source: AGHT+IGZSCPvXXS63WyuAVFRJye+CCRXtb91F99HZuyNCGLJ8WucDiwv5Zwww8qyjL7QLIZ/Xs30B33Ef61IkGDZlPU=
X-Received: by 2002:a17:907:7da6:b0:9a9:ef41:e5c7 with SMTP id
 oz38-20020a1709077da600b009a9ef41e5c7mr9924017ejc.8.1699049080983; Fri, 03
 Nov 2023 15:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-3-song@kernel.org>
In-Reply-To: <20231103214535.2674059-3-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:04:29 -0700
Message-ID: <CAEf4BzamOD4PgiVEroB5qBg5q4YLe=fq1-MoCombzErsrP5bPQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> ARG_PTR_TO_CONST_STR is used to specify constant string args for BPF
> helpers. The logic that verifies a reg is ARG_PTR_TO_CONST_STR is
> implemented in check_func_arg().
>
> As we introduce kfuncs with constant string args, it is necessary to
> do the same check for kfuncs (in check_kfunc_args). Factor out the logic
> for ARG_PTR_TO_CONST_STR to a new check_reg_const_str() so that it can be
> reused.
>
> check_func_arg() ensures check_reg_const_str() is only called with reg of
> type PTR_TO_MAP_VALUE. Add a redundent type check in check_reg_const_str(=
)
> to avoid misuse in the future. Other than this redundent check, there is
> no change in behavior.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 36 deletions(-)
>

LGTM. But please double check indentation and tabs vs spaces, just in case.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2197385d91dc..fefe3eafccb9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8718,6 +8718,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct=
 bpf_verifier_env *env,
>         return state->stack[spi].spilled_ptr.dynptr.type;
>  }
>
> +static int check_reg_const_str(struct bpf_verifier_env *env,
> +                              struct bpf_reg_state *reg, u32 regno)
> +{
> +       struct bpf_map *map =3D reg->map_ptr;
> +       int err;
> +       int map_off;
> +       u64 map_addr;
> +       char *str_ptr;
> +
> +       if (reg->type !=3D PTR_TO_MAP_VALUE)
> +               return -EINVAL;
> +
> +       if (!bpf_map_is_rdonly(map)) {
> +               verbose(env, "R%d does not point to a readonly map'\n", r=
egno);
> +               return -EACCES;
> +       }
> +
> +       if (!tnum_is_const(reg->var_off)) {
> +               verbose(env, "R%d is not a constant address'\n", regno);
> +                       return -EACCES;

indentation is off?

> +       }
> +
> +       if (!map->ops->map_direct_value_addr) {
> +               verbose(env, "no direct value access support for this map=
 type\n");
> +               return -EACCES;

same?

> +       }
> +
> +       err =3D check_map_access(env, regno, reg->off,
> +                              map->value_size - reg->off, false,
> +                              ACCESS_HELPER);
> +       if (err)
> +               return err;
> +
> +       map_off =3D reg->off + reg->var_off.value;
> +       err =3D map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +       if (err) {
> +               verbose(env, "direct value access on string failed\n");
> +               return err;
> +       }
> +
> +       str_ptr =3D (char *)(long)(map_addr);
> +       if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> +               verbose(env, "string is not zero-terminated\n");
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
>                           const struct bpf_func_proto *fn,
> @@ -8962,44 +9010,9 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>         }
>         case ARG_PTR_TO_CONST_STR:
>         {
> -               struct bpf_map *map =3D reg->map_ptr;
> -               int map_off;
> -               u64 map_addr;
> -               char *str_ptr;
> -
> -               if (!bpf_map_is_rdonly(map)) {
> -                       verbose(env, "R%d does not point to a readonly ma=
p'\n", regno);
> -                       return -EACCES;
> -               }
> -
> -               if (!tnum_is_const(reg->var_off)) {
> -                       verbose(env, "R%d is not a constant address'\n", =
regno);
> -                       return -EACCES;
> -               }
> -
> -               if (!map->ops->map_direct_value_addr) {
> -                       verbose(env, "no direct value access support for =
this map type\n");
> -                       return -EACCES;
> -               }
> -
> -               err =3D check_map_access(env, regno, reg->off,
> -                                      map->value_size - reg->off, false,
> -                                      ACCESS_HELPER);
> +               err =3D check_reg_const_str(env, reg, regno);
>                 if (err)
>                         return err;
> -
> -               map_off =3D reg->off + reg->var_off.value;
> -               err =3D map->ops->map_direct_value_addr(map, &map_addr, m=
ap_off);
> -               if (err) {
> -                       verbose(env, "direct value access on string faile=
d\n");
> -                       return err;
> -               }
> -
> -               str_ptr =3D (char *)(long)(map_addr);
> -               if (!strnchr(str_ptr + map_off, map->value_size - map_off=
, 0)) {
> -                       verbose(env, "string is not zero-terminated\n");
> -                       return -EINVAL;
> -               }
>                 break;
>         }
>         case ARG_PTR_TO_KPTR:
> --
> 2.34.1
>

