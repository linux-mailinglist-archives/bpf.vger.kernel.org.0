Return-Path: <bpf+bounces-49157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF49A1483F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C64E188E657
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C91F5610;
	Fri, 17 Jan 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="uTriUNU4"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8B19049B
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080880; cv=none; b=eZON6k0CJSVM+NfpOJQp20J0/jJPZNDet0KoH6xTx6jq2LyklbnxePxiGG+JgewLrcXEoJxEvp7slO51hngfBpva2DzsTQX0orXXMxK9D+lUuC5v4p5Nwvr/1Xpm5Pms1nMoIfMW+eesdTQS3KXaxBgfIUcALsSxIx4Ui2uLmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080880; c=relaxed/simple;
	bh=YGSA5CbwYmEUSgP8xXxZE8xYc8+Mx910sMHZr4WaetY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqcfSSyB4cYrlIKsYWCuIV3H6kRn8MxjBxF63opygTWLvArDvaPXdUH+Cb5bMeZY6TX33tujsarvviP/zKe5dDwqjTXpvWDnt5lypekLiPZ96OnSnk6ZxmQzWGQLP6yttU87QLKJzyIZVg22Bqwf9m7dLTNFJUdma7eHMC1Acl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=uTriUNU4; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737080877; x=1737685677; i=linux@jordanrome.com;
	bh=NHUkJ8oujQfDsLiTqMkqHozkrDqVm9z4cONZsMp0oKQ=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uTriUNU42YJkdZ+zD9jjSjHSnLprxFvQTCoXwr3aAsTJ7fU2MZiQWDR8bopWLgdK
	 MEDrqUU9bYS61H/PdxvJ2YesD+mhiDjNdySuZPK/BUrxQc0B91i05D9gwdzaBLGw2
	 1A7mhSULXUdMeH1pAs6EIEwNZn5O5E5xdk8mGpsmLDaQBR8VONCWGLfttTsTR1O8Y
	 Kzznhf4055xwMnJC9vKxXegGev7uwD+JKrgngEZIxnY+nrPrr2cGIlEzcgKCVAB5V
	 zsEISZZnX25Mnco/cGNSrQTdZDkx904lW59PtBFHeysHY2L3lRat64RYUM4h+dSv8
	 /NQn0+I04TfjlQYVxg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f177.google.com ([209.85.166.177]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MMTgu-1tcQgr2Cre-00A8sD for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 03:22:47
 +0100
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce8c069840so11481945ab.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 18:22:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yx0CntLrGORaCgIysc+4yeqLoL/pxIxfIjcfSvsQ3VGaUTxDUR1
	hdxK21em9v7Razk2oROswglJJcyJlRVZIDXd1yELGOgyjPxHCA1Ha4HGYbZBfqEqJhmu6xNE2TO
	BeTeUb3Y8+/CpfPN9DW7GN7uTep0=
X-Google-Smtp-Source: AGHT+IFR6OFCfJDQjdZa6E7btS+SmM2Bxrw66M2hQBWc0WwX3iQMf1l/RH+4TO4aiKndHBYN/PzfkruidkFQX8LStc8=
X-Received: by 2002:a92:c26b:0:b0:3a7:d792:d6c4 with SMTP id
 e9e14a558f8ab-3cf744beabemr8436275ab.21.1737080567015; Thu, 16 Jan 2025
 18:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107020632.170883-1-linux@jordanrome.com> <CAEf4BzZuAmSn=HxzNBHrAnx3beem+e97ANHTgR-S4Q8yn2A7CA@mail.gmail.com>
In-Reply-To: <CAEf4BzZuAmSn=HxzNBHrAnx3beem+e97ANHTgR-S4Q8yn2A7CA@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 16 Jan 2025 21:22:35 -0500
X-Gmail-Original-Message-ID: <CA+QiOd4iq-UTxayaO7dACFdnJC=qM_FZi7=_LRqzvZEa7vgYEg@mail.gmail.com>
X-Gm-Features: AbW1kvbzbH3vxkrpR0D8T85lIaZiMOhkJFI82AceJSQrSPxAX5QHB4LaBRdqclA
Message-ID: <CA+QiOd4iq-UTxayaO7dACFdnJC=qM_FZi7=_LRqzvZEa7vgYEg@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iubfSgL7slzfwsB3bZkFiKw4DnXZHLjttjjctwfmigCYcddhyeG
 ewUKt4+bt0Z9x+yyvsHhLkkR9/d3WbfADrAc9cGEJkqFkrJD/C5XdqqGm1mUyhygK0bBnI6
 RCpXJPpoX6OfBhzq2aWLNenNr4GHxji/eed2qfI/ETbxf14fGHcq9/7W0FgCgWe1j4KO2uK
 sz3UTtIFPIVmIGRP6phyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lyfw8rDyEB8=;yaHzinZJRjFnq3btWPKMSFi/SeN
 3N3LTSzwOF1SuIYU/WZDFbwpwckiw6aPOvp7N7gsgOM2mCGGIquhCvjkej8r3q75KJc5V5OeM
 mqwSOwKdAE1l0EpQQnG4baOwJnuCCUUJTr1QdPMeylfuCrvAwNoIRJc8pl0VKBI0yMLw2GybI
 ukkW63A7+dFblRlasbZEojwyLfu7e5ZhHhtYBkTMP+4cStp+tdph/Y1C9OAPM1vMJaHKqSXNm
 dJhGCKw1jQ6GNXC+tfbu4bR80mV6qEudAzxpIIzMzIZK1po7HQ2T9I3RMvoMiTYby1pXz1+Z6
 E8aVQo68Fsau+ivLBfgHxbJz1yvCogmtei3tw4m0+OM0Db8JNWZMtJPeMYyfuE/Ieijk9gyLM
 XCTPT+DDo1i9KIX5k8mYW0A9YRPLe9+8nWKj3JsHl6lScYcNd5lLTo5l08ka44neGeqthuab5
 upGieTer2woDGZMh547AlqLaU8kbPGV+ATg5w0VsYd7QnyR5NmhivHYd4oMZRdFlneIFejzAG
 5e0DuZ9EACbLPvx93yL5j77WHwNZgcVC/9pIczIZwu+H/SE1yVS7l60CPLols5WKmqOQlHTBO
 xlQ6WnpD8Wk+S/hCvnnNCzL0ZjR1rUmHxmIBohMrrccje7SQLIVi8gPGW5UVFU3k6FEFRYNVq
 VkPLE8jQ5eIF0kx89Gl4VXnTmk0XR9HfOBn/pTQ3/13p6WGznbxmjH9DC4/W7sHch4pi6QT72
 tGQTU/Zs05EWwGSSK+A3yUCwkfmSZ9RU24lWlXWYR2s7dq1PBdDjy3y9uKJEwse0hdOXxYuDN
 y1/zafREn5oRiOaOYJZIVG3/+sHZEdOIJQqlS6fs4igraR8ym5HcFLX9RcHZtz/nd0FYOeWqz
 CLTCTYfMEoaure92A4I4CybFUuGt+I2NvPqqo7AZ75Met+TEiFgC4sobtUefeSuC6lbfnPXmT
 8IJCKXKsYEI0zp7VQVlYhoQdRp6AD4EacvSEj9fNpznIx9V/Co9x1cJeuJKVszM7hhvtMiCc2
 3zghV7HFp/Sh97CxGlS4Mmzjn5iDhH2PcAFmiVqiZAqQRsNFVzQkJAa+y+aMSdcG3JmfhqHZu
 jQ8RFj3wR3rzyz1lXMPyH815RXaq9D0G0NDkxRxwmS4Azx9QQOGSwFkIZsmZMOe0gJGRt/4Y0
 =

On Fri, Jan 10, 2025 at 4:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 6, 2025 at 6:12=E2=80=AFPM Jordan Rome <linux@jordanrome.com>=
 wrote:
> >
> > This new kfunc will be able to copy a string
> > from another process's/task's address space.
>
> nit: this is kernel code, task is unambiguous, so I'd drop the
> "process" reference here
>
> > This is similar to `bpf_copy_from_user_str`
> > but accepts a `struct task_struct*` argument.
> >
> > This required adding an additional function
> > in memory.c, namely `copy_str_from_process_vm`,
> > which works similar to `access_process_vm`
> > but utilizes the `strncpy_from_user` helper
> > and only supports reading/copying and not writing.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  include/linux/mm.h   |   3 ++
> >  kernel/bpf/helpers.c |  46 ++++++++++++++++++++
> >  mm/memory.c          | 101 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 150 insertions(+)
> >
>
> please check kernel test bot's complains as well

Maybe I need an entry in nommu.c as well for 'copy_remote_vm_str'?

>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c39c4945946c..52b304b20630 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2484,6 +2484,9 @@ extern int access_process_vm(struct task_struct *=
tsk, unsigned long addr,
> >  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
> >                 void *buf, int len, unsigned int gup_flags);
> >
> > +extern int copy_str_from_process_vm(struct task_struct *tsk, unsigned =
long addr,
> > +               void *buf, int len, unsigned int gup_flags);
>
> nit: curious what mm folks think about naming, I'd go with a slightly
> less verbose naming: "copy_remote_vm_str" (copy vs access, _str suffix
> for non fixed-sized semantics marking)

Ack.

>
> for the next revision, let's split out mm parts from helpers parts, I
> don't think we lose much as this new internal API is self-contained,
> and it will be easier for mm folks to review

Ack.

>
> > +
> >  long get_user_pages_remote(struct mm_struct *mm,
> >                            unsigned long start, unsigned long nr_pages,
> >                            unsigned int gup_flags, struct page **pages,
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index cd5f9884d85b..45d41b7a9906 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3072,6 +3072,51 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned =
long *flags__irq_flag)
> >         local_irq_restore(*flags__irq_flag);
> >  }
> >
> > +/**
> > + * bpf_copy_from_user_task_str() - Copy a string from an task's addres=
s space
> > + * @dst:             Destination address, in kernel space.  This buffe=
r must be
> > + *                   at least @dst__sz bytes long.
> > + * @dst__sz:         Maximum number of bytes to copy, includes the tra=
iling NUL.
> > + * @unsafe_ptr__ign: Source address in the task's address space.
> > + * @tsk:             The task whose address space will be used
> > + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> > + *
> > + * Copies a NULL-terminated string from a task's address space to BPF =
space.
>
> there is no "BPF space", really... maybe "copies string into *dst* buffer=
"

Ack.

>
> > + * If user string is too long this will still ensure zero termination =
in the
> > + * dst buffer unless buffer size is 0.
> > + *
> > + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on suc=
cess and
> > + * memset all of @dst on failure.
> > + */
> > +__bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz, co=
nst void __user *unsafe_ptr__ign, struct task_struct *tsk, u64 flags)
>
> this looks like a long line, does it fit under 100 characters?

I'll fix it in the next revision.

>
> > +{
> > +       int count =3D dst__sz - 1;
> > +       int ret =3D 0;
> > +
> > +       if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> > +               return -EINVAL;
> > +
> > +       if (unlikely(!dst__sz))
> > +               return 0;
> > +
> > +       ret =3D copy_str_from_process_vm(tsk, (unsigned long)unsafe_ptr=
__ign, dst, count, 0);
> > +
> > +       if (ret <=3D 0) {
> > +               if (flags & BPF_F_PAD_ZEROS)
> > +                       memset((char *)dst, 0, dst__sz);
>
> nit: no need for (char *) cast? memset takes void *, I think
>
> > +               return ret;
>
> if ret =3D=3D 0, is that an error? If so, `return ret ?: -EINVAL;` or
> something along those lines?

Good catch.

>
> pw-bot: cr
>
> > +       }
> > +
> > +       if (ret < count) {
> > +               if (flags & BPF_F_PAD_ZEROS)
> > +                       memset((char *)dst + ret, 0, dst__sz - ret);
> > +       } else {
> > +               ((char *)dst)[count] =3D '\0';
> > +       }
> > +
> > +       return ret + 1;
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(generic_btf_ids)
> > @@ -3164,6 +3209,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW=
)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> >  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE=
)
> >  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NUL=
L | KF_SLEEPABLE)
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 75c2dfd04f72..514490bd7d6d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6673,6 +6673,75 @@ static int __access_remote_vm(struct mm_struct *=
mm, unsigned long addr,
> >         return buf - old_buf;
> >  }
> >
> > +/*
> > + * Copy a string from another process's address space as given in mm.
> > + * Don't return partial results. If there is any error return -EFAULT.
>
> What does "don't return partial results" mean? What happens if we read
> part of a string and then fail to read the rest?

As per the last sentence, if we fail to read the rest of the string then
an -EFAULT is returned.

>
> > + */
> > +static int __copy_str_from_remote_vm(struct mm_struct *mm, unsigned lo=
ng addr,
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
> > +               mmap_read_unlock(mm);
> > +               return -EFAULT;
>
> maybe let's do (so that we do mmap_read_unlock in just one place)

Ack.

>
> err =3D -EFAULT;
> goto err_out;
>
> and then see below
>
> > +       }
> > +
> > +       while (len) {
> > +               int bytes, offset, retval;
> > +               void *maddr;
> > +               struct vm_area_struct *vma =3D NULL;
> > +               struct page *page =3D get_user_page_vma_remote(mm, addr=
,
> > +                                                            gup_flags,=
 &vma);
> > +
>
> nit: I'd split page declaration and assignment and kept
> get_user_page_vma_remote() invocation on a single line

Ack.

>
> > +               if (IS_ERR(page)) {
> > +                       /*
> > +                        * Treat as a total failure for now until we de=
cide how
> > +                        * to handle the CONFIG_HAVE_IOREMAP_PROT case =
and
> > +                        * stack expansion.
> > +                        */
> > +                       err =3D -EFAULT;
> > +                       break;
> > +               }
> > +
> > +               bytes =3D len;
> > +               offset =3D addr & (PAGE_SIZE - 1);
> > +               if (bytes > PAGE_SIZE - offset)
> > +                       bytes =3D PAGE_SIZE - offset;
> > +
> > +               maddr =3D kmap_local_page(page);
> > +               retval =3D strncpy_from_user(buf, (const char __user *)=
addr, bytes);
>
> you are not using maddr... that seems wrong (even if it works due to
> how kmap_local_page is currently implemented)

How do you think we should handle it then?

>
> > +               unmap_and_put_page(page, maddr);
> > +
> > +               if (retval < 0) {
> > +                       err =3D retval;
> > +                       break;
> > +               }
> > +
> > +               len -=3D retval;
> > +               buf +=3D retval;
> > +               addr +=3D retval;
> > +
> > +               /* Found the end of the string */
> > +               if (retval < bytes)
> > +                       break;
> > +       }
>
> err_out: here
>
> > +       mmap_read_unlock(mm);
> > +
> > +       if (err)
> > +               return err;
> > +
> > +       return buf - old_buf;
> > +}
> > +
> >  /**
> >   * access_remote_vm - access another process' address space
> >   * @mm:                the mm_struct of the target address space
> > @@ -6714,6 +6783,38 @@ int access_process_vm(struct task_struct *tsk, u=
nsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(access_process_vm);
> >
> > +/**
> > + * copy_str_from_process_vm - copy a string from another process's add=
ress space.
> > + * @tsk:       the task of the target address space
> > + * @addr:      start address to access
>
> access -> read from

Ack.

>
> > + * @buf:       source or destination buffer
>
> for this api it's always the destination, right?

Right. Will fix.

>
> > + * @len:       number of bytes to transfer
> > + * @gup_flags: flags modifying lookup behaviour
> > + *
> > + * The caller must hold a reference on @mm.
> > + *
> > + * Return: number of bytes copied from source to destination. If the s=
tring
> > + * is shorter than @len then return the length of the string.
>
> and if the string is longer than @len, then what happens? we should
> either specify or drop the "if string is shorter bit" and make it
> unambiguous whether terminating zero is included or not

I'll make it clearer.

>
> > + * On any error, return -EFAULT.
> > + */
> > +int copy_str_from_process_vm(struct task_struct *tsk, unsigned long ad=
dr,
> > +               void *buf, int len, unsigned int gup_flags)
> > +{
> > +       struct mm_struct *mm;
> > +       int ret;
> > +
> > +       mm =3D get_task_mm(tsk);
> > +       if (!mm)
> > +               return -EFAULT;
> > +
> > +       ret =3D __copy_str_from_remote_vm(mm, addr, buf, len, gup_flags=
);
> > +
> > +       mmput(mm);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(copy_str_from_process_vm);
> > +
> >  /*
> >   * Print the name of a VMA.
> >   */
> > --
> > 2.43.5
> >

