Return-Path: <bpf+bounces-57331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA590AA8FB8
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F1A7A9961
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712041FC0E6;
	Mon,  5 May 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUImnUcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBE1FA261
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437956; cv=none; b=rgLpcBZTQ3f3e43ukyFwGwtzr7wAeBFRyzTt8C3U9Sgjhze6XIkx9vLFZraVGbcmqbD0atRcLB9bepL9FkMCcBmnnb3nd9C1dcrKP6hwIJds3x8VzTDO/sISYrew5oxsMDdehhymX38uGOBCBO9ko6QsdCHcZvGcSYB+BWe6dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437956; c=relaxed/simple;
	bh=1V6wgneDDUoscrLYfbg2Euf7oMDaIpJOS5DKO+Y5Cac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG8eY64wVIejaytr7Gxn5RIqTB4GJpE5ZLHvSV83PObZZt8P/NQzGP6BZpYVKihPSuoKi5Zh7KLOJwqbKFPggpTZj7qemaE53Nkfxu+W8stqlTKCgddKt6fvtIUp0bupKrVFFAA7OEzfBve+Y4m5XDghItbHmCRTPwoi0P4x/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUImnUcc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad744811so33071936d6.1
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746437953; x=1747042753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PniXnnmZ7a07N4kLZ05ow2A8a799DETymk+oTq8f92k=;
        b=hUImnUcc6ZHr0q1Ls++HrWdgBKQ3ia0Zxq1NL6glZiWlwVFUH9UuDNtsOv/s9Id9Tr
         orUGhbv/mjFrpqKaGUuzWP2hsci3aNT5h+98Yk0+hRbI0RnJOahLEOLRQ9X0NEhdFkwl
         KoMdso+H4Ehcpp1SwqKH5F2T8HOCzX4Gi5cqFQqO7REA7l+wc/2U6CMsqTlgIwX0r1sz
         w+DUzNAGA5jpBXXdtsr9q9JInsouH/qdhy2HyxdnoXQhyel6ULn+tx5DWAc+VdfhlweT
         weXwxblwAdhcrXcgNXH2y8p8OJgPKg8GSMurg5mQnzkYRjh1O28M42xI0CjDVAMTjWP0
         xhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746437953; x=1747042753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PniXnnmZ7a07N4kLZ05ow2A8a799DETymk+oTq8f92k=;
        b=cFlOdTqs+v5Ja6fH/+pwIdp/03Sy39R1pRqa5d+cYM54whlkgX/Vq4OQEfBjNpT7th
         88OvaL14BOu9zOdyDUjW+3V4JqDCgsST41ThDkqQ6lSSojqBY+iFQ5xhftQkbiUIacol
         hRN0g5K2YNLG3XD2O8iUKsRo3qw1d8So5FW7qGBnU8HWIj9uOCZcMuMbACtHg60qi0zr
         IkBULnnfva3WEk+TjJdozqpVSOcP1nOlWOsNAQK22eB84CRBgmlWtCQ/jq/0Jr7jywuc
         xfzgmuhSfYjj7o9nQ6Yy8E3IZl6XAwWGcl88zZv2PKLrbojtyAUM8c6DJum5qwO7RvCl
         V8sw==
X-Forwarded-Encrypted: i=1; AJvYcCVkTcsBZaCeWWmKIwfaZcPAIF/8nkel9Zr/fZKqpzZ1SG/yTHVqd44AzujulVq/Yw2N6hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZs2bHTZjxYQIjufUniR7eZwFWWCikyEiu1EKTBlL/lRX9slz
	pr2qL2B+gQX7ix6BHZu/rEolm+0VMP4tg5TnDRNTQ/6eoXgBH3PJ5S+k6SwCG4aLe5sWkirNu0D
	HbA0AnMj7hCcYp56MjEoJZasokcQ=
X-Gm-Gg: ASbGncvWpeKnj19fuNty/JN+/nMCSspo8EhUyzaNrRxFawbZ0g9i0bFtB4AHtx2DLzr
	03jOYXshbpOqns20UOVuNpM3SQlMBr+jyv0+8DQL6WC5f0smJaBJSG8Inrj3M14IFW2ub2zEkSU
	RDmGasBEM1xZ+7dbkVMyByYJY=
X-Google-Smtp-Source: AGHT+IH5E8Q2fSfr06mpuhLKBq2yLsRg6RyFZ/c9Q16ztS7+h+zPz+rsMsfIdCy5fK8FK3cEEnp9/SuvKUocKIDFd38=
X-Received: by 2002:ad4:5c4c:0:b0:6f4:c237:9709 with SMTP id
 6a1803df08f44-6f528c9ca62mr130077606d6.25.1746437952956; Mon, 05 May 2025
 02:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com> <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com> <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org> <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com> <88dd89b9-b2a2-47f7-bc53-1b85004e71da@huawei-partners.com>
In-Reply-To: <88dd89b9-b2a2-47f7-bc53-1b85004e71da@huawei-partners.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 May 2025 17:38:36 +0800
X-Gm-Features: ATxdqUHhMNJNNc_3HkeeMQyecqZ4pH3Yntbjz2m-_N2ilVFXA8JDzBUsehQ6bnk
Message-ID: <CALOAHbCmDa90+6KmikP-6L93FG+ri5yYyMDuuMPW7K4WhKGn0A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:11=E2=80=AFPM Gutierrez Asier
<gutierrez.asier@huawei-partners.com> wrote:
>
>
>
> On 5/2/2025 8:48 AM, Yafang Shao wrote:
> > On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
> > <gutierrez.asier@huawei-partners.com> wrote:
> >>
> >>
> >> On 4/30/2025 8:53 PM, Zi Yan wrote:
> >>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
> >>>
> >>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
> >>>>>>>> If it isn't, can you state why?
> >>>>>>>>
> >>>>>>>> The main difference is that you are saying it's in a container t=
hat you
> >>>>>>>> don't control.  Your plan is to violate the control the internal
> >>>>>>>> applications have over THP because you know better.  I'm not sur=
e how
> >>>>>>>> people might feel about you messing with workloads,
> >>>>>>>
> >>>>>>> It=E2=80=99s not a mess. They have the option to deploy their ser=
vices on
> >>>>>>> dedicated servers, but they would need to pay more for that choic=
e.
> >>>>>>> This is a two-way decision.
> >>>>>>
> >>>>>> This implies you want a container-level way of controlling the set=
ting
> >>>>>> and not a system service-level?
> >>>>>
> >>>>> Right. We want to control the THP per container.
> >>>>
> >>>> This does strike me as a reasonable usecase.
> >>>>
> >>>> I think there is consensus that in the long-term we want this stuff =
to
> >>>> just work and truly be transparent to userspace.
> >>>>
> >>>> In the short-to-medium term, however, there are still quite a few
> >>>> caveats. thp=3Dalways can significantly increase the memory footprin=
t of
> >>>> sparse virtual regions. Huge allocations are not as cheap and reliab=
le
> >>>> as we would like them to be, which for real production systems means
> >>>> having to make workload-specifcic choices and tradeoffs.
> >>>>
> >>>> There is ongoing work in these areas, but we do have a bit of a
> >>>> chicken-and-egg problem: on the one hand, huge page adoption is slow
> >>>> due to limitations in how they can be deployed. For example, we can'=
t
> >>>> do thp=3Dalways on a DC node that runs arbitary combinations of jobs
> >>>> from a wide array of services. Some might benefit, some might hurt.
> >>>>
> >>>> Yet, it's much easier to improve the kernel based on exactly such
> >>>> production experience and data from real-world usecases. We can't
> >>>> improve the THP shrinker if we can't run THP.
> >>>>
> >>>> So I don't see it as overriding whoever wrote the software running
> >>>> inside the container. They don't know, and they shouldn't have to ca=
re
> >>>> about page sizes. It's about letting admins and kernel teams get
> >>>> started on using and experimenting with this stuff, given the very
> >>>> real constraints right now, so we can get the feedback necessary to
> >>>> improve the situation.
> >>>
> >>> Since you think it is reasonable to control THP at container-level,
> >>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
> >>> (Asier cc'd)
> >>>
> >>> In this patchset, Yafang uses BPF to adjust THP global configs based
> >>> on VMA, which does not look a good approach to me. WDYT?
> >>>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierre=
z.asier@huawei-partners.com/
> >>>
> >>> --
> >>> Best Regards,
> >>> Yan, Zi
> >>
> >> Hi,
> >>
> >> I believe cgroup is a better approach for containers, since this
> >> approach can be easily integrated with the user space stack like
> >> containerd and kubernets, which use cgroup to control system resources=
.
> >
> > The integration of BPF with containerd and Kubernetes is emerging as a
> > clear trend.
> >
>
> No, eBPF is not used for resource management, it is mainly used by the
> network stack (CNI), monitoring and security.

This is the most well-known use case of BPF in Kubernetes, thanks to Cilium=
.

> All the resource
> management by Kubernetes is done using cgroups.

The landscape has shifted. As Johannes (the memcg maintainer)
noted[0], "Cgroups are for nested trees dividing up resources. They're
not a good fit for arbitrary, non-hierarchical policy settings."

[0]. https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/

> You are very unlikely
> to convince the Kubernetes community to manage memory resources using
> eBPF.

Kubernetes already natively supports this capability. As documented in
the Container Lifecycle Hooks guide[1], you can easily load BPF
programs as plugins using these hooks. This is exactly the approach
we've successfully implemented in our production environments.

[1]. https://kubernetes.io/docs/concepts/containers/container-lifecycle-hoo=
ks/


--
Regards
Yafang

