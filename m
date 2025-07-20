Return-Path: <bpf+bounces-63833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D8B0B56B
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A607AAF69
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0991FBC90;
	Sun, 20 Jul 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSl7fM12"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6E1F03C9;
	Sun, 20 Jul 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010512; cv=none; b=dDvR6CSSjpCmGV7TfgeyFqRA/q3kZIAc3gaZiraUD4DyfhdFmdXN7fJo+MzOdHXog9Do3aNYnbPrFHReA5OVj2XqMxS7GGhlGsthq/4mhg56VRA/mKO+KPiTwzTLS8Y7yy2+q0Cqgsxyl4IfctZegBhqyVwoGb+rlVUzlRcqLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010512; c=relaxed/simple;
	bh=UhaGvEIZbqNrb/6F2zX8xZgyJJLZD2uQmB5PG/oh2y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE9SZYwTqL4Nl+Rmq+cB5dYPtNYXZAcUEy9ToX7b/dahi1Deg49IIlFXMZUdxbxy9erdHNpmg2QW96Q7sgkq5GHl9estPYEsWt/t3HlVLHGk4Q1bSrqrTtl/5tkKmOEK5G/E1f94eURvPioifiluBBOVt9l76sVcF/3JgbPHD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSl7fM12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19FAC4CEE7;
	Sun, 20 Jul 2025 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010511;
	bh=UhaGvEIZbqNrb/6F2zX8xZgyJJLZD2uQmB5PG/oh2y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSl7fM12tW66EUt+3flUPj/V5FhFiow9G1vGwn8ysGEKeuXZM/TEowCAV5GfzAxSl
	 +OHPgCUzPo2NmkNojKVz+DEQEBtJFzP3YdCbb/5amvAtAm9ccQOCsGVqBjk/WjV6VD
	 0CbXuMCwO9RGTZPO3kVdsU2SEgakuqdA+n6+aubKH2tH2x1kb5+5qNSxt1c9NY7z/R
	 aggBg5qVGGS9YzU6mNhaKdy3u9+by4l/5q8EQTyOt349MNO1HvaS6JQ1tx4lbWvYf8
	 h0vSYXyLn2QzlAUCGgTfaRObbVbLrbY2lxqy8utGUuxGhbJXgoxinOduLL1hGqWqKF
	 7ilVSziyUVbDw==
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
Subject: [PATCHv6 perf/core 01/22] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Sun, 20 Jul 2025 13:21:11 +0200
Message-ID: <20250720112133.244369-2-jolsa@kernel.org>
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

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction, so it can
go away with read lock as explained in here [1]. But with the upcoming
change that writes multiple instructions on the probed address we need
to ensure that any update to mm's pages is exclusive.

[1] https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.50.1


