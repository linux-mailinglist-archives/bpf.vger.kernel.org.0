Return-Path: <bpf+bounces-44035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A569BCDED
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FF41F22928
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274A1D799C;
	Tue,  5 Nov 2024 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/fMqAKo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E41D5ACE;
	Tue,  5 Nov 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813672; cv=none; b=mSCasDA7yGuHVy4tD6tqrg4/jveoRPq8+N9YrU9dX7C2WftWS4KhuVJuMXvYiJs9m/rHWRQZpkjsVoHkpHELpfgTpVXuPYwxUhrngNvGmk3rarE3+qD1mQZVeaRpDOTWaMyzRaxCMtqTNGuRaffy8CyH2KT7Q7hIWqTJyl/be7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813672; c=relaxed/simple;
	bh=r0HQNtBTw57Ve3m9QapRAgnMEQsc1BZ44c9hrQqt3qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx54rGROFoYYR3m2tnOXmdTZoT8IQS9eXXMQSEo+PBjRONua95yg/RAn7XkUNCHRsSBePHCIIg6sZXInLBxu1BHEjMq6+G2eDimNrJArAinjzKBMrR1e83W9HZZpB4UUqAOG8AYad9ZwXV3WZ8wbbAKJovXqIp6iwvr2souEJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/fMqAKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116A8C4CECF;
	Tue,  5 Nov 2024 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813672;
	bh=r0HQNtBTw57Ve3m9QapRAgnMEQsc1BZ44c9hrQqt3qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/fMqAKoSAEkYSczxHa8b/lWLLKGDApMl5+nUMVGztRgj+ERxMKYRP7ASbGch4Y28
	 h27CUga2Mkie/pOrrMid1gx9Fnvq9RjxrzdQR448elXEp8oNqYKNIjwGu+tA58mp88
	 bLdBZYRKMEMwTR8RRMpQrSHzNCCHC68BNv6pDbvALUgUh3DQyI+ZU3rqrFVJ2xCJv3
	 7L/kw8v+iFn5iKB9OwxVvxnTxSk+Sje0bXmfhxoxAfqTML8TE2HWbmsV1jpLl3UiJr
	 InLQSwIeXT70BbpPxsbhcVUtDMahBvOyJNMxw/BHQAVArqs+DK5V1l534lsqtjK1wF
	 vpr0EaWAaJO7A==
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
Subject: [RFC perf/core 02/11] uprobes: Make copy_from_page global
Date: Tue,  5 Nov 2024 14:33:56 +0100
Message-ID: <20241105133405.2703607-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making copy_from_page global and adding uprobe prefix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2f500bc97263..28068f9fcdc1 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0b04c051d712..e9308649bba3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -250,7 +250,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
@@ -278,7 +278,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -1027,7 +1027,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
 
 	return 0;
@@ -1368,7 +1368,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -2288,7 +2288,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
-- 
2.47.0


