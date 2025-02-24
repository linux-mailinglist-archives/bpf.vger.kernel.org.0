Return-Path: <bpf+bounces-52344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6AA42276
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D119A3B403C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA278F5F;
	Mon, 24 Feb 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZz45Tro"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862B78F2D;
	Mon, 24 Feb 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405729; cv=none; b=WuU+pEVEItUORaQEMsMDgM3+EwJfg4DTL3gxs9PCtV+Rl1a7PSReFeC1JIeAzf+pCvUYc3MwAIJa1lLf84FDyDyAGMbJZmNm/J7PiIAid/Kg6PAUToS3Hi+nbEGFid7IwkEkwVnGIFNGJhgEaSMBa9PsLllLRM2w9fDKj5YGK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405729; c=relaxed/simple;
	bh=EpYPzG3PaWpxDf4Yxs/4XvTSmKgVHrQwXvZSH/F4ozI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN0P4+hyx0l2M2jHDp+fkVuK2uOwWB6bnd0a/v1S7etsmh4fbCs59pz47kQFOrQWheLwdrq+aU3Ki1FKaPKvmFzPPHPksX4NLsKF/ov4iwF6i3OueKAZxpiVqvdR/Z96xyg0ldFzr5lmX1d+SUXyv6u1tMImV46ZdsOYmQIbio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZz45Tro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91BAC4CED6;
	Mon, 24 Feb 2025 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405728;
	bh=EpYPzG3PaWpxDf4Yxs/4XvTSmKgVHrQwXvZSH/F4ozI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZz45TroNwYHfLCdlOotsrOE1dIOSQapj9GsqliIQDZDXf9Pte7bFOqgzzcOPAuYw
	 qgiiEIs5BxCX4sgrWmkAtaW6ZqPhlzBuXRfkeb1+a36xQnUVQgbEvJnMLI0QyNIlx/
	 xa/qJqIzBBaIX9WFywaNa1l1AyfXAg3eXz7lGurcUJvovPaqDbiZQ+Dt9UrJZUESo6
	 y8C+ktNuo4xv0oOSSWxccmUbZjZNHC1He1x6xW9EvmVy5EssZJH4KIUsD7RQ4loHgN
	 ZD395rK8FWdIdCYYqPdjZqE0J6/wbuGi6+olonQ9FzG9FhLL+GlfJToP+HtJVLdoF8
	 axAVeAkpE+yUg==
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
Subject: [PATCH RFCv2 01/18] uprobes: Rename arch_uretprobe_trampoline function
Date: Mon, 24 Feb 2025 15:01:33 +0100
Message-ID: <20250224140151.667679-2-jolsa@kernel.org>
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

We are about to add uprobe trampoline, so cleaning up the namespace.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 include/linux/uprobes.h   | 2 +-
 kernel/events/uprobes.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..22a17c149a55 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -338,7 +338,7 @@ extern u8 uretprobe_trampoline_entry[];
 extern u8 uretprobe_trampoline_end[];
 extern u8 uretprobe_syscall_check[];
 
-void *arch_uprobe_trampoline(unsigned long *psize)
+void *arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 	struct pt_regs *regs = task_pt_regs(current);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a40efdda9052..e3ed0d5c5ffe 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -222,7 +222,7 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
-extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 870f69780900..cf4c4e730f0d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1699,7 +1699,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
@@ -1731,7 +1731,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns = arch_uprobe_trampoline(&insns_size);
+	insns = arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.48.1


