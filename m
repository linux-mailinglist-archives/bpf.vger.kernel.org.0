Return-Path: <bpf+bounces-33550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172591EAE8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2371EB21D1E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B1171E60;
	Mon,  1 Jul 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6jaOLsx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353A171E52;
	Mon,  1 Jul 2024 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873612; cv=none; b=pxcdS+9QAPtGk3eYguT+ibOnTiiDkzCFMvdsFBe57R0hoAXw/oezxmUdWFhALC8bA3o0FCWHnHbwV2u4w2394pBb/pcmTm97dsZXC0SgeFmSjV/PjI2mB/+JGLIU/+lBG887qMVEPe57xUhK9dtU1pgG6ooxNcDznQJNyfZ5FlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873612; c=relaxed/simple;
	bh=nWdyuSJceB+cMJxxTIMLYKHDpdzI6rYwtLA5cH3gtRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3iIxaqRYuD6GC7+h3rEltnBpKXlIvdwWbnaAX0m7BpHDmQNhYxyvbQDOs3istIUAahA8u8ZHx7DlbPRUTx/Ml5aYd5k3BjpvtMmhrLNv4unjQpf9Pez7LzpTv5yHJhc0HCRU58dIw/ci3PIsOxnioI7IjJNb4FmX5yHEzaLFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6jaOLsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4852C116B1;
	Mon,  1 Jul 2024 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873611;
	bh=nWdyuSJceB+cMJxxTIMLYKHDpdzI6rYwtLA5cH3gtRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6jaOLsxN5U0Y+gj9bs8Ft+6FoW2nNpL2Oyfq/sb86jkBlZ+BPiJdBTUYYjNR9+5l
	 nuUMxLi0224fJ+KiA9QFyqs7l4NmOiqykAnOiYipVYI30Jeqfu2RHcUyS1VUczv46R
	 3nYsA+PHSFSFfEYtyDdvYn1wzP0s3/1bDbkerctVPbwFI+y1aN9MTZ0Vjz7txaC6Vz
	 BvHQdrJ9kwYvupfg5v1ISNzZySE1M+wY0w9NROtE0DQLCM1LQ53XoQ+Sgv4HQrUZI7
	 pNlayIBrXv96T0BCecBuEETlKETeCgm3wtTVUMODHynvMzzhn7AOtS6ST3KBGVE8Vw
	 WA1X+qXx3Gv4w==
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
Subject: [PATCH v2 10/12] uprobes: improve lock batching for uprobe_unregister_batch
Date: Mon,  1 Jul 2024 15:39:33 -0700
Message-ID: <20240701223935.3783951-11-andrii@kernel.org>
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

Similarly to what we did for uprobes_register_batch(), split
uprobe_unregister_batch() into two separate phases with different
locking needs.

First, all the VMA unregistration is performed while holding
a per-uprobe register_rwsem.

Then, we take a batched uprobes_treelock once to __put_uprobe() for all
uprobe_consumers. That uprobe_consumer->uprobe field is really handy in
helping with this.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ced85284bbf4..bb480a2400e1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1189,8 +1189,8 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn get_uprobe_consumer, void *ctx)
 {
-	struct uprobe *uprobe;
 	struct uprobe_consumer *uc;
+	struct uprobe *uprobe;
 	int i;
 
 	for (i = 0; i < cnt; i++) {
@@ -1203,10 +1203,20 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
 		down_write(&uprobe->register_rwsem);
 		__uprobe_unregister(uprobe, uc);
 		up_write(&uprobe->register_rwsem);
-		put_uprobe(uprobe);
+	}
 
+	write_lock(&uprobes_treelock);
+	for (i = 0; i < cnt; i++) {
+		uc = get_uprobe_consumer(i, ctx);
+		uprobe = uc->uprobe;
+
+		if (!uprobe)
+			continue;
+
+		__put_uprobe(uprobe, true);
 		uc->uprobe = NULL;
 	}
+	write_unlock(&uprobes_treelock);
 }
 
 static struct uprobe_consumer *uprobe_consumer_identity(size_t idx, void *ctx)
-- 
2.43.0


