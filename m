Return-Path: <bpf+bounces-59730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57BACF052
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E997A4D99
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867522FDE8;
	Thu,  5 Jun 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj5vRre8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880122AE7A;
	Thu,  5 Jun 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129850; cv=none; b=LYoy5CRmCpKvWHCULsBaV9CKHidxg9mY91ZmFUYMOSnIaZxSxXjQBhL2LefC6YtPwSPCY2kC/ld4GELqayYQKzTN4Ht7/5eD8uuMQP6m0Zd40QPOZ+wqvy4Hbpgw+H7c/LIgHHKSpM0Mb6Bbt53p4DEFA7mQIjSU6zYQx+BeWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129850; c=relaxed/simple;
	bh=c43NnMviDZa2eH2KyaypLO/fvk/dDaweiwsox7eBBFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah9hsul0Hz61Md7mjcLM5IUVp6ViJf8jxjaC2W8p0b31u3VMi6ZNfZ/z0HFyuUes/G6jNJsHvSJYtk05gBHhZBzXaWKRj7AZDR6UTGhz0PjHz+cJLs2BvoIn7OpayGXa1GNaLYfagpPH86X+O2dYohOdSaB9ce6M5dojlWq93Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj5vRre8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F5CC4CEE7;
	Thu,  5 Jun 2025 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129849;
	bh=c43NnMviDZa2eH2KyaypLO/fvk/dDaweiwsox7eBBFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj5vRre8Io1eVpn8rBm1Lvz3QxjVuHGRUy7JxrYC+orFEYgOmZJ9zWVlsMqjsSRBf
	 Oxx8SfS9Z3aZCUmox41Iz5qRWYGxHEbtXelRn2A9kWTVtTSQ7d2aSTBxDBjgBY9OAX
	 ZRzdDQrlj/Yoee/v/a9I88AJR/RKnbHEbuKt5diXt6YPQ6EvD/1fx7U/MOiH/8oEQp
	 4M7mVAg0owlmPe3KIcuVxATNwX2/Dm7uFHfYgo0ONQDsqnIv7mEB7qxsHuilCyYGHz
	 6Ytzpu7FBbQck+MEN4269ioMXETMUSR0cI68FFYLRe3w0xubDjAUGuNYoS6gNuCrRe
	 BAgY31wfTXTMw==
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
Subject: [PATCHv3 perf/core 01/22] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Thu,  5 Jun 2025 15:23:28 +0200
Message-ID: <20250605132350.1488129-2-jolsa@kernel.org>
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

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction, so it can
go away with read lock as explained in here [1]. But with the upcoming
change that writes multiple instructions on the probed address we need
to ensure that any update to mm's pages is exclusive.

[1] https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/

Acked-by: Oleg Nesterov <oleg@redhat.com>
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


