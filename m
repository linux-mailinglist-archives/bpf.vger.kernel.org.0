Return-Path: <bpf+bounces-63684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4745B099B5
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459101C80B74
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82631A315C;
	Fri, 18 Jul 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+RQquE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E574C9D
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805011; cv=none; b=tsfL3YiVoZM7vVh3V+bktNLk13yGv6nvY4MZyDFYM30lVVn36IkfDfNyHGvGfn+UpSncwtUXR/en2MH23Sypjq6OhNNYvnFTJFmu9Oo0v8LuZeYu1ix799pfVLu30PYdAhGyGXdqXg5RnfyCwGod+umhVmym+erjfzyyFlM8+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805011; c=relaxed/simple;
	bh=aear/aBFQgperpq1qMzTXD4/3a/zLg+8u3uVClL+KeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3IA78BzMOgwvmSRojT4Ym/yl0Crj4SSeSkElWY7JNfQgB4DOGBLMWedtQG9puIxipCPGkmJh41S79JROgUTgsGKxqdEqum/0+1Iv81fi2lYnW4UXwBNL8fTKoJMJbDhYXutIOljh5wSzGGVkHl8Wt9VfX9yL2M9/ivon9m78jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+RQquE3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ef62066eso20869435ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805009; x=1753409809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjPUtTo5Q4RHjWDwA/8ArVUYFnewjb9EWWS17pFPGq0=;
        b=T+RQquE3lbc7gA/wzkpTmjWy8f+oWPaDjiyaaf6JHQVRiu+of77XiUOSBprWR9i5Qi
         CdVnbJTKI9EXSYOJ9Ze7H7g9VwdHIJ0HdiLPkP2MdBR5sipV6musoIkS8szBAJYtWDnY
         oyK2S68PLwXQiLFSkqtAnoO88DLnWRM4n6Bme1YgOlUuMg6+71WOIUl6aHAc+Zr1n1bF
         9eVYf25TKe8PiFRxgensU5j7Xkad5k6T3wK2uZK2KLHZ3R98Y+YWuoUI5xLg/5bWiqyC
         4uHwuSQZz186lcR+U/BoY2JfaoNJwmlBYnbIXrqLTg54RBsYSv175gMu/jRwFrFsw84z
         EnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805009; x=1753409809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjPUtTo5Q4RHjWDwA/8ArVUYFnewjb9EWWS17pFPGq0=;
        b=m4AzmIHx0rZAIHWNbZWKOsMJAML1dqiIQgoqaR8cJVgBCGeHIU012lvoc7ZZW9JI5d
         9V4jdIJ8RPdI8OyC45pByunJTUp2GJ1zIXHBlAAW6/b389bmiuk5dk7Y1JHwhVD7y9rA
         v861PO2dPLc3FVKILdjhtIZftDwun9kGgz5EHEExGtrO7Djkimk0kyzgj0gILmjgmZBj
         VDa09oi9t0AuD6EJyFc6N0jbRkF9r9kNNETkntd0kPWYAWyf24xWAFNH944gSirjzXBM
         Ixo4WNPXulh5EcRyQ97uI1NxSjTUup3GcTDsofn/34NnPsuacy0MUoQ0DEUKq+B+8HIq
         3c+w==
X-Gm-Message-State: AOJu0YxfT5T0soFqmK5KxzdV3T5vXoZ87egZ/UIofC5yJFpTMHaEDnaa
	KkucROzmigxpiYJQBKoscDXjJV2gTL5IVNuUBx626lP3EKJHFWUZx+VivKgXiQ==
X-Gm-Gg: ASbGncskCMP5jAfxntb0glEqb91lXf1lpIXAhtvlur2FXuSHhLcw2rkdnqIkIoPVIJB
	sZwwXO723HW8wPfWFIuXH4IYos8XogBmG86vj7x/a6VmIlkhQITcQU15HniUyf5DFeGK+zAYy0S
	A45rulfR32thBCn3pYWtmm6/0Rd0uHGD9xqFATkl37A1W7eoucilOYKyMSJMy4j2hHtJvzULQmi
	Ly5Aqec8IXuy7BUe8qlRRf0mdVy+WVAIx5EiyAaw5VbmTwJtXlkBzQOeQs9F1AOZvVyJZ2921e7
	yXNmRIIMmsMdtvfFMl1NqrRKLMj17Ds6TzgZ6lpd9CHD4naN3AWyjTF0/slP1nXkDuiL1I6JR6s
	+eyrNyn9rJoOiFnetUo8XWUaRwxFdst1cjTburQEtGtdoGMGQwZe/V7visX/ZMsc=
X-Google-Smtp-Source: AGHT+IFUs3XFpbvaHD7JdqhEQ2KJXQRT8Nq9OZyid4ETRatsPiNyKJKqTiWH2Vs2/DixhBEDNe8Wkg==
X-Received: by 2002:a17:903:1447:b0:238:120:134a with SMTP id d9443c01a7336-23e302cad77mr81099765ad.22.1752805008892;
        Thu, 17 Jul 2025 19:16:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2fa7sm3154335ad.162.2025.07.17.19.16.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:16:48 -0700 (PDT)
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
Subject: [PATCH v4 0/6] slab: Re-entrant kmalloc_nolock() 
Date: Thu, 17 Jul 2025 19:16:40 -0700
Message-Id: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
  locking/local_lock: Expose dep_map in local_trylock_t.
  locking/local_lock: Introduce local_lock_is_locked().
  mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
  mm: Introduce alloc_frozen_pages_nolock()
  slab: Make slub local_(try)lock more precise for LOCKDEP
  slab: Introduce kmalloc_nolock() and kfree_nolock().

 include/linux/gfp.h                 |   2 +-
 include/linux/kasan.h               |  13 +-
 include/linux/local_lock.h          |   2 +
 include/linux/local_lock_internal.h |  16 +-
 include/linux/rtmutex.h             |  10 +
 include/linux/slab.h                |   4 +
 kernel/bpf/syscall.c                |   2 +-
 kernel/locking/rtmutex_common.h     |   9 -
 mm/Kconfig                          |   1 +
 mm/internal.h                       |   4 +
 mm/kasan/common.c                   |   5 +-
 mm/page_alloc.c                     |  54 ++--
 mm/slab.h                           |   7 +
 mm/slab_common.c                    |   3 +
 mm/slub.c                           | 486 +++++++++++++++++++++++++---
 15 files changed, 528 insertions(+), 90 deletions(-)

-- 
2.47.1


