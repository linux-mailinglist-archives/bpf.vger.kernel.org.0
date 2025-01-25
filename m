Return-Path: <bpf+bounces-49791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1EA1C2D6
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476C5188C2CD
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE72080DC;
	Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F531DDA3C
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802756; cv=none; b=ZgUyRmPeE6+pK4HZO9Hh12wbjFsEdNRdkL913FZQMS/npy7fpR6buAJmxRL1unVjxQHInmmDvQRBzgNXajZaK+TKKP24Ots45gC5ZIMRrM32DE9dxTPdzjOP2dijcaYyiFLLeytPmDQJtD7IoJjexaGH9/bZga1I0danNGTQeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802756; c=relaxed/simple;
	bh=2ust30F8/FY1jbaob/aPshja/XaVcRjs+q8IwSnmzhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJ7oVMxIMj6tbe/RnvHc1rxTDPIbVtb9mvPDZ9JbVia6Ly44LDAbfJqxzr0ru9o05T0RBXRNTg7DY+bNjPDIo7PPE7RJAXyb1GY7sOPrkW0PhzyG6ZT5cj9REwz6/FEoMm6QQ8ytS63ugG3KtN4Y3GB54wfqeAHPLSSAO4XQPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWD2hb5z4f3kvl
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 630F31A1068
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S16;
	Sat, 25 Jan 2025 18:59:10 +0800 (CST)
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
Subject: [PATCH bpf-next v2 12/20] bpf: Handle bpf_dynptr_user in bpf syscall when it is used as output
Date: Sat, 25 Jan 2025 19:11:01 +0800
Message-Id: <20250125111109.732718-13-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S16
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1fuF1DAr4fAF1rJw1fWFg_yoW7Kw1kpF
	48G3sxZr4Fqr43JFZ8Xa4qv3yrJrn7Ww1UGas5Ka4rXF9xWr90vr1xKFW09r90vFyDCr12
	vws2qr98ur4xJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

For get_next_key operation, unext_key is used as an output argument.
When there is dynptr in map key, unext_key will also be used as an input
argument, because the userspace application needs to pre-allocate a
buffer for each variable-length part in the map key and save the
length and the address of these buffers in bpf_dynptr_user objects.

To support get_next_key op for map with dynptr key, map_get_next_key()
first calls bpf_copy_from_dynptr_ukey() to construct a map key in which
each bpf_dynptr_kern object has the same size as the corresponding
bpf_dynptr_user object. It then calls ->map_get_next_key() to get the
next_key, and finally calls bpf_copy_to_dynptr_ukey() to copy both the
non-dynptr part and dynptr part in the map key to unext_key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 89 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1f0684ba0a204..dc29fa897855c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1711,7 +1711,7 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
+static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey, bool copy_data)
 {
 	const struct btf_record *record;
 	const struct btf_field *field;
@@ -1719,7 +1719,6 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 	struct bpf_dynptr_kern *kptr;
 	void *key, *new_key, *kdata;
 	unsigned int key_size, size;
-	bpfptr_t udata;
 	unsigned int i;
 	int err;
 
@@ -1734,6 +1733,7 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 		field = &record->fields[i];
 		if (field->type != BPF_DYNPTR)
 			continue;
+
 		uptr = key + field->offset;
 		if (!uptr->size || uptr->size > map->map_extra || uptr->reserved) {
 			err = -EINVAL;
@@ -1764,10 +1764,14 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 
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
@@ -1784,7 +1788,7 @@ static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
 static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
 {
 	if (bpf_map_has_dynptr_key(map))
-		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey));
+		return bpf_copy_from_dynptr_ukey(map, USER_BPFPTR(ukey), true);
 
 	if (map->key_size)
 		return vmemdup_user(ukey, map->key_size);
@@ -1798,7 +1802,7 @@ static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
 static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 {
 	if (bpf_map_has_dynptr_key(map))
-		return bpf_copy_from_dynptr_ukey(map, ukey);
+		return bpf_copy_from_dynptr_ukey(map, ukey, true);
 
 	if (map->key_size)
 		return kvmemdup_bpfptr(ukey, map->key_size);
@@ -1809,6 +1813,51 @@ static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 	return NULL;
 }
 
+static int bpf_copy_to_dynptr_ukey(const struct bpf_map *map,
+				   void __user *ukey, void *key)
+{
+	struct bpf_dynptr_user __user *uptr;
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
 
@@ -2011,10 +2060,19 @@ static int map_get_next_key(union bpf_attr *attr)
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
@@ -2028,12 +2086,13 @@ static int map_get_next_key(union bpf_attr *attr)
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


