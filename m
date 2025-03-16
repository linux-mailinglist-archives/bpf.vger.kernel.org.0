Return-Path: <bpf+bounces-54135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9AA633A5
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9597C3A7840
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6271A3148;
	Sun, 16 Mar 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Maeif0LZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3E14D444;
	Sun, 16 Mar 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097973; cv=none; b=V1q2LAKhuepK/ZlAlaU1qBLcZzTB3Ird8sl8n2lzfoISuRch3hs5KgRSQjnxYXc/Qh8NuePddYLFgmRGefsgDu8Zs9Gh3uVswFZjifhJArRIbMkzKylR0lVitVp8/H5IZRTkZa9g4MEvaJsU1aIfT+1UKrYMc6z2AxZAUvlDLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097973; c=relaxed/simple;
	bh=9q6tMvL0KIAbFk+sY/U9KRjErNQz0NSPRbrt2C3ZJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYTr8qk0L4yccn5qIwM9hKVPQo5mW31ScgzL3TIKDt2l7o2ohafDTgz7zcv41xl2yiq/Rdylh6F+eA8vMJO4ORxi3oZGuW54HBDQVYMs0hj5MmEApcOov77AN0CG8dwBGaAWCu03EiJNA1UXf8Wz115OH2B+IRWEOjMXoK2Cm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Maeif0LZ; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1885961f8f.3;
        Sat, 15 Mar 2025 21:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097969; x=1742702769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjwed54Vqji5j5yoD9/wFQ/aRgNfk0MsQVfeIXpdSXQ=;
        b=Maeif0LZANN+bGhNlD9S4OxIWSFz2OeAV9aCndNE9eFATc7HqO0ShQTHQVfTNq7nCE
         K0pBJAMQP8FgfZgx3b/Tn+msFv47DWnMbdlUPkn+qGTu3cYb94Y/jUYIILb8pIH89aXQ
         oNALM447nySxljHBV8w2aTvUDvQLiRiBtLYwkHmh2KZR1AwTu4pwxMIN8B72363vyTpH
         4HFXrZSYhAuy87gWXWGB0f1wRBC79xCUQD8dmeIk7qi/R9gv5M0fXVV2UhPrhzkRbM7a
         E/mEfz0Y03BLkctima/aymvQfh67sST9tqh8eIFswMtZKxPHkFbQZey893HRVEmN7LJ0
         OQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097969; x=1742702769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjwed54Vqji5j5yoD9/wFQ/aRgNfk0MsQVfeIXpdSXQ=;
        b=csNgFwLwEnwxNNCByxTDEbsh3YaM+hIQEq8Y4YXenkGIiX8cG/IS7D/hwtoEnuDxRR
         3/IbWz+yV1HIC+SNR3qMxNl16vojh3y/RCUdmmetpsCWO/mDWgS4F02WGY+3VvGgLYF1
         oi8NB+dcI3U6cPjwwH4eq5nA+u8fxqRi3V7VGt6QY68RGV19sG0RCiW1AwHmIhDpzqgl
         Xg3D2g+w8mLcjFPBk4OrqKAQ3mAuCgufZGC35jQOm/AOTCNbzcl4ijq6ZXKySgUEmN1v
         d4StNrdbtaSNzDbulv4H+OAuFHEp/Qlw1VBnxBYR5Ty6RmCoTcSD4d5X2rAyB9X0ACE7
         Rucw==
X-Forwarded-Encrypted: i=1; AJvYcCUNS919v8dTQTVlLenC3ZkCAzfwtRqD64/00inxtyYGiNx+1inVNL7JSE8wOBkhjLzPKL8lTzmvr+RepVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuoS73uTr+ZpZgnzK9o8otT1zHE7quhIjPnWWD3Pk8TU9tW/A
	sWSNE5C+cBy4hEQZtFQ1o+p7JnR8Pqg1ll/tV/JWVJ/8qRPVzt+4BUTEU41S81U=
X-Gm-Gg: ASbGncvaT7b8sYMNwFwkZldKW4ESF3SZg6Qv/Yy0gsCDnlAm4R+CIwvUA/SSMuWzksJ
	CRJLJyFzFPEbJoQDibVHJ70An2SYGxlbxSH3f1rPz6ZIiT5Yc4rwOuhDIA5ebs8iE6dzLLI+oE8
	19MSyDtsLM4kGGnfK0lbcXFO2W+Mb+WJ1uJ7a3fYs9GYm+XJ9UdVDtxV8/I0IF0r36wzFMViHf3
	LLdRmtCnYi9yotMQlIfPj+EKiwlmXhDgGr8clGczWYJ0PEbEkr6iezJFFjcSXXHVRrhBysAMt/3
	NqlthRtJXbafmDQPw+saVhfBl3cn/7rUqA==
X-Google-Smtp-Source: AGHT+IGK4qXm9ArrLCXgXNAYLraEfl7iQZEVMYeN5XftPU/x8Co4B5Nq48EhLKMbp6h132WBFeRBuQ==
X-Received: by 2002:a5d:5f8f:0:b0:38f:38eb:fcfc with SMTP id ffacd0b85a97d-3971d136069mr9762245f8f.7.1742097968994;
        Sat, 15 Mar 2025 21:06:08 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda152sm67916635e9.1.2025.03.15.21.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 20/25] bpf: Convert percpu_freelist.c to rqspinlock
Date: Sat, 15 Mar 2025 21:05:36 -0700
Message-ID: <20250316040541.108729-21-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6720; h=from:subject; bh=9q6tMvL0KIAbFk+sY/U9KRjErNQz0NSPRbrt2C3ZJkE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3eRwoCpVBivHRVCIfYOVJ3bSQqELoQ3YdqIHaZ 0Qn/pVmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8RyhG8D/ 4gZK23dPYHGv97XCNumvumPpE5iAC1RvxTgRMG3f8G3jsmtWgXSKJJX0I/LPV9SIjEVENK69dF8OYo JtJzi6M0frKXWOH3i348qYosuOyV2drlvwfNUUEFB30EDCZyh15S5rPPv1UpNngps6KckmlscR7wKN MXqabQVbUGrYpUvjSK5gYCr7BOGqDYpZ1XagCXPKfXCOsOOn1H3cDaPCfaf8XxgcflHHLVxFBMvW9y +YzbVai2PpwEalAolVi6/DC77pJhgfX7rwqhMncu4/xkyFnH87t5JONBFJHZf45QeGx0A4agc9nOg8 rxjniya94z/TfDYqZLAfQEZIV9kAGOUMvPwhEnXyYuDHDDRec7tKNSO+P2IUb2hYefVM3Ghm0n4p0P CmZc9N/Y2GIRXvVl4VLGwfu/ensS1wCFj82w76Ig1qpUYwppwWkH9o5bWb9dv3U8lmN3c8F9NHEx1o OIsPoR47YLMoasxqRtXiWe2dvZbilJdVqJelZipX4dCEyIoC+1YYy6r2/ftW3XakSo6UWBre8hFohm bGJu1Qo3BxBDSej8CFT3E3KsVzZ5XVrF/RPr0liFKY5TyEV1kO33w/oEzrui9Z/irDz8gIF9aF4Y8z u+gd5bcIJtqR98WDZhEnXhXlVzZ3ZFtHlkSpmLfDqE0N5VNrh6rqLtwffGVA==
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
2.47.1


