Return-Path: <bpf+bounces-41644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F268999402
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17E91F243B5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DD1E5732;
	Thu, 10 Oct 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdE/XF1b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49741E260D;
	Thu, 10 Oct 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593817; cv=none; b=AnGj4l/G0B1288kZArbWXlL1gk1IMfchLeTg9c0cMQ7khX48pIxm6R6kAa56D7s52Uteo/30u3ViMkS9dnST9Qrj5GntMNos1IwRVMn7gIKgGvsjobTQCCJG9xf9tvo4ck/0YeVCRUlwncNaeRSRHLGj7UP6VvLsC9z5eJxFr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593817; c=relaxed/simple;
	bh=R2MF70Qe5RyiJ7bapva+CdTRJ3ORlm3QRnJgpBNcwdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvL7njcgnEMrU9Os9ym4gJJV/NkJ3ZDuvKY9qIpmT4BV6TQe9umjhPzoEQR+yXRvkpBjKkZFHQxKbfPNQ2n5GeyuV22oHcAg1IVK1FO9oNEgV3NvLReM6RYNHaQ56g8gCrsNwuIVqHiCBi9GQuOarZreslaK2gqpXJkqYPjHp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdE/XF1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F7FC4CEC5;
	Thu, 10 Oct 2024 20:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728593817;
	bh=R2MF70Qe5RyiJ7bapva+CdTRJ3ORlm3QRnJgpBNcwdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdE/XF1bptJss+RjCSwJXgar0qqj6hZ1g1s6lERBGX2VMmD6i1AXUd2ErsiARXGNW
	 YRD21MpcXIx2VN8huDFgvMAkI2ywlHm1TLyrzAqmANnFxbUj513wQorX4kzCCbnNRF
	 GA4pK3Mwa3/NB+GEQOQe8KCIJK85CcSZMGYtSaHpdZWuYJ7DbHT9VKA9XLmfNXtAXz
	 BM2DzYEHyr6b1/yP6r6vqwCwOgdbFLq3QZ+VYIPzk4x+4WVdjutVExOVZR/DO9yjpN
	 lyRpste/timi9kH9OupllEhR2R79MWCKf6hny5yBMJ2rsl4aUU6KtsLlmgq+io3mO2
	 gOytO7LwqRWfA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	akpm@linux-foundation.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 tip/perf/core 3/4] uprobes: simplify find_active_uprobe_rcu() VMA checks
Date: Thu, 10 Oct 2024 13:56:43 -0700
Message-ID: <20241010205644.3831427-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010205644.3831427-1-andrii@kernel.org>
References: <20241010205644.3831427-1-andrii@kernel.org>
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
index 2a0059464383..fa1024aad6c4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2057,7 +2057,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-		if (valid_vma(vma, false)) {
+		if (vma->vm_file) {
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-- 
2.43.5


