Return-Path: <bpf+bounces-58966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6838DAC47D7
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 07:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D5E7A3F43
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01221E008B;
	Tue, 27 May 2025 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToDso6FN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0A4A33
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325228; cv=none; b=ZBxjEQb/Kl015VbvdXL5+Q51E/ai0HpyQ8/1Clt68yN4mjU2ma0aczXA/cGmQGPkun4vBi5cdAZ6c3v2kbSL5xZkABytkZIgKP1FIy/wnNcSR2wjsI5q+Vafb6bAxCIIOaD3HHiNG0mBfhsI6kKfDbmqnmNRRMzbVAJJQeIxTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325228; c=relaxed/simple;
	bh=reO9SlYvrojLMfXG2Jbzsa5GQur494XllCZju/E67EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyYcu7diyuei8O1ZYOE7QB+u4BDKgdaWt/sITKmmQqE5Dp4W1KJjiQ80Z0pFi7Ip9+vKbrMUMqUl/3RC7Yqvj1afM6jjrYky5095EIz+iJCUwYfBw3Vlng+VEXwJz5wUIx4xBKpMVJihJ2ydKI2Rnb8aGDame+rC2G6qyLU/rO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToDso6FN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fa9dced621so27165286d6.1
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748325225; x=1748930025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+jlkUh3l7BQSELkl79XBQS392Bms/Mo9y185WEn4s8=;
        b=ToDso6FNESoouSKbpGKYHTgtNNZTOs0/ru1r+VFvqsrvIdeMTsHAwyIbFogugmjctb
         3Zb9ZAGAFxJska4cNSo22arjSEu5wiZ7Z2wbE2Cb4GZsxtc6HLvAnS/epUdS9Esa9HiQ
         eGULqoyB3NJUXPe/1hJ2MIz0LxOozY9DjhNyWx+TyUoWdIyqpYICwlGYNXHYs59+fY8D
         ZfS7Rwc9N0oIgWYRugU1wNPXqkRhhc1z+B6xnrlr9T1gyfk4Dq+b74Zp4dil14S+HubG
         OWkAmVtaId8+hujZsGKQ5IDhBxc4Y96OQnl31sRKaTrZv+9OGipxysA9OuUuIuMOh1J+
         C0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325225; x=1748930025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+jlkUh3l7BQSELkl79XBQS392Bms/Mo9y185WEn4s8=;
        b=PxUL9m30LSMpFLJhqKb6WmM0usnYvMxGNx2yRr+UKTEWGfm3phwjJdqTp7FF2iAvWa
         cYMiRYdkSlSxDyNG1mjDnRQHCJC41hBLT1QwTfxJdac0mRKzFMUabzFFslCYrNRruGZq
         azCcfhsksVqrrIju79tNe4c4IO8DT38V5HyakAzawn17I57+uljMHkdlRK1wkW22cwNh
         LgKXdkbWWYqYGSOQBkV8n3xZOXutsGladCPe9LuJBzfUYuTRPz7RDu0OKx0o64UZ75iT
         Aky6vPrIlRPnlCzBfYUjqANcLpwcTI8pXiwgdKsD1P+/OM7OjfoBNYwg8SHumO3BSQat
         7RhA==
X-Forwarded-Encrypted: i=1; AJvYcCVvR8bJDG8+pniSR1puB/CtSymLOJ4BHvjvtTf082cy/05+Ky9DhCvz7XML1IvjMJIRb20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRcBWIPnI75UsheGSHEsHJ9NLE/J7lUYWDenuO5hrSPVqjlEG
	bewBvQYr4g64NixfbDhtdbr3QjKMmRd/T6ryw1IEWkXv4F7IcWaZHWwis+qFYKpSvAe0zpyjTA3
	0rLFHWY8fMR8g84MC5pbFx5aOfGJ/N+0=
X-Gm-Gg: ASbGncvX/EzDuVeKw3tCu3ItkkMwJelL2emJp8bnoCoE3/A1p1KD9blneqvtKMN4Nfo
	T1xOK1Dlmhbc+jk9qEPX3L7wOzou+LLnxYlXhrZ7xx6fAFub/4KDGQSyw/3O8tcH6PmhPxsqtGt
	KS9QZatCrxl3AngIArDqWRH+xyXl9M3GGfqg==
X-Google-Smtp-Source: AGHT+IGg9jK9aZ4hJiCsWXBMCC61gEwztFmL/XIpD/Poc6kt4hDLdJPTLfQndw4XWCMEKtqoLaO9UwlfXFta7WdIVkY=
X-Received: by 2002:a05:6214:1d0e:b0:6fa:a65a:224d with SMTP id
 6a1803df08f44-6faa65a243cmr116898796d6.4.1748325225217; Mon, 26 May 2025
 22:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7570019E-1FF1-47E0-82CD-D28378EBD8B6@nvidia.com>
In-Reply-To: <7570019E-1FF1-47E0-82CD-D28378EBD8B6@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 May 2025 13:53:09 +0800
X-Gm-Features: AX0GCFsJaW1N_a3zIZGQ2An7BlCcwcaEeya7GB9e4FPHLbx2SU3DqjabLfyS7Y4
Message-ID: <CALOAHbA=5cRHJV8hBS18oQ0C_aFx2f4JLJS0gazJgRzTNV99Ww@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:32=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 24 May 2025, at 23:01, Yafang Shao wrote:
>
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
>
> I agree with the above two points.
>
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
> Yes, kernel is basically guessing what userspace wants with some hints
> like MADV_HUGEPAGE/MADV_NOHUGEPAGE. But kernel has the global view
> of memory fragmentation, which userspace cannot get easily.

Correct, memory fragmentation is another critical factor in
determining whether to allocate THP.

> I wonder
> if it is possible that userspace tuning might benefit one set of
> applications but hurt others or overall performance. Right now,
> THP tuning is 0 or 1, either an application wants THPs or not.
> We might need a way of ranking THP requests from userspace to
> let kernel prioritize them (I am not sure if we can add another
> user input parameter, like THP_nice, to get this done, since
> apparently everyone will set THP_nice to -100 to get themselves
> at the top of the list).

Interesting idea. Perhaps we could make this configurable only by sysadmins=
.

--=20
Regards
Yafang

