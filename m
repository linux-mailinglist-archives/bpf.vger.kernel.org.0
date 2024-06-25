Return-Path: <bpf+bounces-32970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E54915AF5
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539D5B21F5B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FC8BE0;
	Tue, 25 Jun 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQT0g131"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451E610D;
	Tue, 25 Jun 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274938; cv=none; b=H4rReJJBG2c9HEnA1JCaK8prAV3/+F2HQArDrBBOlLuE05PIaetiBe/9AKvzRIL0AZ6v6h15d+aO9T6YH/Wia7sCeiBQhUftG8V2hbDkuO6xmBOUS2hJN+WJJwaEXlJOdkJ4/3JPbsx2nW9UeDLGg4o/Kg3eJMBVl1Io/CeKJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274938; c=relaxed/simple;
	bh=ZE5Rg1IvRUne51x35jdHocC3swc9HOGBUqvmZi3cCvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouY6WttmBDwQIZhJkUziw61PvTretQuNKBaHnpH1i0MGal9eZcZR5tTctBhgcQWvtZ8g+WxphnNB89CuhIo6GWUXYU3MIRMJXoPZ4MXF48L+LnBZLDmwJz6bvHRYLYIpAw9QM5kcPhSsROwZGTkU0UwO+dLFgHmeeFUjIDLKoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQT0g131; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA7C2BBFC;
	Tue, 25 Jun 2024 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274938;
	bh=ZE5Rg1IvRUne51x35jdHocC3swc9HOGBUqvmZi3cCvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQT0g131q2A+JPm+NlrDNa250C+SMbhhTxkdHuT1iSivFxGpcCbWkNp39Oy/0WNsv
	 6f+WIrN+PajC3SP/lafEKU6DCCzxWnWej4XUAbwlMY7m/C2toUtVAHcG8Kfv7zwC0e
	 qXSRtyBAcbgKfA3V6UPt3ynWpR6VJDwMwk0ZQ6paSZhCMeOexiiAZW/zBfhfoL+QP8
	 kT9cAhNbs6Gbd1YTCpzitTAKUuYhvyTMn1g+za5fOMLvjIi1xZlJkzQhGoiH+qMKgK
	 sZ0cX3BjV9VJ6F+ONWo941tjxaFEFO4dFzWptzyreBz40H6zVkDbXSPcUGeWrhJW/t
	 9jzHPAxRsXD9Q==
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
Subject: [PATCH 08/12] uprobes: split uprobe allocation and uprobes_tree insertion steps
Date: Mon, 24 Jun 2024 17:21:40 -0700
Message-ID: <20240625002144.3485799-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625002144.3485799-1-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ebd8511b6eb2..5e98e179d47d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1270,9 +1270,8 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 			return -EINVAL;
 	}
 
+	/* pre-allocate new uprobe instances */
 	for (i = 0; i < cnt; i++) {
-		struct uprobe *cur_uprobe;
-
 		uc = get_uprobe_consumer(i, ctx);
 
 		uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
@@ -1289,6 +1288,15 @@ int uprobe_register_batch(struct inode *inode, int cnt,
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
@@ -1296,15 +1304,12 @@ int uprobe_register_batch(struct inode *inode, int cnt,
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
@@ -1318,10 +1323,8 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 			__uprobe_unregister(uprobe, uc);
 		up_write(&uprobe->register_rwsem);
 
-		if (ret) {
-			put_uprobe(uprobe);
+		if (ret)
 			goto cleanup_unreg;
-		}
 	}
 
 	return 0;
-- 
2.43.0


