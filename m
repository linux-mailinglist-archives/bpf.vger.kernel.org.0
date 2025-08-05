Return-Path: <bpf+bounces-65077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6CB1B888
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72CA621C4E
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB21F4171;
	Tue,  5 Aug 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ebWI/kJ2"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C14191F92
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411440; cv=none; b=bFo7MsqruxzVRss3xglISDC6r9bKzvyLKpkolcGD7+CVMVP3gVb28Cmc9wLOtDC7rOMVUDDWQUmzez0jLe4iJpp0JdGEilhIuYh4LQzvAy4xtXlzKlPsLWYccXa3cLUQgihcpo1R2wWiEN4jrawLh0JnIxnlLKp9G0mv9RvfTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411440; c=relaxed/simple;
	bh=urvUiAUWrqjycV/UPg5HenixXWWrN9w8x/5ennKzNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdyUQcVtWUU3IXY2juf1Nl0ReIehaqaUXQM4btYyXhx/DmufdSYd1p4SpfxWFEnduDI6swkueL4QRnnqzxqd0wovFsnyW85Hmd6D/prXkWQaUzyZy4IDZC0QICAlb4UOg0u+7uAI9nUd0zKStSWEJxwneNMhDDB9WGPhos0Tq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ebWI/kJ2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754411435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tur1iY9T1wqBJNL0W1mrHR3j8ql9lSmJmpZP63GH2Hw=;
	b=ebWI/kJ2JcvIwfFqku5p3y/lSD9bdE9AWnTzUD2Hxl5dA7r2oRSp+VCqIk12RIVmjXXGFK
	ZjpUQzwQH/U8lCe+wPEL3awOByQdGkz4/8DNoMl+RSF708c3zwhmc4j1fvWOCqjHUtR5IF
	ciUO3RxSScNsCdU6L3Nqryg2uQZv3bw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/3] libbpf: Support BPF_F_CPU for percpu_array maps
Date: Wed,  6 Aug 2025 00:30:16 +0800
Message-ID: <20250805163017.17015-3-leon.hwang@linux.dev>
In-Reply-To: <20250805163017.17015-1-leon.hwang@linux.dev>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add libbpf support for the BPF_F_CPU flag for percpu_array maps by
embedding the cpu info into the high 32 bits of:

1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
   bpf_map_update_elem() and bpf_map__update_elem()
2. **opts->elem_flags**: bpf_map_lookup_batch() and
   bpf_map_update_batch()

Behavior:

* If cpu is (u32)~0, the update is applied across all CPUs.
* Otherwise, it updates value only to the specified CPU.
* If cpu is (u32)~0, lookup values across all CPUs.
* Otherwise, it lookups value only from the specified CPU.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.h    |  5 +++++
 tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h | 17 ++++++-----------
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad35..8dea8216d5992 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -286,6 +286,11 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
  *    Update spin_lock-ed map elements. This must be
  *    specified if the map value contains a spinlock.
  *
+ * **BPF_F_CPU**
+ *    As for percpu map, the cpu info is embedded into the high 32 bits of
+ *    **opts->elem_flags**. Update value across all CPUs if cpu is (__u32)~0,
+ *    or on specified CPU otherwise.
+ *
  * @param fd BPF map file descriptor
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array of *count* values
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb4d92c5c3394..29ada5d62ba26 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10593,8 +10593,10 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 }
 
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
-			   size_t value_sz, bool check_value_sz)
+			   size_t value_sz, bool check_value_sz, __u64 flags)
 {
+	__u32 cpu;
+
 	if (!map_is_created(map)) /* map is not yet created */
 		return -ENOENT;
 
@@ -10612,6 +10614,20 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 	if (!check_value_sz)
 		return 0;
 
+	if (flags & BPF_F_CPU) {
+		if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+		cpu = flags >> 32;
+		if (cpu != BPF_ALL_CPUS && cpu >= libbpf_num_possible_cpus())
+			return -ERANGE;
+		if (map->def.value_size != value_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
+				map->name, value_sz, map->def.value_size);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
 	switch (map->def.type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
@@ -10644,7 +10660,7 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10657,7 +10673,7 @@ int bpf_map__update_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10669,7 +10685,7 @@ int bpf_map__delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0);
 	if (err)
 		return libbpf_err(err);
 
@@ -10682,7 +10698,7 @@ int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, 0);
 	if (err)
 		return libbpf_err(err);
 
@@ -10694,7 +10710,7 @@ int bpf_map__get_next_key(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0);
 	if (err)
 		return libbpf_err(err);
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057bc..bde22b017a3ce 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1169,10 +1169,11 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory in which looked up value will be stored
  * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
+ * definition's **value_size**. For per-CPU BPF maps, value size can be
+ * definition's **value_size** if **BPF_F_CPU** is specified in **flags**,
+ * otherwise a product of BPF map value size and number of possible CPUs in the
+ * system (could be fetched with **libbpf_num_possible_cpus()**). Note else that
+ * for per-CPU values value size has to be aligned up to closest 8 bytes for
  * alignment reasons, so expected size is: `round_up(value_size, 8)
  * * libbpf_num_possible_cpus()`.
  * @flags extra flags passed to kernel for this operation
@@ -1192,13 +1193,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
  * @param key pointer to memory containing bytes of the key
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory containing bytes of the value
- * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
- * alignment reasons, so expected size is: `round_up(value_size, 8)
- * * libbpf_num_possible_cpus()`.
+ * @param value_sz refer to **bpf_map__lookup_elem**'s description.'
  * @flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
-- 
2.50.1


