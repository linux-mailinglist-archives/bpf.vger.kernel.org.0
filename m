Return-Path: <bpf+bounces-55305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBCA7B68B
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 05:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C517B4E3
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40313D52E;
	Fri,  4 Apr 2025 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv0RsJKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF68633F
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735759; cv=none; b=pUpMknMnPCzX3tIfwPeob65qv6vuTu03gTn2ywLNhvaBnmt2U76IGoq9/njAKDDP67tXmHnO6pEqJA517uJGMtvBMWUJLyz+qAfjKfUGKWJPRmhLwQsgAEwtCUhKVUd41JlA3wAbPdSPTKvhxDLrDKEMsYGKpEpy22/anZEUulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735759; c=relaxed/simple;
	bh=rI4Y5k1mwp544U32qQQIGx9ig7t8T0LiJzxbSFoBqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZqt/SaHvx8E36I1iPDOgnTlNUn7WN/gvdmNpT4j/E+zBkb0g2Mu0oI3Q1O2xi3dwcOgAAicIfhVYZdogonsbFiB778w4dple5Yr4ch7wYqUtcZp0Kw9CEoEc0RwpazoHPQ0qtdg3SLYNO0KCDXH9R+lw7ydCO/kEq/ooFd2Ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv0RsJKQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ad51e7235beso1439692a12.3
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743735756; x=1744340556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3t52AqmCERovAdwdSNyF/Kms1TRCrZy/c/kVxw2Mqc=;
        b=Iv0RsJKQFVjGnrK5vBRIuz4gdoYPkWUGeCxZtekezFL2tHlDrZshLWDWzr22qfr2/b
         3I+9Ogg5cuqVsplu4h58YKRfpyAaXDYRQHUTfEcwgZj/E6lEFZ/Ee33ZW+JkuzqChTyI
         Oclp4ztdXgDENcNb9czEcZT4o/+zZ81r5YiRx7xtb6sVPIFSdqPr/WwQqKeyGyIHJMlq
         DAdHTAA6i42Zia8p7S0WIE1I+Jt1zjq5vS1ERyfXTHrNqf7L++UFMr/v1tMo6Em1Kz7E
         pteavuQeq+9HbtHVRc2QdlFfYHnTYroByRq5on02aJa0EQT6dOoXtFHaL2iiY0tyGCbv
         BRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743735756; x=1744340556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3t52AqmCERovAdwdSNyF/Kms1TRCrZy/c/kVxw2Mqc=;
        b=pJT/VoM8brdh1jxI+zzaSZ0abr1MF0bdk2SAjWicyHxXMcXfhYvM3bK+yz2SjADvY+
         o2P09BAkaWusRfiApa0CNN/qSTlpHhgIOyzQmc6fR2VQ2z6zy+Si+dGriJC2TqW5X+DZ
         AyjbAJS6Z+4NZuGBeVVsduupZjsKj3VRBUnqh93IlUHs1Hlb0bVvFj5dOXXw44+T5tEx
         c+WbHaqOkQ7pw+Ni1gdZP0oaXVquTee/4cf/fyUdZYB19FgfuKzjeuKw0ekXUjMw7l5X
         Bg/fgsCgQI40BJp3Of7FV1jvSmBm/QpPqyX8jt4UOyUYKxw/aThWxLqdsiDSqYJ8cvQG
         L0lg==
X-Gm-Message-State: AOJu0YzgywP+TSe4LEJ0XLn3OfkIvbhlSQLRpVaRoti2U9Xqcdxxuhl2
	V5aMkzD1GFy0Ao9oOkVVJq27NOCTmDUasDJJGncaDFqjcHoSCW1SReCwng==
X-Gm-Gg: ASbGncvOofRC0XttKOvlSH1SaGM5ZUK9VEo7ojdrWDYhnfYMZC824Q+n1k2BsjVnYsb
	jh2WQxUnC8FdBKhtwnnuHyShuipDOJHRhd09hgAlfQnrwP3U0N6+O/Lg48HhJMi7Pt56DDHGzMx
	POOXOWFOcAFaVo24iptVb/nJzepGFhIi0av0rT1Oc/jKB3bsPGOlw0YubKez4QQKEqKO0ORL10T
	XuLR5R+O99bQEzFzOddVR2LQT2m+3f7+aF/TdDEJOXS3R1fChCasbyV2Xk09J9fYC1HSuKyrSKX
	bNIkyjqvNl6NO6dgCSJk3FQVVrp5xCwbx86K9Fd4bTxl2aAWf7z7og2Wa/T/lEH1rNzowfEgV7e
	EDoW1Ekwt0HabU/a9YlE=
X-Google-Smtp-Source: AGHT+IELnCtT9B3IWF6JF6mnI8NiOMntjlfI4vnF3yp5l2NfjfDPi6g2JEn3Mco9p701Xw0hh1Mn9g==
X-Received: by 2002:a17:903:3d0d:b0:224:7a4:b2a with SMTP id d9443c01a7336-22a8a045ceamr21420175ad.11.1743735755834;
        Thu, 03 Apr 2025 20:02:35 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0791sm2262954b3a.110.2025.04.03.20.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:02:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v2 2/4] selftests/bpf: Implement basic uptr KV store
Date: Thu,  3 Apr 2025 20:02:25 -0700
Message-ID: <20250404030227.2690759-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404030227.2690759-1-ameryhung@gmail.com>
References: <20250404030227.2690759-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uptr KV store is a dynamically resizable key-value store that aims to
make rolling out bpf programs with map value layout changes easier by
hiding the layout from bpf program. It is built on top of existing bpf
features with both user space and bpf API. To support usage in bpf
programs on hot paths, only simple APIs such as get/set/delete are
provided in bpf, and space managing API are available in user space API.

To use uptr KV store, the user space program first needs to call
kv_store_init() to allocate memory and setup uptrs in the
task_local_storage of a given process. It will return a pointer to
"struct kv_store" on success, which will be used as a token to access the
KV store in other APIs. Secondly, it needs to initialize all key-value
pairs with kv_store_set(). Then, both bpf and user space program can start
their normal operation.

In the bpf program, the API is designed to minimize map lookups.
Therefore, the bpf program needs to first lookup the task_local_storage.
Then, all bpf APIs will take the map value as the first argument, and
these APIs do not need additional map lookups.

A simple way of using KV store to allow easy bpf program rollout is to use
multiple key-value pairs where the values are primitive datatypes instead
of a structure. This way, adding/deleting fields are just setting/deleting
key-value pairs. The user will not need to worry about how to copy old map
data into a new map with different layout. A more detailed example can
be found in patch 4.

At the core of the KV store are metadata and data. To access the value
stored in the data, the metadata is first queried using an integer key.
The metadata is an array of metadata containing the offset and size of
the values. Both metadata and data are stored in uptr regions in the
task_local_storage.

Note that, it is also possible to support string keys by replacing the
backing storage of metadata with an hashmap. However, the additional map
lookup per get/set/delete will incur higher performance overhead.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/uptr_kv_store.c  | 329 ++++++++++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.h  | 103 ++++++
 .../selftests/bpf/progs/uptr_kv_store.h       | 127 +++++++
 .../selftests/bpf/uptr_kv_store_common.h      |  37 ++
 4 files changed, 596 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/uptr_kv_store_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
new file mode 100644
index 000000000000..53b38ffacd93
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
@@ -0,0 +1,329 @@
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sys/mman.h>
+#include <linux/err.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "task_local_storage_helpers.h"
+#include "uptr_kv_store.h"
+
+struct kv_store {
+	int map_fd;
+	int task_fd;
+	char *map_pin_path;
+	struct kv_store_data_map_value map_val;
+};
+
+static struct kv_store_meta *kvs_store_get_meta(struct kv_store *kvs, int key)
+{
+	return key < kvs->map_val.metas_cnt ? &kvs->map_val.metas->meta[key] : NULL;
+}
+
+static int kv_store_grow_metas(struct kv_store *kvs, int new_metas_cnt)
+{
+	int err, metas_cnt;
+	void *new_metas;
+
+	new_metas = mremap(kvs->map_val.metas,
+			   sizeof(struct kv_store_meta) * kvs->map_val.metas_cnt,
+			   sizeof(struct kv_store_meta) * new_metas_cnt, 0);
+
+	if (new_metas == MAP_FAILED || new_metas != kvs->map_val.metas)
+		return -EFAULT;
+
+	metas_cnt = kvs->map_val.metas_cnt;
+	kvs->map_val.metas_cnt = new_metas_cnt;
+	err = bpf_map_update_elem(kvs->map_fd, &kvs->task_fd, &kvs->map_val, 0);
+	if (err) {
+		kvs->map_val.metas_cnt = metas_cnt;
+		return err;
+	}
+	return 0;
+}
+
+static int kv_store_grow_page(struct kv_store *kvs, int new_page_size)
+{
+	int err, page_size;
+	void *new_page;
+
+	new_page = mremap(kvs->map_val.page, kvs->map_val.page_size,
+			  new_page_size, 0);
+
+	if (new_page == MAP_FAILED || new_page != kvs->map_val.page)
+		return -EFAULT;
+
+	page_size = kvs->map_val.page_size;
+	kvs->map_val.page_size = new_page_size;
+	err = bpf_map_update_elem(kvs->map_fd, &kvs->task_fd, &kvs->map_val, 0);
+	if (err) {
+		kvs->map_val.page_size = page_size;
+		return err;
+	}
+	return 0;
+}
+
+void kv_store_close(struct kv_store *kvs)
+{
+	munmap(kvs->map_val.metas, sizeof(struct kv_store_meta) * kvs->map_val.metas_cnt);
+	munmap(kvs->map_val.page, kvs->map_val.page_size);
+
+	if (kvs->map_pin_path)
+		unlink(kvs->map_pin_path);
+
+	free(kvs);
+}
+
+struct kv_store *kv_store_init(int pid, struct bpf_map *data_map, const char *pin_path,
+			       struct kv_pairs *kvp)
+{
+	struct kv_store *kvs;
+	int i, err;
+	size_t metas_cnt = 0, data_size = 0;
+
+	kvs = calloc(1, sizeof(*kvs));
+	if (!kvs) {
+		errno = -ENOMEM;
+		return NULL;
+	}
+
+	if (kvp) {
+		for (i = 0; i < kvp->array_cnt; i++) {
+			if (kvp->array[i].size > KVS_MAX_VAL_SIZE ||
+			    kvp->array[i].size + data_size > PAGE_SIZE)
+				continue;
+			metas_cnt = metas_cnt > kvp->array[i].key ? metas_cnt : kvp->array[i].key + 1;
+			data_size += kvp->array[i].size;
+		}
+	} else {
+		metas_cnt = 16;
+		data_size = 256;
+	}
+
+	kvs->map_val.metas_cnt = metas_cnt;
+	kvs->map_val.metas = mmap(NULL, metas_cnt * sizeof(struct kv_store_meta),
+				  PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (kvs->map_val.metas == MAP_FAILED) {
+		errno = -ENOMEM;
+		return NULL;
+	}
+
+	kvs->map_val.page_size = data_size;
+	kvs->map_val.page = mmap(NULL, data_size,
+				 PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (kvs->map_val.page == MAP_FAILED) {
+		munmap(kvs->map_val.metas, sizeof(struct kv_store_metas));
+		errno = -ENOMEM;
+		goto err;
+	}
+
+	kvs->map_fd = bpf_map__fd(data_map);
+	if (!kvs->map_fd) {
+		errno = -ENOENT;
+		goto err;
+	}
+
+	kvs->task_fd = sys_pidfd_open(pid, 0);
+	if (!kvs->task_fd) {
+		errno = -ESRCH;
+		goto err;
+	}
+
+	err = bpf_map_update_elem(kvs->map_fd, &kvs->task_fd, &kvs->map_val, 0);
+	if (err) {
+		errno = err;
+		goto err;
+	}
+
+	kvs->map_pin_path = strdup(pin_path);
+	if (!kvs->map_pin_path)
+		goto err;
+
+	err = bpf_map__pin(data_map, kvs->map_pin_path);
+	if (err) {
+		errno = err;
+		goto err;
+	}
+
+	if (kvp) {
+		data_size = 0;
+		for (i = 0; i < kvp->array_cnt; i++) {
+			struct kv_store_meta *meta;
+
+			meta = &kvs->map_val.metas->meta[kvp->array[i].key];
+
+			if (kvp->array[i].size > KVS_MAX_VAL_SIZE ||
+			    kvp->array[i].size + data_size > PAGE_SIZE)
+				continue;
+
+			if (kvp->array[i].val) {
+				memcpy(kvs->map_val.page->data + data_size,
+				       kvp->array[i].val,
+				       kvp->array[i].size);
+			}
+
+			meta->page_off = data_size;
+			meta->size = kvp->array[i].size;
+			meta->init = 1;
+
+			data_size += kvp->array[i].size;
+		}
+	}
+
+	return kvs;
+err:
+	kv_store_close(kvs);
+	return NULL;
+}
+
+int kv_store_reuse(struct kv_store *kvs, struct bpf_map *data_map)
+{
+	return bpf_map__reuse_fd(data_map, kvs->map_fd);
+}
+
+static int comp_kv_pair(const void *kv1, const void *kv2)
+{
+	return ((const struct kv_pair *)kv1)->key -
+	       ((const struct kv_pair *)kv2)->key;
+}
+
+int __kv_store_set(struct kv_store *kvs, int key, void *val, unsigned int val_size);
+
+void kv_store_update(struct kv_store *kvs, struct kv_pairs *kvp)
+{
+	int i = 0, j = 0;
+
+	qsort(kvp->array, kvp->array_cnt, sizeof(struct kv_pair), comp_kv_pair);
+
+	/* for key = [0, max kvp key], delete unused key-value pairs and add new ones */
+	while (j < kvp->array_cnt) {
+		if (i < kvp->array[j].key) {
+			if (kvs->map_val.metas->meta[i].init)
+				kv_store_delete(kvs, i);
+			i++;
+			continue;
+		}
+
+		if (kvs->map_val.metas->meta[i].init &&
+		    kvs->map_val.metas->meta[i].size != kvp->array[j].size)
+			kv_store_delete(kvs, i);
+
+		if (kvs->map_val.metas->meta[i].size != kvp->array[j].size ||
+		    kvp->array[j].val)
+			__kv_store_set(kvs, kvp->array[j].key, kvp->array[j].val,
+				       kvp->array[j].size);
+		i++;
+		j++;
+	}
+	/* for key = [max kvp key + 1, max kvs key], delete unused key-value pairs */
+	for (; i < kvs->map_val.metas_cnt; i++)
+		if (kvs->map_val.metas->meta[i].init)
+			kv_store_delete(kvs, i);
+}
+
+void *kv_store_get(struct kv_store *kvs, int key)
+{
+	struct kv_store_meta *meta;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta || !meta->init)
+		return NULL;
+
+	return kvs->map_val.page->data + meta->page_off;
+}
+
+static int comp_meta(const void *m1, const void *m2)
+{
+	const struct kv_store_meta *meta1 = (const struct kv_store_meta *)m1;
+	const struct kv_store_meta *meta2 = (const struct kv_store_meta *)m2;
+
+	return (meta1->page_off + meta1->init ? 0 : PAGE_SIZE) -
+	       (meta2->page_off + meta2->init ? 0 : PAGE_SIZE);
+}
+
+static int kv_store_find_next_slot(struct kv_store *kvs, int size, struct kv_store_meta *meta)
+{
+	struct kv_store_meta metas[KVS_MAX_VAL_ENTRIES];
+	int i, err, off = 0;
+
+	if (size > KVS_MAX_VAL_SIZE)
+		return -E2BIG;
+
+	memcpy(metas, kvs->map_val.metas, sizeof(struct kv_store_meta) * kvs->map_val.metas_cnt);
+
+	qsort(metas, kvs->map_val.metas_cnt, sizeof(struct kv_store_meta), comp_meta);
+
+	for (i = 0; i < kvs->map_val.metas_cnt; i++) {
+		if (metas[i].page_off - off >= size || !metas[i].init)
+			break;
+		off = metas[i].page_off + metas[i].size;
+	}
+
+	if (size + off > PAGE_SIZE)
+		return -ENOSPC;
+
+	if (size + off > kvs->map_val.page_size) {
+		err = kv_store_grow_page(kvs, size + off);
+		if (err)
+			return err;
+	}
+
+	meta->page_off = off;
+	meta->size = size;
+	return 0;
+}
+
+int __kv_store_set(struct kv_store *kvs, int key, void *val, unsigned int val_size)
+{
+	struct kv_store_meta *meta;
+	int err;
+
+	if (key >= kvs->map_val.metas_cnt && key < KVS_MAX_VAL_ENTRIES) {
+		err = kv_store_grow_metas(kvs, key + 1);
+		if (err)
+			return err;
+	}
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta)
+		return -ENOENT;
+
+	if (!meta->init) {
+		err = kv_store_find_next_slot(kvs, val_size, meta);
+		if (err)
+			return err;
+	}
+
+	val_size = val_size < meta->size ? val_size : meta->size;
+	if (val)
+		memcpy(kvs->map_val.page->data + meta->page_off, val, val_size);
+	else
+		memset(kvs->map_val.page->data + meta->page_off, 0, val_size);
+
+	meta->init = 1;
+	return 0;
+}
+
+int kv_store_set(struct kv_store *kvs, int key, void *val, unsigned int val_size)
+{
+	if (!val)
+		return -EINVAL;
+
+	return __kv_store_set(kvs, key, val, val_size);
+}
+
+void kv_store_delete(struct kv_store *kvs, int key)
+{
+	struct kv_store_meta *meta;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta)
+		return;
+
+	memset(kvs->map_val.page->data + meta->page_off, 0, meta->size);
+	memset(meta, 0, sizeof(*meta));
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
new file mode 100644
index 000000000000..bab0aba3e338
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
@@ -0,0 +1,103 @@
+#ifndef _UPTR_KV_STORE_H
+#define _UPTR_KV_STORE_H
+
+#include "uptr_kv_store_common.h"
+
+struct kv_store;
+
+struct kv_pair {
+	int key;
+	int size;
+	void *val;
+};
+
+struct kv_pairs {
+	int array_cnt;
+	struct kv_pair array[];
+};
+
+/**
+ * @brief kv_store_close() closes a KV store object and release all resources.
+ *
+ * @param kvs A pointer to a KV store object
+ */
+void kv_store_close(struct kv_store *kvs);
+
+/**
+ * @brief kv_store_init() creates a KV store object backed by uptr in a task
+ * local storage map shared between user space and bpf programs. It allocates
+ * memory to be assigned to uptr, initializes key-value pairs, updates the
+ * task local storage map and pins the map to bpffs for reuse.
+ *
+ * @param pid The pid of the process whose task local storage will be used
+ * @param data_map The bpf task local storage map defined in the bpf uptr KV
+ * store header
+ * @param pin_path The path of which the task local storage map will be pinned
+ * (must be under bpffs)
+ * @param kvp A pointer to a list of key-value pairs for initializing the KV
+ * store. If kv_pair::val is NULL, the value will be initialized. If kvp is not
+ * provided, a default of 16-key, 256-byte value storage KV store will be
+ * created. Users can still initialize the KV store later using kv_store_set().
+ * @return A pointer to a KV store object on success; NULL on error
+ */
+struct kv_store *kv_store_init(int pid, struct bpf_map *data_map, const char *pin_path,
+			       struct kv_pairs *kvp);
+
+/**
+ * @brief kv_store_reuse() tells libbpf to reuse the task localstorage map
+ * associated with a KV store object before loading a new bpf program. It must
+ * be called before loading a bpf program using libbpf so that no new map is
+ * created (e.g., call it after skeleton __open() and before __load())
+ *
+ * @param kvs A pointer to a KV store object
+ * @param data_map The bpf task local storage map defined in the bpf uptr KV
+ * store header
+ * @return 0 on success; negative error code, otherwise
+ */
+int kv_store_reuse(struct kv_store *kvs, struct bpf_map *data_map);
+
+/**
+ * @brief kv_store_update() updates a KV store object according a list of
+ * key-value pairs.
+ *
+ * @param kvs A pointer to a KV store object
+ * @param kvp A pointer to a list of key-value pairs for updating the KV store.
+ * Keys in kvs that do not present in kvp or exist but have different value
+ * sizes will be deleted. New key-value pairs will be set. For existing
+ * key-value pairs, if kv_pair::val is provided, the value will be updated.
+ * @return A pointer to a KV store object on success; NULL on error
+ */
+void kv_store_update(struct kv_store *kvs, struct kv_pairs *kvp);
+
+/**
+ * @brief kv_store_get() gets the value corresponding to a key.
+ *
+ * @param kvs A pointer to a KV store object
+ * @param key An integer key, whose value will be retrieved
+ * @return A pointer to the value corresponding to the key on success; NULL if
+ * the key-value pair does not exist
+ */
+void *kv_store_get(struct kv_store *kvs, int key);
+
+/**
+ * @brief kv_store_set() sets the value corresponding to a key. If the key already
+ * exists, updates the value. Otherwise, creates a new key-value pair.
+ *
+ * @param kvs A pointer to a KV store object
+ * @param key The integer key of the value to be set. Must be within the range
+ * [0, 1023]
+ * @param val A pointer to the value to be stored. Cannot be NULL
+ * @param val_size The size of the value in bytes. Must be within [0, 4096]
+ * @return 0 on success; negative error code, otherwise
+ */
+int kv_store_set(struct kv_store *kvs, int key, void *val, unsigned int val_size);
+
+/**
+ * @brief kv_store_delete() deletes a key-value pair.
+ *
+ * @param kvs A pointer to a KV store object
+ * @param key The integer key of the key-value pair to be deleted
+ */
+void kv_store_delete(struct kv_store *kvs, int key);
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/uptr_kv_store.h b/tools/testing/selftests/bpf/progs/uptr_kv_store.h
new file mode 100644
index 000000000000..05c6be9bc7a3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_kv_store.h
@@ -0,0 +1,127 @@
+#ifndef _UPTR_KV_STORE_H
+#define _UPTR_KV_STORE_H
+
+#include <errno.h>
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+
+#include "uptr_kv_store_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct kv_store_data_map_value);
+} data_map SEC(".maps");
+
+__attribute__((unused))
+static int kv_store_set(struct kv_store_data_map_value *data, u16 key, void *val, int val_size)
+{
+	struct kv_store_meta *meta;
+	struct bpf_dynptr ptr;
+	int err = 0;
+
+	if (!data || !data->metas || !data->page)
+		return -ENOENT;
+
+	if (key >= KVS_MAX_VAL_ENTRIES || key >= data->metas_cnt)
+		return -ENOENT;
+
+	meta = &data->metas->meta[key];
+	if (!meta->init)
+		return -ENOENT;
+
+	switch (meta->size) {
+	case 1:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 1)
+			return -EFAULT;
+		*(u8 *)(data->page->data + meta->page_off) = *(u8 *)val;
+		break;
+	case 4:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 4)
+			return -EFAULT;
+		*(u32 *)(data->page->data + meta->page_off) = *(u32 *)val;
+		break;
+	case 8:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 8)
+			return -EFAULT;
+		*(u64 *)(data->page->data + meta->page_off) = *(u64 *)val;
+		break;
+	default:
+		if (meta->page_off >= KVS_MAX_VAL_SIZE)
+			return -EFAULT;
+
+		err = bpf_dynptr_from_mem(data->page->data, KVS_MAX_VAL_SIZE, 0, &ptr);
+		if (err)
+			return err;
+
+		val_size = val_size > meta->size ? meta->size : val_size;
+		err = bpf_dynptr_write(&ptr, meta->page_off, val, val_size, 0);
+	}
+	return err;
+}
+
+__attribute__((unused))
+static int kv_store_get(struct kv_store_data_map_value *data, u16 key, void *val, int val_size)
+{
+	struct kv_store_meta *meta;
+	struct bpf_dynptr ptr;
+	int err = 0;
+
+	if (!data || !data->metas || !data->page)
+		return -ENOENT;
+
+	if (key >= KVS_MAX_VAL_ENTRIES || key >= data->metas_cnt)
+		return -ENOENT;
+
+	meta = &data->metas->meta[key];
+	if (!meta->init)
+		return -ENOENT;
+
+	switch (meta->size) {
+	case 1:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 1)
+			return -EFAULT;
+		*(u8 *)val = *(u8 *)(data->page->data + meta->page_off);
+		break;
+	case 4:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 4)
+			return -EFAULT;
+		*(u32 *)val = *(u32 *)(data->page->data + meta->page_off);
+		break;
+	case 8:
+		if (meta->page_off > KVS_MAX_VAL_SIZE - 8)
+			return -EFAULT;
+		*(u64 *)val = *(u64 *)(data->page->data + meta->page_off);
+		break;
+	default:
+		if (meta->page_off >= KVS_MAX_VAL_SIZE)
+			return -EFAULT;
+
+		err = bpf_dynptr_from_mem(data->page->data, KVS_MAX_VAL_SIZE, 0, &ptr);
+		if (err)
+			return err;
+
+		val_size = val_size > meta->size ? meta->size : val_size;
+		err = bpf_dynptr_read(val, val_size, &ptr, meta->page_off, 0);
+	}
+	return err;
+}
+
+__attribute__((unused))
+static int kv_store_delete(struct kv_store_data_map_value *data, u16 key)
+{
+	struct kv_store_meta *meta;
+
+	if (!data || !data->metas)
+		return -ENOENT;
+
+	if (key >= KVS_MAX_VAL_ENTRIES)
+		return -ENOENT;
+
+	meta = &data->metas->meta[key];
+	meta->init = 0;
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/uptr_kv_store_common.h b/tools/testing/selftests/bpf/uptr_kv_store_common.h
new file mode 100644
index 000000000000..2f1f04e523d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/uptr_kv_store_common.h
@@ -0,0 +1,37 @@
+#ifndef _UPTR_KV_STORE_COMMON_H
+#define _UPTR_KV_STORE_COMMON_H
+
+#define PAGE_SIZE		4096
+#define KVS_MAX_VAL_SIZE	PAGE_SIZE
+#define KVS_MAX_VAL_ENTRIES	1024
+
+#ifdef __BPF__
+struct kv_store_page *dummy_page;
+struct kv_store_metas *dummy_metas;
+#else
+#define __uptr
+#define __kptr
+#endif
+
+struct kv_store_meta {
+	__u32 page_off:12;
+	__u32 size:12;
+	__u32 init:1;
+};
+
+struct kv_store_metas {
+	struct kv_store_meta meta[KVS_MAX_VAL_ENTRIES];
+};
+
+struct kv_store_data_map_value {
+	struct kv_store_metas __uptr *metas;
+	struct kv_store_page __uptr *page;
+	u16 metas_cnt;
+	u16 page_size;
+};
+
+struct kv_store_page {
+	char data[KVS_MAX_VAL_SIZE];
+};
+
+#endif
-- 
2.47.1


