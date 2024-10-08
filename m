Return-Path: <bpf+bounces-41205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88399438E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEF02833BA
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197317BEAC;
	Tue,  8 Oct 2024 09:02:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64913A878
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378154; cv=none; b=n4ixbKJlNFX1vy5zjeRGIReh81sTyARXw8oxUFJwV7ws+vhFbx5JONV8JUYQQQt9FYZehAoLzSwHHfhvIgzWGBFFw1c/FnskJDHzJCdF1luCOJeG3XKkp/bTKNPIa4StrjIVEsLwCroniW7XHG/8AEITq2zBGB4faojBfmvl/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378154; c=relaxed/simple;
	bh=RvE+LTUJOvFTb5I4Ku5u7U5B5d+nmKjUsauimT3CG8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX777IELracaRu50uvERJLLVXSSaX/jVnh9y5TLM+MnMKFhgNST6/bwO94ZBBkKo1cAMGRRhYzFcTHg4u6hkOMS9FjQu2qeAD8S9WO66L2LVNjWC/YaJ3omLlylAS+BcBqf6SPdrEOKEGCuO1+xQhtRhvpkAip8CqS5iYj7cVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9552QbVz4f3jqx
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 10FF81A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S12;
	Tue, 08 Oct 2024 17:02:28 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 08/16] bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
Date: Tue,  8 Oct 2024 17:14:53 +0800
Message-ID: <20241008091501.8302-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45CFWUWr45Jr1DCw18Grg_yoWrtry3pF
	W8WryfZrWFvr43Jr95J3WFva1rWrn2qw1UG3srJas5W3WDXrZ8Xr1xtFZYgryY9FykXrn8
	Jr4Dta4rCry8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUoo7KUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_copy_from_dynptr_ukey() helper to handle map key with
bpf_dynptr when the map key is used in map lookup, update, delete and
get_next_key operations.

The helper places all variable-length data of these bpf_dynptr_user
objects at the end of the map key to simplify the allocate and the free
of map key with dynptr.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 98 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aa0a500f8fad..5bd75db9b12f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1540,10 +1540,83 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *__bpf_copy_key(void __user *ukey, u64 key_size)
+static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
+{
+	const struct btf_record *record;
+	const struct btf_field *field;
+	struct bpf_dynptr_user *uptr;
+	struct bpf_dynptr_kern *kptr;
+	void *key, *new_key, *kdata;
+	unsigned int key_size, size;
+	bpfptr_t udata;
+	unsigned int i;
+	int err;
+
+	key_size = map->key_size;
+	key = kvmemdup_bpfptr(ukey, key_size);
+	if (!key)
+		return ERR_PTR(-ENOMEM);
+
+	size = key_size;
+	record = map->key_record;
+	for (i = 0; i < record->cnt; i++) {
+		field = &record->fields[i];
+		if (field->type != BPF_DYNPTR)
+			continue;
+		uptr = key + field->offset;
+		if (!uptr->size || uptr->size > map->map_extra || uptr->rsvd) {
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
+		udata = make_bpfptr(uptr->data, bpfptr_is_kernel(ukey));
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
 {
-	if (key_size)
-		return vmemdup_user(ukey, key_size);
+	if (bpf_map_has_dynptr_key(map))
+		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey));
+
+	if (map->key_size)
+		return vmemdup_user(ukey, map->key_size);
 
 	if (ukey)
 		return ERR_PTR(-EINVAL);
@@ -1551,10 +1624,13 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
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
@@ -1591,7 +1667,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
@@ -1658,7 +1734,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1705,7 +1781,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1757,7 +1833,7 @@ static int map_get_next_key(union bpf_attr *attr)
 		return -EPERM;
 
 	if (ukey) {
-		key = __bpf_copy_key(ukey, map->key_size);
+		key = __bpf_copy_key(map, ukey);
 		if (IS_ERR(key))
 			return PTR_ERR(key);
 	} else {
@@ -2054,7 +2130,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
-- 
2.44.0


