Return-Path: <bpf+bounces-69735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92CBA0685
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF653AD6C9
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AA2F0C6D;
	Thu, 25 Sep 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bq90qnCl"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA082EC568
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814737; cv=none; b=iJ0KxAOEkqzEcAnBpxQ1YHooZuESWvNw1WoLdb7+WjBg+bAf2lEMy7l9nMMO8t+TQ4Qx7E8Egy2ElocuX/EkDNWAQ/C6BW/o4ftwI6cBMcsNbTVI4R+zRgy2hIKm4NdSgRR5ZmVbUCfdiuNpTAWQSnykQMN37QraZWwbDzlqyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814737; c=relaxed/simple;
	bh=0kiCvvWJsb+/7CPaVYxOUWikevx3g9Bhvb832A8fqLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLJxooXqA4K8ASr+VupgF+TcfmvLOw1OIWQtvGP+cAm5UXmynTsL4QLTdpkNs9J+U0tvb8EuhT4GodIs1uJkUJPhI0IDhvijP7gVyOTlZZDswcy4l6aWNA3eGyxn92C1O2Agd+0RxxvuXJiSM/0kttd7Hvwko4EAQYbuXUQGMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bq90qnCl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758814733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pZqxMqrxFEMidStN37scZfBloJjKCiRZBgWYGJdyLA=;
	b=Bq90qnClSYsprg7E6hX4UrjJXIP36GVbwHK4vYp0Gw3ZjgXnXQ5eyWmpAasg4uNHtabL/A
	SL5/WOPGtaKyUOC4AdkWo14X5+bZvxb0aiMFvZnY3ZHlBj9DGFtgp3desul0Jv2WgWwgWQ
	cDU55/wPg8aSXGxXDf4ErDTkzZupjOA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 6/7] libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
Date: Thu, 25 Sep 2025 23:37:45 +0800
Message-ID: <20250925153746.96154-7-leon.hwang@linux.dev>
In-Reply-To: <20250925153746.96154-1-leon.hwang@linux.dev>
References: <20250925153746.96154-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding the
cpu info into the high 32 bits of:

1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
   bpf_map_update_elem() and bpf_map__update_elem()
2. **opts->elem_flags**: bpf_map_lookup_batch() and
   bpf_map_update_batch()

And the flag can be BPF_F_ALL_CPUS, but cannot be
'BPF_F_CPU | BPF_F_ALL_CPUS'.

Behavior:

* If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
* If the flag is BPF_F_CPU, it updates value only to the specified CPU.
* If the flag is BPF_F_CPU, lookup value only from the specified CPU.
* lookup does not support BPF_F_ALL_CPUS.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.h    |  8 ++++++++
 tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++------
 tools/lib/bpf/libbpf.h | 21 ++++++++-------------
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d612..ffd93feffd71d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -289,6 +289,14 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
  *    Update spin_lock-ed map elements. This must be
  *    specified if the map value contains a spinlock.
  *
+ * **BPF_F_CPU**
+ *    As for percpu maps, update value on the specified CPU. And the cpu
+ *    info is embedded into the high 32 bits of **opts->elem_flags**.
+ *
+ * **BPF_F_ALL_CPUS**
+ *    As for percpu maps, update value across all CPUs. This flag cannot
+ *    be used with BPF_F_CPU at the same time.
+ *
  * @param fd BPF map file descriptor
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array of *count* values
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5161c2b398753..61983c603fa17 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10675,7 +10675,7 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 }
 
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
-			   size_t value_sz, bool check_value_sz)
+			   size_t value_sz, bool check_value_sz, __u64 flags)
 {
 	if (!map_is_created(map)) /* map is not yet created */
 		return -ENOENT;
@@ -10702,6 +10702,20 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 		int num_cpu = libbpf_num_possible_cpus();
 		size_t elem_sz = roundup(map->def.value_size, 8);
 
+		if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
+			if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS)) {
+				pr_warn("map '%s': BPF_F_CPU and BPF_F_ALL_CPUS are mutually exclusive\n",
+					map->name);
+				return -EINVAL;
+			}
+			if (value_sz != elem_sz) {
+				pr_warn("map '%s': unexpected value size %zu provided for per-CPU map, expected %zu\n",
+					map->name, value_sz, elem_sz);
+				return -EINVAL;
+			}
+			break;
+		}
+
 		if (value_sz != num_cpu * elem_sz) {
 			pr_warn("map '%s': unexpected value size %zu provided for per-CPU map, expected %d * %zu = %zd\n",
 				map->name, value_sz, num_cpu, elem_sz, num_cpu * elem_sz);
@@ -10726,7 +10740,7 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10739,7 +10753,7 @@ int bpf_map__update_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10751,7 +10765,7 @@ int bpf_map__delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10764,7 +10778,7 @@ int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10776,7 +10790,7 @@ int bpf_map__get_next_key(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0);
 	if (err)
 		return libbpf_err(err);
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e243..8c06a5cb7569f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory in which looked up value will be stored
  * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
- * alignment reasons, so expected size is: `round_up(value_size, 8)
- * * libbpf_num_possible_cpus()`.
+ * definition's **value_size**. For per-CPU BPF maps, value size can be
+ * `round_up(value_size, 8)` if either **BPF_F_CPU** or **BPF_F_ALL_CPUS** is
+ * specified in **flags**, otherwise a product of BPF map value size and number
+ * of possible CPUs in the system (could be fetched with
+ * **libbpf_num_possible_cpus()**). Note also that for per-CPU values value
+ * size has to be aligned up to closest 8 bytes, so expected size is:
+ * `round_up(value_size, 8) * libbpf_num_possible_cpus()`.
  * @flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
@@ -1219,13 +1220,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
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


