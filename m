Return-Path: <bpf+bounces-56332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DAA9582F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B053B3B2E
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1209219A68;
	Mon, 21 Apr 2025 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4GYO0ZF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C03219A93;
	Mon, 21 Apr 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271909; cv=none; b=jvr4Ab436v3IQsq6hjI8xpQm4UbvbC9FpFV8BK3QD0tlXe2vNXBoiAeWsXL9RQXNcuNRydCgyuwm1o4N1Ogo39cUwoGXfJEwhqzME/C7rHG4k20uYe52DhpBsXwC9Zbk09VAwtf19l7wHU3Im8rFIAKC695q4VpFqTt/A/FEXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271909; c=relaxed/simple;
	bh=D85w/y2lUcAbxKEDuMXy3+L9hQ9+AnyRAYn+0nFXS8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFeKv3dER6bvkc5L7VFOi2Ay4id4tCWEwdOKrfVMOoBvEp1gN0xjnv8LfuDllEPrknZDadcec48i1ij9S56m5BWgVKJQZFc06ox4qPAY5nXbIj0UvZr3VzNjtZ14o3lNiwJWsn0EsQbDB9N5M5GE21tmMVcYHPr2Z7GRxvUNUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4GYO0ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F9C4CEE4;
	Mon, 21 Apr 2025 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271908;
	bh=D85w/y2lUcAbxKEDuMXy3+L9hQ9+AnyRAYn+0nFXS8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4GYO0ZFCjWwCtSf6ycECRA7aobFCWH9bFn4ePzcVZpcTiUBMwY1v5tuYZLa1lGUD
	 wRhyfYWqiXtT4+MzdaPKcmBEq4WVaxveto3CaWTqrtH0GBw8rQed3eYhbz659YDdnV
	 LBYJD3X1LOksgccgyUlOsAIlEMv+w8eyVoJpFkxKTjMoMBjyhH2G8vIf9+YZIimJN6
	 EsNiopzOSuv/qT3q2YtAb3QHb2gXUmmCMtf5OwDTjIE2hTkRZ74UJ/n4oycPxQo0CL
	 c0aYCFFpPS5GsvMzNnal/uh30uENikRweX8XShrQ3C7MVZbR+xGtDPnmHgFHbYIdCy
	 2f9napgds6dnQ==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
Date: Mon, 21 Apr 2025 23:44:03 +0200
Message-ID: <20250421214423.393661-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
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
 include/linux/uprobes.h |  2 +-
 kernel/events/uprobes.c | 62 ++++++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7447e15559b8..d3496f7bc583 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -194,7 +194,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t opcode);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 87bca004ee6a..8b31340ed1c3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -486,13 +486,12 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
  * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
+			uprobe_opcode_t opcode)
 {
 	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
-	struct uprobe *uprobe;
-	int ret, is_register, ref_ctr_updated = 0;
+	int ret, is_register;
 	unsigned int gup_flags = FOLL_FORCE;
 	struct mmu_notifier_range range;
 	struct folio_walk fw;
@@ -500,7 +499,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	struct page *page;
 
 	is_register = is_swbp_insn(&opcode);
-	uprobe = container_of(auprobe, struct uprobe, arch);
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
 		return -EINVAL;
@@ -528,17 +526,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		goto out;
 	}
 
-	/* We are going to replace instruction, update ref_ctr. */
-	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
-		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
-		if (ret) {
-			folio_put(folio);
-			goto out;
-		}
-
-		ref_ctr_updated = 1;
-	}
-
 	ret = 0;
 	if (unlikely(!folio_test_anon(folio))) {
 		VM_WARN_ON_ONCE(is_register);
@@ -580,10 +567,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	}
 
 out:
-	/* Revert back reference counter if instruction update failed. */
-	if (ret < 0 && is_register && ref_ctr_updated)
-		update_ref_ctr(uprobe, mm, -1);
-
 	/* try collapse pmd for compound page */
 	if (ret > 0)
 		collapse_pte_mapped_thp(mm, vaddr, false);
@@ -603,7 +586,27 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN);
+}
+
+static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int err;
+
+	/* We are going to replace instruction, update ref_ctr. */
+	if (uprobe->ref_ctr_offset) {
+		err = update_ref_ctr(uprobe, mm, 1);
+		if (err)
+			return err;
+	}
+
+	err = set_swbp(&uprobe->arch, vma, vaddr);
+
+	/* Revert back reference counter if instruction update failed. */
+	if (err && uprobe->ref_ctr_offset)
+		update_ref_ctr(uprobe, mm, -1);
+	return err;
 }
 
 /**
@@ -618,8 +621,17 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 int __weak set_orig_insn(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, vma, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+	return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
+}
+
+static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
+{
+	int err = set_orig_insn(&uprobe->arch, vma, vaddr);
+
+	/* Revert back reference counter even if instruction update failed. */
+	if (uprobe->ref_ctr_offset)
+		update_ref_ctr(uprobe, vma->vm_mm, -1);
+	return err;
 }
 
 /* uprobe should have guaranteed positive refcount */
@@ -1158,7 +1170,7 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, vma, vaddr);
+	ret = set_swbp_refctr(uprobe, vma, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -1173,7 +1185,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, vma, vaddr);
+	return set_orig_refctr(uprobe, vma, vaddr);
 }
 
 struct map_info {
-- 
2.49.0


