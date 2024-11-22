Return-Path: <bpf+bounces-45446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025C9D58C1
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268DCB20EDE
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0291632E5;
	Fri, 22 Nov 2024 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEMjM3Dg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7391632D1;
	Fri, 22 Nov 2024 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247981; cv=none; b=mtOu9GxrwgMx4cqZIcWFIvKThZ3d0Z0UzEkTN2T5/54ecodNBO3mnkCMJKEB1e3ZvpWQZAUORI2fa6GotGYhrm5oLr1KvzrX1uMFwa10AFxnn35kNA+wDTHm14FfPOF457H/flWFV1kyY1yErbmYSDgQW8jPqGzTUTPxjxfX1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247981; c=relaxed/simple;
	bh=IrM7jUhEG4Z9f//nITfI+eGyW4Lnt6qYBNt5PkL6luM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUV4fnHnTooA3sbH06yRcl4uiZG7N/6s+if0lsTwPCorJeMZsvmUFoCFz+SpV9SZX2bCST6kgT1QAwipDy3yU+HofEGIYPlUt7sYYw6RbedjI6aKctOEibil6KjOl1zD2ArUSo6fWryopNORzWW+x8tbyrXQClb1Tja3eT4KhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEMjM3Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AE7C4CECE;
	Fri, 22 Nov 2024 03:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732247980;
	bh=IrM7jUhEG4Z9f//nITfI+eGyW4Lnt6qYBNt5PkL6luM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEMjM3Dg5YOSh7dsCuJUD6w40TK3OBk1GWuAwaKApntlzya3paJAdHFLEh56H6uYv
	 yIqflIuUP2jbDT8jFBJKMhM1+7pnWeu5LKK0tMgpExDl/NTwRqFTpJtS2ZPnXua/uN
	 FqW5mblLMmkq+2xC18ZZrnLoZsv7EJFaC/8Q/4f9FL2mNhXmIv7ObLUsdsMNOn8tlh
	 9M3FqqaMNKWxsc3CTMFTQT8usfKrQdETreB3Vb7vb1ZQ73X9S8Fha5EC64fMSHtFOK
	 8/h9kv/J09xvzr21AqsJHlyvVaPUB5vhEg+9+RKiJcUUUosuDuNNPVwaKzsahksBry
	 WI9YAczrP+iVg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	mingo@kernel.org,
	torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 tip/perf/core 1/2] uprobes: simplify find_active_uprobe_rcu() VMA checks
Date: Thu, 21 Nov 2024 19:59:21 -0800
Message-ID: <20241122035922.3321100-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122035922.3321100-1-andrii@kernel.org>
References: <20241122035922.3321100-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the point where find_active_uprobe_rcu() is used we know that VMA in
question has triggered software breakpoint, so we don't need to validate
vma->vm_flags. Keep only vma->vm_file NULL check.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a76ddc5fc982..c4da8f741f3a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2305,7 +2305,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-		if (valid_vma(vma, false)) {
+		if (vma->vm_file) {
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-- 
2.43.5


