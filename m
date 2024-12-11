Return-Path: <bpf+bounces-46629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4109ECD4B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AAF282666
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912652368E1;
	Wed, 11 Dec 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+X7iiGC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270722C348;
	Wed, 11 Dec 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924093; cv=none; b=hCPf5nHYjNOtU81W9wJ3bXLHtBvueRucdu6Nmw3CF2gdbRVLikHtH9pGDAshrwnLWTifc4RoDPaTXV4dkbGaSePFxBdj8ZIidCZhb7ceKr9T0vNRMdSNAwo8IXdBcXfO/2lCEdpYcthq34vKu+OdlDxX8jYh3ueLSammcLNqgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924093; c=relaxed/simple;
	bh=ZP/siBTV/mabKudodcX5uGu2nCMI/KrZ0Kd+sWfYlMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpXQ/c0XVq/C+RGcFRxgnkfBBMFewZyMDrZmIPfAJGKMrci/llGEW2ked1KrYkvImUXu+EVGsa79UknRCe5eD7gSybDW0GqFM5ES0fVL0qQ/fmYLWuVC7FN5kkim8q6UnPUmfLnTAGZUjBIx7RHI0hz98duX0F5wpgyc6vUaDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+X7iiGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E8DC4CEDD;
	Wed, 11 Dec 2024 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924092;
	bh=ZP/siBTV/mabKudodcX5uGu2nCMI/KrZ0Kd+sWfYlMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+X7iiGCVD0RmirccVJMNebhdpnzTIRVKw9UoIw6CI7GjZ1MtRFc3l3IyvCAaGcR+
	 B4G6YHecYMdXz2YNwz1Dg3GS3UbM22o4iRYwMLf5K5+4cegKNbgiT0b5K04dQ4pCIX
	 USukRza+PiqV/+hIZRMc/ro9KcQKdJs35bAEmRade6winJb6XkF6814OuygKspYmDk
	 YZfX44DafkKxfaRRZyeDE1rN5b9H1+Kg0+g7fFoFSU/Vae77/X2pwwb9oEjAZDFwAD
	 IGkFHmfcbeWE+l4cVx0IzL3P3oQ/c855ViP7yRAHhsCSzTKTM+ioyFjpZb86VGzvxC
	 rssXeuVoOm22Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 04/13] uprobes: Add arch_uprobe_verify_opcode function
Date: Wed, 11 Dec 2024 14:33:53 +0100
Message-ID: <20241211133403.208920-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding arch_uprobe_verify_opcode function, so we can overload
verification for each architecture in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  5 +++++
 kernel/events/uprobes.c | 19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index cc723bc48c1d..8843b7f99ed0 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -215,6 +215,11 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode);
+extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
+				     unsigned long vaddr, uprobe_opcode_t *new_opcode,
+				     int nbytes);
+extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7c2ecf11a573..8068f91de9e3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -263,7 +263,13 @@ static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const vo
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
+{
+	return is_swbp_insn(insn);
+}
+
+int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
+			 uprobe_opcode_t *new_opcode)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -291,6 +297,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	return 1;
 }
 
+__weak int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
+				     unsigned long vaddr, uprobe_opcode_t *new_opcode,
+				     int nbytes)
+{
+	return uprobe_verify_opcode(page, vaddr, new_opcode);
+}
+
 static struct delayed_uprobe *
 delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
 {
@@ -479,7 +492,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(insn);
+	is_register = arch_uprobe_is_register(insn, nbytes);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
@@ -490,7 +503,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, insn);
+	ret = arch_uprobe_verify_opcode(auprobe, old_page, vaddr, insn, nbytes);
 	if (ret <= 0)
 		goto put_old;
 
-- 
2.47.0


