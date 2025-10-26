Return-Path: <bpf+bounces-72218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F6C0A5BE
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FA53ABB6E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C18925291B;
	Sun, 26 Oct 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1BsCR9F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1CBA3D
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472939; cv=none; b=lBiKFlrJJq7gtL2Ctvuf1rohQZihw6u2ftypANVL5PMhLPbLI9W0TYat11ZSfMoeIr+xTL1HXEhdCBG2AKKR7T1xqXqfSsNz7HB0KUmHRQCBJPS/ZzIs8/k4TIC6jmeXiUlyAxyORDZXo7a2oNnPXLEEM1zYLO4/hkiyUMMMW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472939; c=relaxed/simple;
	bh=4uaXalrNCmR3r9uQhnbgdGAMqQaKUxwCaMNhP8WFtI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mAX4KuI62/radl5oq3C0vNDyBGMAnX9ytKmXcfCoV2oIj//7BQx4rhFxJOxZiy/Ymb058TpUY7IAQirshRxlklGPEGJXr1fCb2OdS+00PZdLiNFeDemsviL7J85GT38UOJu7x+wqEis9lPojmCdO4rk1lncJp01HvTK2g9dHIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1BsCR9F; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so579688a91.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472936; x=1762077736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71oyM3iP4xpqh1DSC2mSfcPoW9iB//67VkyjOnGFurQ=;
        b=X1BsCR9FSUi4j0GfBOhINMj9Zx0ePFmL/u55xcfgubEfkgkewnm3EJawXMbCMEs7m9
         so3DxUBvJ9mtNgk561Dn06fjrq9O5eNAgerkfMmPFd7Zwd6zxV1Ws1F/WdPxWW94yBNu
         JJGO/vJ3P2usIjhH5+hXn6dJCwAGbvv3/h2Tq3/jyYJoBNNVGzSN7BgQLfEYGxEEZMgn
         weChgK5xJ/jQi8kWyF5jGrZn4E7UBzSAx7HqOrkMivGpTqOW4Gr+nnHuY93phESG7Ttx
         wiNlMhirD0Dtfqdyo47s6wV/vjqlY07d0iOeR+0oxA4MMgIJs5CruISDrPuPYky9N3yb
         gI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472936; x=1762077736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71oyM3iP4xpqh1DSC2mSfcPoW9iB//67VkyjOnGFurQ=;
        b=niRY1H/dnST9zEBkMU37pP5qqS+6YKZBrGO8ZKAb27+UNtcft2mqk6w8Id5zqt36pN
         4Du3Oin8ITTZ0HuGunCyZ3CIpzHA02+byEqK1YLuARl9n1zpXWfHlaMwcyxHCzBZDbfG
         HiSrJJaQF2J4wPgUIoOwKd4lPf7CYHiZ15aWHiINDe6iOFusN+cZFNrX2V6Kc26xQ6bM
         s1cAj1zssomRgwLlnTrz4ACW8Zj8HWFcKeH+eS1X1AamyPud6PiC9Cfnfz81GcjCUNfn
         RV8GXpu5MN6P1E8Q+cHL9WiXkNcCyQTq1IilqPrFTZsHQibyaAb1tP2UfjEyBGXsn2zB
         Ck0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLbMLFgvCvZ4QpL9ENV8edD3o6rIjxXmq4FST14cSxj3SuQ4J4/cst6nlHf/vWLxBkAlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZTK93+nu1pM0Hiu/OAe/Vc/eDHUpkx5+RDMS6yeIiR0XuW4b
	tVCiNGSfI85E3EQzgUAoBYgiR3g87hi7MQl/jkmjuCbM03T+44n+xAGP
X-Gm-Gg: ASbGnctQ/Inse8qGYWIWSsuVUQfepvSGg+XuQBzW5kFznjipSLZiLI5lhDinhJRA+hu
	tI1hRw92yHD4IdbRGMbWJHRnqddnSMeY10Tly4KAyjxs+2ZMtvVD75N6obV7thfrquQF9MFqVX0
	HlEznhoKiN6zWOKk7AkaougIrftgxTotCqtJwO8jqh7TKnl2p8sMeQfAhgZTaR8vSp4vGOY9Uig
	H3wVWwEsQqVvTcXIKneecpdgZvBBqnrnEEK8IePWmte+qMYJC4xzmtH6INarR5rhY4jebqMe3Eo
	2EqYsmt0tcOofXJpLXPuk+9W4qUpY6ccjwQURohJ+EZkhrjYfxeERDp2hPMTId39jyOeO+kZ9OW
	6nw9VRR69XxS7WARAzxNa1Qb7eMayzd8Ah3a88GBHx08JcE9Yn99C2qubwjwgJm+/2qw0v/yYzT
	ot/C9JY8pIWR/yUZ1Xy/3dhm+WPfnG5M8nLZ1xTll+BcV08w==
X-Google-Smtp-Source: AGHT+IF3W0fD8mmF2/UGWyg+0FB39FKVjvrwsLKyUVcP5vVu2JK3UT/8NMbm25jqTH9tVOGWi/W2sQ==
X-Received: by 2002:a17:90b:250e:b0:33f:ebdd:9961 with SMTP id 98e67ed59e1d1-33febdd9ccdmr3656581a91.28.1761472935796;
        Sun, 26 Oct 2025 03:02:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:02:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 00/10] mm, bpf: BPF-MM, BPF-THP
Date: Sun, 26 Oct 2025 18:01:49 +0800
Message-Id: <20251026100159.6103-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

History
=======

RFC v1: fmod_ret based BPF-THP hook
        https://lore.kernel.org/linux-mm/20250429024139.34365-1-laoar.shao@gmail.com/

RFC v2: struct_ops based BPF-THP hook
        https://lore.kernel.org/linux-mm/20250520060504.20251-1-laoar.shao@gmail.com/

RFC v4: Get THP order with interface get_suggested_order()
        https://lore.kernel.org/linux-mm/20250729091807.84310-1-laoar.shao@gmail.com/

v4->v9: Simplify the interface to:

        unsigned long
        bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
                                unsigned long orders);

        https://lore.kernel.org/linux-mm/20250930055826.9810-1-laoar.shao@gmail.com/

v9->RFC v10: Scope BPF-THP to individual processes
v10->v11:    Remove the RFC tag
v11->v12:    Fix issues reported by AI

The Design
==========

Scoping BPF-THP to cgroup is rejected
-------------------------------------

As explained by Gutierrez:

1. It breaks the cgroup hierarchy when 2 siblings have different THP policies
2. Cgroup was designed for resource management not for grouping processes and
   tune those processes
3. We set a precedent for other people adding new flags to cgroup and 
   potentially polluting cgroups. We may end up with cgroups having tens of
   different flags, making sysadmin's job more complex

The related links are: 

  https://lore.kernel.org/linux-mm/1940d681-94a6-48fb-b889-cd8f0b91b330@huawei-partners.com/
  https://lore.kernel.org/linux-mm/20241030150851.GB706616@cmpxchg.org/    

So we has to scope it to process.

Scoping BPF-THP to process
--------------------------

To eliminate potential conflicts among competing BPF-THP instances, we
enforce that each process is exclusively managed by a single BPF-THP. This
approach has received agreement from David. For context, see:

  https://lore.kernel.org/linux-mm/3577f7fd-429a-49c5-973b-38174a67be15@redhat.com/

When registering a BPF-THP, we specify the PID of a target task. The
BPF-THP is then installed in the task's `mm_struct`

  struct mm_struct {
      struct bpf_thp_ops __rcu *thp_thp;
  };

Inheritance Behavior:

- Existing child processes are unaffected
- Newly forked children inherit the BPF-THP from their parent
- The BPF-THP persists across exec

A new linked list tracks all tasks managed by each BPF-THP instance:

- Newly managed tasks are added to the list
- Exiting tasks are automatically removed from the list
- During BPF-THP unregistration (e.g., when the BPF link is removed), all
  managed tasks have their bpf_thp pointer set to NULL
- BPF-THP instances can be dynamically updated, with all tracked tasks
  automatically migrating to the new version.

This design simplifies BPF-THP management in production environments by
providing clear lifecycle management and preventing conflicts between
multiple BPF-THP instances.

Global Mode
-----------

The per-process BPF-THP mode is unsuitable for managing shared resources
such as shmem THP and file-backed THP. This aligns with known cgroup
limitations for similar scenarios:

  https://lore.kernel.org/linux-mm/YwNold0GMOappUxc@slm.duckdns.org/ 

Introduce a global BPF-THP mode to address this gap. When registered:
- All existing per-process instances are disabled
- New per-process registrations are blocked
- Existing per-process instances remain registered (no forced unregistration)

The global mode takes precedence over per-process instances. Updates are
type-isolated: global instances can only be updated by new global
instances, and per-process instances by new per-process instances.

BPF CI
------

Several dependency patches are currently in mm-new but haven't been merged
into bpf-next. To enable BPF CI testing, I had to make minor changes to
patches #1 and #2 and trigger the BPF CI manually. For details, see:

  https://github.com/kernel-patches/bpf/pull/10097

An error occurred during the test, but it was unrelated to this series.

Yafang Shao (10):
  mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
  mm: thp: remove vm_flags parameter from thp_vma_allowable_order()
  mm: thp: add support for BPF based THP order selection
  mm: thp: decouple THP allocation between swap and page fault paths
  mm: thp: enable THP allocation exclusively through khugepaged
  mm: bpf-thp: add support for global mode
  Documentation: add BPF THP
  selftests/bpf: add a simple BPF based THP policy
  selftests/bpf: add test case to update THP policy
  selftests/bpf: add test case for BPF-THP inheritance across fork

 Documentation/admin-guide/mm/transhuge.rst    | 113 +++++
 MAINTAINERS                                   |   3 +
 fs/exec.c                                     |   1 +
 fs/proc/task_mmu.c                            |   3 +-
 include/linux/huge_mm.h                       |  58 ++-
 include/linux/khugepaged.h                    |  10 +-
 include/linux/mm_types.h                      |  17 +
 kernel/fork.c                                 |   1 +
 mm/Kconfig                                    |  24 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   7 +-
 mm/huge_memory_bpf.c                          | 423 ++++++++++++++++++
 mm/khugepaged.c                               |  43 +-
 mm/madvise.c                                  |   7 +
 mm/memory.c                                   |  22 +-
 mm/mmap.c                                     |   1 +
 mm/shmem.c                                    |   2 +-
 mm/vma.c                                      |   6 +-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 357 +++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  53 +++
 21 files changed, 1101 insertions(+), 54 deletions(-)
 create mode 100644 mm/huge_memory_bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

-- 
2.47.3


