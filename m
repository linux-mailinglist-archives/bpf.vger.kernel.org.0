Return-Path: <bpf+bounces-58906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A503AC3240
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 05:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD561899235
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEECA5CDF1;
	Sun, 25 May 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxCzdjU6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DF72622
	for <bpf@vger.kernel.org>; Sun, 25 May 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748142112; cv=none; b=bwy/VCkNBBuQ3N1KtLdiyK/PY3hu/08O5bya+4wQqKN5EeH/mUDT6l5Z4sktqNJ7iWNpXY+q7FzeosxnJ1oycLRhqz2jyWrebtWGfrVZYJCamU/sUx5nrZfKbKCXmE3B7YeCMToJRxE8qyjITNWRPwghhYEdlxHrV2/GIFzwPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748142112; c=relaxed/simple;
	bh=c5wo3SIHmsquHcynYrMvphCDSnOpYCMztYxN0Og8d4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkpSD8wsTNSGvF6GwleDZzXdyFdGN+V0jBOGHuYg626q83JV7juxikTMN0muyZ/8krxNcPexgkGGPk/VvLAHDkWOboFAMmfkUsAv39bHdUAKR2D5Up4twkaKZNNm7mk+hZ8BlmVid84Pgwuynwo7tREDODV/DGz+3xrC5dMPE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxCzdjU6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so6363086d6.2
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748142109; x=1748746909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpg3ydFHfh6C0XPQB7F+NnCW4LagDSCJFo3hH04STKo=;
        b=QxCzdjU64ZB7sj0hEFTtfrmWWRe5GHjGrmTUnAlVKUn8AOdiAKbv9ikrlHx/4i5IDV
         IFKnaBioXZyPy6vbDnpuYJYK6LqMp9Qay8RMvMI8sfg/rVrIN83rs+xElgNJi6yUyVo7
         8YVyw1rxxdhbjTXBChGKridxzVGaGEKpa8hGQ1fNBt96ayrO6C2Ru1FqGtKwp9dCBR4W
         /32b/GTGOay5lIA8BqiZqDkRY+162UH6D/t6h/JdKjlwAoTYDp1XQFACHDjh5H9U+5Nf
         AFjGDMftaf/J1sEhWd6Ndb0ckVYQ/pr5fkQZd6sk22pegXOCD9bBcCAHxcIUx+C/IIF+
         9QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748142109; x=1748746909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpg3ydFHfh6C0XPQB7F+NnCW4LagDSCJFo3hH04STKo=;
        b=JjOTRcZcKvmsvAVwq0ABzW+7vQzO65zZ1oz4Jm6ZHHu63BnbLxKL6kbu1213nTzeeP
         xl4GmlzAT4l+PUVp7zi9RUHwSiBaWvrAxuVwo2SdQOYD5DtyhU+SvFaXaDvmSNkgZymq
         486KatzZq1AyzKnMUlQ0s0QIWUZ2D7RR7PcJ9QktwASesGIhEIlmZ2EhI3f5pEydOj/h
         IrOfmWSmHjMCpSRnRsD9SItjPkB0EpwBkCz8ZcfnFsWQbqQkiuyP0nnL2NxYP/jDJvmo
         FCGY3BYSl17eLFH+mWDKQmitA95a4pZAGcu5GdLi0ptL2IMWJXN0bbfguxtUMj5fhd2y
         UdHA==
X-Gm-Message-State: AOJu0YzrUaUTyXsXkk7U1VMTjsadLuu9IcXs7nqkxcEb48mykgR/kvdL
	DKhKglxbTdfNZLyN/t8bG80qeATsukjYP5jInf7yWyOz0ZBF1TYvOg6zVGcZh8GB4n1LeInNmXY
	YBYS4ySwfdwi0nXUTSDPXTiEg3o3yiNU=
X-Gm-Gg: ASbGnct6/aH5x+rwXuDmxvfkwNiMYxsZ66KY5oruHYLeurAfEhBppbpj++1b2i8FJu+
	YhoJXOCF+BfoC8jlroEXZ23PS1kl+TJtlwtLOzmBCWEUndfcO5Q5cSniOjyD1AlibYy7fjJiEA2
	ZCaVeqhGNcMF+U3nKVpABdJhQUxsXs/9C8TA==
X-Google-Smtp-Source: AGHT+IFYZidugpwXxIui43ZlKCb8Zdcj0WFejy/cUh86MZ7zTdngVfHpGXC9aCEc52zFZ4u25BROF764p2MlHAuxyuo=
X-Received: by 2002:a05:6214:2483:b0:6f8:bfbf:5d49 with SMTP id
 6a1803df08f44-6fa9cff2fb7mr83214036d6.5.1748142109494; Sat, 24 May 2025
 20:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com>
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 May 2025 11:01:13 +0800
X-Gm-Features: AX0GCFvIqUjTycaWqTqYAlFohO34CP7TvgS_Cl3gcdcXFRKkl4BcSS_4rVXkny4
Message-ID: <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Background
> ----------
>
> At my current employer, PDD, we have consistently configured THP to "neve=
r"
> on our production servers due to past incidents caused by its behavior:
>
> - Increased memory consumption
>   THP significantly raises overall memory usage.
>
> - Latency spikes
>   Random latency spikes occur due to more frequent memory compaction
>   activity triggered by THP.
>
> These issues have made sysadmins hesitant to switch to "madvise" or
> "always" modes.
>
> New Motivation
> --------------
>
> We have now identified that certain AI workloads achieve substantial
> performance gains with THP enabled. However, we=E2=80=99ve also verified =
that some
> workloads see little to no benefit=E2=80=94or are even negatively impacte=
d=E2=80=94by THP.
>
> In our Kubernetes environment, we deploy mixed workloads on a single serv=
er
> to maximize resource utilization. Our goal is to selectively enable THP f=
or
> services that benefit from it while keeping it disabled for others. This
> approach allows us to incrementally enable THP for additional services an=
d
> assess how to make it more viable in production.
>
> Proposed Solution
> -----------------
>
> For this use case, Johannes suggested introducing a dedicated mode [0]. I=
n
> this new mode, we could implement BPF-based THP adjustment for fine-grain=
ed
> control over tasks or cgroups. If no BPF program is attached, THP remains
> in "never" mode. This solution elegantly meets our needs while avoiding t=
he
> complexity of managing BPF alongside other THP modes.
>
> A selftest example demonstrates how to enable THP for the current task
> while keeping it disabled for others.
>
> Alternative Proposals
> ---------------------
>
> - Gutierrez=E2=80=99s cgroup-based approach [1]
>   - Proposed adding a new cgroup file to control THP policy.
>   - However, as Johannes noted, cgroups are designed for hierarchical
>     resource allocation, not arbitrary policy settings [2].
>
> - Usama=E2=80=99s per-task THP proposal based on prctl() [3]:
>   - Enabling THP per task via prctl().
>   - As David pointed out, neither madvise() nor prctl() works in "never"
>     mode [4], making this solution insufficient for our needs.
>
> Conclusion
> ----------
>
> Introducing a new "bpf" mode for BPF-based per-task THP adjustments is th=
e
> most effective solution for our requirements. This approach represents a
> small but meaningful step toward making THP truly usable=E2=80=94and mana=
geable=E2=80=94in
> production environments.
>
> This is currently a PoC implementation. Feedback of any kind is welcome.
>
> Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg.or=
g/ [0]
> Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.=
asier@huawei-partners.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/=
 [2]
> Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaarif=
642@gmail.com/ [3]
> Link: https://lore.kernel.org/linux-mm/41e60fa0-2943-4b3f-ba92-9f02838c88=
1b@redhat.com/ [4]
>
> RFC v1->v2:
> The main changes are as follows,
> - Use struct_ops instead of fmod_ret (Alexei)
> - Introduce a new THP mode (Johannes)
> - Introduce new helpers for BPF hook (Zi)
> - Refine the commit log
>
> RFC v1: https://lwn.net/Articles/1019290/
>
> Yafang Shao (5):
>   mm: thp: Add a new mode "bpf"
>   mm: thp: Add hook for BPF based THP adjustment
>   mm: thp: add struct ops for BPF based THP adjustment
>   bpf: Add get_current_comm to bpf_base_func_proto
>   selftests/bpf: Add selftest for THP adjustment
>
>  include/linux/huge_mm.h                       |  15 +-
>  kernel/bpf/cgroup.c                           |   2 -
>  kernel/bpf/helpers.c                          |   2 +
>  mm/Makefile                                   |   3 +
>  mm/bpf_thp.c                                  | 120 ++++++++++++
>  mm/huge_memory.c                              |  65 ++++++-
>  mm/khugepaged.c                               |   3 +
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 175 ++++++++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
>  10 files changed, 414 insertions(+), 11 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>
> --
> 2.43.5
>

Hi all,

Let=E2=80=99s summarize the current state of the discussion and identify ho=
w
to move forward.

- Global-Only Control is Not Viable
We all seem to agree that a global-only control for THP is unwise. In
practice, some workloads benefit from THP while others do not, so a
one-size-fits-all approach doesn=E2=80=99t work.

- Should We Use "Always" or "Madvise"?
I suspect no one would choose 'always' in its current state. ;)
Both Lorenzo and David propose relying on the madvise mode. However,
since madvise is an unprivileged userspace mechanism, any user can
freely adjust their THP policy. This makes fine-grained control
impossible without breaking userspace compatibility=E2=80=94an undesirable
tradeoff.
Given these limitations, the community should consider introducing a
new "admin" mode for privileged THP policy management.

- Can the Kernel Automatically Manage THP Without User Input?
In practice, users define their own success metrics=E2=80=94such as latency
(RT), queries per second (QPS), or throughput=E2=80=94to evaluate a feature=
=E2=80=99s
usefulness. If a feature fails to improve these metrics, it provides
no practical value.
Currently, the kernel lacks visibility into user-defined metrics,
making fully automated optimization impossible (at least without user
input). More importantly, automatic management offers no benefit if it
doesn=E2=80=99t align with user needs.
Exception: For kernel-enforced changes (e.g., the page-to-folio
transition), users must adapt regardless. But THP tuning requires
flexibility=E2=80=94forcing automation without measurable gains is
counterproductive.
(Please correct me if I=E2=80=99ve overlooked anything.)

--=20
Regards
Yafang

