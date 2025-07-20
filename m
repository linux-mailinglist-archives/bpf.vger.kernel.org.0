Return-Path: <bpf+bounces-63839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04786B0B576
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F4A3B95AD
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E0202C2A;
	Sun, 20 Jul 2025 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGijcCMZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254E1F5852;
	Sun, 20 Jul 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010582; cv=none; b=aqidygh7UPUDcVQS243ScdVwp+1v/gNbtuJoqDOQYR4c28myUYekgMYBlWr4M06bV0POi+pQqZ/WlZumMFnnM2K9+DAuEPN1HAIWkmebBsghkgFgOpPdCLxiEcriNqA57Cs5j2BMIgUR+0qp+F55BnWYzvaKm/2o1alMAksT9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010582; c=relaxed/simple;
	bh=KMhCWNQxHtiBSE+SRTiH1ttazQpc/bbQ0gCvygEnWyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP4vtpTWKSaw9L1L/P/f2rjfD36pR3fcmFVq69mTCgWIcEgBvecqghbi3A0BxMcqtYsRrKTH30Q0hG/LQn+ADY+YVQByqrbhOX/SZnPOS9sI5VrhBWKZ4rATTWPei6SdH6/KXp6grkt/BVMxSSMA6J4wvrByy3xQjGL9tEkW2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGijcCMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431ADC4CEE7;
	Sun, 20 Jul 2025 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010581;
	bh=KMhCWNQxHtiBSE+SRTiH1ttazQpc/bbQ0gCvygEnWyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGijcCMZqolJB9YLEDGa287wuW+inkvhctfGLdKnfm30qpU1pNyvsbweATgcqgIVf
	 3Kt+2MD9SjLqO0K10s/ulg2uNwrajAx4Yjmpdha8jCxrhdY+s7kK4vjDuNV7GikjzH
	 m/UCUaCwOzrcaOgWHWMg6dDoTeJY8589VIzTLhDXCVW3U9zwLEmdk0yMR7X+XY2Lhp
	 sTcJjOQ3JiavUcGWzjJAyx9jHSrqKc8RIpov9JPJeot6M2VQlzugDiGjr4LTA7TyBk
	 9jln/ZZCNT6eJxbA1lb5UiZ6rt5Qfa9mdrHFdf28bxuT0h8mKJpsUg2RIUxCC9/kLT
	 Xs7K1rLU6O/FA==
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
Subject: [PATCHv6 perf/core 07/22] uprobes: Add do_ref_ctr argument to uprobe_write function
Date: Sun, 20 Jul 2025 13:21:17 +0200
Message-ID: <20250720112133.244369-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.50.1


