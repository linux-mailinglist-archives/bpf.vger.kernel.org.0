Return-Path: <bpf+bounces-68311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F791B5646F
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 04:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D2421307
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224A14B953;
	Sun, 14 Sep 2025 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNOMYhSl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4920311
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757818093; cv=none; b=c5NgOVJnRe7VfjfsCaWkf7SLZZfKdX8YvO4SfdMsBXQ+FsYz9fMzFPtc1rvVVYwofadI0++6R4aK/6cWDkihaprOdME6mmRpkAceU59U4aKrDwHYVuz16QO5wI5wmHPvNu7pi0gcuSjVeTiPpJPIHkymwM8P2wPkScA2QQfDuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757818093; c=relaxed/simple;
	bh=ZEpEOx2YZheQI7XFVGWiC4lJmIN5ohHGkB+M/orVZ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNWcJz6emNc34bRww/7n0HXrhFwV6N0NosmKeC+ygUrS+hE8TmeRrk5DFJcPq+IoZswTcTagtP7MthlZ3pg2ui2OCq/cUPoThAfxxZ1mc+E4MT0Lr2bj/fpr6/jzOci6AvFIagcklRrVmHS9CQZxm75ABM+WtXuGtnh590AvvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNOMYhSl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-76e2efbd84cso17451886d6.1
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757818091; x=1758422891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp7uGh9XMAtdhC8Pg1wTL8oP/uTc27f9iRVAHQuf6uI=;
        b=KNOMYhSlLMNsIxvAwnMx6RGvUbxGYwbKzfeCGD+VH+Rjy0oRHbzAT6nfxpUYCxBj9H
         IMAH6vUH/5Iw+2TGmsUF6Z+jc6bWlivbf6kQmvVDj/XE+SitxFLY5Ez8HeP5aWgyey0g
         EelV3N3+bKKqd+QQSwd9b0ZDvSZHj6aUK7CGEnAFXCB1lGKvhVasvw7noP5pkGRRipcz
         xKtvQ5zdBL//vKIAiuqpiLPXDwIlwQD8Np4hLgiQ1zO5KY6ywmWOfMNZhbMnelYbT17E
         kg/eUiFIyaEPWnPCV2JKWxeEsuNR3HQTpsFIIs5mWPqwx6JLPYTg22mxYJNroN6ViRmB
         N3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757818091; x=1758422891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp7uGh9XMAtdhC8Pg1wTL8oP/uTc27f9iRVAHQuf6uI=;
        b=GR9V8llM7RUYqCBWI5Epb0qfz8iv9ifJiU7wT54ytUAuZp6IkDEEAJEUydXMawV3tv
         11N5EaGZnA9D+OFWwOSl5fzQxXrQ/XVU3bFKyzYAmMVRzfvGouWtsnvK9LG4l3Wtv18H
         dc6GHpkPmLsMcVs7nFNDz0ymvyYR/wniHHnyCitzm88nSD+obpshYGRwuArXOiG2w6xO
         cgYHpohktkegUq+LvavY0uqD4MdTQJbOdFHh2ZGOvKXJr12RhpL5s0naI8UZg+2XCG2S
         ZYI9BnBinwqXD19UB9alAt0zGrvk8yhrwRBdjGMzJiEdK8bzzl88f/j/hVWK0A6Lby0c
         lyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmu5WeVmc2IHOA6a7EOIiwPnJNG0gB2ZVf0VqVubX4ZD18/6vH+SO8BJdGvxYn6lkp1f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIypsBYWKJawTBjdof0tkvQpRxU9Yq5nlH2+xWO98vIfkA/PsM
	zzk/PDB6FMPOe+PMmWU7ohj6JuuSOCxvej102k6WAp2mqz3JqNpZitDFvSTJ5INqnKwEiDkrQ5x
	r+FFrKIK2Qb79IyaopON421nShYN4GtA=
X-Gm-Gg: ASbGnctAokbEzsG+KKpT8zt66P4r3dk7Hnm40ApLv8yNidwxGofboJgAB9y6yUTNWDr
	i3fbrFq+Eje2Yqm7yXlPGlKC4ilZcwNsNySKnY8uqXODUrIFwvQ6QlBIttty9lFyGcR134qZs1Y
	OkZxjdguz1Z28aoTrW+2qK4az4YUE5tDkWE8F5I09gRCK8IvDlSLNpY/C7R7YlILrDgs9qlghG+
	s1yKfshMYTzYVl+5vBP0ZiJ4fj+NmwHQR4UYlLeKIwYQinXbcg=
X-Google-Smtp-Source: AGHT+IH+Jk17l3gErz7feEZAlaVYld9udv0w6feCbqBBsoiFfdHT/10cXwvqjgQ1b69ZWE+uPc9vUwmMf9zu91A5pl8=
X-Received: by 2002:a05:6214:dcb:b0:722:48f8:66a with SMTP id
 6a1803df08f44-767bf630454mr98094176d6.28.1757818090600; Sat, 13 Sep 2025
 19:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-2-laoar.shao@gmail.com>
 <8b7cd7d0-ec5f-4d0e-9182-03e42d37820c@lucifer.local>
In-Reply-To: <8b7cd7d0-ec5f-4d0e-9182-03e42d37820c@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 14 Sep 2025 10:47:33 +0800
X-Gm-Features: AS18NWCLaos2aigXhOQbVTbxEWjeK7eDQncfpgJCLqDM9hHSZWjvSDqX711xaPk
Message-ID: <CALOAHbCJZtLUdbSj8TrV3xqUnpdYL=h+oBofDpsNrPaXdSfwAg@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from khugepaged_mm_slot
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:43=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:44:38AM +0800, Yafang Shao wrote:
> > Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it =
from
> > the khugepaged_mm_slot to stop khugepaged from processing it.
> >
> > After this change, the following semantic relationship always holds:
> >
> >   MMF_VM_HUGEPAGE is set     =3D=3D task is in khugepaged mm_slot
> >   MMF_VM_HUGEPAGE is not set =3D=3D task is not in khugepaged mm_slot
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Lance Yang <ioworker0@gmail.com>
>
> (Obviously on basis of fixing issue bot reported).
>
> > ---
> >  include/linux/khugepaged.h |  1 +
> >  kernel/sys.c               |  6 ++++++
> >  mm/khugepaged.c            | 19 +++++++++----------
> >  3 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index eb1946a70cff..6cb9107f1006 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -19,6 +19,7 @@ extern void khugepaged_min_free_kbytes_update(void);
> >  extern bool current_is_khugepaged(void);
> >  extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long=
 addr,
> >                                  bool install_pmd);
> > +bool hugepage_pmd_enabled(void);
>
> Need to provide a !CONFIG_TRANSPARENT_HUGEPAGE version, or to not invoke
> this in a context where CONFIG_TRANSPARENT_HUGEPAGE is specified.
>
> >
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_str=
uct *oldmm)
> >  {
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index a46d9b75880b..a1c1e8007f2d 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/export.h>
> >  #include <linux/mm.h>
> >  #include <linux/mm_inline.h>
> > +#include <linux/khugepaged.h>
> >  #include <linux/utsname.h>
> >  #include <linux/mman.h>
> >  #include <linux/reboot.h>
> > @@ -2493,6 +2494,11 @@ static int prctl_set_thp_disable(bool thp_disabl=
e, unsigned long flags,
> >               mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
> >               mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
> >       }
> > +
> > +     if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
> > +         !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
> > +         hugepage_pmd_enabled())
> > +             __khugepaged_enter(mm);
>
> Let's refactor this so it's not open-coded.
>
> We can have:
>
> void khugepaged_enter_mm(struct mm_struct *mm)
> {
>         if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm))
>                 return;
>         if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
>                 return;
>         if (!hugepage_pmd_enabled())
>                 return;
>
>         __khugepaged_enter(mm);
> }
>
> void khugepaged_enter_vma(struct vm_area_struct *vma,
>                           vm_flags_t vm_flags)
> {
>         if (!thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_O=
RDER))
>                 return;
>
>         khugepaged_enter_mm(vma->vm_mm);
> }
>
> Then just invoke khugepaged_enter_mm() here.

That's better.

>
>
> >       mmap_write_unlock(current->mm);
> >       return 0;
> >  }
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4ec324a4c1fe..88ac482fb3a0 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disab=
le(struct mm_struct *mm)
> >               mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
> >  }
> >
> > -static bool hugepage_pmd_enabled(void)
> > +bool hugepage_pmd_enabled(void)
> >  {
> >       /*
> >        * We cover the anon, shmem and the file-backed case here; file-b=
acked
> > @@ -445,6 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
> >
> >       /* __khugepaged_exit() must not run from under us */
> >       VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> > +     WARN_ON_ONCE(mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm));
>
> Not sure why this needs to be a naked WARN_ON_ONCE()? Seems that'd be a
> programmatic eror, so VM_WARN_ON_ONCE() more appropriate?

ack

>
> Can also change the VM_BUG_ON_MM() to VM_WARN_ON_ONCE_MM() while we're he=
re.

ack

>
> >       if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
> >               return;
> >
> > @@ -472,7 +473,8 @@ void __khugepaged_enter(struct mm_struct *mm)
> >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         vm_flags_t vm_flags)
> >  {
> > -     if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> > +     if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, vma->vm_mm) &&
> > +         !mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> >           hugepage_pmd_enabled()) {
> >               if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER))
> >                       __khugepaged_enter(vma->vm_mm);
>
> See above, we can refactor this.

ack

>
> > @@ -1451,16 +1453,13 @@ static void collect_mm_slot(struct khugepaged_m=
m_slot *mm_slot)
> >
> >       lockdep_assert_held(&khugepaged_mm_lock);
> >
> > -     if (hpage_collapse_test_exit(mm)) {
> > +     if (hpage_collapse_test_exit_or_disable(mm)) {
> >               /* free mm_slot */
> >               hash_del(&slot->hash);
> >               list_del(&slot->mm_node);
> >
> > -             /*
> > -              * Not strictly needed because the mm exited already.
> > -              *
> > -              * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > -              */
> > +             /* If the mm is disabled, this flag must be cleared. */
> > +             mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> >
> >               /* khugepaged_mm_lock actually not necessary for the belo=
w */
> >               mm_slot_free(mm_slot_cache, mm_slot);
> > @@ -2507,9 +2506,9 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >       VM_BUG_ON(khugepaged_scan.mm_slot !=3D mm_slot);
> >       /*
> >        * Release the current mm_slot if this mm is about to die, or
> > -      * if we scanned all vmas of this mm.
> > +      * if we scanned all vmas of this mm, or if this mm is disabled.
> >        */
> > -     if (hpage_collapse_test_exit(mm) || !vma) {
> > +     if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
> >               /*
> >                * Make sure that if mm_users is reaching zero while
> >                * khugepaged runs here, khugepaged_exit will find
>
> Seems reasonable, but makes me wonder if we actually always want to invok=
e
> hpage_collapse_test_exit_or_disable()?
>
> I guess the VM_BUG_ON() (though it should be a VM_WARN_ON_ONCE()) in
> __khugepaged_enter() is a legit use, but the only other case is
> retract_page_tables().
>
> I wonder if we should change this also? Seems reasonable to.

Right, we can change it also. Thanks for your suggestion.


--=20
Regards
Yafang

