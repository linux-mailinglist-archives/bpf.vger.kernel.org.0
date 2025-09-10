Return-Path: <bpf+bounces-67993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5AB50DF1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406B94811A0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBB2DF3D9;
	Wed, 10 Sep 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJHzqsnS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB92673AA;
	Wed, 10 Sep 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485106; cv=none; b=VFm4o+DQuopDLFO0OvVGgw5xJSzMMwMml+S7vIqsVSv2h+3Y/83MfcilOsSCg3u1tghEPpTYnZEkXsLmpPAtyuhvw0VT6zMLzR+CNWfiNHZ2yhQWnOM7it53ypS2tJfdryGgZP10b6+HOd3zoYXtbOsY+VbJO0YneGE0OM9u5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485106; c=relaxed/simple;
	bh=J36O/t9pbZpHyekI/cR19In77YQfyzOLXMq7MsVD7Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+8ouZVh0544ymHAOiMfLL6CLG6VsEFiGTk04HMiUQYdNi65M41jwYYjwbUl05HJ9Orrt3PjLZcHiySqAHAAhEkk3q5mAocXDYTS9OEHfJc+KSlihtb3ixRHL4em3hTPdlEhHOnRZelM3Gur8S+MvIej5hBqcVL3/cOoc958fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJHzqsnS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7220d7dea27so52692616d6.1;
        Tue, 09 Sep 2025 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757485104; x=1758089904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYzJL7Hx4cl0FskNvKkVhvtLZ/R9JXw2qBXsF5fYGzI=;
        b=LJHzqsnSUsNciaQ/5MGGtCAMdloqKa7gIn8zH5ZtYMceKFSz9lqs88taXwj3HsdKLH
         USuuPxK5h7TvoeeDnj/5wQ3sjKfG5r0an71Zo2PUdTKLcLpq+0iEqmH5+wY5BiWFqoRG
         MUonQNdb9aysQygh46apU5HNAzz+qIkqwwbnpkpfufaUUhxJiliodFv4HOnJF78Z9gct
         mcWImqNYrAUQqwJf8gUIyholPsmN8qGLUK3/tVwPgfPIocz09nqGCVIfGnbwtbmNM2+v
         8jk1MfUncRewgzVbBu2lyPt4kYX8kBTw+c7qLkqzygd9rxzF4TrWC8UlGHvpaj+VUyHe
         xU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485104; x=1758089904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYzJL7Hx4cl0FskNvKkVhvtLZ/R9JXw2qBXsF5fYGzI=;
        b=Oi9pxsukS3xgNBnl718s6xj+rsIjzQoKnIn8pb2Jz+RPjOs+iTOk2qP1EaeaI/Ja8k
         7I/TQuUNoU285O00q1gRQzip9hOhauuzJKy+5pFB2diC++afweaG7FwUQY0+ckWSdBt9
         I0r+jEJXLF64TCTs9GtGWYZc0fwe2SRvQ1U7kYmu+PwjdqfZJPvz8kwtyXCb5zIDYKQW
         8RmzApDIo4DLeljlyJFxVjnz/CjMlnO+9dSw0f7fGxPnvOZUrg2eEIe4bZSerg+4HSrB
         ztmGW/jRhtaNvUqbhLhv5EuIzG4Ty0zNfrU2RNyY9KII5SAQffqS4uU/9WZJyaiezmS/
         +DMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3qlbpTj2xCQoDEW0afRcL3RjBFrJg7VHbO3lHoBmiEechgl9o4iX4Hn4uouqzK3mR3Tyg3lImecw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCaFpoXMLpW1mMoKRL8KALY22yIG0J7eI5rghOb4IGyth59mm
	3hzOTOKQgjKBf8IMephm4hiw1BBCAr1F6g4v/fjv0Ph6YhwQgRAzO1iocypqzmBQt7bqhyWiVlN
	1NsB4NI5DQ/1rGldt0Oe6LxtJyzIm9oA=
X-Gm-Gg: ASbGncskMjpoJapd9ZKwZ8Bf8VZe1e0sAAVRVGEocU60h/zmzBTsut/tdVcJuPFFhY2
	Aq8Qvbw6ZFQ0tf1Rvp2RNTCQ45RMcwYgPaGVJKX2gSeKX1LdNelEl/OH5KHL6/V5LzfB93I8u+y
	SqkRswwZuYARGHsYOnkWtDfVkp/i8E2TalQJU3LZmUD2IrEtqkCDeeyj18e4lKeXn1VH5tgTYoh
	9oxdYQToDqnu1UjrSCNZ9qEaeAd1YETkLusz3s8RsgQnfvv+2E=
X-Google-Smtp-Source: AGHT+IFvX8ysVDBbiXtbizZMNGoZJmz5YmPfl+MEXyDzgFg9igYbqr/nnoZNtm5eoSPGvCef4i3c5jWe9oYtmW6CEfo=
X-Received: by 2002:a05:6214:1c43:b0:720:3cd9:1f7e with SMTP id
 6a1803df08f44-738f718cb4cmr113550666d6.0.1757485103832; Tue, 09 Sep 2025
 23:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-2-laoar.shao@gmail.com>
 <7c890b42-610f-42ec-acf2-b5b9f95209b1@linux.dev>
In-Reply-To: <7c890b42-610f-42ec-acf2-b5b9f95209b1@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Sep 2025 14:17:47 +0800
X-Gm-Features: AS18NWAEtXjJHwi77ZRJ7QtvbBT2n7zXaHBMPXJVp87PMZaJZ2j5bODmbGmPrA0
Message-ID: <CALOAHbDWJMyNQknX9ihGKuAJNQk+MuG8Af4cpLh=0N5mB_-2tg@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from khugepaged_mm_slot
To: Lance Yang <lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Lance Yang <ioworker0@gmail.com>, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	hannes@cmpxchg.org, corbet@lwn.net, ameryhung@gmail.com, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, rientjes@google.com, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, ryan.roberts@arm.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, 
	usamaarif642@gmail.com, lorenzo.stoakes@oracle.com, npache@redhat.com, 
	dev.jain@arm.com, Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:11=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
> Hey Yafang,
>
> On 2025/9/10 10:44, Yafang Shao wrote:
> > Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it =
from
> > the khugepaged_mm_slot to stop khugepaged from processing it.
> >
> > After this change, the following semantic relationship always holds:
> >
> >    MMF_VM_HUGEPAGE is set     =3D=3D task is in khugepaged mm_slot
> >    MMF_VM_HUGEPAGE is not set =3D=3D task is not in khugepaged mm_slot
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/khugepaged.h |  1 +
> >   kernel/sys.c               |  6 ++++++
> >   mm/khugepaged.c            | 19 +++++++++----------
> >   3 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index eb1946a70cff..6cb9107f1006 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -19,6 +19,7 @@ extern void khugepaged_min_free_kbytes_update(void);
> >   extern bool current_is_khugepaged(void);
> >   extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned lon=
g addr,
> >                                  bool install_pmd);
> > +bool hugepage_pmd_enabled(void);
> >
> >   static inline void khugepaged_fork(struct mm_struct *mm, struct mm_st=
ruct *oldmm)
> >   {
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index a46d9b75880b..a1c1e8007f2d 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/export.h>
> >   #include <linux/mm.h>
> >   #include <linux/mm_inline.h>
> > +#include <linux/khugepaged.h>
> >   #include <linux/utsname.h>
> >   #include <linux/mman.h>
> >   #include <linux/reboot.h>
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
> >       mmap_write_unlock(current->mm);
>
> One minor style suggestion for prctl_set_thp_disable():
>
> static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
>                                  unsigned long arg4, unsigned long arg5)
> {
>         struct mm_struct *mm =3D current->mm;
>
>         [...]
>         if (mmap_write_lock_killable(current->mm))
>                 return -EINTR;
>         [...]
>         mmap_write_unlock(current->mm);
>         return 0;
> }
>
> It initializes struct mm_struct *mm =3D current->mm; at the beginning, bu=
t
> then uses both mm and current->mm. Could you change the calls using
> current->mm to use the local mm variable for consistency? Just a nit ;)

Nice catch

Hello Andrew, David,

The original commit "prctl: extend PR_SET_THP_DISABLE to optionally
exclude VM_HUGEPAGE" is still in mm-new branch. The change below is a
minor cleanup for it.

Could we please fold this change directly into the original commit to
keep the history clean?

diff --git a/kernel/sys.c b/kernel/sys.c
index a46d9b7..2250a32 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2479,7 +2479,7 @@ static int prctl_set_thp_disable(bool
thp_disable, unsigned long flags,
        /* Flags are only allowed when disabling. */
        if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVI=
SED))
                return -EINVAL;
-       if (mmap_write_lock_killable(current->mm))
+       if (mmap_write_lock_killable(mm))
                return -EINTR;
        if (thp_disable) {
                if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
@@ -2493,7 +2493,7 @@ static int prctl_set_thp_disable(bool
thp_disable, unsigned long flags,
                mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
                mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
        }
-       mmap_write_unlock(current->mm);
+       mmap_write_unlock(mm);
        return 0;
 }


--=20
Regards
Yafang

