Return-Path: <bpf+bounces-32969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE4915AF4
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B96B1C2167B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320B8F6B;
	Tue, 25 Jun 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otc9NBJ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6E79DC;
	Tue, 25 Jun 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274935; cv=none; b=DWdVsdmc/qOcUh60cySwKNjjky+4twlG23RR+DtbBpXdKtBrfBz/DQBuFq5R96ku8hFgkkwbw/7qeeN8t7P7wwJ2TdTmQacUwT1KChywOEtwmGspAapqyanc1HSMXTp/PQ02ni/kPMHuyvl5/+qPE7LpqA4WVPPfMjAt6dyshYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274935; c=relaxed/simple;
	bh=yuCF/nUI8l84jyOZCB9PLpyuOLEZfVWgfyp2W2ZgeZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNSXJEEUWf0Vxj0+CFzpDki1s8kQ2vIEJktJ3T70c0eGvhKV/uiiWF1cdRKtww3MQPiefDaGfPdZrbohGRIcyx4BBca9ZFy8avJe7+0upKegDcW9pfgwd3tVlDhStbTEs98bMWoTPom1pDoVz59IfKtMOWTOuosv/WgtU/yaxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otc9NBJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3785C2BBFC;
	Tue, 25 Jun 2024 00:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274935;
	bh=yuCF/nUI8l84jyOZCB9PLpyuOLEZfVWgfyp2W2ZgeZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Otc9NBJ/Ik6U+x8dlW5GZ41cYOQOutQXSAFEv0iiMS96uH3egqlJuRVuvdraomtQm
	 Fe8zo+Hwf6PL+q7ccn2WAwZYGyT8iZE/O9sKqBe4AlbLeM7ubl8Hm9Ur7ExjQR2x/x
	 I2chRfa41LqJS5d+JuH0f42+0FD+i4lq0l68326V9NMbZ9Ts4MBQxbKCipd8YxHtZd
	 O31IF1rJlMlVDJ1WuKr2AYeon8GZlnGt/kq8+BcGO/55VtOcR4dINSq1tsD6qSiNjw
	 xxa0jnXS2gB8N61eYWWaKohdoZaaa+qBSigwjzSwHuhget2akWJrEzmOfC/mazaBRJ
	 j/DC2A8zhDrvA==
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
Subject: [PATCH 07/12] uprobes: inline alloc_uprobe() logic into __uprobe_register()
Date: Mon, 24 Jun 2024 17:21:39 -0700
Message-ID: <20240625002144.3485799-8-andrii@kernel.org>
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
index 846efda614cb..ebd8511b6eb2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -842,40 +842,6 @@ ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
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
@@ -1305,14 +1271,39 @@ int uprobe_register_batch(struct inode *inode, int cnt,
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


