Return-Path: <bpf+bounces-54444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B86A6A521
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E04F460F85
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7621E094;
	Thu, 20 Mar 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNgullZB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98D21D3EB;
	Thu, 20 Mar 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470960; cv=none; b=qOCTOvSxuKaYh4GWFOJCybpyZDDEdZGZcqOvJ7Bngr62tebWV0T6tiXlZiPsKbCmdQeb/jqDPDaEYUDAAzrxWcCngQxtz1YHo8UQa060TVkieGaiwsLfenzxPz06x2dB7pG7v6SDM1bjo2FfK1YtYYJM44gRwWoz4xnIUzEo+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470960; c=relaxed/simple;
	bh=Vw+9MtJOcdHTVvYNU4k1rb1Oi0lW9ICGB+e3bKMs3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL4Ktr2FGSH4rpenpFKMIjRkyw5KeiR89CGJAuCehYucz074oycfxHVJWDx9o7pGt9B6pHPEmv1+VaIJNho2cceXiH1YLYCJYzvdmbfOIQNacYGofW7c/yBzjurh4WTlpahOGhzL8mS1TryKWBM560bAu/xipjwyzTLjM0A/clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNgullZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F7C4CEDD;
	Thu, 20 Mar 2025 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470960;
	bh=Vw+9MtJOcdHTVvYNU4k1rb1Oi0lW9ICGB+e3bKMs3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNgullZBjcy26ypqvjr7QFoNu7Jv3JSdNJiyrXCIO/hRoo5QA5eFi7xUOSc5e639G
	 I4N5pmjJG+zPf9LSn3IBDjh/mLqSmXXn1H8eTmtmSx+X06k+rz2d712Ih0OjtFoeZF
	 6Q9gpX0DPJCjw7CF4oab7TJHtrCu6VieAcV1ZwSbXf4ghQmiJiriF3aVyuzVrf0Adc
	 WlxEs9iNOmA1tM2JQ4bcUYl9fwQZGvvcF84yNuWQhX+SHL2JewwtSs2HQedq5+/Xe3
	 D0DW7gyUGCH/iZHQuIWblBXjJEQvB55jW/4ZOHriqFLZbcfIUZvPODZ90e7M0oTwWr
	 N9oQqu5byz+nQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 03/23] uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
Date: Thu, 20 Mar 2025 12:41:38 +0100
Message-ID: <20250320114200.14377-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uprobe_write_opcode function currently updates also refctr offset
if there's one defined for uprobe.

This is not handy for following changes which needs to make several
updates (writes) to install or remove uprobe, but update refctr offset
just once.

Adding set_swbp_refctr/set_orig_refctr which makes sure refctr offset
is updated.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 50 ++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5c9fc31c50f1..77b85b19f4c2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -473,15 +473,13 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode)
 {
-	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret, is_register, ref_ctr_updated = 0;
+	int ret, is_register;
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
 	is_register = is_swbp_insn(&opcode);
-	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
 	if (is_register)
@@ -506,15 +504,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		goto put_old;
 	}
 
-	/* We are going to replace instruction, update ref_ctr. */
-	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
-		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
-		if (ret)
-			goto put_old;
-
-		ref_ctr_updated = 1;
-	}
-
 	ret = 0;
 	if (!is_register && !PageAnon(old_page))
 		goto put_old;
@@ -565,10 +554,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
 
-	/* Revert back reference counter if instruction update failed. */
-	if (ret && is_register && ref_ctr_updated)
-		update_ref_ctr(uprobe, mm, -1);
-
 	/* try collapse pmd for compound page */
 	if (!ret && orig_page_huge)
 		collapse_pte_mapped_thp(mm, vaddr, false);
@@ -590,6 +575,25 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
 	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
+static int set_swbp_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	int err;
+
+	/* We are going to replace instruction, update ref_ctr. */
+	if (uprobe->ref_ctr_offset) {
+		err = update_ref_ctr(uprobe, mm, 1);
+		if (err)
+			return err;
+	}
+
+	err = set_swbp(&uprobe->arch, mm, vaddr);
+
+	/* Revert back reference counter if instruction update failed. */
+	if (err && uprobe->ref_ctr_offset)
+		update_ref_ctr(uprobe, mm, -1);
+	return err;
+}
+
 /**
  * set_orig_insn - Restore the original instruction.
  * @mm: the probed process address space.
@@ -606,6 +610,16 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
+static int set_orig_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	int err = set_orig_insn(&uprobe->arch, mm, vaddr);
+
+	/* Revert back reference counter even if instruction update failed. */
+	if (uprobe->ref_ctr_offset)
+		update_ref_ctr(uprobe, mm, -1);
+	return err;
+}
+
 /* uprobe should have guaranteed positive refcount */
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
@@ -1142,7 +1156,7 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp_refctr(uprobe, mm, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -1155,7 +1169,7 @@ static int
 remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_refctr(uprobe, mm, vaddr);
 }
 
 struct map_info {
-- 
2.49.0


