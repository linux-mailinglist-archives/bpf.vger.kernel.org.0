Return-Path: <bpf+bounces-58288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925CAB860A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D8C1BC3A8C
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B6298CD8;
	Thu, 15 May 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDGiqUag"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640529A9EA;
	Thu, 15 May 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311105; cv=none; b=JVpbP96PVVSWERw088yzJgdkjoQpbDr7akxW4XVq5GCCt9TUA/c2Q98XlgWk7mJyYjF8DyJXCu1uITTaI4rp24y9CjwCbhiK5RBsDJJSSiDIT6g0mnaJLPtP04vBPd90K3oHQafv/nxm2rNKHzZA5pA4WlY8FiP4NAEi3SWUJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311105; c=relaxed/simple;
	bh=8KmucVA5ArHQXXAz/rk71WeyBL7sgj2cskENTE4zkqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKJ5R/htYgro03LtXOuvpzlDgWsHjIBWfeF1Gm4cidhQ7FIgP8fVqoPaGmEs95rAh/4Zk6NAqBkf1cgs/cdYOi/h9vQMLeWkO6xA+npykBYQ3wZ3NeuqAm+HQYQ6rfbHAo5CvpS3+/li+hW+FCgPD4TVPvHLFlTrY8x8PXta7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDGiqUag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10344C4CEEF;
	Thu, 15 May 2025 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311104;
	bh=8KmucVA5ArHQXXAz/rk71WeyBL7sgj2cskENTE4zkqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDGiqUagIV18xLKJA0m94TfKl2eu05t4b1pLCkwmoGS/S906OZMmZHRc5EMWeMaz6
	 h+3d1S1VCQX6MBwYKMJ1tewxXohU0jyZdpn8eSQDGkcfGRuboaPmsNGydjQNk1H0Vm
	 JHSwhqWl0RzYm8g1jh/wyntJm4TFKJveYZJHAMBIebpfSZJbFoYW5YTOxGIrzMORac
	 F05ra0HQwq5cYUNX6OULYq6wwO9zOUII2KW79Xk5DUtsn4DrAsvvD5CYiyuJlO/3XF
	 HUDnCnrCV+dfXlX0qxmOoPbqIz+ax+aAklg22EHgH7Pt6qvKyLdNvmLBHd6mLwkf88
	 pNtrLUBBoZ75w==
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
Subject: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Thu, 15 May 2025 14:10:58 +0200
Message-ID: <20250515121121.2332905-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction, so
it can probably go away with that, but with the upcoming change that
writes multiple instructions on the probed address we need to ensure
that any update to mm's pages is exclusive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 84ee7b590861..257581432cd8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -483,7 +483,7 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
  * @opcode_vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @opcode_vaddr.
  *
- * Called with mm->mmap_lock held for read or write.
+ * Called with mm->mmap_lock held for write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
@@ -1464,7 +1464,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	int err = 0;
 
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
@@ -1481,7 +1481,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, vma, vaddr);
 	}
-	mmap_read_unlock(mm);
+	mmap_write_unlock(mm);
 
 	return err;
 }
-- 
2.49.0


