Return-Path: <bpf+bounces-52233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A105A4051F
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2886419E0D49
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AD1FE463;
	Sat, 22 Feb 2025 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGVjOQT8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E841FBEB3
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192274; cv=none; b=LLQBwABCvb8V1GRSeoUN7N7yP0I/qT5jDxIn2CmSL/6Po03+6XLP4F1nf8CwQz0PlU7WdXHtDz0XCI4+0eVQObC9c0lOeSuilX1/k52vcOlJIXj4614lvvnKqfRgVgd3OYEqZ3THzrGVMBEmvSmeqWHKxEPHDkEtLz0f1Dlp7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192274; c=relaxed/simple;
	bh=dMc1ZBOQrZoZlUOisEaUaNdRyeWZwbdbNy1ihyrh5ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fviueX4fXUV66XNCsVXRD8aO1eMAFOi1khl82N/Kmfhf2sJ6cpXH8ElvQ/6D83KtGbyT8u6duKKuRJveQ9yQqw2rJ7DGz3f6aEkJSO4xjyfoxU+t1vSBiLUO3bCFDLXtwjhiLZufnGWCHklIaOTgtL6EGaJsqh4pA3uDqWUcWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGVjOQT8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8eb195aso61374755ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192272; x=1740797072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIR+vaBmCH81gf3lPHKSq4yJjgf5dTcIauRXAOapdc4=;
        b=kGVjOQT8S42lizvEh7MvMvWMansA0sp7KjTKlM0qK+IdSRFDHAtbABFuFLOqtBfTiF
         H74qGk+vhr5tEMeRfffzFopNFkEynpTLq5hhjaOIHnuY7fbguCeQWKFOqX4ilArSBEP/
         Cm1GjW3A4kqX8Lyz5PU/ME/4j1gMNhdd8Z7Y3WNcynk9BjegBUtfXe+s+HIxl4F6eCTq
         CQckGC3oAmYtIB5xtfl/K7jARZKJiREssmzxkdepqiBceEZzxi1MUCTzRGFaE/p94hOt
         j0UrtdOlegV5GqHeJe9tvLbBnAdKybREd/6pzNJoeoHRE/uKZRnlTKxFEs9paghhh4uV
         d2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192272; x=1740797072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIR+vaBmCH81gf3lPHKSq4yJjgf5dTcIauRXAOapdc4=;
        b=GmmlFls482cBBFwOBXlv4rgR4ViADyPDFxrFS/siPAGFgGFFMEK/0VD1vYLZEBaW9n
         GIIZPfNvWbZC2DgHIACfDwThaRLCUUjNN8KjdLtHCtu1HXHRfcb4DLJoxuUPy56RtdAG
         d4Ejo9VlZnktaxC6Oc2cGxmYePkjAqbN4UOq41Wrhu4+bHH4kv1NAv9RRIH8Jg+gXeJG
         iUQ9PoCpitlKyaeePfWqTrdQCwed/U7mAlgRrQEtBmLmzvRofECYMAXhmzpd+6KR+5yO
         EQay+L8OizTnM1w06aA1c+LcALpDf8HU9CxwRDdq2V+5fHrwXPH5896xvKnW9zlURnvd
         YEGg==
X-Gm-Message-State: AOJu0YxOCExvKv1cU8egkNoA9m/m7+hmgfXhAkwKFcI9fdq8tB3kvIFA
	+UGilKcZcpKH/mHZnsQN2Uk19vPj8PVTxeJuDdIrKCih4m0yo4dAAn1VBQ==
X-Gm-Gg: ASbGncvmvq8nLdi7gRgpDKLf86sODvGmM4xhzVdJ97uQWTJPQdS4eJKRZwvuyjqdb95
	fzHF2KjtBLZuq5/9ECNsoU9pmrjxxLk1zdUgYWGVovIXhH3La/9RLN2fovV8VlVQC+9Uev63ZPa
	ODArE8DbUVoPHLtoBfAWAHkVJR6cNN1ATqKrKwyZUhC01hOVY8+GX5Y76HYhGLzGRNOz01N81es
	w/ieUJHtVHBw3QrA3XBvx7poRCpv/5np/zYx+gXGP1j+fVilpXpZXboCcoT55Q0ZtqOxkR36Hn2
	ym2+d3qDDdfdQnLqQNZ6EyATA5F0jfchGJt2mWlunkS84aIWhhORtw==
X-Google-Smtp-Source: AGHT+IHCy2q5OSVLyb9zJJU+lr9EB5b0ETkZooDfC45u/k9LYYpy905s8TqK2ZkpnWb2o7pn/43yVA==
X-Received: by 2002:a05:6a20:d80b:b0:1ee:a420:7c27 with SMTP id adf61e73a8af0-1eef3cd4506mr10581850637.20.1740192271906;
        Fri, 21 Feb 2025 18:44:31 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732547af8acsm14557469b3a.71.2025.02.21.18.44.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:31 -0800 (PST)
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
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Fri, 21 Feb 2025 18:44:21 -0800
Message-Id: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
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

v8->v9:
- Squash Vlastimil's fix/feature for localtry_trylock, and
  udpate commit log as suggested by Sebastian.
- Drop _noprof suffix in try_alloc_pages kdoc
- rebase

v8:
https://lore.kernel.org/bpf/20250213033556.9534-1-alexei.starovoitov@gmail.com/

v7->v8:
- rebase: s/free_unref_page/free_frozen_page/

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
 include/linux/local_lock.h          |  70 ++++++++++
 include/linux/local_lock_internal.h | 146 ++++++++++++++++++++
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/arena.c                  |   5 +-
 kernel/bpf/syscall.c                |  23 +++-
 lib/stackdepot.c                    |  10 +-
 mm/internal.h                       |   1 +
 mm/memcontrol.c                     |  52 +++++---
 mm/page_alloc.c                     | 200 ++++++++++++++++++++++++++--
 mm/page_owner.c                     |   8 +-
 13 files changed, 506 insertions(+), 41 deletions(-)

-- 
2.43.5


