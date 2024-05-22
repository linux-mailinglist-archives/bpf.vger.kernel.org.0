Return-Path: <bpf+bounces-30254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D778CB888
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4EBB24B72
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383F6AC0;
	Wed, 22 May 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm5e8pAC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAA4C84;
	Wed, 22 May 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341931; cv=none; b=VD5J4tIM5xz/sydcMPJEXEDEOkKCwNQaIKJ3gmQ9lqo9EHOSgTqedQ8CkxTxZDkf1j2+yNdqtAkyK43ExTsgiVk+6GzVSbqbRkem/sjYo14YtOjR/RVtQ/xQwK3Z53nmKzZT7rLuYhiUsDx+0dxjcxvugUR3VeCrAmo85/n+FbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341931; c=relaxed/simple;
	bh=PdIMsdaUCiSs4TuXIKskUpSJzvRucEq5dFDzB/EcSIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZU4YtCXYKQPsejzsXs/MrMBDcdAnOcpN1CJxjiDVlWrIssC6eLP2gu1sBoaTEhZO9a0qErmO+aHWr7Cxcv6Op2dTMPTbGSvufZzD/8KTqz6/s2xk1tqLex+idgr1VILOFaqbbC0g8Y7t/kG7xcxf/AvSi2RLh+svcoYfGJZA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm5e8pAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE63C2BD11;
	Wed, 22 May 2024 01:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716341931;
	bh=PdIMsdaUCiSs4TuXIKskUpSJzvRucEq5dFDzB/EcSIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm5e8pACVky0OUTCldk0owYBNxh2s02U2g5RkVWWMOSxYt/df/bIrv0dhZA/nDOmh
	 uNEiGT0fdbUHeGjWi4y7pw6wXCmtCwDQqF83c5dgeJu+gwKmuie4pRDYk1b/kkalHI
	 Q8FBXG+yrEjIcvzVasX7V6Mf57h6FY9zhBOCG7VcQXmucRTOJbz/LklynDIe2oJund
	 UT9OmlwsVyVKfacAbI3+WNEonueCqgmBl5U8Irvedr2ziZ9cKyc5fZ+hxlWItzsyNT
	 I6Ag7FOoTaVqp9K5+W1ctz8DjANED9Zvej1nJFVOWfD3NRxqb09PJDbwfS4fQT3D20
	 Pj/jkAFPTrMNg==
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
Subject: [PATCH v2 1/4] uprobes: rename get_trampoline_vaddr() and make it global
Date: Tue, 21 May 2024 18:38:42 -0700
Message-ID: <20240522013845.1631305-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522013845.1631305-1-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
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


