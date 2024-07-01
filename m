Return-Path: <bpf+bounces-33547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB991EAE5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB6282D9F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF669171E5A;
	Mon,  1 Jul 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3SASqiX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44117164D;
	Mon,  1 Jul 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873602; cv=none; b=qjp+YDTAYblzgBY4oUxGK0KBkf09LzeOXeOgOO8sXnf0IDLc3MqqCAso76hwQOu+vRHVjscx3eefWPbzDcyxXIaUbdyL+A/gIifZ/gi/2tLD7tAjLIkYFrW7weIrEtTdyw3e1i0ehiL9nE41yKWRn7OpOoiAxVH7B4jTXl0xX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873602; c=relaxed/simple;
	bh=hsAPiWhq0aZiIPV7Z6KG9ozuzn7aBv3ssNJ6TuKJH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgPrCotRdp1rWRZEJE0VJ6YKe6bTNdJ5qYZ+5EqM+oZZbkvZ6zJmsTujOf2VkxVu1ln0nwv2yfwH/yKWHuyEKl0rv6Bsm68QtnGA6uKNSlMSRLxZ/bY5jypFFYL6anJ7kmMunWBm9nnA1+i8CnecaY4g57zLwVf/VRnkzzGC8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3SASqiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED801C116B1;
	Mon,  1 Jul 2024 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873602;
	bh=hsAPiWhq0aZiIPV7Z6KG9ozuzn7aBv3ssNJ6TuKJH1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3SASqiXCuy/edJgsrqgcMsCiuP41G+0Vmb7I3ZGjGXsPa1Zzux6GFWz/AIWfOXtC
	 wV0UKbZcGUqDFQ1AYiN6YdYCEfxExZySqXNqH+YiSR4XfGTbvWy3AumQ7hlbHCqUZk
	 juHn7DFMVgd0Kq0WdvnsZxWMdQFMDuIBRwtCJqj8e6CROXpQce41JqbASprcj7ONPA
	 19fphjp2sQe/CC9Pge3ULorApum0tDB14Ij6cIoSXMgtW5e6gFn6Oc1GaHRrwAxxHY
	 8IoEZi8Ik5GGoE5zR0KlFpm+YRQ1okDJkIUZweTZtkybqT5Mb7u2duaZeN2gxEDJGs
	 B0ciw+EKJKlDw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 07/12] uprobes: inline alloc_uprobe() logic into __uprobe_register()
Date: Mon,  1 Jul 2024 15:39:30 -0700
Message-ID: <20240701223935.3783951-8-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow unbundling alloc-uprobe-and-insert step which is currently
tightly coupled, inline alloc_uprobe() logic into
uprobe_register_batch() loop. It's called from one place, so we don't
really lose much in terms of maintainability.

No functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 65 ++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 68fdf1b8e4bf..0f928a72a658 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -869,40 +869,6 @@ ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
 		(unsigned long long) uprobe->ref_ctr_offset);
 }
 
-static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
-				   loff_t ref_ctr_offset)
-{
-	struct uprobe *uprobe, *cur_uprobe;
-
-	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
-	if (!uprobe)
-		return ERR_PTR(-ENOMEM);
-
-	uprobe->inode = inode;
-	uprobe->offset = offset;
-	uprobe->ref_ctr_offset = ref_ctr_offset;
-	init_rwsem(&uprobe->register_rwsem);
-	init_rwsem(&uprobe->consumer_rwsem);
-	RB_CLEAR_NODE(&uprobe->rb_node);
-	atomic64_set(&uprobe->ref, 1);
-
-	/* add to uprobes_tree, sorted on inode:offset */
-	cur_uprobe = insert_uprobe(uprobe);
-	/* a uprobe exists for this inode:offset combination */
-	if (cur_uprobe != uprobe) {
-		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
-			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
-			put_uprobe(cur_uprobe);
-			kfree(uprobe);
-			return ERR_PTR(-EINVAL);
-		}
-		kfree(uprobe);
-		uprobe = cur_uprobe;
-	}
-
-	return uprobe;
-}
-
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
@@ -1332,14 +1298,39 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 
 	for (i = 0; i < cnt; i++) {
+		struct uprobe *cur_uprobe;
+
 		uc = get_uprobe_consumer(i, ctx);
 
-		uprobe = alloc_uprobe(inode, uc->offset, uc->ref_ctr_offset);
-		if (IS_ERR(uprobe)) {
-			ret = PTR_ERR(uprobe);
+		uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
+		if (!uprobe) {
+			ret = -ENOMEM;
 			goto cleanup_uprobes;
 		}
 
+		uprobe->inode = inode;
+		uprobe->offset = uc->offset;
+		uprobe->ref_ctr_offset = uc->ref_ctr_offset;
+		init_rwsem(&uprobe->register_rwsem);
+		init_rwsem(&uprobe->consumer_rwsem);
+		RB_CLEAR_NODE(&uprobe->rb_node);
+		atomic64_set(&uprobe->ref, 1);
+
+		/* add to uprobes_tree, sorted on inode:offset */
+		cur_uprobe = insert_uprobe(uprobe);
+		/* a uprobe exists for this inode:offset combination */
+		if (cur_uprobe != uprobe) {
+			if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+				ref_ctr_mismatch_warn(cur_uprobe, uprobe);
+				put_uprobe(cur_uprobe);
+				kfree(uprobe);
+				ret = -EINVAL;
+				goto cleanup_uprobes;
+			}
+			kfree(uprobe);
+			uprobe = cur_uprobe;
+		}
+
 		uc->uprobe = uprobe;
 	}
 
-- 
2.43.0


