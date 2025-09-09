Return-Path: <bpf+bounces-67908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E001B503BB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DADA4E3246
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222D35E4D9;
	Tue,  9 Sep 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH8Q1frt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58435E4C9
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437165; cv=none; b=pCnZhCMBK/073zgQ7d+OcvjxY9SvfRz8sC9H593l5vt54+5lpCm1SdhwXI5lZ4lGsDtpJFfIjyxX9O9ySeGeZhLG1bcQWsan67jazOBcKWqaCezgxbXJ3GYJ5It2/dIe16AyXjtUTIz5qmFKfkeriztK/9EVzKJSxbz9gmJW198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437165; c=relaxed/simple;
	bh=WVAjxwh17S2lB+pHUPM4iwfDcpAOFH3ek15Q+dT/V7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4rnHyVpJkQOTPUixwYNK8W38ofz9RVBKOg2JprmCS6C8UyEkxr630oAeDkOs0VDUej4BgltGuL+6xYx41i0grvGyQGwTTJmjAL4I//8PXvCvqvnhnah9A0yYHmgec05WZYV2FgJMFdDwA5bE3KsBLXpEIbAfcCqNuHjmik1Dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH8Q1frt; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so25541545e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757437162; x=1758041962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tXS505H9R1o+vqx1ndt9ftdWkFdo1/cPCy+boBP27hM=;
        b=XH8Q1frt43BWwrhPKGc+mGeyOjBvnFEwBLPbK0RobWNVe4l5fV1v7Moo2j6iANaILd
         7eRdMA8r7gnos0H0EUdMfWdfxzS9tVCH/rskFDSuw+YlnWGdqIvqsaJnKwIve0i5lwGp
         8sX4obhP9yIg6QIeibkkeQ6WXxPyRuOmLRzDNDjwKwX0TQ6wyiXSjlvj/7hHjAC7pCs8
         WAg1T1klokOm5KDTukFkJ45zoJw+VyL+V+1JnzzFYYIB1hmqk4rhID0pMdtqoWloViDb
         JrYUdtPaQzqAY1cqffQ+wTTOjIhJV+Zc7Fkps43iXFjT17bzOz1xxjmSc8FesU7fpCWq
         eeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437162; x=1758041962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXS505H9R1o+vqx1ndt9ftdWkFdo1/cPCy+boBP27hM=;
        b=kDAUpG0H6wWWDS2MusQePB/aw/YfjC5bpwxH2cKyQJLHGtNyM2S/6rR/sFC/DnMvtU
         PlhjgFKlpg4VyF51U1CzLY4v/Wv6ySiZxnZimO1Ra0ysFI7+Emqcqgrmg+SxRdk6uGED
         XDXp1JF244xqmIvU75rYbpnHQPPEfCYCKmN1sL5/MXdHwPu5BG9HzYUvD66ppBkhoshj
         ik+cFJUBgcX1D47LrJBU1UbBMPUsnRvPRJrb128MxJ8HLjcZDmeo6vMNydHSdMYaSo5J
         XlppIARrNpaRK3hOUeB6OfY6AJGNzoI2e/cxou2wocfrOUtMdhwxCrkZyqMDRgADuwzX
         c0wA==
X-Gm-Message-State: AOJu0YyPtXYqrgQ0kKqAFP6U/m4uhUKjoIjelhA+FZ59wjaXxQ+yLObQ
	g7TtJckYQXG4BLevanbaGfKE8oWwTgFGCdAPc/3dHX1/YTZlVB6cZNESuDN6xFMT
X-Gm-Gg: ASbGnctPjlBFrFWglDOJD/EKxchk/M6WPRX1sbnq/1ox3y06iVo3EDO5gbSXiLU6WcK
	AqjfIwhym1lHZ+kEuh9pkeFKnHinMsmVyeOHiHpakAv5epA6cbD1KU6ANe65u2Jqna0uiXYJ41K
	3XzPPoiTtDVc8APVGxQaxqYhYxV5qK4YfbRirqwJ154UMzrWbCflkvRHjjr50YYQvujzB5Cjmxb
	Okp2W31fccMbsZqoAVFrGGLOwOEkl7/0TN/BCT1+t+FNLZeRTcft3KUo8q4BH5hZItlEU1DHVEq
	FpFZthgbrj5wF7ljf+UfFYVMUAl1/CE5eWu4rNhfS+Ff+3tWVSB4MaxQIFXheUD9Qn67oZA4Mw2
	UAN2GBnR0FVeIGhgeDUKeH+j5lBnRpO/Px10c2TLAsj2p2LE2g1Q0gAXCDlpJIws4cg==
X-Google-Smtp-Source: AGHT+IE1YnAOkEFVFfwRWHkkwqFyDDEBB+TLFrAA7KHQHpqtk5dphZIm1Olzec+fm1Tq7jY2ePnCrQ==
X-Received: by 2002:a05:600c:6305:b0:45d:5c71:76a9 with SMTP id 5b1f17b1804b1-45ddded7652mr121134115e9.24.1757437161894;
        Tue, 09 Sep 2025 09:59:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e8ab14esm540765965e9.21.2025.09.09.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:59:21 -0700 (PDT)
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
Subject: [PATCH bpf v1] rqspinlock: Choose trylock fallback for NMI waiters
Date: Tue,  9 Sep 2025 16:59:17 +0000
Message-ID: <20250909165917.3354162-1-memxor@gmail.com>
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
will be made as a follow up.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 164c246571e9 ("rqspinlock: Protect waiters in queue from stalls")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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


