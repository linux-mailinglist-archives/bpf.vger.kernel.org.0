Return-Path: <bpf+bounces-33551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D00291EAE9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451B0282F1B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E6171079;
	Mon,  1 Jul 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFfl0YwF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413117164D;
	Mon,  1 Jul 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873615; cv=none; b=XNM5a4yr7LVqWtfsxYKyz1RLb1NICDG0aDhxomAAGqZCc5AJ9Sajua/ifpLQp9HwffoszIuDIfCzUIGM1mdrBJ6WEgg/NRw9tWb+3uNEQKPYGathfj4USmIjnwLSQLynt+7/Q01qGm/5xWAMWHWWy9pw27RjEdysHBwQmkc3eNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873615; c=relaxed/simple;
	bh=IK9qe93lUTxLehfjnp9sFnXM2BOwnNpa1pCnJf9613Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbhM+/R4Ee2Abl0y4LNuxONDfMPe9XdSJ5HH0wJJfxfOe/dCib6bQUYUwmXrNKJHIFQD8eodGnV2oxbRumt7DUdSNF49h7jmaZZK7rHwnhNpNDfvLz5Bcuty+1B9MmrWsSRTfXYf98ETmT6eYu6wXrId50uuf5BxbbDjQm7VQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFfl0YwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09CBC116B1;
	Mon,  1 Jul 2024 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873615;
	bh=IK9qe93lUTxLehfjnp9sFnXM2BOwnNpa1pCnJf9613Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFfl0YwFhJR32scFBXnOyUwRUiu6+dryL+yzYVBcK5tGFCJsbt2wPw1AmN8CuQPVn
	 7Co+hA7kkHx6geJ2YUm215SoS2xDWRkyTmq9/Lh80OGuE6II9+ysW05wgQPnNWtocS
	 CW1dokQ5gfbGuxgcUJRzxcxf/lnt4Q2237lmAsSYdikXpT3BdlrFg3oXbcx9N93jRP
	 zP03WdovzXAIbp/3DLnjgJux7L5g9mz4UhT5LWSZ2WxVDhmmALLXmdr0/y/jlM+O9b
	 167lgx3Hk0DXGlU9BafuL2ypHS/KELQ2pUS9SCmMUy8sJ2xMpIusQztJe8YBtops5s
	 55q2pWeuyiulg==
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
Subject: [PATCH v2 11/12] uprobes,bpf: switch to batch uprobe APIs for BPF multi-uprobes
Date: Mon,  1 Jul 2024 15:39:34 -0700
Message-ID: <20240701223935.3783951-12-andrii@kernel.org>
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


