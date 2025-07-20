Return-Path: <bpf+bounces-63811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC22B0B338
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 04:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C617F74C
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44F14B086;
	Sun, 20 Jul 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWIz0g+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459A10E9
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752978809; cv=none; b=cVYIABVKYncrHnLoREg5WbcR+aARHhbYufzAgMD1iNFM2NQOa3yVj1wmCSadF9QR0nkO7iLxzKZrOCmEK1ZUPOOecS1OfE/Ik4eYxp7rzCJOXyz90ghqr/ROcEWv06MhqBvGqtBt5ha3BmyXqGulkQdUJjs+o0YmHAJ7CLw6pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752978809; c=relaxed/simple;
	bh=nYXndaenW+qDejIVCvwb97L1VRULvsmxqpBBLsy39z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZpN7ecz37FWfpff7iWFly3hmj3klVXJBEEtBGLhmStP8rqf0tHNui5QOY/6AqFo6ZaJffzoYOQjvmcjd0hGYc+fDExHSnGl1UpZOuoi+Lo4c6N0kq9aLTsu88PahwKbld8I+sOzq6L/R90DrHm5+p4LJfmrGvKPdF2UduxcIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWIz0g+4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-700c7e4c048so54797546d6.3
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752978807; x=1753583607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1AcXbZhhMCsQq8cdg55uHT4Lno8k1BjaqAVBbHTohA=;
        b=HWIz0g+4F96WBHsw5zHngm73Dluma9WJuSMQdb1F4k0o0lH0UGwZHYp1GhEBRZGOGd
         J1nNC4JAdkwwAH0cXn/ESXZpfHJ4utFfYa9zqtRGHmFIB49AjrkTsjI4zF94y2SdD8jX
         vOcQZwacPYq/ttC3+U4zgOzyev+TyHUBi55Vahcf3//V8VuSIIe6jJZuFKs2u23kYWXl
         jCuUOY2Nw/PM7lTcubYldwTvit4bRXaI7P2+hBP6ev4bGOcZyPOmM8QEpRJy3Gej8y7w
         3Cd7UG37inh6vkGSBZWX5L4NusuarvSqlvtuWBFb0YWP1fkXI5Zb5xlslY8IJ8rn3XnM
         kscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752978807; x=1753583607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1AcXbZhhMCsQq8cdg55uHT4Lno8k1BjaqAVBbHTohA=;
        b=ctFQ2MzjwNXBmDAvsNLdNneOWrp/ouo9HaC9Wg5HUnrThty7jBQ9e2JTXyE3HMysbJ
         rhclXJyFkinc/WOW5hsz7FbwRguCXYkRJDtVOxVCGV219OJLrL+niq4wHm30Reas4Uon
         EZWqGF2zNkiDI1NEQ+8W/bfDE+CEmclfJRnGjTdsjAzqL3wkoutspJP+sflnvAnPuG2z
         whuQYPL3xWpOkxdcpoxJkE0MqvJenN9KIJA0BYsSKftdeCYwE6O23jdQDCzCBolQFW+4
         FTnnqJCPtjMuyE+JewBOkYnVc+NuIjm13o3n4ihobzaa7Lvnol5JQnE19+7utJI1Bo8J
         J7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUmevsm1tTHYDufPOL6YE9Liy2QX6hhJhVt+GKTII2ckXxinqpF1AlmA8Y5RFDLCeW3bpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuwRPWBHMCR4RsDORPf1WCaK/J/K+EGfBUGYZH2IpwC5EsaYs
	itGkI9bzoOdAlFlO+mUF+aObrPtNeVlhQn5yfP/6oM8OukFPfhnFX1jIcr5UzMhdGLilSiHZfRk
	g4JqarzkM+pftC0JdKcQVD9D7r/SvZbg=
X-Gm-Gg: ASbGncsogoJZ4ViDX3m4lePOy+tFJuQ+to2K+hLyVUGQQGnlt3H9y1gj7+Lcp9qtOQ2
	s9/qPKCnxPK98msu0WMCMKtIs/UEvw6oc4Gb7wJO7mRHuUEubuCwuYCVycBg2YA0HHHMWJdYcJ2
	RWxYAHDcCXqJQ8ClqmVrbMSgC0Mr6ZwJ8FFLV0uZw8Ll7b/s6TJqHqSfC7Yxm7FbKcouSY5v4I/
	RF1c9dm
X-Google-Smtp-Source: AGHT+IFo3rS8yovheWHQeZ6/MU78iRdjhC4knUI/qAE8qhQkjdVnscfZ5FRSyE2vjG2CT0Qt6hM9aqGxg3hoOmtQIWY=
X-Received: by 2002:a05:6214:3a87:b0:704:7c55:4ff3 with SMTP id
 6a1803df08f44-70519fc9d3fmr120998616d6.4.1752978806850; Sat, 19 Jul 2025
 19:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com> <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
In-Reply-To: <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 10:32:50 +0800
X-Gm-Features: Ac12FXzbHqjEqvUujy_ZW2tgACE4NObdiUPq0wo6Dd4Wytvm3VY9_-7qweOQFdU
Message-ID: <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:52=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.07.25 05:09, Yafang Shao wrote:
> > On Wed, Jul 16, 2025 at 6:42=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 08.06.25 09:35, Yafang Shao wrote:
> >>
> >> Sorry for not replying earlier, I was caught up with all other stuff.
> >>
> >> I still consider this a very interesting approach, although I think we
> >> should think more about what a reasonable policy would look like
> >> medoium-term (in particular, multiple THP sizes, not always falling ba=
ck
> >> to small pages if it means splitting excessively in the buddy etc.)
> >
> > I find it difficult to understand why we introduced the mTHP sysfs
> > knobs instead of implementing automatic THP size switching within the
> > kernel. I'm skeptical about its practical utility in real-world
> > workloads.
> >
> > In contrast, XFS large folio (AKA. File THP) can automatically select
> > orders between 0 and 9. Based on our verification, this feature has
> > proven genuinely useful for certain specific workloads=E2=80=94though i=
t's not
> > yet perfect.
>
> I suggest you do some digging about the history of these toggles and the
> plans for the future (automatic), there has been plenty of talk about
> all that.
>
> [...]
>
> >>>
> >>> - THP allocator
> >>>
> >>>     int (*allocator)(unsigned long vm_flags, unsigned long tva_flags)=
;
> >>>
> >>>     The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHU=
GEPAGED,
> >>>     indicating whether THP allocation should be performed synchronous=
ly
> >>>     (current task) or asynchronously (khugepaged).
> >>>
> >>>     The decision is based on the current task context, VMA flags, and=
 TVA
> >>>     flags.
> >>
> >> I think we should go one step further and actually get advises about t=
he
> >> orders (THP sizes) to use. It might be helpful if the program would ha=
ve
> >> access to system stats, to make an educated decision.
> >>
> >> Given page fault information and system information, the program could
> >> then decide which orders to try to allocate.
> >
> > Yes, that aligns with my thoughts as well. For instance, we could
> > automate the decision-making process based on factors like PSI, memory
> > fragmentation, and other metrics. However, this logic could be
> > implemented within BPF programs=E2=80=94all we=E2=80=99d need is to ext=
end the feature
> > by introducing a few kfuncs (also known as BPF helpers).
>
> We discussed this yesterday at a THP upstream meeting, and what we
> should look into is:
>
> (1) Having a callback like
>
> unsigned int (*get_suggested_order)(.., bool in_pagefault);

This interface meets our needs precisely, enabling allocation orders
of either 0 or 9 as required by our workloads.

>
> Where we can provide some information about the fault (vma
> size/flags/anon_name), and whether we are in the page fault (or in
> khugepaged).
>
> Maybe we want a bitmap of orders to try (fallback), not sure yet.
>
> (2) Having some way to tag these callbacks as "this is absolutely
> unstable for now and can be changed as we please.".

BPF has already helped us complete this, so we don=E2=80=99t need to implem=
ent
this restriction.
Note that all BPF kfuncs (including struct_ops) are currently unstable
and may change in the future.

Alexei, could you confirm this understanding?

>
> One idea will be to use this mechanism as a way to easily prototype
> policies, and once we know that a policy works, start moving it into the
> core.
>
> In general, the core, without a BPF program, should be able to continue
> providing a sane default behavior.

makes sense.

>
> >
> >>
> >> That means, one would query during page faults and during khugepaged,
> >> which order one should try -- compared to our current approach of "sta=
rt
> >> with the largest order that is enabled and fits".
> >>
> >>>
> >>> - THP reclaimer
> >>>
> >>>     int (*reclaimer)(bool vma_madvised);
> >>>
> >>>     The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSW=
APD,
> >>>     determining whether memory reclamation is handled by the current =
task or
> >>>     kswapd.
> >>
> >> Not sure about that, will have to look into the details.
> >
> > Some workloads allocate all their memory during initialization and do
> > not require THP at runtime. For such cases, aggressively attempting
> > THP allocation is beneficial. However, other workloads may dynamically
> > allocate THP during execution=E2=80=94if these are latency-sensitive, w=
e must
> > avoid introducing long allocation delays.
> >
> > Given these differing requirements, the global
> > /sys/kernel/mm/transparent_hugepage/defrag setting is insufficient.
> > Instead, we should implement per-workload defrag policies to better
> > optimize performance based on individual application behavior.
>
> We'll be very careful about the callbacks we will offer. Maybe the
> get_suggested_order() callback could itself make a decision and not
> suggest a high order if allocation would require comapction.
>
> Initially, we should keep it simple and see what other callbacks to add
> / how to extend get_suggested_order(), to cover these cases.

Yes, we can proceed by adding a simple get_suggested_order() and
address any remaining details in follow-up work.

--
Regards

Yafang

