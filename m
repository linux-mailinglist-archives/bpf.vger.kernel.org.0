Return-Path: <bpf+bounces-62659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5CAFCBDF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FCC3A22BF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CD2DEA8D;
	Tue,  8 Jul 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJaci3Mb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024722BF001;
	Tue,  8 Jul 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981041; cv=none; b=G3eBBXmGlO/1x6eQafuNAJkgOyETpupc9AyXVcGqbZPisLE0nD2KIiGssB9GNzJSc+1qfx7Cqu704/Z4uYkQj3aJHt4T6pm9ZBZjuo3iiKZbg4+ThUPtd8IzJ1boKev/qz1gBKbccWX9nTwx5nLFrIGr1wOm+llDneMRKteCu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981041; c=relaxed/simple;
	bh=frcAoZ+jUYYDKfX2pi9ft0tOwNEbFuiwLggEmcrxcLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bobH8aSrapKkFd7wByO9N3LvtMDHLOVvFvjDQhncVTFC+saEelaIjJxn6+wZB97fUOEzx+uw0lkhC18GRrJ9WUMj3NPGYylX+PjNxLmCryDV0nKrT1ypBP6V359BFM+egMXWdQ7bHQLxKM9MIWrWOk6uwua6Fd2VJhIoBZAARjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJaci3Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6E1C4CEED;
	Tue,  8 Jul 2025 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981039;
	bh=frcAoZ+jUYYDKfX2pi9ft0tOwNEbFuiwLggEmcrxcLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJaci3MbFK3ktZOrb8Z9HCGdAbZkFyRmZfuoHaXWRnx9uW3iTpuXhvFUcgZNgjgLJ
	 zkBKeMgXO9fgcJb92gq4+7taYLDvrYgRDB10rw/0AG1wF2Xpga76IpZ5RWFM2aTA8C
	 pv2M4uXXMel8jR45QpTYsyhIQG+xOkG9dLpzlqJ5Cfr7YdlcZGCGQHMOJ2tURWsQcV
	 xnHwRytpgcp/s6hTIGEfbKmMCBptgV3yTO1rg96fKc2elR036K1sXkJLPJLlQUAZWo
	 Flm/PSTP8lVSCIwibaoDEMiDkMpSArihUzr3InjUbk4Sjt+TMWtm3IAOWvPQzdUQi7
	 MTwDQezewjCvw==
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
Subject: [PATCHv4 perf/core 01/22] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Tue,  8 Jul 2025 15:23:10 +0200
Message-ID: <20250708132333.2739553-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
2.50.0


