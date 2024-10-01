Return-Path: <bpf+bounces-40723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6698C869
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A394A1C23073
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12761CF7D3;
	Tue,  1 Oct 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsSJ/T3H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF861CF7CB;
	Tue,  1 Oct 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823149; cv=none; b=ioBhYR/DFEf85+HaaHO79QfAu322RN4ntjjxNFL3BxQ2+sdiGXBsZv6d8w1IxjT87RGpA15O8Wy8IFhYwmOWyHFqktz0K0GpEG2rwjPIWV9zPPvAYvczLbXXcxFkJ94nSDghpX2N10gtDwixcPFdSMRivXQ5Hxn6s7SbVTaJI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823149; c=relaxed/simple;
	bh=bBBk1ELWuu6s2YRaDtSMqIlSwNWabgjEjVeq3ZwLyBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsCfGf6fn9GJt3y2zIKTA02ESEmzhX5XblxVDAwVcBb1QHfMjIdPsR93t2bDKIKp4g/1/9HF+nmzSgSDo9lZS8kuGPPZW5y3sRhWfw46Bv5tJxYcKHaf++AQR3H8Mpn5v7GR6GRgAy2Tf57XG8saDvjRh06romb7ezF2B5bpxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsSJ/T3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE9C4CECF;
	Tue,  1 Oct 2024 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823148;
	bh=bBBk1ELWuu6s2YRaDtSMqIlSwNWabgjEjVeq3ZwLyBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsSJ/T3HGEBenk4eNetFCKTWXI2642nBJifJ82B76LRpDRtOh+ZzBzGw2Gb/PimJy
	 bUZ2Lfc9akr6eHVKSP5YmLBmyqxkQX+pIAh5EfBsiEs5u39K+IlG9YW7tdVlkyBWL6
	 AyfUg43cU/BbCV1VC5JOMxMmjh/EZ0IxlkzCkC1hoTt0RZZDKQ81ohEp5PbbC6F8n0
	 +uxYFbtYUGU8lxV0rqy6wzypxN7UiNcOC2tiCjhKpiCxpUYB2B6LXIe1rR9vB7tc5C
	 4hQtfKOCD2wiUeMIDzUZwD9u9dkClabmwxiNtcMhBkfvmv9wsO+fRK1+AXpUo5AJlv
	 cwmrHDrk2xpjg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	mingo@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 tip/perf/core 4/5] uprobes: simplify find_active_uprobe_rcu() VMA checks
Date: Tue,  1 Oct 2024 15:52:06 -0700
Message-ID: <20241001225207.2215639-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001225207.2215639-1-andrii@kernel.org>
References: <20241001225207.2215639-1-andrii@kernel.org>
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

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a2e6a57f79f2..7bd9111b4e8b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2091,7 +2091,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-		if (valid_vma(vma, false)) {
+		if (vma->vm_file) {
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-- 
2.43.5


