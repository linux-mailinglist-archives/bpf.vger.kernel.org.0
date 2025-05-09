Return-Path: <bpf+bounces-57928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4061AAB1EC1
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250241B68AEB
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ECB25F7BC;
	Fri,  9 May 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn+E7W4R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FA25D533
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825121; cv=none; b=Sv4a+tkomV8lVpfAWbx6JAL/V5sj3UUBxgxABVav/HCr+igKIwAUJDEIyv5AKMBmpcembtkC2cIX2lczENJWUXxnw8t8RkqHDvwcp8BZlB1he+ti0R6nPyZSxB2jtXp6cWRXlF6EbDb3IM73A3QA7EESTjKNdv8fotwmfjLI1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825121; c=relaxed/simple;
	bh=cnIMKE1QajafWT/o4tiV3OnZBnRn2GxvwJKVafqeQe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ES5Ii9v6tMCpRwHMiuHtWMTiOIMu+CyAtGtC1On+9ZeJVCQp2PCgJpGrqkR7rPBYqLeVYGj0XLh6zGG5H9Qqw0lIUm9LWijZ6AWn/BmA6cGNN9rIs/uJWlVVlsjVr3M3QVfOGevIuyKBu5yP+f67o87ARJDVJMQuBZwgqyCtyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn+E7W4R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30820167b47so2272867a91.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746825119; x=1747429919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo/shWWi6cand0vWtKRzf0hJlhcC0xRZAQmeDL5oM/Q=;
        b=fn+E7W4RUbn/jew5UWX1UeLF5VazaoSQqcxcKRQnfHwsvQva6gn3r2L4fi/LL6x7SM
         q13er8URJu3ksac3i3EqrVSX4Kd86qUzq5lyYJD1oYOkl5yii/kgV+KtRlrrM/fzpPuy
         +1tLnj6zttdDTB945laG1uCOaNypBho1vfJxIxUbUfyHZgH6lNo/fXn4e4nIoA1F4oba
         24yJVmXnQJTJb+B3tdGMZktRTLcULY9RdUr+fiaDgSxjTj4FP8yGonmPXMoaVcoKVre/
         o+WQwrICKBdWQhZ0WVGCVcUpkKG8+DQdhDPI++YwYojDXv0I8fHKeZP8ChPgBAMpQ4af
         S7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746825119; x=1747429919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo/shWWi6cand0vWtKRzf0hJlhcC0xRZAQmeDL5oM/Q=;
        b=WceC9tvum6q/zWeZWerWMEPVjmRlPv+VhDTg5h+9faz2RGAY72C5TLg7Vk9JWBcCyO
         fLCPznaj7uGFuMajshdixoCYeQdgaEI38gf3/pdycIJxnQh5NNoKX9w5IG4E5Zl9YuCx
         DbHQ2wHpfmhfoVG9gZACbflquAzHWLR0W4ZJVh8zX9HwWm5QQnM33kZdon93EL9/1yqG
         7S5ZtwmvuAfDI14+SGOZojW0o6jxs1riW/geAhw4pdkSqZVXQ7N2Bx74XYaQNWHBpeYC
         Z3txrpmKBJGFKF+jyzUgPrmRcvRuyPkMJFKWB8i/zkCRBqfy0WJ1Lm0KZsRi8ZsAwNRG
         HO1Q==
X-Gm-Message-State: AOJu0YyzesJHdH82AfJp+sYPA+GQCPqOWcRnCcgtVPGfprWRFqpy+xvS
	Bdezjrd32EONSE8zh/tErv6rmxberbIoMyAy4uDW6pXg8GksMLv0l+pFkQQX0GBoR/YHT27y2jg
	zaLaZxcrqeyx6n8U8fH6VFyQPXrM=
X-Gm-Gg: ASbGncu4syKjUvryiM7umpYSTetN58/Lj4m94lJ6kvawAWkyT4ew5inYmojfQ5xWD3V
	Z7lVdIewJLEFGuWvzhj3zMpjAErbGLHn2GQuaZ+VKy22b2fbMAiG/fAX+xajpO2Vf+/8s5fgP2B
	JvohceF8uJR7jRnSIn37PRIe0fqwDvP8e1bDQMlHKusZ+uSeCI
X-Google-Smtp-Source: AGHT+IEs+w7S0piffWncdZWm/2h6eCnwdrn3ps0CHy+rnTxZwc2sR8Cj45wNNYzMPYd7+iZDE7+Z4hoaT9JLliS1Reg=
X-Received: by 2002:a17:90b:2d8a:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-30c4000ffdfmr7556267a91.14.1746825118975; Fri, 09 May 2025
 14:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-2-memxor@gmail.com>
In-Reply-To: <20250507171720.1958296-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:11:46 -0700
X-Gm-Features: ATxdqUHQvk8ug1gWRw7TEA9b4Sn0GM01Ahev9tPm9suPhwh5eeNF5hu9FI5KQzU
Message-ID: <CAEf4Bzbw7qgmpvFr-ki=774Jf4c91CbpCmJ1+jjuSqK0MV4VNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/11] bpf: Introduce bpf_dynptr_from_mem_slice
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:17=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
> the new bpf_mem_slice type. This slice is read-only, for a read-write
> slice we can expose a distinct type in the future.
>
> Since this is the first kfunc with potential local dynptr
> initialization, add it to the if-else list in check_kfunc_call.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   |  6 ++++++
>  kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c |  6 +++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..b0ea0b71df90 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1344,6 +1344,12 @@ enum bpf_dynptr_type {
>         BPF_DYNPTR_TYPE_XDP,
>  };
>
> +struct bpf_mem_slice {
> +       void *ptr;
> +       u32 len;
> +       u32 reserved;
> +};
> +
>  int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>  const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len=
);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 78cefb41266a..89ab3481378d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2873,6 +2873,42 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
>         return 0;
>  }
>
> +/**
> + * bpf_dynptr_from_mem_slice - Create a dynptr from a bpf_mem_slice
> + * @mem_slice: Source bpf_mem_slice, backing the underlying memory for d=
ynptr
> + * @flags: Flags for dynptr construction, currently no supported flags.
> + * @dptr__uninit: Destination dynptr, which will be initialized.
> + *
> + * Creates a dynptr that points to variable-length read-only memory repr=
esented
> + * by a bpf_mem_slice fat pointer.
> + * Returns 0 on success; negative error, otherwise.
> + */
> +__bpf_kfunc int bpf_dynptr_from_mem_slice(struct bpf_mem_slice *mem_slic=
e, u64 flags, struct bpf_dynptr *dptr__uninit)
> +{
> +       struct bpf_dynptr_kern *dptr =3D (struct bpf_dynptr_kern *)dptr__=
uninit;
> +       int err;
> +
> +       /* mem_slice is never NULL, as we use KF_TRUSTED_ARGS. */
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
> @@ -3327,6 +3363,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_mem_slice, KF_TRUSTED_ARGS)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 99aa2c890e7b..ff34e68c9237 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12116,6 +12116,7 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_unlock,
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
> +       KF_bpf_dynptr_from_mem_slice,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -12219,6 +12220,7 @@ BTF_ID(func, bpf_res_spin_lock)
>  BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> +BTF_ID(func, bpf_dynptr_from_mem_slice)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -13140,7 +13142,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         if (is_kfunc_arg_uninit(btf, &args[i]))
>                                 dynptr_arg_type |=3D MEM_UNINIT;
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

