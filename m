Return-Path: <bpf+bounces-58363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B48AB9176
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722C24A0BA5
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78C288CAC;
	Thu, 15 May 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGp7+9DG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF86247298;
	Thu, 15 May 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343772; cv=none; b=JNdn316Gk1YDI9BRs10h3aI2jwbF5Tlg36RaapHGXT1eyOXl/H1Okp0TI7XUVj37lvayvfjFwaQhd3BwEy0RyuohG8teL3AQk6Z5UDNNzVf3eOj2T6BKWo07f/sOm8xSXUSgvUp6oA7Q5Av7gzMDmZYe0HTAc5fIlPFA4IofE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343772; c=relaxed/simple;
	bh=L5G79OA/R6QuCjTYUOedNzSaCxIU+M/pNfeH/McoaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxx+U7TEy3b5VuCsbQHuARIdBkvRc3GJOeHdITyxIIUuIULCoK0ZBwsXpJa9jJyjWDDfoAONgqRerEGE2dNhFAONkGYquqextv5hqQ6RixILj8QMJSAo3GRa5njpku09Xg/ScnRJ1eKbFttisORAGhXZHk+QnmoApeNSn4q9oyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGp7+9DG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-afc857702d1so1117373a12.3;
        Thu, 15 May 2025 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343769; x=1747948569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGBJ+0gd0iV7g5ODyiWJRWVLXnv4z8NCVKWztbEyG44=;
        b=IGp7+9DG3lr7Gm6kkA+0ozRyQkPLOcQGBZNhRn63nXg+lL8CPkboel63y+PoqQyQrp
         44gdhg8/lb6sZepwc4aXBK7ixrfaVuFtoHe3wYx7778n4+f75W37iOIy1eXdLs6eGZ0/
         Shsk6nyhchZ09R+vKe+4ZA3W8ZwyVbMSUlC5zFa2rGYFvcJQudWqh8UnOiKsb2olKm4N
         0MxSX86k/eC/Fu7my0FDILp3xTCvU23nMrUz4bGkSl+ar13i2ij3LAHHyMlgm6PSkyvI
         25NNq13GN+HtwpQbicKmPebO5xfUDv4CHirzZ83kmiYKK/InPih6FPmNgX5duTctG6ub
         WSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343769; x=1747948569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGBJ+0gd0iV7g5ODyiWJRWVLXnv4z8NCVKWztbEyG44=;
        b=FJnQf1DwJXftSl6zqq5W7VmfYiR/QTQydimg364u3l/5vxKC4viC9UUTu8Wea1A3vW
         9QXg08JJNoJXO36whP3XofxTCrZRLctK8nWKnXgniqnO+zClrP8auzFqUazLsMwB2XDk
         0GMY5O6ujOu/ux7Q08+e2idvlTKjB1aOY0fjuBEeZAwD8dSCVCOwatYyaGUV6W1ltnUY
         Rkjd917tMujYJ7VV6qP5WKTAbqBWhdYDw6WFFT12Orvb/5MqH4Kl6g3bq0Ak7sbYTv2Y
         KW3V7Lxa49F8l7nciCRmU2c/hPzqewBlU8Cc7aX18oQQAsioSy9JBcDiWYaQYJoQYzx9
         cZ5g==
X-Gm-Message-State: AOJu0Yxi+ccPpe/RT/qwQ3evtf2HN5KSE6hpFq8A1F69fWV+yfvw5kJ/
	ZUJe4V62YldsPbbv/TjFYpJQQpTTT/I/GKukbLYq8bWYVP54r93nOHrc5yhjcg==
X-Gm-Gg: ASbGncvwHKUZCCE9qbd5N9GTNdnf8RmMTmEH7N1nplDF65AbiI7YojaQtMe+r631TUQ
	L8qiDm3gAW1LuvMcWJVHjfdT3L+QH9MmHWL8+Q5KzudSEzFZulbWz05rvWe5Akcr3iRlR8H6U8w
	EoBTVMIeYlBlBqIrh7fcu+SEIpSnRIQUzLTBVGPWnq2a9VP3uadpS6lGthAfd9JfjWIWjOTTHej
	b6nIX2tWpHX1Y/F1LLxvRhLG05f6L89up0sQtWCPBUDpaKMum9zAGCallDqbiXuiWHynjaBFue3
	zCQRvHQrR8k+9Y/1uJ3VigKaTZj4F96WbfuBXT1LkQ==
X-Google-Smtp-Source: AGHT+IHck7aVUlLl+PZk+C9faA+9PLBE/MohILLP42MnY0tuIGPa6y6Wvqh+zv2FYIXAi2TxNF9mOA==
X-Received: by 2002:a17:903:1987:b0:231:99a4:8321 with SMTP id d9443c01a7336-231d45c4b95mr10037115ad.51.1747343768768;
        Thu, 15 May 2025 14:16:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm2061425ad.250.2025.05.15.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:16:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
Date: Thu, 15 May 2025 14:16:00 -0700
Message-ID: <20250515211606.2697271-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515211606.2697271-1-ameryhung@gmail.com>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Task local data defines an abstract storage type for storing task-
specific data (TLD). This patch provides user space and bpf
implementation as header-only libraries for accessing task local data.

Task local data is a bpf task local storage map with two UPTRs:
1) u_tld_metadata, shared by all tasks of the same process, consists of
the total count of TLDs and an array of metadata of TLDs. A metadata of
a TLD comprises the size and the name. The name is used to identify a
specific TLD in bpf 2) data is memory for storing TLDs specific to the
task.

The following are the basic task local data API:

                 User space               BPF
Create key     tld_create_key()            -
Fetch key            -               tld_fetch_key()
Get data       tld_get_data()        tld_get_data()

A TLD is first created by the user space with tld_create_key(). First,
it goes through the metadata array to check if the TLD can be added.
The total TLD size needs to fit into a page (limited by UPTR), and no
two TLDs can have the same name. It also calculates the offset, the next
available space in u_tld_data, by summing sizes of TLDs. If the TLD
can be added, it increases the count using cmpxchg as there may be other
concurrent tld_create_key(). After a successful cmpxchg, the last
metadata slot now belongs to the calling thread and will be updated.
tld_create_key() returns the offset encapsulated as a opaque object key
to prevent user misuse.

Then user space can pass the key to tld_get_data() to get a pointer
to the TLD. The pointer will remain valid for the lifetime of the
thread.

BPF programs also locate TLDs with the keys. This is done by calling
tld_fetch_key() with the name of the TLD. Similar to tld_create_key(),
it scans through metadata array, compare the name of TLDs and compute
the offset. Once found, the offset is also returned as a key, which
can be passed to the bpf version of tld_get_data() to retrieve a
pointer to the TLD.

User space task local data library uses a light way approach to ensure
thread safety (i.e., atomic operation + compiler and memory barriers).
While a metadata is being updated, other threads may also try to read it.
To prevent them from seeing incomplete data, metadata::size is used to
signal the completion of the update, where 0 means the update is still
ongoing. Threads will wait until seeing a non-zero size to read a
metadata. Acquire/release order is required for metadata::size to
prevent hardware reordering. For example, moving store to metadata::name
after store to metadata::size or moving load from metadata::name before
load from metadata::size.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.h          | 263 ++++++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 220 +++++++++++++++
 2 files changed, 483 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
new file mode 100644
index 000000000000..ec43ea59267c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_LOCAL_DATA_H
+#define __TASK_LOCAL_DATA_H
+
+#include <fcntl.h>
+#include <errno.h>
+#include <sched.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include <bpf/bpf.h>
+
+#ifndef PIDFD_THREAD
+#define PIDFD_THREAD O_EXCL
+#endif
+
+#define PAGE_SIZE 4096
+
+#ifndef __round_mask
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#endif
+#ifndef round_up
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#endif
+
+#ifndef READ_ONCE
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#endif
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
+
+#define TLD_DATA_SIZE PAGE_SIZE
+#define TLD_DATA_CNT 63
+#define TLD_NAME_LEN 62
+
+typedef struct {
+	__s16 off;
+} tld_key_t;
+
+struct tld_metadata {
+	char name[TLD_NAME_LEN];
+	__u16 size;
+};
+
+struct u_tld_metadata {
+	__u8 cnt;
+	__u8 padding[63];
+	struct tld_metadata metadata[TLD_DATA_CNT];
+};
+
+struct u_tld_data {
+	char data[TLD_DATA_SIZE];
+};
+
+struct tld_map_value {
+	struct u_tld_data *data;
+	struct u_tld_metadata *metadata;
+};
+
+struct u_tld_metadata *tld_metadata_p __attribute__((weak));
+__thread struct u_tld_data *tld_data_p __attribute__((weak));
+
+static int __tld_init_metadata(int map_fd)
+{
+	struct u_tld_metadata *new_metadata;
+	struct tld_map_value map_val;
+	int task_fd = 0, err;
+
+	task_fd = syscall(SYS_pidfd_open, getpid(), 0);
+	if (task_fd < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	new_metadata = aligned_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!new_metadata) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memset(new_metadata, 0, PAGE_SIZE);
+
+	map_val.data = NULL;
+	map_val.metadata = new_metadata;
+
+	/*
+	 * bpf_map_update_elem(.., pid_fd,..., BPF_NOEXIST) guarantees that
+	 * only one tld_create_key() can update tld_metadata_p.
+	 */
+	err = bpf_map_update_elem(map_fd, &task_fd, &map_val, BPF_NOEXIST);
+	if (err) {
+		free(new_metadata);
+		if (err == -EEXIST || err == -EAGAIN)
+			err = 0;
+		goto out;
+	}
+
+	WRITE_ONCE(tld_metadata_p, new_metadata);
+out:
+	if (task_fd > 0)
+		close(task_fd);
+	return err;
+}
+
+static int __tld_init_data(int map_fd)
+{
+	struct u_tld_data *new_data = NULL;
+	struct tld_map_value map_val;
+	int err, task_fd = 0;
+
+	task_fd = syscall(SYS_pidfd_open, gettid(), PIDFD_THREAD);
+	if (task_fd < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	new_data = aligned_alloc(PAGE_SIZE, TLD_DATA_SIZE);
+	if (!new_data) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	map_val.data = new_data;
+	map_val.metadata = READ_ONCE(tld_metadata_p);
+
+	err = bpf_map_update_elem(map_fd, &task_fd, &map_val, 0);
+	if (err) {
+		free(new_data);
+		goto out;
+	}
+
+	tld_data_p = new_data;
+out:
+	if (task_fd > 0)
+		close(task_fd);
+	return err;
+}
+
+/**
+ * tld_create_key() - Create a key associated with a TLD.
+ *
+ * @map_fd: A file descriptor of the underlying task local storage map,
+ * tld_data_map
+ * @name: The name the TLD will be associated with
+ * @size: Size of the TLD
+ *
+ * Returns an opaque object key. Use tld_key_is_err() or tld_key_err_or_zero() to
+ * check if the key creation succeed. Pass to tld_get_data() to get a pointer to
+ * the TLD. bpf programs can also fetch the same key by name.
+ */
+__attribute__((unused))
+static tld_key_t tld_create_key(int map_fd, const char *name, size_t size)
+{
+	int err, i, cnt, sz, off = 0;
+
+	if (!READ_ONCE(tld_metadata_p)) {
+		err = __tld_init_metadata(map_fd);
+		if (err)
+			return (tld_key_t) {.off = err};
+	}
+
+	if (!tld_data_p) {
+		err = __tld_init_data(map_fd);
+		if (err)
+			return (tld_key_t) {.off = err};
+	}
+
+	size = round_up(size, 8);
+
+	for (i = 0; i < TLD_DATA_CNT; i++) {
+retry:
+		cnt = __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_RELAXED);
+		if (i < cnt) {
+			/*
+			 * Pending tld_create_key() uses size to signal if the metadata has
+			 * been fully updated.
+			 */
+			while (!(sz = __atomic_load_n(&tld_metadata_p->metadata[i].size,
+						      __ATOMIC_ACQUIRE)))
+				sched_yield();
+
+			if (!strncmp(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN))
+				return (tld_key_t) {.off = -EEXIST};
+
+			off += sz;
+			continue;
+		}
+
+		if (off + size > TLD_DATA_SIZE)
+			return (tld_key_t) {.off = -E2BIG};
+
+		/*
+		 * Only one tld_create_key() can increase the current cnt by one and
+		 * takes the latest available slot. Other threads will check again if a new
+		 * TLD can still be added, and then compete for the new slot after the
+		 * succeeding thread update the size.
+		 */
+		if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt, &cnt, cnt + 1, true,
+						 __ATOMIC_RELAXED, __ATOMIC_RELAXED))
+			goto retry;
+
+		strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN);
+		__atomic_store_n(&tld_metadata_p->metadata[i].size, size, __ATOMIC_RELEASE);
+		return (tld_key_t) {.off = off};
+	}
+
+	return (tld_key_t) {.off = -ENOSPC};
+}
+
+__attribute__((unused))
+static inline bool tld_key_is_err(tld_key_t key)
+{
+	return key.off < 0;
+}
+
+__attribute__((unused))
+static inline int tld_key_err_or_zero(tld_key_t key)
+{
+	return tld_key_is_err(key) ? key.off : 0;
+}
+
+/**
+ * tld_get_data() - Gets a pointer to the TLD associated with the key.
+ *
+ * @map_fd: A file descriptor of the underlying task local storage map,
+ * tld_data_map
+ * @key: A key object returned by tld_create_key().
+ *
+ * Returns a pointer to the TLD if the key is valid; NULL if no key has been
+ * added, not enough memory for TLD for this thread, or the key is invalid.
+ *
+ * Threads that call tld_get_data() must call tld_free() on exit to prevent
+ * memory leak.
+ */
+__attribute__((unused))
+static void *tld_get_data(int map_fd, tld_key_t key)
+{
+	if (!READ_ONCE(tld_metadata_p))
+		return NULL;
+
+	if (!tld_data_p && __tld_init_data(map_fd))
+		return NULL;
+
+	return tld_data_p->data + key.off;
+}
+
+/**
+ * tld_free() - Frees task local data memory of the calling thread
+ */
+__attribute__((unused))
+static void tld_free(void)
+{
+	if (tld_data_p)
+		free(tld_data_p);
+}
+
+#endif /* __TASK_LOCAL_DATA_H */
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
new file mode 100644
index 000000000000..5f48e408a5e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_LOCAL_DATA_BPF_H
+#define __TASK_LOCAL_DATA_BPF_H
+
+/*
+ * Task local data is a library that facilitates sharing per-task data
+ * between user space and bpf programs.
+ *
+ *
+ * PREREQUISITE
+ *
+ * A TLD, an entry of data in task local data, first needs to be created by the
+ * user space. This is done by calling user space API, tld_create_key(), with
+ * the name of the TLD and the size.
+ *
+ *     tld_key_t prio, in_cs;
+ *
+ *     prio = tld_create_key("priority", sizeof(int));
+ *     in_cs = tld_create_key("in_critical_section", sizeof(bool));
+ *
+ * A key associated with the TLD, which has an opaque type tld_key_t, will be
+ * returned. It can be used to get a pointer to the TLD in the user space by
+ * calling tld_get_data().
+ *
+ *
+ * USAGE
+ *
+ * Similar to user space, bpf programs locate a TLD using the same key.
+ * tld_fetch_key() allows bpf programs to retrieve a key created in the user
+ * space by name, which is specified in the second argument of tld_create_key().
+ * tld_fetch_key() additionally will cache the key in a task local storage map,
+ * tld_key_map, to avoid performing costly string comparisons every time when
+ * accessing a TLD. This requires the developer to define the map value type of
+ * tld_key_map, struct tld_keys. It only needs to contain keys used by bpf
+ * programs in the compilation unit.
+ *
+ * struct tld_keys {
+ *     tld_key_t prio;
+ *     tld_key_t in_cs;
+ * };
+ *
+ * Then, for every new task, a bpf program will fetch and cache keys once and
+ * for all. This should be done ideally in a non-critical path (e.g., in
+ * sched_ext_ops::init_task).
+ *
+ *     struct tld_object tld_obj;
+ *
+ *     err = tld_object_init(task, &tld);
+ *     if (err)
+ *         return 0;
+ *
+ *     tld_fetch_key(&tld_obj, "priority", prio);
+ *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
+ *
+ * Note that, the first argument of tld_fetch_key() is a pointer to tld_object.
+ * It should be declared as a stack variable and initialized via tld_object_init().
+ *
+ * Finally, just like user space programs, bpf programs can get a pointer to a
+ * TLD by calling tld_get_data(), with cached keys.
+ *
+ *     int *p;
+ *
+ *     p = tld_get_data(&tld_obj, prio, sizeof(int));
+ *     if (p)
+ *         // do something depending on *p
+ */
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#define TLD_DATA_SIZE __PAGE_SIZE
+#define TLD_DATA_CNT 63
+#define TLD_NAME_LEN 62
+
+typedef struct {
+	__s16 off;
+} tld_key_t;
+
+struct u_tld_data *dummy_data;
+struct u_tld_metadata *dummy_metadata;
+
+struct tld_metadata {
+	char name[TLD_NAME_LEN];
+	__u16 size;
+};
+
+struct u_tld_metadata {
+	__u8 cnt;
+	__u8 padding[63];
+	struct tld_metadata metadata[TLD_DATA_CNT];
+};
+
+struct u_tld_data {
+	char data[TLD_DATA_SIZE];
+};
+
+struct tld_map_value {
+	struct u_tld_data __uptr *data;
+	struct u_tld_metadata __uptr *metadata;
+};
+
+struct tld_object {
+	struct tld_map_value *data_map;
+	struct tld_keys *key_map;
+};
+
+/*
+ * Map value of tld_key_map for caching keys. Must be defined by the developer.
+ * Members should be tld_key_t and passed to the 3rd argument of tld_fetch_key().
+ */
+struct tld_keys;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct tld_map_value);
+} tld_data_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct tld_keys);
+} tld_key_map SEC(".maps");
+
+/**
+ * tld_object_init() - Initializes a tld_object.
+ *
+ * @task: The task_struct of the target task
+ * @tld_obj: A pointer to a tld_object to be initialized
+ *
+ * Returns 0 on success; -ENODATA if the task has no TLD; -ENOMEM if the creation
+ * of tld_key_map fails
+ */
+__attribute__((unused))
+static int tld_object_init(struct task_struct *task, struct tld_object *tld_obj)
+{
+	tld_obj->data_map = bpf_task_storage_get(&tld_data_map, task, 0, 0);
+	if (!tld_obj->data_map)
+		return -ENODATA;
+
+	tld_obj->key_map = bpf_task_storage_get(&tld_key_map, task, 0,
+						BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tld_obj->key_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * tld_fetch_key() - Fetches the key to a TLD by name. The key has to be created
+ * by user space first with tld_create_key().
+ *
+ * @tld_obj: A pointer to a valid tld_object initialized by tld_object_init()
+ * @name: The name of the key associated with a TLD
+ * @key: The key in struct tld_keys to be saved to
+ *
+ * Returns a positive integer on success; 0 otherwise
+ */
+#define tld_fetch_key(tld_obj, name, key)					\
+	({									\
+		(tld_obj)->key_map->key.off = __tld_fetch_key(tld_obj, name);	\
+	})
+
+__attribute__((unused))
+static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *name)
+{
+	int i, meta_off, cnt;
+	void *metadata, *nm, *sz;
+	u16 off = 0;
+
+	if (!tld_obj->data_map || !tld_obj->data_map->metadata)
+		return 0;
+
+	cnt = tld_obj->data_map->metadata->cnt;
+	metadata = tld_obj->data_map->metadata->metadata;
+
+	bpf_for(i, 0, cnt) {
+		meta_off = i * sizeof(struct tld_metadata);
+		if (meta_off > TLD_DATA_SIZE - offsetof(struct u_tld_metadata, metadata)
+					   - sizeof(struct tld_metadata))
+			break;
+
+		nm = metadata + meta_off + offsetof(struct tld_metadata, name);
+		sz = metadata + meta_off + offsetof(struct tld_metadata, size);
+
+		/*
+		 * Reserve 0 for uninitialized keys. Increase the offset of a valid key
+		 * by one and subtract it later in tld_get_data().
+		 */
+		if (!bpf_strncmp(nm, TLD_NAME_LEN, name))
+			return off + 1;
+
+		off += *(u16 *)sz;
+	}
+
+	return 0;
+}
+
+/**
+ * tld_get_data() - Retrieves a pointer to the TLD associated with the key.
+ *
+ * @tld_obj: A pointer to a valid tld_object initialized by tld_object_init()
+ * @key: The key of a TLD saved in tld_maps
+ * @size: The size of the TLD. Must be a known constant value
+ *
+ * Returns a pointer to the TLD data associated with the key; NULL if the key
+ * is not valid or the size is too big
+ */
+#define tld_get_data(tld_obj, key, size) \
+	__tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size)
+
+__attribute__((unused))
+__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32 off, u32 size)
+{
+	return (tld_obj->data_map->data && off >= 0 && off < TLD_DATA_SIZE - size) ?
+		(void *)tld_obj->data_map->data + off : NULL;
+}
+
+#endif
-- 
2.47.1


