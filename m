Return-Path: <bpf+bounces-48868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A0A1143D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FFF188ACD3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F52139B0;
	Tue, 14 Jan 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+8bXRv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4C2135B2;
	Tue, 14 Jan 2025 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894269; cv=none; b=tW6MaCkttoMvIShjcd3vu0O3Hs4nSFn4zR/KT0rEmjukcUJokPZ0w/AKcY17VKR0qivyYlXcEkcxQkwj1yeuQpImR9sS5RePRT5uynzI5X1MTEpxt6CEt3aQPkXb+TnbxHV1y/7AWACvz0kEXqHvd5fSYEor239PCk2NRDwYJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894269; c=relaxed/simple;
	bh=kIIDO6mKKKsiUrHUin63T2+OnDNGMO6HD2TLecpIbzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7Pqm/ffgX7/VT3rRDp/xSFyj7NljDqYawOUAIdNWwwGKqHh1bXU3eC4pDtFWbchJLUw2as7VR2L7/ozNujoptWAwgyuB//pI8laN6ueknl38SuyWhskTqwKS3YweEWTq1wN2lTGU4J3yyknpmn46WLpDSkdRpDrqbMsx+n1dBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+8bXRv2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so8300301a91.2;
        Tue, 14 Jan 2025 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736894267; x=1737499067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZa8j2HXsGPK6Sj9LJE923ozyYtCvk9k49+qv9NqpRE=;
        b=a+8bXRv28CdquXZwCBOj8s0M0rj+r3qbuGKInq7lZLjJmu1E8AhWTshTQd2v+kiD38
         WSOWLWEAcqivGFLr79BX4zn04+EaXVxwHdDoP58bPMF0QJ1c3NNvAf3b36qEy73BOfFy
         OfOrkQeTWiNYzXeUN4RFwo182nCmfuMUXVFysBqjt0N3GiLMGauauVN2gS+/POjBiymB
         1K3yLWnilNgGV2RBjP8A8nurZLZSzs2+ydfDh0gwoW8YFbGJleo3HamF8zaxlvbSXpuw
         3c1HRlysyTIecg2TkeCEJIVj6XlpqCAeKAxv84VR9xjBpaEIuPzC0Zj6AdxAiokCvq2G
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894267; x=1737499067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZa8j2HXsGPK6Sj9LJE923ozyYtCvk9k49+qv9NqpRE=;
        b=j2uPFxwga8/ok/cTP3UOg7aO/7gsrDJ2f4LToyAr+GeAvbaIiUIpJuR7/wHdWOGaBp
         /5UR8PhG8SDFMrkd3zVIYTIUUISLK2t34m3KW9A5NlI1BQzRHvk/9v5qLnhLgneM7++H
         Go84WPYRAxl2sD8K17q7LEW4Z5RbZQ5+KKHEXwfksYNWKvyeCrLVzkHAona2B3K6fVAM
         tKAI/sZNi+RBjwRrRXqIONvCUYp3ltiP1hQ3tpsVXiI9Pc+K9Psj4rcw8SRQ/UwlJDcy
         7bknBTkB2hhZ5KQY3pRkL9+la0qMf6kn8beU/slhCpM6VanbIVN3cloOLgIu5GG7+jhY
         zdqA==
X-Forwarded-Encrypted: i=1; AJvYcCU+dAU9p11AVdKStYU1xP3/RhxqOMhBsI+6WLt52r2SYFl1A36XFbsRhvkjcT7xQZUQhawXFoTwEPDKC68=@vger.kernel.org, AJvYcCXY1gxda9lsY6DY9nsnQbkdQr7t8pvxWWHe0QRhbLr1s7+GNPGHbV4xACSoJcTbmIHA91e9GJi3H1D7c9WNxgKEjyscuOE9@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlOCbfLF8U6Z5uiEhkR0J0+z6O8MFwyNwwAqIzXVTfZIrv5pw
	h9XDtvfsKgM9IL+NhnnGILc7lR5s/J1vZsLnqgRgswjZmECr0F1dfd6/fMwOiv1xXcHFI9YBfl3
	M3WjG+L/zwKHyBjLIkcTCR20GHJE=
X-Gm-Gg: ASbGncuk9BSFAO1yrSD6km9HkyFizQAFntwrYqBpZyTCBIQADJi1iR1QPH/HqLd37uV
	UfKJURIq3Xx4M9zOgzqfl4vNNd8+vdEQwyx3t
X-Google-Smtp-Source: AGHT+IGV7xRPaRi6KD96FY//fG7Aky1D8K81ghyGU/Im23vZbtMDDEdaCJ7k4Uk5DZbXJjfkoFxYEIsS+TDe70li9bU=
X-Received: by 2002:a17:90b:534b:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f548f1cb1bmr41295749a91.24.1736894266943; Tue, 14 Jan 2025
 14:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108225140.3467654-1-song@kernel.org> <20250108225140.3467654-6-song@kernel.org>
In-Reply-To: <20250108225140.3467654-6-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 14:37:32 -0800
X-Gm-Features: AbW1kvalnJvLbe45DKyOxuDasC85kkgK546oyC53bxIqFVLe3KS6w5-ugGut84o
Message-ID: <CAEf4BzapTMSfv4afg8QnV-mX2nL8cKboXCTBwp-_cRk8ybKnQQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 2:52=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> btf_kfunc_id_set.remap can pick proper version of a kfunc for the calling
> context. Use this logic to select bpf_dynptr_from_skb or
> bpf_dynptr_from_skb_rdonly. This will make the verifier simpler.
>
> Unfortunately, btf_kfunc_id_set.remap cannot cover the DYNPTR_TYPE_SKB
> logic in check_kfunc_args(). This can be addressed later.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/verifier.c | 25 ++++++----------------
>  net/core/filter.c     | 49 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 51 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c321fd25fca3..95b0847191fe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11677,6 +11677,7 @@ enum special_kfunc_type {
>         KF_bpf_rbtree_add_impl,
>         KF_bpf_rbtree_first,
>         KF_bpf_dynptr_from_skb,
> +       KF_bpf_dynptr_from_skb_rdonly,
>         KF_bpf_dynptr_from_xdp,
>         KF_bpf_dynptr_slice,
>         KF_bpf_dynptr_slice_rdwr,
> @@ -11712,6 +11713,7 @@ BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
>  #ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
>  BTF_ID(func, bpf_dynptr_from_xdp)
>  #endif
>  BTF_ID(func, bpf_dynptr_slice)
> @@ -11743,10 +11745,12 @@ BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
>  #ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
>  BTF_ID(func, bpf_dynptr_from_xdp)
>  #else
>  BTF_ID_UNUSED
>  BTF_ID_UNUSED
> +BTF_ID_UNUSED
>  #endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
> @@ -12668,7 +12672,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         if (is_kfunc_arg_uninit(btf, &args[i]))
>                                 dynptr_arg_type |=3D MEM_UNINIT;
>
> -                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb] ||
> +                           meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb_rdonly]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_xdp]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
> @@ -20821,9 +20826,7 @@ static void specialize_kfunc(struct bpf_verifier_=
env *env,
>                              u32 func_id, u16 offset, unsigned long *addr=
)
>  {
>         struct bpf_prog *prog =3D env->prog;
> -       bool seen_direct_write;
>         void *xdp_kfunc;
> -       bool is_rdonly;
>
>         if (bpf_dev_bound_kfunc_id(func_id)) {
>                 xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(prog, func_id);
> @@ -20833,22 +20836,6 @@ static void specialize_kfunc(struct bpf_verifier=
_env *env,
>                 }
>                 /* fallback to default kfunc when not supported by netdev=
 */
>         }
> -
> -       if (offset)
> -               return;
> -
> -       if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> -               seen_direct_write =3D env->seen_direct_write;
> -               is_rdonly =3D !may_access_direct_pkt_data(env, NULL, BPF_=
WRITE);
> -
> -               if (is_rdonly)
> -                       *addr =3D (unsigned long)bpf_dynptr_from_skb_rdon=
ly;
> -
> -               /* restore env->seen_direct_write to its original value, =
since
> -                * may_access_direct_pkt_data mutates it
> -                */
> -               env->seen_direct_write =3D seen_direct_write;

is it safe to remove this special seen_direct_write part of logic?

> -       }
>  }
>
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 21131ec25f24..f12bcc1b21d1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12047,10 +12047,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct _=
_sk_buff *s, struct sock *sk,
>  #endif
>  }
>
> -__bpf_kfunc_end_defs();
> -
> -int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> -                              struct bpf_dynptr *ptr__uninit)
> +__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 fl=
ags,
> +                                          struct bpf_dynptr *ptr__uninit=
)
>  {
>         struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)ptr__un=
init;
>         int err;
> @@ -12064,10 +12062,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff=
 *skb, u64 flags,
>         return 0;
>  }
>
> +__bpf_kfunc_end_defs();
> +
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
>
> +BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
> +
>  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
> @@ -12080,9 +12084,46 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
>  BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>
> +BTF_ID_LIST(bpf_dynptr_from_skb_list)
> +BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
> +
> +static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfun=
c_id)
> +{
> +       if (kfunc_id !=3D bpf_dynptr_from_skb_list[0])
> +               return 0;
> +
> +       switch (resolve_prog_type(prog)) {
> +       /* Program types only with direct read access go here! */
> +       case BPF_PROG_TYPE_LWT_IN:
> +       case BPF_PROG_TYPE_LWT_OUT:
> +       case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> +       case BPF_PROG_TYPE_SK_REUSEPORT:
> +       case BPF_PROG_TYPE_FLOW_DISSECTOR:
> +       case BPF_PROG_TYPE_CGROUP_SKB:
> +               return bpf_dynptr_from_skb_list[1];
> +
> +       /* Program types with direct read + write access go here! */
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +       case BPF_PROG_TYPE_SCHED_ACT:
> +       case BPF_PROG_TYPE_XDP:
> +       case BPF_PROG_TYPE_LWT_XMIT:
> +       case BPF_PROG_TYPE_SK_SKB:
> +       case BPF_PROG_TYPE_SK_MSG:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +               return kfunc_id;
> +
> +       default:
> +               break;
> +       }
> +       return bpf_dynptr_from_skb_list[1];
> +}

I'd personally prefer the approach we have with BPF helpers, where
each program type has a function that handles all helpers (identified
by its ID), and then we can use C code sharing to minimize duplication
of code.

With this approach it seems like we'll have more duplication and we'll
need to repeat these program type-based large switches for various
small sets of kfuncs, no?

> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>         .owner =3D THIS_MODULE,
>         .set =3D &bpf_kfunc_check_set_skb,
> +       .hidden_set =3D &bpf_kfunc_check_hidden_set_skb,
> +       .remap =3D &bpf_kfunc_set_skb_remap,
>  };
>
>  static const struct btf_kfunc_id_set bpf_kfunc_set_xdp =3D {
> --
> 2.43.5
>

