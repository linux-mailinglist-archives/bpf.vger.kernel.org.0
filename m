Return-Path: <bpf+bounces-49967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E003A20CF4
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48AE1881CBB
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED421D5ADD;
	Tue, 28 Jan 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="sH7bBCvC"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F41D5165
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077816; cv=none; b=l/FuWOCjvwuAKxJsDr+9Xpk+1nbE856sWQEiCnpXpSgZ4fBoLMMWGU7IbHhRok+1bqPEciPlNDBgaeAMPMCsBMbRz9tzcSyBuEalM/zrc7mQCKfGH8xgwFmApe2rzASwyGuNasuNpP8L4xyzx9UAF0bka7vEAcxV90o0zIUgn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077816; c=relaxed/simple;
	bh=ZwNU48bwexlwaMDlDCMcSHyEV6t5TKZqBhdenMeMmfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3rDvw4ytZ2BS/cjC2XcoAypLd8LK+nRBwjAYaPX+aMudLO2DdRQMzfHHp+W78nF0RAmnTpkbWF99XIfUi4c+XhteS3YMrtuj7kafJif8ODsF0IKN3uGzimkUAq+br1nWqDYrBJ/HmuVmYOQmTagqWt/I69eSFqXBXoYghrJF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=sH7bBCvC; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1738077807; x=1738682607; i=linux@jordanrome.com;
	bh=dviztsrN6r3+sJz8wDFyEpqNs703txYKEZgvVUo9trw=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sH7bBCvCnL1XOuCqcWAH/H3jY4gT0bNdp4KHBCXJgQ7OYHA7XOq23Gbh4OAxg3c1
	 +lFLQ7i7s0FsfKEqoePPi6+TTC90B6hdrjxQECHoUPGnzPQkghx3cE7plpNd0/9b4
	 98U49sowVSq6YiJ4vZzOsnr6aV3nKplg8tzz8Hac2xguT0g7iV9vHhGj88vfUdQcw
	 li2LpAaUSWi9uDbelP3NoXk7L8+BBfyFjfqAxPovpPrkC9WVizQGnpZdWLYqM5XXf
	 IZKCmFIxD3/NdJBZQCZVRyoSz+Walr1ijFyhuYXbvXZeT87NTJTfDKkCEpTWRukvh
	 eJiPjwEaHa7ZFz0f1w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f179.google.com ([209.85.166.179]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MvJPR-1tLGeN3u41-00vcF7 for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 16:23:26
 +0100
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cf8f2c34a5so41929415ab.0
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 07:23:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwaRUlD82VHjGHIb5p9kq+/xPqAQFgpic3KB0t2qYqF4C1lkj0A
	8MFy6Wdw18kYIE+xEq5rBiDqcatMFHKARVxgeU4yGpIIaVE8hP/kA6xnAh6jfQWyQ/EQFzTxVsq
	gx0p5ht0OnsbzU9dqRDzGJKy7BR0=
X-Google-Smtp-Source: AGHT+IFA7V3WZTORdWHz9Ixoi8Wx6BJeLy8NoBN4lsjAoP2lDCzQQBZApCt9YdDDjzp2PcLRhpIc6gXFIF1LpSHzAEQ=
X-Received: by 2002:a92:ca0a:0:b0:3cf:c8bf:3b87 with SMTP id
 e9e14a558f8ab-3cfc8bf3cb0mr140284785ab.1.1738077806421; Tue, 28 Jan 2025
 07:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126163857.410463-1-linux@jordanrome.com> <CAEf4BzYcDefO=9esaMJVYzkMYdBDuRO5XwsTt4gR68nvfQcZPw@mail.gmail.com>
In-Reply-To: <CAEf4BzYcDefO=9esaMJVYzkMYdBDuRO5XwsTt4gR68nvfQcZPw@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Tue, 28 Jan 2025 10:23:15 -0500
X-Gmail-Original-Message-ID: <CA+QiOd64re2t_u0tHKx0sSXTbD6vuET4nG+YfN6hhEM_YpKv5g@mail.gmail.com>
X-Gm-Features: AWEUYZmD5R9qgG6wb5qN2aJde3RCAr02FoQFbl4F5NzEp9wPPikB6YRRSr_EPnc
Message-ID: <CA+QiOd64re2t_u0tHKx0sSXTbD6vuET4nG+YfN6hhEM_YpKv5g@mail.gmail.com>
Subject: Re: [bpf-next v5 1/3] mm: add copy_remote_vm_str
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+yFz385uSpyoaCiHgvZBscQA7ckCk1YtiRvzwVzVarl+QbQ7O8u
 XXS/PoEmi64pfMNpmUyyvd/uL6TjdKLXdkkeevwbzHpHaDgMSEjNST3rC4wig93BrM+hpo1
 4zoxpToVQ9a+2pPp+n2BO5ujlBNJ29V7HVCa7EUglLjUK0/iokO6gCDUsNRzijWa5NcdbIq
 NHwsT5Ljm+FzwKEcl3Rog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6LxE0Xn6/v0=;OYw7SSjfCSw3g/fvR8vlAR6YskB
 vZTl3iT7NDod7xi5oKVhUHsEbSb+X0v925OV4WkP2/Yt9LrX7pIfM/UmmAxV/nqJyyp6DAACI
 ycZ7hTuzePQEVCHk7DZ5TXtedHPseSdiGuoikcEMeZMlZXXkEb6jZKZYxuI2ojKGSqaMM7RJ8
 Rf4be3+7SUDiVQ3GFt4eqqgaIW+Ej9Q4uy42vKnx41jwxsnwU+vc7/vTr1ffeN2ew2/ub39DL
 VmJdrVkGBDSkSlSaTAva9VzrgqIfQuusvzdYdcblO41OpmRLTK9+7GN6/WJTfzqeA6bzCuIIM
 IYXYhu/epHNVETLeGRo4a/OOK2fNijix1R5eN+7mklRMP3RnLnhOsWEF2ZoOqLWyVv1UG87rC
 qjAZzLkGJsmNeA9bAGtGF8U66FpDQwdg4YTh8+zwpV/JMPA5btJaIvkn6dNDHZOZJGOmVQGJ7
 fW3Ze45JU3q5RTvbsRJMdtFrebSWPdtbUHUIk9uNfQy2CmFm9ELMJNEP9PNKkNvaOqQ194wla
 dKw53qr9crVe7hjw3ab94ejKcNW2QgjvjM2xiu1j2EvlG8ND6QQrkWjvkVIuyuXts+aDAcBHH
 J3gaWhX4G1gfSoh0LHOGJ9ic7qI0RqIdfR5o9R09mf0vyJnb88AlCQnzHACnzHXWKobZOcNg4
 3nFKGDXGh7TmjfJESIzaq1Dg4DzLPWRrbh1drSMLYRZdFYmKsuLhKQdJ26CuNxSYP20m/WNkR
 85J3yqaSl/RXSIfRjVBsgZ+dMvIV8lB4kY8Avq771zG3+BodiGNYgENPwiubQqBjRVFhM55ym
 QgkP+sBUPoALtM8+zG8Byk+lXeDOhk/t/Iou+dcIs2MdN1XWC0UskaJrO79ubOE6RNfR5mz1W
 d24lK1cguIh/u3zXKmUOhOhhYTERYiDZpqH8ixNHgPdnvoQhzr7fYh9PGsVTWLfdzEm0j3On5
 77kNNKp6MuiH7k5GMpd6Xk8yArpY9nlaf5EnppkAsEBBYvty5OuBvggl0IZSXcYdthecXCSV4
 f4/CNNGV7yCAcXbp8iGUDHcXCxqlFQWsyfLCOe3ReDGnbtuUgLDTzIz4fM9X5tl7mOWJLkRYs
 Yp8qaRExMHZbt+zO/L9ggnaeseFPDqzW/EC7JVWnj0r9sRolTuhWGxUbcyFwYbnn4pGBRJPrf
 YW3JXvTZ0OmKv8gyrSmGYn5Jz1l1iYNhGe6l/3hv7Q5wJF23gdEK1GxAGHXO0FX2WO/avi1bM
 VR6ZsnsYYHeo97ev2UU8BChDiREoj1cvJw==

On Mon, Jan 27, 2025 at 6:49=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Jan 26, 2025 at 8:39=E2=80=AFAM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > Similar to `access_process_vm` but specific to strings.
> > Also chunks reads by page and utilizes `strscpy`
> > for handling null termination.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  include/linux/mm.h |   3 ++
> >  mm/memory.c        | 118 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c         |  67 +++++++++++++++++++++++++
> >  3 files changed, 188 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f02925447e59..f3a05b3eb2f2 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2485,6 +2485,9 @@ extern int access_process_vm(struct task_struct *=
tsk, unsigned long addr,
> >  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
> >                 void *buf, int len, unsigned int gup_flags);
> >
> > +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long a=
ddr,
> > +               void *buf, int len, unsigned int gup_flags);
> > +
> >  long get_user_pages_remote(struct mm_struct *mm,
> >                            unsigned long start, unsigned long nr_pages,
> >                            unsigned int gup_flags, struct page **pages,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 398c031be9ba..e1ed5095b258 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6714,6 +6714,124 @@ int access_process_vm(struct task_struct *tsk, =
unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(access_process_vm);
> >
> > +/*
> > + * Copy a string from another process's address space as given in mm.
> > + * If there is any error return -EFAULT.
> > + */
> > +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long ad=
dr,
> > +                             void *buf, int len, unsigned int gup_flag=
s)
> > +{
> > +       void *old_buf =3D buf;
> > +       int err =3D 0;
> > +
> > +       if (mmap_read_lock_killable(mm))
> > +               return -EFAULT;
> > +
> > +       /* Untag the address before looking up the VMA */
> > +       addr =3D untagged_addr_remote(mm, addr);
> > +
> > +       /* Avoid triggering the temporary warning in __get_user_pages *=
/
> > +       if (!vma_lookup(mm, addr)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       while (len) {
> > +               int bytes, offset, retval;
> > +               void *maddr;
> > +               struct page *page;
> > +               struct vm_area_struct *vma =3D NULL;
> > +
> > +               page =3D get_user_page_vma_remote(mm, addr, gup_flags, =
&vma);
> > +
> > +               if (IS_ERR(page)) {
> > +                       /*
> > +                        * Treat as a total failure for now until we de=
cide how
> > +                        * to handle the CONFIG_HAVE_IOREMAP_PROT case =
and
> > +                        * stack expansion.
> > +                        */
> > +                       err =3D -EFAULT;
> > +                       goto out;
> > +               }
> > +
> > +               bytes =3D len;
> > +               offset =3D addr & (PAGE_SIZE - 1);
> > +               if (bytes > PAGE_SIZE - offset)
> > +                       bytes =3D PAGE_SIZE - offset;
> > +
> > +               maddr =3D kmap_local_page(page);
> > +               retval =3D strscpy(buf, maddr + offset, bytes);
> > +               unmap_and_put_page(page, maddr);
> > +
> > +               if (retval > -1) {
>
> nit: retval >=3D 0 is more conventional, -1 has no special meaning here
> (it's -EPERM, if anything), zero does
>

Ack.

> > +                       /* Found the end of the string */
> > +                       buf +=3D retval;
> > +                       goto out;
> > +               }
> > +
> > +               retval =3D bytes - 1;
> > +               buf +=3D retval;
> > +
> > +               if (bytes =3D=3D len)
> > +                       goto out;
> > +
> > +               /*
> > +                * Because strscpy always NUL terminates we need to
> > +                * copy the last byte in the page if we are going to
> > +                * load more pages
> > +                */
> > +               addr +=3D retval;
> > +               len -=3D retval;
> > +               copy_from_user_page(vma,
> > +                               page,
> > +                               addr,
> > +                               buf,
> > +                               maddr + (PAGE_SIZE - 1),
> > +                               1);
>
> just realized, you've already unmap_and_put_page(), and yet you are
> trying to access it here again. Seems like you'll need to delay that
> unmap_and_put
>

Good catch on the `unmap_and_put_page` - will fix.

> also, stylistical nit: you have tons of short arguments, keep them on
> smaller number of lines, it's taking way too much vertical space for
> what it is
>

Ack.

> Also, I was worried about non-zero terminated buf here. It still can
> happen if subsequent get_user_page_vma_remote() fails and we exit
> early, but we'll end up returning -EFAULT, so perhaps that's not a
> problem. On the other hand, it's trivial to do buf[1] =3D '\0'; to keep
> that buf always zero-terminated, so maybe I'd do that... And if we do
> buf[0] =3D '\0'; at the very beginning, we can document that
> copy_remote_vm_str() leaves valid zero-terminated buffer of whatever
> it managed to read before EFAULT, which isn't a bad property that
> basically comes for free, no?

Sounds good. Will update to always nul terminate the buffer.
It is a bit odd to me that users would read the buffer at all if an error
is returned but, at the same time, this implementation is doing
exactly that if strscopy returns E2BIG.

>
> pw-bot: cr
>
> > +               len -=3D 1;
> > +               buf +=3D 1;
> > +               addr +=3D 1;
> > +       }
> > +
> > +out:
> > +       mmap_read_unlock(mm);
> > +       if (err)
> > +               return err;
> > +
> > +       return buf - old_buf;
> > +}
> > +
> > +/**
> > + * copy_remote_vm_str - copy a string from another process's address s=
pace.
> > + * @tsk:       the task of the target address space
> > + * @addr:      start address to read from
> > + * @buf:       destination buffer
> > + * @len:       number of bytes to copy
> > + * @gup_flags: flags modifying lookup behaviour
> > + *
> > + * The caller must hold a reference on @mm.
> > + *
> > + * Return: number of bytes copied from @addr (source) to @buf (destina=
tion);
> > + * not including the trailing NUL. On any error, return -EFAULT.
>
> "On success, leaves a properly NUL-terminated buffer." (or if we do
> adjustments I suggested above we can even say "Even on error will
> leave properly NUL-terminated buffer with contents that was
> successfully read before -EFAULT", or something along those lines).
>

Ack.

> > + */
> > +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> > +               void *buf, int len, unsigned int gup_flags)
> > +{
> > +       struct mm_struct *mm;
> > +       int ret;
> > +
> > +       mm =3D get_task_mm(tsk);
> > +       if (!mm)
> > +               return -EFAULT;
> > +
> > +       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> > +
> > +       mmput(mm);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> > +
> >  /*
> >   * Print the name of a VMA.
> >   */
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 9cb6e99215e2..ce24ea829c73 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -1701,6 +1701,73 @@ int access_process_vm(struct task_struct *tsk, u=
nsigned long addr, void *buf, in
> >  }
> >  EXPORT_SYMBOL_GPL(access_process_vm);
> >
> > +/*
> > + * Copy a string from another process's address space as given in mm.
> > + * If there is any error return -EFAULT.
> > + */
> > +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long ad=
dr,
> > +                             void *buf, int len)
> > +{
> > +       int ret;
> > +       struct vm_area_struct *vma;
> > +
> > +       if (mmap_read_lock_killable(mm))
> > +               return -EFAULT;
> > +
> > +       /* the access must start within one of the target process's map=
pings */
> > +       vma =3D find_vma(mm, addr);
> > +       if (vma) {
> > +               /* don't overrun this mapping */
> > +               if (addr + len >=3D vma->vm_end)
>
> Should we worry about overflows here? check_add_overflow() maybe?

Ack.

>
> > +                       len =3D vma->vm_end - addr;
> > +
> > +               /* only read mappings where it is permitted */
> > +               if (vma->vm_flags & VM_MAYREAD) {
> > +                       ret =3D strscpy(buf, (char *)addr, len);
> > +                       if (ret < 0)
> > +                               ret =3D len - 1;
> > +               } else {
> > +                       ret =3D -EFAULT;
> > +               }
> > +       } else {
> > +               ret =3D -EFAULT;
> > +       }
> > +
>
> nit: might be cleaner to have `ret =3D -EFAULT;` before `if (vma)` and
> only set ret on success/overflow?

Ack.

>
> > +       mmap_read_unlock(mm);
> > +       return ret;
> > +}
> > +
> > +/**
> > + * copy_remote_vm_str - copy a string from another process's address s=
pace.
> > + * @tsk:       the task of the target address space
> > + * @addr:      start address to read from
> > + * @buf:       destination buffer
> > + * @len:       number of bytes to copy
> > + * @gup_flags: flags modifying lookup behaviour (unused)
> > + *
> > + * The caller must hold a reference on @mm.
> > + *
> > + * Return: number of bytes copied from @addr (source) to @buf (destina=
tion);
> > + * not including the trailing NUL. On any error, return -EFAULT.
> > + */
> > +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> > +               void *buf, int len, unsigned int gup_flags)
> > +{
> > +       struct mm_struct *mm;
> > +       int ret;
> > +
> > +       mm =3D get_task_mm(tsk);
> > +       if (!mm)
> > +               return -EFAULT;
> > +
> > +       ret =3D __copy_remote_vm_str(mm, addr, buf, len);
> > +
> > +       mmput(mm);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> > +
> >  /**
> >   * nommu_shrink_inode_mappings - Shrink the shared mappings on an inod=
e
> >   * @inode: The inode to check
> > --
> > 2.43.5
> >
> >

