Return-Path: <bpf+bounces-65960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C701B2B765
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 05:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0195800B6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86A2D0C68;
	Tue, 19 Aug 2025 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1a9rtTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196E28727E
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572931; cv=none; b=rRUdd5OxC/xz134EQ0Ml4FPVJ/LQhael4iBif3JCyHrQxQoQ39Ed3Olkk0U4f4sDFN845+O6Amw393H1olNqnhBhDTmoPHP2lIvSHpNkPQ9ZjNhlco/CSAL3oQhXpsv268bSmXiL1Y0L7Ob8nGpsRnJl7CNAcZn79GVHB0mBC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572931; c=relaxed/simple;
	bh=54OOzHYB8tDY05PddgMkUoIW6UkaxKN3b0E2YnX4oZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLjSu63hXgKG4hVdnpXrDBYO5skXRs/B6Vc2Q7Z0/yPdqhHy0e1t/Daxw0mlhu4lZIbsLZOfFUiF9O91l7U9Ng/kFmdMCbDOl3XNxWbpw8GFI+9RBQ338SUNbIM2JVbqQtkoAFnn8YqQ+iPyQU62456VfML8ZJzAk0XMOtDofXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1a9rtTV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a9f6542f7so37650876d6.3
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755572928; x=1756177728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVQ3txuqhXptMPW0m70Tse+67oS8ipM+vDOvy7EJnh0=;
        b=W1a9rtTV0Uiyod3vb6Iye4on0cKm8tcevnHDkSVx+Iv8Jpa98h8J3vC4+iMp3oWUBd
         pV5TZ7Y07Grjb6W8HKm0PQNxCNRk2TYmPcaZJ3Q17fdCXl4EgLQ6zoklMNZIgExCrwHu
         4BiZk5LqDZntod3bg/qV+qObRS97nCjCoaZKngNerBSIaSvs1T1VdpXYKqn6nIv2etxk
         JDNYNMbslekfZ95aBVoXEPZWlp3wMJFjdbk5m8DIDHWQHRIS9AaanqcYqZwyDxyOxEWF
         9pUrX3ABbDYVb6pzuKXfPZ6MMPdHzgn52QN4LtYx0TGRlDsAo1xamJYv+wClakJ9/pYm
         NaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572928; x=1756177728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVQ3txuqhXptMPW0m70Tse+67oS8ipM+vDOvy7EJnh0=;
        b=L1gUIELMHmC53/82KRqH1X+KSNj+W3KNIs23ZHRI5sq+qc4vFmMN3vpj2Smn35izVD
         2toDkRsOozjxWFE7g8U/dmMEWkqL7MTCMuxhHxRZIsidX85U8OseROe5NhJqiUVhskyu
         B38tAl5qv/q4IynDFeYEsYJzqpJkANXHJLgCcEk/xoq68TJbBPKHI/AuJyUpRXhE3DOp
         TWgec/bdMkNVN9abv8DnI13F5HYIx5GWLJG5dtsC55j4HFy/1YFIPj185edswLYwV2UO
         O2YjN6d+2E5jfWl1pH1SkKSkcAfBLdDje1WrRMgt4DMKDMvgwM9h8heQKsfhIzdR3SWD
         8YDA==
X-Forwarded-Encrypted: i=1; AJvYcCVXos+0uN0TmzIm+gAzaTyHTA7eOGH7W7pjjjyVEKG5D1pR1tHs64Sbqtm7GBRN4N6DfS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YiI3mqdjBqDug8U8Cc1s6HMkRA3yL88JwNEdDldwHkbSqz/W
	9n/zl0O1Yk6g/soeUWSN2RFmbtUQKSrOnu82hIHh2sr3iVcUsFvnEgummypOTbDO7qhgdl1deDg
	4SLOfwKHibELAOHyCKcqZ1m+5EsvvGLo=
X-Gm-Gg: ASbGncuf2/uia+J6hpZwZUYJCHJGe8+OyeyaduIjXnU/RJQxgtTKrKh9XkLsiAPKOUQ
	9L/S6+zPTqcdXNR4/FkXbHR+TdlDZEzICgW3h0PefCE9FQDYt3/s7kjqGwrmb8+zyrBuANVmI+4
	yzt7l8jzEvw5oYYJia++89Ekrc6/FZDVHNBUxoAJTWa7e6gsdC2DHCKtTz4/srfP0TwrSkHxlgj
	hZYv6lQykmME2Uuh/sigUJs9aVPGQ==
X-Google-Smtp-Source: AGHT+IG4d+j08Ahd6e0IGmLpLjVQywBiVWxr/oNbqn/B7jFk/v+8Z5OpkOO0eFgFAIrZiT4AXFJQ9Ow8ACyQoIj9cbM=
X-Received: by 2002:a05:6214:2529:b0:704:c686:3f54 with SMTP id
 6a1803df08f44-70c35b75de4mr11175206d6.15.1755572928192; Mon, 18 Aug 2025
 20:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818055510.968-1-laoar.shao@gmail.com> <20250818055510.968-2-laoar.shao@gmail.com>
 <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com>
In-Reply-To: <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 11:08:11 +0800
X-Gm-Features: Ac12FXyGdjs74vIigEErSMFXUxLnN6Z-FmbRaiTyFNQo0NxSWMWlqri9y3uiYyo
Message-ID: <CALOAHbAzQmqxcJ7HU+gsdX4+iEj0U=E5mS8nXF8OYW9QxuXSLA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 mm-new 1/5] mm: thp: add support for BPF based THP
 order selection
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> Hi Yafang,
>
> From the coverletter, one of the potential usecases you are trying to solve for is if global policy
> is "never", but the workload want THPs (either always or on madvise basis). But over here,
> MMF_VM_HUGEPAGE will never be set so in that case mm_flags_test(MMF_VM_HUGEPAGE, oldmm) will
> always evaluate to false and the get_sugested_order call doesnt matter?

See the replyment in another thread.

>
>
>
> >               __khugepaged_enter(mm);
> >  }
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 4108bcd96784..d10089e3f181 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
> >
> >         EXPERIMENTAL because the impact of some changes is still unclear.
> >
> > +config EXPERIMENTAL_BPF_ORDER_SELECTION
> > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > +
> > +     help
> > +       Enable dynamic THP order selection using BPF programs. This
> > +       experimental feature allows custom BPF logic to determine optimal
> > +       transparent hugepage allocation sizes at runtime.
> > +
> > +       Warning: This feature is unstable and may change in future kernel
> > +       versions.
> > +
>
>
> I know there was a discussion on this earlier, but my opinion is that putting all of this
> as experiment with warnings is not great. No one will be able to deploy this in production
> if its going to be removed, and I believe thats where the real usage is.

See the replyment in another thread.

>
> >  endif # TRANSPARENT_HUGEPAGE
> >
> >  # simple helper to make the code a bit easier to read
> > diff --git a/mm/Makefile b/mm/Makefile
> > index ef54aa615d9d..cb55d1509be1 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
> >  obj-$(CONFIG_NUMA) += memory-tiers.o
> >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> > +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
> >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> >  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
> >  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > new file mode 100644
> > index 000000000000..2b03539452d1
> > --- /dev/null
> > +++ b/mm/bpf_thp.c
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +struct bpf_thp_ops {
> > +     /**
> > +      * @get_suggested_order: Get the suggested THP orders for allocation
> > +      * @mm: mm_struct associated with the THP allocation
> > +      * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
> > +      *                 When NULL, the decision should be based on @mm (i.e., when
> > +      *                 triggered from an mm-scope hook rather than a VMA-specific
> > +      *                 context).
> > +      *                 Must belong to @mm (guaranteed by the caller).
> > +      * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
> > +      * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> > +      * @orders: Bitmask of requested THP orders for this allocation
> > +      *          - PMD-mapped allocation if PMD_ORDER is set
> > +      *          - mTHP allocation otherwise
> > +      *
> > +      * Rerurn: Bitmask of suggested THP orders for allocation. The highest
> > +      *         suggested order will not exceed the highest requested order
> > +      *         in @orders.
>
> If we want to make this generic enough so that it doesnt change, should we allow suggested order to
> exceed highest requested order?

The maximum requested order is determined by the callsite. For example:
- PMD-mapped THP uses PMD_ORDER
- mTHP uses (PMD_ORDER - 1)

We must respect this upper bound to avoid undefined behavior.

>
> > +      */
> > +     int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > +                                u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;
> > +};
> > +
> > +static struct bpf_thp_ops bpf_thp;
> > +static DEFINE_SPINLOCK(thp_ops_lock);
> > +
> > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > +                     u64 vma_flags, enum tva_type tva_flags, int orders)
> > +{
> > +     int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > +                                u64 vma_flags, enum tva_type tva_flags, int orders);
> > +     int suggested_orders = orders;
> > +
> > +     /* No BPF program is attached */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                   &transparent_hugepage_flags))
> > +             return suggested_orders;
> > +
> > +     rcu_read_lock();
> > +     bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
> > +     if (!bpf_suggested_order)
> > +             goto out;
>
>
> My rcu API knowledge is not the best, but maybe we could do:
>
> if (!rcu_access_pointer(bpf_thp.get_suggested_order))
>         return suggested_orders;
>

There might be a race here.  The current rcu_access_pointer() check
occurs outside the RCU read-side critical section, meaning the
protected pointer could be freed between the check and use.
Therefore, we must perform the NULL check within the RCU read critical
section when dereferencing the pointer:

> rcu_read_lock();
> bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);

 if (!bpf_suggested_order)
     goto out;

>
> I believe this might be better as you dont acquire the rcu_read_lock and avoid
> the lockdep checks when you do rcu_access_pointer, but I might be wrong
> and hope you or someone on the mailing list corrects me if thats the case :)
>
> > +
> > +     suggested_orders = bpf_suggested_order(mm, vma__nullable, vma_flags, tva_flags, orders);
> > +     if (highest_order(suggested_orders) > highest_order(orders))
> > +             suggested_orders = orders;
> > +
>
> Maybe we should allow suggested_order to be greater than order if we want this to be truly generic?
> Not a suggestion to change, just to have a discussion.

As replied above, the upper bound is a limitation.

>
> > +out:
> > +     rcu_read_unlock();
> > +     return suggested_orders;
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
> > +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +     return bpf_base_func_proto(func_id, prog);
> > +}
> > +
> > +static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
> > +     .get_func_proto = bpf_thp_get_func_proto,
> > +     .is_valid_access = bpf_thp_ops_is_valid_access,
> > +};
> > +
> > +static int bpf_thp_init(struct btf *btf)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int bpf_thp_init_member(const struct btf_type *t,
> > +                            const struct btf_member *member,
> > +                            void *kdata, const void *udata)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_thp_ops *ops = kdata;
> > +
> > +     spin_lock(&thp_ops_lock);
> > +     if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +             &transparent_hugepage_flags)) {
> > +             spin_unlock(&thp_ops_lock);
> > +             return -EBUSY;
> > +     }
> > +     WARN_ON_ONCE(bpf_thp.get_suggested_order);
>
> Should it be WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order)) ?

Nice catch.  I'll make that change

>
> > +     WRITE_ONCE(bpf_thp.get_suggested_order, ops->get_suggested_order);
>
> Should it be rcu_assign_pointer instead of WRITE_ONCE?

will change it.

>
> > +     spin_unlock(&thp_ops_lock);
> > +     return 0;
> > +}
> > +
> > +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     spin_lock(&thp_ops_lock);
> > +     clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> > +     WARN_ON_ONCE(!bpf_thp.get_suggested_order);
>
> Maybe need to use use rcu_access_pointer here in the warning?

Agreed, will change it.

>
> > +     rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is_held(&thp_ops_lock));
> > +     spin_unlock(&thp_ops_lock);
> > +
> > +     synchronize_rcu();
> > +}
> > +
> > +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_thp_ops *ops = kdata;
> > +     struct bpf_thp_ops *old = old_kdata;
> > +     int ret = 0;
> > +
> > +     if (!ops || !old)
> > +             return -EINVAL;
> > +
> > +     spin_lock(&thp_ops_lock);
> > +     /* The prog has aleady been removed. */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags)) {
> > +             ret = -ENOENT;
> > +             goto out;
> > +     }
> > +     WARN_ON_ONCE(!bpf_thp.get_suggested_order);
>
> As above about using rcu_access_pointer.

will change it.

Thanks for your review!

-- 
Regards
Yafang

