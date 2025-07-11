Return-Path: <bpf+bounces-63016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A59B0162B
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B4C5A66F1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC6221DBD;
	Fri, 11 Jul 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVGAeoRF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9E20B80B;
	Fri, 11 Jul 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222673; cv=none; b=R0ruVeWrbXpLfhBIcRMut7O8GyTz5twtqFMhSRGpQr1v8ccy7XayMZZdHXAAz7WKysi6XQ0EwEwvVj/CW7A31yCYYpogYU5irNm/omx6RvGvRX0iZKks8CYo2T5CiejWdQtisZVbAHcVSXXofeWi1RbPXf6fBvCl1gAm/uPkWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222673; c=relaxed/simple;
	bh=avABY2M9T3BOKobcIpHvSW7kE15SbB3u3CUPWpxE318=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTY6kzru5ZTO7yRM+x4fQRRDjD/pqIW0ttvJJtWtjZHARhEUulFUf7YefbuIkTYMqofXs158PYI043dA8glzwkc+uKYTTJaFa299KHmDcMBKYEehZ9lmBCZjzngpvGcfppFDyL5MNdhZl0SHrHl/gfR3DgKeEeuEPBW1SFuY+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVGAeoRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AF9C4CEED;
	Fri, 11 Jul 2025 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222673;
	bh=avABY2M9T3BOKobcIpHvSW7kE15SbB3u3CUPWpxE318=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVGAeoRFYtdT1s+8L+7Y79KMIC7wiWmkPr9OoaSfQQnYY1P1BiQoZLSzcUnAs3yte
	 3aLi33Pfl4ME7KmZYEH8gnQXHYMIYLRrtu/aYSgsPTsyyBE8zNSA8N78fRMOX0xt6U
	 BUbX5Qf05fGJ70f50loGNiHfKG0sz+to+SpoPVKYpzeq0aOZXvVXdfpuOvVwBLgZJR
	 byMWtsg9uux1IYiR6KjQIDVaATSjqIT8X4+U9kfbqO9KAFPcgDgLdiOEonUsNpZBGg
	 kiAHNnnOOW/0XKF05xY/dsxJseRASyI5LDCsP9+vaoVUJ0og9JTsrXmLfp/mARYY/q
	 7PoQScBXZ68Pg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 perf/core 07/22] uprobes: Add do_ref_ctr argument to uprobe_write function
Date: Fri, 11 Jul 2025 10:29:15 +0200
Message-ID: <20250711082931.3398027-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making update_ref_ctr call in uprobe_write conditional based
on do_ref_ctr argument. This way we can use uprobe_write for
instruction update without doing ref_ctr_offset update.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h | 2 +-
 kernel/events/uprobes.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 518b26756469..5080619560d4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -200,7 +200,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
 			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1e5dc3b30707..6795b8d82b9c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -492,12 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		bool is_register)
 {
 	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
-			    verify_opcode, is_register);
+			    verify_opcode, is_register, true /* do_update_ref_ctr */);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify, bool is_register)
+		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -538,7 +538,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	}
 
 	/* We are going to replace instruction, update ref_ctr. */
-	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
+	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
 		if (ret) {
 			folio_put(folio);
@@ -590,7 +590,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 
 out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret < 0 && ref_ctr_updated)
+	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
 
 	/* try collapse pmd for compound page */
-- 
2.50.0


