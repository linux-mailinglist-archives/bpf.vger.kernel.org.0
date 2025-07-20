Return-Path: <bpf+bounces-63816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ECBB0B341
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 05:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60D77AEE87
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51A31519A6;
	Sun, 20 Jul 2025 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMmWV/7o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0EF1CFBC
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752980891; cv=none; b=GtEjolJ+BtfPoMCQM7G5mrt32e+oHYNDNxcYHLCMdoc1pd2+i9DxYNKaU6mjfnulSzbXVnLtBvh+od2VQumUSYIMAsnJabehwyGW5vkiuO4zSqaOcQI3XNra1idpFCfw8axww7rqh6isxt7DbXjTqRwz3rN+ZFTROWf/fww2tvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752980891; c=relaxed/simple;
	bh=BYoka2nQg8snQJmTI+9mS8GMnXc0UOUHGHOT77IDJYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmxwJ4gYhw7bF9lzAf4AdlJRHXzgwpeIvxH7W7kqr0akWgJDiVUqRMt4EUaVovO8xWXewny7E+9H9YXKpn2UXUt57JeycJyBIqbPCywBIuljaw0ov6e6UDAn5EAXdMmTgP/R/8+wwJ320n1hD/4rXjfLSP6YtEUJGIRl6MQFWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMmWV/7o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so25840026d6.0
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752980888; x=1753585688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7YDzvyZ5EbOXLpo3at6ynRgR96TYB5L3Vxl1yzLIJ8=;
        b=IMmWV/7ouN7Qeper3AAcWSLeSSf796vcbQ58a4gp6RzxX7pwDMeZYylZfb44khJw/q
         fwlKirJ2WEHaXUH5XAEGnevDWtp0wMS3YmHi9sK23LcJiDzNBAstDkxSS2EWNx8Z70IK
         8dFVtCFayxLp47wcfAxR6jzhBUqa6AvVTnd/vPfpu1GEon6Fw5DA73NuQyAPOw3zMd47
         u8h4lm8gnYsWUgN+5+EyoJQg/PAA2oIvSZF6o/qAc/7HuVh1i84oGdCePao5+yiIL4xO
         sHA4UyVZVjg3NFQiJ+zcGXfFrgehmM8gkOTAtZR7UoySOxjwZASRshaRbAlk+MUls9eW
         79IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752980888; x=1753585688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7YDzvyZ5EbOXLpo3at6ynRgR96TYB5L3Vxl1yzLIJ8=;
        b=PupHwGs7vbQvyM3m24TnJX7/8hgXiVORU8wfQvENVI9SyIou4Gj30yxg/XKScRVWuX
         RB80sLuUb/x4NEljv1x5FqLFqHpOmXq5FvRxDjic4cfzf5E6CF94BGfqa9FBELXR8NL8
         EcPtVAf8HDBuarRY8ambGJfCUx0l3pWK29hlk0XuplIauVDbJTWUkRlrvNQxYL+2wg/E
         feADXD3/g9aIKA0TsO/s3naWch55PovHVdpqyBBzCg24X6aPn6Sp5B/q2KZfzbnckWaR
         d3uzLtO2CumO06VzW7b9juNz7CxWjrTBN9ERgfNHb6gFsTFlO6RBwO4fEhBJlL9z9ibD
         NZww==
X-Forwarded-Encrypted: i=1; AJvYcCWmE2oBv9JxQBxwXPJcmHW1QeQOUgQp/IgqTEfMw1g61xTC4VRcFfEIdrPMD8ypMmO3ZFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaHL4EHTio+OHIYWYku+0vDS3l67ZnSRaH1SD/FNNL7AjMcn4e
	owc6dlmpa/5VgorMeDcE58gpSUMD7FTIJL13dQpGbkTFr5MvH7dQhteYHkyfsd4CHY/u3tdNyYy
	EbccMRH/MmvA3Vno+zRsJ2+wVRHYnShU=
X-Gm-Gg: ASbGnctrVe0+fo3x7Fu4tZUt9NlDWxp42E4X/icd2yQWeuH53aBVg14roslegdEzF9p
	F1EHHZ5lrrEINajPwwMWw7FaTLJunL6fyfyxmJIqM9JdM7OfUuDXZq82oP0KiLt5faX/PoDxiU6
	SzIMNVUIg2qmIcOl8SSh0RI0jLJh0Ill+UqbCkQLzlvzuCRjSFm6I4JUPf/AQZgA5n+OVL7lvb2
	SGG1R0Q
X-Google-Smtp-Source: AGHT+IGarZ9zKueZnuZ07/wlCjNSFFxXtEJtCHq1d/Ev7fFF0Q8WWGnyqL8zFNfbuPKzkSkzwj3M46NErLqaW7swzZg=
X-Received: by 2002:a05:6214:801c:b0:705:16d9:16d8 with SMTP id
 6a1803df08f44-70516d9181emr96351766d6.6.1752980888282; Sat, 19 Jul 2025
 20:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <20250608073516.22415-5-laoar.shao@gmail.com>
 <a19a28e6-6a67-464f-9597-2da1d2d906db@gmail.com>
In-Reply-To: <a19a28e6-6a67-464f-9597-2da1d2d906db@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 11:07:32 +0800
X-Gm-Features: Ac12FXyRAfYlda0oZ33NtJkYwFeQfBWm3JyUCjQHjv0g9f2Lbj5t4lwJWlDZr28
Message-ID: <CALOAHbDHHnRcnEMiqLUGimPFe_m9CmD+2XdV4qZJECmRhTDSUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] mm: thp: add bpf thp struct ops
To: Amery Hung <ameryhung@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 2:21=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
>
>
> On 6/8/25 12:35 AM, Yafang Shao wrote:
> > A new bpf_thp struct ops is introduced to provide finer-grained control
> > over THP allocation policy. The struct ops includes two APIs for
> > determining the THP allocator and reclaimer behavior:
> >
> > - THP allocator
> >
> >    int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
> >
> >    The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEP=
AGED,
> >    indicating whether THP allocation should be performed synchronously
> >    (current task) or asynchronously (khugepaged).
> >
> >    The decision is based on the current task context, VMA flags, and TV=
A
> >    flags.
> >
> > - THP reclaimer
> >
> >    int (*reclaimer)(bool vma_madvised);
> >
> >    The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD=
,
> >    determining whether memory reclamation is handled by the current tas=
k or
> >    kswapd.
> >
> >    The decision depends on the current task and VMA flags.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   include/linux/huge_mm.h |  13 +--
> >   mm/Makefile             |   3 +
> >   mm/bpf_thp.c            | 184 +++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 190 insertions(+), 10 deletions(-)
> >   create mode 100644 mm/bpf_thp.c
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 6a40ebf25f5c..0d02c9b56a85 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -54,6 +54,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
> >   };
> >
> >   struct kobject;
> > @@ -192,16 +193,8 @@ static inline bool hugepage_global_always(void)
> >
> >   #define THP_ALLOC_KHUGEPAGED (1 << 1)
> >   #define THP_ALLOC_CURRENT (1 << 2)
> > -static inline int bpf_thp_allocator(unsigned long vm_flags,
> > -                                  unsigned long tva_flags)
> > -{
> > -     return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> > -}
> > -
> > -static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> > -{
> > -     return 0;
> > -}
> > +int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags)=
;
> > +gfp_t bpf_thp_gfp_mask(bool vma_madvised);
> >
> >   static inline int highest_order(unsigned long orders)
> >   {
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 1a7a11d4933d..e5f41cf3fd61 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
> >   obj-$(CONFIG_NUMA) +=3D memory-tiers.o
> >   obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
> >   obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> > +ifdef CONFIG_BPF_SYSCALL
> > +obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D bpf_thp.o
> > +endif
> >   obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> >   obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
> >   obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > new file mode 100644
> > index 000000000000..894d6cb93107
> > --- /dev/null
> > +++ b/mm/bpf_thp.c
> > @@ -0,0 +1,184 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +#define RECLAIMER_CURRENT (1 << 1)
> > +#define RECLAIMER_KSWAPD (1 << 2)
> > +#define RECLAIMER_BOTH (RECLAIMER_CURRENT | RECLAIMER_KSWAPD)
> > +
> > +struct bpf_thp_ops {
> > +     /**
> > +      * @allocator: Specifies whether the THP allocation is performed
> > +      * by the current task or by khugepaged.
> > +      * @vm_flags: Flags for the VMA in the current allocation context
> > +      * @tva_flags: Flags for the TVA in the current allocation contex=
t
> > +      *
> > +      * Rerurn:
> > +      * - THP_ALLOC_CURRENT: THP was allocated synchronously by the ca=
lling
> > +      *   task's context.
> > +      * - THP_ALLOC_KHUGEPAGED: THP was allocated asynchronously by th=
e
> > +      *   khugepaged kernel thread.
> > +      * - 0: THP allocation is disallowed in the current context.
> > +      */
> > +     int (*allocator)(unsigned long vm_flags, unsigned long tva_flags)=
;
> > +     /**
> > +      * @reclaimer: Specifies the entity performing page reclaim:
> > +      *             - current task context
> > +      *             - kswapd
> > +      *             - none (no reclaim)
> > +      * @vma_madvised: MADV flags for this VMA (e.g., MADV_HUGEPAGE, M=
ADV_NOHUGEPAGE)
> > +      *
> > +      * Return:
> > +      * - RECLAIMER_CURRENT: Direct reclaim by the current task if THP
> > +      *   allocation fails.
> > +      * - RECLAIMER_KSWAPD: Wake kswapd to reclaim memory if THP alloc=
ation fails.
> > +      * - RECLAIMER_ALL: Both current and kswapd will perform the recl=
aim
> > +      * - 0: No reclaim will be attempted.
> > +      */
> > +     int (*reclaimer)(bool vma_madvised);
> > +};
> > +
> > +static struct bpf_thp_ops bpf_thp;
> > +
> > +int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags)
> > +{
> > +     int allocator;
> > +
> > +     /* No BPF program is attached */
> > +     if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_A=
TTACHED)))
> > +             return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> > +
> > +     if (current_is_khugepaged())
> > +             return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> > +     if (!bpf_thp.allocator)
> > +             return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> > +
> > +     allocator =3D bpf_thp.allocator(vm_flags, tva_flags);
> > +     if (!allocator)
> > +             return 0;
>
> The check seems redundant. Is it?

Right, thanks for pointing it out.

>
> > +     /* invalid return value */
> > +     if (allocator & ~(THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT))
> > +             return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> > +     return allocator;
> > +}
> > +
> > +gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> > +{
> > +     int reclaimer;
> > +
> > +     if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_A=
TTACHED)))
> > +             return 0;
> > +
> > +     if (!bpf_thp.reclaimer)
> > +             return 0;
> > +
> > +     reclaimer =3D bpf_thp.reclaimer(vma_madvised);
> > +     switch (reclaimer) {
> > +     case RECLAIMER_CURRENT:
> > +             return GFP_TRANSHUGE | __GFP_NORETRY;
> > +     case RECLAIMER_KSWAPD:
> > +             return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
> > +     case RECLAIMER_BOTH:
> > +             return GFP_TRANSHUGE | __GFP_KSWAPD_RECLAIM | __GFP_NORET=
RY;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static bool bpf_thp_ops_is_valid_access(int off, int size,
> > +                                     enum bpf_access_type type,
> > +                                     const struct bpf_prog *prog,
> > +                                     struct bpf_insn_access_aux *info)
> > +{
> > +     return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> > +}
> > +
> > +static const struct bpf_func_proto *
> > +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
> > +{
> > +     return bpf_base_func_proto(func_id, prog);
> > +}
> > +
> > +static const struct bpf_verifier_ops thp_bpf_verifier_ops =3D {
> > +     .get_func_proto =3D bpf_thp_get_func_proto,
> > +     .is_valid_access =3D bpf_thp_ops_is_valid_access,
> > +};
> > +
> > +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_thp_ops *ops =3D kdata;
> > +
> > +     /* TODO: add support for multiple attaches */
> > +     if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +             &transparent_hugepage_flags))
> > +             return -EOPNOTSUPP;
>
> I think returning -EBUSY if the struct_ops is already attached is a
> better choice

Makes sense. Thanks for the suggestion.

>
> > +     bpf_thp.allocator =3D ops->allocator;
> > +     bpf_thp.reclaimer =3D ops->reclaimer;
> > +     return 0;
> > +}
> > +
> > +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepag=
e_flags);
> > +     bpf_thp.allocator =3D NULL;
> > +     bpf_thp.reclaimer =3D NULL;
> > +}
> > +
> > +static int bpf_thp_check_member(const struct btf_type *t,
> > +                             const struct btf_member *member,
> > +                             const struct bpf_prog *prog)
> > +{
> > +     return 0;
> > +}
> > +
>
> [...]
>
> > +static int bpf_thp_init_member(const struct btf_type *t,
> > +                            const struct btf_member *member,
> > +                            void *kdata, const void *udata)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int bpf_thp_init(struct btf *btf)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int allocator(unsigned long vm_flags, unsigned long tva_flags)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int reclaimer(bool vma_madvised)
> > +{
> > +     return 0;
> > +}
> > +
> > +static struct bpf_thp_ops __bpf_thp_ops =3D {
> > +     .allocator =3D allocator,
> > +     .reclaimer =3D reclaimer,
> > +};
> > +
> > +static struct bpf_struct_ops bpf_bpf_thp_ops =3D {
> > +     .verifier_ops =3D &thp_bpf_verifier_ops,
> > +     .init =3D bpf_thp_init,
> > +     .check_member =3D bpf_thp_check_member,
>
> nit. check_member doesn't need to be defined if it does not do anything.

I will remove it.

--=20
Regards
Yafang

