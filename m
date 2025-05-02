Return-Path: <bpf+bounces-57293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230AAA7B66
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8A43BE69E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD89204588;
	Fri,  2 May 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laR2mPY/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9E1F1513
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221546; cv=none; b=ah8zoymlUTaYNcL18tmhUkgmZ2+gOsgdJfjZE5yRjke54kisKr3LWNcSd2NbN6YpC5+oEFu7DXIlxiB6QD1AI+1V4To+HOm7rX4QxtfeLvRuQfTRgLR8ucS5gSXPGn+0vnrIDyNyxAthEv4b9r31Iy2oBmLYbsDWnkVqE8M/f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221546; c=relaxed/simple;
	bh=vzEu2VtE65vamiky2nJM6w4ho54L+QB8h2yQlNg4C4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb9gSWb4pjx9t10TDYu/Z++668uhHyHjBFTDTLqG5rerNANm/QEHk2LdtRtQWdso2web4c0nu/WqHE70iPLYslwd1dKLNVA3g3rrUbY2iN8OLkD8vq3zKM1brpeNr6K/pwoCWqpjMGD9xTzv4YBMt00AjMglRmidngKApHlcq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laR2mPY/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so20317315e9.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746221543; x=1746826343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkVkVHGIvjVYMZnNyOFSNOqyjyGgSqqIjMnGQOB0Mtg=;
        b=laR2mPY/00vpVVo3N2YE54vuEvDladqn3frTcVbb55diS4QUn9ZHch3134dUxiOyOZ
         1uwR1EvFWPUthsbNJvQX25Fnw7L704fMgziur6fFIbWlS5DGRgXFYUKKs4OlR+bbMggq
         JjLrsfvgC0z5UVyn2veaO4+THkEpb6gZOaMcdM29FsBNXOiiqmNAtqQB4ugaxj+UCFnw
         DyibvUQQDHnkQWrJJmY2are/O8Tg3sSuseN8Pl7j2UqqdFV4An0h6Snlah9ye1o8jqvM
         lJtf/7V4QqVpGaL8CMT8sOJMHccWGMTir7oZClc+JJEEnMVSKMagvhc4vz3r+Go8NP+x
         1Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221543; x=1746826343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkVkVHGIvjVYMZnNyOFSNOqyjyGgSqqIjMnGQOB0Mtg=;
        b=ISFDBRWKRmdtc1LkDlyeSqVOqvAHV+RfOWcD0I9v9kLpDoRt60GDUOf/wDa4y/P6wj
         8ltG8zpJNm48dBsGFhn4sxHrKDKnMrnL/vPzXlUJ1kSfZU0woGDIsGiVoMNeExkAyimb
         AmcROoBcoSo+D6Q2sM7H2YUZ8PmqbqeVLoeuDkmzkh+ynlczYmYoGnJJ4b1opdxySJkW
         QjWVv1gTQgSwVEYAsShH5XPbTmoc1ilBkpG0FvkY1I2m1e86MIGEuVMRdLmAOyxI8wfo
         IUmSNIVxIIWag9pgJiNhDLW6vkZLpYEQLJkA7NBs5ZVVNUwdSi99CfV15Egg9UIS0UCL
         RxlA==
X-Gm-Message-State: AOJu0Yy0F8tc+pS/uNMaR/N5oOWxE9gwcrnELvJFembSr36xu/AczDSw
	+LS+P4fMrGiWdLTCTiYcm6nYwsD9cg1SxoOVNQlzC+rm0BPf4jwlx6zCP7RBinWp1orkEyrkrKK
	P2ONfbtVJXOHi7RoYu13Op5Oi7sc=
X-Gm-Gg: ASbGnctkzvmhT3bBDn1fdE993DNAhuEbuVhoeR6LEksuQgeUZq6uBEmXhLL83Nz77/m
	yPhn0O42nl3FyE15Bh/OF3schBlAcPqCUoSgT5H5SoO1L3ZvmDuhelrcrUOadhM3nbIy4N3b83C
	KaqRjiL6FTmBozbm+b8XnECk1B6TCsGdUQ05yP0zZZpo7JVsKlvA==
X-Google-Smtp-Source: AGHT+IFNrZr/gKTX+PH1qaFriF6kFkrLDt2iY9pxoQEbgd+NlNa74zaR4dxQB6Yf25h10T939YIa5uLIpNKpPqmN3rU=
X-Received: by 2002:a5d:5f84:0:b0:3a0:89f4:9b02 with SMTP id
 ffacd0b85a97d-3a09ceaf889mr589855f8f.14.1746221542960; Fri, 02 May 2025
 14:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com> <20250502190621.41549-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250502190621.41549-3-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 14:32:11 -0700
X-Gm-Features: ATxdqUGKkqpAz0vGT3rwMKfI25EkLCsww_psafXbvqP3fWrC9aTNiFIx_P-np_w
Message-ID: <CAADnVQ+PyzpJutq44dWtfX+YfkKuzRtmLTB7f7vgFtY+P-rjog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 12:06=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> This patch introduces a new set of kfuncs for working with dynptrs in
> BPF programs, enabling reading variable-length user or kernel data
> into dynptr directly. To enable memory-safety, verifier allows only
> constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
> kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memory
> safety shortcomings.
>
> The following kfuncs are introduced:
> * `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dynpt=
r
> * `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
> * `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string into
> a dynptr
> * `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
> dynptr
> * `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data into
> a dynptr for the current task
> * `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space string
> into a dynptr for the current task
> * `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space data
> of the task into a dynptr
> * `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
> string of the task into a dynptr
>
> The implementation is built on two generic functions:
>  * __bpf_dynptr_copy
>  * __bpf_dynptr_copy_str
> These functions take function pointers as arguments, enabling the
> copying of data from various sources, including both kernel and user
> space. Notably, these indirect calls are typically inlined.
>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c     |   8 ++
>  kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2aad7c57425b..7d72d3e87324 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3294,6 +3294,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_IT=
ER_NEXT | KF_RET_NULL | KF_SLE
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)

They need to have KF_TRUSTED_ARGS, otherwise legacy ptr_to_btf_id
can be passed in.

>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 52c432a44aeb..52926d572006 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3499,6 +3499,147 @@ static int __init bpf_kprobe_multi_kfuncs_init(vo=
id)
>
>  late_initcall(bpf_kprobe_multi_kfuncs_init);
>
> +typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct ta=
sk_struct *tsk);
> +
> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr=
, u32 doff, u32 size,

why always_inline?

patch 1 already adds overhead in non-LTO build,
since small helper bpf_dynptr_check_off_len() will not be inlined.
This __always_inline looks odd and probably wrong
from optimizations pov.

All other __always_inline look wrong too.


> +                                                const void __user *unsaf=
e_src,
> +                                                copy_fn_t str_copy_fn,
> +                                                struct task_struct *tsk)
> +{
> +       struct bpf_dynptr_kern *dst;
> +       u32 chunk_sz, off;
> +       void *dst_slice;
> +       int cnt, err;
> +       char buf[256];
> +
> +       dst_slice =3D bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
> +       if (likely(dst_slice))
> +               return str_copy_fn(dst_slice, unsafe_src, size, tsk);
> +
> +       dst =3D (struct bpf_dynptr_kern *)dptr;
> +       if (bpf_dynptr_check_off_len(dst, doff, size))
> +               return -E2BIG;
> +
> +       for (off =3D 0; off < size; off +=3D chunk_sz - 1) {
> +               chunk_sz =3D min_t(u32, sizeof(buf), size - off);
> +               /* Expect str_copy_fn to return count of copied bytes, in=
cluding
> +                * zero terminator. Next iteration increment off by chunk=
_sz - 1 to
> +                * overwrite NUL.
> +                */
> +               cnt =3D str_copy_fn(buf, unsafe_src + off, chunk_sz, tsk)=
;
> +               if (cnt < 0)
> +                       return cnt;
> +               err =3D __bpf_dynptr_write(dst, doff + off, buf, cnt, 0);
> +               if (err)
> +                       return err;
> +               if (cnt < chunk_sz || chunk_sz =3D=3D 1) /* we are done *=
/
> +                       return off + cnt;
> +       }
> +       return off;
> +}
> +
> +static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dp=
tr, u32 doff,
> +                                            u32 size, const void __user =
*unsafe_src,
> +                                            copy_fn_t copy_fn, struct ta=
sk_struct *tsk)
> +{
> +       struct bpf_dynptr_kern *dst;
> +       void *dst_slice;
> +       char buf[256];
> +       u32 off, chunk_sz;
> +       int err;
> +
> +       dst_slice =3D bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
> +       if (likely(dst_slice))
> +               return copy_fn(dst_slice, unsafe_src, size, tsk);
> +
> +       dst =3D (struct bpf_dynptr_kern *)dptr;
> +       if (bpf_dynptr_check_off_len(dst, doff, size))
> +               return -E2BIG;
> +
> +       for (off =3D 0; off < size; off +=3D chunk_sz) {
> +               chunk_sz =3D min_t(u32, sizeof(buf), size - off);
> +               err =3D copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
> +               if (err)
> +                       return err;
> +               err =3D __bpf_dynptr_write(dst, doff + off, buf, chunk_sz=
, 0);
> +               if (err)
> +                       return err;
> +       }
> +       return 0;
> +}
> +
> +static __always_inline int copy_user_data_nofault(void *dst, const void =
__user *unsafe_src,
> +                                                 u32 size, struct task_s=
truct *tsk)
> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;
> +
> +       return copy_from_user_nofault(dst, unsafe_src, size);
> +}
> +
> +static __always_inline int copy_user_data_sleepable(void *dst, const voi=
d __user *unsafe_src,
> +                                                   u32 size, struct task=
_struct *tsk)
> +{
> +       int ret;
> +
> +       if (!tsk) /* Read from the current task */
> +               return copy_from_user(dst, unsafe_src, size);
> +
> +       ret =3D access_process_vm(tsk, (unsigned long)unsafe_src, dst, si=
ze, 0);
> +       if (ret !=3D size)
> +               return -EFAULT;
> +       return 0;
> +}
> +
> +static __always_inline int copy_kernel_data_nofault(void *dst, const voi=
d *unsafe_src,
> +                                                   u32 size, struct task=
_struct *tsk)
> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;

Why ? Let's not do defensive programming.
The caller clearly passes NULL.
Just drop this line.

> +
> +       return copy_from_kernel_nofault(dst, unsafe_src, size);
> +}
> +
> +static __always_inline int copy_user_str_nofault(void *dst, const void _=
_user *unsafe_src,
> +                                                u32 size, struct task_st=
ruct *tsk)
> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;

same here and further down.

pw-bot: cr

