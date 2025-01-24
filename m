Return-Path: <bpf+bounces-49641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04201A1AF32
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22294169A3F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC11D6DC4;
	Fri, 24 Jan 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCAjDYkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81031D5CD7
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691021; cv=none; b=heCXl3DejgVXUG6yJgK4EXPNCa/tcw/iFLhKnQyLUanFn/vQflcIhR/vmyKpfEGWJxtLy1omOoIaubbzkr0IJ0vlFHVB+GA7fhIqfpKJMLixeYlClCKTT65Lwrc5Rr9Hswzwly28xaGDuPdVaV7nzRG/tzeRNQAtoBw++xaFZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691021; c=relaxed/simple;
	bh=8rT+pfrO4VNDF+vQ4eIh3LLUa3VZHB8MOJAidkGgGmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXxqm8Wq4ZfDsHfuif0aXFseNx+IwBK1/i1TdaxVG1brq2E6vg31IFqSe/n1obQ0jkOuLoNPzDKqfD555kHaf6qWc51t2Z7i2xfZoMpvTR7BlbXdiQ05LMTsjYdZU2rFnI+UOipj69vkOjo6JsiEb0J3TeS4tBsu3Ioc4XYavNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCAjDYkh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so2380887a91.3
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691018; x=1738295818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLZNcZOzM4HMR5QxZcLvTip7sFNfzroHw5hu6l3uVKs=;
        b=RCAjDYkhhJNHWFkBmp8xlsd0ydNqRLQPNMB/Y6spix7onI4OUD3zsAaHf8d4HGbvbU
         LHt4VqF1RvCWTktvrikZw/6A6uohpiApNj93zF3ftzA8T6/SPeI7zmH+ZNqDLq/aCHNe
         9atWMCNb71ITQ9yGX32TOdqa1rUOYw5i2TT9Nf1Tqid+YB14JvnyH19nmSbv+cYB4qwc
         YBkmHqzuI2qcQsgxcKUIRTIwxh3MO9bUJn69bO8Ey2oxGOtOcGk0+I0USkOFW90VwZnl
         9ujVrIMpymFVvG/ShPGSdpTW7nASkWwTYBd3Tea3gwq6xDrEEpYx88NOP3NiL1tai67h
         o4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691018; x=1738295818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLZNcZOzM4HMR5QxZcLvTip7sFNfzroHw5hu6l3uVKs=;
        b=gbDZhtR0+TbWK8tS7gGDwZqvYgJr0fXPycu9+sCzj6DfirUtlX1gekn0WLhb/o4rLO
         zMnUlgr2tPYvoLGFhdI169W0/wAWA84zlIv3I441oM3Er1yvIEcgDwabcARFteCma4yt
         jEGQsU33uowoznqeBUWgzHe/IQh3Ux9R7IG+zIgYRueCZtgoH8HaTW6SgDiAX6q/9uis
         Dp0kI0DktwUjbgw6lz7b86XoS0EiZLXqukc+qM0aS5PZzEyfNMRWfe5A6XscSLGguubE
         b/zJmRHugVZE6Q5HlWiZ+HOQ2PZ4/Q55G9sDsRsgiXQW1z7Kx0Zm3RMA1QIgJlo5s9R1
         ouDg==
X-Gm-Message-State: AOJu0YyDrT9eFm37pHZtTnFDylNtrFUMXorDBf6tmVjWwMEOSuINKy4z
	K8C96bODfyJ9/H/aceFD7oR9tdhlrX3OW4wFOp3zUYTgGvEVTFVOh80qSA==
X-Gm-Gg: ASbGncvo6tiXeIZR32XPJ39JYyWWFPTqFkySlAOhR2UVc+E99b8KodK3XDtzQ1FBKQL
	rjoDxW/jNWhtsLOGygONOjMzNXOkede5BibIaPxcwFD/UGX+8G9nuVjwyrufEmUr3aGLQaZwHzw
	pFJPpdvkHQK4t9SM0dptJMMnPtujYX5CDibTxOWmlPGuSl345lCBAHzd2GaK7rs6hwO+ippdHUr
	5VtKi80WiFKozZcTevd+RbWjL/w21zJu7V1VYt8oqc65fZux4MeK9HoxiyD7QkzFtCsP1X8IAf2
	LM6nwf+FHjsAm2ySgsdtioijuV95BD4gtCtUVhY=
X-Google-Smtp-Source: AGHT+IFd/i+i3ARovVNSw+aB9/e2We/yPoeff71p/2Ozdal3L84ASztsnD4x85dfNBBwdATQXMdVCQ==
X-Received: by 2002:a17:90b:51c1:b0:2ee:b2fe:eeeb with SMTP id 98e67ed59e1d1-2f782d2ea80mr34100890a91.22.1737691018229;
        Thu, 23 Jan 2025 19:56:58 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa67f7asm639692a91.23.2025.01.23.19.56.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:56:57 -0800 (PST)
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
Subject: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Thu, 23 Jan 2025 19:56:49 -0800
Message-Id: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
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

Alexei Starovoitov (6):
  mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
  mm, bpf: Introduce free_pages_nolock()
  locking/local_lock: Introduce local_trylock_t and
    local_trylock_irqsave()
  memcg: Use trylock to access memcg stock_lock.
  mm, bpf: Use memcg in try_alloc_pages().
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

 include/linux/bpf.h                 |   2 +-
 include/linux/gfp.h                 |  23 ++++
 include/linux/local_lock.h          |   9 ++
 include/linux/local_lock_internal.h |  79 ++++++++++-
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/arena.c                  |   5 +-
 kernel/bpf/syscall.c                |  23 +++-
 lib/stackdepot.c                    |  10 +-
 mm/internal.h                       |   1 +
 mm/memcontrol.c                     |  30 ++++-
 mm/page_alloc.c                     | 200 ++++++++++++++++++++++++++--
 mm/page_owner.c                     |   8 +-
 13 files changed, 365 insertions(+), 32 deletions(-)

-- 
2.43.5


