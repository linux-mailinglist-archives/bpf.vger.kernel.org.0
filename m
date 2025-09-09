Return-Path: <bpf+bounces-67933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D13B50594
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051FA4E48C1
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2045D352080;
	Tue,  9 Sep 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmUN2SEo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDA21FF24
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443808; cv=none; b=rRL6WLysTLb1zjyo+3HdxrSG3r5NYymVTNt812VrvGC2+DuwYBUvbP7E3nZRkPnxz03fkct7tqYY6RCBxwbdyFT/MthFW4Fhoz7e9gKg7MjBVMURdoM5MfBgfXlzC5RySQg6GgJkMIbGcoQnRsKAE74ngxYxHS9JSAVM9t4pWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443808; c=relaxed/simple;
	bh=AIdpGdCtR4CWvytc9ynHviivkMyDzhZGlyzur0+U+FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/k7mtLV9QLqJUztrRfmrifLiL925GajSPwzz5E7SH0w6jUi9iiXNZHQ7aMRka8cyRGFbFCJBmNXAICiPjodvl1dFJJQJkVr/z/Zbq/AAg/wEZjdXyRNXkxvZjTwYU2nGqjz3uuya8lx0aKpCGx7YtX+DmEww/MfeBDzIwtjI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmUN2SEo; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3e2055ce973so3250058f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757443805; x=1758048605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBq8/zPHNAvO4ZHrc95hoaPHI2gNms2kWd1UUmJwldg=;
        b=lmUN2SEoGGF0LwdQ7IQYaE7gp9WYiOrBBf3M2f8iRvEzjq/cMO9l6s96HdEeIatuLa
         iuDfSK7fU+i0/VdrZJCO/XuRJwH7b6pz52Uda7hSqJHIdc78/ymD3t4GKcZIVqC3QQoL
         Oo1v/e9nhCVlaWle/TixpyXyRGTNqiVHl6JqzF7XdbZ+OkdU4hJv1zd4uD3YbJ4hLuhY
         8gLb1cClcRt7t3ezFo6IEMrlgxHQ+0hAffV0HGrTAQbr/jwRhEyqSIB+S3649Aq61hNi
         hMHWi2hKjn7C3mjhFwWBLA7+y+9R07ifcB4UleX33GvS3XgHigpU7J3FDxPxQm0gTzys
         TPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443805; x=1758048605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBq8/zPHNAvO4ZHrc95hoaPHI2gNms2kWd1UUmJwldg=;
        b=D9G3KZMBw+c3KaWzK5b7krVhspBgkDKWIl9ka4eScjzFMsiku3ZrHKSNV5zxxrc5r7
         r0mtOAroy2YCdt3APXD7nkAIAeSH+EAoop5ObQX5mxbSKh3BxDjXEQTz3rcZ3q++k25g
         mjZsQbdm+rBgsvhvSCtKRl5AxZG8p63fllM1qM0M7dBsz5Nf49IYdHny2WcG1E2RJyfR
         KhaXOJ7jSnLMcWy6m9s/UfAcUhQnab3zr8UWSRs2fIHu8YOfxbcpfTLnUiRTMWOBr+ol
         twDG4cwHVC8sbri/0+bUFDfBjG5W8u9JygRw/S/wJPBAspeSkkcaMByIfCMAKy8dlnM5
         bxWQ==
X-Gm-Message-State: AOJu0Yz0qQKG0nP12R7KcdJgvA0dZAUM0l4+pBrdbb80bete0vCWecV9
	stAabpd8bfT96oLHdy2IzwTI8FIe+3WK4f5HxeKdjB4CGYLWI0vnw3qRxyNGJfn9
X-Gm-Gg: ASbGncvgNjSJaUn8SqpI1R3uqf0eMFBfI1SIfZvi4QjkIv3QQ5quaoJV5dUtxMop5dC
	90rsh0mS/07gwLx57NY3fjL2993R9apN4iNwNawO3U61JdSEhPtoHBQiRcmqcwUoRzt01maoCzX
	tLiXa0gRSvj2y4gDNeo/h6sa24dWsDjyxrakSXLLH6/fLAUFtMD6O7Ea8hjlF6d1sdqE+YLunb1
	ZRMakdo7lgWwFEo89YOovHmiTFonvR5DY2qraL2X4VAeLZBQJLTxKhHClEKLEGJOTYztMtHhHcl
	mvr8tBvByaXibVAj0MSCgnYIDYVV+iwUwuID6rcusNNUa73ixemKxYKc6HIz//YVgdfS1cGtLtL
	9nO4J0WalyoiIECgMGG492uDEAD4lYu6HsK6NxhTH1oNW
X-Google-Smtp-Source: AGHT+IEbzu4fVIutOsz+P1c9zeDN/tGpzhDdg83wKP/n5COWRz1BhhPza9fpWA4rJWbXTBrOGkOfwg==
X-Received: by 2002:a05:6000:1ac6:b0:3df:f065:ca13 with SMTP id ffacd0b85a97d-3e64392b761mr10343167f8f.33.1757443804527;
        Tue, 09 Sep 2025 11:50:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521bff6esm3566777f8f.13.2025.09.09.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2] rqspinlock: Choose trylock fallback for NMI waiters
Date: Tue,  9 Sep 2025 18:49:59 +0000
Message-ID: <20250909184959.3509085-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, out of all 3 types of waiters in the rqspinlock slow path
(i.e., pending bit waiter, wait queue head waiter, and wait queue
non-head waiter), only the pending bit waiter and wait queue head
waiters apply deadlock checks and a timeout on their waiting loop. The
assumption here was that the wait queue head's forward progress would be
sufficient to identify cases where the lock owner or pending bit waiter
is stuck, and non-head waiters relying on the head waiter would prove to
be sufficient for their own forward progress.

However, the head waiter itself can be preempted by a non-head waiter
for the same lock (AA) or a different lock (ABBA) in a manner that
impedes its forward progress. In such a case, non-head waiters not
performing deadlock and timeout checks becomes insufficient, and the
system can enter a state of lockup.

This is typically not a concern with non-NMI lock acquisitions, as lock
holders which in run in different contexts (IRQ, non-IRQ) use "irqsave"
variants of the lock APIs, which naturally excludes such lock holders
from preempting one another on the same CPU.

It might seem likely that a similar case may occur for rqspinlock when
programs are attached to contention tracepoints (begin, end), however,
these tracepoints either precede the enqueue into the wait queue, or
succeed it, therefore cannot be used to preempt a head waiter's waiting
loop.

We must still be careful against nested kprobe and fentry programs that
may attach to the middle of the head's waiting loop to stall forward
progress and invoke another rqspinlock acquisition that proceeds as a
non-head waiter. To this end, drop CC_FLAGS_FTRACE from the rqspinlock.o
object file.

For now, this issue is resolved by falling back to a repeated trylock on
the lock word from NMI context, while performing the deadlock checks to
break out early in case forward progress is impossible, and use the
timeout as a final fallback.

A more involved fix to terminate the queue when such a condition occurs
will be made as a follow up. A selftest to stress this aspect of nested
NMI/non-NMI locking attempts will be added in a subsequent patch to the
bpf-next tree when this fix lands and trees are synchronized.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 164c246571e9 ("rqspinlock: Protect waiters in queue from stalls")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20250909165917.3354162-1-memxor@gmail.com

 * Add description about future addition of selftest to the commit log.
---
 kernel/bpf/Makefile     | 1 +
 kernel/bpf/rqspinlock.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269c04a24664..f6cf8c2af5f7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -62,3 +62,4 @@ CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_queue_stack_maps.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lpm_trie.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_ringbuf.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rqspinlock.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 5ab354d55d82..a00561b1d3e5 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -471,7 +471,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * any MCS node. This is not the most elegant solution, but is
 	 * simple enough.
 	 */
-	if (unlikely(idx >= _Q_MAX_NODES)) {
+	if (unlikely(idx >= _Q_MAX_NODES || in_nmi())) {
 		lockevent_inc(lock_no_node);
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
 		while (!queued_spin_trylock(lock)) {
--
2.51.0


