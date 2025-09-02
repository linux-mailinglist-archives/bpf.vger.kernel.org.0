Return-Path: <bpf+bounces-67183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F7B40710
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3855439D7
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BA3128A6;
	Tue,  2 Sep 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFlSDziQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868E309DB5;
	Tue,  2 Sep 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823726; cv=none; b=mmJJSOuLqBR3mi5t2BAhLKXrFOZEqg6pzsXgeTS+mYXg9EtWyKa55lxq+uAltvFvGJejomYL5K1RZHj/SRFVi8gIDEZsBMagYFvdA13jh+0V3z82Uk0LzsH4qT37DvupoETRvV2VIghpdU3r5iH+uEzoEIBOgA+g9KWTSYP1Q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823726; c=relaxed/simple;
	bh=tDmYNAmIv1AO38nKYIGGnLwjJ4+wCAxin6PUU3wtmPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSTmGBVlnhku8+sBGaoCTnKkJk9jhl14Exc28A8YwdhSF6iNTmawnPhePd3wKqY4VdKW5iqSkzAJY8zoK1xPyILVSOpYaBl7fxMuKC9D9S7O2oRwAeGddTZVtJHkF4fr7D5Y4WqmOXxBkyC2XUKhahOdJK+TBnxinD308JteDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFlSDziQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E478C4CEED;
	Tue,  2 Sep 2025 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823726;
	bh=tDmYNAmIv1AO38nKYIGGnLwjJ4+wCAxin6PUU3wtmPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFlSDziQfQjciFA3+labMmTVTZOcmG2QAcSZNF+zyid4HQIDg4rj2+MLWOS3US1xS
	 VK6PVezRNlO8d6SJfrYY8n5GFmT7KRk5pskHfXrqZRT8YayKqIUXH6I1FUnJ7SQsCm
	 NfEZa6ZJX6F0UIXO4gwTZOHxzQpY+PYUhXWc6QU0gA7M+JmgqAoTjmvwUlgkIo3wiW
	 KdU67JG8Y+uT8YqtgHEryoynGf/Z2TxzJojXN+Zu1neRCBT49iKZk9p7T3AFjxp5wc
	 8lctWLh4ysbfj3hTJKQVz+8gu4fBNS2KDkdej6334+8cLfvW7Iq9+kCvmMSVI/dRqN
	 1qCNa2XZjtgsQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 01/11] uprobes: Add unique flag to uprobe consumer
Date: Tue,  2 Sep 2025 16:34:54 +0200
Message-ID: <20250902143504.1224726-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding unique flag to uprobe consumer to ensure it's the only consumer
attached on the uprobe.

This is helpful for use cases when consumer wants to change user space
registers, which might confuse other consumers. With this change we can
ensure there's only one consumer on specific uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 08ef78439d0d..0df849dee720 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -60,6 +60,7 @@ struct uprobe_consumer {
 	struct list_head cons_node;
 
 	__u64 id;	/* set when uprobe_consumer is registered */
+	bool is_unique; /* the only consumer on uprobe */
 };
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 996a81080d56..b9b088f7333a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1024,14 +1024,35 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	return uprobe;
 }
 
-static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
+{
+	/* Uprobe has no consumer, we can add any. */
+	if (list_empty(head))
+		return true;
+	/* Uprobe has consumer/s, we can't add unique one. */
+	if (uc->is_unique)
+		return false;
+	/*
+	 * Uprobe has consumer/s, we can add nother consumer only if the
+	 * current consumer is not unique.
+	 **/
+	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
+}
+
+static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	static atomic64_t id;
+	int ret = -EBUSY;
 
 	down_write(&uprobe->consumer_rwsem);
+	if (!consumer_can_add(&uprobe->consumers, uc))
+		goto unlock;
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	uc->id = (__u64) atomic64_inc_return(&id);
+	ret = 0;
+unlock:
 	up_write(&uprobe->consumer_rwsem);
+	return ret;
 }
 
 /*
@@ -1420,7 +1441,12 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return uprobe;
 
 	down_write(&uprobe->register_rwsem);
-	consumer_add(uprobe, uc);
+	ret = consumer_add(uprobe, uc);
+	if (ret) {
+		put_uprobe(uprobe);
+		up_write(&uprobe->register_rwsem);
+		return ERR_PTR(ret);
+	}
 	ret = register_for_each_vma(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
 
-- 
2.51.0


