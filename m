Return-Path: <bpf+bounces-52346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8471A4224F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD14918959FC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010F1339A4;
	Mon, 24 Feb 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEifQFst"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205E7083F;
	Mon, 24 Feb 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405751; cv=none; b=LloIfCVaIsheCeY6xtYlrNk1FxPsnrSvwESlJ+JH8cSPvpmx+4IU2/Yy5P4uevC21kBslpiA1OboRDhY8396EHcY5WTvpX7oqMnjhqUYQoQkctSE50kIePwnxnI1W1R4W4gUmM+jsxgJt543XTlQ85XgxO901Xx0j8EvBj5KY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405751; c=relaxed/simple;
	bh=k9KUIypm6luhuRm4NGVxMOsl3X9Q8iKuBV/QMEedF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFytyXc9WYxBH0MW0cW49NSaNtnkBdpSnYWcXcb9t40aOMAc3uwsLSFJb8CHu+SRc2Dr0npqQ4D82ak9ZIXJO1/pNkxD/HJLG92AwER7gsmWHXcmTeHDROxBtVy8JSuj+lnQwUobk6QD9eyKYiBxp0lUlH0qE2K1TbXIOJ2oBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEifQFst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09468C4CEE6;
	Mon, 24 Feb 2025 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405750;
	bh=k9KUIypm6luhuRm4NGVxMOsl3X9Q8iKuBV/QMEedF5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEifQFstQ7AN91c4VDmSxcf88iO8aL+9IFSSqEoA2EQ7ZE29PHMt6Si2X+mucNY34
	 8ypKZXNYXS7D2gIs1yobGIc+Ma/L6fojpV6HNaqvNz18T43rClpqhpp6eSdhhu0nKu
	 AI9CBO7Hg/tFOcC0ZYnetnqrx9T+fhvR7OgyjnpfjkAXb2f+FJP6axnxO3cT19jNl/
	 LNdeA1xkFyJ9dQvJW0U+VIXninNeu41gMV5a2OuNtVnFuuUi39D8bbXXUMoK4rmA7c
	 4c+TuZ2NZ8ub1mZU6o6zEROeacBuxjDe1LRLxRcrCMwuH+qxYmFvbWQWHusA6VqUhD
	 0HuDu0u8+WfOg==
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
Subject: [PATCH RFCv2 03/18] uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
Date: Mon, 24 Feb 2025 15:01:35 +0100
Message-ID: <20250224140151.667679-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
index f07b6b7b199c..86c4eeda0ed9 100644
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
@@ -501,15 +499,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
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
@@ -560,10 +549,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
 
-	/* Revert back reference counter if instruction update failed. */
-	if (ret && is_register && ref_ctr_updated)
-		update_ref_ctr(uprobe, mm, -1);
-
 	/* try collapse pmd for compound page */
 	if (!ret && orig_page_huge)
 		collapse_pte_mapped_thp(mm, vaddr, false);
@@ -585,6 +570,25 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
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
@@ -601,6 +605,16 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
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
@@ -1133,7 +1147,7 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp_refctr(uprobe, mm, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -1146,7 +1160,7 @@ static int
 remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_refctr(uprobe, mm, vaddr);
 }
 
 struct map_info {
-- 
2.48.1


