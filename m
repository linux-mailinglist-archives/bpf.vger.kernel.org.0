Return-Path: <bpf+bounces-63636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A3B09228
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEB3B1E24
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D982FD589;
	Thu, 17 Jul 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ5Y8F+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A932FA63E;
	Thu, 17 Jul 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770928; cv=none; b=nqhZWMl0iJBeFkDqQYZ5D+Oxq4wviBrHbmXJIgXu8J82Iy1/8W1SzbyXtsgZs37DbD2DXCm7psBppsoj4+7LjDIPvIPwxE4nXGOiWZhFAA26HagWSGbnzwURdEUHgwLYnqW71WeS6iU1VNcfBrNFzvRUYQ7qze/+LSt1ER719uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770928; c=relaxed/simple;
	bh=KgtQF0w95CGfUOV/YwWecVs3MHQjoG42tt2lz0u6SbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP+YSLU/gHUvpwRygdmMppsGLK2sGKMqvHrDdhGwHPNEUsIvxZnf7B7lXnvlj4W5edGLnc40ByOfXIKlKm6+Ra6TWEdcTm+obO0OVDeFb4r8fsx30btoLUg+GW4dmf16JzfvvanC5tiWVf5qVTjOjKy1EHYYM91mtXBIlDQ3f5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ5Y8F+B; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso938309a12.0;
        Thu, 17 Jul 2025 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770925; x=1753375725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZwG1UMKEQ03PYRv3aLSa4lHW3OdIobvUNSCXEs6c2w=;
        b=DQ5Y8F+Bd5lFbgYY/CGIpKCq9cl992b1VIXFUfEKJSl0gwL+/KyInNz7jDd4wgsYSc
         M83jkj0DlsUcAVky0bzGUK478bCExuea4pk0Q0nfaFnLSWmhFbGdjKuqozucw93RcykG
         d6WnWjg/spV5GdcYldGwnIPnXxgS+PflHD7R/Lg9nzTNHStfk07nOzZMJlOj3IZIEiiM
         i+GX+nzSzkeC50DlQTr80+TK9/pFCE/GQIbtZh7b52o7jwjwdZaQrCKqqOMu/qgqQ+Vz
         o0TaiD3QmzASThxiW6uviCVj+hFwCNApCmFmAEBHFVpo8SybsV3pXRCpJNZOMRiIfMnd
         QfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770925; x=1753375725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZwG1UMKEQ03PYRv3aLSa4lHW3OdIobvUNSCXEs6c2w=;
        b=UOz9mk+VCCMljX+IUgNqnrwYbr8YB002rNBp/txO9e+Ds4EhUkNRonmufZMCQFAU7L
         fw7Oat0PNAa37bQrRNL9ik1ogCuqY0MPRApgczHeYSldsjJKwQon4pWPkSD0hlXrprGK
         nzJHJYEJwi0pzNFz69gSR/yZ3SZ4lR0keCWYYqA4ZQBzJBP8VA3LedonF6Xm+pwppfmK
         NXEX3aywUgkIlRsv4CIOS6Igrl+91WGPp+RKn50v5nuBnoRsL4wyNrcx2N3xYBqCJXti
         JrLhm9i9SPjmzMi6v4HfAAFKKqm2pAUapLkEsxQFte6qb7JOXwSQ2zxuTMG8oPXyS/Zj
         EuVA==
X-Gm-Message-State: AOJu0YybkyrVZd6ut5x2datoWeiytIM24CqagNCsYo66ANLz9TWBMUBJ
	p+nX+IU84fsLgbqWKjtHirQqopdFyZGD0IJG4RZEPDHT+65PFAVq9R6fqMlb+Q==
X-Gm-Gg: ASbGncuKlEDcRseCARoXDazyQOhvSIfSQoX02FYvC/pxPkH89zElfYR2UMy6wrE2tTd
	YAoPqufsNEiHVlJK78CyS9YzFS8jmNa3+hrC2zgxohp3I1Aq/Kg/NqolJY+UZCB2N8ZbexeIKV5
	ilIkN14X+Ktm9w6zqcAtDA4G32N9V9oS2QkAL/YP/vcWOOkKJhJHjoAgsAjRBr3Cox1PZg3tCDw
	Jdwqo6kDwLnll1eFXShUiHP9Bnfqu3YaOyr5MF0OBDmNo0qi7K04F8AXTHp5PeNbLC2buE3dGik
	UtA4jlGiEfh9mWkz+fJ7k1WJT4s26hN4/TDcyk+Vx/XJgN1Mly6IUcKAyVX+psI3qQeuGTKJb4m
	ytIZsYkBRgL7a1g==
X-Google-Smtp-Source: AGHT+IFw0Fm1+PFZi2Oz5wu7+sLCDm7SRgtm8AN3YiRi65BQGiErAJBpovsoeJbWXsPWh7JGExStGg==
X-Received: by 2002:a17:90b:280a:b0:313:fab4:1df6 with SMTP id 98e67ed59e1d1-31c9f4c5115mr8169909a91.32.1752770924672;
        Thu, 17 Jul 2025 09:48:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7aa6ddsm1814193a91.1.2025.07.17.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:48:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/3] selftests/bpf: Introduce task local data
Date: Thu, 17 Jul 2025 09:48:39 -0700
Message-ID: <20250717164842.1848817-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717164842.1848817-1-ameryhung@gmail.com>
References: <20250717164842.1848817-1-ameryhung@gmail.com>
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
specific TLD in bpf 2) u_tld_data points to a task-specific memory region
for storing TLDs.

Below are the core task local data API:

                     User space                           BPF
Define TLD    TLD_DEFINE_KEY(), tld_create_key()           -
Get data           tld_get_data()                    tld_get_data()

A TLD is first defined by the user space with TLD_DEFINE_KEY() or
tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and allocates
just enough memory during initialization. tld_create_key() allows
creating TLDs on the fly, but has a fix memory budget, TLD_DYN_DATA_SIZE.
Internally, they all go through the metadata array to check if the TLD can
be added. The total TLD size needs to fit into a page (limited by UPTR),
and no two TLDs can have the same name. It also calculates the offset, the
next available space in u_tld_data, by summing sizes of TLDs. If the TLD
can be added, it increases the count using cmpxchg as there may be other
concurrent tld_create_key(). After a successful cmpxchg, the last
metadata slot now belongs to the calling thread and will be updated.
tld_create_key() returns the offset encapsulated as a opaque object key
to prevent user misuse.

Then, user space can pass the key to tld_get_data() to get a pointer
to the TLD. The pointer will remain valid for the lifetime of the
thread.

BPF programs can also locate the TLD by tld_get_data(), but with both
name and key. The first time tld_get_data() is called, the name will
be used to lookup the metadata. Then, the key will be saved to a
task_local_data map, tld_keys_map. Subsequent call to tld_get_data()
will use the key to quickly locate the data.

User space task local data library uses a light way approach to ensure
thread safety (i.e., atomic operation + compiler and memory barriers).
While a metadata is being updated, other threads may also try to read it.
To prevent them from seeing incomplete data, metadata::size is used to
signal the completion of the update, where 0 means the update is still
ongoing. Threads will wait until seeing a non-zero size to read a
metadata.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.h          | 388 ++++++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 227 ++++++++++
 2 files changed, 615 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
new file mode 100644
index 000000000000..73ee122daf81
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_LOCAL_DATA_H
+#define __TASK_LOCAL_DATA_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdatomic.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+#include <pthread.h>
+#endif
+
+#include <bpf/bpf.h>
+
+/*
+ * OPTIONS
+ *
+ *   Define the option before including the header
+ *
+ *   TLD_FREE_DATA_ON_THREAD_EXIT - Frees memory on thread exit automatically
+ *
+ *   Thread-specific memory for storing TLD is allocated lazily on the first call to
+ *   tld_get_data(). The thread that calls it must also calls tld_free() on thread exit
+ *   to prevent memory leak. Pthread will be included if the option is defined. A pthread
+ *   key will be registered with a destructor that calls tld_free().
+ *
+ *
+ *   TLD_DYN_DATA_SIZE - The maximum size of memory allocated for TLDs created dynamically
+ *   (default: 64 bytes)
+ *
+ *   A TLD can be defined statically using TLD_DEFINE_KEY() or created on the fly using
+ *   tld_create_key(). As the total size of TLDs created with tld_create_key() cannot be
+ *   possibly known statically, a memory area of size TLD_DYN_DATA_SIZE will be allocated
+ *   for these TLDs. This additional memory is allocated for every thread that calls
+ *   tld_get_data() even if no tld_create_key are actually called, so be mindful of
+ *   potential memory wastage. Use TLD_DEFINE_KEY() whenever possible as just enough memory
+ *   will be allocated for TLDs created with it.
+ *
+ *
+ *   TLD_NAME_LEN - The maximum length of the name of a TLD (default: 62)
+ *
+ *   Setting TLD_NAME_LEN will affect the maximum number of TLDs a process can store,
+ *   TLD_MAX_DATA_CNT.
+ *
+ *
+ *   TLD_DATA_USE_ALIGNED_ALLOC - Always use aligned_alloc() instead of malloc()
+ *
+ *   When allocating the memory for storing TLDs, we need to make sure there is a memory
+ *   region of the X bytes within a page. This is due to the limit posed by UPTR: memory
+ *   pinned to the kernel cannot exceed a page nor can it cross the page boundary. The
+ *   library normally calls malloc(2*X) given X bytes of total TLDs, and only uses
+ *   aligned_alloc(PAGE_SIZE, X) when X >= PAGE_SIZE / 2. This is to reduce memory wastage
+ *   as not all memory allocator can use the exact amount of memory requested to fulfill
+ *   aligned_alloc(). For example, some may round the size up to the alignment. Enable the
+ *   option to always use aligned_alloc() if the implementation has low memory overhead.
+ */
+
+#define TLD_PIDFD_THREAD O_EXCL
+
+#define TLD_PAGE_SIZE getpagesize()
+#define TLD_PAGE_MASK (~(TLD_PAGE_SIZE - 1))
+
+#define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
+#define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
+
+#define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+
+#ifndef TLD_DYN_DATA_SIZE
+#define TLD_DYN_DATA_SIZE 64
+#endif
+
+#define TLD_MAX_DATA_CNT (TLD_PAGE_SIZE / sizeof(struct tld_metadata) - 1)
+
+#ifndef TLD_NAME_LEN
+#define TLD_NAME_LEN 62
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct {
+	__s16 off;
+} tld_key_t;
+
+struct tld_metadata {
+	char name[TLD_NAME_LEN];
+	_Atomic __u16 size;
+};
+
+struct u_tld_metadata {
+	_Atomic __u8 cnt;
+	__u16 size;
+	struct tld_metadata metadata[];
+};
+
+struct u_tld_data {
+	__u64 start; /* offset of u_tld_data->data in a page */
+	char data[];
+};
+
+struct tld_map_value {
+	void *data;
+	struct u_tld_metadata *metadata;
+};
+
+struct u_tld_metadata * _Atomic tld_metadata_p __attribute__((weak));
+__thread struct u_tld_data *tld_data_p __attribute__((weak));
+__thread void *tld_data_alloc_p __attribute__((weak));
+
+#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+pthread_key_t tld_pthread_key __attribute__((weak));
+
+static void tld_free(void);
+
+static void __tld_thread_exit_handler(void *unused)
+{
+	tld_free();
+}
+#endif
+
+static int __tld_init_metadata(void)
+{
+	struct u_tld_metadata *meta, *uninit = NULL;
+	int err = 0;
+
+	meta = (struct u_tld_metadata *)aligned_alloc(TLD_PAGE_SIZE, TLD_PAGE_SIZE);
+	if (!meta) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memset(meta, 0, TLD_PAGE_SIZE);
+	meta->size = TLD_DYN_DATA_SIZE;
+
+	if (!atomic_compare_exchange_strong(&tld_metadata_p, &uninit, meta)) {
+		free(meta);
+		goto out;
+	}
+
+#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+	pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler);
+#endif
+out:
+	return err;
+}
+
+static int __tld_init_data(int map_fd)
+{
+	bool use_aligned_alloc = false;
+	struct tld_map_value map_val;
+	struct u_tld_data *data;
+	int err, tid_fd = -1;
+	void *d = NULL;
+
+	tid_fd = syscall(SYS_pidfd_open, gettid(), TLD_PIDFD_THREAD);
+	if (tid_fd < 0) {
+		err = -errno;
+		goto out;
+	}
+
+#ifdef TLD_DATA_USE_ALIGNED_ALLOC
+	use_aligned_alloc = true;
+#endif
+
+	/*
+	 * tld_metadata_p->size = TLD_DYN_DATA_SIZE +
+	 *          total size of TLDs defined via TLD_DEFINE_KEY()
+	 */
+	if (use_aligned_alloc || tld_metadata_p->size >= TLD_PAGE_SIZE / 2)
+		d = aligned_alloc(TLD_PAGE_SIZE, tld_metadata_p->size);
+	else
+		d = malloc(tld_metadata_p->size * 2);
+	if (!d) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Always pass a page-aligned address to UPTR since the size of tld_map_value::data
+	 * is a page in BTF. If d spans across two pages, use the page that contains large
+	 * enough memory.
+	 */
+	if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)d) >= tld_metadata_p->size) {
+		map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)d);
+		data = d;
+		data->start = (~TLD_PAGE_MASK & (intptr_t)d) + offsetof(struct u_tld_data, data);
+	} else {
+		map_val.data = (void *)(TLD_ROUND_UP((intptr_t)d, TLD_PAGE_SIZE));
+		data = (void *)(TLD_ROUND_UP((intptr_t)d, TLD_PAGE_SIZE));
+		data->start = offsetof(struct u_tld_data, data);
+	}
+	map_val.metadata = TLD_READ_ONCE(tld_metadata_p);
+
+	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
+	if (err) {
+		free(d);
+		goto out;
+	}
+
+	tld_data_p = (struct u_tld_data *)data;
+	tld_data_alloc_p = d;
+#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+	pthread_setspecific(tld_pthread_key, (void *)1);
+#endif
+out:
+	if (tid_fd >= 0)
+		close(tid_fd);
+	return err;
+}
+
+static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
+{
+	int err, i, sz, off = 0;
+	__u8 cnt;
+
+	if (!TLD_READ_ONCE(tld_metadata_p)) {
+		err = __tld_init_metadata();
+		if (err)
+			return (tld_key_t){err};
+	}
+
+	for (i = 0; i < TLD_MAX_DATA_CNT; i++) {
+retry:
+		cnt = atomic_load(&tld_metadata_p->cnt);
+		if (i < cnt) {
+			/* A metadata is not ready until size is updated with a non-zero value */
+			while (!(sz = atomic_load(&tld_metadata_p->metadata[i].size)))
+				sched_yield();
+
+			if (!strncmp(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN))
+				return (tld_key_t){-EEXIST};
+
+			off += TLD_ROUND_UP(sz, 8);
+			continue;
+		}
+
+		/*
+		 * TLD_DEFINE_KEY() is given memory upto a page while at most
+		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
+		 */
+		if (dyn_data) {
+			if (off + TLD_ROUND_UP(size, 8) > tld_metadata_p->size)
+				return (tld_key_t){-E2BIG};
+		} else {
+			if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE - sizeof(struct u_tld_data))
+				return (tld_key_t){-E2BIG};
+			tld_metadata_p->size += TLD_ROUND_UP(size, 8);
+		}
+
+		/*
+		 * Only one tld_create_key() can increase the current cnt by one and
+		 * takes the latest available slot. Other threads will check again if a new
+		 * TLD can still be added, and then compete for the new slot after the
+		 * succeeding thread update the size.
+		 */
+		if (!atomic_compare_exchange_strong(&tld_metadata_p->cnt, &cnt, cnt + 1))
+			goto retry;
+
+		strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN);
+		atomic_store(&tld_metadata_p->metadata[i].size, size);
+		return (tld_key_t){(__s16)off};
+	}
+
+	return (tld_key_t){-ENOSPC};
+}
+
+/**
+ * TLD_DEFINE_KEY() - Define a TLD and a global variable key associated with the TLD.
+ *
+ * @name: The name of the TLD
+ * @size: The size of the TLD
+ * @key: The variable name of the key. Cannot exceed TLD_NAME_LEN
+ *
+ * The macro can only be used in file scope.
+ *
+ * A global variable key of opaque type, tld_key_t, will be declared and initialized before
+ * main() starts. Use tld_key_is_err() or tld_key_err_or_zero() later to check if the key
+ * creation succeeded. Pass the key to tld_get_data() to get a pointer to the TLD.
+ * bpf programs can also fetch the same key by name.
+ *
+ * The total size of TLDs created using TLD_DEFINE_KEY() cannot exceed a page. Just
+ * enough memory will be allocated for each thread on the first call to tld_get_data().
+ */
+#define TLD_DEFINE_KEY(key, name, size)			\
+tld_key_t key;						\
+							\
+__attribute__((constructor))				\
+void __tld_define_key_##key(void)			\
+{							\
+	key = __tld_create_key(name, size, false);	\
+}
+
+/**
+ * tld_create_key() - Create a TLD and return a key associated with the TLD.
+ *
+ * @name: The name the TLD
+ * @size: The size of the TLD
+ *
+ * Return an opaque object key. Use tld_key_is_err() or tld_key_err_or_zero() to check
+ * if the key creation succeeded. Pass the key to tld_get_data() to get a pointer to
+ * locate the TLD. bpf programs can also fetch the same key by name.
+ *
+ * Use tld_create_key() only when a TLD needs to be created dynamically (e.g., @name is
+ * not known statically or a TLD needs to be created conditionally)
+ *
+ * An additional TLD_DYN_DATA_SIZE bytes are allocated per-thread to accommodate TLDs
+ * created dynamically with tld_create_key(). Since only a user page is pinned to the
+ * kernel, when TLDs created with TLD_DEFINE_KEY() uses more than TLD_PAGE_SIZE -
+ * TLD_DYN_DATA_SIZE, the buffer size will be limited to the rest of the page.
+ */
+__attribute__((unused))
+static tld_key_t tld_create_key(const char *name, size_t size)
+{
+	return __tld_create_key(name, size, true);
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
+ * tld_get_data() - Get a pointer to the TLD associated with the given key of the
+ * calling thread.
+ *
+ * @map_fd: A file descriptor of tld_data_map, the underlying BPF task local storage map
+ * of task local data.
+ * @key: A key object created by TLD_DEFINE_KEY() or tld_create_key().
+ *
+ * Return a pointer to the TLD if the key is valid; NULL if not enough memory for TLD
+ * for this thread, or the key is invalid. The returned pointer is guaranteed to be 8-byte
+ * aligned.
+ *
+ * Threads that call tld_get_data() must call tld_free() on exit to prevent
+ * memory leak if TLD_FREE_DATA_ON_THREAD_EXIT is not defined.
+ */
+__attribute__((unused))
+static void *tld_get_data(int map_fd, tld_key_t key)
+{
+	if (!TLD_READ_ONCE(tld_metadata_p))
+		return NULL;
+
+	/* tld_data_p is allocated on the first invocation of tld_get_data() */
+	if (!tld_data_p && __tld_init_data(map_fd))
+		return NULL;
+
+	return tld_data_p->data + key.off;
+}
+
+/**
+ * tld_free() - Free task local data memory of the calling thread
+ *
+ * For the calling thread, all pointers to TLDs acquired before will become invalid.
+ *
+ * Users must call tld_free() on thread exit to prevent memory leak. Alternatively,
+ * define TLD_FREE_DATA_ON_THREAD_EXIT and a thread exit handler will be registered
+ * to free the memory automatically.
+ */
+__attribute__((unused))
+static void tld_free(void)
+{
+	if (tld_data_alloc_p) {
+		free(tld_data_alloc_p);
+		tld_data_alloc_p = NULL;
+		tld_data_p = NULL;
+	}
+}
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+#endif /* __TASK_LOCAL_DATA_H */
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
new file mode 100644
index 000000000000..2f919fa87a66
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_LOCAL_DATA_BPF_H
+#define __TASK_LOCAL_DATA_BPF_H
+
+/*
+ * Task local data is a library that facilitates sharing per-task data
+ * between user space and bpf programs.
+ *
+ *
+ * USAGE
+ *
+ * A TLD, an entry of data in task local data, first needs to be created by the
+ * user space. This is done by calling user space API, TLD_DEFINE_KEY() or
+ * tld_create_key(), with the name of the TLD and the size.
+ *
+ * TLD_DEFINE_KEY(prio, "priority", sizeof(int));
+ *
+ * or
+ *
+ * void func_call(...) {
+ *     tld_key_t prio, in_cs;
+ *
+ *     prio = tld_create_key("priority", sizeof(int));
+ *     in_cs = tld_create_key("in_critical_section", sizeof(bool));
+ *     ...
+ *
+ * A key associated with the TLD, which has an opaque type tld_key_t, will be
+ * initialized or returned. It can be used to get a pointer to the TLD in the
+ * user space by calling tld_get_data().
+ *
+ * In a bpf program, tld_object_init() first needs to be called to initialized a
+ * tld_object on the stack. Then, TLDs can be accessed by calling tld_get_data().
+ * The API will try to fetch the key by the name and use it to locate the data.
+ * A pointer to the TLD will be returned. It also caches the key in a task local
+ * storage map, tld_key_map, whose value type, struct tld_keys, must be defined
+ * by the developer.
+ *
+ * struct tld_keys {
+ *     tld_key_t prio;
+ *     tld_key_t in_cs;
+ * };
+ *
+ * SEC("struct_ops")
+ * void prog(struct task_struct task, ...)
+ * {
+ *     struct tld_object tld_obj;
+ *     int err, *p;
+ *
+ *     err = tld_object_init(task, &tld_obj);
+ *     if (err)
+ *         return;
+ *
+ *     p = tld_get_data(&tld_obj, prio, "priority", sizeof(int));
+ *     if (p)
+ *         // do something depending on *p
+ */
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
+#define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
+
+#define TLD_MAX_DATA_CNT (__PAGE_SIZE / sizeof(struct tld_metadata) - 1)
+
+#ifndef TLD_NAME_LEN
+#define TLD_NAME_LEN 62
+#endif
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
+	__u16 size;
+	struct tld_metadata metadata[TLD_MAX_DATA_CNT];
+};
+
+struct u_tld_data {
+	__u64 start; /* offset of u_tld_data->data in a page */
+	char data[__PAGE_SIZE - sizeof(__u64)];
+};
+
+struct tld_map_value {
+	struct u_tld_data __uptr *data;
+	struct u_tld_metadata __uptr *metadata;
+};
+
+typedef struct tld_uptr_dummy {
+	struct u_tld_data data[0];
+	struct u_tld_metadata metadata[0];
+} *tld_uptr_dummy_t;
+
+struct tld_object {
+	struct tld_map_value *data_map;
+	struct tld_keys *key_map;
+	/*
+	 * Force the compiler to generate the actual definition of u_tld_metadata
+	 * and u_tld_data in BTF. Without it, u_tld_metadata and u_tld_data will
+	 * be BTF_KIND_FWD.
+	 */
+	tld_uptr_dummy_t dummy[0];
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
+ * tld_object_init() - Initialize a tld_object.
+ *
+ * @task: The task_struct of the target task
+ * @tld_obj: A pointer to a tld_object to be initialized
+ *
+ * Return 0 on success; -ENODATA if the user space did not initialize task local data
+ * for the current task through tld_get_data(); -ENOMEM if the creation of tld_key_map
+ * fails
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
+/*
+ * Return the offset of TLD if @name is found. Otherwise, return the current TLD count
+ * using the nonpositive range so that the next tld_get_data() can skip fetching key if
+ * no new TLD is added or start comparing name from the first newly added TLD.
+ */
+__attribute__((unused))
+static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_start)
+{
+	struct tld_metadata *metadata;
+	int i, cnt, start, off = 0;
+
+	if (!tld_obj->data_map || !tld_obj->data_map->data || !tld_obj->data_map->metadata)
+		return 0;
+
+	start = tld_obj->data_map->data->start;
+	cnt = tld_obj->data_map->metadata->cnt;
+	metadata = tld_obj->data_map->metadata->metadata;
+
+	bpf_for(i, 0, cnt) {
+		if (i >= TLD_MAX_DATA_CNT)
+			break;
+
+		if (i >= i_start && !bpf_strncmp(metadata[i].name, TLD_NAME_LEN, name))
+			return start + off;
+
+		off += TLD_ROUND_UP(metadata[i].size, 8);
+	}
+
+	return -cnt;
+}
+
+/**
+ * tld_get_data() - Retrieve a pointer to the TLD associated with the name.
+ *
+ * @tld_obj: A pointer to a valid tld_object initialized by tld_object_init()
+ * @key: The cached key of the TLD in tld_key_map
+ * @name: The name of the key associated with a TLD
+ * @size: The size of the TLD. Must be a known constant value
+ *
+ * Return a pointer to the TLD associated with @name; NULL if not found or @size is too
+ * big. @key is used to cache the key if the TLD is found to speed up subsequent calls.
+ * It should be defined as an member of tld_keys of tld_key_t type by the developer.
+ */
+#define tld_get_data(tld_obj, key, name, size)						\
+	({										\
+		void *data = NULL, *_data = (tld_obj)->data_map->data;			\
+		long off = (tld_obj)->key_map->key.off;					\
+		int cnt;								\
+											\
+		if (likely(_data)) {							\
+			if (likely(off > 0)) {						\
+				barrier_var(off);					\
+				if (likely(off < __PAGE_SIZE - size))			\
+					data = _data + off;				\
+			} else {							\
+				cnt = -(off);						\
+				if (likely((tld_obj)->data_map->metadata) &&		\
+				    cnt < (tld_obj)->data_map->metadata->cnt) {		\
+					off = __tld_fetch_key(tld_obj, name, cnt);	\
+					(tld_obj)->key_map->key.off = off;		\
+											\
+					if (likely(off < __PAGE_SIZE - size)) {		\
+						barrier_var(off);			\
+						if (off > 0)				\
+							data = _data + off;		\
+					}						\
+				}							\
+			}								\
+		}									\
+		data;									\
+	})
+
+#endif
-- 
2.47.1


