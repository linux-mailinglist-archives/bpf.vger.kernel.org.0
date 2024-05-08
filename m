Return-Path: <bpf+bounces-29125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33E8C0642
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065B728410F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DDC132489;
	Wed,  8 May 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu/stqCp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09612BF23;
	Wed,  8 May 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203575; cv=none; b=OgR/6ZHgtBBgLB+vGnP+bMvPHuR2Y0rZ1vmQmrCJdnQR5XnAtpnlNR47QFnx8DL0kz/KJAU6Ato6/ESky1sPJ61Xa9/bvurnl3ouyN32C8vK8n/j1VAhpFrEuehBDlXWvssvyv8OUIgPLcoyhdci0lsOaX5fsvg9+wnjzwS3T6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203575; c=relaxed/simple;
	bh=PdIMsdaUCiSs4TuXIKskUpSJzvRucEq5dFDzB/EcSIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tanMLuMTEcp6zibjXv46vuv3lgT6ciqlXm2TYgoXgRu0BMnf8eUxgzPOFwh4+VYS4mudx8XtGAtmNKgx6WjH6b7Vj1jpnqR6JviWtWgz7uEO0mpbBnN1ON4zF6vPmBDgY8DgGn/zXwvjkU6F2vN/F1b1KzzGRX/5XgBxioNpHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu/stqCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF85C32781;
	Wed,  8 May 2024 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715203574;
	bh=PdIMsdaUCiSs4TuXIKskUpSJzvRucEq5dFDzB/EcSIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lu/stqCpGqXbJCbwBFZy/OhMMRDhP17FPPje8d87tprBaEoaifFfQ2HqPLhAl7V9W
	 6VB0IpbY1wVitIp2XrhAay3JJJId2Kpb7QrTb0mCnqaVsn76s8vqBjpW15DVJMrhrd
	 a14WBvvjkDdYLnmRJ4aILUj/szfYXudWBplpb+q9Mtv2Q+JqUnRMb6YJ9cn9OfGDs6
	 jnHTHijCRNGTpXYG3uCnuTphVw679PZzD4jwaoBftl37PGipPEip2vsJ5eJBtdWLe7
	 gR0+6y7dU0NKpC6sBJA6EKC3y1rOat+EBVH+FP3H7E8plRE6lxfwEsxFZg4ITYeBd7
	 wZtSkwUruTuZg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/4] uprobes: rename get_trampoline_vaddr() and make it global
Date: Wed,  8 May 2024 14:26:02 -0700
Message-ID: <20240508212605.4012172-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508212605.4012172-1-andrii@kernel.org>
References: <20240508212605.4012172-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper is needed in another file, so make it a bit more uniquely
named and expose it internally.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h | 1 +
 kernel/events/uprobes.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..0c57eec85339 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -138,6 +138,7 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8ae0eefc3a34..d60d24f0f2f4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1827,7 +1827,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  *
  * Returns -1 in case the xol_area is not allocated.
  */
-static unsigned long get_trampoline_vaddr(void)
+unsigned long uprobe_get_trampoline_vaddr(void)
 {
 	struct xol_area *area;
 	unsigned long trampoline_vaddr = -1;
@@ -1878,7 +1878,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	if (!ri)
 		return;
 
-	trampoline_vaddr = get_trampoline_vaddr();
+	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
 		goto fail;
@@ -2187,7 +2187,7 @@ static void handle_swbp(struct pt_regs *regs)
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
-	if (bp_vaddr == get_trampoline_vaddr())
+	if (bp_vaddr == uprobe_get_trampoline_vaddr())
 		return handle_trampoline(regs);
 
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
-- 
2.43.0


