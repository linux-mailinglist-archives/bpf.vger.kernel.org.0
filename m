Return-Path: <bpf+bounces-56333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E4A95830
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6221896405
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849E219A8A;
	Mon, 21 Apr 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgS20hVa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1515D1;
	Mon, 21 Apr 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271921; cv=none; b=VacFvTKL6ut+ABtaqEZGLBDB0aLm7sSaiQslrn8zaCCh17oxgMyGT583a9Kl/3ga9QObUBxQ0NXH/m92iKuaJOPcrR551svM/oyKiO9bvQuEZM9Dp40mWgdcCs6KTnOBhls1VU2FJNXpgHJ9YxrwKy9cUKliq2woxVsTnVvoXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271921; c=relaxed/simple;
	bh=1h8Lt5sfu3I36yNkn7tVNN8qftvnhgevSwlEaG90tM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYdop878Z6kiKJx1hXIz5uP3n3Ck0WI2IO0cDZlkU8TPsyC6CgZscYcg477bYxaut87I1jWipBjFnH62Zvrln1/yIbgaoX8uGtNAn86rsP6zJLDCbGBWIIo9h/h/HMnvhg5OkshmbA8OtpFLnang0K48Cg6LZREBD8wuNt6iWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgS20hVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F98C4CEE4;
	Mon, 21 Apr 2025 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271921;
	bh=1h8Lt5sfu3I36yNkn7tVNN8qftvnhgevSwlEaG90tM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgS20hVaRmYbyUn3HeoV1Xl+DTNeZobY/dlY0dL4kZ2M9WEwn7uyO025YtCsJTiOP
	 ytbji9NNI/JDXMtqHMmDc9lXh8NZdHDnLMSwNGz9CID5AaNV2JOHXmjOqsrS3JV//g
	 fd57+smsSrtdohiUELx8ho2LS9wbXf3qLv/Wx6yHj5ZgBOd4QQrDBXARbWuwVEwdKr
	 ukpu5i3VkkqSjeIpIsL1UpdtPKGJIaJIr9FhDc/Mr4br9vKM0BuDTXxNKoyUkN7BsW
	 bBcGhbR0bMKoAz5TR6Quq60KGOcY47EPGCgo2FfPQUG4MzKb5DY8P1DwbjXQ3D1cG6
	 fDRQ2OidgI+SQ==
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
Subject: [PATCH perf/core 04/22] uprobes: Add uprobe_write function
Date: Mon, 21 Apr 2025 23:44:04 +0200
Message-ID: <20250421214423.393661-5-jolsa@kernel.org>
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

Adding uprobe_write function that does what uprobe_write_opcode did
so far, but allows to pass verify callback function that checks the
memory location before writing the opcode.

It will be used in following changes to implement specific checking
logic for instruction update.

The uprobe_write_opcode now calls uprobe_write with verify_opcode as
the verify callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  5 +++++
 kernel/events/uprobes.c | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d3496f7bc583..09fe93816173 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -187,6 +187,9 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
+				     uprobe_opcode_t *opcode);
+
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -195,6 +198,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t opcode);
+extern int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
+			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8b31340ed1c3..3c5dc86bfe65 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -399,7 +399,7 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
 	return identical;
 }
 
-static int __uprobe_write_opcode(struct vm_area_struct *vma,
+static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
 		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
@@ -488,6 +488,12 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
  */
 int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
 			uprobe_opcode_t opcode)
+{
+	return uprobe_write(vma, opcode_vaddr, opcode, verify_opcode);
+}
+
+int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
+		 uprobe_opcode_t opcode, uprobe_write_verify_t verify)
 {
 	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -508,7 +514,7 @@ int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_v
 	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
 	 * fault if required. When unregistering, we might be lucky and the
 	 * anon page is already gone. So defer write faults until really
-	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
+	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write()
 	 * cannot deal with PMDs yet.
 	 */
 	if (is_register)
@@ -520,7 +526,7 @@ int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_v
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify_opcode(page, opcode_vaddr, &opcode);
+	ret = verify(page, opcode_vaddr, &opcode);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -548,7 +554,7 @@ int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_v
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
+			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
 		folio_walk_end(&fw, vma);
 	}
 
-- 
2.49.0


