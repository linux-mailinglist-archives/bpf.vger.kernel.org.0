Return-Path: <bpf+bounces-43263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D275C9B21D6
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4AA28144C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F418593B;
	Mon, 28 Oct 2024 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHZTZEzL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96813774D;
	Mon, 28 Oct 2024 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077756; cv=none; b=j6enUoQK9H9/JtfjkXqrYkdOmKmmBsaijjRWkyYVsA+6RNQsGuIlYNmyMCoi+jgbTegILSUuoNxeVDw/fZxdNGbR+BUfMmrFxDG/e2ikBxnEr3hSn71clk6ZHCMEFAzc1QnTTd3nj+XqtBcEKw7yoPl4J/xG+YncriQOcd9+XFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077756; c=relaxed/simple;
	bh=d0t2KdzFB54YqijRSkN8zgCUkKArImLR1/o5M57T+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+wS2PZC5m2f6aebL9t0Le2ItNtN47Lm19IMVYA/Ee+M7YY1G02TagxQmNiZYz3NawcG9LT3uucNrpI0E1pMt2Nqe2b4D6PQ8l3tLCyfuI6JXq/96ibuOjxlrEVPM0uVaC9KBeRW7ZqY6SqBi006ymUPKEdoCy/QG129HgEZDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHZTZEzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52B2C4CEC3;
	Mon, 28 Oct 2024 01:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730077755;
	bh=d0t2KdzFB54YqijRSkN8zgCUkKArImLR1/o5M57T+Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHZTZEzLr1iL3FHbaDuT4QMbEbbJCKfdJHak1Cphw3Io7OVy4N+9xviZFpn66aI1f
	 PlJOkge1nFNeUdTsUnrOMPN1hqSeV1o0gMm9Lg/U2BhrunABIRUiRijxF0F2+CkU8d
	 v58avLtFpLU/wQJTBPSWS4XGJpq96/WS8igjo7MUUUodF4yAQ3kroN4bJHsKngkHlT
	 l8xJpHr70NPY6NK78bXQv05YYUiquo6oYCTtSTdJKylBEBOTHst9WNjrRy8s45NIDO
	 bgUj7V6k42jCxv/1X9EWh7uooH0Cih40WwIP7W2TzNwQMR6cvih5Yu9jll42E3zSyv
	 TwSiGKYcMRJ4g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org
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
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 tip/perf/core 3/4] uprobes: simplify find_active_uprobe_rcu() VMA checks
Date: Sun, 27 Oct 2024 18:08:17 -0700
Message-ID: <20241028010818.2487581-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241028010818.2487581-1-andrii@kernel.org>
References: <20241028010818.2487581-1-andrii@kernel.org>
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

Acked-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4ef4b51776eb..290c445768fa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2084,7 +2084,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-		if (valid_vma(vma, false)) {
+		if (vma->vm_file) {
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-- 
2.43.5


