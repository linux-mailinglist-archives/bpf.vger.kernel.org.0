Return-Path: <bpf+bounces-63397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5887B06BB1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF2562C91
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A7270ECB;
	Wed, 16 Jul 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cah+oOuV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D52E36EF
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632996; cv=none; b=p9UTz0dLGn9Tt+A3uGY3U0w3PLDS02PLpzaThL9XI8u7vA/Z27uVix+gv+D+qJgjm5f9NRs8Xjjpm3m1b4jZLZKHHvxt1/ms01nDx0y6/rRGU+3v5WnkupQo4aoY2sNqNH15aT14mU3OZGCRLSlzIYpT72OpdiYnF9Jd31irA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632996; c=relaxed/simple;
	bh=vBxG/v2pCJ7vaTafMYJLzqV0HphjP6qCPqV3b7rPI+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hx77/Rwy5EUc+jLj/+nMJ5rG96du1oOiss+TXx8XIbkMGbS8yH88weDBVbczTd4IszSvY4gV5KuNiqVpnF6A4T0IFoWvQ0J14ZdaJT7GIdJhOni02bbyDv/1xEXwkWutL1//I7vGy1ZCZoWD94yO5nH10YsHE2s2RvrCXkEnAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cah+oOuV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313154270bbso5726633a91.2
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752632993; x=1753237793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54YMk9JDQn8IHKAz5YLE0koa8eulLZZ41W4aFx7nouU=;
        b=cah+oOuVpbA6wdZC88NCUKIJrd+j1kmjdq3vw46TYcIcfZ94+N9FW1WpvDXTH66VOw
         1rn4pu8cIcWJtQ48SJ9kLNyL7EfJdq028uLxLgmXcPQ67ghQ0mxhjrzbcpr1Yu50hOxD
         sFi5YWcfmP8hdn9FNl+9hDEgx9xPQ1acirPMb0++XpJBT4mWd2bpti6JPyZYP6FQJ0dp
         D3SZPdqs4mY3PFsGzhb02weY/pHYHoCU6YE1+X4YgwwXfz6SL1QZjq+W8x1sncQkAJQq
         SXNmyuAj+H+VhFQvSFUlOiZieSK3GGZTcsh4so45AfZz0byOtXCpiTjULoCp5b765Ra+
         xgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632993; x=1753237793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54YMk9JDQn8IHKAz5YLE0koa8eulLZZ41W4aFx7nouU=;
        b=Wyl09pTVSwuOQEuaGeD9uH7tmB0yrzz7FoA6AfngOyIkMkvYp0US6/rgTHQjAGiCh3
         oPdEL996qLj/Oe5C38kpXnb+rSQvUm0g03e25/JRDMojw4X3hRphv3e9oDEj/ULTkNjZ
         u4sYD0JmXq6V/Btnugxf8gCw+I2SC0Hmytpls5OX7xpwwLLNHExzLcP5j1tLgEkQVnVo
         uyxPzaUQGg5EK/cUQ1Xzv44rPl9ww/iiRzJxZN9RBd7N3QpQXvN4dRw8oZiWTwtSCfTv
         UqbwKT6b71Fv/zWVfpVOMMob7EtXomZExt79+Od1Rj1GdDrQGg4VmOKmodPimDt8kuhx
         MOLQ==
X-Gm-Message-State: AOJu0YwIco36hw0Rn7KaJmy4XD89m7SNogfW3rTiKmx7DTtL2VHFrqqx
	O3TTVSiuWalbYBwyTTjbKRDku+L8nujQJaK1syaMtPSbVYA7xFShI8zDjCf9JQ==
X-Gm-Gg: ASbGncv63LulRuAQxbCCNUNGpW/qLWYvntwfW6uVhstd9K5pmWk/roLINWa884LxBRP
	IZuhceD34KMn5saOUI9a8q3ZjsYuouSBvHAzdHdICXgb3V+82aZvxSubjs6B3XveWlbkIRG0zBs
	IYwaOtmT68d9oax9fTvdPqfyoAi9geljXXjyLina+p3zyWZRLDGHzkSd06vG1Xump9Fygs22/Cc
	k74nrHW1I7rJFj4K95xsC/HT2ZzBFgLyi1uOD/bOAD0lYonNIBCvJ0I3gMTzsuyFDK7fgxtnWYp
	018uFbEdDfvkoym9pf0DfH8IedpY7mIgos/uQ/wUAkFDQX+TmfuzWOD+s+Epa0ppFZXaYm0M5iW
	KQ8RDyj+EREcThqHMeDsxIvXbSgITMFdmpbneE0PE8IddPUPKq92NOiFz9XEsV3w=
X-Google-Smtp-Source: AGHT+IFH8pUexJCnFJRvpl8rZhS654EBz2PixSOVjcUbuVR23X8JzXXfrQK1qEDlWeKIKXuRZG/jMA==
X-Received: by 2002:a17:90b:1c82:b0:311:ffe8:20e6 with SMTP id 98e67ed59e1d1-31c9f3eeac5mr1164056a91.3.1752632993285;
        Tue, 15 Jul 2025 19:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2879fcsm338049a91.28.2025.07.15.19.29.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:29:52 -0700 (PDT)
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
Subject: [PATCH v3 0/6] slab: Re-entrant kmalloc_nolock() 
Date: Tue, 15 Jul 2025 19:29:44 -0700
Message-Id: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
  slab: Introduce kmalloc_nolock() and kfree_nolock().
  slab: Make slub local_trylock_t more precise for LOCKDEP

 include/linux/gfp.h                 |   2 +-
 include/linux/kasan.h               |  13 +-
 include/linux/local_lock.h          |   2 +
 include/linux/local_lock_internal.h |  16 +-
 include/linux/rtmutex.h             |   9 +
 include/linux/slab.h                |   4 +
 kernel/bpf/syscall.c                |   2 +-
 kernel/locking/rtmutex_common.h     |   9 -
 mm/Kconfig                          |   1 +
 mm/internal.h                       |   4 +
 mm/kasan/common.c                   |   5 +-
 mm/page_alloc.c                     |  54 ++--
 mm/slab.h                           |   7 +
 mm/slab_common.c                    |   3 +
 mm/slub.c                           | 471 +++++++++++++++++++++++++---
 15 files changed, 513 insertions(+), 89 deletions(-)

-- 
2.47.1


