Return-Path: <bpf+bounces-59736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5CACF06A
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B53ADD81
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADB239E88;
	Thu,  5 Jun 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaE/+XN3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178222F14D;
	Thu,  5 Jun 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129921; cv=none; b=BXbHtb4TPBxu+C4DcKcTyM2/PazdxG/5qfqm31RBpMBJvRdZbMvqkBoisL1PWftRF54cSuwfjWdS5QMkOxHTBxxvVT+UE/kq/Unbo5KhSbmOOpqW4lNoioUcVW8979RvZ3AzsCJ4SZgJBpOuRASKp4x/e8Zw/Jv+II1C00qu/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129921; c=relaxed/simple;
	bh=Ev5nJAiSMvgalMrnszs3NHHVXFevOJwzRNViANzSKV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YajhVLHn/ulJPKjEOt5OCO+qQWX4hojP0QOkCpiy0JncaLfLOmG3EhFlWdXjnH0BxAxYpOxd8zTqBo2Ujt4nFyW+DKwRnJr1UojEHJS2MBmqWwRKm6qXlV02qq7Jw20ve282ue7edRYgS3uYqXGXCzDPuhGCIowXEmceWEBKl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaE/+XN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D7C4CEF3;
	Thu,  5 Jun 2025 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129919;
	bh=Ev5nJAiSMvgalMrnszs3NHHVXFevOJwzRNViANzSKV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaE/+XN3NqsAmeU62CsWGsAzj+TDdA37B1e4N8tNSqkqXL4/5wIWkuCh7WaENN8cu
	 3shvoADTN8XnDA6RNtQS2JvqmEYesCRnXCiz1quyjm65orvrHBOW+2PhaII85YB3Wp
	 stgmY2/AS4x/h0/XYGbnlIji/3jdj5olCLmsMg+CXOg37f/bfluS75bcnfCuxPFO2s
	 mI/FzyDd87gE9spIDkGqoZJfJ0hSLKKuI3xNuXtRu0nt5BWiOn5iTNbGcJRj9gRjCE
	 FWU+hQWFLYxIH2avbUdFKZf4UeaaJcBl2BPoxve5bkJYUxijbthsaOtVaz0xJBkmIO
	 BgAkD4fqr6Aog==
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
Subject: [PATCHv3 perf/core 07/22] uprobes: Add do_ref_ctr argument to uprobe_write function
Date: Thu,  5 Jun 2025 15:23:34 +0200
Message-ID: <20250605132350.1488129-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605132350.1488129-1-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
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
2.49.0


