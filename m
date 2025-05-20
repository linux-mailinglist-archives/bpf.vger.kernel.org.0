Return-Path: <bpf+bounces-58527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF6ABCFDD
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2927417CF67
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB325CC59;
	Tue, 20 May 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzAAfVqk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE8258CC1
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723958; cv=none; b=sm1MJUOt1aCjQG+nCwieKkSoAEawABQciT+jmQY3E67jOXI1933pUwIEjwcSZDzBRNP94A4RmBcvYyZdHD/zs++SxaF0tn1b0AJuNCZVmvfcQpEouvvMJ6x7JBWstJgeVbU3copYug2Cl4tB8xoQqQaSrTbHjBjxg4YR7QdB5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723958; c=relaxed/simple;
	bh=qb3C1Jev1D1Rbhw/2guDQzIBwBI96YqL8u+s1DNHyXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhLu45gmeLFbUcnMSDLqtN4rTztwCV0LDgviycwl3uGkIDLoVwb8ilJTuUfq94u18dqde4OKYZKmEDN+Z3lQ0vE28vomSBcpoxwkKaVsFq4daneWGz+65epo+1KXVwTdQsUIfPFzrPQSa16fhRDcUQ08n71VPzSoG/ruBT4XsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzAAfVqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747723954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K02mA4C+4/K25Ln3AUAdiBQorrkaczFdbSqJeBmGrbU=;
	b=ZzAAfVqks/+IGe7MDkeTe9u7IDQiz5YhLDxr+LkfuHjdfu+WsxNwh1kQYmIxy+foToT5Ki
	Oquvko7XXpb91LiuTDP3iEUc3bD2Hua6dZ4s9OkV/On2hJJ05j9uLlnzEWf7q4Wr9hFFJ3
	s22iwlhb4O2I7cAg7COB/fENtkvgSjM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-dXvolgy6NiqJghDK4L1hAQ-1; Tue, 20 May 2025 02:52:33 -0400
X-MC-Unique: dXvolgy6NiqJghDK4L1hAQ-1
X-Mimecast-MFC-AGG-ID: dXvolgy6NiqJghDK4L1hAQ_1747723953
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7081121c3f7so62829467b3.1
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747723952; x=1748328752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K02mA4C+4/K25Ln3AUAdiBQorrkaczFdbSqJeBmGrbU=;
        b=Fn2tX3G7A8O4cc6pu1vLbF5Y7ifgtzfdgl6cfC9uP4ONN/3wnEHnvHyXxfK002cVke
         Y3K6MFS7vHVjSTMN/F6dR6IbDKr2+th0WTdELAQBPmkc2Ya7RqCerlh8EUTSihy8l9RF
         ONccQ2RMfbQUbt2CcErl/g4Wcn1FS3vSYvMymqUlIl355YJgp23yD/opv0UGNmNhMH7F
         GIIdx1NZwPcq83MPNJvbvbhpI7QObNoW/IbItP6EjI4F+Lv6id28BJk91k2U93nx1iZZ
         DKCYAn3TVKJxqwc1xgregVZ2hgd7FUGK8x3+QKiyI3qXqXjnC6IL9XLkgxOkCXgRTuQ2
         pnwg==
X-Forwarded-Encrypted: i=1; AJvYcCWrOUyEQkjr1AtWf/24QDoaBbVTNXmA/siiL4WggLROJ6JeNmR0xqdXGw/8kqj+hHwH0CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoq+rxTvDfm18YQY7QbEXh1HwikrsS/9SjBr0A5/GuO5VsjZB
	2Hs2V5rwoNeDPxGPWRO4ft4Cd0YXMEo3xASUrDmBFFKAxQXMpf97KFpLb1fqTawpUI8urhCFmsK
	3wYjB5AioqIkuCuMrfI2Vc1vQPHwGWv4RaJzyaoPmXNsQlnXLabspyyr5S/+ipKaU+MIFty/HEY
	vkMcg4RwVqHfH80SWoWRsT/VllzQAC8o900xJEZQcpZ67c
X-Gm-Gg: ASbGncvpY4Cw635SUBFPGhzLJx8fEPfRVPBJp6Sl/l7oQibTFJBjDrAPFs4kpQkss8G
	qws6PHtKAX6cGlKO6uaPdyEMScv657F3oUFCMjKasNNqDRZoJ7i5UwMThJVVJ+UjpLvLmy/A=
X-Received: by 2002:a05:690c:3708:b0:70d:cfa6:3a78 with SMTP id 00721157ae682-70dcfa63c61mr77604297b3.14.1747723952261;
        Mon, 19 May 2025 23:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfRmKTFh/P7sVm7GJzzYcMZ5kOxdBOMqKx0xmtNzIhOh//EXCKXxN6SfOiiNKsR2xSVp4cYFUTyKoHaj7f/KM=
X-Received: by 2002:a05:690c:3708:b0:70d:cfa6:3a78 with SMTP id
 00721157ae682-70dcfa63c61mr77604157b3.14.1747723951938; Mon, 19 May 2025
 23:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com>
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 20 May 2025 00:52:05 -0600
X-Gm-Features: AX0GCFv2SCRFUqlzGzET-AHxP_3iGPACHE6NZmE2RNFmksIZEVxzSPB4qcgl-7Y
Message-ID: <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:06=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
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
Hi Yafang Shao,

I believe you would have to invert your logic and disable the
processes you dont want using THPs, and have THP=3D"madvise"|"always". I
have yet to look over Usama's solution in detail but I believe this is
possible based on his cover letter.

I also have an alternative solution proposed here!
https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

It's different in the sense it doesn't give you granular control per
process, cgroup, or BPF programmability, but it "may" suit your needs
by taming the THP waste and removing the latency spikes of PF time THP
compactions/allocations.

Cheers,
-- Nico

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


