Return-Path: <bpf+bounces-47174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D948E9F5D39
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450011887743
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86613AD11;
	Wed, 18 Dec 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXZSCcue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EB7082E
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491248; cv=none; b=pzE1QNKw5G0+pn9fcvRInrLuAx6dccndOpxMyaEl4ScLSaIHlr7+M+5e89tPt1SfuLqdtoXSgkfx4WgQo76+cpAkRJN5xLcsWTID+0KktZ9GZHR8QJM+3Imre7RjNf0waNmFVe8ERFBDp34fuUyIwEm3kqXv7YtnsHP+TKpDz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491248; c=relaxed/simple;
	bh=t+UatdibgMfCn/3uX9YsjqBOssWVHExlVAb085NhkQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD6VhEgObk3U01KR9VLksWh0m88+cKnnIEYoqS3sgKLsAZuwWhJgw25tXbDf8zTXt5n6DOouiW72PKVooyE3r8zx5i123E1BoDxbnbHHsQkitCGxF4e2btKIXnVB71twrxNrT5RJ16C0D13brtsx6vhsEPw9TkdutrsyNnHYa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXZSCcue; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e1597e3b4so1393763a34.3
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491245; x=1735096045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLUzsaLjLU+Ex9GXU6YIdFJojy3CkfRVGp+Tnzm8cTo=;
        b=NXZSCcueZtH8FRLbLs3yoLXv3PFnSMZhEPlz7WyRAPDazkM2Q91hieTrAn0R01V2Cg
         zRFDAAopNe+j12GutsTTyT1FkPBvvXdPkj1l1D22P0xN8mnBkWI6X8m8d+4BAID7yDKT
         nzzJC0q7qwdKInIuOumMAUwO2csSxevUbreQMngB5WKTxnPfX2XgXy5onqQLw/hzVflr
         UVkN8r0nqpZA7kMllS25jPt4Z1LlFspc4r1qjsFSArhj7yL95E+j3uQem3dPSxcAYsfO
         kgD0rDh5HR84UjCTq9M7wnrDazZpQ1KidA6Q4sjj6j2JpVLa1JAeekLTOgHclPjBRuzr
         3Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491245; x=1735096045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLUzsaLjLU+Ex9GXU6YIdFJojy3CkfRVGp+Tnzm8cTo=;
        b=COXIErB4e4Kb6pOrbv/C9PKZ3ygwuYfkXkDP9AWWZcreYAys+ucyFICMQkxPMnCdZ/
         1WdTha7dJa/RuflzpG0brO+6QBUGRQpky4m19cCOgevSp2/NPxFDgxPTT/vr+gxbOtQw
         SfCYUmk34paPIo8cUmf//KDWQSTyUs9nGo7yRKQxZyPon2e+ruz+FFTbmgwleVhCp96j
         CcurzG2TF1HjH8nSho9HIxVJNwtZdD0haKp+3favXIAODBlx6tn4ZYsu2hp7kt1jaHnS
         yu2hsn0jtLK5B8hUXTYNVpT3c9PEK2GppxeBXnd993xFb5igxrsaj+GXmH1bV/H0bP/n
         1rsA==
X-Gm-Message-State: AOJu0YzP4srjsoi6bZPXyPk3unU2GJuNLm9l+XSpzLqiI/hAokt7GIm6
	uIfBH4R99Nf6UG2pww/H5X+tadFl+giENK6NZOUqyUXtlO0C0oZO8lAEwA==
X-Gm-Gg: ASbGncs3z1aKw+jL1da07FQSr09kgsouKnoTncFgxZ81W1m08I9/PNn7bSly/frXY3T
	+/UHjlzIWtedMwgD2fPV0xLGhUnb9Eg/FjrpGoHnE2nQEpKSKrDtYccZceUu3h9oLfm/E7n9Mll
	FA/EWbjeEup+7GbCRazWeRaWOJ/0anNlX4KI2SWpv7rLcXb3qMcMXJPeK1sGuC/veSFHmxfgvwy
	ki+FhnU3MA+vssv/7A1CqnJ0flNXaDJTofcm/sJxv4omdbwyqZQ7sKt0pCXtcE=
X-Google-Smtp-Source: AGHT+IELkbGioOIBruYnfnBhjvrdD/9nxp1XARpuv68LnPIsDO9cv4uN+8AnnqNP7RjvvRS0m3wP4w==
X-Received: by 2002:a05:6830:2115:b0:71e:5a:f4e6 with SMTP id 46e09a7af769-71fb762c98dmr791362a34.20.1734491244697;
        Tue, 17 Dec 2024 19:07:24 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e484ae1d4sm2469497a34.44.2024.12.17.19.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:23 -0800 (PST)
From: alexei.starovoitov@gmail.com
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
Subject: [PATCH bpf-next v3 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Tue, 17 Dec 2024 19:07:13 -0800
Message-ID: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.43.5
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
  locking/local_lock: Introduce local_trylock_irqsave()
  memcg: Use trylock to access memcg stock_lock.
  mm, bpf: Use memcg in try_alloc_pages().
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

 include/linux/gfp.h                 |   4 +
 include/linux/gfp_types.h           |   1 +
 include/linux/local_lock.h          |   9 ++
 include/linux/local_lock_internal.h |  76 ++++++++++++--
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/syscall.c                |   4 +-
 mm/internal.h                       |   2 +
 mm/memcontrol.c                     |  20 +++-
 mm/page_alloc.c                     | 152 +++++++++++++++++++++++++---
 10 files changed, 250 insertions(+), 25 deletions(-)

-- 
2.43.5


