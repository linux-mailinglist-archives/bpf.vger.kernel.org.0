Return-Path: <bpf+bounces-49789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477FBA1C2D4
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F8C1888D6D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFB1E491B;
	Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EF1E7C11
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802755; cv=none; b=G+5gUFEIlc3QwxXF51k/A88vqQrSiuzev4VzsVwFZ2enTae9MSeHoh4uV4qzLTwa3OwpQ7vTomSrmD6iRXZ/ONMcWhxuXzWrg7lDPkyWjjUDMoQRsMGfQCmLojxaINiC1lDIVwy0iURIy4jjb2fYM1QkAyy+cfaie+bUUgKEHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802755; c=relaxed/simple;
	bh=WY9WyPicU+1X66tg9LlWMToM+tv0t8rbS84ZTrAc+qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9ii8WoPDsUlMWxmXa8jj7zm6zBIPeSOkKiO2Cz9IdiVbkXTjUW1vioI4DEUqH1/VlgYcprrOKF6bPIIIL8uDEkPvgkeJRDGk0x1KqoenZ9sazGwvzQ/DOLFH2clca4VUpVLVy71H78A2++XX4pYkfy0HlfSp/6LT3ADjkcBtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWF60Z1z4f3jqC
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E32A1A0FDC
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S8;
	Sat, 25 Jan 2025 18:59:05 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 04/20] bpf: Move the initialization of btf before ->map_alloc_check
Date: Sat, 25 Jan 2025 19:10:53 +0800
Message-Id: <20250125111109.732718-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4kZrWktrWfuF17Xw13urg_yoW7Jw18pF
	WfJFya9r4kArW7Xwn3ta1rWa4rtr4xJ3yDCF1UWryfZF4UXr1agr1SgayjqryakFy8A348
	Zw4Yqa95Ca4xZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	F9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

As for now, map_create() calls ->map_alloc_check() and ->map_alloc()
first, then it initializes map btf. In order to support dynptr in map
key, map_create() needs to check whether there is bpf_dynptr in map key
btf type and passes the information to ->map_alloc_check() and
->map_alloc().

However, the case where btf_vmlinux_value_type_id > 0 needs special
handling. The reason is that the probe of struct_ops map in libbpf
doesn't pass a valid btf_fd to map_create syscall, and it expects
->map_alloc() to be invoked before the initialization of the map btf. If
the initialization of the map btf happens before ->map_alloc(), the
probe of struct_ops will fail. To prevent breaking the old libbpf in the
new kernel, the patch only moves the initialization of btf before
->map_alloc_check() for non-struct-ops map case.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 91 ++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ba2df15ae0f1f..d57bfb30463fa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1368,6 +1368,7 @@ static int map_create(union bpf_attr *attr)
 	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
+	struct btf *btf = NULL;
 	struct bpf_map *map;
 	bool token_flag;
 	int f_flags;
@@ -1391,43 +1392,63 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
 
+	if (attr->btf_key_type_id || attr->btf_value_type_id) {
+		btf = get_map_btf(attr->btf_fd);
+		if (IS_ERR(btf))
+			return PTR_ERR(btf);
+	}
+
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
-	    attr->map_extra != 0)
-		return -EINVAL;
+	    attr->map_extra != 0) {
+		err = -EINVAL;
+		goto put_btf;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
-	if (f_flags < 0)
-		return f_flags;
+	if (f_flags < 0) {
+		err = f_flags;
+		goto put_btf;
+	}
 
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
-	     !node_online(numa_node)))
-		return -EINVAL;
+	     !node_online(numa_node))) {
+		err = -EINVAL;
+		goto put_btf;
+	}
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map_type = attr->map_type;
-	if (map_type >= ARRAY_SIZE(bpf_map_types))
-		return -EINVAL;
+	if (map_type >= ARRAY_SIZE(bpf_map_types)) {
+		err = -EINVAL;
+		goto put_btf;
+	}
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
-	if (!ops)
-		return -EINVAL;
+	if (!ops) {
+		err = -EINVAL;
+		goto put_btf;
+	}
 
 	if (ops->map_alloc_check) {
 		err = ops->map_alloc_check(attr);
 		if (err)
-			return err;
+			goto put_btf;
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
-		return -EINVAL;
+	if (!ops->map_mem_usage) {
+		err = -EINVAL;
+		goto put_btf;
+	}
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
-			return PTR_ERR(token);
+		if (IS_ERR(token)) {
+			err = PTR_ERR(token);
+			goto put_btf;
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1517,30 +1538,27 @@ static int map_create(union bpf_attr *attr)
 	mutex_init(&map->freeze_mutex);
 	spin_lock_init(&map->owner.lock);
 
-	if (attr->btf_key_type_id || attr->btf_value_type_id ||
-	    /* Even the map's value is a kernel's struct,
-	     * the bpf_prog.o must have BTF to begin with
-	     * to figure out the corresponding kernel's
-	     * counter part.  Thus, attr->btf_fd has
-	     * to be valid also.
-	     */
-	    attr->btf_vmlinux_value_type_id) {
-		struct btf *btf;
-
-		btf = btf_get_by_fd(attr->btf_fd);
-		if (IS_ERR(btf)) {
-			err = PTR_ERR(btf);
-			goto free_map;
-		}
-		if (btf_is_kernel(btf)) {
-			btf_put(btf);
-			err = -EACCES;
-			goto free_map;
+	/* Even the struct_ops map's value is a kernel's struct,
+	 * the bpf_prog.o must have BTF to begin with
+	 * to figure out the corresponding kernel's
+	 * counter part.  Thus, attr->btf_fd has
+	 * to be valid also.
+	 */
+	if (btf || attr->btf_vmlinux_value_type_id) {
+		if (!btf) {
+			btf = get_map_btf(attr->btf_fd);
+			if (IS_ERR(btf)) {
+				err = PTR_ERR(btf);
+				btf = NULL;
+				goto free_map;
+			}
 		}
+
 		map->btf = btf;
+		btf = NULL;
 
 		if (attr->btf_value_type_id) {
-			err = map_check_btf(map, token, btf, attr->btf_key_type_id,
+			err = map_check_btf(map, token, map->btf, attr->btf_key_type_id,
 					    attr->btf_value_type_id);
 			if (err)
 				goto free_map;
@@ -1572,7 +1590,6 @@ static int map_create(union bpf_attr *attr)
 		 * have refcnt-ed it through BPF_MAP_GET_FD_BY_ID.
 		 */
 		bpf_map_put_with_uref(map);
-		return err;
 	}
 
 	return err;
@@ -1583,6 +1600,8 @@ static int map_create(union bpf_attr *attr)
 	bpf_map_free(map);
 put_token:
 	bpf_token_put(token);
+put_btf:
+	btf_put(btf);
 	return err;
 }
 
-- 
2.29.2


