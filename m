Return-Path: <bpf+bounces-49725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB54A1BF91
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0CD3A5071
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3921A50;
	Sat, 25 Jan 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljv2tI2z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DE3214
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763915; cv=none; b=oMokuM7pzXOXFjdytpMzk/1vgtCi2/SzVuG7J5mNxbt0K+CQL56t0OtUE/eOTugt2xcjJW/xpplk39qXiUs0wsg7agcBkhbblq10/0eJ5wUcGLNxqpYG13ft/QLtUhE+Rv+LVHPBeGitQxhDVX8zKxaOg62YkzecWAq7q+VTKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763915; c=relaxed/simple;
	bh=dw9ZhS873tFB55zJtkYzCT9obn+NEHrBc8o7aG2JrWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC5s3uIh4EiQbMgo2g/a+8ORA+BbezU0xuVnjXk6CgXp8aMkQD3VMzhvR48pgHR81gtLqS9ic4x7b6nTjCQYtRs1ABLmceEweyP3KcjMu5DWWbnrhI3cDS3mwvuUOKN+EUJsurEXPu7n2x5lB4ufhLGEcGA0y6EJK5mZCGr0G4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljv2tI2z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa67ac42819so423245066b.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737763912; x=1738368712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDKhjtLDoAEYrS8Cw95F5DbSI5uvabYE9192eO3X0yY=;
        b=ljv2tI2zY6UCcV5gEFPJ6A0TpOibK/BrYQZRDg/fmlcMK7eylc5x4Kh4+vadtBIpum
         I8g/PbJn+ItZhrwYb1hDjjOVwJlJvwT7IzoFoAFDiN0f/Bi2wza/tw9tg2anSnqyq8yp
         OSH0Mo79SceONREBzvMRarT3LeFh5RolQG7Li4MQf3NoNRKgEOhS9A1sQl+1czzjU1+I
         IP+r6WRXfItyRrLPr0gCNd88Oa8jIzoVraFQ/OCEcj4UOEobklZ4Q+SQ82N11Ccb571w
         XsQli/SvF0GWeFRhIZomAmI3b6DrN1Hf3gkuWVyEpeJLAHQonJiYEBElnUb5ZP1EvF1S
         scyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737763912; x=1738368712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDKhjtLDoAEYrS8Cw95F5DbSI5uvabYE9192eO3X0yY=;
        b=YimQgPzrE9Lx21iRLuA3nJPm6HNeaG85jeQ0zg5m75WCNP8WcUpnehBrAN32wmwZ0N
         YvHdvk9wItwg0WYq3vF6y2qg4XgGJLwDJhk7WfDW5FdGKomJLTqAxLd1mLLsjoYRi7r7
         pOMYaPXoUWYp2spro/J76vUDlOgI6i2CqylBXdR+jySiUEJMYbHuZr/8T36wEv4tQpPZ
         sByRM3DlZpprCOdVmelvXx5dwaG9BQFeZrnZL2lAST/AKRXVW/H4IVOqj8lHRj10eDaL
         c9F3aIvAIcpGjzKWVrrJF8InnPibcgiIL0KrvNKlUVpCSOoPoRs6dgPmXV5AhOiPfVKE
         9MmQ==
X-Gm-Message-State: AOJu0Ywq/ex5dmaJPxWPOcwq8e8mGQ2Stpht9Cdj2KgchpBxJPrZUt+u
	YOl0zE1FmJ2W1eHG3TKiD60x2xJM548jDtmF4NLDd9Wck132v6x20emjWsgmWd7rzTkqpCiD0zo
	dYAfabY5D3uVUC3JL5EQMZH6Hyso=
X-Gm-Gg: ASbGncsddZ3qojx7EwoImT8dBb/TPsZ/z2EFfLZvnMTTlBx51cK8IHOOXB5VgT62GTL
	Fr8mNuZPl+xVWIpWmHI7/W5eRVyxiR+p6r2QbyPOskkZazn6Xn2E5DKwAlK9H
X-Google-Smtp-Source: AGHT+IG6ZIhMPdpyE98BhykyhS7JaWHcS3SY2WdVzNeGbZGNB9Uuq5zeoeynQ6YX7KkFz07DPJNOt6qN3AJBNiv90Qs=
X-Received: by 2002:a17:906:f58a:b0:aa6:ac9b:6822 with SMTP id
 a640c23a62f3a-ab38b0b80efmr3141975566b.12.1737763911586; Fri, 24 Jan 2025
 16:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124183303.2019147-1-linux@jordanrome.com>
In-Reply-To: <20250124183303.2019147-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 16:11:36 -0800
X-Gm-Features: AWEUYZlJInUVwmDrmIniFcyJ27py2tS5N7zpBW_MrbNudUS5BkS1G7RweizA1e4
Message-ID: <CAEf4BzYGkpj3Cd-3t7r0knmWZbbMfE=nie9Qp8mbmuvNBWgT=Q@mail.gmail.com>
Subject: Re: [bpf-next v3 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 10:33=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> This new kfunc will be able to copy a string
> from another process's/task's address space.
> This is similar to `bpf_copy_from_user_str`
> but accepts a `struct task_struct*` argument.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  kernel/bpf/helpers.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f27ce162427a..c26fabf97afd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3082,6 +3082,56 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +/**
> + * bpf_copy_from_user_task_str() - Copy a string from an task's address =
space
> + * @dst:             Destination address, in kernel space.  This buffer =
must be
> + *                   at least @dst__sz bytes long.
> + * @dst__sz:         Maximum number of bytes to copy, includes the trail=
ing NUL.
> + * @unsafe_ptr__ign: Source address in the task's address space.
> + * @tsk:             The task whose address space will be used
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NULL-terminated string from a task's address space to *dst* =
buffer.
> + * If user string is too long this will still ensure zero termination in=
 the
> + * dst buffer unless buffer size is 0.
> + *
> + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succe=
ss and
> + * memset all of @dst on failure.
> + *
> + * Return: The number of copied bytes on success, including the NULL-ter=
minator.

s/NULL/NUL/

Other than that, LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> + * A negative error code on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_task_str(void *dst,
> +                                           u32 dst__sz,
> +                                           const void __user *unsafe_ptr=
__ign,
> +                                           struct task_struct *tsk,
> +                                           u64 flags)
> +{
> +       int ret =3D 0;

nit: no need to zero initialize, you'll overwrite it unconditionally below
> +
> +       if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +               return -EINVAL;
> +
> +       if (unlikely(!dst__sz))
> +               return 0;
> +
> +       ret =3D copy_remote_vm_str(tsk, (unsigned long)unsafe_ptr__ign, d=
st, dst__sz, 0);
> +
> +       if (ret <=3D 0) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset(dst, 0, dst__sz);
> +               return ret ?: -EINVAL;
> +       }
> +
> +       if (ret < dst__sz) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset(dst + ret, 0, dst__sz - ret);
> +               return ret + 1;
> +       }
> +
> +       return ret;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3174,6 +3224,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL =
| KF_SLEEPABLE)
> --
> 2.43.5
>

