Return-Path: <bpf+bounces-19681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AB82FB60
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBB41C269B2
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BD1649C8;
	Tue, 16 Jan 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPShMc6+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724061649B9;
	Tue, 16 Jan 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435415; cv=none; b=Y1cgGEUHxjgPV0zI06Tv9A78QaJ/Im6k6SVfDCPXz2b0zbOrvX98nx6nIMz0oxjJjWqiKgmxQvJJfHpDi0vENgvrYCpJCIw2DZtc1riNjSGMab0TaJmEavLHrj+RVNJTiYcQ0xa/kTUZRK72geKaNcq8JmuRm9v9QXVQR1/FZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435415; c=relaxed/simple;
	bh=ZCiF5JZiLNOTSWZVFa+rJ2ctFdJUGD3R8j4J0MzxFXk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ayYok44oidsj65fadnDZjZGBQXu2rLZM6NaZ35JjmxQgFCZqnEiOJmA/GDChDybtfGnYuJ9Hg84y2wDXM7GweqvWI23qWvkwA7EqEjb0LicazoUveN1WhJCh/ky1PEOW8A/fLxHZTKtZ8qS1KjBqGLpx0AKhxG4OHe6cGM2CSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPShMc6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6424BC433C7;
	Tue, 16 Jan 2024 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435415;
	bh=ZCiF5JZiLNOTSWZVFa+rJ2ctFdJUGD3R8j4J0MzxFXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPShMc6+n6Q4tTtJqqVdQXN0ykMbvqM3lbHg3h1siX46pafoKk4H8lOsiTvTABSXZ
	 XsDj5lFB5TkN6nddjx1XZVhsZ72wqh6Pa78ETTxCHqvwo+C0ZCkzjEYQWDZf30zF6n
	 TcvwJETFc7voHRo0AFDq5TTAaCw6mtvqIvmKP5kiIFVYj/FOof+MeK+N5A7lZbLR/7
	 MON3jRNr5u9SGvhivSDlYKRZxzuUZd5x6sFgI2/z6Kt+JPCEMlP7x2u/HN4+5gkZOf
	 Pe6thGIij3MCzEXJJvCQJygL7phTaXpPWOcD++PEpvktdcifCFG8dp2aGlp5X9SJ3N
	 Ddx5e47sUGTFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/31] bpf: Add map and need_defer parameters to .map_fd_put_ptr()
Date: Tue, 16 Jan 2024 15:02:20 -0500
Message-ID: <20240116200310.259340-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 20c20bd11a0702ce4dc9300c3da58acf551d9725 ]

map is the pointer of outer map, and need_defer needs some explanation.
need_defer tells the implementation to defer the reference release of
the passed element and ensure that the element is still alive before
the bpf program, which may manipulate it, exits.

The following three cases will invoke map_fd_put_ptr() and different
need_defer values will be passed to these callers:

1) release the reference of the old element in the map during map update
   or map deletion. The release must be deferred, otherwise the bpf
   program may incur use-after-free problem, so need_defer needs to be
   true.
2) release the reference of the to-be-added element in the error path of
   map update. The to-be-added element is not visible to any bpf
   program, so it is OK to pass false for need_defer parameter.
3) release the references of all elements in the map during map release.
   Any bpf program which has access to the map must have been exited and
   released, so need_defer=false will be OK.

These two parameters will be used by the following patches to fix the
potential use-after-free problem for map-in-map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h     |  6 +++++-
 kernel/bpf/arraymap.c   | 12 +++++++-----
 kernel/bpf/hashtab.c    |  6 +++---
 kernel/bpf/map_in_map.c |  2 +-
 kernel/bpf/map_in_map.h |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5705cda3c4c4..6107b537245a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -49,7 +49,11 @@ struct bpf_map_ops {
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
 				int fd);
-	void (*map_fd_put_ptr)(void *ptr);
+	/* If need_defer is true, the implementation should guarantee that
+	 * the to-be-put element is still alive before the bpf program, which
+	 * may manipulate it, exists.
+	 */
+	void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_defer);
 	u32 (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf);
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1c65ce0098a9..81ed9b79f401 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -542,7 +542,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	old_ptr = xchg(array->ptrs + index, new_ptr);
 	if (old_ptr)
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 
 	return 0;
 }
@@ -558,7 +558,7 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
 
 	old_ptr = xchg(array->ptrs + index, NULL);
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 		return 0;
 	} else {
 		return -ENOENT;
@@ -582,8 +582,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	return prog;
 }
 
-static void prog_fd_array_put_ptr(void *ptr)
+static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_prog is freed after one RCU or tasks trace grace period */
 	bpf_prog_put(ptr);
 }
 
@@ -694,8 +695,9 @@ static void *perf_event_fd_array_get_ptr(struct bpf_map *map,
 	return ee;
 }
 
-static void perf_event_fd_array_put_ptr(void *ptr)
+static void perf_event_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_perf_event is freed after one RCU grace period */
 	bpf_event_entry_free_rcu(ptr);
 }
 
@@ -736,7 +738,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
 	return cgroup_get_from_fd(fd);
 }
 
-static void cgroup_fd_array_put_ptr(void *ptr)
+static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* cgroup_put free cgrp after a rcu grace period */
 	cgroup_put(ptr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 03a67583f6fb..f1dec90f3a52 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -674,7 +674,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (map->ops->map_fd_put_ptr) {
 		ptr = fd_htab_map_get_ptr(map, l);
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
 
@@ -1426,7 +1426,7 @@ static void fd_htab_map_free(struct bpf_map *map)
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			void *ptr = fd_htab_map_get_ptr(map, l);
 
-			map->ops->map_fd_put_ptr(ptr);
+			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
 	}
 
@@ -1467,7 +1467,7 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
 	if (ret)
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, false);
 
 	return ret;
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index fab4fb134547..7fe5a73aff07 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -106,7 +106,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	return inner_map;
 }
 
-void bpf_map_fd_put_ptr(void *ptr)
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* ptr->ops->map_free() has to go through one
 	 * rcu grace period by itself.
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index a507bf6ef8b9..d296890813cc 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -15,7 +15,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1);
 void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
-void bpf_map_fd_put_ptr(void *ptr);
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 #endif
-- 
2.43.0


