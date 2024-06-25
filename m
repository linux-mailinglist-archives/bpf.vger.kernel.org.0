Return-Path: <bpf+bounces-32972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69591915AF7
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFD1B210A0
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523248F54;
	Tue, 25 Jun 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUU5UpTw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8875610D;
	Tue, 25 Jun 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274944; cv=none; b=I9qEQpQ7YFK/mrHS9pmytlq14rItQuxT70jCPa+FIIEcP/GkbaLTuHQtrUPejEJb4JMprCxOO1O31nNdXeHWix6PoEyYAGayRbz1lCfaOk9+BdyDwJJwptZxgdt2WL0b+8iWv1aHk/0Ph+8BwL1MfZDK3CzKtHV4RYdiZ63/K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274944; c=relaxed/simple;
	bh=q4qr05ioeVqwQBhfkfKyRsix4NeNxsBCV+tYl5QrVRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo6CTEeApuArUIpbVcFTEa3wntQE2EzDv1/wGHcvVQIcKewBuF/TY+jbLJX/fA7EncTa1jP8yGs8JCz8K+oJ5Yv7eBSBiq+XCIgPPg09pIaPFRCT/jp6+YZ43wB0i2gctpakYtNTu/qmG9sij3mhmJRr2HzpY1H4qqf5H5zK8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUU5UpTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D3C2BBFC;
	Tue, 25 Jun 2024 00:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274944;
	bh=q4qr05ioeVqwQBhfkfKyRsix4NeNxsBCV+tYl5QrVRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUU5UpTw+MFTTNNq/+ae9h1iVQN33dOKIB6vbIJxr3owFUUQ8X3jXuB9P0DgLJc7M
	 iHPjhohAkTGgxE9U4h3C26ALujbqj8aImOAizvXewYlS5Z9BILqAzJeRrU5pZb/23D
	 ZhwOHyDTPDPyg7IKK4PmtvO5dakGS2HtvcFmoCxOCsDB+tqaN1tv4jQshyLM7Su9l6
	 KCaujiKpx+GC8qw0WuP3kI3SpRriAI7PLsQLPL+Yy/mdHVvAEPWnZE0l5IDSFg88vr
	 kwcnkzfMBIpfrANBJwSBKfEj6Jp4rE1tj8se0tqJSly7DknfMPOuQCyahXHaKVAUVB
	 vabM6QhbI3CWQ==
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
Subject: [PATCH 10/12] uprobes: improve lock batching for uprobe_unregister_batch
Date: Mon, 24 Jun 2024 17:21:42 -0700
Message-ID: <20240625002144.3485799-11-andrii@kernel.org>
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
index 416f408cbed9..7e94671a672a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1162,8 +1162,8 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn get_uprobe_consumer, void *ctx)
 {
-	struct uprobe *uprobe;
 	struct uprobe_consumer *uc;
+	struct uprobe *uprobe;
 	int i;
 
 	for (i = 0; i < cnt; i++) {
@@ -1176,10 +1176,20 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
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


