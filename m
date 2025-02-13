Return-Path: <bpf+bounces-51345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D805A3361C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B76F3A2B57
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB9204C27;
	Thu, 13 Feb 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH65e4qB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBB9476
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417762; cv=none; b=fBWrAVVFXZhesMs6v2tR79DkfaZX5939qgsG31IoZLhD5XRXDmCA+4zz4vdMNEmLpm2eqxz7iE9JknfZm2rp/67jxDAVYnXqARN8texPxI92rinjR1vcOddtbsT+K0bNigKUObdgoob5dMotFCKD4EgJTBHGWiksOEtImh9J6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417762; c=relaxed/simple;
	bh=1d8fIFT7Ef0/1V8jlUZ0UFzdXtwrJRZtzSnhMCU/1ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ChSYpPpZOK1EXT5S+7aSFReadViTStDWsPxnSgY8u8bmv1fZYC78ytLxGVT/ARgTgUcwRrrb5VtwPepRw1/AXYka5z7LYl5PJwZPiVg5xmGC2Zm8DjUubiJr+T8e/A1e1hZe++LRmsN3PXD0DnDjhE3aIkRD+Yw/sB2F7YACMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH65e4qB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f62cc4088so6112005ad.3
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417760; x=1740022560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/F/5Y1tCE2vrCT95xLgYeFjLhYdDffTJn3bYNGuc4gw=;
        b=RH65e4qB4ccHac4BSsKhur8FAVVVBvAjtryu1JUbQEmiYrbhqSZ9GtJBsBMZ1qjqOT
         bwWgLrFYSTwJsrnIUV9+96rT/NwhHDKtCd90hBsZ3v8GStkjxgzG5siDAvxEHeuFZj9h
         aoy/M81lqbb/IfwOSkVmF77hZ6lROoouqnsPMAkrVKvFbYJ/c/6FMNxeGoO7hdiIkLLd
         75tB9st9EIMxvYAYhx9lEC6XRSUT6qq8cs7CUv0CziLvQrkN4J0Ll0mTFcbViZO8iv3Q
         SmXrdriezi0pPaN7esrZ08Y6HYZMgdZp4kkix1tXp94SRGQpJNsZm8ByVxYyq37xq9/x
         j+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417760; x=1740022560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/F/5Y1tCE2vrCT95xLgYeFjLhYdDffTJn3bYNGuc4gw=;
        b=iCt6EviCF5lZn/VAfdl7CEqNCDALlZjhsdBF5r7gdMx+39GC1BV5QAmuHmgU5sRqio
         NU1nVHlSQz52BKqjoqtltrdiHZmG6RDaYDMmFw8wVrIL/gfspXu4cQjhRsGMISfWvsQi
         z4Tf3N6s0x2lpQ8A7+SD3VP/y6UNmKkAZQboNonsKDWH2aMFT7+556pbTCL+HDxr7DJI
         m0lHUMUzEZqqwLujShC4ZFVkKbSzJ/REZ/Rigy/UuWW4FmWW1py27Sgy1V6fhEpo6OBw
         V6FZ9BailSsg3kJyv4i275d0+G7xSkY4QT31VfbnEn8KZZHFvT4AfAonb+65hvCl6dpq
         h/4w==
X-Gm-Message-State: AOJu0YyfAi9DyKu9PqOYm+K7EP8tHXMp0uE7YIwcSqbPAxPuS3G9wO0M
	DjkaIP9IC20iqS3s3zlN1FPBUKylE4jT1RcGsVYyIv5Mi/R/NA129m0McQ==
X-Gm-Gg: ASbGncsP2hiEVQ3KPU6twYyGtRhyo1mGLnWExJUdprl6mQ7RNfO0DmRQi9hjW+QfNbe
	yGtBM1kgnXFWBd4vy3CDZnwgaUS/5eoznWqStxf/yPVNzTGDf/CgO/6MF4CGx2KIP2UIO93bI0w
	h2gpdeqo7UYcnWf/UdTjmtMGInCNb9tscysCk8ZPnWbxS5u+5GPAu/QA0189bgcxthWo6CONEjY
	Ls+KZzUnrtrQR1v8Mh7oWQfrVmttRzcXbiICc8PUPkurscJNnETB5mrtmfM2httCs9bOaShvhMN
	g5Hkiy1lkkU2dmXCPzFk8HI6uNoGCUBBawcU8f5xPaYjid4MfQ==
X-Google-Smtp-Source: AGHT+IFVW3XUkxi8+x0+pwzPDKfCmXT8Cctzlltk41rn5tvKeWIrEe7ywpTu70J0Ezwq3Nwd3nXcLA==
X-Received: by 2002:a05:6a00:35cf:b0:72f:f764:6269 with SMTP id d2e1a72fcca58-7323c139fa8mr2430260b3a.12.1739417759448;
        Wed, 12 Feb 2025 19:35:59 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256afabsm225850b3a.58.2025.02.12.19.35.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:35:59 -0800 (PST)
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
Subject: [PATCH bpf-next v8 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Wed, 12 Feb 2025 19:35:50 -0800
Message-Id: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
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


