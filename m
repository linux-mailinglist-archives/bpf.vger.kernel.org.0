Return-Path: <bpf+bounces-63689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560BB099BE
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EB77B9AF9
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715101C7013;
	Fri, 18 Jul 2025 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEdEPaMr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0619067C
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805026; cv=none; b=HG/hZbcK/An0ZQqIcFQ0C6ME3ZuemANa/LG0hSi74suSR094b0OAutZ12qHFREJMl5qQLEpb/j7MbJiJShWi/3IGAqXGRUkwKTeQm9OjKqEiQ6/XsAdtkxtztQEGOEDsoMV4b/JDOLPbQ95WU92sOTs2Ood9kzcueeQfDl1/NBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805026; c=relaxed/simple;
	bh=VsW3knDCb2p7hqwuc87Iuwtv0OF7l/eTW1lo3LOH/Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pn80ZAHb6ZtStb7nK/9nD1tbrEGArNFeYzizXscYdIhYlpF7/1BVbdveSNJ9peC7WxwD1KjzX6QozHh3BKu+LV8q6aegJknbHO7RyGR7pReQAetxIZczjDyh2vr8AnEcNY+RvFO/Vi95o+V5JhflkER7bhbDWAWOUEu4F3FdFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEdEPaMr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748e378ba4fso2017223b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805024; x=1753409824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWETJlOKGazWkISOD3+6VC2F2WWqxCGLlibMASETCes=;
        b=cEdEPaMr24UwiRNuG1hJF7F7HpVMg/70oQ9enCTWqodeA5UJR8nAD+eYIBwS0srXDi
         5o8B1q98FLQ6JJUIuzFlCfznJwI4Yq9bXNaV+HgpSNI/J21aY4nkAGxw1cxUy0xtgte3
         ubE40vYfXFiqAoFTC2qVDtFfNhonXU9blD9HQZGOeyTW8alk8KokLaxeeG2Pwt7AmAvn
         NblYmZZRldE6IvoMYOPFC6ndy5yIpvXHydiK5CX01eO8icugfTHJwuX9MRGW8GTsuBP3
         38ATywG/RODPc7sIzNTZu8B1NoXDChwxQq2EFNYmVt/whWt7LlQ9k2XStPopUh9DZ/8l
         AscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805024; x=1753409824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWETJlOKGazWkISOD3+6VC2F2WWqxCGLlibMASETCes=;
        b=H78eRUcfMNe/8toiJx0rGoLpVuUphCDNQl67iPC+pmvAYro9bLSgzTuX/ABSHU4lFv
         nsmifEc6Me5YEf+I/+jsR27FHBjccilIH/iMG7vi6MKGJVvOr4xsOtbx1FmCXY8Hm+iJ
         3c1sxOxR1cOdIdSzISczch5IrCAtsj2/5E5i+KmAezGDGqUs4akeflH2SqLfSWcecGlH
         UQhSraRP0i+YWS4uM1+z3WGlGvuTs7k+gHf7NdB1/ABbuiqEH26EQFpiB42V7q3TWaNl
         4CN8Hl419bAx1DCK5QgtKV2+5nEqSwsZEm8D1Mo+gEWdq6+3OSa064/vGjUI8KPA//XH
         k+Og==
X-Gm-Message-State: AOJu0YxhMpCRzDj2Yn6rZe77lF13bm6BrLu/nkMvaWWlQJ0N1DLZgelg
	7qabg3CJZl3F9eS7IVcJ/SrbcBo1uYSZevHNfm1+TbAudouSQ5D0Zx9NU8C5RQ==
X-Gm-Gg: ASbGncvbyUYrUAGMgXM7S+AEmH/0+xFgV+6+skow69np7Idi9J3k9ELLQVXit6K2vUu
	18l+IkhAxLmgWT/3iREogy3mw5UvgkHEE2mixGtfM1MBDon0Csw22PlrGpg/BPgPx/OQe9T6DUZ
	9fnFyLcPyEq1HiDjQyb0H363RFjhgrZ83y1d6R4fjVf82OIIPyxg6RQy4dEjq9DdYyBZVj7yRUL
	mXpIK2kFGE6KuRQrL2hIvENYAuKw29R7MYSVgm8HzbpuWdPX4l6SGOLKhkiLzncXB6gGR9nVI+V
	Aykaenl6OZqeqqKKpQfH6uKao+spNJS7fn2Ed0BE+Jg3MQA+Z55NejZxTF6mWLQYPxK2X0ey+o9
	1cxRi/RV9rsXomvP/vl+rkMd0ta6CKFrb40pu43InP/9660PiaSrU55Sb4ctsZpI=
X-Google-Smtp-Source: AGHT+IHWyxaj7icsLAL7jj7PUwL0yEJU4J9Ecb5MsKbovfcnY7bdDm2SOePe+iLUf+n5utsLBghogw==
X-Received: by 2002:a05:6a21:7109:b0:238:351a:6438 with SMTP id adf61e73a8af0-2390dc71a6fmr7468515637.44.1752805023593;
        Thu, 17 Jul 2025 19:17:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm224084b3a.69.2025.07.17.19.17.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:17:03 -0700 (PDT)
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
Subject: [PATCH v4 5/6] slab: Make slub local_(try)lock more precise for LOCKDEP
Date: Thu, 17 Jul 2025 19:16:45 -0700
Message-Id: <20250718021646.73353-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
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
index 05a21dc796e0..4f4dfc3d239c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -258,6 +258,7 @@ struct kmem_cache_order_objects {
 struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
+	struct lock_class_key lock_key;
 #endif
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
diff --git a/mm/slub.c b/mm/slub.c
index c4b64821e680..54444bce218e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3051,12 +3051,29 @@ static inline void note_cmpxchg_failure(const char *n,
 
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
@@ -5614,6 +5631,9 @@ void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
 #ifndef CONFIG_SLUB_TINY
+#ifdef CONFIG_PREEMPT_RT
+	lockdep_unregister_key(&s->lock_key);
+#endif
 	free_percpu(s->cpu_slab);
 #endif
 	free_kmem_cache_nodes(s);
-- 
2.47.1


