Return-Path: <bpf+bounces-63403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CEBB06BB7
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630C5562F08
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290A2750F9;
	Wed, 16 Jul 2025 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdtZRMtU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DF266EFC
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633012; cv=none; b=IIUTSF0Hz/5O0cee18uFIVclnjpbQrUCTY+uQ5UIBVUOdDjlW9dX4kyU5Nb6E1IhDQNX3qsvvBPjDKq0AY8YYbGTTq0Z1gSV2HuHhNQ4+VrRBhMtXeVd0XP9DzxoQuUkpLIx/2Gn/vqW0JoBJAJACy9x0HhgQuD87N33MqLesuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633012; c=relaxed/simple;
	bh=JNWPks3V5CJQLJ7CxOk1VH1oLi+M/CBwSbbArW3oyAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChbkmV8eM4iDvPkIrJZ/cInPDq4YJoXh670DdVkunWpOb6Sx5QZB6KTf2fx6BuSkod/MRX+M5NhYuiy2XEXNIvKGasIutL0qTRFcg4kGqEbifPC1COKlXjO/gbJsmnBeQRh/vNA9aWtrGdnnr6pT2288T5b8QLw8OkhbKQ7gSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdtZRMtU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7494999de5cso3850325b3a.3
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752633010; x=1753237810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEQTfrtiJP5hL9ewk3ogQOxqHXPRDQklPst/jRYzXXc=;
        b=GdtZRMtUBF96w02qvE2voEGYVqxp7sRBlBVKkr69iXt5QHqaQtVQVI7EpfS0vFq2X/
         wtJSAa3iEK/vxwya3x5JY/4uKYsvfCoV9UJQEs4zqdjnoWn2KLQ1uShVrTfYCAJaq4Az
         2QnZrA703t52LZ7oofZEFlCwuA7gBV0XRt7PxXfcGYAu1Xn0mq5n/SfRLztZMbQxm0cl
         4YmfuSaVaGx4fD5+MotTORv13NmV5g78kIjpRSpXclZROmqelsBTEKYdQqeLd0qCUcx2
         jL1W3Nn/3TZGHPMtlTiQJrcJvVNDqPwauV1Qk0p6cMud4PZXpsmLnizQzoomg7nuhG3U
         Wc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752633010; x=1753237810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEQTfrtiJP5hL9ewk3ogQOxqHXPRDQklPst/jRYzXXc=;
        b=gREqdQ+x8oeZVAWOnpdX3qinv4mlRX6wcPNfZUkyxTh8RmbWJQZqQvtvSv+8TAPyma
         YZeI38ZNOf8WWris+m7n4Cr/TRg8bp/+oA29xLeYilMO3dfih7xtkXx4motx/iJtZqzn
         Gli3I1+rPWGg807+On+OEcy+wPmQbRejAAJxQ62XTQ6Gd4Pi+iItuj4QCfRZvS2mrcKK
         EGUpY01Ux8Gg1LY4fZzzy/UHAsWaxOBof5Hp8kfnzJi6bTGq8kp26tPCS9aJYSaFkHCb
         fL6OB51ey8NDq0r41fmxrg2Og9qVVIzS+FRKVIgPl0OG6Lz8yoZlzm3qEyPRFqRL2zkN
         l1QQ==
X-Gm-Message-State: AOJu0YzJWSonqKLJ2Isi5sHhlRLRjXMzJkKm+x5Iz93iqzATPU6sceRC
	WPuz1oSUhS0i0ezPbJJbnHX/Rq7Q39jonFT8npT/6widt3c4lUOjB8e+XbEoEw==
X-Gm-Gg: ASbGncs5Wkv/rOFUjbFhROj/7l9xdr7Znui9fDsFJkQsxmJ/oehciIog00enmeI9ZY8
	kaSc6XBtGKpAuwH+KgKM/fFgw3ExtxpJ68zZyuVxkgWaMck+1i48FX6gCjdX5bhoIANbdfu4PYv
	Ksxs66o0lw8uxl7RrzlbvLfhW6Uj7pvYPCA1FbBvZWnmEaRC1NfJXFUoMCW47XGmB1MasLZ24Ff
	fqOaWV/5m69MJP79MNulVwZEgRqQvquxcbGE1VjR3kV91eVDumXPHtUwFdIbfm9WGfnJZ8xeF5Z
	LdbRRwy7dKlCbeoypvGEsTAaYLBH4dTapnQRK8CKcnlDe9hqg8f6yLwmqgT6M6K/4HpzFcpR+al
	vOHH1uJBXOB88wjZi/XBjKPxK2zxb4lpP8Q0x7UYGEgqsEwMc3EHARwOlasG0VfQ=
X-Google-Smtp-Source: AGHT+IEZ4Wjamq4/sEeNP8QyuJywAlTxuEb8nMnNqCpdq+3ecGRYT7Q6RA8xh6SvWLQy1HeLNVKG0w==
X-Received: by 2002:a05:6a21:a919:b0:238:3519:ee6a with SMTP id adf61e73a8af0-2383519f114mr732514637.45.1752633010324;
        Tue, 15 Jul 2025 19:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b2f6sm13766669b3a.99.2025.07.15.19.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:30:09 -0700 (PDT)
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
Subject: [PATCH v3 6/6] slab: Make slub local_trylock_t more precise for LOCKDEP
Date: Tue, 15 Jul 2025 19:29:50 -0700
Message-Id: <20250716022950.69330-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Since kmalloc_nolock() can be called from any context
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
but teach lockdep about it only for PREEMP_RT, since
in !PREEMPT_RT the code is using local_trylock_irqsave() only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slab.h |  1 +
 mm/slub.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 65f4616b41de..165737accb20 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -262,6 +262,7 @@ struct kmem_cache_order_objects {
 struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
+	struct lock_class_key lock_key;
 #endif
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
diff --git a/mm/slub.c b/mm/slub.c
index c92703d367d7..526296778247 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3089,12 +3089,26 @@ static inline void note_cmpxchg_failure(const char *n,
 
 static void init_kmem_cache_cpus(struct kmem_cache *s)
 {
+#ifdef CONFIG_PREEMPT_RT
+	/* Register lockdep key for non-boot kmem caches */
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
 		local_trylock_init(&c->lock);
+		if (finegrain_lockdep)
+			lockdep_set_class(&c->lock, &s->lock_key);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -5976,6 +5990,9 @@ void __kmem_cache_release(struct kmem_cache *s)
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


