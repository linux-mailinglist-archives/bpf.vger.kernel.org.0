Return-Path: <bpf+bounces-57027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F7AA412A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 04:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FB11BC79BE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09497158DAC;
	Wed, 30 Apr 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI0KVsBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06392111
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981330; cv=none; b=d+PFyX29Msvdx6XWte3Q1tYK6s2t8mW9XBPhCZxbcQshf2Bddox7s8hdpaq84mosxLqVehBnHRg8da8qMEjPfgYjLmtXpCWFlJOlFf3XVgld7goTF+g4aSrjhW55LT+0KrRFuAUk+V2TUWt4pjQ/3skjExEDQDUWL02AFvQaUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981330; c=relaxed/simple;
	bh=b4rtcByyK1Yp5FyBYhYVa2kWm3+0iJswdnQ4Q7PB0qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY2A/hGAmq7KgeYB9IVppOHpb9NfFtW1GKzyvKUl2vMddRBSMxQoX6A5i3ABjO+nABIkQGHZDUgrNcNTZOff7tvgpPr6V/i2AusgI+sRY6nvOMYowvBsIzW7j7gfNL0d67aKrp0JWiRo3UZbHXf2OrF6miLzRZsuWxqkciGE0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI0KVsBY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f7019422so68344596d6.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745981328; x=1746586128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xEji0aPCu4ufQeSz/hkiElJuERhNyl1TgZKIhegpo0=;
        b=EI0KVsBYPliuPcScij2d+ZGb4XfE5vxif4N26eZJp7lqZyhkU7BIdan8yQw68j0nyM
         ExlI5xue/3kj2GZT5jlBAquqXMIta77tXl6Na5p+a7VA+AOzudvOKGGbwXXVKk6Rl6uZ
         IItzOvO72e5HI+g5BX4X6DN4nYOru7vNnipuo/8ujnUp25f/XQTMcBSxzLeE5fLP3y5Z
         6Zl9a1NzaN8I8120jGxz9tHbDwe2TQXN8pAxEX+QOh3Mh53S0G0bFI94pXmgMxJoXXqU
         MpGa0ODryIysxjHfXuSDNfj3llanb1QavNTwIz5AxeALCVQVuYolckd9RiQ0mCsqo6Lz
         KUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745981328; x=1746586128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xEji0aPCu4ufQeSz/hkiElJuERhNyl1TgZKIhegpo0=;
        b=FlKr+DKkh/P/sTsC8eluAr8oyeD6EPvBa/4L7YqhFPRXafPKGe1CSEBp4V064wDtJN
         QZKJQ8RH8uvI51fcTpK50qZsYXOTbEDt8RGr7YVXLvNzpug3zlRXx2xrJKLiFSLtXSgQ
         4BYTRbeP2aaqz+2K++gOVWRb8I+zXxo3e86H4+r7PKYZ1U95V43LwahRd/JhFAIVwAEX
         Utt+vcwat7s27DNmWiJtUb4vwQVbDaP34rmX6ELzch16oSA0AjP5N/rSZLPLVT4cEvvX
         uz/fdFrkB4x3RcMXOJ5GTv8Nz1ASiYZ05Cf5HOnm7LVlpCo4fAK+1rf+L1ng0R+1BFsF
         h4jg==
X-Forwarded-Encrypted: i=1; AJvYcCUYIkM4NMD2h6eI9jQAxCNch+o3obT0cfcq7BKbMEN9nmxdHw7IkTBrGre5wHrPcWLUHos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeo/+2btnvKGQ2ONUCXX8IBRxpO2GYnrxk0sIZ8xtDJFPjr20
	LBKywjBD+hEtcudLhHyoglLUsyqNbzTkp7l7uZ1L2PKqoifAKXLd+KIcCAmvzKUB1Co5wDo/2nq
	1UpiEwROT7gYu6J/wkiH/gDqW0Rw=
X-Gm-Gg: ASbGncveRWoHEGYXQGYYsjIp1dtLW01dRAtPbw0fpNas6P7IfxH+Q/DcWnK/F/+N4h9
	fljwdZ/Syy4zmwmxtd95leNBSgScbwDzykRoNszGKJImig9BcUdgt9TfUCecNBFMQ17pmQ+sc2E
	QUgDYDHne5cVWU+Z+YaTBzEU0=
X-Google-Smtp-Source: AGHT+IGzXDrLanqLfUNrRxT6C7Ik75q5yOi0GpuXGu/nkZML1mPpBPk244Lz+mSza57BSp0/bDrNJGdy4yUhB0hxdEM=
X-Received: by 2002:ad4:5dc1:0:b0:6e8:f4e2:26ef with SMTP id
 6a1803df08f44-6f4fe105662mr20014996d6.31.1745981327764; Tue, 29 Apr 2025
 19:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <20250429024139.34365-4-laoar.shao@gmail.com>
 <CAADnVQJw2ou7mHtvp+kCxLi_kzN+j4UqXA5xvOR1gJDjA8iVfQ@mail.gmail.com>
In-Reply-To: <CAADnVQJw2ou7mHtvp+kCxLi_kzN+j4UqXA5xvOR1gJDjA8iVfQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 10:48:11 +0800
X-Gm-Features: ATxdqUGL5jXU36qe6VWfQi1M76XEbLnbQFXHuudVSmgEzj7hMolHpVblf2tLFvE
Message-ID: <CALOAHbBrQDiVdwPkXB_5NAiwnjK1Wk713aDJbjDZJ_mYpK5RHw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: add BPF hook for THP adjustment
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 7:42=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > We will use the @vma parameter in BPF programs to determine whether THP=
 can
> > be used. The typical workflow is as follows:
> >
> > 1. Retrieve the mm_struct from the given @vma.
> > 2. Obtain the task_struct associated with the mm_struct
> >    It depends on CONFIG_MEMCG.
> > 3. Adjust THP behavior dynamically based on task attributes
> >    E.g., based on the task=E2=80=99s cgroup
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/Makefile   |  3 +++
> >  mm/bpf.c      | 36 ++++++++++++++++++++++++++++++++++++
> >  mm/bpf.h      | 21 +++++++++++++++++++++
> >  mm/internal.h |  3 +++
> >  4 files changed, 63 insertions(+)
> >  create mode 100644 mm/bpf.c
> >  create mode 100644 mm/bpf.h
> >
> > diff --git a/mm/Makefile b/mm/Makefile
> > index e7f6bbf8ae5f..97055da04746 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
> >  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
> >  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> > +ifdef CONFIG_BPF_SYSCALL
> > +obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D bpf.o
> > +endif
> >  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> >  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
> >  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > diff --git a/mm/bpf.c b/mm/bpf.c
> > new file mode 100644
> > index 000000000000..72eebcdbad56
> > --- /dev/null
> > +++ b/mm/bpf.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/mm_types.h>
> > +
> > +__bpf_hook_start();
> > +
> > +/* Checks if this @vma can use THP. */
> > +__weak noinline int
> > +mm_bpf_thp_vma_allowable(struct vm_area_struct *vma)
> > +{
> > +       /* At present, fmod_ret exclusively uses 0 to signify that the =
return
> > +        * value remains unchanged.
> > +        */
> > +       return 0;
> > +}
> > +
> > +__bpf_hook_end();
> > +
> > +BTF_SET8_START(mm_bpf_fmod_ret_ids)
> > +BTF_ID_FLAGS(func, mm_bpf_thp_vma_allowable)
> > +BTF_SET8_END(mm_bpf_fmod_ret_ids)
> > +
> > +static const struct btf_kfunc_id_set mm_bpf_fmodret_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set   =3D &mm_bpf_fmod_ret_ids,
> > +};
> > +
> > +static int __init bpf_mm_kfunc_init(void)
> > +{
> > +       return register_btf_fmodret_id_set(&mm_bpf_fmodret_set);
> > +}
> > +late_initcall(bpf_mm_kfunc_init);
> > diff --git a/mm/bpf.h b/mm/bpf.h
> > new file mode 100644
> > index 000000000000..e03a38084b08
> > --- /dev/null
> > +++ b/mm/bpf.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#ifndef __MM_BPF_H
> > +#define __MM_BPF_H
> > +
> > +#define MM_BPF_ALLOWABLE       (1)
> > +#define MM_BPF_NOT_ALLOWABLE   (-1)
> > +
> > +#define MM_BPF_ALLOWABLE_HOOK(func, args...)   {       \
> > +       int ret =3D func(args);                           \
> > +                                                       \
> > +       if (ret =3D=3D MM_BPF_ALLOWABLE)                    \
> > +               return 1;                               \
> > +       if (ret =3D=3D MM_BPF_NOT_ALLOWABLE)                \
> > +               return 0;                               \
> > +}
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +int mm_bpf_thp_vma_allowable(struct vm_area_struct *vma);
> > +#endif
> > +
> > +#endif
> > diff --git a/mm/internal.h b/mm/internal.h
> > index aa698a11dd68..c8bf405fa581 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -21,6 +21,7 @@
> >
> >  /* Internal core VMA manipulation functions. */
> >  #include "vma.h"
> > +#include "bpf.h"
> >
> >  struct folio_batch;
> >
> > @@ -1632,6 +1633,7 @@ static inline bool reclaim_pt_is_enabled(unsigned=
 long start, unsigned long end,
> >   */
> >  static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
> >  {
> > +       MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);
> >         return transparent_hugepage_flags &
> >                         ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> >                         (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
> > @@ -1639,6 +1641,7 @@ static inline bool hugepage_global_enabled(struct=
 vm_area_struct *vma)
> >
> >  static inline bool hugepage_global_always(struct vm_area_struct *vma)
> >  {
> > +       MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);
>
> Please define a clean struct_ops based interface and demonstrate
> the generality of the api with both bpf prog and a kernel module.
> Do not use fmod_ret since it's global while struct_ops can be made
> scoped for use case. Ex: per cgroup.

Thank you for the suggestion. I'll give this careful consideration.

--=20
Regards
Yafang

