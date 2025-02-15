Return-Path: <bpf+bounces-51637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F07A36B7F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2182F3AE6A7
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9A13CA9C;
	Sat, 15 Feb 2025 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8gftEK3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126CEACE
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587702; cv=none; b=rpmLjPNbGEsjl5DN6YBNKW7qGIeyjEkW0DcmyZZ4phlh6H1zor52U8lQOF+qvRcHG4rFECrl312OrJm5jVbjgi8QEuVKqqHOgfJ7MeBYw6jNPF2mNpfRwSNaTwgYsROikoW1tuui5/Ub19SpYupg4g8CVW5BudJ3TJY3dwkTeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587702; c=relaxed/simple;
	bh=yVmYgeaWxYsuMMDWKR6NTOvo64zucfGfCivFHU5n4C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaXqTTOq6rOs6arHOuQlWrGhsJFRFG4c6J4Na/POlpnTuuc0MjtIpO9VBDPW2XBFFfaW2S06VBBk8xU0oigHs3H/fQrCQ2VyyT3VLNFh/UT9ti+efPV26JieTpIbgWnZe9lzmi+YHGcePOqa2lmjY7CNM6w2wD8hfENreuy0JSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8gftEK3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso1523457f8f.1
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 18:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739587698; x=1740192498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oR4Jz89VJ2ERrsEZOTehYBu0ZayI5TJyS4IoDijubg=;
        b=A8gftEK3xu87ph3S/oYFrTjBO4oplQa4O0qzlpNq9uO8AbkCWIuhcrJg0AxG3wb9gx
         vfr6w3fLE+4dNDH9UrgDoRY7vLPIvTbfprqy311ch2G1rcYaofwFYwgI28Rriui+64JS
         M56mPANaxAYPrpYKjSHTh7ubtGKX0jhs+RzU/8mKCQRZbSQ77E4iw3bu1xXloxhu6xy9
         ienrNslqFcI9fp/LM3M1tRzDhb8ItSt3pH+U1EPODr6J8bIQQS32cwnlK32CawlxcJQE
         ohXQ2lRPfCVLEWa2FGHGo69dSR5UU56W8atyatn1qfIp0dKLFBwLvHnbmShosLDNZ0Rp
         Yimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739587698; x=1740192498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oR4Jz89VJ2ERrsEZOTehYBu0ZayI5TJyS4IoDijubg=;
        b=gjPnrvanwHdNJDWe6C5Tv5WWQdsLi9kZ9kB5wwuL3piXdWKLpD0/nlbiKrK7C1Q/Yl
         qjP2cQgiaD4J4viQ+8qqrUsI1edsArzZCkHKbFRBDvv3LLNbZFQaR+h7cjdKJ9acJlSx
         2/ikM/Uu5FXzCOWOui9iw9S0DpVG/YB2hyEUKjq9OxG6YbPhIhraFZHlTJk7LOwW9neW
         21Aw2mHBaek2hlH4MaO2NEG9qmjYckMdPNLe6XT/KO+3ugbGGBV06dKfpjyPw++wZHPt
         ibX93YsQZ5YMApdFD45Cu5U1eYw9mnCQ4H0DtKe4CXJLSeGBUg7ldAvJXB+DBTni6FtB
         Xo9Q==
X-Gm-Message-State: AOJu0YyuIbs3kjVHr+RNBDNKgtDxQLkBvz5oLZFaV+p6JUco5jM5i5Le
	OXKOJVSGqPfuURX7IS01mb6QTFTVlY1CgtziCtKie21jdv6vqBg9hVKIXPDDM5DubG0shZcTLGk
	POtNltUxsOuGOvwyEc3+aesc8p/I=
X-Gm-Gg: ASbGncsJKOQYcQcSyuo9d5jes1ZIrjESdqlANcvYNXEuVtT6WLGDnB3zt0IS6Heg2rB
	XnkP41gzzaVPyc3cGvqyrWDvX9ifO6ycdXJi9h6AdVoACWS0zyL17um888qzRAitVS4X3x3HP
X-Google-Smtp-Source: AGHT+IHtKQ+asV05FN7dQ9w/3QjydnM4+vYHu9xl8giacG8prLpphzh8YPkBX3/+NS5QuLeT6B3sZz/+aBT+kEaBpqw=
X-Received: by 2002:a5d:5848:0:b0:38f:28a1:501d with SMTP id
 ffacd0b85a97d-38f33f2f4a8mr1934195f8f.25.1739587698255; Fri, 14 Feb 2025
 18:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <20250214164520.1001211-3-ameryhung@gmail.com>
In-Reply-To: <20250214164520.1001211-3-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 18:48:07 -0800
X-Gm-Features: AWEUYZmbtvXYiz8sd620DN_stT5GzxICZguCPt7jLc1wx3cm4PSutNuicg3V3JA
Message-ID: <CAADnVQJoUpZ8qNKSR7drX9nr1YE_Wcx+fM+FAeyMvXekr=ECDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/5] bpf: Support getting referenced kptr from
 struct_ops argument
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:45=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> +               if (!is_nullable && !is_refcounted)
>                         continue;
>
> +               if (is_nullable)
> +                       suffix =3D MAYBE_NULL_SUFFIX;
> +               else if (is_refcounted)
> +                       suffix =3D REFCOUNTED_SUFFIX;

I would remove the first 'if' and add:
   else
      continue;

>                 /* Should be a pointer to struct */
>                 pointed_type =3D btf_type_resolve_ptr(btf,
>                                                     args[arg_no].type,
> @@ -236,7 +246,7 @@ static int prepare_arg_info(struct btf *btf,
>                 if (!pointed_type ||
>                     !btf_type_is_struct(pointed_type)) {
>                         pr_warn("stub function %s has %s tagging to an un=
supported type\n",
> -                               stub_fname, MAYBE_NULL_SUFFIX);
> +                               stub_fname, suffix);
>                         goto err_out;
>                 }
>
> @@ -254,11 +264,15 @@ static int prepare_arg_info(struct btf *btf,
>                 }
>
>                 /* Fill the information of the new argument */
> -               info->reg_type =3D
> -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
>                 info->btf_id =3D arg_btf_id;
>                 info->btf =3D btf;
>                 info->offset =3D offset;
> +               if (is_nullable) {
> +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID | =
PTR_MAYBE_NULL;
> +               } else if (is_refcounted) {
> +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID;
> +                       info->refcounted =3D true;
> +               }
>
>                 info++;
>                 info_cnt++;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9de6acddd479..fd3470fbd144 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6677,6 +6677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>                         info->reg_type =3D ctx_arg_info->reg_type;
>                         info->btf =3D ctx_arg_info->btf ? : btf_vmlinux;
>                         info->btf_id =3D ctx_arg_info->btf_id;
> +                       info->ref_obj_id =3D ctx_arg_info->refcounted ? c=
tx_arg_info->ref_obj_id : 0;
>                         return true;
>                 }
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a41ba019780f..a0f51903e977 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1543,6 +1543,17 @@ static void release_reference_state(struct bpf_ver=
ifier_state *state, int idx)
>         return;
>  }
>
> +static bool find_reference_state(struct bpf_verifier_state *state, int p=
tr_id)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < state->acquired_refs; i++)
> +               if (state->refs[i].id =3D=3D ptr_id)
> +                       return true;
> +
> +       return false;
> +}
> +
>  static int release_lock_state(struct bpf_verifier_state *state, int type=
, int id, void *ptr)
>  {
>         int i;
> @@ -5981,7 +5992,8 @@ static int check_packet_access(struct bpf_verifier_=
env *env, u32 regno, int off,
>  /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
>  static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
>                             enum bpf_access_type t, enum bpf_reg_type *re=
g_type,
> -                           struct btf **btf, u32 *btf_id, bool *is_retva=
l, bool is_ldsx)
> +                           struct btf **btf, u32 *btf_id, bool *is_retva=
l, bool is_ldsx,
> +                           u32 *ref_obj_id)

It's ok-ish for now, but 11 arguments in a function is pushing it.
We've accumulated enough tech debt here.
Consider a follow up.

