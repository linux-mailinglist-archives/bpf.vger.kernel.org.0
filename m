Return-Path: <bpf+bounces-68944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90CB8AA31
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F76AA815D3
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0E3195F5;
	Fri, 19 Sep 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H80ojMNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAB2580EE
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300425; cv=none; b=ecCY4BwDXCfP5Up+O1eZYhiS6KWYeVHQ7cCGu2Jn/O4dwS7oXU+0R8PiTnOYuQDlJXRHS7JqvFQ3ZfZWjK5OdWmrEsRpFTl8r0FHFg86Oo1HRvxzy5hpLix6CjKP9kNpBn8t9gqmYsMh9MAysiln5romzkj7GAFCWrVEFbPCfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300425; c=relaxed/simple;
	bh=gXSPc7haTMa0yej8EF3fMKWNoG8Ou0BDC9EDyxBumL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pti6Rr4lp9cSY3OCN4NxJ4p0FoO2ncbhtfsFa7p9E2ZW5424qs/sxGpqlfsGf02aKvitC2XwWbSsX+2hWUw3w6zsXGhxAhUSw9qYAFtmS+Eo23B9eFLlLN/Gv5A2Qu6oQIe6KRMmH00H9wb/qr4W85k+XtzvZHaJR0SzlQirBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H80ojMNJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so2841745a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758300423; x=1758905223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5krzktAuO/kqQYV+CIZnUD+Pr9cuuyzlVcPhbJbNNM=;
        b=H80ojMNJf9VEbDk9dwdn4qXkpElXEWx316OSLzf8oe09tbWZm4T90e/x7fnUyb4/uV
         zxMSGhJ4onPeWdzhb4xD2XiZFgxJ4B/yTA4eHkUHGeHfq2nDPS+aBlNpf9KlMoXQ1iwU
         DPKfHdWGLn9ZUsmP0tUIxumuw8+Xk7LCxTtppOnTSYoKgqQCmyWuCQeof5PJ56rcfZlH
         +HVopQbxGROboGgnk3dllCZYMTuit5bz+sc7iN9/1GD5lTrohvTERfr3EXHOsOCmTiC3
         qtxEYXECyqp5BWAjTwluI4zQ07pqZ9D4eoN5jqOqDzLmu9llbqRyvyQ0dDWPCgGNnnDA
         u55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300423; x=1758905223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5krzktAuO/kqQYV+CIZnUD+Pr9cuuyzlVcPhbJbNNM=;
        b=wXRgWxaEHwSlqHh4ZoBN9L4p/Dd3xOKXM5p0XdlawcrW3GPLSh3LM3mqCZmqFPV31A
         q72h1iUWY0xWYPikmdM+nlC2jJnSf361B1Hx4aHRgC+TcrAzw93yVwGcHZhIq2CBjmw9
         yao0+kOKBFopdiGh6blUVL5r5QiO8X4blGkj0C5n3mMz9kil/GSF5Hjrs4TSYeBRSA4v
         ygp5m1lPm6UtdmJ8udsyU3IbyDVRO6BHz2c5vmSFjs/kd7nk4pImumaYcwr52cuwa/Dn
         jP4K+Rm4Q2OCIGmwB9Oz9qQUpakYBqLqFBfQhn2aSGjpT6lgDDV70nzUH/cMMX/hEFYH
         yi7w==
X-Gm-Message-State: AOJu0YzEDXF6RJn2Ymlrd08LNI1eDZCPU688insTbJfDKmrFXcbv5iYe
	96YfHVzMSOQAd+PVhVxjF4EHmZ/1pZVY2xXUKmfGy+ZLmZf8Z0cEt7cZV9AunSLiiabq5Kv9SB5
	kmE0mkiHr2fNc6SmqTZiE2PbB5oq5uqE=
X-Gm-Gg: ASbGncsOkItI0blafOpFK8rcxfscyKmeNyiPCL1VRxR44O8sDe82bQ6BTxGbwNHUduN
	nfGSRVG1fqAOpZ8qIGb6CE93eBeuLsJK+Wv4/6m30zwh8mjTxOdY6Iu9XrvJKxiPvooC/GhPN76
	h26HI6Tk4vLTqpbP2+KtCAdgHqQ3jfwASiQCXbJtbcbRrjjXCWoEPo0pgrAv4EGFLdHzu9T5qOn
	nTbpfkLX0sA2s8B54f+UnA=
X-Google-Smtp-Source: AGHT+IGxJhDkn1fkRVlFHH1HBRLxG33faBfAiOC6b2Ie/e6TumOT4nAo5dEZ8/wy8ox8W0/gcZ/izgFiQhhbGSuSfLw=
X-Received: by 2002:a17:90b:2cc6:b0:32e:15e9:2cbc with SMTP id
 98e67ed59e1d1-3305c5c5fe6mr10034406a91.5.1758300423156; Fri, 19 Sep 2025
 09:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919162252.174386-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250919162252.174386-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 09:46:50 -0700
X-Gm-Features: AS18NWAhOXA1eH0i1nupA2VeZilaj26zwo95N33a0lUGxme0Y783Hx3OHAJV9n0
Message-ID: <CAEf4BzafgrVHVWOO+gHRyNM2YWmqdQ6b2OoToKvADoLaG7xDDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: introduce kfunc flags for dynptr types
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> The verifier currently special-cases dynptr initialization kfuncs to set
> the correct dynptr type for an uninitialized argument. This patch moves
> that logic into kfunc metadata.
>
> Introduce KF_DYNPTR_* kfunc flags and a helper,
> dynptr_type_from_kfunc_flags(), which translates those flags into the
> appropriate DYNPTR_TYPE_* mask. With the type encoded in the kfunc
> declaration, the verifier no longer needs explicit checks for
> bpf_dynptr_from_xdp(), bpf_dynptr_from_skb(), and
> bpf_dynptr_from_skb_meta().
>
> This simplifies the verifier and centralizes dynptr typing in kfunc
> declarations, helps with future changes, adding new dynptr types.
> No user-visible behavior change.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/btf.h   |  3 +++
>  kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++--------
>  net/core/filter.c     |  6 +++---
>  3 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b..d41d6a0d1085 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,9 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
> +#define KF_DYNPTR_XDP   (1 << 16) /* kfunc takes dynptr to XDP */
> +#define KF_DYNPTR_SKB   (1 << 17) /* kfunc takes dynptr to SKB */
> +#define KF_DYNPTR_SKB_META   (1 << 18) /* kfunc takes dynptr to SKB meta=
data */
>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index aef6b266f08d..2f99097f6f51 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2297,6 +2297,33 @@ static bool reg_is_dynptr_slice_pkt(const struct b=
pf_reg_state *reg)
>                 (DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META=
));
>  }
>
> +#define ALL_DYNPTR_MASK (KF_DYNPTR_SKB | KF_DYNPTR_XDP | KF_DYNPTR_SKB_M=
ETA)

nit: call it KF_DYNPTR_MASK ?

other than that lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +
> +static u64 dynptr_type_from_kfunc_flags(struct bpf_verifier_env *env,
> +                                       const struct bpf_kfunc_call_arg_m=
eta *meta)
> +{
> +       static const struct {
> +               u64 mask;
> +               enum bpf_type_flag type;
> +       } type_flags[] =3D {
> +               { KF_DYNPTR_SKB, DYNPTR_TYPE_SKB },
> +               { KF_DYNPTR_XDP, DYNPTR_TYPE_XDP },
> +               { KF_DYNPTR_SKB_META, DYNPTR_TYPE_SKB_META },
> +       };
> +       int i;
> +
> +       if (hweight32(meta->kfunc_flags & ALL_DYNPTR_MASK) > 1) {
> +               verifier_bug(env, "multiple dynptr types declared for kfu=
nc %s", meta->func_name);
> +               return 0;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(type_flags); ++i) {
> +               if (type_flags[i].mask & meta->kfunc_flags)
> +                       return type_flags[i].type;
> +       }
> +       return 0;
> +}
> +
>  /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
>  static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
>                                     enum bpf_reg_type which)
> @@ -13277,14 +13304,11 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                         if (is_kfunc_arg_uninit(btf, &args[i]))
>                                 dynptr_arg_type |=3D MEM_UNINIT;
>
> -                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
> -                               dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
> -                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_xdp]) {
> -                               dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
> -                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_skb_meta]) {
> -                               dynptr_arg_type |=3D DYNPTR_TYPE_SKB_META=
;
> -                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_clone] &&
> -                                  (dynptr_arg_type & MEM_UNINIT)) {
> +                       if (meta->kfunc_flags & ALL_DYNPTR_MASK)
> +                               dynptr_arg_type |=3D dynptr_type_from_kfu=
nc_flags(env, meta);
> +
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_clone] &&
> +                           (dynptr_arg_type & MEM_UNINIT)) {
>                                 enum bpf_dynptr_type parent_type =3D meta=
->initialized_dynptr.type;
>
>                                 if (parent_type =3D=3D BPF_DYNPTR_TYPE_IN=
VALID) {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8342f810ad85..7baabff22656 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12228,15 +12228,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff=
 *skb, u64 flags,
>  }
>
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS | KF_DYNPTR_SKB)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
>
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS | KF_DYNPTR=
_SKB_META)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
>
>  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_xdp, KF_DYNPTR_XDP)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
>
>  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
> --
> 2.51.0
>

