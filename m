Return-Path: <bpf+bounces-54798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17BA72B5D
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45F61898A60
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7C20551B;
	Thu, 27 Mar 2025 08:23:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD5204F7F
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063786; cv=none; b=WenKj9HEGoJdikBg0lSXB9ctbldM4ak81Ay7IobhvJq9symrqBGiJE46u/KJmyKhQjtinEz+cvvH4MIi57bywGbEOSebsShaNXF1W4H6f35+Xr8t1LAgFbTLJnonp2EaI8pi9MhKqss/BFBqr3GvAiicKyg++wu5bbvzYVwb0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063786; c=relaxed/simple;
	bh=6NmuHmprQGQyMyd6DhwXoJJEJPrriVBTKeim9p4R4E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOg3sM7t9XpKsovgv6R6CiUwTx1Fsb+p07Kggjy3PXAHcZDmMqmOqmRUAJix/32Tex5rPWQzhOw8MHPC6ewGhZrgkeJ6a+aAEtsWA+wmhhHwQ8TPO4fj74UVMeBLC+fM5XddXJFnOcH0iDfKF7XEplbsH3a9Ji7dXcLuPicq5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8m5DQTz4f3jXm
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD7EE1A0AD5
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S12;
	Thu, 27 Mar 2025 16:22:55 +0800 (CST)
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
Subject: [PATCH bpf-next v3 08/16] bpf: Handle bpf_dynptr in bpf syscall when it is used as output
Date: Thu, 27 Mar 2025 16:34:47 +0800
Message-Id: <20250327083455.848708-9-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S12
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1fuF1DAr4fAF1rJw1fWFg_yoW7KF15pF
	48G3sxZr4Fqr43JFZ8X3Wjv3yrtrn7Ww1UGas3Ka4rWF9xWr90vr1xKFW09ryYvFyDCr12
	vws2qr98ZrWxJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

For get_next_key operation, unext_key is used as an output argument.
When there is dynptr in map key, unext_key will also be used as an input
argument, because the userspace application needs to pre-allocate a
buffer for each variable-length part in the map key and save the
length and the address of these buffers in bpf_dynptr objects.

To support get_next_key op for map with dynptr key, map_get_next_key()
first calls bpf_copy_from_dynptr_ukey() to construct a map key in which
each bpf_dynptr_kern object has the same size as the corresponding
bpf_dynptr object. It then calls ->map_get_next_key() to get the
next_key, and finally calls bpf_copy_to_dynptr_ukey() to copy both the
non-dynptr part and dynptr part in the map key to unext_key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 89 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d6dbcea3c30cb..40c3d85b06bae 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1664,7 +1664,7 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
+static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey, bool copy_data)
 {
 	const struct btf_record *record;
 	const struct btf_field *field;
@@ -1672,7 +1672,6 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 	void *key, *new_key, *kdata;
 	unsigned int key_size, size;
 	struct bpf_dynptr *uptr;
-	bpfptr_t udata;
 	unsigned int i;
 	int err;
 
@@ -1687,6 +1686,7 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 		field = &record->fields[i];
 		if (field->type != BPF_DYNPTR)
 			continue;
+
 		uptr = key + field->offset;
 		if (!uptr->size || uptr->reserved) {
 			err = -EINVAL;
@@ -1717,10 +1717,14 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 
 		uptr = key + field->offset;
 		size = uptr->size;
-		udata = make_bpfptr((u64)(uintptr_t)uptr->data, bpfptr_is_kernel(ukey));
-		if (copy_from_bpfptr(kdata, udata, size)) {
-			err = -EFAULT;
-			goto free_key;
+		if (copy_data) {
+			bpfptr_t udata = make_bpfptr((u64)(uintptr_t)uptr->data,
+						     bpfptr_is_kernel(ukey));
+
+			if (copy_from_bpfptr(kdata, udata, size)) {
+				err = -EFAULT;
+				goto free_key;
+			}
 		}
 		kptr = (struct bpf_dynptr_kern *)uptr;
 		bpf_dynptr_init(kptr, kdata, BPF_DYNPTR_TYPE_LOCAL, 0, size);
@@ -1737,7 +1741,7 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
 {
 	if (bpf_map_has_dynptr_key(map))
-		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey));
+		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey), true);
 
 	if (map->key_size)
 		return vmemdup_user(ukey, map->key_size);
@@ -1751,7 +1755,7 @@ static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
 static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 {
 	if (bpf_map_has_dynptr_key(map))
-		return bpf_copy_from_dynptr_ukey(map, ukey);
+		return bpf_copy_from_dynptr_ukey(map, ukey, true);
 
 	if (map->key_size)
 		return kvmemdup_bpfptr(ukey, map->key_size);
@@ -1762,6 +1766,51 @@ static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 	return NULL;
 }
 
+static int bpf_copy_to_dynptr_ukey(const struct bpf_map *map,
+				   void __user *ukey, void *key)
+{
+	struct bpf_dynptr __user *uptr;
+	struct bpf_dynptr_kern *kptr;
+	struct btf_record *record;
+	unsigned int i, offset;
+
+	offset = 0;
+	record = map->key_record;
+	for (i = 0; i < record->cnt; i++) {
+		struct btf_field *field;
+		unsigned int size;
+		void *udata;
+
+		field = &record->fields[i];
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		/* Any no-dynptr part before the dynptr ? */
+		if (offset < field->offset &&
+		    copy_to_user(ukey + offset, key + offset, field->offset - offset))
+			return -EFAULT;
+
+		/* dynptr part */
+		uptr = ukey + field->offset;
+		if (copy_from_user(&udata, &uptr->data, sizeof(udata)))
+			return -EFAULT;
+
+		kptr = key + field->offset;
+		size = __bpf_dynptr_size(kptr);
+		if (copy_to_user((void __user *)udata, __bpf_dynptr_data(kptr, size), size) ||
+		    put_user(size, &uptr->size) || put_user(0, &uptr->reserved))
+			return -EFAULT;
+
+		offset = field->offset + field->size;
+	}
+
+	if (offset < map->key_size &&
+	    copy_to_user(ukey + offset, key + offset, map->key_size - offset))
+		return -EFAULT;
+
+	return 0;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1964,10 +2013,19 @@ static int map_get_next_key(union bpf_attr *attr)
 		key = NULL;
 	}
 
-	err = -ENOMEM;
-	next_key = kvmalloc(map->key_size, GFP_USER);
-	if (!next_key)
+	if (bpf_map_has_dynptr_key(map))
+		next_key = bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(unext_key), false);
+	else
+		next_key = kvmalloc(map->key_size, GFP_USER);
+	if (IS_ERR_OR_NULL(next_key)) {
+		if (!next_key) {
+			err = -ENOMEM;
+		} else {
+			err = PTR_ERR(next_key);
+			next_key = NULL;
+		}
 		goto free_key;
+	}
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_get_next_key(map, key, next_key);
@@ -1981,12 +2039,13 @@ static int map_get_next_key(union bpf_attr *attr)
 	if (err)
 		goto free_next_key;
 
-	err = -EFAULT;
-	if (copy_to_user(unext_key, next_key, map->key_size) != 0)
+	if (bpf_map_has_dynptr_key(map))
+		err = bpf_copy_to_dynptr_ukey(map, unext_key, next_key);
+	else
+		err = copy_to_user(unext_key, next_key, map->key_size) ? -EFAULT : 0;
+	if (err)
 		goto free_next_key;
 
-	err = 0;
-
 free_next_key:
 	kvfree(next_key);
 free_key:
-- 
2.29.2


