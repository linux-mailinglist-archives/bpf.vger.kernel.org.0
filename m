Return-Path: <bpf+bounces-62728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA203AFDD19
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CED4E6778
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359718C011;
	Wed,  9 Jul 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEIHkREH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EC83A14
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025988; cv=none; b=kGpVgfKphO0+A3KEr3qBnksjr4pPcpNfrmiQtHKysduRcJP/ELLr+shlTyH2QEGkPrBp9XCQfqAE/G5tAmN/RNNjzcIxFVbsxB8HS+MtUaWHX9h2h1ktiTrdjfXfIRVsqlFaOuTWZDz4uX72Xhat4cciSfJPe2CYHUuDR4jmoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025988; c=relaxed/simple;
	bh=hSiwpStpLRJTj1TEop2fW91bZQDtZD7tNWWa+JND9Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEeQqF7XDuMYO4zcWnTldkSvORbn1X/JmT5Ec3GUFWNX6NdHuiYRJQhdmvN4fxnnXjzyFI+nEQiayAzQ3vIF09hHbPmkoBFTZ1AKa/Hb2CyEDRsPD5Kx1OLZRx30R4lnUj+WN183G2OqfKojTRYeOqnBe2UN7OPJ4vSzIatRGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEIHkREH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7481600130eso6635136b3a.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025986; x=1752630786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVq8OliOKpTiMPXRZnkr313UvLWkoyiKBS7rnvUZNAg=;
        b=aEIHkREHZyhgjR2hK1u6j3wR4H2gAslfc7kP7MTFOS1SOEcpX7DhIGjDVPsFQVjWaN
         BWISMb5ibudL5XJIm/+kjMi633XVNb2uUEO7ETl/1iHE/vR2Slia7/nuPbQ/OkmHr8Rs
         J83grpC0V3oXpAcf31CWJSZPy6/7eHC2wEL3VQ4xgNQnwXKCE4V2MVCR3RnpzeAPngy1
         jdZlAmbqMpcsys2KvTvx5CobSf2qErtTkJf5DgHqyQrC4Np/0EFDzYOvxGu2dsnOY/7i
         XjF8uI6Cy/RFw2fN+08CVTJ5PiYTDYM4fVeE6djiMMonzcr5hXMgJ7EwD+CgUSNF74gO
         dAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025986; x=1752630786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVq8OliOKpTiMPXRZnkr313UvLWkoyiKBS7rnvUZNAg=;
        b=XWlL0p1+fk3pfvhrALGdSQmmPV2+BTOqYhbektRrOhHz6RqG1t9NZz2qPFWlc8anLf
         nmiozFM3LO+5ecXjGw+XGoHzCgG4V+XRbFJTHJL8WpU/LtMBWcG4U+2LUamJTTMAwpLr
         /H/2oIJBdSBmp5oRnJAJkS7b7k36MPczfewfS8XvYZDYJhiyPHBnshiL7ecJt2pvC816
         mXfwx6A64syby4nhh0zrffEg41yMGIdMKCRtDr0Js4iF/1OyOPczV4ZE3dcdM+bN7xGn
         wjRT6AqoT49jShxYwBLvhOj4JKFBBBx0gJKSxH9RLWlC2KyaWZJVtaOunQ1XqKjbm7Jp
         Iypg==
X-Gm-Message-State: AOJu0Yw1NicUvDO67q4DVq2sB6P2bxogK3krxxkgiPlEiXA82CVm7TgE
	CNuQT2rLEVjszvxGWcXX2EqY1+75Rki/uCArWm5O7v5bzs7/yeEWRijczU0ZxQ==
X-Gm-Gg: ASbGncsj58kOUc+7krCYhbrehRUZDzuUfezpxQt2q517zrVvWBCaCq8sIq8iJ83XAvG
	6P5NnqFho2+NfpLdaIMWdYWI5V50NFvPsQkHHXNNWC3afOB4O9vI6SPBmIqvrpw2vchHdm9dsWp
	sg+UFuFS60w8b91Tdg+U61uaQW0vQNMJ6bdsBGxaDVqbYjdgALF/5WGoEhlwTuT1mHgHET3dWfb
	x0oxKEdEQOR6Cyc8PiNXUsAvi0zF8ZljBHFMxT1mEostYzjIkhyEpI4CZBw1cO6dsHPkjxewg8s
	pHLfQnlc1Vtc4QfB9LaFtWOPSgusPxC95ojkiI2XfC0ktO72qD8pl7DahmCIlJUKue6eU2TUTwe
	IMw3ibZ5JWapaVEx0xfm6cokwpvk=
X-Google-Smtp-Source: AGHT+IHCph7Yg/NOpvmruFegQftJXZni6axyi8rZm/eKyQH1pYHkOEY8X87zl1eAyxvFY4CFbr7EhA==
X-Received: by 2002:a05:6a00:3a1b:b0:740:9c57:3907 with SMTP id d2e1a72fcca58-74ea66d7ca3mr1151896b3a.19.1752025985900;
        Tue, 08 Jul 2025 18:53:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc152sm12202908b3a.51.2025.07.08.18.53.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:05 -0700 (PDT)
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
Subject: [PATCH v2 0/6] slab: Re-entrant kmalloc_nolock() 
Date: Tue,  8 Jul 2025 18:52:57 -0700
Message-Id: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
  locking/local_lock: Introduce local_lock_lockdep_start/end()
  mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
  mm: Introduce alloc_frozen_pages_nolock()
  slab: Introduce kmalloc_nolock() and kfree_nolock().

 include/linux/gfp.h                 |   2 +-
 include/linux/kasan.h               |  13 +-
 include/linux/local_lock.h          |  17 ++
 include/linux/local_lock_internal.h |  16 +-
 include/linux/lockdep_types.h       |   4 +-
 include/linux/rtmutex.h             |   9 +
 include/linux/slab.h                |   4 +
 kernel/bpf/syscall.c                |   2 +-
 kernel/locking/lockdep.c            |   4 +
 kernel/locking/rtmutex_common.h     |   9 -
 mm/internal.h                       |   4 +
 mm/kasan/common.c                   |   5 +-
 mm/page_alloc.c                     |  54 +++--
 mm/slub.c                           | 330 +++++++++++++++++++++++++---
 14 files changed, 402 insertions(+), 71 deletions(-)

-- 
2.47.1


