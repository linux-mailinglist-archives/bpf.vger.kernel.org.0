Return-Path: <bpf+bounces-65999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD486B2C0CC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804CF171E2C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95B32BF45;
	Tue, 19 Aug 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoPYvTJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA322A4D5
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603826; cv=none; b=RI0No6wn/ugFhxFJsshTqdabruFF0SdEwmTe6/uhl/FJZHJH1UrrtU13GaLsY1i2J5XL65O7MECYeD20xmeSauF3npVVfW6zMBuGuaq5M84tgPwmENE0Q4muqVNsFk56SNdeEf8yDYZE0FZn3TFYrToM3B4bN6akeT9t1I+gXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603826; c=relaxed/simple;
	bh=gM1SKQO/9qsL27KOoHmiSAJKkSZSAAGBkRTruh+taLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kR+aPOtoTvgv2pZJUO+kRftxuPrAdj33PDkyROafckMCFqlEz2mXgWVEKaxIjtkSs6zQniKuHcIt8/3c812PQyiQAp+dQeiI1bj3WJNzRjkQathdZGMk71t1wph4T4RxIs1sKQ5bjd3zEhfsCKN1We5TXIYWknUvKuwBBtpTN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoPYvTJ4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8706c880eso589815685a.3
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755603823; x=1756208623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDRl7pKGEPhnsDQ32deXqvH+LFVXgPlPNsW5Pg/4+Lw=;
        b=hoPYvTJ4dP6HW1IL4R4on947ti56D+Xyke5H5a1FKUPOlwwK4w0/q7f3i5F5HJt5nr
         v7Eom7+73QY5xhei6gIyd0je7P6tXsp8ZZjL89dbods9d1lijl68h1RZXf0MbSTHNqs/
         eJuJm9VCJoCJtY5SukjihCMyAXTjreo5IqIu+yn8TXbrEmtHEsHcJ3DCUxyyzFyJl4tk
         +xi/3JHn1NlUDdXP2hWftQzbbNkEHlz/FL/8PLZ+MYKjLmbgvwe4taHYeINVzvXdpDz2
         9tYUkqX7klrmj/5mk3I87RRqvdFM0ns+G+sKwLDRtyfmCjK67pTuOFZdvmNjjZjZvYtX
         Pk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603823; x=1756208623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDRl7pKGEPhnsDQ32deXqvH+LFVXgPlPNsW5Pg/4+Lw=;
        b=C5Xuth7dmQUaG2OzITGUm5eg1Zq2ad5XrIhkNG4Js9Rr5AZ0gGhUVGQA9ThTRr7WH3
         XfwPUz5Khtmmfwp/e++8emN8EM3KjkgkXmLNRy06A22J0sUaH757wNwykzUP18TpHvxK
         mFmub5loBiCb1/iMnqY5SpOiRjBwQZ1l5ock9WdX/f+CnOc4oyNdgbxGPJCgQTrzwj0o
         RRPRfnBIuhjK3yr7HjlXXbg959ZB1T9YK+QQBP7KingwguKm+W+NCMTZHMttiFsnD5uI
         SKw9lBQa79O05OE4PQvUiB/y20rDeBp1CaodXtru0lRuGsvmVP7J3MklPwqAqlykKMOg
         sEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHzs0YWXwRLJBbH3B/2+a1rSIt+yGyFNKm56RaAA9lTf3KGAO7vtJKfxq3GEwsWBQiTxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiOZh+79OUag6H/ulM1ltpb42yO+2XTTEeN8I6DB7uAdpeFoT
	I1m4cYqHdBQzErnRfE7V+6fFVvYsjOLzQhp87e3QlRSTUxlvqA4zC734gVGbzbVauo9/hBU+Wb/
	kDAoICssTCnY4PuLNPmQ5aVtsSBrqCps=
X-Gm-Gg: ASbGnctvNuJ1oprKx69GcYhDTMDHLj4eneqbVDS2JOYAhqHKvYwxWlslZLyW0PrOhwg
	H6XuHPOLQqlNlFCxzJY5n9UptiAEknI9KIQrx4Wjl1VJIM4+9kX8tFTOEATSIDxffbuN26Qb1De
	22c7v6bcah7CpgWNRNsiZ1K78FNdv9FzgMZGUjmq+vwyG8zqbc2+KP6Txr3rDAexSf/8qY9cvI4
	obfoDkE
X-Google-Smtp-Source: AGHT+IEQRWZETfw6TaV/Y1cUt7is0ycsbkU7AHy2XqNr3gdTaWPTaHfu5jkl9lEXDNCudr183a6YgCdHfI6RtNDb1ok=
X-Received: by 2002:ad4:5dc6:0:b0:709:ded9:5b1a with SMTP id
 6a1803df08f44-70c35c4334dmr22879126d6.46.1755603823087; Tue, 19 Aug 2025
 04:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818055510.968-1-laoar.shao@gmail.com> <20250818055510.968-2-laoar.shao@gmail.com>
 <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com> <7d458b5a-6920-472a-a83c-764c0f00c156@huawei-partners.com>
In-Reply-To: <7d458b5a-6920-472a-a83c-764c0f00c156@huawei-partners.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 19:43:06 +0800
X-Gm-Features: Ac12FXzk9DmQtD2Uz1DTnkhYCjCO22SJ0c7s_qBMz0mjC82X5cx-i_o2T2iAogU
Message-ID: <CALOAHbA9nWKE1QWxxMyXyAPqMr=43MmNw9=K37PXF9tJMS1rpA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 mm-new 1/5] mm: thp: add support for BPF based THP
 order selection
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:11=E2=80=AFPM Gutierrez Asier
<gutierrez.asier@huawei-partners.com> wrote:
>
> Hi,
>
> On 8/18/2025 4:17 PM, Usama Arif wrote:
> >
> >
> > On 18/08/2025 06:55, Yafang Shao wrote:
> >> This patch introduces a new BPF struct_ops called bpf_thp_ops for dyna=
mic
> >> THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
> >> programs to influence THP order selection based on factors such as:
> >> - Workload identity
> >>   For example, workloads running in specific containers or cgroups.
> >> - Allocation context
> >>   Whether the allocation occurs during a page fault, khugepaged, or ot=
her
> >>   paths.
> >> - System memory pressure
> >>   (May require new BPF helpers to accurately assess memory pressure.)
> >>
> >> Key Details:
> >> - Only one BPF program can be attached at a time, but it can be update=
d
> >>   dynamically to adjust the policy.
> >> - Supports automatic mTHP order selection and per-workload THP policie=
s.
> >> - Only functional when THP is set to madise or always.
> >>
> >> It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> >> This feature is unstable and may evolve in future kernel versions.
> >>
> >> Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redh=
at.com/ [0]
> >> Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@luci=
fer.local/ [1]
> >>
> >> Suggested-by: David Hildenbrand <david@redhat.com>
> >> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >> ---
> >>  include/linux/huge_mm.h    |  15 +++
> >>  include/linux/khugepaged.h |  12 ++-
> >>  mm/Kconfig                 |  12 +++
> >>  mm/Makefile                |   1 +
> >>  mm/bpf_thp.c               | 186 ++++++++++++++++++++++++++++++++++++=
+
> >>  mm/huge_memory.c           |  10 ++
> >>  mm/khugepaged.c            |  26 +++++-
> >>  mm/memory.c                |  18 +++-
> >>  8 files changed, 273 insertions(+), 7 deletions(-)
> >>  create mode 100644 mm/bpf_thp.c
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 1ac0d06fb3c1..f0c91d7bd267 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -6,6 +6,8 @@
> >>
> >>  #include <linux/fs.h> /* only for vma_is_dax() */
> >>  #include <linux/kobject.h>
> >> +#include <linux/pgtable.h>
> >> +#include <linux/mm.h>
> >>
> >>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> >>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >> @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
> >>      TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> >>      TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> >>      TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> >> +    TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
> >>  };
> >>
> >>  struct kobject;
> >> @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void)
> >>                      (1<<TRANSPARENT_HUGEPAGE_FLAG);
> >>  }
> >>
> >> +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> >> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *=
vma__nullable,
> >> +                    u64 vma_flags, enum tva_type tva_flags, int order=
s);
> >> +#else
> >> +static inline int
> >> +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma_=
_nullable,
> >> +                u64 vma_flags, enum tva_type tva_flags, int orders)
> >> +{
> >> +    return orders;
> >> +}
> >> +#endif
> >> +
> >>  static inline int highest_order(unsigned long orders)
> >>  {
> >>      return fls_long(orders) - 1;
> >> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> >> index eb1946a70cff..d81c1228a21f 100644
> >> --- a/include/linux/khugepaged.h
> >> +++ b/include/linux/khugepaged.h
> >> @@ -4,6 +4,8 @@
> >>
> >>  #include <linux/mm.h>
> >>
> >> +#include <linux/huge_mm.h>
> >> +
> >>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>  extern struct attribute_group khugepaged_attr_group;
> >> @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct=
 *mm, unsigned long addr,
> >>
> >>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_st=
ruct *oldmm)
> >>  {
> >> -    if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> >> +    /*
> >> +     * THP allocation policy can be dynamically modified via BPF. Eve=
n if a
> >> +     * task was allowed to allocate THPs, BPF can decide whether its =
forked
> >> +     * child can allocate THPs.
> >> +     *
> >> +     * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> >> +     */
> >> +    if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> >> +            get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> >
> > Hi Yafang,
> >
> > From the coverletter, one of the potential usecases you are trying to s=
olve for is if global policy
> > is "never", but the workload want THPs (either always or on madvise bas=
is). But over here,
> > MMF_VM_HUGEPAGE will never be set so in that case mm_flags_test(MMF_VM_=
HUGEPAGE, oldmm) will
> > always evaluate to false and the get_sugested_order call doesnt matter?
> >
> >
> >
> >>              __khugepaged_enter(mm);
> >>  }
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 4108bcd96784..d10089e3f181 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
> >>
> >>        EXPERIMENTAL because the impact of some changes is still unclea=
r.
> >>
> >> +config EXPERIMENTAL_BPF_ORDER_SELECTION
> >> +    bool "BPF-based THP order selection (EXPERIMENTAL)"
> >> +    depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> >> +
> >> +    help
> >> +      Enable dynamic THP order selection using BPF programs. This
> >> +      experimental feature allows custom BPF logic to determine optim=
al
> >> +      transparent hugepage allocation sizes at runtime.
> >> +
> >> +      Warning: This feature is unstable and may change in future kern=
el
> >> +      versions.
> >> +
> >
> >
> > I know there was a discussion on this earlier, but my opinion is that p=
utting all of this
> > as experiment with warnings is not great. No one will be able to deploy=
 this in production
> > if its going to be removed, and I believe thats where the real usage is=
.
> >
> If the goal is to deploy it in Kubernetes, I believe eBPF is the wrong wa=
y to do it. Right
> now eBPF is used mainly for networking (CNI).

As I recall, I've already shared the Kubernetes deployment procedure
with you. [0]
If you=E2=80=99re using k8s, you should definitely check this out.
JFYI, we have already deployed this in our Kubernetes production environmen=
t.

[0] https://lore.kernel.org/linux-mm/CALOAHbDJPP499ZDitUYqThAJ_BmpeWN_NVR-w=
m=3D8XBe3X7Wxkw@mail.gmail.com/

>
> Kubernetes currently has something called Dynamic Resource Allocation (DR=
A), which is already
> in alpha version. It's main use is to share GPU and TPU among many pods. =
Still, we should
> take into account how likely the user space is going to use eBPF for cont=
rolling resources and
> how it integrates with the mechanisms currently available for resource co=
ntrol by the user
> space.

This is unrelated to the current feature.

>
> There is another scenario, when you you have a number of pods and a limit=
 of huge pages you
> want to use among them. Something similar to HugeTLBfs. Could this be ach=
ieved with your
> ebpf implementation?

This feature focuses on policy adjustment rather than resource control.

--=20
Regards
Yafang

