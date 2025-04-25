Return-Path: <bpf+bounces-56748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C8EA9D459
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CD4C8269
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955D274647;
	Fri, 25 Apr 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GolvS3AG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150C226534;
	Fri, 25 Apr 2025 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617246; cv=none; b=RxB4KLR9P+8oXiHHjMuYIEZn2v4wPCvcOgnmacsW6GJ6OWQLZb+uKD1vKeWGHbVlMbiUhkkOYgLSXOC5SeOBIhIG9llKDlgFExuq/yEoJVtEDaGkfYMSklDMiUDdRqPkUghJ4SLNFw3gROEo8w21w27OitoBldxddpYSU4P0sAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617246; c=relaxed/simple;
	bh=PiVoqrXYqtfgH0ukDU0zsMVK1GwWkttVjGy2F6jXiJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgi8D/oQJgA0nVGrp2ED0ExuQSVGNDKn71mWfzQH0FxqhzLFXZkDOn+EqB57yZWyXisiNO9dcjyySdqmYR9LvuCPXqoIWQQshIBUAYtoWw/Dq9RGZinneDGhi4XIXBWUT7bbRirEse257KMtA1WRDDKS5H4PhGZ2TWQhEhcTV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GolvS3AG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3035858c687so2342192a91.2;
        Fri, 25 Apr 2025 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745617242; x=1746222042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alknRS6/6VdS3WrIXOYj+vVOvrxgDfw3zMIYlvau+hA=;
        b=GolvS3AGIbeUSp/kvVpIYJ+iAuAnynSq1gZaC1pLxvDUrLsa11E9u1T13AP4uxybuS
         kmk/jCpOR9moVum9erSm7JxQv5jTjzyFBZ9rupE2yYdH4tEwicvF0hy3+Xkussfzb1Vy
         5dgq/jRibP36Nl2g5NbJq/ldFnmgFvpMPmiyDRF/zlHOFx/nzxfl2R7XeddZREdMtg+c
         bVttVXUMGD1XmJJSR44HZHovcmH65ROocG6vsVrq2Yx4d+dAZ1j6K6kmqqKcenJlTMm+
         HTy83dYPTa7UXQop+KruA38CEl/fSlu0XyDN7qGHKmBl8wQvZi0dLsJ1YR38M/3RT+P9
         Hp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617242; x=1746222042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alknRS6/6VdS3WrIXOYj+vVOvrxgDfw3zMIYlvau+hA=;
        b=wlZMKfha8GlRPTJ1WmX9DIhwme9z4ls26WxhCb6lD84bJDpGKT9wkaKMmqTP8OEefL
         JOfGfJwwHE2YbcO5Biox7QekheefFxgT8/JupdRczF+DKOLX2rEV8yrUbhk/H5Bqox1I
         QWPoytbjxCLLhlyNh1WNohpg9/7eag2jMWD0TnQxO3OB6Qc6EAujXVQMu6ZU61iZ66kv
         UPzRfbFHOjwKcrNOvVlvcLZoJvopTNPxuSSfngFwPr+kcJcCAr70KrPj9OaxJY554CTK
         AQbdKv82KG2LWZwtyk8rXYaBwOiIWDbpVwh1qAHdxjjRMgtgfNCqGbKLPciXBAvZ52PD
         mOxw==
X-Gm-Message-State: AOJu0Yy5ME1WebgtPhViJVfXyqmwtgOy82d/egSS13yvG2xPNX2JDRQr
	piQWLOCOxpuP6kKFQIbJlFJG8OumIdg+1YD+vhC2Q/w8PYS6V3J1qf7baw==
X-Gm-Gg: ASbGnctWgNSjNiwMAIcbsFKkvQhoRrvHJeafWvrQG1BpJRN5LCMXQ+IklPEhR4o23Q/
	DV2N+xa9rwXNXGwZjbji+yWAjZ9KVLfAfTZpoEANzuG7+kJ7PzhhjCVbzZHSuNdLF3PTnNR94/7
	x+WmOesHkZzrUuf5yZla5x3LpBgjoBYFeeaF2Jn/06PmPrnVSZI8lUO5m0Q9iS3EKqFJ9DglP+L
	JXvQ7Lgoq6I7HzDr4bOhA07BcsKwA2rK34Z7P7aJnZd6BLxrZxnCX/LXP9hSXJ8kYYfLDK9wLI/
	jxfn69HMnjckrlv1OKHwiDLGQioIXnM=
X-Google-Smtp-Source: AGHT+IE/TMVWznQH5YQ8AsMIlS+K+5SRWUOqcVYEuVFkOoe3PiqTFypgiV/vVmV7y1S2mievndB5tQ==
X-Received: by 2002:a17:90b:2888:b0:305:5f25:59a5 with SMTP id 98e67ed59e1d1-309f7ea8b06mr5925380a91.35.1745617242377;
        Fri, 25 Apr 2025 14:40:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef1475c1sm4029859a91.45.2025.04.25.14.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:40:42 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH RFC v3 1/2] selftests/bpf: Introduce task local data
Date: Fri, 25 Apr 2025 14:40:33 -0700
Message-ID: <20250425214039.2919818-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425214039.2919818-1-ameryhung@gmail.com>
References: <20250425214039.2919818-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Task local data provides simple and fast bpf and user space APIs to
exchange per-task data through task local storage map. The user space
first declares task local data using bpf_tld_type_key_var() or
bpf_tld_type_var(). The data is a thread-specific variable which
every thread has its own copy. Then, a bpf_tld_thread_init() needs to
be called for every thread to share the data with bpf. Finally, users
can directly read/write thread local data without bpf syscall.

For bpf programs to see task local data, every data need to be
initialized once for every new task using bpf_tld_init_var(). Then
bpf programs can retrieve pointers to the data with bpf_tld_lookup().

The core of task local storage implementation relies on UPTRs. They
pin user pages to the kernel so that user space can share data with bpf
programs without syscalls. Both data and the metadata used to access
data are pinned via UPTRs.

A limitation of UPTR makes the implementation of task local data
less trivial than it sounds: memory pinned to UPTR cannot exceed a
page and must not cross the page boundary. In addition, the data
declaration uses __thread identifier and therefore does not have
directly control over the memory allocation. Therefore, several
tricks and checks are used to make it work.

First, task local data declaration APIs place data in a custom "udata"
section so that data from different compilation units will be contiguous
in the memory and can be pinned using two UPTRs if they are smaller than
one page.

To avoid each data from spanning across two pages, they are each aligned
to the smallest power of two larget than their sizes.

As we don't control the memory allocation for data, we need to figure
out the layout of user defined data. This is done by the data
declaration API and bpf_tld_thread_init(). The data declaration API
will insert constructors for all data, and they are used to find the
size and offset of data as well as the beginning and end of the whole
udata section. Then, bpf_tld_thread_init() performs a per-thread check
to make sure no data will cross the page boundary as udata can start at
different offset in a page.

Note that for umetadata, we directly aligned_alloc() memory for it and
assigned to the UPTR. This is only done once for every process as every
tasks shares the same umetadata. The actual thread-specific data offset
will be adjusted in the bpf program when calling bpf_tld_init_var().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.c          | 159 +++++++++++++++
 .../bpf/prog_tests/task_local_data.h          |  58 ++++++
 .../selftests/bpf/progs/task_local_data.h     | 181 ++++++++++++++++++
 .../selftests/bpf/task_local_data_common.h    |  41 ++++
 4 files changed, 439 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/task_local_data_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.c b/tools/testing/selftests/bpf/prog_tests/task_local_data.c
new file mode 100644
index 000000000000..5a21514573d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.c
@@ -0,0 +1,159 @@
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <pthread.h>
+
+#include <bpf/bpf.h>
+
+#include "bpf_util.h"
+#include "task_local_data.h"
+#include "task_local_storage_helpers.h"
+
+#define PIDFD_THREAD       O_EXCL
+
+/* To find the start of udata for each thread, insert a dummy variable to udata.
+ * Contructors generated for every task local data will figured out the offset
+ * from the beginning of udata to the dummy symbol. Then, every thread can infer
+ * the start of udata by subtracting the offset from the address of dummy.
+ */
+static __thread struct udata_dummy {} udata_dummy SEC("udata");
+
+static __thread bool task_local_data_thread_inited;
+
+struct task_local_data {
+	void *udata_start;
+	void *udata_end;
+	int udata_start_dummy_off;
+	struct meta_page *umetadata;
+	int umetadata_cnt;
+	bool umetadata_init;
+	short udata_sizes[64];
+	pthread_mutex_t lock;
+} task_local_data = {
+	.udata_start = (void *)-1UL,
+	.lock = PTHREAD_MUTEX_INITIALIZER,
+};
+
+static void tld_set_data_key_meta(int i, const char *key, short off)
+{
+	task_local_data.umetadata->meta[i].off = off;
+	strncpy(task_local_data.umetadata->meta[i].key, key, TASK_LOCAL_DATA_KEY_LEN);
+}
+
+static struct key_meta *tld_get_data_key_meta(int i)
+{
+	return &task_local_data.umetadata->meta[i];
+}
+
+static void tld_set_data_size(int i, int size)
+{
+	task_local_data.udata_sizes[i] = size;
+}
+
+static int tld_get_data_size(int i)
+{
+	return task_local_data.udata_sizes[i];
+}
+
+void __bpf_tld_var_init(const char *key, void *var, int size)
+{
+	int i;
+
+	i = task_local_data.umetadata_cnt++;
+
+	if (!task_local_data.umetadata) {
+		if (task_local_data.umetadata_cnt > 1)
+			return;
+
+		task_local_data.umetadata = aligned_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!task_local_data.umetadata)
+			return;
+	}
+
+	if (var < task_local_data.udata_start) {
+		task_local_data.udata_start = var;
+		task_local_data.udata_start_dummy_off =
+			(void *)&udata_dummy - task_local_data.udata_start;
+	}
+
+	if (var + size > task_local_data.udata_end)
+		task_local_data.udata_end = var + size;
+
+	tld_set_data_key_meta(i, key, var - (void *)&udata_dummy);
+	tld_set_data_size(i, size);
+}
+
+int bpf_tld_thread_init(void)
+{
+	unsigned long udata_size, udata_start, udata_start_page, udata_end_page;
+	struct task_local_data_map_value map_val;
+	int i, task_id, task_fd, map_fd, err;
+
+	if (!task_local_data.umetadata_cnt || task_local_data_thread_inited)
+		return 0;
+
+	if (task_local_data.umetadata_cnt && !task_local_data.umetadata)
+		return -ENOMEM;
+
+	udata_start = (unsigned long)&udata_dummy + task_local_data.udata_start_dummy_off;
+
+	pthread_mutex_lock(&task_local_data.lock);
+	for (i = 0; i < task_local_data.umetadata_cnt; i++) {
+		struct key_meta *km = tld_get_data_key_meta(i);
+		int size = tld_get_data_size(i);
+		int off;
+
+		if (!task_local_data.umetadata_init) {
+			/* Constructors save the offset from udata_dummy to each data
+			 * Now as all ctors have run and the offset between the start of
+			 * udata and udata_dummy is known, adjust the offsets of data
+			 * to be relative to the start of udata
+			 */
+			km->off -= task_local_data.udata_start_dummy_off;
+
+			/* Data exceeding a page may not be able to be covered by
+			 * two udata UPTRs in every thread
+			 */
+			if (km->off >= PAGE_SIZE)
+				return -EOPNOTSUPP;
+		}
+
+		/* A task local data should not span across two pages. */
+		off = km->off + udata_start;
+		if ((off & PAGE_MASK) != ((off + size - 1) & PAGE_MASK))
+			return -EOPNOTSUPP;
+	}
+	task_local_data.umetadata_init = true;
+	pthread_mutex_unlock(&task_local_data.lock);
+
+	udata_size = task_local_data.udata_end - task_local_data.udata_start;
+	udata_start_page = udata_start & PAGE_MASK;
+	udata_end_page = (udata_start + udata_size) & PAGE_MASK;
+
+	/* The whole udata can span across two pages for a thread. Use two UPTRs
+	 * to cover the second page in case it happens.
+	 */
+	map_val.udata_start = udata_start & ~PAGE_MASK;
+	map_val.udata[0].page = (struct data_page *)(udata_start_page);
+	map_val.udata[1].page = (udata_start_page == udata_end_page) ? NULL :
+		(struct data_page *)(udata_start_page + PAGE_SIZE);
+
+	/* umetadata is shared by all threads under the assumption that all
+	 * task local data are defined statically and linked together
+	 */
+	map_val.umetadata = task_local_data.umetadata;
+	map_val.umetadata_cnt = task_local_data.umetadata_cnt;
+
+	map_fd = bpf_obj_get(TASK_LOCAL_DATA_MAP_PIN_PATH);
+	if (map_fd < 0)
+		return -errno;
+
+	task_id = sys_gettid();
+	task_fd = sys_pidfd_open(task_id, PIDFD_THREAD);
+	err = bpf_map_update_elem(map_fd, &task_fd, &map_val, 0);
+	if (err)
+		return err;
+
+	task_local_data_thread_inited = true;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
new file mode 100644
index 000000000000..c928e8d2c0a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -0,0 +1,58 @@
+#ifndef __BPF_TASK_LOCAL_DATA_H__
+#define __BPF_TASK_LOCAL_DATA_H__
+
+#include "task_local_data_common.h"
+
+#define SEC(name) __attribute__((section(name), used))
+#define __aligned(x) __attribute__((aligned(x)))
+
+#define ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_clzl(x - 1)))
+
+void __bpf_tld_var_init(const char *key, void *var, int size);
+
+/**
+ * @brief bpf_tld_key_type_var() declares a task local data shared with bpf
+ * programs. The data will be a thread-specific variable which a user space
+ * program can directly read/write, while bpf programs will need to lookup
+ * with the string key.
+ *
+ * @param key The string key a task local data will be associated with. The
+ * string will be truncated if the length exceeds TASK_LOCAL_DATA_KEY_LEN
+ * @param type The type of the task local data
+ * @param var The name of the task local data
+ */
+#define bpf_tld_key_type_var(key, type, var)					\
+__thread type var SEC("udata") __aligned(ROUND_UP_POWER_OF_TWO(sizeof(type)));	\
+										\
+__attribute__((constructor))							\
+void __bpf_tld_##var##_init(void)						\
+{										\
+	_Static_assert(sizeof(type) < PAGE_SIZE,				\
+		       "data size must not exceed a page");			\
+	__bpf_tld_var_init(key, &var, sizeof(type));				\
+}
+
+/**
+ * @brief bpf_tld_key_type_var() declares a task local data shared with bpf
+ * programs. The data will be a thread-specific variable which a user space
+ * program can directly read/write, while bpf programs will need to lookup
+ * the data with the string key same as the variable name.
+ *
+ * @param type The type of the task local data
+ * @param var The name of the task local data as well as the name of the
+ * key. The key string will be truncated if the length exceeds
+ * TASK_LOCAL_DATA_KEY_LEN.
+ */
+#define bpf_tld_type_var(type, var) \
+	bpf_tld_key_type_var(#var, type, var)
+
+/**
+ * @brief bpf_tld_thread_init() initializes the task local data for the current
+ * thread. All data are undefined from a bpf program's point of view until
+ * bpf_tld_thread_init() is called.
+ *
+ * @return 0 on success; negative error number on failure
+ */
+int bpf_tld_thread_init(void);
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.h b/tools/testing/selftests/bpf/progs/task_local_data.h
new file mode 100644
index 000000000000..7358993ee634
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_data.h
@@ -0,0 +1,181 @@
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_local_data_common.h"
+
+#define PAGE_IDX_MASK 0x8000
+
+/* Overview
+ *
+ * Task local data (TLD) allows sharing per-task information between users and
+ * bpf programs without explicit storage layout managenent. TLD APIs use to
+ * string keys to access data. Internally, TLD shares user pages throguh two
+ * UPTRs in a task local storage: udata and umetadata. Data are stored in udata.
+ * Keys and the offsets of the corresponding data in udata are stored in umetadata.
+ *
+ * Usage
+ *
+ * Users should initialize every task local data once for every new task before
+ * using them with bpf_tld_init_var(). It should be done ideally in non-critical
+ * paths first (e.g., sched_ext_ops::init_task) as it compare key strings and
+ * cache the offsets of data.
+ *
+ * First, user should define struct task_local_data_offsets, which will be used
+ * to cache the offsets of task local data. Each member of the struct should
+ * be a short integer with name same as the key name defined in the user space.
+ * Another task local storage map will be created to save the offsets. For example:
+ *
+ * struct task_local_data_offsets {
+ *     short priority;
+ *     short in_critical_section;
+ * };
+ *
+ * Task local data APIs take a pointer to bpf_task_local_data object as the first
+ * argument. The object should be declared as a stack variable and initialized via
+ * bpf_tld_init(). Then, in a bpf program, to cache the offset for a key-value pair,
+ * call bpf_tld_init_var(). For example, in init_task program:
+ *
+ *     struct bpf_task_local_data tld;
+ *
+ *     err = bpf_tld_init(task, &tld);
+ *     if (err)
+ *         return 0;
+ *
+ *     bpf_tld_init_var(&tld, priority);
+ *     bpf_tld_init_var(&tld, in_critical_section);
+ *
+ * Subsequently and in other bpf programs, to lookup task local data, call
+ * bpf_tld_lookup(). For example:
+ *
+ *     int *p;
+ *
+ *     p = bpf_tld_lookup(&tld, priority, sizeof(int));
+ *     if (p)
+ *         // do something depending on *p
+ */
+
+struct task_local_data_offsets;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_local_data_map_value);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} task_local_data_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_local_data_offsets);
+} task_local_data_off_map SEC(".maps");
+
+struct bpf_task_local_data {
+	struct task_local_data_map_value *data_map;
+	struct task_local_data_offsets *off_map;
+};
+
+/**
+ * @brief bpf_tld_init() initializes a bpf_task_local_data object.
+ *
+ * @param task The task_struct of the target task
+ * @param tld A pointer to a bpf_task_local_data object to be initialized
+ * @return -EINVAL if task KV store is not initialized by the user space for this task;
+ * -ENOMEM if cached offset map creation fails. In both cases, users can abort, or
+ * conitnue without calling task KV store APIs as if no key-value pairs are set.
+ */
+__attribute__((unused))
+static int bpf_tld_init(struct task_struct *task, struct bpf_task_local_data *tld)
+{
+	tld->data_map = bpf_task_storage_get(&task_local_data_map, task, 0, 0);
+	if (!tld->data_map)
+		return -EINVAL;
+
+	tld->off_map = bpf_task_storage_get(&task_local_data_off_map, task, 0,
+					    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tld->off_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * @brief bpf_tld_init_var() lookups the metadata with a key and caches the offset of
+ * the value corresponding to the key.
+ *
+ * @param tld A pointer to a valid bpf_task_local_data object initialized by bpf_tld_init()
+ * @param key The key used to lookup the task KV store. Should be one of the
+ * symbols defined in struct task_local_data_offsets, not a string
+ */
+#define bpf_tld_init_var(tld, key)					\
+	({								\
+		(tld)->off_map->key = bpf_tld_fetch_off(tld, #key);	\
+	})
+
+__attribute__((unused))
+static short bpf_tld_fetch_off(struct bpf_task_local_data *tld, const char *key)
+{
+	int i, umetadata_off, umetadata_cnt, udata_start;
+	void *umetadata, *key_i, *off_i;
+	short off = 0;
+
+	if (!tld->data_map || !tld->data_map->umetadata)
+		goto out;
+
+	udata_start = tld->data_map->udata_start;
+	umetadata_cnt = tld->data_map->umetadata_cnt;
+	umetadata = tld->data_map->umetadata->meta;
+
+	bpf_for(i, 0, umetadata_cnt) {
+		umetadata_off = i * sizeof(struct key_meta);
+		if (umetadata_off > PAGE_SIZE - sizeof(struct key_meta))
+			break;
+
+		key_i = umetadata + umetadata_off + offsetof(struct key_meta, key);
+		off_i = umetadata + umetadata_off + offsetof(struct key_meta, off);
+
+		if (!bpf_strncmp(key_i, TASK_LOCAL_DATA_KEY_LEN, key)) {
+			off = *(short *)(off_i) + udata_start;
+			if (off >= PAGE_SIZE)
+				off = (off - PAGE_SIZE) | PAGE_IDX_MASK;
+			/* Shift cached offset by 1 so that 0 means not initialized */
+			off += 1;
+			break;
+		}
+	}
+out:
+	return off;
+}
+
+/**
+ * @brief bpf_tld_lookup() lookups the task KV store using the cached offset
+ * corresponding to the key.
+ *
+ * @param tld A pointer to a valid bpf_task_local_data object initialized by bpf_tld_init()
+ * @param key The key used to lookup the task KV store. Should be one of the
+ * symbols defined in struct task_local_data_offsets, not a string
+ * @param size The size of the value. Must be a known constant value
+ * @return A pointer to the value corresponding to the key; NULL if the offset
+ * if not cached or the size is too big
+ */
+#define bpf_tld_lookup(tld, key, size)	__bpf_tld_lookup(tld, (tld)->off_map->key, size)
+__attribute__((unused))
+static void *__bpf_tld_lookup(struct bpf_task_local_data *tld, short cached_off, int size)
+{
+	short page_off, page_idx;
+
+	if (!cached_off--)
+		return NULL;
+
+	page_off = cached_off & ~PAGE_IDX_MASK;
+	page_idx = !!(cached_off & PAGE_IDX_MASK);
+
+	if (page_idx) {
+		return (tld->data_map->udata[1].page && page_off < PAGE_SIZE - size) ?
+			(void *)tld->data_map->udata[1].page + page_off : NULL;
+	} else {
+		return (tld->data_map->udata[0].page && page_off < PAGE_SIZE - size) ?
+			(void *)tld->data_map->udata[0].page + page_off : NULL;
+	}
+}
diff --git a/tools/testing/selftests/bpf/task_local_data_common.h b/tools/testing/selftests/bpf/task_local_data_common.h
new file mode 100644
index 000000000000..2a0bb724c77c
--- /dev/null
+++ b/tools/testing/selftests/bpf/task_local_data_common.h
@@ -0,0 +1,41 @@
+#ifndef __BPF_TASK_KV_STORE_COMMON_H__
+#define __BPF_TASK_KV_STORE_COMMON_H__
+
+#ifdef __BPF__
+struct data_page *dummy_data_page;
+struct meta_page *dummy_meta_page;
+#else
+#define __uptr
+#endif
+
+
+#define TASK_LOCAL_DATA_MAP_PIN_PATH "/sys/fs/bpf/task_local_data_map"
+#define TASK_LOCAL_DATA_KEY_LEN 62
+#define PAGE_SIZE 4096
+#define PAGE_MASK (~(PAGE_SIZE - 1))
+
+struct data_page {
+	char data[PAGE_SIZE];
+};
+
+struct data_page_entry {
+	struct data_page __uptr *page;
+};
+
+struct key_meta {
+	char key[TASK_LOCAL_DATA_KEY_LEN];
+	short off;
+};
+
+struct meta_page {
+	struct key_meta meta[64];
+};
+
+struct task_local_data_map_value {
+	struct data_page_entry udata[2];
+	struct meta_page __uptr *umetadata;
+	short umetadata_cnt;
+	short udata_start;
+};
+
+#endif
-- 
2.47.1


