Return-Path: <bpf+bounces-53089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BCA4C555
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD35D7AAF54
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFB23643E;
	Mon,  3 Mar 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnFEf66B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAF2356A6;
	Mon,  3 Mar 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015419; cv=none; b=UkqY6Px38VXsDl9draMxZwDGXYxh5xLxmdnQyzdSsvHKbmkh6ml0CILcYzOBm4J6nCD9YlVCWTg5YLxbVFu41LccP23cC3BqxSN4WQidkew9p7JoN2f0+YGFFxCUc/5A9Oodu0SLKNk3WQSX34ikCxYQafdVuAw/O7PIkHfs8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015419; c=relaxed/simple;
	bh=at8Ekv6S0aGbB9KEki4TPKeyEB0J4bUZMvZ4q+vMLKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0yiLLz68ziMo+7935BgbMBPZ6rmrLjWq4sDmLZrbSVdOTJSymLvrVML3sNaIPl8G/T9y5uqRkiqpo7JT7NZDuTS/VAR62xdAEi8QIrzGaGJR64CJjofSyoW872sTUhZecbLgH+/0xiNSAbuzrsW5uEMF0HvFrfhikytITUVzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnFEf66B; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43948021a45so42175175e9.1;
        Mon, 03 Mar 2025 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015416; x=1741620216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8dD4/Kp++x7YqbDF8EB2j5tk6yfejIzgpWScMmcz5s=;
        b=MnFEf66BIAGpvy3dHyStWHajoA4i6JOty4nZJ8hAPBs88ToLIr+VOQ7Ox7Gr9Mzew9
         sf9l9ABpVA+ORLagjSAmXSLAQsgOtRgfUyNmzcr+LzZZwA6ngnOwYGHEgEBILpkTl0Zz
         z15VpoblZVp2QMOBgzx+uHJdxtbEsyBxOFC9xOiIoyJPuHd+vtKSuzFY7d+CZv72EHKu
         Uu3D7jWZ1bvDNDEykdHnCMwcwIG5QRtUCLjywWNTNTwdksPMt1qd5JpxOLeMtKpTEVQz
         VCAp+vCFQQ7fDul2IIJmgfliHkPAZtL7LPn7xI2ISboX0X9DEBYo6/u19aTXjS+lDnKi
         o+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015416; x=1741620216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8dD4/Kp++x7YqbDF8EB2j5tk6yfejIzgpWScMmcz5s=;
        b=BCk/fe2CvR4Lr/uhhm0vs6owyIGBgV4N4gp3asepA6zXxgNMLyPXNdkz+tU5aIZUKC
         KIexCJmb3TjRAmbwsP4qbZOPE4GMIzmpXNKlkcyOWg4pzdtQncrvu9SG9/aiBDO5xbQG
         XnuQ3mQlnwpgToaSuD5IeJp+XtodvAHGhVihJmEcznVQE9RsVPz/Mvb17EqeUyNdmHdr
         JUwZjnNSAaMTPTiofmr6QWlZ4u/PNo7DnMFLPAvNlUJ4OIGfSPGNi01MOKAMlP0epPZG
         RwGAzGViPje90BJNGnJhr1RAxkdE/HhhZR4mHTYwrYfvm/mprNTweBFwZSTkAB1ruU08
         K/yw==
X-Forwarded-Encrypted: i=1; AJvYcCU/QfailE7pUwLwtKDWZpRu6U84RoXrRJ8jxxlFwaFZhpdXib+k+ljHaVax5dYjY6XrxCPChf8JZLTYQWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XEcWsAhsqbOeRCjkVuFeBeXBsVlUV2vhfqMFpN/4EZOQ+Q7e
	XV+tY8rfJ9j+4itS70pq/J3Gd8p1ZBMNUYl6lnmbsS1iuuLlEoWlKktEqX6RwyA=
X-Gm-Gg: ASbGncty5kCBBqkBHvKF2cPng1+7ZTIxPPBixbu8SMjxd5+F13OJCs2dMYEYuIBfRTW
	vh4EvyDjPirNtFbBpI6vm8BYc8W7YQlQCxrJJr/zAPt/AI3WKLPkvdBxrmQur0pUsvIoIhlicCH
	BuKnrq9XUXVfZJjwTEUwNiqkZNb7u/wCsms+LFLwvq+ApHa5XfbAuRo5a2fo0K9A6Owq9QOeWHE
	4i9LcX+rof5iCIJUAFd2xQdx+HgD8D61IZcb1Uk/LA2Ya+ld+Ly+WOL/AVQOOmutWcUHbSyCLFk
	0O9KKn9Sitzi14UEDUvza9GKgkPQ2bDInFM=
X-Google-Smtp-Source: AGHT+IFM6Zq1v0jmMwXwYqRoD9oDMqR8dF4x86BBEAU0OdxfdV7k9GzF2/Hh85klPoaqsXWBJydz9g==
X-Received: by 2002:a05:600c:138c:b0:439:5da7:8e0 with SMTP id 5b1f17b1804b1-43ba6710819mr131963315e9.16.1741015415569;
        Mon, 03 Mar 2025 07:23:35 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:52::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5329besm191031045e9.15.2025.03.03.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:34 -0800 (PST)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 20/25] bpf: Convert percpu_freelist.c to rqspinlock
Date: Mon,  3 Mar 2025 07:23:00 -0800
Message-ID: <20250303152305.3195648-21-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6720; h=from:subject; bh=at8Ekv6S0aGbB9KEki4TPKeyEB0J4bUZMvZ4q+vMLKI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYU15SR6rg3ngy0KboyZkXB1I7iXAgTU+4Zv4a q8n+lJ+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8Ryp6rD/ 9okBvTAvR2PTgrgAzFgfUFBu77V0INCzcE3PwQfEwD6rcvTnQUIlryGruEBawLfwn0wxW24wRL/dRy nGL+yuYrEX9YWrs+Pqsz7o2vt7yJfza0S2lZUFT62qMjwUQg9BarfBMcmdWT9afoe0wpXqzQJZc6jh N6kk4VGDj6B7Px2V2Q0EmPXTnjMNmTYmW+3aIZ54OWksD6UxJnflDMq5xbEWu/GF4B5K4mbSvFMCII lU78oDBb2buz6I6WKt9BQukjzIuQSRCcH/r1FEJvzfoQ4A3TWk18Y1lxWqoLywUa4Ts7ff2I7yus+1 Zj/YRvGo//Lcbv35gHIqrjLfvvKXZaW20bcvjfIhytSshAaX3innu2cR2sqFFrVmcb9QwjjqIKzOCa 5FGA1xCE5jK6UkBwTmMKx4rg1e1fUi1vRIbBAjX86NNJ0GuOCdFjKuYocy4yxL30V9Ik680i0XeSlr QnkJNq/7VLZRNEjs54b4gDrXYDTwnRE6WzcfhV7ZQ4Ju0vanEBetGxwfUjmZM0M0ajtqIWGYnzgiFS R5C7BadAXVRz5lKKGAlQxBfZ6nS2erxfMxeR6kGXDbOMO6k1byllETTKxBijhGc5WApPvSUKF8aOUK sGKE2uv8eHTZLfSfjrYm32k98H6hP2O73mx941c2I3ASB3LXurQ/pSaQGQRQ==
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

Closes: https://lore.kernel.org/bpf/CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com
Closes: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCXmCrQ@mail.gmail.com
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


