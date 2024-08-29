Return-Path: <bpf+bounces-38446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1B964DD7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A2B1C23011
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC61BAEC0;
	Thu, 29 Aug 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzC1CmdK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C321BA891;
	Thu, 29 Aug 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956686; cv=none; b=gL4I4m2ChizsH7CFF9YNaY2XU/ZEf2+Tm6/3kWLKBawxzTQHba4/cSG/ReLMWs2TB/eDD5SReKrtBpyalC/RrKCv9TZQx1Bkc7ArtEzfU75Azy7JekWeHu+9t3Y/EIvgF3CrD6rQeNwfIEFrQmO7DITXUrj30T1TtYX1btCxVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956686; c=relaxed/simple;
	bh=iIO+4imlGFWJODra3HvN51TRltaxN3vJ0lLIJ7O8eDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epLFTAU28JTa5w5eub0Ir+AZ5q6u3D0SHFeSrzwVujP+wIg6GMQeBF95CzMguPtIkqB9ZE1KwPrnAw/A+FdU9n1BsgWd+V3qeOZPjGPpRXyfVYM1MnMlN/HDje++WPuA1rGxp3xywdQyoTmCr34r+FAEYeEVkfR+uuWsszaE5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzC1CmdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB41C4CEC8;
	Thu, 29 Aug 2024 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956686;
	bh=iIO+4imlGFWJODra3HvN51TRltaxN3vJ0lLIJ7O8eDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzC1CmdKA1dtEn7aGy1jjW/ec/JkAE54yAYkcV7++RQ8t92nsCNYrmWjTv5EAce7s
	 yziefBlq6hxVldBtXB+7OKy7SGFy0H/BKTt7LyNloWdF/FxvOQe4YPAHuciZta8xmo
	 hNN8v5AtrC45em3nFrg143zZISbYTM7V8ypcuYxl3xFF0RNlNuVWhFSWS8mx1JLRYL
	 8ttljUgfpwxp5E9rn/hUY3uSv4eOT2RNYFphSR4IaMcMZgHhEd07n605BPDs9uQ75D
	 Dc9aJe8SJJesglvAjesr+/i3sZBzpAmaZyvulNcBOWBpbBxAJhc7tGiW1DpBfj2ppr
	 ODT29am/jlW5w==
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
Subject: [PATCH v4 6/8] rbtree: provide rb_find_rcu() / rb_find_add_rcu()
Date: Thu, 29 Aug 2024 11:37:39 -0700
Message-ID: <20240829183741.3331213-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829183741.3331213-1-andrii@kernel.org>
References: <20240829183741.3331213-1-andrii@kernel.org>
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


