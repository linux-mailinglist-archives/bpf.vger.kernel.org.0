Return-Path: <bpf+bounces-48593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B799A09D60
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE753AA7D5
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC5209F50;
	Fri, 10 Jan 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckgQcXGA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989424B254
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545825; cv=none; b=t7FFoUribqL/ua+oxQSPn9uH7YcPhIQ0QP7aVbxxPV10cs7WFmLdKPKB/5ha749suNlJz3HgzGwzTvk94SdRxZDkOVboxUfxnX0huiUPgYOQV5FeJ0pBk1P4qTafK8sA0zWUMiwvsRFFnxhodmVaT1S1DKkQtX+2/+mh9p7Tyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545825; c=relaxed/simple;
	bh=uThlivdER09zy3HD/F9tXPzWUABObMBz7W1AcmNepwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W03KejB9CXYe7RUm7FtYTbTFUNBunUEH3j5upgq+0Q1Oy2wCm6sJLcX5PD2lW1vwVcjj3dvjlIcrcHGiw5O0ukDFKrCq0v1i/3kk/5RB8471mzpzj6m7AM5tIA1DUZasBKFch6qy8CbosnJkvnotp41aG9pmAHcWb3g++J6g+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckgQcXGA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso3269576a91.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 13:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736545823; x=1737150623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xiufv729pOKW8hnhToeicXpljZB4POyrD90eQfHIv4=;
        b=ckgQcXGApDQ82fhUDbWOSdHAJ8mJcUFYpmNojR6Tml9asLRG5ojlQjcxeEecZqxOA5
         VYJiudJZjkw951u2LHjgHnuiyez7OVBWoDVwDg7XJlAj1AqdOYQ5lLi4LaktR1XrbJjz
         SAq9uC2QHXnl3nCEBr1K95pYIS7h4ucj8ivoA4zpk1DExic1mU1gLwPQsx+9ewnkiuAQ
         r94mGx1bF3KUDk3HWyRwsP+TNYTGP5TyQrR+nHxVQj7tEEds6/YTDwz5IeejhrwEHvtQ
         FUNeJu+NQ3gxbCsvEGVcrD8ZFRQOS8oXTCA/UmNgOK3dE2UCXhBXw8IQySZ2G4B8il27
         jKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545823; x=1737150623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xiufv729pOKW8hnhToeicXpljZB4POyrD90eQfHIv4=;
        b=cikDyMYNCZF+2FCZCo7btUpBo1AWS2JB7OWX/37MgaJT0yA1aOeob8bxgLDokjTUaC
         my6uX0VjT1gJNXjbaTjfTwbJweQGZOa901/QZQ44vgkMYIs4yd+DLeKX226D9pH7JmLl
         O5KeBuz50m1pVrWHR6WuWd9x6euG6hZD2nl0mxcpJoITrVpS66EyjinskVFwcIb9hozl
         ENISjAJOrYSvl7St1TKK7SAI6uf4vAHzBe21S2j7AYaf3LW75N+oBPiyp3G0BROuyV9z
         UACSmm4sxFpzSravQKm8/wl1rrbP6IQ6AOza3QrEvtdhuLAg/1Y4A2U7xIuV3z9aJPDz
         3ooQ==
X-Gm-Message-State: AOJu0YybUrw6dEdfKqAgb53V3Q7bOk0nMP2+NcWmTzSamn4XHXsUR9Dq
	WJVhgHSPP+IkwYP33lUWi5t7/55oygDMM+InjmDK8ASJuTqDomGSZsGIAiHvE7x/udz2GRMlTok
	6aSwcBabWS3j6xcJHi7NQMBr2f5Q=
X-Gm-Gg: ASbGncvZuvfn+5eArTSOuIfApXUe2SYZ1P5SlFZHwOdnaQP/Esf5qUTWwMYxp4ukboR
	UG/bOHaj+dATyqvSyPjbjenuRAzP6VpN29lXWQ2bHrBh0bDvbMVQYcA==
X-Google-Smtp-Source: AGHT+IFwb1UA0jsbhrxi6K9k2KJ9JTPE2VSiqJlbAoIASbUk/Ij6+6kDpkSDfFz6PhS4YjdQLyFQydpfb5BWKq0xfEc=
X-Received: by 2002:a17:90b:4a44:b0:2f4:f7f8:fc8a with SMTP id
 98e67ed59e1d1-2f548f7649amr18841977a91.33.1736545822614; Fri, 10 Jan 2025
 13:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107020632.170883-1-linux@jordanrome.com>
In-Reply-To: <20250107020632.170883-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 13:50:10 -0800
X-Gm-Features: AbW1kvZdJKWtBITRhKw1pwnPHXPw1S5Hq52RmAs6XYGyTsyVT8Stg86WmsD6Z9A
Message-ID: <CAEf4BzZuAmSn=HxzNBHrAnx3beem+e97ANHTgR-S4Q8yn2A7CA@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 6:12=E2=80=AFPM Jordan Rome <linux@jordanrome.com> w=
rote:
>
> This new kfunc will be able to copy a string
> from another process's/task's address space.

nit: this is kernel code, task is unambiguous, so I'd drop the
"process" reference here

> This is similar to `bpf_copy_from_user_str`
> but accepts a `struct task_struct*` argument.
>
> This required adding an additional function
> in memory.c, namely `copy_str_from_process_vm`,
> which works similar to `access_process_vm`
> but utilizes the `strncpy_from_user` helper
> and only supports reading/copying and not writing.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/linux/mm.h   |   3 ++
>  kernel/bpf/helpers.c |  46 ++++++++++++++++++++
>  mm/memory.c          | 101 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>

please check kernel test bot's complains as well

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..52b304b20630 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2484,6 +2484,9 @@ extern int access_process_vm(struct task_struct *ts=
k, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
> +extern int copy_str_from_process_vm(struct task_struct *tsk, unsigned lo=
ng addr,
> +               void *buf, int len, unsigned int gup_flags);

nit: curious what mm folks think about naming, I'd go with a slightly
less verbose naming: "copy_remote_vm_str" (copy vs access, _str suffix
for non fixed-sized semantics marking)

for the next revision, let's split out mm parts from helpers parts, I
don't think we lose much as this new internal API is self-contained,
and it will be easier for mm folks to review

> +
>  long get_user_pages_remote(struct mm_struct *mm,
>                            unsigned long start, unsigned long nr_pages,
>                            unsigned int gup_flags, struct page **pages,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cd5f9884d85b..45d41b7a9906 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3072,6 +3072,51 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
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
> + * Copies a NULL-terminated string from a task's address space to BPF sp=
ace.

there is no "BPF space", really... maybe "copies string into *dst* buffer"

> + * If user string is too long this will still ensure zero termination in=
 the
> + * dst buffer unless buffer size is 0.
> + *
> + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succe=
ss and
> + * memset all of @dst on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz, cons=
t void __user *unsafe_ptr__ign, struct task_struct *tsk, u64 flags)

this looks like a long line, does it fit under 100 characters?

> +{
> +       int count =3D dst__sz - 1;
> +       int ret =3D 0;
> +
> +       if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +               return -EINVAL;
> +
> +       if (unlikely(!dst__sz))
> +               return 0;
> +
> +       ret =3D copy_str_from_process_vm(tsk, (unsigned long)unsafe_ptr__=
ign, dst, count, 0);
> +
> +       if (ret <=3D 0) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset((char *)dst, 0, dst__sz);

nit: no need for (char *) cast? memset takes void *, I think

> +               return ret;

if ret =3D=3D 0, is that an error? If so, `return ret ?: -EINVAL;` or
something along those lines?

pw-bot: cr

> +       }
> +
> +       if (ret < count) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset((char *)dst + ret, 0, dst__sz - ret);
> +       } else {
> +               ((char *)dst)[count] =3D '\0';
> +       }
> +
> +       return ret + 1;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3164,6 +3209,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL =
| KF_SLEEPABLE)
> diff --git a/mm/memory.c b/mm/memory.c
> index 75c2dfd04f72..514490bd7d6d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6673,6 +6673,75 @@ static int __access_remote_vm(struct mm_struct *mm=
, unsigned long addr,
>         return buf - old_buf;
>  }
>
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * Don't return partial results. If there is any error return -EFAULT.

What does "don't return partial results" mean? What happens if we read
part of a string and then fail to read the rest?

> + */
> +static int __copy_str_from_remote_vm(struct mm_struct *mm, unsigned long=
 addr,
> +                             void *buf, int len, unsigned int gup_flags)
> +{
> +       void *old_buf =3D buf;
> +       int err =3D 0;
> +
> +       if (mmap_read_lock_killable(mm))
> +               return -EFAULT;
> +
> +       /* Untag the address before looking up the VMA */
> +       addr =3D untagged_addr_remote(mm, addr);
> +
> +       /* Avoid triggering the temporary warning in __get_user_pages */
> +       if (!vma_lookup(mm, addr)) {
> +               mmap_read_unlock(mm);
> +               return -EFAULT;

maybe let's do (so that we do mmap_read_unlock in just one place)

err =3D -EFAULT;
goto err_out;

and then see below

> +       }
> +
> +       while (len) {
> +               int bytes, offset, retval;
> +               void *maddr;
> +               struct vm_area_struct *vma =3D NULL;
> +               struct page *page =3D get_user_page_vma_remote(mm, addr,
> +                                                            gup_flags, &=
vma);
> +

nit: I'd split page declaration and assignment and kept
get_user_page_vma_remote() invocation on a single line

> +               if (IS_ERR(page)) {
> +                       /*
> +                        * Treat as a total failure for now until we deci=
de how
> +                        * to handle the CONFIG_HAVE_IOREMAP_PROT case an=
d
> +                        * stack expansion.
> +                        */
> +                       err =3D -EFAULT;
> +                       break;
> +               }
> +
> +               bytes =3D len;
> +               offset =3D addr & (PAGE_SIZE - 1);
> +               if (bytes > PAGE_SIZE - offset)
> +                       bytes =3D PAGE_SIZE - offset;
> +
> +               maddr =3D kmap_local_page(page);
> +               retval =3D strncpy_from_user(buf, (const char __user *)ad=
dr, bytes);

you are not using maddr... that seems wrong (even if it works due to
how kmap_local_page is currently implemented)

> +               unmap_and_put_page(page, maddr);
> +
> +               if (retval < 0) {
> +                       err =3D retval;
> +                       break;
> +               }
> +
> +               len -=3D retval;
> +               buf +=3D retval;
> +               addr +=3D retval;
> +
> +               /* Found the end of the string */
> +               if (retval < bytes)
> +                       break;
> +       }

err_out: here

> +       mmap_read_unlock(mm);
> +
> +       if (err)
> +               return err;
> +
> +       return buf - old_buf;
> +}
> +
>  /**
>   * access_remote_vm - access another process' address space
>   * @mm:                the mm_struct of the target address space
> @@ -6714,6 +6783,38 @@ int access_process_vm(struct task_struct *tsk, uns=
igned long addr,
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
>
> +/**
> + * copy_str_from_process_vm - copy a string from another process's addre=
ss space.
> + * @tsk:       the task of the target address space
> + * @addr:      start address to access

access -> read from

> + * @buf:       source or destination buffer

for this api it's always the destination, right?

> + * @len:       number of bytes to transfer
> + * @gup_flags: flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from source to destination. If the str=
ing
> + * is shorter than @len then return the length of the string.

and if the string is longer than @len, then what happens? we should
either specify or drop the "if string is shorter bit" and make it
unambiguous whether terminating zero is included or not

> + * On any error, return -EFAULT.
> + */
> +int copy_str_from_process_vm(struct task_struct *tsk, unsigned long addr=
,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm)
> +               return -EFAULT;
> +
> +       ret =3D __copy_str_from_remote_vm(mm, addr, buf, len, gup_flags);
> +
> +       mmput(mm);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_str_from_process_vm);
> +
>  /*
>   * Print the name of a VMA.
>   */
> --
> 2.43.5
>

