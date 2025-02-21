Return-Path: <bpf+bounces-52122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD1A3E942
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B417519C30A0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68917991;
	Fri, 21 Feb 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwNHRVZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB179F2
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098540; cv=none; b=ZeVzxwUJFf3aKbJcCvbII/Rg66v/fod5chPIg5BDrHCJumIPpnHkkHJd1WpkUZ1KnFuF52tbTxUupG5ZLp2P0yMLl4zDlWO4UnexU4YgjfNE6/qjYlOgn/EpY11cb2PO8EN6qjwKgr6KoBxgJ5Ka8MB7F8ty31niOiKIAluV+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098540; c=relaxed/simple;
	bh=JVyYELs/aZSUOLuatREFRLpvus6SMDudoL8g1OGvpNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxfPbvMJE4s9AiY+rGfOaplOVXvILY/sz5HHhYFGihrtAikOFDc6W5h61VsCFtRcYoJzN59f/HjI9nI42hET0C+Vyi9Q760tLUJsQfwyYE9ZdnDJvJ7JGhR+9OSh1ksVc2LIRRUsHAGNBlrd5f0pepRCXQahBFcc9xiitzUEx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwNHRVZ7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2210d92292eso45314175ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740098538; x=1740703338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcjTsnP4fwZNj4scJrUPrWQPt+w9NuoOTmBlcRxKZ6Q=;
        b=WwNHRVZ79qLdBvDpgY81wtFd5lUqpvvU2glaojZb/4viVNEn/IXQTH16Qkzp98N0bD
         x8NQkC+DhZOJBJaQWC0H5Hn/Y5X4Y7+luVagL9BJfYjBwzMQp9sR/GPNM6HhnnSniZ/T
         mRCJN6oj8rJJXHDcyqdRvJxdgpEhyliTWRrLauT3WzjpUTje++CrFtO6GovBX7dd5oR6
         LWUsvgv5yJPaNTeudqwvamuL4XTtj0BNmftG/F+p8ubD4lEPqNhrOs0mGMQsLf/xMRhu
         XUCXLyyng6bedkP9i82xMjKB6Kr5xoT2tKafviGKQNsmajR6VurWk/ArAgPVFYPNff0a
         TsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098538; x=1740703338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcjTsnP4fwZNj4scJrUPrWQPt+w9NuoOTmBlcRxKZ6Q=;
        b=jj2aMnHXaX02VKTc8aiAjXSc5bIVmncxER71kJDuQR/CLhqR4R/0BUyD3CVepQBTvD
         Ogv1TfsKgyY9FUQs0dPjGoJjWoFWD7NeV8+oEWYmZa+W2/l6Jw8yb1cLWi+dtRfqfpjZ
         BLOxb+HUbvg8HVhd7950LxeYQSXEAHWQFlmNI1FOXGyTlY1d5bz9Y6D+EcaTE4ie9AUz
         CRi3mjAkq9su7kSgZEWZWKhHB05dz4sKJXw4FPKGhF2Rob1lbXyHUD55N+PSzsNZtOUH
         jfgjlQ8gJu2pzOsVrY9do5seApHxL1DLVOA19g0IvMstOrWJ+MmN5daa2FjcZE2qq+JC
         QQDg==
X-Gm-Message-State: AOJu0Yykv8XecyoAGL/PQVV0fRBb9QKGToZSAGPZFlbe5FFyfIGnhJGD
	5N9m6qSo3JAy4+7kq07gC76/j9woR+EehXSUXJbbSfJ5ga6iaZQFBu+5wk84FbtjPL5jVgGl92P
	qGyQQZqDbNdOzb2/MfFuAAMhctypr2Vof
X-Gm-Gg: ASbGncs8OrGS/hCazWY2+zEh6J+bkjGxZAYbXCWBrl3OqyH3C1O1KyBS2H37r9DNbqO
	w3s835g8ZQ6ojbp4pU7KRO4cvy0u3LaTe7xR62iL5EvFvSXN02FOkfJS1mVhv/3GXyUf74kLG1R
	x5mvNRYKdp9Dsq
X-Google-Smtp-Source: AGHT+IHb+5xYXVrCN/gNCBehCqmGKUylMoXs6fm6CUHGFb5VpuOHl5tlN7L/GrrNa7YBpV6EmrdJSVZ/JzW0h3RSpJg=
X-Received: by 2002:a17:902:d4d0:b0:21f:6a22:b294 with SMTP id
 d9443c01a7336-2219ff5f93bmr23636425ad.28.1740098538426; Thu, 20 Feb 2025
 16:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com> <20250218190027.135888-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250218190027.135888-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 16:42:06 -0800
X-Gm-Features: AWEUYZmhv9Qd4PUBCsxYqpJryZ_ZNTasMqvp0v4awCyV0-7hvhL0h0dpQECojaI
Message-ID: <CAEf4BzbV_J5JXtkSE0Lfp31T01rZgLjVwi6-fhD3Y_DaDDtx9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:01=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr t=
o
> another. This functionality is useful in scenarios such as capturing XDP
> data to a ring buffer.
> The implementation consists of 4 branches:
>   * A fast branch for contiguous buffer capacity in both source and
> destination dynptrs
>   * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
> data to/from non-contiguous buffer
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c |  3 +++
>  2 files changed, 40 insertions(+)

This is surprisingly nicely compact and terse, I really like this! See
some nits below, and yes, let's add doc-comment as Eduard suggested.

pw-bot: cr

>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2833558c3009..ac5fbdfc504d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2770,6 +2770,42 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_=
dynptr *p,
>         return 0;
>  }
>
> +__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
> +                               struct bpf_dynptr *src_ptr, u32 src_off, =
u32 size)
> +{
> +       struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
> +       struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;
> +       __u8 *src_slice, *dst_slice;

let's use `void *`, both memmove and bpf_dynptr_{write,read} uses
`void *` throughout

> +       int err =3D 0;

I'm not sure we want to thread through this err, see below

> +
> +       src_slice =3D bpf_dynptr_slice(src_ptr, src_off, NULL, size);
> +       dst_slice =3D bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size)=
;
> +
> +       if (src_slice && dst_slice) {
> +               memmove(dst_slice, src_slice, size);

return 0;

> +       } else if (src_slice) {
> +               err =3D __bpf_dynptr_write(dst, dst_off, src_slice, size,=
 0);

return __bpf_dynptr_write(...)

> +       } else if (dst_slice) {
> +               err =3D __bpf_dynptr_read(dst_slice, size, src, src_off, =
0);

ditto, direct return

> +       } else {
> +               u32 off =3D 0;
> +               char buf[256];
> +
> +               if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
> +                   bpf_dynptr_check_off_len(src, src_off, size))
> +                       return -E2BIG;

see, you are doing direct return here (but inconsistent with the rest of lo=
gic)

> +
> +               while (err =3D=3D 0 && off < size) {

just while (off < size), because...

> +                       u32 chunk_sz =3D min(sizeof(buf), size - off);

this might trigger warning about type mismatch (size_t vs u32), so
probably best to be explicit: `min_t(u32, sizeof(buf), size - off);`

> +
> +                       err =3D err ?: __bpf_dynptr_read(buf, chunk_sz, s=
rc, src_off + off, 0);
> +                       err =3D err ?: __bpf_dynptr_write(dst, dst_off + =
off, buf, chunk_sz, 0);

I'd keep this a bit more conventional with just


err =3D __bpf_dynptr_read(...);
if (err)
    return err;
err =3D __bpf_dynptr_write(...);
if (err)
    return err;

off +=3D chunk_sz;


Nothing wrong or incorrect with how you wrote it, but somehow feels a
bit more typical to do it this way.

> +                       off +=3D chunk_sz;
> +               }
> +       }
> +       return err;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -3174,6 +3210,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_dynptr_copy)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7bc74171c99..3c567bfcc582 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11781,6 +11781,7 @@ enum special_kfunc_type {
>         KF_bpf_dynptr_slice,
>         KF_bpf_dynptr_slice_rdwr,
>         KF_bpf_dynptr_clone,
> +       KF_bpf_dynptr_copy,
>         KF_bpf_percpu_obj_new_impl,
>         KF_bpf_percpu_obj_drop_impl,
>         KF_bpf_throw,
> @@ -11819,6 +11820,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> +BTF_ID(func, bpf_dynptr_copy)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
>  BTF_ID(func, bpf_throw)
> @@ -11857,6 +11859,7 @@ BTF_ID_UNUSED
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> +BTF_ID(func, bpf_dynptr_copy)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
>  BTF_ID(func, bpf_throw)
> --
> 2.48.1
>

