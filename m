Return-Path: <bpf+bounces-68555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0DB5A40E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B737D582FEB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C8286891;
	Tue, 16 Sep 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfDLhtqO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E3238178
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058561; cv=none; b=WlTrkv5JpG1vA82ORcMsoZ28lZZAMrl1pCXNqUvq57YDk/WoMg1pU6ZvCoo9ATM8sa/pAit66rzWHdJo65Igl3+iTYPrWWqcM5NFYc6cUtZ13N9Ti3CH5kuVfkfsJLz1eWB2YkjuoTVGVs6aZXhrboUaosTChG1Flf4Ez+3GUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058561; c=relaxed/simple;
	bh=6fBESadhL1IET0gtxBgl2X85qTI3tssacf6690NlGcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIUz2r8wXvqOQsLqqLHFlrP2JRnXc2t0DJWfdmOoyZLpfheOQ1qHqgfFNH0G7qSYqK054t7RtDcn/3SR8ONiPIEPo1jKSXs9bJlQbHfQesyO2nsSyzW+mX1Vc6zmnJObDPMDdF1exZhpt2+a2csQowLez2i8Pf8EDPXnENwIUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfDLhtqO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-724b9ba77d5so59135097b3.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758058559; x=1758663359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKW9PG4acBtHXE0O1YqBDbRufb/ArPb8aZbFHILmQIc=;
        b=ZfDLhtqOS3I3yodmP3aQTXwy9G+WP+K+wgOHoQLX6iKnJDRwLQJ/TMF9d6AJ/UGtXk
         b7o2yNG40zJoUg1XnZ5JOjT2T2xVp1NS6YXZdTbGSJNMCbV1Uo6lNjrEBkUoneT3MFug
         UhrckmbWTvtPXZl+NSxZJPk4a5JwIu6M+9folYQqdFSOHiVP26KKX6wzNAEJzdxHORxy
         CrdqgvrhVjRiAUjOtgLZQNUsPy1tELEiKB0BA6x46W2QlCFye+4dLSMYCj/laaVrUiN8
         rZmgKIe/fmM0PvIMabqvgujQ3MnUASiuLacGP6PSd30GfBy5yOZL/RFjId0M5rF2cGVY
         uS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058559; x=1758663359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKW9PG4acBtHXE0O1YqBDbRufb/ArPb8aZbFHILmQIc=;
        b=kQaA3LIAtPCcFr0lpKVX/kbPqDKRZ1kbtjKKD7tLmzODCirsndAiDrM3sbGNt8SbEX
         XwhnH+XZ8SSxmYAoCA1An9EEbAL0Ls/j0qIzmmFUuuoCgo18sZQ2FJmfbGx8p6EhNZpA
         zt/7+bSRwcKNa+CEO3m5By9pI6Y3XOZ9LiSjWCICsm/dasIn2NzacAIEpz7KFX8XQRPy
         9+0OeEPT9R3Sb6Jl7XQoj1sz7pnNdFQ8TfFgMYcMBI8mXyU40gyTLOQpM8uGrPq2x969
         Db1Be2PwyyLymrdBt6xqkDUhMVPMBeLeDJ0DtEpVgau/L+1nvbHPQTEEBumOe42esZer
         oQjw==
X-Gm-Message-State: AOJu0YwgqzcIOYnBOJb5U+hP/kCWOvB1t5CqzAJruQG7gyuYC64DSK7J
	MB9j+v7O3XAr/lpMrHLO54Y2dYPoYdCfSBegX7JiG9BoB1TCrL65VRoZKyGSSPznYTnCJbVPpCz
	zZ0xcImOZBQs2nGE4lScaR6gBjGWnuZ8=
X-Gm-Gg: ASbGncvcReFvwt/f0fR45DO3IudFJltMX2NcBHptgSfxAeyKbwE1lCvX6h04h6qHzMC
	iDo8fccAHXkpP+3Cut4z0p/rnl7UQ3bs2fKd0f5NEPYBryU4BPJEPmG5FuwmVFzdyUEkPlgp7Af
	izjOuELc+i+/iLoAyKCoOnKthaMDTy6vlVmucvmMz6fINgQN60dnbz2oiacdF2H3SGm2JJj6ivV
	bLlNGw4PPYGA1M27Hw47yMeasgpr8DAag==
X-Google-Smtp-Source: AGHT+IGRpTyyS2+VsbX1QVrHVEl+EIw2Tc337NPy/QMwRZICCljAViEuJcpIYSqfVF4sRSkBCY2PbcPjnnQMQ/eiRgo=
X-Received: by 2002:a05:690c:10c:b0:71f:c7ae:fb73 with SMTP id
 00721157ae682-730659befadmr166538867b3.42.1758058559133; Tue, 16 Sep 2025
 14:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916155211.61083-1-leon.hwang@linux.dev> <20250916155211.61083-2-leon.hwang@linux.dev>
In-Reply-To: <20250916155211.61083-2-leon.hwang@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 16 Sep 2025 14:35:46 -0700
X-Gm-Features: AS18NWC9u1MQwgNrxqkH72_gRMjmAP27pXnyH20uD6cMiXnUCmmGq6bxhSwS5bk
Message-ID: <CAMB2axM2o+tr0hUJYWgPRO7sGg5rE5RSa_tW_sHY_oegi1_bbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Allow union argument in trampoline
 based programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, yatsenko@meta.com, 
	puranjay@kernel.org, davidzalman.101@gmail.com, cheick.traore@foss.st.com, 
	chen.dylane@linux.dev, mika.westerberg@linux.intel.com, 
	menglong8.dong@gmail.com, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:52=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Currently, functions with 'union' arguments cannot be traced with
> fentry/fexit:
>
> bpftrace -e 'fentry:release_pages { exit(); }' -v
> AST node count: 6
> Attaching 1 probe...
> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
> Kernel error log:
> The function release_pages arg0 type UNION is unsupported.
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>
> ERROR: Loading BPF object(s) failed.
>
> The type of the 'release_pages' argument is defined as:
>
> typedef union {
>         struct page **pages;
>         struct folio **folios;
>         struct encoded_page **encoded_pages;
> } release_pages_arg __attribute__ ((__transparent_union__));
>
> This patch relaxes the restriction by allowing function arguments of type
> 'union' to be traced in verifier.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h | 3 +++
>  include/linux/btf.h | 5 +++++
>  kernel/bpf/btf.c    | 8 +++++---
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 41f776071ff51..010ecbb798c60 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1119,6 +1119,9 @@ struct bpf_prog_offload {
>  /* The argument is signed. */
>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>
> +/* The argument is a union. */
> +#define BTF_FMODEL_UNION_ARG           BIT(2)
> +

[...]

>  struct btf_func_model {
>         u8 ret_size;
>         u8 ret_flags;
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b4..255f8c6bd2438 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -404,6 +404,11 @@ static inline bool btf_type_is_struct(const struct b=
tf_type *t)
>         return kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_UNION;
>  }
>
> +static inline bool __btf_type_is_union(const struct btf_type *t)
> +{
> +       return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION;
> +}
> +
>  static inline bool __btf_type_is_struct(const struct btf_type *t)
>  {
>         return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_STRUCT;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64739308902f7..2a85c51412bea 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>         /* skip modifiers */
>         while (btf_type_is_modifier(t))
>                 t =3D btf_type_by_id(btf, t->type);
> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_=
is_struct(t))
> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is=
_struct(t))
>                 /* accessing a scalar */
>                 return true;
>         if (!btf_type_is_ptr(t)) {
> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf=
_id,
>         if (btf_type_is_ptr(t))
>                 /* kernel size of pointer. Not BPF's size of pointer*/
>                 return sizeof(void *);
> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_str=
uct(t))
> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struc=
t(t))
>                 return t->size;
>         return -EINVAL;
>  }
> @@ -7347,6 +7347,8 @@ static u8 __get_type_fmodel_flags(const struct btf_=
type *t)
>                 flags |=3D BTF_FMODEL_STRUCT_ARG;

Might be nit-picking but the handling of union arguments is identical
to struct, so maybe we don't need to introduce a new flag
BTF_FMODEL_UNION_ARG just for this. Changing __btf_type_is_struct() to
btf_type_is_struct() here should also work.

Otherwise, the set looks good to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>         if (btf_type_is_signed_int(t))
>                 flags |=3D BTF_FMODEL_SIGNED_ARG;
> +       if (__btf_type_is_union(t))
> +               flags |=3D BTF_FMODEL_UNION_ARG;
>
>         return flags;
>  }
> @@ -7384,7 +7386,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
>                 return -EINVAL;
>         }
>         ret =3D __get_type_size(btf, func->type, &t);
> -       if (ret < 0 || __btf_type_is_struct(t)) {
> +       if (ret < 0 || btf_type_is_struct(t)) {
>                 bpf_log(log,
>                         "The function %s return type %s is unsupported.\n=
",
>                         tname, btf_type_str(t));
> --
> 2.50.1
>

