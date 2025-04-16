Return-Path: <bpf+bounces-56063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7805A90D93
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A3D3BBB92
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189C23026C;
	Wed, 16 Apr 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUkpdxqT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF81B4235
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837498; cv=none; b=DqJ13Obxkvly93VFlRqDCfafzEDUlL1e+Zne2FOvqvnWDWRHk9PAJX973Ls9z0N8o55MYQuQyGv0sqdfE7IIt/3ccj/m8vbRpIP+jnW1HF+ZCyNosq7ofJmHwer248xxBje24uZRstPvFEwJiV0fXwacesC7qC2JmZlBWPb3ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837498; c=relaxed/simple;
	bh=o+OfitB0g35dYnYe/0lp4EFMGf7GI1z4Xuc/ieOV3pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDOynRvM6RqExh9ZsOO9dBCVDvHCEnmZJQhYtuCYNW5FWERKr2dphtqsIav1Be4XrkhLKAfC1QI0+vDs4ma33UBMZpVe1RCs54cmF7OUznkiIXa8VJ2y0SOzU1T6NvLfOEuHdmvycOB6fArk1TQFvJZG1q6vihxnPdQVdYgGKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUkpdxqT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-226185948ffso1423405ad.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744837497; x=1745442297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKrRFREpUWXlBVYsV2NnouduVRPnfvX9YOKF9lPw1xY=;
        b=WUkpdxqTExTFUB+dqsiGZaBQgVElq1lzlxHKiq2sTHPvlTeBq8QSaoEgfSpK70H4sm
         4K6zW6c6jxCZ1Vyfukds9fxnjyoeHveIHlkR5eGOrjNXN0yjJbeb5erYKI5rCB5w9ILz
         yg4Rr/oIhimWCDlbM3iM/SZJYOL0QLy5tUu87xCVH2s5GSAL/KUbBWp6+eblYzXmXtAl
         FkuxrgpHHhStO0vP4iSRcPNnfCzqP+NnT98eSu3BqoTMYivg8vz2hZmwzAkoIsOQ9xdm
         V/FBPsoot7TXNFYMTaEyRyGD5UQWMTeLeC9UdslZbJ7eNQkCaXVFXAvJD6VQN76iX8Lx
         svqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744837497; x=1745442297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKrRFREpUWXlBVYsV2NnouduVRPnfvX9YOKF9lPw1xY=;
        b=VxMa09U5dj/+uJ7mqx0O3haOJ3jUJ8cLYgXQy1Fh5KdBBZiRLO3qsh/wATWqGYwpJt
         ImgHQHvXUmf5jrnOmJItadnB3h/Bxk2h0PHrsTh3HwiYe05lV+XHcPnvCJ4vm8RPXluS
         fBZNX3gETHGg9mFxKcBOotJjiH4gL9grqMmdQ+pivoGV2FH9UEWHaMxJU3kHwiRXv7/i
         Yy10LZpdRqTQtSdklBS4XLIgus1c8RqkkSENtmkLweKDFCH/ZuqY0xYcnCD6UtK1QV32
         kXv+hU2DK6FsWjBOIMmF0wMzBmoNc0WHJsKnSPJt8kBQ+ejMxwYviSQvObH+P8fBsz6f
         gjEw==
X-Gm-Message-State: AOJu0YzDScAuw81Ox/iAbMcPU2eoVAf86IFck8DyeoAz1q7oDizduXLq
	4+oIP+mj2ahJ04Hl1wO10WCWB9mDe/nSbv+kqOVXRvXwydo/9iFkWZ3g5+Il1ompcSR4V5ZskO2
	qTU9OmCtnBheMC90j3Ie9YiWOIEE=
X-Gm-Gg: ASbGnct6HQEVFSjSskNQuEYajQADUnqsmoN89j4QSg0tuteQ+DEO7AvYka4c0FqlR7D
	gS0laMasszq+LVgLjryvkLbHWBaKluDI2Gzr3xZ4ZZmI1vnpmPsa6uM8gsd9BApZ9SLQa1VGxfW
	hHLa5whRKoQawPy8IcN/0r8TMkNwu7N14hEJnumQ==
X-Google-Smtp-Source: AGHT+IHu69Rtot9ZK+drL+lxDybO43HriI5p/95LMNXHVdZEDOPeHbEoM3g+mFI2cREE0R6CjEgs0t9r7Q6x6OdlgpA=
X-Received: by 2002:a17:902:f684:b0:224:1220:7f40 with SMTP id
 d9443c01a7336-22c358c2996mr41112195ad.3.1744837496668; Wed, 16 Apr 2025
 14:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-7-memxor@gmail.com>
In-Reply-To: <20250414161443.1146103-7-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 14:04:43 -0700
X-Gm-Features: ATxdqUE5uZuGZGdztw3ouCpNywb6qAh5xL8NBBoOOnbB7vYULfZ9IEijlLUoepE
Message-ID: <CAEf4BzY1xE=3f--Gd-xf_5bKMAEC5z5fF8PsFNkg3Q8Wjob6Bg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 06/13] bpf: Introduce bpf_dynptr_from_mem_slice
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
> the new bpf_mem_slice type. This slice is read-only, for a read-write
> slice we can expose a distinct type in the future.
>
> We rely on the previous commits ensuring source objects underpinning
> dynptr memory are tracked correctly for invalidation to ensure when a
> PTR_TO_BTF_ID holding a memory slice goes away, it's corresponding
> dynptrs get invalidated.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   |  5 +++++
>  kernel/bpf/helpers.c  | 32 ++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c |  6 +++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..9feaa9bbf0a4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1344,6 +1344,11 @@ enum bpf_dynptr_type {
>         BPF_DYNPTR_TYPE_XDP,
>  };
>
> +struct bpf_mem_slice {
> +       void *ptr;
> +       size_t len;

for better future extensibility and to avoid big-endian issues, let's have

u32 len;
u32 __reserved; /* or flags */

?

> +};
> +
>  int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>  const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len=
);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..95e9c9df6062 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2826,6 +2826,37 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
>         return 0;
>  }
>
> +/**
> + * XXX
> + */
> +__bpf_kfunc int bpf_dynptr_from_mem_slice(struct bpf_mem_slice *mem_slic=
e, u64 flags, struct bpf_dynptr *dptr__uninit)
> +{
> +       struct bpf_dynptr_kern *dptr =3D (struct bpf_dynptr_kern *)dptr__=
uninit;
> +       int err;
> +
> +       if (!mem_slice)
> +               return -EINVAL;

you have to initialize dynptr regardless of errors, just like
bpf_dynptr_from_mem() does, so

err =3D -EINVAL;
goto error;


> +
> +       err =3D bpf_dynptr_check_size(mem_slice->len);
> +       if (err)
> +               goto error;
> +
> +       /* flags is currently unsupported */
> +       if (flags) {
> +               err =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       bpf_dynptr_init(dptr, mem_slice->ptr, BPF_DYNPTR_TYPE_LOCAL, 0, m=
em_slice->len);
> +       bpf_dynptr_set_rdonly(dptr);
> +
> +       return 0;
> +
> +error:
> +       bpf_dynptr_set_null(dptr);
> +       return err;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -3275,6 +3306,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_mem_slice, KF_TRUSTED_ARGS)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7e09c4592038..26aa70cd5734 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12125,6 +12125,7 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_unlock,
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
> +       KF_bpf_dynptr_from_mem_slice,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -12218,6 +12219,7 @@ BTF_ID(func, bpf_res_spin_lock)
>  BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> +BTF_ID(func, bpf_dynptr_from_mem_slice)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -13139,7 +13141,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                                 }
>                         }
>
> -                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_mem_slice]) {
> +                               dynptr_arg_type |=3D DYNPTR_TYPE_LOCAL;
> +                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_skb]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_xdp]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
> --
> 2.47.1
>

