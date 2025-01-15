Return-Path: <bpf+bounces-48894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B0A11725
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D20F167C3C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA69BE6C;
	Wed, 15 Jan 2025 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pah8aSiH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F7381A3
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907476; cv=none; b=IsmSQfFz06miwIGN6X9GTBsfNcatRN4crswJwdQXHWTrxrppNyXmjugKXn+LvIkMyiIR8x6qTmNPDf7E1U8AW2x1Qkedy8DW/mShFtetWVmuehhcit+xS4qH+RbLORi4+at3ZriOSOrXupH2cHkup2z4Cv80FTCW8iQdWBoz5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907476; c=relaxed/simple;
	bh=MOB5yfBdofZ3ODotEo7qPJvxm9nPi/A+r3GSL95Jvjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJ0vZHu2YSfrID87H5NjzJn1uHN4ejCgSHk41q/8mV58qaV1rdI66pxDGNySUvxBskq1WucXcwighICrm+u92exKnqdsE+QVeAnNjPmggSt91KwH4bKwT80wKHeiM/rQVuu0PvfbKgyp02GAD6aGLG3q3LQvUeFx5+LfEv2bAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pah8aSiH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21654fdd5daso105542955ad.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907473; x=1737512273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN0vJtsMHnI14li1NiTj5wGmn2n1ui8c0NTZs6gOd+w=;
        b=Pah8aSiHXDhDCevK3n30sabLn/MRtqrJqlqW/SSOdCCxXg3EzcOV7PdcOsj9kG6AAZ
         fJrGsKG6hJYd+c1qbL3em3YaMyUPGau/4sCwYSTPy2ZFY8vHLlEnkCp8uL9m7Pplfwo6
         3Uu8eUnCu+dxeH+OToTuHvtEMg+y+VGEWVhpHKmp7c/mwJA1/E2bVrwd8UrILY48Np71
         lmpf0QHA+R/s/kjbReiU7v9MkKxcjATDy3QKdfJdGIXqOoRlsDAly6Jd4WpU/Mhq6NJK
         27w5v6FtXuAL6VVm8kl8bnRH0rNoWSFaNa45JBnJbTVpqDWDnNsYszX45n44awUO7R2C
         3n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907473; x=1737512273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN0vJtsMHnI14li1NiTj5wGmn2n1ui8c0NTZs6gOd+w=;
        b=ss4EUA9J8xyju1HwZPuPqapGDVyIuCGaYiiAMAGxjV+qn3EhsLiQY8FqJm9OgUmhMd
         scshLor47Cek3NjhwSW29qZvioEEqdjSdS49+tSwRPfbusPYwUOcw/59Ca9hx3Wmrnlw
         pyIJWSC+PX/cqVUn/2u474DyOiB/OcirOAywC7TBiQYBLcGQeQ8FGWnNpfQVSANFAB9i
         azOZOEtdKRoCwyUiRP9ahNYvim9/DnXp4CUqlSJZKhGaGb19aGJMzOPv562nbFSbRYUo
         ulwjiv8Zk94kFJijv3BC5rpkEA208Le3Aqo866VT5+qgh7pWr3H/giBvmDuxL6ZNLCHW
         n56g==
X-Gm-Message-State: AOJu0Ywf1/5ZlqHc4EzsaoWlSaF6TZ712nJ6fx3G0Uj1ToL0BsJbLe37
	Tv9uzPmCDddLpEl+B/X5g+sfMAAFRlsdwbxNMsXYxYFt7V9RBdH62vbC0A==
X-Gm-Gg: ASbGncuwTchmK0arrEFWr+um4X6fonKaXhCeUGkyayv2ROlOcUWsf6Ti8ubvMzO7Sbn
	RMkBEjfk3Sh282yTzh3g0JvEiVkehUn0pMtAi/47wo8PPKcb+3q3cDbYAX18+IQRA8W2nM8mie8
	czkdzYx2ARPeX0ejGNkRlAZHPAvYTU5VRpvVes+G3rQTUSIdZRI0olfkoi11sQj7TrxWK2+08lP
	cOXfwMffVEj4cMi9PMNUyfo+NkS7QZf/7BAPi1Fi6DYAsnhCMWpZhbKTXh1eYWUzblDB9aKun82
	JLJ18JrF
X-Google-Smtp-Source: AGHT+IFK6tdW1FPA3xVY7tDs6ZHExuF1d9DHLRmzwm867PQyWSGR3QkvAlO/Szoty0e+gWaWspC3Qg==
X-Received: by 2002:a17:902:ea0a:b0:216:682f:175 with SMTP id d9443c01a7336-21a840029a0mr446616755ad.49.1736907472941;
        Tue, 14 Jan 2025 18:17:52 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e8ec100sm8680763a12.36.2025.01.14.18.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:17:52 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/7] bpf, mm: Introduce try_alloc_pages()
Date: Tue, 14 Jan 2025 18:17:39 -0800
Message-Id: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
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

Alexei Starovoitov (7):
  mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
  mm, bpf: Introduce free_pages_nolock()
  locking/local_lock: Introduce local_trylock_irqsave()
  memcg: Use trylock to access memcg stock_lock.
  mm, bpf: Use memcg in try_alloc_pages().
  mm: Make failslab, kfence, kmemleak aware of trylock mode
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

 include/linux/gfp.h                 |  23 ++++
 include/linux/local_lock.h          |   9 ++
 include/linux/local_lock_internal.h |  76 ++++++++++--
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/syscall.c                |   4 +-
 mm/failslab.c                       |   3 +
 mm/internal.h                       |   1 +
 mm/kfence/core.c                    |   4 +
 mm/kmemleak.c                       |   3 +
 mm/memcontrol.c                     |  24 +++-
 mm/page_alloc.c                     | 183 ++++++++++++++++++++++++++--
 12 files changed, 313 insertions(+), 24 deletions(-)

-- 
2.43.5


