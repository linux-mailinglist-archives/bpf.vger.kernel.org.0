Return-Path: <bpf+bounces-48727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56448A0FE9D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68492169F27
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738022FE08;
	Tue, 14 Jan 2025 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOs5BIB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18AAD27
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821174; cv=none; b=cCWsjfHcN94CDncFmB7Rk6opSCIz6fOs9YoFYM87jidPYp5rqb1GHV4sO9iM6P8H66nFzEqlFj2AdozF5eVoXMzwevpMIk2lCeefxpFBfzuSB14jTvKp2UWZ4mjWQWoO6KaymafwmPBvhKnNXvTwKq7TQr90Cq66r42V/30mvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821174; c=relaxed/simple;
	bh=glxNET2//9BrngBVKZVq0urhg4djjnj0XkymG38Q578=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m4bFxocibUnsgDVDZfu3F6ms1XmGMFuxwNRVy443MUaeCb/4HBKelInoF4J70wCZCxC2UvaOJMA3VTyko2DzlehUFyKcz07w3MId2QJJSCODWozHZJ8muiZEP3vWBvm2aywhraBgrKd9vw5mMFOGoydkoUkh6FMpb6EynkI3x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOs5BIB0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21634338cfdso73810565ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821172; x=1737425972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnxIlzgPMp8m5mNwVmolPyMCi6FeHvtuBonEllyjCg4=;
        b=fOs5BIB0EPpvHoQ6FkpWmAn4r4CFhOhMUMYlnmP/DBf5Q7pjTmwIKgeiU9ZpGAVV6/
         gLZF2PkqslUkuMDzet7QpvjefYGe8umI/xze0Tf1LmLM2SUBHDZkZ495HXSAXduT+5rr
         tIS6XX1J00wN5N8Nq64A2pHtU5wt29HEw1LBAZg90bIeOWKn/XfEUF/G81zG7Vyl15qi
         JO1RYsYWcenVwStkEPzUCpj48v6OUphVCeQInYyxuiBwMRWm3jmTzC9JhZVNpXVyox5k
         0YlYnRFgHnHf6Hqt4c+4UugqphQLczgzHk0jB9rzMVysO1KANBZTMrXzMe3uyM5pSj5R
         bs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821172; x=1737425972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnxIlzgPMp8m5mNwVmolPyMCi6FeHvtuBonEllyjCg4=;
        b=Qi88IoQ9ytsOcJu78BZkMMQENWOVoyKJAS5iSGSucsvSDAVQ/phhYoc+UrCtkovtqW
         eQo9dl2h3K9ne0VYi/KG9uteDj6vnr9O797yZIWFQKh1KFIXL5yiAxhNsGw8BJgKvqsR
         RZymn4Sq2oDc07keNBS9wmd1xxIohmuyrKkIH3YMD8Buzg/cWReg/K3o8FFIbKDNy8Y+
         pNYinXtpfMUA9Wr7p9kEoW3ceMHqZLuNfzJDkAN4XlvTBi9hqFuqBGBLyEZwSvVHhKOK
         uQMdorQH4d4nN5EUjK7t2PxNPLk+nS0HrcYnk5F8cgOHYbGRSgaJnInAZ2SB3cJgZohf
         Lj0Q==
X-Gm-Message-State: AOJu0YwAH4A/GTFFkOs0/yLVjHeoqkbLMQDhN7PVCdx+UN1l1uldRf6s
	fYe/QDLu5qfbmrjZX77GXbSL2PPcvfueWOx6yCS1lyp/MYUUrNMOBaG6QQ==
X-Gm-Gg: ASbGnctBOi3D3vwZr2DxWRUrPHSDDnG3VjFizrB/86fdsInHfjG9Tc3f34hYDRePpUh
	SRcWK2Xa4DO9o1vJKPUodw5lXufRKFuDwau4khllWMbde47zKs4RsVOdD26isOwFfaKrpq0zb46
	PPaAkGGeD83RuWBclvHKsB/a9nlOtXTLx1DG4bn6W3OrbOUrTArnTR86elxWYceKM/iEZPGgWmJ
	0lFIAaAKY3w+GsU6tcn8sZxiD+XW+XR06UGXnuX3L0CbA3pRep0KdK+BHTyapgpmGrikdZWxcrX
	iXrR5G5J
X-Google-Smtp-Source: AGHT+IGs+L+RJhb/gY+29/U3wyZWsPjK2+A1FHlKlCHVaSYdjRzTWST3E11vOglMDbQRC1a7b6KlbA==
X-Received: by 2002:a17:902:ec8f:b0:215:7447:ebf0 with SMTP id d9443c01a7336-21a83f665c8mr376178995ad.29.1736821171500;
        Mon, 13 Jan 2025 18:19:31 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f153486sm59669375ad.105.2025.01.13.18.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:30 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/6] bpf, mm: Introduce try_alloc_pages()
Date: Mon, 13 Jan 2025 18:19:16 -0800
Message-Id: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
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
  locking/local_lock: Introduce local_trylock_irqsave()
  memcg: Use trylock to access memcg stock_lock.
  mm, bpf: Use memcg in try_alloc_pages().
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

 include/linux/gfp.h                 |  23 ++++
 include/linux/local_lock.h          |   9 ++
 include/linux/local_lock_internal.h |  76 +++++++++++--
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/syscall.c                |   4 +-
 mm/internal.h                       |   1 +
 mm/memcontrol.c                     |  24 +++-
 mm/page_alloc.c                     | 170 ++++++++++++++++++++++++++--
 9 files changed, 290 insertions(+), 24 deletions(-)

-- 
2.43.5


