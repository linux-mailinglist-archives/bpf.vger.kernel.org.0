Return-Path: <bpf+bounces-50654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9085A2A687
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980501889686
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668A231CA0;
	Thu,  6 Feb 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvztQax2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA7231A3C;
	Thu,  6 Feb 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839308; cv=none; b=OyKZEefAvECh27EI7NCjq+ftxqO+JP/Ab/yeLUwShflucokCfGPXps7WoRY429Mdax58pptouV32uQ8yYXpZNHVfil3ISZeWTz3ydIuZA1jplzgcE6cfv81gsQCUGSLdJyD5XAWOj11nPrCmcPzqd/YGucv4UFlDFNFCRCCuYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839308; c=relaxed/simple;
	bh=b7GJYiFRKmgt+Gua6MyRj5cuN5rmsZksWMg2VkyS3aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BylMcSDHmlxxoR7YTJfoFeYliayELxdo02kyNngfDHpwyNnwYGoMNFf+IdybzWi55pB/FYlnwUB5ub/Bcz41PZrj5+iYYKLCqyD1pPs7TKfka13dvn+cqOI1QzWH8Mr7jmYMCzSHA1Yh+6HVc9i4O3u033bgWjitHyofrrSqv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvztQax2; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-38db34a5c5fso325938f8f.2;
        Thu, 06 Feb 2025 02:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839305; x=1739444105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+/W0EApda7zGr5aRBIxeSAAJdBHD2PeVsO8K+dox+k=;
        b=XvztQax2a0JYqPd6jFXQ6ErTuHnvFDB2Wo328WE/a0oeEePjDKW4az35LMENBbvvpX
         co0O+ikp6X3I/IizCeEsjZCUWo8FcgDkiyRrG6KzYbGHYT5Y0/hWVhnJ7VRy1KiKDspq
         hywlpm6CDz02UKIyB9+hOyB53I2v8PYfEQVBXS0wYnpvJOiWmRz3O9i6t3vuBtf9RwZI
         f2tC5LBKIF17r30rkjT34w3ZjVdpqLEMAXQDkDBA9Nujr5I7JUYSRcdBAd+CTL4Cbdtb
         bz8B1MNZz3GoPVgzLYXVykRvC2Hd9/HywI3f3fN1ql6aIPlWeBawQCbhoBcF+vGgfPw0
         oHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839305; x=1739444105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+/W0EApda7zGr5aRBIxeSAAJdBHD2PeVsO8K+dox+k=;
        b=LW/gMGAkypKZC59clkGS07iGMMgRWtPdFvtjjdiQutCK6jJ65O1WpYwFvDzehDdzqg
         AlLJKSIPunkqZL88fFW8OdAAq+TSzzyksUxXykUfIRjFfRmAfdmrEaU056lp3N9xu4n3
         JOeO8Ku845uCa/PBbWS5UX9B3uNQpNY+slikl4XPQe3m5dvRXGJQTrTUwcUX+k4i8u+T
         DL9b5l4mSXvSkCIu8t4OwmdFY0ozQBF41NNEU1t8xUtaQME/QKGrOURzDAHV+HkzvBvN
         PFSF0BLjwMoil5Dl3YbKVfgOgBfffJKp6wRovunJ3DD7wwoJ1Ypht5RW+mL69x5eM1FS
         IRTw==
X-Forwarded-Encrypted: i=1; AJvYcCVHP8xHPhUbFtituZkqfxoSS4nNwPRUdur1yqGeO6VfxgFTpcwRp2H6uLtTkufXNhfsw17NMoh+Z7peClk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaVGMJvLBfQP5wbQOtEbiM8gjL186xxpR0QttXkCI/tP+w9nl
	05dJ5xF+YTKN5/20TF8pETPsWosA8XX9rYtPKEVK1+Ah568h7luoZ7Z7r4xZE8M=
X-Gm-Gg: ASbGnctkD1ANRixv7LF1YQEosOibA4MNymnODlyscR84jLkervB4lM42a8FNU84462D
	9bkiLOhUOljZzPbi4ERxkiM3G3o6eDnwlrm0ll5FbTFPiRiDAym0g7adKrIa5Kb1HDjARm8mgav
	+3EQAacLMnLDgUINxEDk9z3uO+O+4alNc8Tolg1zbgkTa8tbUtNeJWi3AgmCClF76oHUFy6AFNS
	4MrkcDMugjeoQfJawc64H7IGh9PdzVH/Bu8KqALEU0iDzTKI1D+qQts4fNeoCeY/NhMCThuuxQE
	d8OY
X-Google-Smtp-Source: AGHT+IE1fh4Z/RX0JKmKGEVYdBOLzgVhEKs2AnV1hSi1PhRaogcIsY0ipckf2p7b6ebAKkLpzIqwFg==
X-Received: by 2002:a5d:6da3:0:b0:38c:5b52:3a5e with SMTP id ffacd0b85a97d-38db48577fdmr4311094f8f.8.1738839304658;
        Thu, 06 Feb 2025 02:55:04 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fc25sm1415577f8f.64.2025.02.06.02.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 20/26] bpf: Convert percpu_freelist.c to rqspinlock
Date: Thu,  6 Feb 2025 02:54:28 -0800
Message-ID: <20250206105435.2159977-21-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6512; h=from:subject; bh=b7GJYiFRKmgt+Gua6MyRj5cuN5rmsZksWMg2VkyS3aw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRm4A+EBJCWxvZBf7f2Rwf9fNAzPFNCmT/crlsa NhTJVJuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8RysBTD/ 9cLKt+PR4fSl5mi6p7a7E2k65BK0pYhLW8IoR7EvD1rs1MUM8TYi9Wd0P3u5ARJSKgUZRovio/UJsb MCLHj+03gAh32u7M8XtrbyRGGjWp81sskv3umm0S5W6qW7GNEzdDfhDCVgZGxTaPwghKEcP6GNkC5D 3LWP4b9pp2XSrw5PDT7EN54Ds1FfjGWg6awZXbJcWgVmmS4522IVKIgAgnotntrcI70ccUJoxtdyUD ADWxNVhu3snrVyFYlCSn80qYS6o0ZBYVjqh5K1pU/GnUahNHcT7iZbSHN3HH7/pZhLFbvphUDLtImg bi4WsQVeTVKTqXtm6o/FeA/7+P+pIhRSeOynMeOZT9EqTagpNVaaptRj5HZMuXJWY5qUIHnY+c8P0v o1VHWya9TBJyOJM37cFthbRx9BxyN7uDd3fsaqDwGs+p+NFzUAh5Yyx3n6dkBHQI+zFF2mryGLzXTR h/vu/u/DQSfC2693zDq/2G2Nq8GCT4nwzP2057XK4Fhewd7/9rFPbG2Azm6f192ZUVX2yNhrwmZcFt jjpQ4CaSn5LXmu4ocoOo3rDF0aGwvP5Sb/Jn9vS78QfBYpWYEJxBrVtRMyeKfPjo4jEinqb40wB4vk h5S6Uj1SdTQN/i3IBzw259gce+jCSWN1SQaz6Dgy7OdNHF2kxY9Ea5mBCF8A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert the percpu_freelist.c code to use rqspinlock, and remove the
extralist fallback and trylock-based acquisitions to avoid deadlocks.

Key thing to note is the retained while (true) loop to search through
other CPUs when failing to push a node due to locking errors. This
retains the behavior of the old code, where it would keep trying until
it would be able to successfully push the node back into the freelist of
a CPU.

Technically, we should start iteration for this loop from
raw_smp_processor_id() + 1, but to avoid hitting the edge of nr_cpus,
we skip execution in the loop body instead.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/percpu_freelist.c | 113 ++++++++---------------------------
 kernel/bpf/percpu_freelist.h |   4 +-
 2 files changed, 27 insertions(+), 90 deletions(-)

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 034cf87b54e9..632762b57299 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -14,11 +14,9 @@ int pcpu_freelist_init(struct pcpu_freelist *s)
 	for_each_possible_cpu(cpu) {
 		struct pcpu_freelist_head *head = per_cpu_ptr(s->freelist, cpu);
 
-		raw_spin_lock_init(&head->lock);
+		raw_res_spin_lock_init(&head->lock);
 		head->first = NULL;
 	}
-	raw_spin_lock_init(&s->extralist.lock);
-	s->extralist.first = NULL;
 	return 0;
 }
 
@@ -34,58 +32,39 @@ static inline void pcpu_freelist_push_node(struct pcpu_freelist_head *head,
 	WRITE_ONCE(head->first, node);
 }
 
-static inline void ___pcpu_freelist_push(struct pcpu_freelist_head *head,
+static inline bool ___pcpu_freelist_push(struct pcpu_freelist_head *head,
 					 struct pcpu_freelist_node *node)
 {
-	raw_spin_lock(&head->lock);
-	pcpu_freelist_push_node(head, node);
-	raw_spin_unlock(&head->lock);
-}
-
-static inline bool pcpu_freelist_try_push_extra(struct pcpu_freelist *s,
-						struct pcpu_freelist_node *node)
-{
-	if (!raw_spin_trylock(&s->extralist.lock))
+	if (raw_res_spin_lock(&head->lock))
 		return false;
-
-	pcpu_freelist_push_node(&s->extralist, node);
-	raw_spin_unlock(&s->extralist.lock);
+	pcpu_freelist_push_node(head, node);
+	raw_res_spin_unlock(&head->lock);
 	return true;
 }
 
-static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
-					     struct pcpu_freelist_node *node)
+void __pcpu_freelist_push(struct pcpu_freelist *s,
+			struct pcpu_freelist_node *node)
 {
-	int cpu, orig_cpu;
+	struct pcpu_freelist_head *head;
+	int cpu;
 
-	orig_cpu = raw_smp_processor_id();
-	while (1) {
-		for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
-			struct pcpu_freelist_head *head;
+	if (___pcpu_freelist_push(this_cpu_ptr(s->freelist), node))
+		return;
 
+	while (true) {
+		for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
+			if (cpu == raw_smp_processor_id())
+				continue;
 			head = per_cpu_ptr(s->freelist, cpu);
-			if (raw_spin_trylock(&head->lock)) {
-				pcpu_freelist_push_node(head, node);
-				raw_spin_unlock(&head->lock);
-				return;
-			}
-		}
-
-		/* cannot lock any per cpu lock, try extralist */
-		if (pcpu_freelist_try_push_extra(s, node))
+			if (raw_res_spin_lock(&head->lock))
+				continue;
+			pcpu_freelist_push_node(head, node);
+			raw_res_spin_unlock(&head->lock);
 			return;
+		}
 	}
 }
 
-void __pcpu_freelist_push(struct pcpu_freelist *s,
-			struct pcpu_freelist_node *node)
-{
-	if (in_nmi())
-		___pcpu_freelist_push_nmi(s, node);
-	else
-		___pcpu_freelist_push(this_cpu_ptr(s->freelist), node);
-}
-
 void pcpu_freelist_push(struct pcpu_freelist *s,
 			struct pcpu_freelist_node *node)
 {
@@ -120,71 +99,29 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
 
 static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 {
+	struct pcpu_freelist_node *node = NULL;
 	struct pcpu_freelist_head *head;
-	struct pcpu_freelist_node *node;
 	int cpu;
 
 	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		head = per_cpu_ptr(s->freelist, cpu);
 		if (!READ_ONCE(head->first))
 			continue;
-		raw_spin_lock(&head->lock);
+		if (raw_res_spin_lock(&head->lock))
+			continue;
 		node = head->first;
 		if (node) {
 			WRITE_ONCE(head->first, node->next);
-			raw_spin_unlock(&head->lock);
+			raw_res_spin_unlock(&head->lock);
 			return node;
 		}
-		raw_spin_unlock(&head->lock);
+		raw_res_spin_unlock(&head->lock);
 	}
-
-	/* per cpu lists are all empty, try extralist */
-	if (!READ_ONCE(s->extralist.first))
-		return NULL;
-	raw_spin_lock(&s->extralist.lock);
-	node = s->extralist.first;
-	if (node)
-		WRITE_ONCE(s->extralist.first, node->next);
-	raw_spin_unlock(&s->extralist.lock);
-	return node;
-}
-
-static struct pcpu_freelist_node *
-___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
-{
-	struct pcpu_freelist_head *head;
-	struct pcpu_freelist_node *node;
-	int cpu;
-
-	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
-		head = per_cpu_ptr(s->freelist, cpu);
-		if (!READ_ONCE(head->first))
-			continue;
-		if (raw_spin_trylock(&head->lock)) {
-			node = head->first;
-			if (node) {
-				WRITE_ONCE(head->first, node->next);
-				raw_spin_unlock(&head->lock);
-				return node;
-			}
-			raw_spin_unlock(&head->lock);
-		}
-	}
-
-	/* cannot pop from per cpu lists, try extralist */
-	if (!READ_ONCE(s->extralist.first) || !raw_spin_trylock(&s->extralist.lock))
-		return NULL;
-	node = s->extralist.first;
-	if (node)
-		WRITE_ONCE(s->extralist.first, node->next);
-	raw_spin_unlock(&s->extralist.lock);
 	return node;
 }
 
 struct pcpu_freelist_node *__pcpu_freelist_pop(struct pcpu_freelist *s)
 {
-	if (in_nmi())
-		return ___pcpu_freelist_pop_nmi(s);
 	return ___pcpu_freelist_pop(s);
 }
 
diff --git a/kernel/bpf/percpu_freelist.h b/kernel/bpf/percpu_freelist.h
index 3c76553cfe57..914798b74967 100644
--- a/kernel/bpf/percpu_freelist.h
+++ b/kernel/bpf/percpu_freelist.h
@@ -5,15 +5,15 @@
 #define __PERCPU_FREELIST_H__
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <asm/rqspinlock.h>
 
 struct pcpu_freelist_head {
 	struct pcpu_freelist_node *first;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 struct pcpu_freelist {
 	struct pcpu_freelist_head __percpu *freelist;
-	struct pcpu_freelist_head extralist;
 };
 
 struct pcpu_freelist_node {
-- 
2.43.5


