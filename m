Return-Path: <bpf+bounces-36995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3F94FCB5
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C471F22789
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172CB43AC4;
	Tue, 13 Aug 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyi4ZzFt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25443165;
	Tue, 13 Aug 2024 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523400; cv=none; b=r1uX1fx3+vD9Ky9myGrMbqqb9cdv7e6nTjqlmzJ8v74m1iYB20nQY9b1wW1UAFez6HhPNtRwTguSt/RSjGpOfYlGovyjCwW8E0f9y+gFwlsVD7HyNOzkIki3277H3nkEUp57IAb99/a+k9IEXnMfq61HOjWt/T6RIvzbHj0m4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523400; c=relaxed/simple;
	bh=iIO+4imlGFWJODra3HvN51TRltaxN3vJ0lLIJ7O8eDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLxdZipjps6gy8wmrmLhBdayoYaKFja1aFwKh8+UZ/TV1yH9CXjHqh1FdIl1u7/BSisGtw4hrEuY/47s8xKaZiol6GTQPrtzE8e9spMv2veZ6xhuk+eJyTOELpG7lmWCcRH/rJpnerPbO1qpRum44Ch3D3yWmi711MvbrnE0yVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyi4ZzFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C2EC4AF0E;
	Tue, 13 Aug 2024 04:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523400;
	bh=iIO+4imlGFWJODra3HvN51TRltaxN3vJ0lLIJ7O8eDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyi4ZzFtnEAKbgF77exAYbwH1JsjVlsy90cUdbmKcEkFiUDkFs7z+WNMHwv52zCQs
	 RYZnm0SPIyUnbXEBgAAfgiLeilZyo+U9A/ZkLVTHGCuWzvl/JyN5GDGL9wrZBTAszT
	 JxinIH2E9S72z3nYli0ti618m+TKCvsomeB+oeRn8jpQ3Hz3AlsvNoh+xwkhjqMeEd
	 g9PDl+ERgtJaZSDu7PY34GWvX0XBXEts9uwIBdCcwZIP+FQ69ct0JoOsxsg7rJfyIs
	 HCCyxlizGciad8le7WUAhSzKGHiUduThHlpeVKwJtvyMDQV4THSw0uUYbUpYbmTb4w
	 HW43b2PqOU8hg==
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
Subject: [PATCH v3 06/13] rbtree: provide rb_find_rcu() / rb_find_add_rcu()
Date: Mon, 12 Aug 2024 21:29:10 -0700
Message-ID: <20240813042917.506057-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
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


