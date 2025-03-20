Return-Path: <bpf+bounces-54498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6091A6B00B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0EF189F2FA
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7998229B2C;
	Thu, 20 Mar 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACpt6snz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F322170A
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506873; cv=none; b=anrPANAmSdz5+r/OsyDefOuYlTWKPm5S/4q8zHORxCbqpFa988TIiHXolGVtX64zfr3LIn+jFfBSAgXNUKU81ueKPokoHkaDSHs61M50j6oo4YyI9WPQcFzUywikNgvpw5msqpnBuqZ68MsPZG2KNFKrqkK3hgbgrrbi0V28ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506873; c=relaxed/simple;
	bh=kyPOx8CHFrW1aXtiSXucDSto5ZMuATFzfCjcH2K8kwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF7ep4oiWrCSrSPt0bdwqYxKWALgnkco7u1mD41KgP3u54xNsJEGwa+orCLa31NmEyl63rupdG8RsynujR9OUhl1quj5RFCgItPwy2OCEdTHWujcXyfTs4rc1fhgfrlaz0Ga7Pp30wuV/NWE2lX/Gw7NhRVDtGoeNNP3UGBgFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACpt6snz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2255003f4c6so25455485ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506869; x=1743111669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/fZ234dAZVGtQaAGmz3CCq6broya7oHFZGYXayYrKE=;
        b=ACpt6snz5H0Zf9YVZTscO62qI5iP7bpKHIpByjfOi+UgIKgN7lPP7MF671hoAN2i5z
         UQt0/tJYzbQ+s5LyMHsnVjpqePW2c8HHHWh1RDFBCafLDsoBkWXsdXfQHr1KIbHmOUUm
         1fo8AOF3BT3DhFPPgp6ZUGk5I4wQxYqJL5vo84puGqmIBg62NISVsuNM6yTDNsCRmMoH
         7t0pDq3jhUIEvob2d4qdELIUx/8V/5f1YE44+GW9ty5KmNN6pJNPGoMgSMTiLTPX/eRi
         YCeG0p/a7u8ajRr13RP34igy5AQIgGBdPuFHBTWhNB1Ne2UqIXhHLGlIz0u6+5FSwk2E
         kZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506869; x=1743111669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/fZ234dAZVGtQaAGmz3CCq6broya7oHFZGYXayYrKE=;
        b=MNlDkn0Brtnj6ZQ1PszlrV0oN2aWoUcSCecx6X5wehRtVx9O0UbO/trtDZ0xJB+H4l
         EaHhqL+p89dJp5FyHpeSUTHUItMeabHYDDOVm0DNcUSYTHbv0WlM83+otw+pBAcKmbhj
         swWtqXBudyNka2lOkDGxLBE7ioaZA+ClmlrSbMNBwLUTt2WUV5ffxq3ft9zudJYY5Qlx
         +22DbOcRuGgeL69fRJJqVck56wcjNFwRc8qPVrpZxeNHyWvdgj+qx83fd4SwMtmYn6Ow
         ILCBPs4cfON+d9+LM5mlZe1j4AEJqHS6Kdk5WaN9Hb4kFympS1INziz2v2NeGtwFooZI
         aX3A==
X-Gm-Message-State: AOJu0YzhM9c5VhAwtLHRCkvozLMZbCLJzAwpjEgDHCXaxmFiDuXoaJHD
	e2yxVDZLFX1maxfsxSYKaBanV9lY2AXWFP67inU9bmAq7D7ifMaR1ylQnwHnNdg=
X-Gm-Gg: ASbGncvpRLU1MdLO0Z2Fw4iNmqJ34RKxP5UQ0aXtIcd1afTmkeLh5wxXmXF9Aps37Jk
	+qjVvPLvoej5UWEe4aahFUx1MbnlxAPuh5TLQppwr2B7kM7mgE4Oj0nbCOEYGH68LfsxWtLrqUV
	uUuG39SkYOFRgiTSYpmpWeio7ionfcto8oTjqacRld1PXlJO2klxRGSmX8QKbjmO78Th3x14MGk
	01rugdP35/vnqaroh2Ati557+AJdf52T7eh+970rYWnsuvTiSxKXGTzbW8MNyofx6qQL/irYKT+
	Ik+D4x12ewql0WZjb5edWAOfnKfzq01yelhOwJogMoB2A9kbCKDxS3j5nNCdf8ezIlxZorWUzvB
	0ZtNcVF7YCLzw65XlZLg=
X-Google-Smtp-Source: AGHT+IEGvAh7x1l6fy1jAu9NeGDkvQMj0FU+hMYVhM+DhHkrtxY+diE9R3S3dt9b54d/U2k8pXSTRg==
X-Received: by 2002:a05:6a21:6b04:b0:1fd:f8dc:833e with SMTP id adf61e73a8af0-1fe4300f7e7mr1791508637.30.1742506869016;
        Thu, 20 Mar 2025 14:41:09 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e59esm321135b3a.170.2025.03.20.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:41:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH 2/4] selftests/bpf: Implement basic uptr KV store
Date: Thu, 20 Mar 2025 14:40:56 -0700
Message-ID: <20250320214058.2946857-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320214058.2946857-1-ameryhung@gmail.com>
References: <20250320214058.2946857-1-ameryhung@gmail.com>
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
programs on hot paths, only simple APIs such as get/put/delete are
provided in bpf, and space managing API are available in user space API.

To use uptr KV store, the user space program first needs to call
kv_store_init() to allocate memory and setup uptrs in the
task_local_storage of a given process. It will return a pointer to
"struct kv_store" on success, which will be used as a token to access the
KV store in other APIs. Secondly, it needs to initialize all key-value
pairs with kv_store_put(). Then, both bpf and user space program can start
their normal operation.

In the bpf program, the API is designed to minimize map lookups.
Therefore, the bpf program needs to first lookup the task_local_storage.
Then, all bpf API will take the map value as the first argument, and
these API do not incur additional map lookups.

A simple way of using KV store to allow easy bpf program rollout is to use
multiple key-value pairs where the values are primitive datatypes instead
of a structure. This way, adding/deleting fields are just adding/deleting
keys without moving data. The following is an example of how this would
work.

  user space: kv_store_init()
  user space: kv_store_put({key1, key2, key3})

  prog_v1: kv_store_get/put({key1, key2, key3})

  user space: kv_store_delete{key1}
  user space: kv_store_add{key4}
  user space: kv_store_set_map_reuse(prog_v2.data_map)

  prog_v2: kv_store_get/put({key2, key3, key4})

At the core of the KV store are metadata and data. To access the value
stored in the data, the metadata is first queried using an integer key.
The metadata is an array of metadata containing the offset and size of
the values. Both metadata and data are stored in uptr regions in the
task_local_storage.

Note that, it is also possible to support string keys by replacing the
backing storage of metadata with an hashmap. However, the additional map
lookup per API may suggest higher performance overhead.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/uptr_kv_store.c  | 282 ++++++++++++++++++
 .../selftests/bpf/prog_tests/uptr_kv_store.h  |  22 ++
 .../selftests/bpf/progs/uptr_kv_store.h       | 120 ++++++++
 .../selftests/bpf/uptr_kv_store_common.h      |  47 +++
 4 files changed, 471 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_kv_store.h
 create mode 100644 tools/testing/selftests/bpf/uptr_kv_store_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
new file mode 100644
index 000000000000..18328b1d5a9a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.c
@@ -0,0 +1,282 @@
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
+	int data_map_fd;
+	int task_fd;
+	int page_cnt;
+	char *data_map_pin_path;
+	struct kv_store_data_map_value data;
+};
+
+static struct kv_store_page *__kv_store_add_page(struct kv_store *kvs)
+{
+	struct kv_store_page *p;
+
+	if (kvs->page_cnt > KVS_MAX_PAGE_ENTRIES)
+		return ERR_PTR(-ENOSPC);
+
+	p = mmap(NULL, sizeof(struct kv_store_page), PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (p == MAP_FAILED)
+		return ERR_PTR(-ENOMEM);
+
+	kvs->data.pages[kvs->page_cnt].page = p;
+	kvs->page_cnt++;
+
+	return p;
+}
+
+static void __kv_store_del_page(struct kv_store *kvs)
+{
+	struct kv_store_page *p;
+
+	p = kvs->data.pages[kvs->page_cnt - 1].page;
+	kvs->data.pages[kvs->page_cnt - 1].page = NULL;
+	kvs->page_cnt--;
+	munmap(p, sizeof(*p));
+}
+
+static struct kv_store_meta *kvs_store_get_meta(struct kv_store *kvs, int key)
+{
+	return key < KVS_MAX_VAL_ENTRIES ? &kvs->data.metas->meta[key] : NULL;
+}
+
+void kv_store_close(struct kv_store *kvs)
+{
+	int i;
+
+	munmap(kvs->data.metas, sizeof(struct kv_store_metas));
+
+	for (i = 0; i < kvs->page_cnt; i++)
+		__kv_store_del_page(kvs);
+
+	if (kvs->data_map_pin_path)
+		unlink(kvs->data_map_pin_path);
+
+	free(kvs);
+}
+
+struct kv_store *kv_store_init(int pid, struct bpf_map *data_map, const char *pin_path)
+{
+	struct kv_store_page *p;
+	struct kv_store *kvs;
+	int err;
+
+	kvs = calloc(1, sizeof(*kvs));
+	if (!kvs) {
+		errno = -ENOMEM;
+		return NULL;
+	}
+
+	kvs->data.metas = mmap(NULL, sizeof(struct kv_store_page),
+			       PROT_READ | PROT_WRITE,
+			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (kvs->data.metas == MAP_FAILED) {
+		errno = -ENOMEM;
+		return NULL;
+	}
+
+	p = __kv_store_add_page(kvs);
+	if (IS_ERR(p)) {
+		errno = PTR_ERR(p);
+		goto err;
+	}
+
+	kvs->data_map_fd = bpf_map__fd(data_map);
+	if (!kvs->data_map_fd) {
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
+	err = bpf_map_update_elem(kvs->data_map_fd, &kvs->task_fd, &kvs->data, 0);
+	if (err) {
+		errno = err;
+		goto err;
+	}
+
+	kvs->data_map_pin_path = strdup(pin_path);
+	if (!kvs->data_map_pin_path)
+		goto err;
+
+	err = bpf_map__pin(data_map, kvs->data_map_pin_path);
+	if (err) {
+		errno = err;
+		goto err;
+	}
+
+	return kvs;
+err:
+	kv_store_close(kvs);
+	return NULL;
+}
+
+int kv_store_data_map_set_reuse(struct kv_store *kvs, struct bpf_map *data_map)
+{
+	return bpf_map__reuse_fd(data_map, kvs->data_map_fd);
+}
+
+void *kv_store_get(struct kv_store *kvs, int key)
+{
+	struct kv_store_meta *meta;
+	struct kv_store_page *p;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta || !meta->init)
+		return NULL;
+
+	p = kvs->data.pages[meta->page_idx].page;
+
+	return p->data + meta->page_off;
+}
+
+static int linear_off(const struct kv_store_meta *meta)
+{
+	if (!meta->init)
+		return KVS_MAX_PAGE_ENTRIES * KVS_MAX_VAL_SIZE;
+
+	return meta->page_idx * KVS_MAX_VAL_SIZE + meta->page_off;
+}
+
+static int comp_meta(const void *m1, const void *m2)
+{
+	struct kv_store_meta *meta1 = (struct kv_store_meta *)m1;
+	struct kv_store_meta *meta2 = (struct kv_store_meta *)m2;
+	int off1, off2;
+
+	off1 = linear_off(meta1);
+	off2 = linear_off(meta2);
+
+	if (off1 > off2)
+		return 1;
+	else if (off1 < off2)
+		return -1;
+	else
+		return 0;
+}
+
+static int kv_store_find_next_slot(struct kv_store *kvs, int size, struct kv_store_meta *meta)
+{
+	struct kv_store_meta metas[KVS_MAX_VAL_ENTRIES];
+	int i, err, off, next_off = 0;
+	struct kv_store_page *p;
+
+	memcpy(metas, kvs->data.metas, sizeof(struct kv_store_meta) * KVS_MAX_VAL_ENTRIES);
+
+	qsort(metas, KVS_MAX_VAL_ENTRIES, sizeof(struct kv_store_meta), comp_meta);
+
+	for (i = 0; i < KVS_MAX_VAL_ENTRIES; i++) {
+		off = linear_off(&metas[i]);
+		if (off - next_off >= size &&
+		    next_off / PAGE_SIZE == (next_off + size - 1) / PAGE_SIZE) {
+			break;
+		}
+		next_off = off + metas[i].size;
+	}
+
+	meta->page_idx = next_off / PAGE_SIZE;
+	meta->page_off = next_off % PAGE_SIZE;
+	meta->size = size;
+
+	if (meta->page_idx >= kvs->page_cnt) {
+		p = __kv_store_add_page(kvs);
+		if (!p)
+			return -ENOMEM;
+
+		err = bpf_map_update_elem(kvs->data_map_fd, &kvs->task_fd, &kvs->data, 0);
+		if (err) {
+			__kv_store_del_page(kvs);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+int kv_store_put(struct kv_store *kvs, int key, void *val, unsigned int val_size)
+{
+	struct kv_store_meta *meta;
+	struct kv_store_page *p;
+	int err;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta)
+		return -ENOENT;
+
+	if (!meta->init) {
+		if (val_size > KVS_MAX_VAL_SIZE)
+			return -E2BIG;
+
+		err = kv_store_find_next_slot(kvs, val_size, meta);
+		if (err)
+			return err;
+	}
+
+	p = kvs->data.pages[meta->page_idx].page;
+	val_size = val_size < meta->size ? val_size : meta->size;
+	memcpy((char *)p->data + meta->page_off, val, val_size);
+	meta->init = 1;
+	return 0;
+}
+
+void kv_store_delete(struct kv_store *kvs, int key)
+{
+	struct kv_store_meta *meta;
+	struct kv_store_page *p;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta)
+		return;
+
+	p = kvs->data.pages[meta->page_idx].page;
+	memset(p->data + meta->page_off, 0, meta->size);
+	memset(meta, 0, sizeof(*meta));
+}
+
+int kv_store_update_value_size(struct kv_store *kvs, int key, unsigned int val_size)
+{
+	struct kv_store_meta *meta, new_meta;
+	struct kv_store_page *old_p, *new_p;
+	int err;
+
+	if (val_size > KVS_MAX_VAL_SIZE)
+		return -E2BIG;
+
+	meta = kvs_store_get_meta(kvs, key);
+	if (!meta || !meta->init)
+		return -ENOENT;
+
+	if (val_size <= meta->size) {
+		meta->size = val_size;
+		return 0;
+	}
+
+	err = kv_store_find_next_slot(kvs, val_size, &new_meta);
+	if (err)
+		return -ENOSPC;
+
+	old_p = kvs->data.pages[meta->page_idx].page;
+	new_p = kvs->data.pages[new_meta.page_idx].page;
+
+	memcpy(new_p->data + new_meta.page_off,
+	       old_p->data + meta->page_off, meta->size);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
new file mode 100644
index 000000000000..a1da3e6e2de3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uptr_kv_store.h
@@ -0,0 +1,22 @@
+#ifndef _UPTR_KV_STORE_H
+#define _UPTR_KV_STORE_H
+
+#include "uptr_kv_store_common.h"
+
+struct kv_store;
+
+void kv_store_close(struct kv_store *kvs);
+
+struct kv_store *kv_store_init(int pid, struct bpf_map *data_map, const char *pin_path);
+
+int kv_store_data_map_set_reuse(struct kv_store *kvs, struct bpf_map *data_map);
+
+void *kv_store_get(struct kv_store *kvs, int key);
+
+int kv_store_put(struct kv_store *kvs, int key, void *val, unsigned int val_size);
+
+void kv_store_delete(struct kv_store *kvs, int key);
+
+int kv_store_update_value_size(struct kv_store *kvs, int key, unsigned int val_size);
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/uptr_kv_store.h b/tools/testing/selftests/bpf/progs/uptr_kv_store.h
new file mode 100644
index 000000000000..9109073a4933
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_kv_store.h
@@ -0,0 +1,120 @@
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
+static int bpf_dynptr_from_kv_store(struct kv_store_data_map_value *data, int key,
+				    unsigned int val_size, struct bpf_dynptr *ptr,
+				    struct kv_store_meta **meta)
+{
+	struct kv_store_page *p = NULL;
+	u16 _key = 0;
+
+	if (!data || !data->metas)
+		return -ENOENT;
+
+	/* workaround. llvm generates memory access with unbound key with the following code:
+	 * if (key >= KVS_MAX_VAL_ENTRIES)
+	 *         return -ENOENT;
+	 *
+	 * ; *meta = &data->metas->meta[key]; @ uptr_kv_store.h:37
+	 * 62: (bc) w2 = w2                      ; frame1: R2_w=scalar(id=3,smin=0,smax=umax=0xffffffff,smax32=1023,var_off=(0x0; 0xffffffff))
+	 * 63: (67) r2 <<= 32                    ; frame1: R2_w=scalar(smax=0x3ff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
+	 * 64: (c7) r2 s>>= 32                   ; frame1: R2_w=scalar(smin=0xffffffff80000000,smax=smax32=1023)
+	 * 65: (67) r2 <<= 2                     ; frame1: R2_w=scalar(smax=0x7ffffffffffffffc,umax=0xfffffffffffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0; 0xfffffffffffffffc))
+	 * 66: (0f) r6 += r2
+	 * math between mem pointer and register with unbounded min value is not allowed
+	 */
+	_key += key;
+	if (_key >= KVS_MAX_VAL_ENTRIES)
+		return -ENOENT;
+
+	*meta = &data->metas->meta[_key];
+	if (!(*meta)->init)
+		return -ENOENT;
+
+	/* workaround for variable offset uptr access:
+	 * p = data->pages[meta->page_idx].page;
+	 */
+	switch((*meta)->page_idx) {
+	case 0: p = data->pages[0].page; break;
+	case 1: p = data->pages[1].page; break;
+	case 2: p = data->pages[2].page; break;
+	case 3: p = data->pages[3].page; break;
+	case 4: p = data->pages[4].page; break;
+	case 5: p = data->pages[5].page; break;
+	case 6: p = data->pages[6].page; break;
+	case 7: p = data->pages[7].page; break;
+	}
+
+	if (!p)
+		return -ENOENT;
+
+	val_size = val_size < (*meta)->size ? val_size : (*meta)->size;
+
+	if ((*meta)->page_off >= KVS_MAX_VAL_SIZE)
+		return -EINVAL;
+
+	return bpf_dynptr_from_mem(p->data, KVS_MAX_VAL_SIZE, 0, ptr);
+}
+
+__attribute__((unused))
+static int kv_store_put(struct kv_store_data_map_value *data, int key,
+			void *val, unsigned int val_size)
+{
+	struct kv_store_meta *meta;
+	struct bpf_dynptr ptr;
+	int err;
+
+	err = bpf_dynptr_from_kv_store(data, key, val_size, &ptr, &meta);
+	if (err)
+		return err;
+
+	return bpf_dynptr_write(&ptr, meta->page_off, val, val_size, 0);
+}
+
+__attribute__((unused))
+static int kv_store_get(struct kv_store_data_map_value *data, int key,
+			void *val, unsigned int val_size)
+{
+	struct kv_store_meta *meta;
+	struct bpf_dynptr ptr;
+	int err;
+
+	err = bpf_dynptr_from_kv_store(data, key, val_size, &ptr, &meta);
+	if (err)
+		return err;
+
+	return bpf_dynptr_read(val, val_size, &ptr, meta->page_off, 0);
+}
+
+__attribute__((unused))
+static int kv_store_delete(struct kv_store_data_map_value *data, int key)
+{
+	struct kv_store_meta *meta;
+	u16 _key = 0;
+
+	if (!data || !data->metas)
+		return -ENOENT;
+
+	_key += key;
+	if (_key >= KVS_MAX_VAL_ENTRIES)
+		return -ENOENT;
+
+	meta = &data->metas->meta[_key];
+	meta->init = 0;
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/uptr_kv_store_common.h b/tools/testing/selftests/bpf/uptr_kv_store_common.h
new file mode 100644
index 000000000000..af69cd0b32da
--- /dev/null
+++ b/tools/testing/selftests/bpf/uptr_kv_store_common.h
@@ -0,0 +1,47 @@
+#ifndef _UPTR_KV_STORE_COMMON_H
+#define _UPTR_KV_STORE_COMMON_H
+
+#define PAGE_SIZE		4096
+#define KVS_MAX_KEY_SIZE 	32
+#define KVS_MAX_VAL_SIZE 	PAGE_SIZE
+#define KVS_MAX_VAL_ENTRIES 	1024
+
+#define KVS_VALUE_INFO_PAGE_IDX_BIT	3
+#define KVS_VALUE_INFO_PAGE_OFF_BIT	12
+#define KVS_VALUE_INFO_VAL_SIZE_BIT	12
+
+#define KVS_MAX_PAGE_ENTRIES	(1 << KVS_VALUE_INFO_PAGE_IDX_BIT)
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
+	__u32 page_idx:KVS_VALUE_INFO_PAGE_IDX_BIT;
+	__u32 page_off:KVS_VALUE_INFO_PAGE_OFF_BIT;
+	__u32 size:KVS_VALUE_INFO_VAL_SIZE_BIT;
+	__u32 init:1;
+};
+
+struct kv_store_metas {
+	struct kv_store_meta meta[KVS_MAX_VAL_ENTRIES];
+};
+
+struct kv_store_page_entry {
+	struct kv_store_page __uptr *page;
+};
+
+struct kv_store_data_map_value {
+	struct kv_store_metas __uptr *metas;
+	struct kv_store_page_entry pages[KVS_MAX_PAGE_ENTRIES];
+};
+
+struct kv_store_page {
+	char data[KVS_MAX_VAL_SIZE];
+};
+
+#endif
-- 
2.47.1


