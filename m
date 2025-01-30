Return-Path: <bpf+bounces-50077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10996A22727
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF027A2D3C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A979CF;
	Thu, 30 Jan 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjvzBCi4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B9256D
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196400; cv=none; b=OEMWmiT11+TZYS/NwXF8yeefmagXF3lbUDP2ys2B4gTVK97yZKUnAob/Hzyn67kfx8pOAoXDuKAbDjNBpf+sa2oa5HqzMThZ+ztMwN2gk3xoRW1CWwam6N58Mc5gsj6i5nuPPm1TVh1nQH7TVoL+kzsxgrR99qJUwRlVfFM1bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196400; c=relaxed/simple;
	bh=nE3ezhE0ORUpCvqCobzfUnHXUqFDFn51RbDdP8kbTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQ3X4KzaxpJUYotZtPOHzTBOgnreakbS44Ths95N/KQLH+4Emj6B8KJ/sxDLKaKS165mENQtreN//UiDNvMJWo5vp4N7IgiA9Uh1VfT5Hb9ZhMZXTSKVmv/XG32LamedVvPuYgNgGp+N8A4OAovdlfZw0gKW5xFtOa8a/w2GkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjvzBCi4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb94cceso2317045ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738196398; x=1738801198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AMh6nFsScnlaxd8YC2LQqnUdnaSzHiT4jf6slLXshc=;
        b=PjvzBCi4kntnDb4IQXkMZbcXQFTcRDku6KYTEb/0hoHWAm82zEVqbWXajtMSTSxmjp
         LOfHvDxL0Fibliveu5H7du4HZTOmPmUOdYHE0xw0z0ubqE0BTf9cPR163Zfms7cc75Lg
         54MWk5RUPr5tjuDg0gTyi7oVZGLophHVAFDPEwgYa0ZJjZYCrS4whyaXDmArVJCpjVky
         wPbN55yu2C8DzkD0tIEMLi5vcRWnmSA3NuXsyA8SOImQEvG0zTgHWLKkYDAkq7rk3oSP
         7x9QuMIYtNNnVn/UnTKyhyKMMCdxoX7M1Uulg24ZCxSLVAoIP/dnlhWGM/LuIepC6LJO
         OA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738196398; x=1738801198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AMh6nFsScnlaxd8YC2LQqnUdnaSzHiT4jf6slLXshc=;
        b=qX4b1vm8qM56cD6cLiRDpJKPZ01LKdV37+wckS1+iREq8IyEIrieh+Yq3yf32lT2oE
         ru961lyXb5uQ96/i+/TpppXVLAEITvD7BbLmHLA7Q5DOecBm51o0UYFKkgNZz+gtIdUl
         O/sXLSnugFQG/1+zIayOj3ivVNRueOmwMAJ9Y1n25AOX+YUOdbLzTHpOvB89xNE/COYu
         EkzBkpaL2P/uIWlaMsb6ywn02QiP/R/+0xcnS2Vtt5Te5J3pfic53cwUcyasRuF5uTBT
         BJdx9ge8K05CXbcO5AVU3wgK6Uz8KN908Qjgukb+SrL5DeFeBxnjTH81evibfnztV9DK
         kCWA==
X-Gm-Message-State: AOJu0YxMgKByZDT0wwkgySSoITI04c7lXlPXgT1hV2ImhLk46f0CsXIY
	UD1iqK476PZY2/tmPVdtDMHvUCvE3I40nGk42XZW6KSowwz1ZG6uBR3V6HruVoNE1Tmb6lhvjtI
	E/pKKxop5a37N5+4uhPxRFtBrfkM=
X-Gm-Gg: ASbGncsz6n71ikUJilR+61RTq7mmGyrLorwtl5QQxRkTrT2K45eeXB4jFoQ81iiEdBV
	1J/uMHZGkgDZ9j4N89LXkWdvdegqwpp0dXfV1FJ6Lny0Sl9FhRmmHfPL+oiJC+Y91cHp9F1eAel
	mzfKHZrQEcbpqn
X-Google-Smtp-Source: AGHT+IEWbSlMkZ5Mw89iU2qXlIjzZXpHahbdfaQoRbtPhTaFUQtOSWvv+SrxUpHVnmQ3LYEDqKbO08pevESaNYb+5/8=
X-Received: by 2002:a05:6a20:c91c:b0:1e1:f281:8d07 with SMTP id
 adf61e73a8af0-1ed7a5efb7fmr7402768637.10.1738196398239; Wed, 29 Jan 2025
 16:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128224352.3808460-1-linux@jordanrome.com>
In-Reply-To: <20250128224352.3808460-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:19:44 -0800
X-Gm-Features: AWEUYZnKIr_x5jBe8dUdIMZTkUYqxsK0hZXP8wHi6oSpzQDU6UMn2eP25IZoNrg
Message-ID: <CAEf4BzbpnHOULxRyWhNU30HknYmZpfAT0zdi1OekxMV4ZHydYQ@mail.gmail.com>
Subject: Re: [bpf-next v6 1/3] mm: add copy_remote_vm_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 2:44=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/linux/mm.h |   3 ++
>  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         |  74 ++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>

The logic looks good, but I have a bunch of stylistic nits below. It
would be nice for someone from mm side to take a look as well.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f02925447e59..f3a05b3eb2f2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2485,6 +2485,9 @@ extern int access_process_vm(struct task_struct *ts=
k, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
> +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
> +               void *buf, int len, unsigned int gup_flags);
> +
>  long get_user_pages_remote(struct mm_struct *mm,
>                            unsigned long start, unsigned long nr_pages,
>                            unsigned int gup_flags, struct page **pages,
> diff --git a/mm/memory.c b/mm/memory.c
> index 398c031be9ba..7f6e74a99984 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6714,6 +6714,125 @@ int access_process_vm(struct task_struct *tsk, un=
signed long addr,
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
>
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * If there is any error return -EFAULT.
> + */
> +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr=
,
> +                             void *buf, int len, unsigned int gup_flags)
> +{
> +       void *old_buf =3D buf;
> +       int err =3D 0;

empty line between variables and statements

> +       ((char *)buf)[0] =3D '\0';

nit: this would be probably a bit more "canonical": *(char *)buf =3D '\0';

> +
> +       if (mmap_read_lock_killable(mm))
> +               return -EFAULT;
> +
> +       /* Untag the address before looking up the VMA */
> +       addr =3D untagged_addr_remote(mm, addr);
> +
> +       /* Avoid triggering the temporary warning in __get_user_pages */
> +       if (!vma_lookup(mm, addr)) {
> +               err =3D -EFAULT;
> +               goto out;
> +       }
> +
> +       while (len) {
> +               int bytes, offset, retval;
> +               void *maddr;
> +               struct page *page;
> +               struct vm_area_struct *vma =3D NULL;
> +
> +               page =3D get_user_page_vma_remote(mm, addr, gup_flags, &v=
ma);
> +
> +               if (IS_ERR(page)) {
> +                       /*
> +                        * Treat as a total failure for now until we deci=
de how
> +                        * to handle the CONFIG_HAVE_IOREMAP_PROT case an=
d
> +                        * stack expansion.
> +                        */
> +                       ((char *)buf)[0] =3D '\0';
> +                       err =3D -EFAULT;
> +                       goto out;
> +               }
> +
> +               bytes =3D len;
> +               offset =3D addr & (PAGE_SIZE - 1);
> +               if (bytes > PAGE_SIZE - offset)
> +                       bytes =3D PAGE_SIZE - offset;
> +
> +               maddr =3D kmap_local_page(page);
> +               retval =3D strscpy(buf, maddr + offset, bytes);
> +
> +               if (retval < 0) {
> +                       buf +=3D (bytes - 1);

nit: unnecessary ()

another nit: you could have had `addr +=3D bytes - 1;` here, to keep
addr and buf adjustment code close


> +                       /*
> +                        * Because strscpy always NUL terminates we need =
to
> +                        * copy the last byte in the page if we are going=
 to
> +                        * load more pages
> +                        */
> +                       if (bytes !=3D len) {
> +                               addr +=3D (bytes - 1);
> +                               copy_from_user_page(vma, page, addr, buf,
> +                                               maddr + (PAGE_SIZE - 1), =
1);
> +
> +                               buf +=3D 1;
> +                               addr +=3D 1;
> +                       }
> +                       len -=3D bytes;
> +               }
> +
> +               unmap_and_put_page(page, maddr);
> +
> +               if (retval >=3D 0) {
> +                       /* Found the end of the string */
> +                       buf +=3D retval;
> +                       goto out;
> +               }

it's not incorrect, but it would be nice not to have to re-check
retval twice. Why not this structure:

ret =3D strscpy(...)
if (retval >=3D 0) {
    unmap_and_put_page(page, maddr);
    buf +=3D retval;
    break;
}

/* this is -E2BIG case */

buf +=3D bytes - 1;
addr +=3D bytes - 1;

if (bytes !=3D len) { copy, buf +=3D 1, addr +=3D 1 }

unmap_and_put_page(page, maddr);



Note that you don't need goto, break is fine. And yes, I don't think
duplicating unmap_and_put_page() is a problem.


> +       }
> +
> +out:
> +       mmap_read_unlock(mm);
> +       if (err)
> +               return err;
> +
> +       return buf - old_buf;
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> + * @tsk:       the task of the target address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to copy
> + * @gup_flags: flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on);
> + * not including the trailing NUL. Always guaranteed to leave NUL-termin=
ated
> + * buffer. On any error, return -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm) {
> +               ((char *)buf)[0] =3D '\0';
> +               return -EFAULT;
> +       }
> +
> +       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +
> +       mmput(mm);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +
>  /*
>   * Print the name of a VMA.
>   */
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 9cb6e99215e2..4d83d0813eb8 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1701,6 +1701,80 @@ int access_process_vm(struct task_struct *tsk, uns=
igned long addr, void *buf, in
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
>
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * If there is any error return -EFAULT.
> + */
> +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr=
,
> +                             void *buf, int len)
> +{
> +       uint64_t tmp;

s/uint64_t/unsigned long/

also tmp -> addr_end ?

> +       struct vm_area_struct *vma;
> +

nit: no empty line here, why?

> +       int ret =3D -EFAULT;
> +
> +       ((char *)buf)[0] =3D '\0';
> +
> +       if (mmap_read_lock_killable(mm))
> +               return ret;
> +
> +       /* the access must start within one of the target process's mappi=
ngs */
> +       vma =3D find_vma(mm, addr);
> +       if (!vma)
> +               goto out;
> +
> +       if (check_add_overflow(addr, len, &tmp))
> +               goto out;
> +       /* don't overrun this mapping */
> +       if (tmp >=3D vma->vm_end)

nit: strictly speaking only `tmp > vma->vm_end` needs special handling

> +               len =3D vma->vm_end - addr;
> +
> +       /* only read mappings where it is permitted */
> +       if (vma->vm_flags & VM_MAYREAD) {
> +               ret =3D strscpy(buf, (char *)addr, len);
> +               if (ret < 0)
> +                       ret =3D len - 1;
> +       }
> +
> +out:
> +       mmap_read_unlock(mm);
> +       return ret;
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> + * @tsk:       the task of the target address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to copy
> + * @gup_flags: flags modifying lookup behaviour (unused)
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on);
> + * not including the trailing NUL. Always guaranteed to leave NUL-termin=
ated
> + * buffer. On any error, return -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm) {
> +               ((char *)buf)[0] =3D '\0';
> +               return -EFAULT;
> +       }
> +
> +       ret =3D __copy_remote_vm_str(mm, addr, buf, len);
> +
> +       mmput(mm);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +
>  /**
>   * nommu_shrink_inode_mappings - Shrink the shared mappings on an inode
>   * @inode: The inode to check
> --
> 2.43.5
>

