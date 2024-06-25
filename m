Return-Path: <bpf+bounces-32973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDE4915AF8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421EC1F2243D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A02946F;
	Tue, 25 Jun 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqlEKFTt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C78BE0;
	Tue, 25 Jun 2024 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274948; cv=none; b=mSZZRF7XTJrud/bgF2wXnSoy234lWsDc44/D5uwiRRFfRG9zxHD0AfNNWPBdZ9HhHCRdG/ztIn2NQrHQh+95zDuCJNhqzGgZAZx30HBmDAnFdREZDvrbwtoR1gdfiZMN3J6HGVYSW+nIndF7Vz4QgEtI+QjiFXTerh5Zke59AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274948; c=relaxed/simple;
	bh=IK9qe93lUTxLehfjnp9sFnXM2BOwnNpa1pCnJf9613Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FebqwssmrwVYSd74dj7NP0wsAQdJIWRyPHmNmCMb9rCJBvy+5b+/RyHdjsJ1EOI2+5jGcmyO/wuj/YKBBojQHu60BiFGje7M3Q6ScCFmwd4p5gqa3yGdWmHJX2w5jY/Q9z59QiL9FJa8LdQQU98kNIF1CSOctjEPvyNSfcuiQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqlEKFTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA94C2BBFC;
	Tue, 25 Jun 2024 00:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274947;
	bh=IK9qe93lUTxLehfjnp9sFnXM2BOwnNpa1pCnJf9613Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqlEKFTthFSKD2aQWden0fp76ZQQCIvn2/uuCHUc4lFowjSg+lyt6f/3Huea4XS7B
	 O8zSZu0s0SMbJnLE1i5EFioJ+ZMsbf62zm/kM0gvt7f/SgClopqjw0zpxSTZwDmIn3
	 wPC45YK/DsGwb1LRThXYgmOhiKg5X47tu7KNNfGJ+B6zgCcv2SdLWu2wcKWZdanPwo
	 RNpxGu/CKeMfMa5OV9yr7qzksoyu8bEOAPgoNdIcCabWYbcE1Ujpt8LpzbvTjrgyTD
	 orQm5oA99mxxVtvK902rAXyLLWnbXuVPMLYBAvTwYVM60UNLyV6bh43YKH62diiT7U
	 lTMjHK8BTAeJw==
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
Subject: [PATCH 11/12] uprobes,bpf: switch to batch uprobe APIs for BPF multi-uprobes
Date: Mon, 24 Jun 2024 17:21:43 -0700
Message-ID: <20240625002144.3485799-12-andrii@kernel.org>
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

Switch internals of BPF multi-uprobes to batched version of uprobe
registration and unregistration APIs.

This also simplifies BPF clean up code a bit thanks to all-or-nothing
guarantee of uprobes_register_batch().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ba62baec3152..41bf6736c542 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3173,14 +3173,11 @@ struct bpf_uprobe_multi_run_ctx {
 	struct bpf_uprobe *uprobe;
 };
 
-static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
-				  u32 cnt)
+static struct uprobe_consumer *umulti_link_get_uprobe_consumer(size_t idx, void *ctx)
 {
-	u32 i;
+	struct bpf_uprobe_multi_link *link = ctx;
 
-	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), &uprobes[i].consumer);
-	}
+	return &link->uprobes[idx].consumer;
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
@@ -3188,7 +3185,8 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	uprobe_unregister_batch(d_real_inode(umulti_link->path.dentry), umulti_link->cnt,
+				umulti_link_get_uprobe_consumer, umulti_link);
 	if (umulti_link->task)
 		put_task_struct(umulti_link->task);
 	path_put(&umulti_link->path);
@@ -3474,13 +3472,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);
 
-	for (i = 0; i < cnt; i++) {
-		err = uprobe_register(d_real_inode(link->path.dentry), &uprobes[i].consumer);
-		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
-			goto error_free;
-		}
-	}
+	err = uprobe_register_batch(d_real_inode(link->path.dentry), cnt,
+				    umulti_link_get_uprobe_consumer, link);
+	if (err)
+		goto error_free;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-- 
2.43.0


