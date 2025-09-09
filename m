Return-Path: <bpf+bounces-67823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0CB49E6E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19371B2516D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A66221DB4;
	Tue,  9 Sep 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ6YbgHg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA621A92F
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379623; cv=none; b=owhd6FsMHSn6d5AHUL9PH1hrzWf56eQYkbNp1WYWx4LnkIwWjsBNWCtOTLdO1fjB4fSNneZok2v12BelBIBfefyISbfF7oAZLnLlGelPwG8KGOrWnyLm09A6hPh5C20C2KgIQAWaO3KHA6K6JUBiHT1fU+MlDec72jUzB0zYGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379623; c=relaxed/simple;
	bh=MbOSIRQgfd3Q5+l2ZQwM/dw1X61/cJZ7ul42dardrc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvnFJpHBVEjzPIqMsNYy62yi8KGG9LqAKH9ssb+Uq7wd1Xr0bAtW2PiiT5y56GRtw5oxfyP9vPue+NWnoiOFiLlcK9D2npVnV0eSPZVncCTevrTpgEn5rfIe803YRgHAv8eveZTbGFHDvL99FtqQ7B8f+fIVc2IujaGTBvqeL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ6YbgHg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7742adc1f25so2033531b3a.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379621; x=1757984421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIvN7gEFDj+MX9N79cOcDUYPJnyqb9DQof2cQsOTIWw=;
        b=CZ6YbgHgwR77ebns1LiZ5HQL309xPux6xKtGWTFpFF1ayAwi6DOLvTBdtoIIjZ9k65
         oJn8VL3G5asKdzwxNmPcZnMD3yrOYKG6zK6/xFwApxeJFrZMx/COjK1SrgJ/T3CNWP4i
         U8YI9rMor2lSX0+U7FvwO9Dq1onsqvMnbnhvji9Uupv8A2qQJrGmU12vDyzQCbuMHYso
         J3Q24b7DD3fgMlUOtWNxjhUW8ynZXRK1enAUv9KAKf4eEhNTmO+ISVY9XYAFIJwpFsc5
         t1qkqCXxkDihauCwW1kI7wZOa7qYpnAtYQuDyM7v4JuIlVNX4frAXGHFcN2DmGMD4I8U
         yfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379621; x=1757984421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIvN7gEFDj+MX9N79cOcDUYPJnyqb9DQof2cQsOTIWw=;
        b=i2t5ud3RrmWvKgDiGCoU3U613IrKjSelrjLW6iEVgDio2Q5JX0O5JU14tRGB99EcF9
         P9yqcNZP6wDzCLkmZSLe050hU+KM5xcPGMu3VAKRwim4hKItc5p9zm3DjHj29ZSzQ2bR
         wOMogoQdXzpjyoKDuAy0eKeBrhqhbLNJHNgw+KtMoxk04c1tF5i0FYiZm/17hQcEl7YF
         Ge29RYoaC5meGnqn5XexXeNmXiMBkthMCopb8/vvpIIS40RJKyFP2izJthXEAlc4LXtq
         FTQN9aI9AiGZqS3AJ8+mESK+F4G/Ox/eIrvUWckMnisATv0MTQqe2JefoeYRw5BEl3y/
         HXaw==
X-Gm-Message-State: AOJu0YzUm/rWN799ljIr6JzACBXEwK9eBB0OBsyIqw7eEsy+soIMAY2i
	0nxMy4QVy4cvm+UZwvI1DSTwbIZx9bWQcBWuyQWzdLeEpfyyUO6bHvpbxhqJkQ==
X-Gm-Gg: ASbGncuoaJiN7En9zaaE7KH4KBMToKtqMnWsc0r4YD80o1vjvxMlOd/Z9aZ6lCWykZi
	c43g8OpQAmHHNjZwkEuS6zGdZj8JrP4/8yfT8qoHxTXi73aVp7IH0Y/xLnZktGnDXnOkx6v/e8E
	/xNytfosgMN/n6QiQ7FLRU5xUVYp7E3Hk0h/6QUoFSUWz/cCPjoJpeuYZ+cX9YCEF4033FkB9I7
	F8ScsaqpFJn6B6lVSJg9Vp0wiChqay6+iyEbSHHaqrdocTQ+iS6ur7FToT83UF76TroQojaNVES
	RA7hbNjFYgK97CVM0fYs2KCmY4LabbqWrApc5yA/7RJOn3iNN+180bZps50wM49pSE+jj3Pv7d9
	wS0sndzeWn2lVHc0InWr2lgp7fUr23TFMsnXxqaNyvHYRxtqbZEhJ+szJyW6KcAo=
X-Google-Smtp-Source: AGHT+IFZUeoe6fBkWDULTMp8LjubHq1BmCo/G40/7pgpBHQ8AvM+nhqTLUrWBmOTwtVm5kzmDZuCtw==
X-Received: by 2002:a05:6a20:939e:b0:24e:e270:2f51 with SMTP id adf61e73a8af0-2533d225f82mr12211294637.16.1757379620658;
        Mon, 08 Sep 2025 18:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f9c35f391sm15955890a12.25.2025.09.08.18.00.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:20 -0700 (PDT)
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
Subject: [PATCH slab v5 4/6] slab: Make slub local_(try)lock more precise for LOCKDEP
Date: Mon,  8 Sep 2025 18:00:05 -0700
Message-Id: <20250909010007.1660-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

kmalloc_nolock() can be called from any context
the ___slab_alloc() can acquire local_trylock_t (which is rt_spin_lock
in PREEMPT_RT) and attempt to acquire a different local_trylock_t
while in the same task context.

The calling sequence might look like:
kmalloc() -> tracepoint -> bpf -> kmalloc_nolock()

or more precisely:
__lock_acquire+0x12ad/0x2590
lock_acquire+0x133/0x2d0
rt_spin_lock+0x6f/0x250
___slab_alloc+0xb7/0xec0
kmalloc_nolock_noprof+0x15a/0x430
my_debug_callback+0x20e/0x390 [testmod]
___slab_alloc+0x256/0xec0
__kmalloc_cache_noprof+0xd6/0x3b0

Make LOCKDEP understand that local_trylock_t-s protect
different kmem_caches. In order to do that add lock_class_key
for each kmem_cache and use that key in local_trylock_t.

This stack trace is possible on both PREEMPT_RT and !PREEMPT_RT,
but teach lockdep about it only for PREEMPT_RT, since
in !PREEMPT_RT the ___slab_alloc() code is using
local_trylock_irqsave() when lockdep is on.

Note, this patch applies this logic to local_lock_t
while the next one converts it to local_trylock_t.
Both are mapped to rt_spin_lock in PREEMPT_RT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slab.h |  1 +
 mm/slub.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index f1866f2d9b21..5a6f824a282d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -234,6 +234,7 @@ struct kmem_cache_order_objects {
 struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
+	struct lock_class_key lock_key;
 #endif
 	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
diff --git a/mm/slub.c b/mm/slub.c
index bf399ba65a4b..212161dc0f29 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3591,12 +3591,29 @@ static inline void note_cmpxchg_failure(const char *n,
 
 static void init_kmem_cache_cpus(struct kmem_cache *s)
 {
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Register lockdep key for non-boot kmem caches to avoid
+	 * WARN_ON_ONCE(static_obj(key))) in lockdep_register_key()
+	 */
+	bool finegrain_lockdep = !init_section_contains(s, 1);
+#else
+	/*
+	 * Don't bother with different lockdep classes for each
+	 * kmem_cache, since we only use local_trylock_irqsave().
+	 */
+	bool finegrain_lockdep = false;
+#endif
 	int cpu;
 	struct kmem_cache_cpu *c;
 
+	if (finegrain_lockdep)
+		lockdep_register_key(&s->lock_key);
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
 		local_lock_init(&c->lock);
+		if (finegrain_lockdep)
+			lockdep_set_class(&c->lock, &s->lock_key);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -7142,6 +7159,9 @@ void __kmem_cache_release(struct kmem_cache *s)
 	if (s->cpu_sheaves)
 		pcs_destroy(s);
 #ifndef CONFIG_SLUB_TINY
+#ifdef CONFIG_PREEMPT_RT
+	lockdep_unregister_key(&s->lock_key);
+#endif
 	free_percpu(s->cpu_slab);
 #endif
 	free_kmem_cache_nodes(s);
-- 
2.47.3


