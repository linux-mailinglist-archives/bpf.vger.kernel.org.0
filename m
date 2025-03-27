Return-Path: <bpf+bounces-54788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D67A72B55
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB516176906
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F82054F5;
	Thu, 27 Mar 2025 08:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACB204F81
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063780; cv=none; b=Rx/jTUTsxnplZwxPz2jslFVit/8o+zLCQVzSMkAxYf/zE0ANiku5SExU5jsUqfc8ilXOOMzl8KA6zP+DvcySRfCIpyYETf6Ts/WHnd+/f5NS342XIrolByH96FLvh9PMp6l+o4F1p/zTzMm1EvVu4YQVB2vi7qx2v//NorFI3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063780; c=relaxed/simple;
	bh=ccyPeBNrKQ+K5C/VknquWfulfyq6KXZ31RA8LdfuKT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CarPLgNvs+/MDlx7UD6f7ttATN+iPSe28GUv2vl2f/uMy7FBXtBPlh+4UGdHSJcDcWHcRzNLIEL9H0pML/BFrPY/pPj3Sdr6/pOX2eRVxfg0Z1HEU+N/s3+zHy6jhZDBZDlrEhCwgMRFrWHThGiasvU8VWGttrSUiHw3Qmjo84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8s3zB9z4f3jZd
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 238D91A083E
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S11;
	Thu, 27 Mar 2025 16:22:54 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 07/16] bpf: Handle bpf_dynptr in bpf syscall when it is used as input
Date: Thu, 27 Mar 2025 16:34:46 +0800
Message-Id: <20250327083455.848708-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43XrW7JrWkur1DuryUZFb_yoWrtryUpF
	48WryfZrWFvr43Jr98X3WFva1rWrn2qw1UG3s7Jas5Wa1DXrZ8Xr1IqFZYgryYvFykXrn5
	Jr4Dta45Cry8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_copy_from_dynptr_ukey() helper to handle map key with
bpf_dynptr when the map key is used in map lookup, update, delete and
get_next_key operations.

The helper places all variable-length data of these bpf_dynptr objects
at the end of the map key to simplify the allocation and the freeing of
map key with dynptr.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 98 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9ded3ba82d356..d6dbcea3c30cb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1664,10 +1664,83 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *__bpf_copy_key(void __user *ukey, u64 key_size)
+static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 {
-	if (key_size)
-		return vmemdup_user(ukey, key_size);
+	const struct btf_record *record;
+	const struct btf_field *field;
+	struct bpf_dynptr_kern *kptr;
+	void *key, *new_key, *kdata;
+	unsigned int key_size, size;
+	struct bpf_dynptr *uptr;
+	bpfptr_t udata;
+	unsigned int i;
+	int err;
+
+	key_size = map->key_size;
+	key = kvmemdup_bpfptr(ukey, key_size);
+	if (IS_ERR(key))
+		return ERR_CAST(key);
+
+	size = key_size;
+	record = map->key_record;
+	for (i = 0; i < record->cnt; i++) {
+		field = &record->fields[i];
+		if (field->type != BPF_DYNPTR)
+			continue;
+		uptr = key + field->offset;
+		if (!uptr->size || uptr->reserved) {
+			err = -EINVAL;
+			goto free_key;
+		}
+
+		size += uptr->size;
+		/* Overflow ? */
+		if (size < uptr->size) {
+			err = -E2BIG;
+			goto free_key;
+		}
+	}
+
+	/* Place all dynptrs' data in the end of the key */
+	new_key = kvrealloc(key, size, GFP_USER | __GFP_NOWARN);
+	if (!new_key) {
+		err = -ENOMEM;
+		goto free_key;
+	}
+
+	key = new_key;
+	kdata = key + key_size;
+	for (i = 0; i < record->cnt; i++) {
+		field = &record->fields[i];
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		uptr = key + field->offset;
+		size = uptr->size;
+		udata = make_bpfptr((u64)(uintptr_t)uptr->data, bpfptr_is_kernel(ukey));
+		if (copy_from_bpfptr(kdata, udata, size)) {
+			err = -EFAULT;
+			goto free_key;
+		}
+		kptr = (struct bpf_dynptr_kern *)uptr;
+		bpf_dynptr_init(kptr, kdata, BPF_DYNPTR_TYPE_LOCAL, 0, size);
+		kdata += size;
+	}
+
+	return key;
+
+free_key:
+	kvfree(key);
+	return ERR_PTR(err);
+}
+
+static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
+{
+	if (bpf_map_has_dynptr_key(map))
+		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey));
+
+	if (map->key_size)
+		return vmemdup_user(ukey, map->key_size);
 
 	if (ukey)
 		return ERR_PTR(-EINVAL);
@@ -1675,10 +1748,13 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 	return NULL;
 }
 
-static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
+static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 {
-	if (key_size)
-		return kvmemdup_bpfptr(ukey, key_size);
+	if (bpf_map_has_dynptr_key(map))
+		return bpf_copy_from_dynptr_ukey(map, ukey);
+
+	if (map->key_size)
+		return kvmemdup_bpfptr(ukey, map->key_size);
 
 	if (!bpfptr_is_null(ukey))
 		return ERR_PTR(-EINVAL);
@@ -1715,7 +1791,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
@@ -1782,7 +1858,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1829,7 +1905,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1881,7 +1957,7 @@ static int map_get_next_key(union bpf_attr *attr)
 		return -EPERM;
 
 	if (ukey) {
-		key = __bpf_copy_key(ukey, map->key_size);
+		key = __bpf_copy_key(map, ukey);
 		if (IS_ERR(key))
 			return PTR_ERR(key);
 	} else {
@@ -2170,7 +2246,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
-- 
2.29.2


