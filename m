Return-Path: <bpf+bounces-38808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67096A5C4
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D26B1C23CF1
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A211198858;
	Tue,  3 Sep 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePac60MH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84918FDAA;
	Tue,  3 Sep 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385588; cv=none; b=S3tT8koaN/OuMUvYqZrKOiqOF48r4NIQ7aKqaNHNSSPiKoh/gtp9JlUhto7gZ0rn/ngGHu+faLe0pc+arRx/b6T+l2vqtTXTV6pvPaZYPejwoyzKCRsSCtFb1rTOJPv4TCZ4HFiXGvkgH8XXKcXgRU0CrZ+p2yUv+aVJ8DDucPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385588; c=relaxed/simple;
	bh=fbkVIaD1WSV5k2O1l+qbLGEuln2w8HvLuX0+cvs5jtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCyYbaLEgnRqKAxhD1Xzfk/jJ7DegZDJy2PPu8kUIpC4NhcPKNKd0FzZs56DQjn0+8zOlL9lWZAybfPj/OW3BGd+19Z6FxLgaVv5v88nISgA4aelpcsY/9LAS8JgUFm1A/Hn2NA8psybpeedtxMbuHqm2FBR5SqZNh2v5qRXhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePac60MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8DAC4CEC6;
	Tue,  3 Sep 2024 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385587;
	bh=fbkVIaD1WSV5k2O1l+qbLGEuln2w8HvLuX0+cvs5jtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePac60MHZQZol0UGw03YynNTwklAOaXlOvgQPfdFV66MYzxkSzn+Zmk4d1UTS198j
	 zU8y2voSoi8FHy8gTAz9OTJ/tflW4leFmuRPC95QNYsdovmI8L/kSz/oHSbwosTt4l
	 90yxAjvX0bAlHHDCz/NCCWumyGr9+oyKrPSrqZY5wXnN3jRekx9+V7cdxUl5sXMLkN
	 qChy2ahmkKbxyNBiybflTFGhG9xQqB2nQW0rsB/wTcKY0458tc/hGBHh9VnRe/+5Oq
	 UuYFJ19TN2rpx1y9fim9ueGgCZ24e5P73q8VPvfJvBuUviAuEuoLvMxFS4Z8cCJcb7
	 /vMnWH9OEYinw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 6/8] rbtree: provide rb_find_rcu() / rb_find_add_rcu()
Date: Tue,  3 Sep 2024 10:46:01 -0700
Message-ID: <20240903174603.3554182-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903174603.3554182-1-andrii@kernel.org>
References: <20240903174603.3554182-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Much like latch_tree, add two RCU methods for the regular RB-tree,
which can be used in conjunction with a seqcount to provide lockless
lookups.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/rbtree.h | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca369eda..7c173aa64e1e 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -244,6 +244,42 @@ rb_find_add(struct rb_node *node, struct rb_root *tree,
 	return NULL;
 }
 
+/**
+ * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Adds a Store-Release for link_node.
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
 /**
  * rb_find() - find @key in tree @tree
  * @key: key to match
@@ -272,6 +308,37 @@ rb_find(const void *key, const struct rb_root *tree,
 	return NULL;
 }
 
+/**
+ * rb_find_rcu() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Notably, tree descent vs concurrent tree rotations is unsound and can result
+ * in false-negatives.
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
 /**
  * rb_find_first() - find the first @key in @tree
  * @key: key to match
-- 
2.43.5


