Return-Path: <bpf+bounces-58931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B95AC3D0F
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E00188A45E
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F61EFFB2;
	Mon, 26 May 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6h6ZQcv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7861D86DC
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252306; cv=none; b=RF4XO8JY2EtzlzPI3X2T4Pw3kU/PrqTFfDX6M/6LTLW2Vygytv3kRmQ4loIEQyHcYGbH/2hWrOyLgCoxo4TegKXiDbjkk5NGu8oGGFVXfUbIFMX6k0fjFGGN957X3peM/y40sKjGdwCHwJjtyL3QrQvCd2hodEigvfwvxRkuRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252306; c=relaxed/simple;
	bh=T9ajKTrvsq09f3yhFwwXf9zBYaMf+aV7NV8Ve3OSm3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebZaqiICkgIL4l2Y5kPtLG7oF/pQnNN2Idf6tQOXCE78T4UjnEo1kzkAIj5V13rsYMbVtzsgALUsPLaGyN7FgT/u/dgX3X7u4pyNT4CtRxszLFRPjHk7Fr8Ywb4ledqM579N9mDxoIqiPo4rR/xrJu8aAub4mYaCdFmSNuXEUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6h6ZQcv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4774193fdffso31493321cf.1
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748252304; x=1748857104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5A59FT9CuvJsFQo35fW96IT4aEXb+iFDHAsNy6R8rw=;
        b=D6h6ZQcvzaaRp06Zzfh3fOz1dCzG6EO8D7Tij5lEqw6dtjEfBr9p3r5GmqHTDjENzj
         jhUmtZwrEzy4BQdmduIcSZLQNxKOfTjWv6NeJrP+laNUBhZKKrONY8JNVla0gpy/Z50W
         f3wGtQ1ERw+ViQ6x8BRELDqlbblLjn6jIIrm8ouQj+ZWAExx/O7GYFBrFJBtNXO3+2gh
         sF8BePtK1rkYwLrIiJyKQe4urkTD44X20cRZYG4u1M29HfD3rjOqQdKtbC7PK4UFSpJX
         8REhO1hUq9srViQ/UqLFlFMm+SyOLserq5NNBasvwPK2TYc3tDb6y++WkS/UrZKDVGkh
         T1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252304; x=1748857104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5A59FT9CuvJsFQo35fW96IT4aEXb+iFDHAsNy6R8rw=;
        b=fbQYuz2R+IJQ2nyeVyN/gk3rbHxNTCrT9s9Q/08SIr13xuO/O/63FcpJtKke+OCcfd
         nbCoO1KGStZdE+OLAbidzfeixDMBp65FH5JJbZn2munRqWCmGQEhKFEUpPycHqAnwX7Q
         gypDUL77jRG/deNZDr/i/c78VRjYz+IeaXyQlqtiGyGK16bGReWXZquMw4Z3Y6O0OC6Y
         Xoqc3rTKhWqmnKPtfAso8qdy1wre/mZrQVn/nWN0Cf5pi+0VQsCdQFvN9ppxVT5J68Wf
         c3UNAXqNYurjibbKe2NAVOych9g8NPRh4pWpj6b3CINHeGRlgdn5U1RxeBjADvl1cAOP
         BuwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vEnf2jIxo38+b+6hq5AZNR4REBEK6g17Oz+d+e3WvQnC8B824lJ3RKSTeitVluhV9K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWALylpSo/rBwij19DuxRHn9cLYyCqnR18l/Uof/7E+OyTwQZ
	D74QBMMaxQctPhOBobNQQQM9FIPl6rue8S5+aLWR4W0AufHdfzJQiNrv/vWolvx82t2fqxDgpsC
	1B90ZbVkZhS92ASd96iRnKkLza0xrvOI=
X-Gm-Gg: ASbGncsQwKdagqkI8jYA6LeGDVxB7AfjZHemEabtvXyp8KQI/IAs0xyHW+FD8FpCSVx
	9Vii1iroMUHMFUKyzy/0YWzaGoJmHIIklzGVOtffcq985Hb7xyt9leWAAL5JCYGJ2nBo3lSp6oM
	l5VF1aE246IU6WrrxGiYaRRqzf+2B9DJEcIA==
X-Google-Smtp-Source: AGHT+IG9h1oa4yDTTsRr9qv2qF7VE34ip1MwtWbTEJCIyDkkvGY621U2jfjV/ws3UKHsOtZoB5coCMRvXhf564z6Hew=
X-Received: by 2002:a05:6214:5098:b0:6f8:d76c:5885 with SMTP id
 6a1803df08f44-6fa9d29f798mr155344516d6.37.1748252303888; Mon, 26 May 2025
 02:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <a03e4e99-bcbd-4279-acc1-34d665e7dcef@huawei-partners.com>
In-Reply-To: <a03e4e99-bcbd-4279-acc1-34d665e7dcef@huawei-partners.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 May 2025 17:37:47 +0800
X-Gm-Features: AX0GCFtgqFzFDEYVvpGB9D9uX-pdDApKBy1rHjoi42WzlxzoCq7qQ353vDYJhqc
Message-ID: <CALOAHbDJPP499ZDitUYqThAJ_BmpeWN_NVR-wm=8XBe3X7Wxkw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:41=E2=80=AFPM Gutierrez Asier
<gutierrez.asier@huawei-partners.com> wrote:
>
>
>
> On 5/25/2025 6:01 AM, Yafang Shao wrote:
> > On Tue, May 20, 2025 at 2:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >>
> >> Background
> >> ----------
> >>
> >> At my current employer, PDD, we have consistently configured THP to "n=
ever"
> >> on our production servers due to past incidents caused by its behavior=
:
> >>
> >> - Increased memory consumption
> >>   THP significantly raises overall memory usage.
> >>
> >> - Latency spikes
> >>   Random latency spikes occur due to more frequent memory compaction
> >>   activity triggered by THP.
> >>
> >> These issues have made sysadmins hesitant to switch to "madvise" or
> >> "always" modes.
> >>
> >> New Motivation
> >> --------------
> >>
> >> We have now identified that certain AI workloads achieve substantial
> >> performance gains with THP enabled. However, we=E2=80=99ve also verifi=
ed that some
> >> workloads see little to no benefit=E2=80=94or are even negatively impa=
cted=E2=80=94by THP.
> >>
> >> In our Kubernetes environment, we deploy mixed workloads on a single s=
erver
> >> to maximize resource utilization. Our goal is to selectively enable TH=
P for
> >> services that benefit from it while keeping it disabled for others. Th=
is
> >> approach allows us to incrementally enable THP for additional services=
 and
> >> assess how to make it more viable in production.
> >>
> >> Proposed Solution
> >> -----------------
> >>
> >> For this use case, Johannes suggested introducing a dedicated mode [0]=
. In
> >> this new mode, we could implement BPF-based THP adjustment for fine-gr=
ained
> >> control over tasks or cgroups. If no BPF program is attached, THP rema=
ins
> >> in "never" mode. This solution elegantly meets our needs while avoidin=
g the
> >> complexity of managing BPF alongside other THP modes.
> >>
> >> A selftest example demonstrates how to enable THP for the current task
> >> while keeping it disabled for others.
> >>
> >> Alternative Proposals
> >> ---------------------
> >>
> >> - Gutierrez=E2=80=99s cgroup-based approach [1]
> >>   - Proposed adding a new cgroup file to control THP policy.
> >>   - However, as Johannes noted, cgroups are designed for hierarchical
> >>     resource allocation, not arbitrary policy settings [2].
> >>
> >> - Usama=E2=80=99s per-task THP proposal based on prctl() [3]:
> >>   - Enabling THP per task via prctl().
> >>   - As David pointed out, neither madvise() nor prctl() works in "neve=
r"
> >>     mode [4], making this solution insufficient for our needs.
> >>
> >> Conclusion
> >> ----------
> >>
> >> Introducing a new "bpf" mode for BPF-based per-task THP adjustments is=
 the
> >> most effective solution for our requirements. This approach represents=
 a
> >> small but meaningful step toward making THP truly usable=E2=80=94and m=
anageable=E2=80=94in
> >> production environments.
> >>
> >> This is currently a PoC implementation. Feedback of any kind is welcom=
e.
> >>
> >> Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg=
.org/ [0]
> >> Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierr=
ez.asier@huawei-partners.com/ [1]
> >> Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.o=
rg/ [2]
> >> Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaa=
rif642@gmail.com/ [3]
> >> Link: https://lore.kernel.org/linux-mm/41e60fa0-2943-4b3f-ba92-9f02838=
c881b@redhat.com/ [4]
> >>
> >> RFC v1->v2:
> >> The main changes are as follows,
> >> - Use struct_ops instead of fmod_ret (Alexei)
> >> - Introduce a new THP mode (Johannes)
> >> - Introduce new helpers for BPF hook (Zi)
> >> - Refine the commit log
> >>
> >> RFC v1: https://lwn.net/Articles/1019290/
> >>
> >> Yafang Shao (5):
> >>   mm: thp: Add a new mode "bpf"
> >>   mm: thp: Add hook for BPF based THP adjustment
> >>   mm: thp: add struct ops for BPF based THP adjustment
> >>   bpf: Add get_current_comm to bpf_base_func_proto
> >>   selftests/bpf: Add selftest for THP adjustment
> >>
> >>  include/linux/huge_mm.h                       |  15 +-
> >>  kernel/bpf/cgroup.c                           |   2 -
> >>  kernel/bpf/helpers.c                          |   2 +
> >>  mm/Makefile                                   |   3 +
> >>  mm/bpf_thp.c                                  | 120 ++++++++++++
> >>  mm/huge_memory.c                              |  65 ++++++-
> >>  mm/khugepaged.c                               |   3 +
> >>  tools/testing/selftests/bpf/config            |   1 +
> >>  .../selftests/bpf/prog_tests/thp_adjust.c     | 175 +++++++++++++++++=
+
> >>  .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
> >>  10 files changed, 414 insertions(+), 11 deletions(-)
> >>  create mode 100644 mm/bpf_thp.c
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.=
c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.=
c
> >>
> >> --
> >> 2.43.5
> >>
> >
> > Hi all,
> >
> > Let=E2=80=99s summarize the current state of the discussion and identif=
y how
> > to move forward.
> >
> > - Global-Only Control is Not Viable
> > We all seem to agree that a global-only control for THP is unwise. In
> > practice, some workloads benefit from THP while others do not, so a
> > one-size-fits-all approach doesn=E2=80=99t work.
> >
> > - Should We Use "Always" or "Madvise"?
> > I suspect no one would choose 'always' in its current state. ;)
> > Both Lorenzo and David propose relying on the madvise mode. However,
> > since madvise is an unprivileged userspace mechanism, any user can
> > freely adjust their THP policy. This makes fine-grained control
> > impossible without breaking userspace compatibility=E2=80=94an undesira=
ble
> > tradeoff.
> > Given these limitations, the community should consider introducing a
> > new "admin" mode for privileged THP policy management.
> >
> > - Can the Kernel Automatically Manage THP Without User Input?
> > In practice, users define their own success metrics=E2=80=94such as lat=
ency
> > (RT), queries per second (QPS), or throughput=E2=80=94to evaluate a fea=
ture=E2=80=99s
> > usefulness. If a feature fails to improve these metrics, it provides
> > no practical value.
> > Currently, the kernel lacks visibility into user-defined metrics,
> > making fully automated optimization impossible (at least without user
> > input). More importantly, automatic management offers no benefit if it
> > doesn=E2=80=99t align with user needs.
>
> I don't think that using things like RPS or QPS is the right way.
> These metrics can be affected by many factors like network issues,
> garbage collectors in the user space (JVM, golang, etc.) and many other
> things out of our control. Even noisy neighbors can slow down a service.

This is an example of how to measure whether apps can benefit from a
new feature.
Please review the A/B test details here:
https://en.wikipedia.org/wiki/A/B_testing

--=20
Regards
Yafang

