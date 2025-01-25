Return-Path: <bpf+bounces-49787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CDA1C2D1
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FC41664A6
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA018207E11;
	Sat, 25 Jan 2025 10:59:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A461DC9B1
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802755; cv=none; b=hwzZjI+JGXA9b9v4KMV70ywqlejNVoo+Ovsh7Tv0Ec08H/NBkY0CRTY3yyT7NjKvcJX7rJN52X5bzNF0aISHLYTD38Zf2tfps1Nfs8TawmWcSuLItOKax6B6AjLJ74lSRQxQoZ5negJmtUBcqKLUsUyGKXukiAKVG1SZnUflb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802755; c=relaxed/simple;
	bh=xs+dD/BAxXp8EPqSntj+W88qv5kZre2d20+q3Obtkjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRUOe7zumcDmGZIfTR/INYlNs0ws/wy8SJcdpco6xDTaw3v1OPj3Nn4YGIasSQ5Y1sA/00PtT7qGoXl0/URtMfz9KGk6rzPuNmziPQyDr2zZxhmNy11/yQW2XIxJifmLacGhwShPe21ZHY++97cXKwrNuI52N5Pw+X5qtvwCmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWC5S0kz4f3kvf
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C14F21A106D
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S15;
	Sat, 25 Jan 2025 18:59:09 +0800 (CST)
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
Subject: [PATCH bpf-next v2 11/20] bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
Date: Sat, 25 Jan 2025 19:11:00 +0800
Message-Id: <20250125111109.732718-12-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S15
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43XrW7JrWkur1DuryUZFb_yoWrtF4fpF
	48WryfZrWFvr43Jr95t3WFvw4rWrn2qw1UG3sxJas5Wa1DXrZ8Xr1IgFZYgryYqFykXrn8
	Jr4Dta4rCry8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_copy_from_dynptr_ukey() helper to handle map key with
bpf_dynptr when the map key is used in map lookup, update, delete and
get_next_key operations.

The helper places all variable-length data of these bpf_dynptr_user
objects at the end of the map key to simplify the allocation and the
freeing of map key with dynptr.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 98 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 79459b218109e..1f0684ba0a204 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1711,10 +1711,83 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *__bpf_copy_key(void __user *ukey, u64 key_size)
+static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 {
-	if (key_size)
-		return vmemdup_user(ukey, key_size);
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
+		if (!uptr->size || uptr->size > map->map_extra || uptr->reserved) {
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
@@ -1722,10 +1795,13 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
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
@@ -1762,7 +1838,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
@@ -1829,7 +1905,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1876,7 +1952,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1928,7 +2004,7 @@ static int map_get_next_key(union bpf_attr *attr)
 		return -EPERM;
 
 	if (ukey) {
-		key = __bpf_copy_key(ukey, map->key_size);
+		key = __bpf_copy_key(map, ukey);
 		if (IS_ERR(key))
 			return PTR_ERR(key);
 	} else {
@@ -2225,7 +2301,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
-- 
2.29.2


