Return-Path: <bpf+bounces-66926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D343EB3B147
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F48980A45
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DCA21772D;
	Fri, 29 Aug 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHEFzZNb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789FD515;
	Fri, 29 Aug 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436559; cv=none; b=IiA4OjE4Cfy+YEbPmaZy8m/xBITzVhFRT1ggnLdlUeH4muh4HRDHO6eAZR9YlVerZJcT7dJYxExC/8RmhChkHASDebS+jvFPknfTroYwUBjIg0GO1dBoIBCmqESSkD7euwacX5nwzIfk4E80n/ARoUAJsgQ7Rieq/fVoslzlm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436559; c=relaxed/simple;
	bh=wAUCg6oBQeQXxP6KLZilCzzqmmz2migi9ZWOTdFikg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvJO5gEOrpE4qjvHL7r200FPyWF/pzgCn4LVCQUhKDlOQpuIlSFJOOVQKNkzKd53CqrpzxB0ZM0Yaw1AGcFeXiu4fYup0M5Eedms9cvrQt/UHCMFlOYmbzaISf9oZuUTENsULxylJq27W7fNhjWILtObBF+QJueXQECKq27Eyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHEFzZNb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ddadde494so14619886d6.1;
        Thu, 28 Aug 2025 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436556; x=1757041356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhgmqxKLJuOaLZcUXD5MEQh1DmQDI8mHzCcmyP5IxbU=;
        b=FHEFzZNbu9t56r3ir26v1LNj+Z7jJDh8NJ7pk12AbNBQ8FvIh9iSTWCXw3ke3rqVHI
         HEhaHDY/GBiaz0pMEagxjaxuUASwZUacjBkx8fF4FJ6TidNIe89Q2EoyW75XX2hrNueH
         fUrBV02y1YX1IIm0myOt25V5GwEVLTc1k6W9aCa37Pl+cKcSH9dQ5preinr5puTZB/WO
         qWWVm3CTPWgPGT5kmMsWALndsaTn9Tp7yjcZT89gQ1Rw2PHzZ5yAuujX5FKkBSV7apNw
         GMwvCgrj96a6ENVNHdRacvDRNJ4kp3IDdQoziHRw2is/tH0PJBy+cNgToqpMg3kkG+Ba
         i8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436556; x=1757041356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhgmqxKLJuOaLZcUXD5MEQh1DmQDI8mHzCcmyP5IxbU=;
        b=H9XKLTAOn/8NlpJKDnlwUtFMgnMY+5hUjfrNOD91SPTVbeEjnxUWZCzphIvP2uzpgP
         X3g8r5yFlQuaLunf9saIYu1uY/3Bacgw7xs7soEvOLbT9leqIxQuRZ6Kx1eIuXNt0+De
         PqYEhAIucnCDJLWMrxQxxbV/DHvAEwPQDqad4kBoEPqwFu9fOTdQuAi4YHtDqqWSj9R2
         q06dr6UUT4qZMO1j1b+lMLtx6Pr4G3KirGTBCZqCpImI2HOE2iro37cxHaMuKpeHk0Vj
         +RxDgZfuwjtivdLZlL9oZe72DlLq9MicBIMssOdjEftr7yak9kNh4TJ6xyIoYHgJHei4
         IDGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5hEMxtPdk3g87r1jQj1aOcsRTTV4UVsMEEu8EZxZM4nTeQHWpszUGnhnZo8wXM1KoWGdaWlZGez4w@vger.kernel.org, AJvYcCWRkUmPF+p4SGFXoCrsmQGOzYDjJePcu7ep1lArJFUID0K6v17YrTwUUdfy9TsczYt5g00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAowyoXO0mAbOkMG4dUhT7DE6Wm0ca7SdiilboFw3GYfpMN/q
	NZ5wQ64PUwCeAld63UN1NXFxR7htrrUU9x56cInFwin8TdKsFhyN+bGl3t0exH5IfbS70HXq4oz
	tI1/MLxatNPRd2fbCm9SbsWgPKKeeyIM=
X-Gm-Gg: ASbGnct2ekCAYT7smIdwWZqF6Xd4rkCod4qtpStTOolJbYng/XHOOmhzCiWIO8zWTia
	CtYtPfaCaVS7PI9u5DteIaqPw+wbSQOmZt3QqoV3Fwxqmdy8NqBggJSX6qCA37mgPwTxvqweX76
	JMp8z55V9KL2/Kzk60hyh/Jh2+TalD5hRN0N9TMxPrZxsv0p/FPQeQnNTznr9P/KC3y+uSDoT6Y
	/Hrk+W6YoyOZLqV7rQO0qMw6QhekjkPF1SQYJXLkrkoE7ATfb5BMuZ6MQ+Z
X-Google-Smtp-Source: AGHT+IFCA/ufNb9acmpb5g9POQpHx+87MOh9EsKN9gSIn+QdiN5qMP5IrlOxS3qCWOgy9JnxZJsDawQ/kj3NdQ9qbU4=
X-Received: by 2002:a05:6214:2347:b0:707:4c0c:5316 with SMTP id
 6a1803df08f44-70d97205f05mr317023876d6.46.1756436555740; Thu, 28 Aug 2025
 20:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local> <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
In-Reply-To: <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 11:01:59 +0800
X-Gm-Features: Ac12FXwg5i-SVMnPOKBwFF6Xwxs19nlAAA3ABnFBax3YfLYk0XDqXqEAe2d4hTE
Message-ID: <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> > On Wed, Aug 27, 2025 at 11:03=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Aug 26, 2025 at 03:19:39PM +0800, Yafang Shao wrote:
> > > > This patch introduces a new BPF struct_ops called bpf_thp_ops for d=
ynamic
> > > > THP tuning. It includes a hook get_suggested_order() [0], allowing =
BPF
> > > > programs to influence THP order selection based on factors such as:
> > > > - Workload identity
> > > >   For example, workloads running in specific containers or cgroups.
> > > > - Allocation context
> > > >   Whether the allocation occurs during a page fault, khugepaged, or=
 other
> > > >   paths.
> > > > - System memory pressure
> > > >   (May require new BPF helpers to accurately assess memory pressure=
.)
> > > >
> > > > Key Details:
> > > > - Only one BPF program can be attached at a time, but it can be upd=
ated
> > > >   dynamically to adjust the policy.
> > > > - Supports automatic mTHP order selection and per-workload THP poli=
cies.
> > > > - Only functional when THP is set to madise or always.
> > > >
> > > > It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> > > > This feature is unstable and may evolve in future kernel versions.
> > > >
> > > > Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@r=
edhat.com/ [0]
> > > > Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@l=
ucifer.local/ [1]
> > > >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  include/linux/huge_mm.h    |  15 +++
> > > >  include/linux/khugepaged.h |  12 ++-
> > > >  mm/Kconfig                 |  12 +++
> > > >  mm/Makefile                |   1 +
> > > >  mm/bpf_thp.c               | 186 +++++++++++++++++++++++++++++++++=
++++
> > >
> > > Please add new files to MAINTAINERS as you add them.
> >
> > will do it.
> >
> > >
> > > >  mm/huge_memory.c           |  10 ++
> > > >  mm/khugepaged.c            |  26 +++++-
> > > >  mm/memory.c                |  18 +++-
> > > >  8 files changed, 273 insertions(+), 7 deletions(-)
> > > >  create mode 100644 mm/bpf_thp.c
> > > >
> > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > index 1ac0d06fb3c1..f0c91d7bd267 100644
> > > > --- a/include/linux/huge_mm.h
> > > > +++ b/include/linux/huge_mm.h
> > > > @@ -6,6 +6,8 @@
> > > >
> > > >  #include <linux/fs.h> /* only for vma_is_dax() */
> > > >  #include <linux/kobject.h>
> > > > +#include <linux/pgtable.h>
> > > > +#include <linux/mm.h>
> > >
> > > Hm this is a bit weird as mm.h includes huge_mm... I guess it will be=
 handled by
> > > header defines but still.
> >
> > Some refactoring is needed for these two header files, but we can
> > handle it separately later.
> >
> > >
> > > >
> > > >  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> > > >  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_=
mm,
> > > > @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
> > > >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> > > >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> > > >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > > > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attach=
ed */
> > > >  };
> > > >
> > > >  struct kobject;
> > > > @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void=
)
> > > >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> > > >  }
> > > >
> > > > +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> > > > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struc=
t *vma__nullable,
> > > > +                     u64 vma_flags, enum tva_type tva_flags, int o=
rders);
> > >
> > > Not a massive fan of this naming to be honest. I think it should expl=
icitly
> > > reference bpf, e.g. bpf_hook_thp_get_order() or something.
> >
> > will change it to bpf_hook_thp_get_orders().
>
> Thanks!
>
> >
> > >
> > > Right now this is super unclear as to what it's for.
> > >
> > > Also wrt vma_flags - this type is wrong :) it's vm_flags_t and going =
to change
> > > to a bitmap of unlimiiteeed size soon. So probs best not to pass arou=
nd as value
> > > type either.
> >
> > As replied in another thread. I will change it.
>
> Thanks. Will check the other thread.
>
> >
> > >
> > > But unclear us to purpose as mentioned elsewhere.
> > >
> > > And also get_suggested_order() should be get_suggested_orderS() no? A=
s you
> > > seem later in the code to be referencing a bitfield?
> >
> > Right, it should be bpf_hook_thp_get_orderS().
>
> Thanks!
>
> >
> > >
> > > Also will mm ever !=3D vma->vm_mm?
> >
> > No it can't. It can be guaranteed by the caller.
>
> In this case we don't need to pass mm separately then right?

Right, we need to pass either @mm or @vma. However, there are cases
where vma information is not available at certain call sites, such as
in khugepaged. In those cases, we need to pass @mm instead.

>
> >
> > >
> > > Are we hacking this for the sake of overloading what this does?
> >
> > The @vma is actually unneeded. I will remove it.
>
> Ah OK.
>
> I am still a little concerned about passing around a value reference to t=
he VMA
> flags though, esp as this type can + will change in future (not sure what=
 that
> means for BPF).
>
> We may go to e.g. a 128 bit bitmap there etc.

As mentioned in another thread, we only need to determine whether the
flag is VM_HUGEPAGE or VM_NOHUGEPAGE, so it can be simplified.

>
>
> >
> > >
> > > Also if we're returning a bitmask of orders which you seem to be (not=
 sure I
> > > like that tbh - I feel like we shoudl simply provide one order but op=
en for
> > > disucssion) - shouldn't it return an unsigned long?
> >
> > We are indifferent to whether a single order or a bitmask is returned,
> > as we only use order-0 and order-9. We have no use cases for
> > middle-order pages, though this feature might be useful for other
> > architectures or for some special use cases.
>
> Well surely we want to potentially specify a mTHP under certain circumsta=
nces
> no?

Perhaps there are use cases, but I haven=E2=80=99t found any use cases for
this in our production environment. On the other hand, I can clearly
see a risk that it could lead to more costly high-order allocations.

>
> In any case I feel it's worth making any bitfield a system word size.
>
> >
> > >
> > > > +#else
> > > > +static inline int
> > > > +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *v=
ma__nullable,
> > > > +                 u64 vma_flags, enum tva_type tva_flags, int order=
s)
> > > > +{
> > > > +     return orders;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static inline int highest_order(unsigned long orders)
> > > >  {
> > > >       return fls_long(orders) - 1;
> > > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.=
h
> > > > index eb1946a70cff..d81c1228a21f 100644
> > > > --- a/include/linux/khugepaged.h
> > > > +++ b/include/linux/khugepaged.h
> > > > @@ -4,6 +4,8 @@
> > > >
> > > >  #include <linux/mm.h>
> > > >
> > > > +#include <linux/huge_mm.h>
> > > > +
> > >
> > > Hm this is iffy too, There's probably a reason we didn't include this=
 before,
> > > the headers can be so so fragile. Let's be cautious...
> >
> > I will check.
>
> Thanks!
>
> >
> > >
> > > >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> > > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > >  extern struct attribute_group khugepaged_attr_group;
> > > > @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_str=
uct *mm, unsigned long addr,
> > > >
> > > >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm=
_struct *oldmm)
> > > >  {
> > > > -     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > > > +     /*
> > > > +      * THP allocation policy can be dynamically modified via BPF.=
 Even if a
> > > > +      * task was allowed to allocate THPs, BPF can decide whether =
its forked
> > > > +      * child can allocate THPs.
> > > > +      *
> > > > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> > > > +      */
> > > > +     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> > > > +             get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> > >
> > > Hmmm so there seems to be some kind of additional functionality you'r=
e providing
> > > here kinda quietly, which is to allow the exact same interface to det=
ermine
> > > whether we kick off khugepaged or not.
> > >
> > > Don't love that, I think we should be hugely specific about that.
> > >
> > > This bpf interface should literally be 'ok we're deciding what order =
we
> > > want'. It feels like a bit of a gross overloading?
> >
> > This makes sense. I have no objection to reverting to returning a singl=
e order.
>
> OK but key point here is - we're now determining if a forked child can _n=
ot_
> allocate THPs using this function.
>
> To me this should be a separate function rather than some _weird_ usage o=
f this
> same function.

Perhaps a separate function is better.

>
> And generally at this point I think we should just drop this bit of code
> honestly.

MMF_VM_HUGEPAGE is set when the THP mode is "always" or "madvise". If
it=E2=80=99s set, any forked child processes will inherit this flag. It is
only cleared when the mm_struct is destroyed (please correct me if I=E2=80=
=99m
wrong).

However, when you switch the THP mode to "never", tasks that still
have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn=E2=80=99t=
 an
issue under the current global mode because khugepaged doesn=E2=80=99t run
when THP is set to "never".

The problem arises when we move from a global mode to a per-task mode.
In that case, khugepaged may end up doing unnecessary work. For
example, if the THP mode is "always", but some tasks are not allowed
to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
will continue scanning them unnecessarily.

To avoid this, we should prevent setting this flag for child processes
if they are not allowed to allocate THP in the first place. This way,
khugepaged won=E2=80=99t waste cycles scanning them. While an alternative
approach would be to set the flag at fork and later clear it for
khugepaged, it=E2=80=99s clearly more efficient to avoid setting it from th=
e
start.

>
> >
> > >
> > > >               __khugepaged_enter(mm);
> > > >  }
> > > >
> > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > index 4108bcd96784..d10089e3f181 100644
> > > > --- a/mm/Kconfig
> > > > +++ b/mm/Kconfig
> > > > @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
> > > >
> > > >         EXPERIMENTAL because the impact of some changes is still un=
clear.
> > > >
> > > > +config EXPERIMENTAL_BPF_ORDER_SELECTION
> > > > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > > > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > > > +
> > > > +     help
> > > > +       Enable dynamic THP order selection using BPF programs. This
> > > > +       experimental feature allows custom BPF logic to determine o=
ptimal
> > > > +       transparent hugepage allocation sizes at runtime.
> > > > +
> > > > +       Warning: This feature is unstable and may change in future =
kernel
> > > > +       versions.
> > >
> > > Thanks! This is important to document. Absolute nitty nit: can you ca=
pitalise
> > > 'WARNING'? Thanks!
> >
> > will do it.
>
> Thanks!
>
> >
> > >
> > > > +
> > > >  endif # TRANSPARENT_HUGEPAGE
> > > >
> > > >  # simple helper to make the code a bit easier to read
> > > > diff --git a/mm/Makefile b/mm/Makefile
> > > > index ef54aa615d9d..cb55d1509be1 100644
> > > > --- a/mm/Makefile
> > > > +++ b/mm/Makefile
> > > > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
> > > >  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
> > > >  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
> > > >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> > > > +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) +=3D bpf_thp.o
> > > >  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> > > >  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
> > > >  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > > new file mode 100644
> > > > index 000000000000..fbff3b1bb988
> > > > --- /dev/null
> > > > +++ b/mm/bpf_thp.c
> > >
> > > As mentioned before, please update MAINTAINERS for new files. I went =
to great +
> > > painful lengths to get everything listed there so let's keep it that =
way please
> > > :P
> >
> > will do it.
>
> Thanks!
>
> >
> > >
> > > > @@ -0,0 +1,186 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/btf.h>
> > > > +#include <linux/huge_mm.h>
> > > > +#include <linux/khugepaged.h>
> > > > +
> > > > +struct bpf_thp_ops {
> > > > +     /**
> > > > +      * @get_suggested_order: Get the suggested THP orders for all=
ocation
> > > > +      * @mm: mm_struct associated with the THP allocation
> > > > +      * @vma__nullable: vm_area_struct associated with the THP all=
ocation (may be NULL)
> > > > +      *                 When NULL, the decision should be based on=
 @mm (i.e., when
> > > > +      *                 triggered from an mm-scope hook rather tha=
n a VMA-specific
> > > > +      *                 context).
> > > > +      *                 Must belong to @mm (guaranteed by the call=
er).
> > > > +      * @vma_flags: use these vm_flags instead of @vma->vm_flags (=
0 if @vma is NULL)
> > > > +      * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL=
)
> > > > +      * @orders: Bitmask of requested THP orders for this allocati=
on
> > > > +      *          - PMD-mapped allocation if PMD_ORDER is set
> > > > +      *          - mTHP allocation otherwise
> > > > +      *
> > > > +      * Rerurn: Bitmask of suggested THP orders for allocation. Th=
e highest
> > > > +      *         suggested order will not exceed the highest reques=
ted order
> > > > +      *         in @orders.
> > > > +      */
> > > > +     int (*get_suggested_order)(struct mm_struct *mm, struct vm_ar=
ea_struct *vma__nullable,
> > > > +                                u64 vma_flags, enum tva_type tva_f=
lags, int orders) __rcu;
> > >
> > > I feel like we should be declaring this function pointer type somewhe=
re else as
> > > we're now duplicating this in two places.
> >
> > agreed, I have already done it to fix the spare warning.
>
> Thanks!
>
> >
> > >
> > > > +};
> > > > +
> > > > +static struct bpf_thp_ops bpf_thp;
> > > > +static DEFINE_SPINLOCK(thp_ops_lock);
> > > > +
> > > > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struc=
t *vma__nullable,
> > > > +                     u64 vma_flags, enum tva_type tva_flags, int o=
rders)
> > >
> > > surely tva_flag? As this is an enum value?
> >
> > will change it to tva_type instead.
>
> Thanks!
>
> >
> > >
> > > > +{
> > > > +     int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_ar=
ea_struct *vma__nullable,
> > > > +                                u64 vma_flags, enum tva_type tva_f=
lags, int orders);
> > >
> > > This type for vma flags is totally incorrect. vm_flags_t. And that's =
going to
> > > change soon to an opaque type.
> > >
> > > Also right now it's actually an unsigned long.
> > >
> > > I really really do not like that we're providing extra, unexplained V=
MA flags
> > > for some reason. I may be missing something :) so happy to hear why t=
his is
> > > necessary.
> > >
> > > However in future we really shouldn't be passing something like this.
> >
> > will change it as replied in another thread.
>
> Thanks!
>
> >
> > >
> > > Also - now a third duplication of the same function pointer :) can we=
 do better
> > > than this? At least typedef it.
> > >
> > > > +     int suggested_orders =3D orders;
> > > > +
> > > > +     /* No BPF program is attached */
> > > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > > +                   &transparent_hugepage_flags))
> > > > +             return suggested_orders;
> > >
> > > This is atomic ofc, but are we concerned about races, or I guess you =
expect only
> > > the first attached bpf program to work with it I suppose.
> >
> > It is against the race to unreg or update.
>
> OK cool, it does make sense overall.
>
> >
> > >
> > > > +
> > > > +     rcu_read_lock();
> > >
> > > Is this sufficient? Anything stopping the mm or VMA going away here?
> >
> > This RCU lock is not for protecting the mm or VMA structures
> > themselves, but for protecting the update of the function pointer.
> > Arbitrary access to pointers within the mm_struct or vm_area_struct is
> > prohibited, as they are guarded by the BPF verifier.
> >
> > >
> > > > +     bpf_suggested_order =3D rcu_dereference(bpf_thp.get_suggested=
_order);
> > > > +     if (!bpf_suggested_order)
> > > > +             goto out;
> > > > +
> > > > +     suggested_orders =3D bpf_suggested_order(mm, vma__nullable, v=
ma_flags, tva_flags, orders);
> > >
> > > OK so now it's suggested order_S but we're invoking suggested order :=
) whaaatt?
> > > :)
> >
> > will change it.
>
> Thanks!
>
> >
> > >
> > > > +     if (highest_order(suggested_orders) > highest_order(orders))
> > > > +             suggested_orders =3D orders;
> > >
> > > Hmmm so the semantics are - whichever is the highest order wins?
> >
> > The maximum requested order is determined by the callsite. For example:
> > - PMD-mapped THP uses PMD_ORDER
> > - mTHP uses (PMD_ORDER - 1)
> >
> > We must respect this upper bound to avoid undefined behavior. So the
> > highest suggested order can't exceed the highest requested order.
>
> OK, please document this in a comment here.

will doc it.

>
> >
> > >
> > > I thought the idea was we'd hand control over to bpf if provided in e=
ffect?
> > >
> > > Definitely worth going over these semantics in the cover letter (and =
do forgive
> > > me if you have and I've missed! :)
> >
> > It has already in the cover letter:
> >
> >  * Return: Bitmask of suggested THP orders for allocation. The highest
> >  *         suggested order will not exceed the highest requested order
> >  *         in @orders.
>
> OK cool thanks, a comment here would be useful also.

will add it.

>
> >
> >
> > >
> > > > +
> > > > +out:
> > > > +     rcu_read_unlock();
> > > > +     return suggested_orders;
> > > > +}
> > > > +
> > > > +static bool bpf_thp_ops_is_valid_access(int off, int size,
> > > > +                                     enum bpf_access_type type,
> > > > +                                     const struct bpf_prog *prog,
> > > > +                                     struct bpf_insn_access_aux *i=
nfo)
> > > > +{
> > > > +     return bpf_tracing_btf_ctx_access(off, size, type, prog, info=
);
> > > > +}
> > > > +
> > > > +static const struct bpf_func_proto *
> > > > +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_=
prog *prog)
> > > > +{
> > > > +     return bpf_base_func_proto(func_id, prog);
> > > > +}
> > > > +
> > > > +static const struct bpf_verifier_ops thp_bpf_verifier_ops =3D {
> > > > +     .get_func_proto =3D bpf_thp_get_func_proto,
> > > > +     .is_valid_access =3D bpf_thp_ops_is_valid_access,
> > > > +};
> > > > +
> > > > +static int bpf_thp_init(struct btf *btf)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int bpf_thp_init_member(const struct btf_type *t,
> > > > +                            const struct btf_member *member,
> > > > +                            void *kdata, const void *udata)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> > > > +{
> > > > +     struct bpf_thp_ops *ops =3D kdata;
> > > > +
> > > > +     spin_lock(&thp_ops_lock);
> > > > +     if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > > +                          &transparent_hugepage_flags)) {
> > > > +             spin_unlock(&thp_ops_lock);
> > > > +             return -EBUSY;
> > > > +     }
> > > > +     WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order))=
;
> > > > +     rcu_assign_pointer(bpf_thp.get_suggested_order, ops->get_sugg=
ested_order);
> > > > +     spin_unlock(&thp_ops_lock);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> > > > +{
> > > > +     spin_lock(&thp_ops_lock);
> > > > +     clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hug=
epage_flags);
> > > > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order)=
);
> > > > +     rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockde=
p_is_held(&thp_ops_lock));
> > > > +     spin_unlock(&thp_ops_lock);
> > > > +
> > > > +     synchronize_rcu();
> > > > +}
> > >
> > > I am a total beginner with BPF implementations so don't feel like I c=
an say much
> > > intelligent about the above. But presumably fairly standard fare BPF-=
wise?
> >
> > This implementation is necessary to support BPF program updates.
>
> Ack.
>
> >
> > >
> > > Will perhaps try to dig deeper on another iteration :) as intersting =
to me.
> > >
> > > > +
> > > > +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf=
_link *link)
> > > > +{
> > > > +     struct bpf_thp_ops *ops =3D kdata;
> > > > +     struct bpf_thp_ops *old =3D old_kdata;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     if (!ops || !old)
> > > > +             return -EINVAL;
> > > > +
> > > > +     spin_lock(&thp_ops_lock);
> > > > +     /* The prog has aleady been removed. */
> > > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent=
_hugepage_flags)) {
> > > > +             ret =3D -ENOENT;
> > > > +             goto out;
> > > > +     }
> > >
> > > OK so we gate things on this flag and it's global, got it.
> > >
> > > I see this is a hook, and I guess RCU-all-the-things is what BPF does=
 which
> > > makes tonnes of sense.
> > >
> > > > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order)=
);
> > > > +     rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_sug=
gested_order,
> > > > +                         lockdep_is_held(&thp_ops_lock));
> > > > +
> > > > +out:
> > > > +     spin_unlock(&thp_ops_lock);
> > > > +     if (!ret)
> > > > +             synchronize_rcu();
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int bpf_thp_validate(void *kdata)
> > > > +{
> > > > +     struct bpf_thp_ops *ops =3D kdata;
> > > > +
> > > > +     if (!ops->get_suggested_order) {
> > > > +             pr_err("bpf_thp: required ops isn't implemented\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int suggested_order(struct mm_struct *mm, struct vm_area_st=
ruct *vma__nullable,
> > > > +                        u64 vma_flags, enum tva_type vm_flags, int=
 orders)
> > > > +{
> > > > +     return orders;
> > > > +}
> > > > +
> > > > +static struct bpf_thp_ops __bpf_thp_ops =3D {
> > > > +     .get_suggested_order =3D suggested_order,
> > > > +};
> > >
> > > Can you explain to me what this stub stuff is for? This is more 'BPF =
impl 101'
> > > stuff sorry :)
> >
> > It is a CFI stub. cfi_stubs in BPF struct_ops are secure intermediary
> > functions that prevent the kernel from making direct, unsafe jumps to
> > BPF code. A new attached BPF program will run via this stub.
>
> Ack.
>
> >
> > >
> > > > +
> > > > +static struct bpf_struct_ops bpf_bpf_thp_ops =3D {
> > > > +     .verifier_ops =3D &thp_bpf_verifier_ops,
> > > > +     .init =3D bpf_thp_init,
> > > > +     .init_member =3D bpf_thp_init_member,
> > > > +     .reg =3D bpf_thp_reg,
> > > > +     .unreg =3D bpf_thp_unreg,
> > > > +     .update =3D bpf_thp_update,
> > > > +     .validate =3D bpf_thp_validate,
> > > > +     .cfi_stubs =3D &__bpf_thp_ops,
> > > > +     .owner =3D THIS_MODULE,
> > > > +     .name =3D "bpf_thp_ops",
> > > > +};
> > > > +
> > > > +static int __init bpf_thp_ops_init(void)
> > > > +{
> > > > +     int err =3D register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp=
_ops);
> > > > +
> > > > +     if (err)
> > > > +             pr_err("bpf_thp: Failed to register struct_ops (%d)\n=
", err);
> > > > +     return err;
> > > > +}
> > > > +late_initcall(bpf_thp_ops_init);
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index d89992b65acc..bd8f8f34ab3c 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct=
 vm_fault *vmf)
> > > >               return ret;
> > > >       khugepaged_enter_vma(vma, vma->vm_flags);
> > > >
> > > > +     /*
> > > > +      * This check must occur after khugepaged_enter_vma() because=
:
> > > > +      * 1. We may permit THP allocation via khugepaged
> > > > +      * 2. While simultaneously disallowing THP allocation
> > > > +      *    during page fault handling
> > > > +      */
> > > > +     if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_P=
AGEFAULT, BIT(PMD_ORDER)) !=3D
> > > > +                             BIT(PMD_ORDER))
> > >
> > > Hmmm so you return a bitmask of orders, but then you only allow this =
fault if
> > > the only order provided is PMD order? That seems strange. Can you exp=
lain?
> >
> > This is in the do_huge_pmd_anonymous_page() that can only accept a PMD
> > order, otherwise it might result in unexpected behavior.
>
> OK please document this in the comment.

will doc it.


--
Regards
Yafang

