Return-Path: <bpf+bounces-19668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5882FA3E
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542E3B26568
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B762A05;
	Tue, 16 Jan 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEaV/rcn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189B151470;
	Tue, 16 Jan 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435147; cv=none; b=bZMKSZ0ri0bbPxDk6O6gj+tWfWPuntkMCL/vADn0LV4/HnNAaKzS8zlReG/7W2MiVeoicrdlIGSoalsIHTPI+MkglWKXqEnQWP4pezDkuj8ZdnpFvmqTrgp3dqvPICsNLsgQuVtYnoIfkUicNXdv8qDd6ZGsciiCzG+l1od/6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435147; c=relaxed/simple;
	bh=t+/Z8geTTCTdYeZaGHC/3idC0OS3/d+FROJO9Uly8mc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Jqyvlhs3GHI9z5bPlEwP+0o1jJi48yG95ZxVQmY3YmK9hR2I46BzJyTjGDyVAfB+Rtzdleja+Efa6TO4DtAWb0tEJAMW86qMsWK+8sb9sBA60a0iu0YSZU9RnPCOvnLts6bUut6sTwy474QpH9mQl5y/NNAn7VtlXtQ2sCbvOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEaV/rcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8F6C433C7;
	Tue, 16 Jan 2024 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435147;
	bh=t+/Z8geTTCTdYeZaGHC/3idC0OS3/d+FROJO9Uly8mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEaV/rcnkCz+Wsl7vQp1LvYGkzNgQz0FJZTkfZRxR9ATN6lRRxVYcCGFw4Oy7hD7j
	 slcdQz2syZEqNTaRFNo9NsAMuMnXbAWO+LauOIKV35tEtvt5N48e4tzZwis2+5WSbm
	 33WwsS6TW5V3HD3rzAsBcQJ3rrCN4uc+SClzKEJcl9/Ny3OtbkmhWy5Ax1HX6yQIuf
	 CtcWpAoQ0CN+HcHVnuxxzx94qqVBav8hcvWN0i6ZQNDBG/WqHCXYLN9kMzQr/ZEe2n
	 UfASly+F48iq3CP97HJp0f5iQ0lcbytvnpyWvtt8c3Wuf2DHKZ1LCisFQcbWNpbDEG
	 tgFVqf1KMHqmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/47] bpf: Set need_defer as false when clearing fd array during map free
Date: Tue, 16 Jan 2024 14:57:18 -0500
Message-ID: <20240116195834.257313-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index c76870bfd816..8c4201dc6959 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -815,7 +815,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	return 0;
 }
 
-static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
+static int __fd_array_map_delete_elem(struct bpf_map *map, void *key, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *old_ptr;
@@ -834,13 +834,18 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
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
@@ -870,13 +875,13 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
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
@@ -1017,7 +1022,7 @@ static void prog_array_map_clear_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_array_aux,
 					   work)->map;
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, true);
 	bpf_map_put(map);
 }
 
@@ -1169,7 +1174,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 	for (i = 0; i < array->map.max_entries; i++) {
 		ee = READ_ONCE(array->ptrs[i]);
 		if (ee && ee->map_file == map_file)
-			fd_array_map_delete_elem(map, &i);
+			__fd_array_map_delete_elem(map, &i, true);
 	}
 	rcu_read_unlock();
 }
@@ -1177,7 +1182,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 static void perf_event_fd_array_map_free(struct bpf_map *map)
 {
 	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
-		bpf_fd_array_map_clear(map);
+		bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1214,7 +1219,7 @@ static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_de
 
 static void cgroup_fd_array_free(struct bpf_map *map)
 {
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1260,7 +1265,7 @@ static void array_of_map_free(struct bpf_map *map)
 	 * is protected by fdget/fdput.
 	 */
 	bpf_map_meta_free(map->inner_map_meta);
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
-- 
2.43.0


