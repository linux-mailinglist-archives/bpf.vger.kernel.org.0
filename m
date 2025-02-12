Return-Path: <bpf+bounces-51284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB45A32DCD
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74C0162F91
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3625A2D3;
	Wed, 12 Feb 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpEriInt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495B214A8F
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382432; cv=none; b=FewuhSMONXlBI1RdHsqINhSjKFLPeujPLkKz+Uw5k+iNNc8um21qZyko2E8sla3QMrYcSFTWPvdFUlh94bHsLShUUWpGvYhrjZ4ra0ofUXoZJGW++vdTj9gr5aaXC7LcrEkDTaMLpmgMBj+I9aR5D5z6B6NwTXpzrlBUxrCaJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382432; c=relaxed/simple;
	bh=HHLQzsqMY/qmJK59ClYK+gzpGL81xhW+kb/ULPc1vqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyxcT4Z8IgK7yvfNWDOEZDONZCpGDEkm+HxIJVnfhg0iH884wgRpE6QlVs0Ir5Aw/5WbjFM7edA/wLXxwZa8GoS4n08Xoj/38pdgPbFeOLvi24IpSjZIQMY7eQFCzbNy6XwBRDKcExhmSxwwlI7ZEyhVdwkxVneN4eL3FNPeWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpEriInt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c92c857aso9918415ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382429; x=1739987229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9fhO+BS2i5TU/nKnLQ/PI4+KQnCWLkCctf34i7V6S8=;
        b=fpEriIntaEwVwZgyrtu/nPnhj2yXFQpcqBwHj2yW9nhQEK77p7jAAUGrjCo7ZKYYI6
         x/etlk9cTvvrvZQAJCroQcgTGn1RX1fyG2RR8f+/o4aZ9rPS8uh8Jb4tjlYHFYiys2ij
         kLhWRThbUptHerBif0rh5aPvmfKXBMVJvpoLALqSrVh1xNPhBBt0TeiJ3MkfXNinGho4
         Qyf/5CuqDBiNv6kRYaGFRk4iLqfCcdpTPr1qHE11+45YXw4qgK6gj9CJbHpJZesCG2nP
         HPKbRzZZq7b6NhZOZfiUMHp8dykL2dzD1TLf8LB8JlijaHfs3N1NkS9zBm0+zbKSRnjF
         THkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382429; x=1739987229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9fhO+BS2i5TU/nKnLQ/PI4+KQnCWLkCctf34i7V6S8=;
        b=Vx3owF5r2Eq2IsuFg2kk8Occ1aXyqlYTpOOc5z5M85P1jdmd7W18qtC000bBsDWhJG
         HGK7PwH3edyX5FKp1hhOooniI6ebiIfXUBdzqSiCojeCgDKmx2vUpkBvivqq44ohMi1c
         RgRQP5xzubIgkc2iReQjjryw3VIM6tvTey9HIofyEmlrsgLkZvIdqUr1zXJYm1eWBIny
         7XjARem7AcCU+nnLgbTgImqAjfIQTIDxDAsm22nB2G49mgVPEmGyWODDqWbDjuSjnl/T
         6U+HUHATBRrkSrQTEEAy/Ddpjt89+BucKiq0kjAS00aytkay4lEGOMgNLRaWbVlut0H/
         xqrQ==
X-Gm-Message-State: AOJu0Yx5dgwaE5wnrhJyO/uQSP5/PEtOMTJ2Scs5PkNzjGiPnOYq14sr
	3GscUsfm0h/nyRGCrMl8Y3z8HwjtoBXxs66tb5QUmSWc1uY3XfRTwlMxxQ==
X-Gm-Gg: ASbGncuiWWxO3uiG2dyRIhjJ9b/sxxBdZOKjAhnveNjuFdWcMMyD1akU3YAZcQh2ypr
	dqhyMzNKbjXCIr5ulT5ZlyyqlbjIvMbBJXQjMAXUB0NVVbkeANkDK8efpd6ZCmy8jjuF9g83a2a
	3u8BIKQoPboCcdtSfCWQTWjvINrzKX3e6TTaum/hTmBcBdz3gOo1HnTuD8bDGkbHnSMCzYhpXd3
	YSygovoB/Vj/CNCpU4eQTOBQI01jwI1q8e9ag+UZrKAF8VD8VlkseGRusVEU4LgbMiKL2UoXNOp
	kpI0BIsQnY7yt5ufXMafG1H/omYS3QG/gfISlJDAlc01oA==
X-Google-Smtp-Source: AGHT+IGfQoyalWrHQlyLgonx0iOL2TKRU24Gx8Ezpd3Df5XDfW68VP7XADVbj3GjLbQQjGKjYMRRXw==
X-Received: by 2002:a17:903:22cd:b0:215:a303:24e9 with SMTP id d9443c01a7336-220d1ed05e9mr3495795ad.3.1739382429173;
        Wed, 12 Feb 2025 09:47:09 -0800 (PST)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:c330])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220c06eb6a7sm14536715ad.43.2025.02.12.09.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 09:47:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Wed, 12 Feb 2025 09:46:59 -0800
Message-Id: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Hi All,

The main motivation is to make alloc page and slab reentrant and
remove bpf_mem_alloc.

v6->v7:
- Took Sebastian's patch for localtry_lock_t as-is with minor
  addition of local_trylock_acquire() for proper LOCKDEP.
  Kept his authorship.
- Adjusted patch 4 to use it. The rest is unchanged.

v6:
https://lore.kernel.org/bpf/20250124035655.78899-1-alexei.starovoitov@gmail.com/

v5->v6:
- Addressed comments from Sebastian, Vlastimil
- New approach for local_lock_t in patch 3. Instead of unconditionally
  increasing local_lock_t size to 4 bytes introduce local_trylock_t
  and use _Generic() tricks to manipulate active field.
- Address stackdepot reentrance issues. alloc part in patch 1 and
  free part in patch 2.
- Inlined mem_cgroup_cancel_charge() in patch 4 since this helper
  is being removed.
- Added Acks.
- Dropped failslab, kfence, kmemleak patch.
- Improved bpf_map_alloc_pages() in patch 6 a bit to demo intended usage.
  It will be refactored further.
- Considered using __GFP_COMP in try_alloc_pages to simplify
  free_pages_nolock a bit, but then decided to make it work
  for all types of pages, since free_pages_nolock() is used by
  stackdepot and currently it's using non-compound order 2.
  I felt it's best to leave it as-is and make free_pages_nolock()
  support all pages.

v5:
https://lore.kernel.org/all/20250115021746.34691-1-alexei.starovoitov@gmail.com/

v4->v5:
- Fixed patch 1 and 4 commit logs and comments per Michal suggestions.
  Added Acks.
- Added patch 6 to make failslab, kfence, kmemleak complaint
  with trylock mode. It's a prerequisite for reentrant slab patches.

v4:
https://lore.kernel.org/bpf/20250114021922.92609-1-alexei.starovoitov@gmail.com/

v3->v4:
Addressed feedback from Michal and Shakeel:
- GFP_TRYLOCK flag is gone. gfpflags_allow_spinning() is used instead.
- Improved comments and commit logs.

v3:
https://lore.kernel.org/bpf/20241218030720.1602449-1-alexei.starovoitov@gmail.com/

v2->v3:
To address the issues spotted by Sebastian, Vlastimil, Steven:
- Made GFP_TRYLOCK internal to mm/internal.h
  try_alloc_pages() and free_pages_nolock() are the only interfaces.
- Since spin_trylock() is not safe in RT from hard IRQ and NMI
  disable such usage in lock_trylock and in try_alloc_pages().
  In such case free_pages_nolock() falls back to llist right away.
- Process trylock_free_pages llist when preemptible.
- Check for things like unaccepted memory and order <= 3 early.
- Don't call into __alloc_pages_slowpath() at all.
- Inspired by Vlastimil's struct local_tryirq_lock adopted it in
  local_lock_t. Extra 4 bytes in !RT in local_lock_t shouldn't
  affect any of the current local_lock_t users. This is patch 3.
- Tested with bpf selftests in RT and !RT and realized how much
  more work is necessary on bpf side to play nice with RT.
  The urgency of this work got higher. The alternative is to
  convert bpf bits left and right to bpf_mem_alloc.

v2:
https://lore.kernel.org/bpf/20241210023936.46871-1-alexei.starovoitov@gmail.com/

v1->v2:
- fixed buggy try_alloc_pages_noprof() in PREEMPT_RT. Thanks Peter.
- optimize all paths by doing spin_trylock_irqsave() first
  and only then check for gfp_flags & __GFP_TRYLOCK.
  Then spin_lock_irqsave() if it's a regular mode.
  So new gfp flag will not add performance overhead.
- patches 2-5 are new. They introduce lockless and/or trylock free_pages_nolock()
  and memcg support. So it's in usable shape for bpf in patch 6.

v1:
https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (5):
  mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
  mm, bpf: Introduce free_pages_nolock()
  memcg: Use trylock to access memcg stock_lock.
  mm, bpf: Use memcg in try_alloc_pages().
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

Sebastian Andrzej Siewior (1):
  locking/local_lock: Introduce localtry_lock_t

 include/linux/bpf.h                 |   2 +-
 include/linux/gfp.h                 |  23 ++++
 include/linux/local_lock.h          |  59 ++++++++
 include/linux/local_lock_internal.h | 123 +++++++++++++++++
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/arena.c                  |   5 +-
 kernel/bpf/syscall.c                |  23 +++-
 lib/stackdepot.c                    |  10 +-
 mm/internal.h                       |   1 +
 mm/memcontrol.c                     |  52 +++++---
 mm/page_alloc.c                     | 200 ++++++++++++++++++++++++++--
 mm/page_owner.c                     |   8 +-
 13 files changed, 472 insertions(+), 41 deletions(-)

-- 
2.43.5


