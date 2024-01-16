Return-Path: <bpf+bounces-19659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C1F82F970
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C445B23C9A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37C143744;
	Tue, 16 Jan 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R//Pu0eO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D45FBBA;
	Tue, 16 Jan 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434961; cv=none; b=h06uz/j3syoxwR3LkJTMfG3ANz9AGBXxdWOJTPCxALQnTnXQARBgzGFJAfEpaTY0246+5Z68EkVp03WxaN/jL2shkzjHe17x1BrEeT03OkkvSgNpGVDi8Fg167JtHRTMgiXM3O5nTPgFlNjtZ/AVUZX2Z7bo1VnmdCnJtS8Wnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434961; c=relaxed/simple;
	bh=5c0wZCzEVzcaOEdHi8PWSnZCbPMkJvW0RZMYCubRTUU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=aDCn6rxXqMHyxFJcPmC0lyZSkxKjIETAbICAOnYgVrVLNkOeDbnfNfL3EMijQS7IES8W7bL4j5KzWZ8VKbilFWr979d44yo5tIyiZhwRM7KPmGuE9gOeagCHw/3D0TlpqMRVuUl49rpFGqxamD6UjP1lv6lTAEjOpfLaV3vJpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R//Pu0eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A0C43394;
	Tue, 16 Jan 2024 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434961;
	bh=5c0wZCzEVzcaOEdHi8PWSnZCbPMkJvW0RZMYCubRTUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R//Pu0eOtIH7nidbu75QlaH2GVn0jA0qYIjMykrqtQl56nG3H9Nv0LWiuc94/aufo
	 2lQUjEDS/s/6CtnlFb42gSZWC7AYd17O346CIM0zIunzQDDfOTXij3BbEolKILcNH0
	 yw6CWTLGbZ0hC7ciCLvC3CLHfJY6y1EtkE9i6WHqbcCC4ni0QhtTPbv/uH/YqRzEfW
	 1B60mtF3B92luFc0H9ccRmMwiOYYNaQQL92xDKs/zJjkIZtjKqPYhMQzl8k7vOt69y
	 EdZBOmc4+0bT70MLAIZcPq6VzMTGWED+vJEgwH7IPsyqwokqvrWQItO/O2mwCq50jX
	 fOlGx+gE1hsCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 23/68] bpf: Set need_defer as false when clearing fd array during map free
Date: Tue, 16 Jan 2024 14:53:22 -0500
Message-ID: <20240116195511.255854-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 79d93b3c6ffd79abcd8e43345980aa1e904879c4 ]

Both map deletion operation, map release and map free operation use
fd_array_map_delete_elem() to remove the element from fd array and
need_defer is always true in fd_array_map_delete_elem(). For the map
deletion operation and map release operation, need_defer=true is
necessary, because the bpf program, which accesses the element in fd
array, may still alive. However for map free operation, it is certain
that the bpf program which owns the fd array has already been exited, so
setting need_defer as false is appropriate for map free operation.

So fix it by adding need_defer parameter to bpf_fd_array_map_clear() and
adding a new helper __fd_array_map_delete_elem() to handle the map
deletion, map release and map free operations correspondingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-4-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/arraymap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index c04e69f34e4d..390650b3a4cb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -856,7 +856,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	return 0;
 }
 
-static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
+static int __fd_array_map_delete_elem(struct bpf_map *map, void *key, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *old_ptr;
@@ -875,13 +875,18 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(map, old_ptr, true);
+		map->ops->map_fd_put_ptr(map, old_ptr, need_defer);
 		return 0;
 	} else {
 		return -ENOENT;
 	}
 }
 
+static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return __fd_array_map_delete_elem(map, key, true);
+}
+
 static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
@@ -910,13 +915,13 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
-static void bpf_fd_array_map_clear(struct bpf_map *map)
+static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		fd_array_map_delete_elem(map, &i);
+		__fd_array_map_delete_elem(map, &i, need_defer);
 }
 
 static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
@@ -1057,7 +1062,7 @@ static void prog_array_map_clear_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_array_aux,
 					   work)->map;
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, true);
 	bpf_map_put(map);
 }
 
@@ -1206,7 +1211,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 	for (i = 0; i < array->map.max_entries; i++) {
 		ee = READ_ONCE(array->ptrs[i]);
 		if (ee && ee->map_file == map_file)
-			fd_array_map_delete_elem(map, &i);
+			__fd_array_map_delete_elem(map, &i, true);
 	}
 	rcu_read_unlock();
 }
@@ -1214,7 +1219,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 static void perf_event_fd_array_map_free(struct bpf_map *map)
 {
 	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
-		bpf_fd_array_map_clear(map);
+		bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1249,7 +1254,7 @@ static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_de
 
 static void cgroup_fd_array_free(struct bpf_map *map)
 {
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1293,7 +1298,7 @@ static void array_of_map_free(struct bpf_map *map)
 	 * is protected by fdget/fdput.
 	 */
 	bpf_map_meta_free(map->inner_map_meta);
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
-- 
2.43.0


