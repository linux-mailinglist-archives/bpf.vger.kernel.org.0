Return-Path: <bpf+bounces-33548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9A91EAE6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A7D1F228BC
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C039171E57;
	Mon,  1 Jul 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE6aRMyF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275B17164D;
	Mon,  1 Jul 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873605; cv=none; b=U/lzMF2e8Tx2DX2ob5eb7gLy7I+LcBqvJqvgnKTDo/CgpBd+eOZAEHsQS9g99h2s3ZoRPtnD8ZopA0eulegFiAg0SucEb2EbHpSKAGUzuhBmVOO5uUnxQqJO4dSF1CIeG/eGRm80wTvVO0mC3ML7X8BhCVBYz70azRtGz/oIGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873605; c=relaxed/simple;
	bh=2ujlAJwBRdM6eCA+Xbj6B9HXFPf+fftjjvITuvUEy1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiAaDgHidYl8Yl8bfwkuJNfKIf29HZnaXk7RXsmqr/CSuI63IaEOf6UE4dNIjcOKFWDOmh9+AwFF6l54Qiv0d5T2OKgTdIIUjfQaqsi8FV/qbr/J4e/wSPOkeV+lRjpeuNNpJokl9n+K5ynsREGqTvHPTBJSiVzhQYGYQZk2ncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE6aRMyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD7C116B1;
	Mon,  1 Jul 2024 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873605;
	bh=2ujlAJwBRdM6eCA+Xbj6B9HXFPf+fftjjvITuvUEy1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE6aRMyF0AEJdkPGjx6o6KZGUCeYd9WFCRbmZK0YFUrI4GAYmE/bIE5ACdb6SZa0w
	 fm5RPLzxST51cMpq86NKznXHvFb0toE92DVYANktLeaPzYHgOsM/16OhKs+jA+1WQg
	 cmlh6RmFOCApRcLX6kdMDQDVSS8p5nUBebKFcvslPbBVBIV47HJKWyN8ibqB5YnjZV
	 9lh0LCV1ZlE2eRfJcseNlPOXgKtGBhI/QiuSConqLHKHNrlFvlC5afkzOXFdEAlKyk
	 RNJs6ojQs1xtLJHSUqGSyT/mXhr5ntO3P8+Ggq5QIsKfaFx7q/ds+rRFsEP/2fIJYQ
	 CwrAW1RdpYWPw==
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
Subject: [PATCH v2 08/12] uprobes: split uprobe allocation and uprobes_tree insertion steps
Date: Mon,  1 Jul 2024 15:39:31 -0700
Message-ID: <20240701223935.3783951-9-andrii@kernel.org>
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

Now we are ready to split alloc-and-insert coupled step into two
separate phases.

First, we allocate and prepare all potentially-to-be-inserted uprobe
instances, assuming corresponding uprobes are not yet in uprobes_tree.
This is needed so that we don't do memory allocations under
uprobes_treelock (once we batch locking for each step).

Second, we insert new uprobes or reuse already existing ones into
uprobes_tree. Any uprobe that turned out to be not necessary is
immediately freed, as there are no other references to it.

This concludes preparations that make uprobes_register_batch() ready to
batch and optimize locking per each phase.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0f928a72a658..128677ffe662 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1297,9 +1297,8 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 			return -EINVAL;
 	}
 
+	/* pre-allocate new uprobe instances */
 	for (i = 0; i < cnt; i++) {
-		struct uprobe *cur_uprobe;
-
 		uc = get_uprobe_consumer(i, ctx);
 
 		uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
@@ -1316,6 +1315,15 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		RB_CLEAR_NODE(&uprobe->rb_node);
 		atomic64_set(&uprobe->ref, 1);
 
+		uc->uprobe = uprobe;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct uprobe *cur_uprobe;
+
+		uc = get_uprobe_consumer(i, ctx);
+		uprobe = uc->uprobe;
+
 		/* add to uprobes_tree, sorted on inode:offset */
 		cur_uprobe = insert_uprobe(uprobe);
 		/* a uprobe exists for this inode:offset combination */
@@ -1323,15 +1331,12 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 			if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
 				ref_ctr_mismatch_warn(cur_uprobe, uprobe);
 				put_uprobe(cur_uprobe);
-				kfree(uprobe);
 				ret = -EINVAL;
 				goto cleanup_uprobes;
 			}
 			kfree(uprobe);
-			uprobe = cur_uprobe;
+			uc->uprobe = cur_uprobe;
 		}
-
-		uc->uprobe = uprobe;
 	}
 
 	for (i = 0; i < cnt; i++) {
-- 
2.43.0


