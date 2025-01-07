Return-Path: <bpf+bounces-48115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23508A04186
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F10B1886ED5
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637461F2C39;
	Tue,  7 Jan 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfD/2ctA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FF1F428A;
	Tue,  7 Jan 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258445; cv=none; b=SUSzdrhcEXPWuEvfOCAW9b1IlPYxCmp/Ngcudam5/xFqYBjg7j7vTe0fJBVu1CLzUYRdGh4lRIMJAa2zqJpg4EkRWdtG9lxcU7/iqSfvCQEfxFUJMwazeATmeFzJiTTCyxaQk+Xhadny22S+I6NcXnJzxYehLcnYG7UTTNxbC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258445; c=relaxed/simple;
	bh=b7GJYiFRKmgt+Gua6MyRj5cuN5rmsZksWMg2VkyS3aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8fgEoq6pb4ayRw9fZQOe7HTPQ+nxkSRVb/BCHZABNg8KlC/OjmNLB2v4Ty8TFVAqOoDt6hbf1JVySB9qY+rrbun7UQSm3o9fAWAqtIjHT518u7ZmGl+4VIddLGpE+kLdvsooFy08ntUoi3eo8HqGsUdYN55577ZpdH/gAoZ+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfD/2ctA; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436341f575fso160517015e9.1;
        Tue, 07 Jan 2025 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258437; x=1736863237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+/W0EApda7zGr5aRBIxeSAAJdBHD2PeVsO8K+dox+k=;
        b=DfD/2ctAQMCUBY2QmauxoOXcsXioJ2Fu6jaQ8vO6nwwZpdqNSzESXqZQXlD51tcxxO
         xCNG0lnLws4x0BQ8O1iLrSyszFXRlrvZNlAz4OQQTNxHn07JuB8TnixGa8pM71Zg0Mj1
         LI+ca2D8zLkEfpEdbOsRvfrStjJQ4IKuyacl54mesrKDnaf+GZxJJWA+hJR9vgfPAmmF
         QkIHw9cdd9oVzog3+ZqhhMvLeznzrfASaNguBvFVtvZ7vZ+Xv7nt/XRO7wtIsE1nKJJz
         GKECryuBVhi66B0IkrrUNbimAOCDNVKhGGEnXR6rmyMlrv6a0mTclVtLsfxvITRJ2uFo
         +N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258437; x=1736863237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+/W0EApda7zGr5aRBIxeSAAJdBHD2PeVsO8K+dox+k=;
        b=MKxUcBHLnGgOXzIpu7R7A6iSHizknzwv4C1/c0pmTgS0jz1UYiP1lHpncvvYULy/WL
         hpWeWdmCWCnOp3rmWwW/facSMz6H1073HTKgxp/sBkk0y5QhGGlsAjlRIk1Q112iXJrg
         Ag7q2e1+8nKxbrTU7tue4u6dEJVArhs/p2sXoB9XLUZEeuZvvHMutP7l9UKhg7HMGt8C
         oYJfxRX8JoIVKX/ejMnHWgnI3VkQXrViXWVBeu9HHwm5ywHxXM1CGQKmvacKXOltW8Ua
         /B/3+OZjyOjWP3G/UuoAZfFFFnPFozD21GU1mQX7RrradsS3Gr95QAOsEhcetz9qjhU1
         ZkdA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOSr4Xbks2e/9n1F45vC6W8jWDmIsRNlpP1BZXPznmJRTh1/4DKIqFmkKhq65fBYSjT1b3wnQgKGHQmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQgkhUzgb2TxY5BpVeOBXWEV1lbNytnpMUU+fdaBdpzQKs5Mr
	H4EAlh/2qhNk9gq1YIx+BuWMs8/8ETOqrP+6BQ47nLHmjZr/Ciyz6ziP76rF2AQAlw==
X-Gm-Gg: ASbGnctxsGTRRBX6fmdcbUg3rReFqSrUkF4QzW0xmEFGD6mpEwecKieOBDHW6dgezbN
	6WgG3egVWV3z5KFC7bZQau7Demb+ZdAedtNguSgPfxLBFAvBwkSZa2ki8fivt2KF9rckkkS7ip9
	Rl185B0wen6AFYqelAjgaMuwxc/KGt9wWexlmeXeLD5sQVQ6IZqMKuByR6DaoETsI7uc3m+iZbn
	590/KExl2CSZa8bhPi5uTu+ZJmeFPZ3MFVsBtg9DQd4g0E=
X-Google-Smtp-Source: AGHT+IEQ3ZfxC25vxuUk/xs/lMpAQUDW63O7gmVkKXnpPZfubVg6BOGgSV5Gv2VztpvJgbvK9QHoRw==
X-Received: by 2002:a5d:6f16:0:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-38a221fadadmr53312179f8f.34.1736258436684;
        Tue, 07 Jan 2025 06:00:36 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c6ad3e3sm52182531f8f.0.2025.01.07.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 18/22] bpf: Convert percpu_freelist.c to rqspinlock
Date: Tue,  7 Jan 2025 06:00:00 -0800
Message-ID: <20250107140004.2732830-19-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6512; h=from:subject; bh=b7GJYiFRKmgt+Gua6MyRj5cuN5rmsZksWMg2VkyS3aw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCe4A+EBJCWxvZBf7f2Rwf9fNAzPFNCmT/crlsa NhTJVJuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8Ryr/gD/ 9YHT84xt8qyZ4dr56/EVDHUkVPJCu799UqHZ1pcZPBMZwTNzhSAiQrLzKW1JlyTLCgla83f8gqaUV4 QEUJSZxKW2yHxC6WD4r+jw8A+LP8pFuna0qK9/yj9jRiepOMENZ5VignxQSbXFitPMoFUdo0ADmlJc w9DgDgjSQmCDKxf6fpw1ekgRoo396piBStwXAFxuDmdkmjqqPxZoloiAW0tzafxL2efzeH6Txzln2C VvcPewnZKdi3niudFjaqG6y8xmCQbAAHeCe1lKNtyYE8IXBW56vd9R250ew7/GAisZc7JMSsvfGuEX 4fbCL/MOIPG0lWSW9+WOoSR81/vw9krSUNbXztcLYKPDvM8JdNUj0nggX8t6OM0PZxSLI6k74yh/n3 jsCxSK+VRpfBKaIuU7s+vCawxvRhELhWUCq0utcBwORN1OBqx4l51XeDRbz1WHA79CFi/VRS7bogfK 2iKpHvbccWnzJIas4tFDz5C1xgz2dSbFNcfpH+U67AT7rtUZYF8tbKWud61rZHrouv9W7CByAK4JYP cBgirYoOl22giKX/jhGTVP5snxyGNpPLlcQIepHcU6EhUnpotjk0hs9+jjCw8x2Z16RtTS7NRjrDSz 6WIdNfuLu28kMtFM3/QNQFiJqglB6LbtMw1dqHxK30LBhpLvlc/GBlCF4h0A==
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


