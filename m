Return-Path: <bpf+bounces-56336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0BA95838
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FC218964B9
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA821ABC5;
	Mon, 21 Apr 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEQkmuWN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CC19B5B8;
	Mon, 21 Apr 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271957; cv=none; b=egxn7igcml5XrGNZKotX+OvYs+hhd94POQM/OWIgSkh86iiVYmZfqaJJ+zdRmGBMYsnmf0vuC2lYr0wzM9sOf4ulPoC6jU4O0m2zMWAgUQut7nqhwHns43H9OdsU33a3tsZPD8q6b99Xmgp7F4JxpRcI51wGMj8w3qFnrR0Mln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271957; c=relaxed/simple;
	bh=5HVHWaig0HEBawYxtqQdeilqzoxF5+c66y72SyzkBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwm6nQH9FOV9+5Bh5VGt4FGhUPYq91Fe5Gpec0XsCcxevP9gKMwq+duLV6IXcNaaSr9cPlJywRleXAUpHykchNAI53HM78cZG0N3vHFdMWbXDz1rJlCxMNkUeWV0g1cL4x4/YtY5vcLhDCTj5w9KFjKMGvccKZZl1lwbSQYvpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEQkmuWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC92C4CEE4;
	Mon, 21 Apr 2025 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271956;
	bh=5HVHWaig0HEBawYxtqQdeilqzoxF5+c66y72SyzkBlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEQkmuWNapw0a58kRsvpiDRxddPLJVjMIvlClYAdMNORc1Rz9xLDu5dNPvgC4pn6M
	 hSse5BTgRuCocPCoe1a0/a9RC02t0Rj6tJaXUolVGfvB01XtrhjLUy8iDbC5uOOwew
	 COlDoe6sqtetk9QI9/vFh6uAxFCHSWR2ocOIix+zmyLOd+n06sLm1MtzjUly4H00C2
	 Yt8quWeij+vrEP1adkBnUjMUBa4ib81Tys20wUTp1DJw15LTmR7aZjZ5c6EBcGdyH+
	 uxunl9svtx5HNGxd7ZFwlg8Ts6ZgFUMyMzkFij3nzWDnlQr4xpsZw5zyg9/QvIKPrU
	 t1uUpf2LQJZMg==
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
Subject: [PATCH perf/core 07/22] uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
Date: Mon, 21 Apr 2025 23:44:07 +0200
Message-ID: <20250421214423.393661-8-jolsa@kernel.org>
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

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction, so
it can probably go away with that, but with the upcoming change that
writes multiple instructions on the probed address we need to ensure
that any update to mm's pages is exclusive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c8d88060dfbf..d256c695d7ff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1483,7 +1483,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	int err = 0;
 
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
@@ -1500,7 +1500,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, vma, vaddr);
 	}
-	mmap_read_unlock(mm);
+	mmap_write_unlock(mm);
 
 	return err;
 }
-- 
2.49.0


