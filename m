Return-Path: <bpf+bounces-58519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8449ABCEF3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369CA167852
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EF255F55;
	Tue, 20 May 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQtDDx0i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B419259F
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721156; cv=none; b=FkXL4SsW5AEPrOtuKbYWsAOxl5tHdqzMrNUQHm/UpAnJpBTLSDdCXT6idEdMsf+kNcVAvdcNdXBUPVbsY4TXARTbpoVeBC2hortN1er/9kcZCpgngNZ5/K0exv+5eXkG6wzk+mEZvJOgzHyR547E+sq9SxFE/OqxX//jge9xtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721156; c=relaxed/simple;
	bh=KQLrSswPdacb8+xXhNwXWpyl1ut817MLPIaUvHnhAQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SdpXj5HwDI6BVcbY8n+FO1TtPjSBruk2EBAr/IEcTd2s/x212Cdz9LU19a8lRTl141vAkv4HWxyBQA+OoXLjGASzxeDL0Ja5qFt5UuXhfceWBT8ZciPmSvr+pJtK6RoCcj3eGBuWYxgn8FSM0SK9f4A9uwu8sqf0syCJH5Ivzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQtDDx0i; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30ed99132abso1905685a91.3
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721154; x=1748325954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoO1ZG+ahV3O8j+yt6jMzGkcb3VB4QBlBdOxkB1mErg=;
        b=fQtDDx0i5I13xGOYiyFuzxahg8qNnPYb7kby9IYzrH/3bgDfcuinhVsNKKGK8Thm/m
         SpAXWWdlSx0uVD4FEfbXAbCNq9Tf8dZ/lK2FrPBSCgdjp06TIdc/gsK9DY1is//Bz0tR
         4xQXw2rzulZswLnEk01Af+mrmNdVI6AchRZ6cQDksILczQT/vo1uyJmOp1kzVHpfhJ8T
         r34W7qEwabb565NYxsTmt4DKiy4qOzJ/53Vatnj24kJLHech2t+8RY9MU6GBVB+aYj7z
         ZiH4a8YON7uAKDbluHmoTCsYCp4M92OLNllaeEK4o+RKpoArdEOQMMfhZXKYLV5hF0pm
         um3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721154; x=1748325954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoO1ZG+ahV3O8j+yt6jMzGkcb3VB4QBlBdOxkB1mErg=;
        b=dLle3ryDHyzASF6Ov+9TnoltpLLnTLC8FG+HmLTNIl7QNuOCf2RMMlbFFuo3YjVnYb
         0kafpV47GX/p0aXz27T49HdflQ/GPljTB/wMXUxRh1jy3IsURmffge68Ucrxs72J+ObH
         VMa8CqMjs/IHktV0+vtw7ix1XQJlpRpRLKDgtVr5xosFlk5I9oIoC/5GglioPI4/V79t
         +r/FPe+/NzPJdGveyaw2gcFPxAsKV4P30dMEo3QTufPsSzUiK/3eeoAGn5AsMdeNzE6v
         G/BZekUAK8+lq8W9z1yvWFK5mZ1AU1r+biIep+lraxzLi99o0wkiuJ5mYpCI8Sia4Vfe
         IKog==
X-Gm-Message-State: AOJu0Yxv8G3pDlI22QAILdqTUZrj/3KEDNPt0V+/Z1E0U70Eh3hy2Gpj
	SKzcxkdoWSp5RPHP5BnM6ZBJlwJqw6uU9A7YlzF1xOmIb/iuQY4KGxNq
X-Gm-Gg: ASbGncumKvSW7hJd3rGdtzZXL3PVpm8jMIhVInM5ENYYt/yH8m4218n8U1dG2/bJ++a
	8znbUo5Cgr1j9+mKFe4T5btJZy+wf3cJiijV8yEM2MAgjYAD7xNAqER1kGH4/71xoyfw4WdNb3K
	4Ln2jS5FiRKZcFIAOSfYNUsdPne3Z4v6X8i6LjYi4ujfwNMcsEgsZTW+XItoumbSttKY/3cgQxB
	0M6V8lWOGThi3lzvrnye+HsjWcFZCtxhRRT8AhKctUnOegnrwsI7Q/SvfSTWUmjw/U7ASYgNgX0
	cnnwUv2zIP09D7VEZYgwaQC7cmJrNo9kLTIfAQDgiX1BW547PdLjkeI7wHmGx9DWuzNS7VlSOpo
	=
X-Google-Smtp-Source: AGHT+IFO2cTP5K2gFf3u2jvbQ9TH0AIx++5m9nnXFp+E54swdRvB7tIgv4wBN3xBoOSiOnMSyLAADQ==
X-Received: by 2002:a17:90b:1d4f:b0:308:6d7a:5d30 with SMTP id 98e67ed59e1d1-30e7d5458dcmr29595890a91.18.1747721153848;
        Mon, 19 May 2025 23:05:53 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:05:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Date: Tue, 20 May 2025 14:04:58 +0800
Message-Id: <20250520060504.20251-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Background
----------

At my current employer, PDD, we have consistently configured THP to "never"
on our production servers due to past incidents caused by its behavior:

- Increased memory consumption
  THP significantly raises overall memory usage.

- Latency spikes
  Random latency spikes occur due to more frequent memory compaction
  activity triggered by THP.

These issues have made sysadmins hesitant to switch to "madvise" or
"always" modes.

New Motivation
--------------

We have now identified that certain AI workloads achieve substantial
performance gains with THP enabled. However, we’ve also verified that some
workloads see little to no benefit—or are even negatively impacted—by THP.

In our Kubernetes environment, we deploy mixed workloads on a single server
to maximize resource utilization. Our goal is to selectively enable THP for
services that benefit from it while keeping it disabled for others. This
approach allows us to incrementally enable THP for additional services and
assess how to make it more viable in production.

Proposed Solution
-----------------

For this use case, Johannes suggested introducing a dedicated mode [0]. In
this new mode, we could implement BPF-based THP adjustment for fine-grained
control over tasks or cgroups. If no BPF program is attached, THP remains
in "never" mode. This solution elegantly meets our needs while avoiding the
complexity of managing BPF alongside other THP modes.

A selftest example demonstrates how to enable THP for the current task
while keeping it disabled for others.

Alternative Proposals
---------------------

- Gutierrez’s cgroup-based approach [1]
  - Proposed adding a new cgroup file to control THP policy.
  - However, as Johannes noted, cgroups are designed for hierarchical
    resource allocation, not arbitrary policy settings [2].
  
- Usama’s per-task THP proposal based on prctl() [3]: 
  - Enabling THP per task via prctl().
  - As David pointed out, neither madvise() nor prctl() works in "never"
    mode [4], making this solution insufficient for our needs.

Conclusion
----------

Introducing a new "bpf" mode for BPF-based per-task THP adjustments is the
most effective solution for our requirements. This approach represents a
small but meaningful step toward making THP truly usable—and manageable—in
production environments.

This is currently a PoC implementation. Feedback of any kind is welcome.

Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg.org/ [0] 
Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/ [1]
Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/ [2]
Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaarif642@gmail.com/ [3]
Link: https://lore.kernel.org/linux-mm/41e60fa0-2943-4b3f-ba92-9f02838c881b@redhat.com/ [4]

RFC v1->v2:
The main changes are as follows,
- Use struct_ops instead of fmod_ret (Alexei) 
- Introduce a new THP mode (Johannes)
- Introduce new helpers for BPF hook (Zi)
- Refine the commit log

RFC v1: https://lwn.net/Articles/1019290/

Yafang Shao (5):
  mm: thp: Add a new mode "bpf"
  mm: thp: Add hook for BPF based THP adjustment
  mm: thp: add struct ops for BPF based THP adjustment
  bpf: Add get_current_comm to bpf_base_func_proto
  selftests/bpf: Add selftest for THP adjustment

 include/linux/huge_mm.h                       |  15 +-
 kernel/bpf/cgroup.c                           |   2 -
 kernel/bpf/helpers.c                          |   2 +
 mm/Makefile                                   |   3 +
 mm/bpf_thp.c                                  | 120 ++++++++++++
 mm/huge_memory.c                              |  65 ++++++-
 mm/khugepaged.c                               |   3 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 175 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
 10 files changed, 414 insertions(+), 11 deletions(-)
 create mode 100644 mm/bpf_thp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

-- 
2.43.5


