Return-Path: <bpf+bounces-63551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914EB0833E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCE7174323
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05951E0DE3;
	Thu, 17 Jul 2025 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2ddTCjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF349171C9
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721835; cv=none; b=utpEbVJOZHDAKmbXS9sgWBI6HUI/EXNnyqrDvY+07JYjnl/Fx1hDBSE/2HQUVTJ+0mDzJFDeiu6pM2fe9LABnxFn40SHTCZaT2BzQkdXZo6W39jUI7O51gdFiUbPszC6jW6UIbg0Ecmws3fC6fgfYIkgVF3DmX8TJ8ClV+xp38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721835; c=relaxed/simple;
	bh=JPIYYUCPuoaBTJMGFo83xeNYRn7dZh/OTbyM1GrDsaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXyzRn1Ow8sPdNlf7YAHwn58j9d+K4lVPQvdRRj4r57tb6EFFO+9tRSGr8tzDvp0y2zZRyfdls2o7GTETtNcVa4AvvG4khJkZ2OpN6goBf6cn7fPrWWgkiH9NSiF12M0osjVlnWm06FKUoPZcK2fsSQBn5yghZXulyAz2pgjCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2ddTCjQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e278d8345aso50708185a.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 20:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752721833; x=1753326633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdEjgjFyfSkQ7Qq7sTJYYecJMsmFRlNLmJSZOVtGdIM=;
        b=N2ddTCjQyfFeFHSINSZuzgawemJEPc4huhsIdOcZei9nvmKqPom2Ancb4QKRW0v8zG
         xx/M0FO3Cj2xjnVE0zNDCIKfzYCJLDd4wibKsWvrPvB1xzndBa/C/MUqpKW+oZxh4wSY
         9UkWdsFKaf3AtR1EUkT4Tg5b1KKXtNb35GNOaO648QJh7+amPr5DNP0/fRDVsujRLr/K
         tYg7JkuTliPM1ds0NoBvstPk/B/EGsRmtPWsT/Exvw3Z7mCxETfPfAlYIGPdvAgLhGKM
         6bKjOYgTowYLnALpd5F5rGB47YaSMOd6SYjF43biH7tC76s7j8z2REkTf2n7SFhfZcDj
         9Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752721833; x=1753326633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdEjgjFyfSkQ7Qq7sTJYYecJMsmFRlNLmJSZOVtGdIM=;
        b=N075QHfbgO59r2JPQJ0KG76SPVoS8Cq4dI1p85HoIkxCxUNZEyM2kk8GcUntWL4eHN
         4CLwhp3vg4MIeIqizQk2+jVMufX17/CG5hwFFYkX6GLAAw3v6mmzQQOJ5L7HR56tghfG
         dG6hE/N4g+1y0wwkAAVm4c+/BjsXErmhCv08g+Iw/3a89EconaIif47aCP3f8O8w8ZqL
         bhjjQxkeKcabZpcfANoz/PSwObC1WMiM97w1TGAowhWAa14wb6F5zFZf321hxMxdrIdu
         txzP8cZNXY7PPH6rsKQc9FIlv29j7kzTHMWb0WHgD7Vde8BzYeQrX12qDl3cq+sCrsPx
         82nA==
X-Forwarded-Encrypted: i=1; AJvYcCWIKDM0Wl/Gu9BS/lZwtPt44I6ky0jJePCGdbSoxS4+8eaHtpoEkmnG4m6m+ubq74ToeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyhBJzLwNYZ3AArorKSkf/oTq73dmURHHaCxqz9B1DbUwL7re
	KOpL+JykghDGb+9gMBeM91IwQbSSNIRWGQFRk7JEvfaq5xBQaJZP4yrm/zGOceIH++0xgowW1eu
	B/4v8rFytw8aolM5pZX83+Ueo48A+oPU=
X-Gm-Gg: ASbGncs6PlcTkR87YAh0YDLmT8SXixHMRFKYl9FophRPFLtG8XLyaxnchc+lkWiFsiI
	9wzyZnDW5+usd6NyfKS94ThWnUKLCxDXUwnRMeXfl6L8lYrY1D5DGrRQ/VJzpZZb8fc0gIJ7Zl0
	0lXmbIZZ5YXwT5W4919NyZ+nzzRlEc1VjCPRsWTtSCrr19meIstPC2fySXon/NGYlF7LHw3T18A
	a9K4NFqH7C05dFemIE=
X-Google-Smtp-Source: AGHT+IGaEET0Q41yt/KUxbXgwYWDbCP2Fwqe/8vdtggSADiYMaZbm3jv4KJAEUX2LELc4GVmkLBYVb1fLlHzCK+aTKA=
X-Received: by 2002:a05:620a:450c:b0:7e2:769a:c85d with SMTP id
 af79cd13be357-7e343350fb3mr712947785a.3.1752721832629; Wed, 16 Jul 2025
 20:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
In-Reply-To: <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 17 Jul 2025 11:09:56 +0800
X-Gm-Features: Ac12FXy-t5oZin4xRVLt33sd1d3DxFzwzaSxQSIQzkxN07Im_3FtSYyRMyaRWxA
Message-ID: <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.06.25 09:35, Yafang Shao wrote:
>
> Sorry for not replying earlier, I was caught up with all other stuff.
>
> I still consider this a very interesting approach, although I think we
> should think more about what a reasonable policy would look like
> medoium-term (in particular, multiple THP sizes, not always falling back
> to small pages if it means splitting excessively in the buddy etc.)

I find it difficult to understand why we introduced the mTHP sysfs
knobs instead of implementing automatic THP size switching within the
kernel. I'm skeptical about its practical utility in real-world
workloads.

In contrast, XFS large folio (AKA. File THP) can automatically select
orders between 0 and 9. Based on our verification, this feature has
proven genuinely useful for certain specific workloads=E2=80=94though it's =
not
yet perfect.

>
> > Background
> > ----------
> >
> > We have consistently configured THP to "never" on our production server=
s
> > due to past incidents caused by its behavior:
> >
> > - Increased memory consumption
> >    THP significantly raises overall memory usage.
> >
> > - Latency spikes
> >    Random latency spikes occur due to more frequent memory compaction
> >    activity triggered by THP.
> >
> > - Lack of Fine-Grained Control
> >    THP tuning knobs are globally configured, making them unsuitable for
> >    containerized environments. When different workloads run on the same
> >    host, enabling THP globally (without per-workload control) can cause
> >    unpredictable behavior.
> >
> > Due to these issues, system administrators remain hesitant to switch to
> > "madvise" or "always" modes=E2=80=94unless finer-grained control over T=
HP
> > behavior is implemented.
> >
> > New Motivation
> > --------------
> >
> > We have now identified that certain AI workloads achieve substantial
> > performance gains with THP enabled. However, we=E2=80=99ve also verifie=
d that some
> > workloads see little to no benefit=E2=80=94or are even negatively impac=
ted=E2=80=94by THP.
> >
> > In our Kubernetes environment, we deploy mixed workloads on a single se=
rver
> > to maximize resource utilization. Our goal is to selectively enable THP=
 for
> > services that benefit from it while keeping it disabled for others. Thi=
s
> > approach allows us to incrementally enable THP for additional services =
and
> > assess how to make it more viable in production.
> >
> > Proposed Solution
> > -----------------
> >
> > To enable fine-grained control over THP behavior, we propose dynamicall=
y
> > adjusting THP policies using BPF. This approach allows per-workload THP
> > tuning, providing greater flexibility and precision.
> >
> > The BPF-based THP adjustment mechanism introduces two new APIs for gran=
ular
> > policy control:
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
>
> I think we should go one step further and actually get advises about the
> orders (THP sizes) to use. It might be helpful if the program would have
> access to system stats, to make an educated decision.
>
> Given page fault information and system information, the program could
> then decide which orders to try to allocate.

Yes, that aligns with my thoughts as well. For instance, we could
automate the decision-making process based on factors like PSI, memory
fragmentation, and other metrics. However, this logic could be
implemented within BPF programs=E2=80=94all we=E2=80=99d need is to extend =
the feature
by introducing a few kfuncs (also known as BPF helpers).

>
> That means, one would query during page faults and during khugepaged,
> which order one should try -- compared to our current approach of "start
> with the largest order that is enabled and fits".
>
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
>
> Not sure about that, will have to look into the details.

Some workloads allocate all their memory during initialization and do
not require THP at runtime. For such cases, aggressively attempting
THP allocation is beneficial. However, other workloads may dynamically
allocate THP during execution=E2=80=94if these are latency-sensitive, we mu=
st
avoid introducing long allocation delays.

Given these differing requirements, the global
/sys/kernel/mm/transparent_hugepage/defrag setting is insufficient.
Instead, we should implement per-workload defrag policies to better
optimize performance based on individual application behavior.

>
> But what could be interesting is deciding how to deal with underutilized
> THPs: for now we will try replacing zero-filled pages by the shared
> zeropage during a split. *maybe* some workloads could benefit from ...
> not doing that, and instead optimize the split.

I believe a per-workload THP shrinker (e.g.,
/sys/kernel/mm/transparent_hugepage/shrink_underused) would also be
valuable.
Thank you for the suggestion.

--=20
Regards
Yafang

