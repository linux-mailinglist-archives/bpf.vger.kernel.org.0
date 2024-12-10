Return-Path: <bpf+bounces-46469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805D9EA53D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E499164599
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143A19C556;
	Tue, 10 Dec 2024 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHWP++wG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78270816
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798384; cv=none; b=NXLh3H8EjMpfy8B8vbGNUb2iQ2oV0KzlGepi2WTeZuvw52EFqRj/jDTd6DwSqEStpIY3Q+lbXTVrH6vbbVjJeUqMJUya/75NNPBhRg7XbWxdFo20n1cbv6i3dtIkApyob4L2uCr5F7Xm19MA/TKtvdYWdHGBMLq3CdsC9bqlml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798384; c=relaxed/simple;
	bh=2kT90JCyxpQplM0xYkBcrQa2HQwsG95yoxSHQnDms8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+wPtfx1oXxQIOAnGUxPlWsJTc8ZYZv+K+QkVs8GdlMKRI2WnZrEFhrtWRzpJZQjSmv8XVJq+gsw9jjQ5i3TV9X2b7f660u9hFn0+5GPRQ4SYJvxOtlyRzzQReyAvikjeeqL34WQfaGH3b/OlzVIUIsK1VbJi7JMEsvHfT2nEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHWP++wG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2162c0f6a39so21529585ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798381; x=1734403181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LLi8Dl+VMtnVMEMMd/PCpnnCqhn8N4DHFfLuFQFr6U=;
        b=XHWP++wG2LAw5+z7q2t0ehMIrbP/whYGP6jATEzlHfnsV9WIrkT56s3dgJDYhcKrH7
         xx3E0hka3zJ1B7f3pYuEWqC5I8F7urNoCEOJu3QHjR+pYEQlU4s4BVYzKkyPsCgKW/WX
         wkJXXTkgfK/jFRfU76qOVp1FsVXWUTvLsfWMYJYyOngY5sXcVlj4bTWCL+kndbYi1BUN
         60g+TlE9R6y93fC0zUHRqCDSMq/+kf3uCq+huwYmOVg2cSwWLzqPzjIroFFkCa0rJ0Wx
         UjU0KlrGDH1SRpxgBHFwaJBLLisOS1CMksc0CMSf3cgEohiU5X66/K0vXoekWfKb8tzY
         fHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798381; x=1734403181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LLi8Dl+VMtnVMEMMd/PCpnnCqhn8N4DHFfLuFQFr6U=;
        b=lJKTkiINGiXKu95LwI8xe9ZFZua+GmUTuX7yzYltHrDIURYMBqz2TZgYqbmLzp60YK
         pbke99xQ4Kop+DeOoNmRoaUOM9oYlpaO/PXez1h4DhISBzEinIJxKXgOfJBSoCvqC3TS
         Hfoe0EMJRiKx/j+zvRmnkhwzpr+0UQ2juF+McTaJzVNRXSYIN8RILs5ZTUy4yhzaJSkl
         mjpLIaXHD67TVgAOIeKkVyIcWK11hznGlLPKrGV4CRZFj5VN12BAOogNLYXDfpUoU4Mo
         qmNFN3p4fhUL4PDsnEl3ypctE24SlC22E90x20OwqSUqFh52UcXEfNFcxYdqBNAD7Qm1
         wi1g==
X-Gm-Message-State: AOJu0YywPI0mImq3HOt+UMzfLbRgTU7q75IYH+1rQaCsQYwAju4xOSqZ
	B0xuK5+VwmoaDS2OhWy53fos1NtfkVfOFfsomDbUchYY6bR4GwKOWskbIA==
X-Gm-Gg: ASbGncuzkhQniHfXevVocFsvy7L2klMkMSg1H6PtH3mtr8qAWcvnsefG7kr992KFaG8
	j9mzL369DLvJQDEMtDfNIIqjpdd/KAbvH1c+ZRoGFyQ/uRgdyNwrG/+AcQsXkXlQLrcH/bhRzpF
	yu8aVM+kM/K8k7mBEi/GUMJPvgk40tr3LM3rUHK35EC3M6OQxgNKOxWnw2Ejij1AQZ0yQGO6Hcr
	1VXFjZpVdkqKNe50lfodWux21CX9VieT9qEOHdSRjpwv4ukidQPTX5+fRX/T/WYmxZtt6f1Ufkx
	SLGDOQ==
X-Google-Smtp-Source: AGHT+IEI7Az27IsEgQkhAQk9YZAyRRzn6cHjP5COEJuaiwQiuLYgIM3ARR/xQ4q/YDKLrDtzp5BQaQ==
X-Received: by 2002:a17:902:f610:b0:215:4f99:4ef5 with SMTP id d9443c01a7336-21670a76c4amr23554425ad.28.1733798380660;
        Mon, 09 Dec 2024 18:39:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161b77ea74sm60455935ad.229.2024.12.09.18.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:39:40 -0800 (PST)
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
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/6] bpf, mm: Introduce __GFP_TRYLOCK
Date: Mon,  9 Dec 2024 18:39:30 -0800
Message-Id: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
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

This is a more complete patch set that introduces __GFP_TRYLOCK
for opportunistic page allocation and lockless page freeing.
It's usable for bpf as-is.
The main motivation is to remove bpf_mem_alloc and make
alloc page and slab reentrant.
These patch set is a first step. Once try_alloc_pages() is available
new_slab() can be converted to it and the rest of kmalloc/slab_alloc.

I started hacking kmalloc() to replace bpf_mem_alloc() completely,
but ___slab_alloc() is quite complex to convert to trylock.
Mainly deactivate_slab part. It cannot fail, but when only trylock
is available I'm running out of ideas.
So far I'm thinking to limit it to:
- USE_LOCKLESS_FAST_PATH
  Which would mean that we would need to keep bpf_mem_alloc only for RT :(
- slab->flags & __CMPXCHG_DOUBLE, because various debugs cannot work in
  trylock mode. bit slab_lock() cannot be made to work with trylock either.
- simple kasan poison/unposion, since kasan_kmalloc and kasan_slab_free are
  too fancy with their own locks.

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
  mm, bpf: Introduce __GFP_TRYLOCK for opportunistic page allocation
  mm, bpf: Introduce free_pages_nolock()
  locking/local_lock: Introduce local_trylock_irqsave()
  memcg: Add __GFP_TRYLOCK support.
  mm, bpf: Use __GFP_ACCOUNT in try_alloc_pages().
  bpf: Use try_alloc_pages() to allocate pages for bpf needs.

 include/linux/gfp.h                 | 25 ++++++++
 include/linux/gfp_types.h           |  3 +
 include/linux/local_lock.h          |  9 +++
 include/linux/local_lock_internal.h | 23 +++++++
 include/linux/mm_types.h            |  4 ++
 include/linux/mmzone.h              |  3 +
 include/trace/events/mmflags.h      |  1 +
 kernel/bpf/syscall.c                |  4 +-
 mm/fail_page_alloc.c                |  6 ++
 mm/internal.h                       |  1 +
 mm/memcontrol.c                     | 21 +++++--
 mm/page_alloc.c                     | 94 +++++++++++++++++++++++++----
 tools/perf/builtin-kmem.c           |  1 +
 13 files changed, 177 insertions(+), 18 deletions(-)

-- 
2.43.5


