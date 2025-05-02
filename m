Return-Path: <bpf+bounces-57189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71021AA6A58
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 07:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D00B1BA70E5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 05:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338F1C6FE1;
	Fri,  2 May 2025 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+flXiQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9891A83E8
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164937; cv=none; b=VCuOkw7t+d95FUf5OWWQYKXk165FMenwbUi1bGvZIzarXMAMndH+0pNEbM10eu8uRyH5KG9izWmO2z+Y/R/FOiA38tRMdUCploHXVHb5Xbri0esHCYtfmUsWGKBxViOWQGhUkJmcdHFxDax8N6VqyPmwTQux4NEvTnaSLOz1STY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164937; c=relaxed/simple;
	bh=t1u9wmBOs3zef6yDrpQwy2LXq9ZbzjianWA8+00dGV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toljjIExd+fZf9sj5vlwcf0agsoke8G0bjQG21vqUUUIl0j3gb7j4/pRCqBotFUcaFn8ehMxC3KIf81ftzzHNp50RGFFDNmYs/Iw1+cAc/PRAPhKypgFPXEtT0j/5b87LIHK7+LAZ1yscC8vh2SJwQSm5ccWr8MR7ea9fII9i14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+flXiQ0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso33824766d6.2
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 22:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746164935; x=1746769735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMexbe5tQlgN890FeKVE4DWJ/0rTxSY9QsDpbevR/S0=;
        b=I+flXiQ0nrWausRfer6p4VBntg5O6DXqHJpIK/Dmaz1U5jbLauXl9sf7mnfCFFtz/1
         cE0udb4nTPGUO5UmNutF71wfe8dK1z9zcSbMmZl8b1xddlZf1yScV5M6/XlnDj2VV0uu
         +GA8PnN/EXmhjLsN3IgVsbFZarOLrvnOCpVkcbdnKizA9xzxmihnMWv2iqx7ydsJuF4e
         ai7EZ8jM6lDZIQ7kZCoIVsKFKvyXEroovpzqPabb0sld/CA9fuGRMvDl/Q3z2LCzE2D5
         RxBSnKp99sAmwP1HCZA6yRnBYf3Gfhk3W+RlkHVMZ/enKgkZVWn15m+FpG97aBTFgAxw
         7GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164935; x=1746769735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMexbe5tQlgN890FeKVE4DWJ/0rTxSY9QsDpbevR/S0=;
        b=GfmNIug9VXrs1GpmXX+ADGbe3u+nRZhPt/iNzOmdAqkEGY2rK1BMENRjV5ahKKZWJP
         28d2XCqx5cUZebb5bi8ZhZWHnEB2qvECAfQhJXE1vYydxbJh6FPaP5nj7Ps/5owwhUA2
         OuFCWrCJjSQGRB00IxuVdTqnrK3JVhoXsRjDjA4MndbVVVzfYh4Pypr6j+go1xuyo/Zp
         MbbvOl/fmumK4hFNv59L/fQzyhbbn8QxjDfdcU63wLgjQYB9/czi4GUAR8UZ7XFwFS6a
         ASUBsIqy6odmQEx6URthoZMn8xgLuptRWzq9f4iCY33cGpLkLPYnL90AVw0SzFQiLT9g
         74rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlrXJJVSkvrfgqudfzAqh5bIWCqgasHCN2QHHX6+MuBb39FxKL3qicbvSaSl6gVL5Jkbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6uX2WnGL4q49jg3ryCxG4wKtx5oEFKjPqa0d9drufMNvIyLi
	NRePPkHNidFSr9k6LDiP1uFkKZfjDB50sslfJj+uwD6q4MIfrWsWUqDxtE9EJolXtktbYjDws0s
	uinbZOgjDOFz0cCcGm8AW8jh3R3w=
X-Gm-Gg: ASbGncv4/RzzfmgXaG5rPeBnli2dwY//Wrd9AWBj+STaS4Hi69cTiMMcouLto89E9Jz
	e9R/XjusvywOkM/17VV7j++I5tH3Fh48L6MdQPn50Ubz0HzXvWceWHKoT5Ks+13zXBbY3ouWz8x
	1AVMG33NSwN4m7t03ffx8rWBXuyzehmwCYMw==
X-Google-Smtp-Source: AGHT+IFAssNPhXmkgMLUWRxviUOdBE4T5K5fXxVrO6hktAtHO6KaLdqo53pPUWNztt9jFmQkR6BEzihAnn5NAiIhWOw=
X-Received: by 2002:ad4:5aed:0:b0:6f4:f123:a97a with SMTP id
 6a1803df08f44-6f515279443mr31888236d6.15.1746164934558; Thu, 01 May 2025
 22:48:54 -0700 (PDT)
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
In-Reply-To: <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 2 May 2025 13:48:15 +0800
X-Gm-Features: ATxdqUEXwez0j7P-DIWkuWVLYO87xhgDtGxwM5YlaAjAM8EDfYSzpKPy36U9ofo
Message-ID: <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
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

On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
<gutierrez.asier@huawei-partners.com> wrote:
>
>
> On 4/30/2025 8:53 PM, Zi Yan wrote:
> > On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
> >
> >> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
> >>>>>> If it isn't, can you state why?
> >>>>>>
> >>>>>> The main difference is that you are saying it's in a container tha=
t you
> >>>>>> don't control.  Your plan is to violate the control the internal
> >>>>>> applications have over THP because you know better.  I'm not sure =
how
> >>>>>> people might feel about you messing with workloads,
> >>>>>
> >>>>> It=E2=80=99s not a mess. They have the option to deploy their servi=
ces on
> >>>>> dedicated servers, but they would need to pay more for that choice.
> >>>>> This is a two-way decision.
> >>>>
> >>>> This implies you want a container-level way of controlling the setti=
ng
> >>>> and not a system service-level?
> >>>
> >>> Right. We want to control the THP per container.
> >>
> >> This does strike me as a reasonable usecase.
> >>
> >> I think there is consensus that in the long-term we want this stuff to
> >> just work and truly be transparent to userspace.
> >>
> >> In the short-to-medium term, however, there are still quite a few
> >> caveats. thp=3Dalways can significantly increase the memory footprint =
of
> >> sparse virtual regions. Huge allocations are not as cheap and reliable
> >> as we would like them to be, which for real production systems means
> >> having to make workload-specifcic choices and tradeoffs.
> >>
> >> There is ongoing work in these areas, but we do have a bit of a
> >> chicken-and-egg problem: on the one hand, huge page adoption is slow
> >> due to limitations in how they can be deployed. For example, we can't
> >> do thp=3Dalways on a DC node that runs arbitary combinations of jobs
> >> from a wide array of services. Some might benefit, some might hurt.
> >>
> >> Yet, it's much easier to improve the kernel based on exactly such
> >> production experience and data from real-world usecases. We can't
> >> improve the THP shrinker if we can't run THP.
> >>
> >> So I don't see it as overriding whoever wrote the software running
> >> inside the container. They don't know, and they shouldn't have to care
> >> about page sizes. It's about letting admins and kernel teams get
> >> started on using and experimenting with this stuff, given the very
> >> real constraints right now, so we can get the feedback necessary to
> >> improve the situation.
> >
> > Since you think it is reasonable to control THP at container-level,
> > namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
> > (Asier cc'd)
> >
> > In this patchset, Yafang uses BPF to adjust THP global configs based
> > on VMA, which does not look a good approach to me. WDYT?
> >
> >
> > [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.=
asier@huawei-partners.com/
> >
> > --
> > Best Regards,
> > Yan, Zi
>
> Hi,
>
> I believe cgroup is a better approach for containers, since this
> approach can be easily integrated with the user space stack like
> containerd and kubernets, which use cgroup to control system resources.

The integration of BPF with containerd and Kubernetes is emerging as a
clear trend.

>
> However, I pointed out earlier, the approach I suggested has some
> flaws:
> 1. Potential polution of cgroup with a big number of knobs

Right, the memcg maintainers once told me that introducing a new
cgroup file means committing to maintaining it indefinitely, as these
interface files are treated as part of the ABI.
In contrast, BPF kfuncs are considered an unstable API, giving you the
flexibility to modify them later if needed.

> 2. Requires configuration by the admin
>
> Ideally, as Matthew W. mentioned, there should be an automatic system.

Take Matthew=E2=80=99s XFS large folio feature as an example=E2=80=94it was=
 enabled
automatically. A few years ago, when we upgraded to the 6.1.y stable
kernel, we noticed this new feature. Since it was enabled by default,
we assumed the author was confident in its stability. Unfortunately,
it led to severe issues in our production environment: servers crashed
randomly, and in some cases, we experienced data loss without
understanding the root cause.

We began disabling various kernel configurations in an attempt to
isolate the issue, and eventually, the problem disappeared after
disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
kernel version with THP disabled and had to restart hundreds of
thousands of production servers. It was a nightmare for both us and
our sysadmins.

Last year, we discovered that the initial issue had been resolved by this p=
atch:
https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com/.
We backported the fix and re-enabled XFS large folios=E2=80=94only to face =
a
new nightmare. One of our services began crashing sporadically with
core dumps. It took us several months to trace the issue back to the
re-enabled XFS large folio feature. Fortunately, we were able to
disable it using livepatch, avoiding another round of mass server
restarts. To this day, the root cause remains unknown. The good news
is that the issue appears to be resolved in the 6.12.y stable kernel.
We're still trying to bisect which commit fixed it, though progress is
slow because the issue is not reliably reproducible.

In theory, new features should be enabled automatically. But in
practice, every new feature should come with a tunable knob. That=E2=80=99s=
 a
lesson we learned the hard way from this experience=E2=80=94and perhaps
Matthew did too.

>
> Anyway, regarding containers, I believe cgroup is a good approach
> given that the admin or the container management system uses cgroups
> to set up the containers.
>
> --
> Asier Gutierrez
> Huawei
>

--=20
Regards
Yafang

