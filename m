Return-Path: <bpf+bounces-67819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBFB49E6D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A973B3B49
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542B22425E;
	Tue,  9 Sep 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0N1qsIn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05269223702
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379612; cv=none; b=afQHSX3/0LiCbpRouksy3WY37aqUd7v4xYel3KOogvkCt1O3ghua0KnsS1B7gAL/w77L6wReeFmU76kaWJsNnQJxbGfUdABY64FVPSdMgLBwiN2DDLDu/0yLqGxEfFHIRCz16wdyXgGF8W81aYjxSvDxM7cfC5lww113RjUeoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379612; c=relaxed/simple;
	bh=Xpz4Q3HgOThYXgXXsQSg4qUb3z3ioTsrrBuBFUdAxv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnejeIFg1XTwcNGQqL1an90H5pH5NnpJeinGtrE0P25lHpCqIv4VAAeXyDFqSsIxM8wdQgQqgPzeJ6jTPp6Xp88h76JHbRF0s/rFVTjoHsCv08BlNsmf1uegjuYDfk71Sw6/vLdos0CzUumD2o6hBDpEsHMKCIw5eitDkN7FdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0N1qsIn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4d5886f825so4370283a12.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379610; x=1757984410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3I0VmGs2kpEbMcr5q5JKcZdoO9Oa/TvNmRGysVtq0no=;
        b=B0N1qsInpquPJJMvuFHg50ptm2LabdQxbo/pbejC4hk0oDD46czET6rzi7kyqFHaH+
         bG70Ub8KrfonzMbqfBioJVXeAE6yH3PSaLmUV8fbR90x4yFG6Z8HTqatkga+UtLdu3x6
         JehuAdxTMVxQxwtEe7ARm05gk9bqbC7h4VlQleoFPcLvedAXuCTZ8Smq2EA/1GXlg74M
         LSoHWcpZsyCx5gg7Fy3+spYlC6i0t9H9FrBaLoHt8QQLZhpfj43b3ZooCmgV3da3MFAx
         2ulE2794PoY8R+SNpK87AuWZVu0DaH2CP14k6t765lRkRoCzva8EAHcmRITE+BFxCNho
         OYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379610; x=1757984410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I0VmGs2kpEbMcr5q5JKcZdoO9Oa/TvNmRGysVtq0no=;
        b=HjznoWzy4jEPfGhxjARzDFPWJsn1ruQjciB1aV9TQ6txaTCnmLvphPEfd0xIiyGWdr
         P6zRwBojU6EZML4hxMwNbCRcpYxE/zuOtus+TwiX/mZdDRQDSFk5e/LwYPLKj4mqMzMP
         K7IbHo1fp/sKs7dAmXOw5WqnvoKr3LFzaqJTyi0BlXxsNQE+GfIusDv4kuLQuojKMGJT
         4/vJZ3DNKOzj5rziiX/+NiD/wOV0pUkid0NhAY97w7+wpwmlyDTEZ90LRl7w6GngGqEJ
         ghY+JrsDFvYMR3LfiDy5e7tw4fH2wAtO80M3OJ1wXADFe+l5/91lRQtG7vOCsSiDA4lK
         +XDg==
X-Gm-Message-State: AOJu0YxyshIbDodhXgBJGTs5Rl2aKwzHUsJWv0+U1/f52dqRwM6K2a3C
	I/udz3vtjrWli9UuDX1A6yMv2sVcz1yvSG+0MbvHTXybF0Tlbm1VHa4IYLamCQ==
X-Gm-Gg: ASbGncsOfshcBqIgP/QJyWEGzreRi7ZCG7yeWig07Clnz9vefyXbZT1BJzegtoT6mWn
	vA83DLITkvY2qGDEwKcHDQrcilEsNE0ieLylPHUrTwfrrIIWp+l3/9a81p9CVEmU3koacS9xXCw
	GashRAM0OTIbvN1lEdJfCykIRfiEe7AzHzfRjGRJeQHfZjp2hgUPubAWlJjFESSTXuiKTeEulUv
	UsYfcClrUn9+8Z0rNsld4/iYgHVMn0LTBNq+AaPpjt4P2KvIxCCk/YGqAjGia+SNcQj8wg7A47k
	2gb8hK8l+Hj2B2/vYfB3uErFx05M6ONGwliq3gV+iY/guZJ60j/BXllWpaTHCKbRLx4ugOlPO7x
	I1KMaMcnedMte1Em1LFHbEDUWqSo7rCKHs8x44u/9h8INBReufJl8EL1en4ejGF9sNL/v/BHZL/
	hBMU/2+k+v
X-Google-Smtp-Source: AGHT+IEM2XoQeUfxViqxHUBGb9ymPiInaAJmBJ0r2R3U73+XlaqvewD+wzVN2Y2P6L12bEYs46pCRg==
X-Received: by 2002:a17:903:1b64:b0:24b:4a9a:703a with SMTP id d9443c01a7336-2516e4aeb33mr144178765ad.17.1757379609741;
        Mon, 08 Sep 2025 18:00:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c30f4sm135606085ad.110.2025.09.08.18.00.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH slab v5 0/6] slab: Re-entrant kmalloc_nolock() 
Date: Mon,  8 Sep 2025 18:00:01 -0700
Message-Id: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Overview:

This patch set introduces kmalloc_nolock() which is the next logical
step towards any context allocation necessary to remove bpf_mem_alloc
and get rid of preallocation requirement in BPF infrastructure.
In production BPF maps grew to gigabytes in size. Preallocation wastes
memory. Alloc from any context addresses this issue for BPF and
other subsystems that are forced to preallocate too.
This long task started with introduction of alloc_pages_nolock(),
then memcg and objcg were converted to operate from any context
including NMI, this set completes the task with kmalloc_nolock()
that builds on top of alloc_pages_nolock() and memcg changes.
After that BPF subsystem will gradually adopt it everywhere.

The patch set is on top of slab/for-next that already has
pre-patch "locking/local_lock: Expose dep_map in local_trylock_t." applied.
I think the patch set should be routed via vbabka/slab.git.

v4->v5:
- New patch "Reuse first bit for OBJEXTS_ALLOC_FAIL" to free up a bit
  and use it to mark slabobj_ext vector allocated with kmalloc_nolock(),
  so that freeing of the vector can be done with kfree_nolock()
- Call kasan_slab_free() directly from kfree_nolock() instead of deferring to
  do_slab_free() to avoid double poisoning
- Addressed other minor issues spotted by Harry

v4:
https://lore.kernel.org/all/20250718021646.73353-1-alexei.starovoitov@gmail.com/

v3->v4:
- Converted local_lock_cpu_slab() to macro
- Reordered patches 5 and 6
- Emphasized that kfree_nolock() shouldn't be used on kmalloc()-ed objects
- Addressed other comments and improved commit logs
- Fixed build issues reported by bots

v3:
https://lore.kernel.org/bpf/20250716022950.69330-1-alexei.starovoitov@gmail.com/

v2->v3:
- Adopted Sebastian's local_lock_cpu_slab(), but dropped gfpflags
  to avoid extra branch for performance reasons,
  and added local_unlock_cpu_slab() for symmetry.
- Dropped local_lock_lockdep_start/end() pair and switched to
  per kmem_cache lockdep class on PREEMPT_RT to silence false positive
  when the same cpu/task acquires two local_lock-s.
- Refactorred defer_free per Sebastian's suggestion
- Fixed slab leak when it needs to be deactivated via irq_work and llist
  as Vlastimil proposed. Including defer_free_barrier().
- Use kmem_cache->offset for llist_node pointer when linking objects
  instead of zero offset, since whole object could be used for slabs
  with ctors and other cases.
- Fixed "cnt = 1; goto redo;" issue.
- Fixed slab leak in alloc_single_from_new_slab().
- Retested with slab_debug, RT, !RT, lockdep, kasan, slab_tiny
- Added acks to patches 1-4 that should be good to go.

v2:
https://lore.kernel.org/bpf/20250709015303.8107-1-alexei.starovoitov@gmail.com/

v1->v2:
Added more comments for this non-trivial logic and addressed earlier comments.
In particular:
- Introduce alloc_frozen_pages_nolock() to avoid refcnt race
- alloc_pages_nolock() defaults to GFP_COMP
- Support SLUB_TINY
- Added more variants to stress tester to discover that kfree_nolock() can
  OOM, because deferred per-slab llist won't be serviced if kfree_nolock()
  gets unlucky long enough. Scraped previous approach and switched to
  global per-cpu llist with immediate irq_work_queue() to process all
  object sizes.
- Reentrant kmalloc cannot deactivate_slab(). In v1 the node hint was
  downgraded to NUMA_NO_NODE before calling slab_alloc(). Realized it's not
  good enough. There are odd cases that can trigger deactivate. Rewrote
  this part.
- Struggled with SLAB_NO_CMPXCHG. Thankfully Harry had a great suggestion:
  https://lore.kernel.org/bpf/aFvfr1KiNrLofavW@hyeyoo/
  which was adopted. So slab_debug works now.
- In v1 I had to s/local_lock_irqsave/local_lock_irqsave_check/ in a bunch
  of places in mm/slub.c to avoid lockdep false positives.
  Came up with much cleaner approach to silence invalid lockdep reports
  without sacrificing lockdep coverage. See local_lock_lockdep_start/end().

v1:
https://lore.kernel.org/bpf/20250501032718.65476-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (6):
  locking/local_lock: Introduce local_lock_is_locked().
  mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
  mm: Introduce alloc_frozen_pages_nolock()
  slab: Make slub local_(try)lock more precise for LOCKDEP
  slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
  slab: Introduce kmalloc_nolock() and kfree_nolock().

 include/linux/gfp.h                 |   2 +-
 include/linux/kasan.h               |  13 +-
 include/linux/local_lock.h          |   2 +
 include/linux/local_lock_internal.h |   7 +
 include/linux/memcontrol.h          |  12 +-
 include/linux/rtmutex.h             |  10 +
 include/linux/slab.h                |   4 +
 kernel/bpf/stream.c                 |   2 +-
 kernel/bpf/syscall.c                |   2 +-
 kernel/locking/rtmutex_common.h     |   9 -
 mm/Kconfig                          |   1 +
 mm/internal.h                       |   4 +
 mm/kasan/common.c                   |   5 +-
 mm/page_alloc.c                     |  55 ++--
 mm/slab.h                           |   7 +
 mm/slab_common.c                    |   3 +
 mm/slub.c                           | 495 +++++++++++++++++++++++++---
 17 files changed, 541 insertions(+), 92 deletions(-)

-- 
2.47.3


