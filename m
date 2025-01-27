Return-Path: <bpf+bounces-49913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738FA201E8
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534A8188666B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEB1E1A33;
	Mon, 27 Jan 2025 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPWfaWtE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872421DF98F
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021781; cv=none; b=TKOCfxskZjjKdiIGlzUyMvI7aeupe3tm4/sDAYioNICXbRBCjRrIdbyVfOtVo3cIAw/iz2e8G6wAYn730Rgxrs3rvh1348PXmMooqHsIKGzQmr+p6AW84pwVjrIqWwZ45bek6f3Uq3trVhw5QImJAquLTk03CnMi+do5vE4Ubxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021781; c=relaxed/simple;
	bh=o45tQZUfrUdxId/JYTlRJTsxh//wUXoiQCi9FSvXTO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1Ln46XSa5gZML43ePqnA3oJhf17rP2iOZXuMmEPoGgOTa3khbz9d2cX/jgc6ZvYtR62qRYIRs7SvH3CqCnjscBDvBK53LrhgXLtLMTcyxUFqs+0Ke2PXORDT2vLlkId5kmyWLDOIw4kDQXKQK6QlYD0mSRAD6LelbVznTkHF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPWfaWtE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso86080225ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 15:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738021779; x=1738626579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueR0tPBW9KSxuoTyiD1vKriJZY51qUX5OjKQE+zjGUU=;
        b=JPWfaWtEd/tL9lsvkxBoppn5aDOxVbTgBiQC14KWm4vz3WdSsCTLEYZcHmvh8RQ3bA
         qzLa3yHx+a+Cmg4h8gpWPnHI/8TjiM9CfGk1jiMsxxm6dUODHzrxFjy44tbEDMNB/wiY
         q79yNPpln8ZSDqNo56lFgGQhZgOvEwlWLRptIQ28W7jZOkZZWlc9UhM/tibvebIux0Q4
         AxY8t7ssZ0yQXfbS+KIpxbMhtvogjBjp+I3GtO6fcm5YkfwbUStjdbcSUGvutb+WanZi
         uPJD39FFJV96vJ19XquAHbkgN76PhHwGGBj9FvbZkoNCE8bzCl72AhJemcqeoc+CqCQr
         YFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738021779; x=1738626579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueR0tPBW9KSxuoTyiD1vKriJZY51qUX5OjKQE+zjGUU=;
        b=B7jkV02lIpxmOxa+4eBiyV9Bpgba8faPwXpylPNgSTdxad/0yJOIn04fD0QeqfC6r6
         B1z7T8/IczsiiIMVxckPd3SOTmrqyrNoBVD85brj8wDytCvrwg/f53umVLZat495vJCy
         1xix+AN2ilvTAz4r1i5gYJE/FQaiaPRgOKIXAVLjmFo2aAGCoCJJcQ0DS664RfQDYAER
         yYqbXs4/KfT9cIQeR5U13aoLrScD72bhU5oBfznWxiH1H9wjhdRf5a0JgiNQ2cxz3UuX
         LCLzrKkPz/KznhSPHCBtoDYRO+z0rwEJBEodbXHciJR+JGc8AzHS8gBCKDE67HnwHq3A
         QYSA==
X-Gm-Message-State: AOJu0Yz6Xzm19t8NKSR4ZgVWJ57oK1Y5HKlm5gjsMZ4p89JWiGeulVCh
	8GsQz7zpy3v/0yz43JkpxrM/HQlBNAl+O7wKhvxOJdkw0//d9jWiDa8tfdzaEBII6XY6JUnquZv
	ITifo5Dzlr0x8gX8+Trt+bKqXvwZQefyi
X-Gm-Gg: ASbGncv5A7FYm/AMKND698JNMkmUu3jJZNuQgkQdC3roAcjc4umMg5NzEhl6voVWabM
	yQRy9UKJVFS6ZmNNAdNmLwWfuFG0jL2ZUKp/Y5dZ3CNKue4zr36o2p1W0bdCmPSkBjbr0KlwYUe
	DuGA==
X-Google-Smtp-Source: AGHT+IHUaEzOgwZ9VsLKfy//45nNHaXYoE+7SaUf9Ik1aHtWcYDGPxfO2EfONss8QkU/5iEL1A7JbZzvU2MkbCeOKVI=
X-Received: by 2002:a05:6a20:432a:b0:1e1:dbfd:582b with SMTP id
 adf61e73a8af0-1eb21498454mr61557416637.15.1738021778638; Mon, 27 Jan 2025
 15:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126163857.410463-1-linux@jordanrome.com>
In-Reply-To: <20250126163857.410463-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 15:49:26 -0800
X-Gm-Features: AWEUYZmWRoBNB8YI2CD-wENTn8_oIOE4M9dDV8NWvdwiDbEqTrCDTir_FC6BJ5k
Message-ID: <CAEf4BzYcDefO=9esaMJVYzkMYdBDuRO5XwsTt4gR68nvfQcZPw@mail.gmail.com>
Subject: Re: [bpf-next v5 1/3] mm: add copy_remote_vm_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 8:39=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/linux/mm.h |   3 ++
>  mm/memory.c        | 118 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         |  67 +++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
>
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
> index 398c031be9ba..e1ed5095b258 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6714,6 +6714,124 @@ int access_process_vm(struct task_struct *tsk, un=
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
> +               unmap_and_put_page(page, maddr);
> +
> +               if (retval > -1) {

nit: retval >=3D 0 is more conventional, -1 has no special meaning here
(it's -EPERM, if anything), zero does

> +                       /* Found the end of the string */
> +                       buf +=3D retval;
> +                       goto out;
> +               }
> +
> +               retval =3D bytes - 1;
> +               buf +=3D retval;
> +
> +               if (bytes =3D=3D len)
> +                       goto out;
> +
> +               /*
> +                * Because strscpy always NUL terminates we need to
> +                * copy the last byte in the page if we are going to
> +                * load more pages
> +                */
> +               addr +=3D retval;
> +               len -=3D retval;
> +               copy_from_user_page(vma,
> +                               page,
> +                               addr,
> +                               buf,
> +                               maddr + (PAGE_SIZE - 1),
> +                               1);

just realized, you've already unmap_and_put_page(), and yet you are
trying to access it here again. Seems like you'll need to delay that
unmap_and_put

also, stylistical nit: you have tons of short arguments, keep them on
smaller number of lines, it's taking way too much vertical space for
what it is

Also, I was worried about non-zero terminated buf here. It still can
happen if subsequent get_user_page_vma_remote() fails and we exit
early, but we'll end up returning -EFAULT, so perhaps that's not a
problem. On the other hand, it's trivial to do buf[1] =3D '\0'; to keep
that buf always zero-terminated, so maybe I'd do that... And if we do
buf[0] =3D '\0'; at the very beginning, we can document that
copy_remote_vm_str() leaves valid zero-terminated buffer of whatever
it managed to read before EFAULT, which isn't a bad property that
basically comes for free, no?

pw-bot: cr

> +               len -=3D 1;
> +               buf +=3D 1;
> +               addr +=3D 1;
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
> + * not including the trailing NUL. On any error, return -EFAULT.

"On success, leaves a properly NUL-terminated buffer." (or if we do
adjustments I suggested above we can even say "Even on error will
leave properly NUL-terminated buffer with contents that was
successfully read before -EFAULT", or something along those lines).

> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm)
> +               return -EFAULT;
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
> index 9cb6e99215e2..ce24ea829c73 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1701,6 +1701,73 @@ int access_process_vm(struct task_struct *tsk, uns=
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
> +       int ret;
> +       struct vm_area_struct *vma;
> +
> +       if (mmap_read_lock_killable(mm))
> +               return -EFAULT;
> +
> +       /* the access must start within one of the target process's mappi=
ngs */
> +       vma =3D find_vma(mm, addr);
> +       if (vma) {
> +               /* don't overrun this mapping */
> +               if (addr + len >=3D vma->vm_end)

Should we worry about overflows here? check_add_overflow() maybe?

> +                       len =3D vma->vm_end - addr;
> +
> +               /* only read mappings where it is permitted */
> +               if (vma->vm_flags & VM_MAYREAD) {
> +                       ret =3D strscpy(buf, (char *)addr, len);
> +                       if (ret < 0)
> +                               ret =3D len - 1;
> +               } else {
> +                       ret =3D -EFAULT;
> +               }
> +       } else {
> +               ret =3D -EFAULT;
> +       }
> +

nit: might be cleaner to have `ret =3D -EFAULT;` before `if (vma)` and
only set ret on success/overflow?

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
> + * not including the trailing NUL. On any error, return -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm)
> +               return -EFAULT;
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
>

