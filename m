Return-Path: <bpf+bounces-64741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A985B166A5
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A9F18C0544
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6BF2E3398;
	Wed, 30 Jul 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFQ2xN8k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321EC2E2EE7;
	Wed, 30 Jul 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901950; cv=none; b=JbDvo+gxXgMLhLNoWd4Dxg2S+UHBnmcTpE+RCyZ39lIYkGLUpqgQXoKq2JVAFfRTIQ1YWQ+6OZ58inyI2u4EU50FHA9WG3IDmycP5OIddatOCW46AaeItqOWbTcN5r1YX1YDrPZ5eV/XjmlLxAMkaqya/3aADvPdgwbjNDwMBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901950; c=relaxed/simple;
	bh=j20OTXMex8wL5Qbw1uCOCBeiHRqI54gV32jyk2clwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poUudYXsS28c4/RbwKAJfjZal/FOOE0oOa+Gui659O6+vZndYGoUSMcAANenfzHokQDv/YGatC05XcY3KZA+2AXEoq/FYDAgAcxTdyEqhgGvmeI8xDbkG3CDfqxS6shbeMQQOXpSfd4FwEMvb0Lky8zMaEWiXpanOGVt9530cNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFQ2xN8k; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so155057a91.2;
        Wed, 30 Jul 2025 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901947; x=1754506747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/Kfkj93hy/WoUVbOVLDoZP/XSsfiM3PFnTBTBb+UF0=;
        b=KFQ2xN8kaP6lJGyqSPoAQBkmei1gRFaZwgnRKePn3O7DjJ5GoHagw0U2ueJbg1OOBV
         dj9jf75dVU36m9G2KaCU8q2f1uP9fI5fsdODp235VfVammX+chGtET8ADLzhDy3xBWC5
         MkvwoBRw8o77dtRnM8lhY9adBOIWOOTsFTjjxFWhcfWfWRP7qfucKHknOdbhDekMrSUG
         gD6NEBrZvFW8OSh3qdUkU+ynvN/0UxisjzZrOHpnBTPoMdbJwPN/nhz2UYM9bNtQWY9c
         +CniVg4AQm3Mf7XmEr1/MdTpDLPfbP1dm8Pf7HjXCu6snnhgGs/OT3IUEM6HacqecjBj
         +eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901947; x=1754506747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/Kfkj93hy/WoUVbOVLDoZP/XSsfiM3PFnTBTBb+UF0=;
        b=mQT2MXvgUpMLcK6zZL/7GiMwpyMZ8gnSTm+/K9XC3OGHW5Nqf7DWRvcXJ3iitPxvd/
         eqjcN8WVSQVkVu7rUxxZ1TzDNRaZiWj/w92opMJ2p/a+GXfQriVK2TcdKKfgE/1gmsYM
         KdY2l9Odit9H/U4CMxxgILKlo4vlbGdsOk1xWRJEyEy6hf9eGA7CAFsl5IU7vBdkylEj
         s2gS0TigNW7rVNkibgsT/3xVTYDI2912RrZgi5txKLPO7+BwIPUXSZNXG7yIoEXDuW9F
         +XjjCc0LS4JXqXqSusXc/TfZXb4ZE1W+luQGxCVxlhao6bYc/baQz50Ro7gx8NMxsrsg
         h8sg==
X-Gm-Message-State: AOJu0Yzcfcs49aKym7Vra3Lp6V7qKp4BPqgfy8VpgIwHta7PJkteKYEQ
	af3wbQB/4Oie0QFafJOT6DeJxJWdxdyn7Em6FSz7cen4lowvs0v6XM/J/+VDRw==
X-Gm-Gg: ASbGncu2BbOJ6lBJoOLirS27Q6yrvJ3x1/mutX7vbKcIb1RNBPQkRqYxT/k2HYFW31G
	+k1n2daqrG57KRIJRzasS6SROk46YiIVFDoBowSAwv9gwc0h2+DgVlWjvuHEKgVmU/yI7O7KAV7
	Kgbm9XOumlxM7dnX6g/qyhJvYivGttpiB7wQl+Ik2xHrxm1hoPZg0km0j1Yx81ZL60YmXg40vSU
	NHZeNxXNw9cl/Ec/sPw0YKJA5FEglJ/rfYogRjbPX/QTUgz3dXUHEfE9xVb83u1nog3u4hIHgsm
	TgPGZXsfDnz8akhV6YPJ9Z6yrbdLjdaWBQ2446TYJdaXKjRBMp5XzC8kp06K3seTGhgMioLqZ/m
	waekImhwUtibkCoj+ZbA0K8+M
X-Google-Smtp-Source: AGHT+IGfe+r/eAr3sUowIvTBgNBEjsORFnu9iVxCGFJ5FolsK2LVFydAKpBWXwLmts4wkFzJeiCtDQ==
X-Received: by 2002:a17:90b:4a45:b0:31f:6d95:8f76 with SMTP id 98e67ed59e1d1-31f6d9599afmr3316715a91.29.1753901946653;
        Wed, 30 Jul 2025 11:59:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f33e58sm2636570a91.33.2025.07.30.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:59:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	linux-lists@etsalapatis.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 2/4] selftests/bpf: Introduce task local data
Date: Wed, 30 Jul 2025 11:58:53 -0700
Message-ID: <20250730185903.3574598-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730185903.3574598-1-ameryhung@gmail.com>
References: <20250730185903.3574598-1-ameryhung@gmail.com>
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

- tld_meta_u, shared by all tasks of a process, consists of the total
  count and size of TLDs and an array of metadata of TLDs. A TLD
  metadata contains the size and name. The name is used to identify a
  specific TLD in bpf programs.

- u_tld_data points to a task-specific memory. It stores TLD data and
  the starting offset of data in a page.

  Task local design decouple user space and bpf programs. Since bpf
  program does not know the size of TLDs in compile time, u_tld_data
  is declared as a page to accommodate TLDs up to a page. As a result,
  while user space will likely allocate memory smaller than a page for
  actual TLDs, it needs to pin a page to kernel. It will pin the page
  that contains enough memory if the allocated memory spans across the
  page boundary.

The library also creates another task local storage map, tld_key_map,
to cache keys for bpf programs to speed up the access.

Below are the core task local data API:

                   User space                          BPF
  Define TLD       TLD_DEFINE_KEY(), tld_create_key()  -
  Init TLD object  -                                   tld_object_init()
  Get TLD data     tld_get_data()                      tld_get_data()

- TLD_DEFINE_KEY(), tld_create_key()

  A TLD is first defined by the user space with TLD_DEFINE_KEY() or
  tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and
  allocates just enough memory during initialization. tld_create_key()
  allows creating TLDs on the fly, but has a fix memory budget,
  TLD_DYN_DATA_SIZE.

  Internally, they all call __tld_create_key(), which iterates
  tld_meta_u->metadata to check if a TLD can be added. The total TLD
  size needs to fit into a page (limit of UPTR), and no two TLDs can
  have the same name. If a TLD can be added, u_tld_meta->cnt is
  increased using cmpxchg as there may be other concurrent
  __tld_create_key(). After a successful cmpxchg, the last available
  tld_meta_u->metadata now belongs to the calling thread. To prevent
  other threads from reading incomplete metadata while it is being
  updated, tld_meta_u->metadata->size is used to signal the completion.

  Finally, the offset, derived from adding up prior TLD sizes is then
  encapsulated as an opaque object key to prevent user misuse. The
  offset is guaranteed to be 8-byte aligned to prevent load/store
  tearing and allow atomic operations on it.

- tld_get_data()

  User space programs can pass the key to tld_get_data() to get a
  pointer to the associated TLD. The pointer will remain valid for the
  lifetime of the thread.

  tld_data_u is lazily allocated on the first call to tld_get_data().
  Trying to read task local data from bpf will result in -ENODATA
  during tld_object_init(). The task-specific memory need to be freed
  manually by calling tld_free() on thread exit to prevent memory leak
  or use TLD_FREE_DATA_ON_THREAD_EXIT.

- tld_object_init() (BPF)

  BPF programs need to call tld_object_init() before calling
  tld_get_data(). This is to avoid redundant map lookup in
  tld_get_data() by storing pointers to the map values on stack.
  The pointers are encapsulated as tld_object.

  tld_key_map is also created on the first time tld_object_init()
  is called to cache TLD keys successfully fetched by tld_get_data().

  bpf_task_storage_get(.., F_CREATE) needs to be retried since it may
  fail when another thread has already taken the percpu counter lock
  for the task local storage.

- tld_get_data() (BPF)

  BPF programs can also get a pointer to a TLD with tld_get_data().
  It uses the cached key in tld_key_map to locate the data in
  tld_data_u->data. If the cached key is not set yet (<= 0),
  __tld_fetch_key() will be called to iterate tld_meta_u->metadata
  and find the TLD by name. To prevent redundant string comparison
  in the future when the search fail, the tld_meta_u->cnt is stored
  in the non-positive range of the key. Next time, __tld_fetch_key()
  will be called only if there are new TLDs and the search will start
  from the newly added tld_meta_u->metadata using the old
  tld_meta_u-cnt.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.h          | 386 ++++++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 237 +++++++++++
 2 files changed, 623 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
new file mode 100644
index 000000000000..a408d10c3688
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -0,0 +1,386 @@
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
+ *   tld_get_data(). The thread that calls it must also call tld_free() on thread exit
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
+struct tld_meta_u {
+	_Atomic __u8 cnt;
+	__u16 size;
+	struct tld_metadata metadata[];
+};
+
+struct tld_data_u {
+	__u64 start; /* offset of tld_data_u->data in a page */
+	char data[];
+};
+
+struct tld_map_value {
+	void *data;
+	struct tld_meta_u *meta;
+};
+
+struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
+__thread struct tld_data_u *tld_data_p __attribute__((weak));
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
+static int __tld_init_meta_p(void)
+{
+	struct tld_meta_u *meta, *uninit = NULL;
+	int err = 0;
+
+	meta = (struct tld_meta_u *)aligned_alloc(TLD_PAGE_SIZE, TLD_PAGE_SIZE);
+	if (!meta) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memset(meta, 0, TLD_PAGE_SIZE);
+	meta->size = TLD_DYN_DATA_SIZE;
+
+	if (!atomic_compare_exchange_strong(&tld_meta_p, &uninit, meta)) {
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
+static int __tld_init_data_p(int map_fd)
+{
+	bool use_aligned_alloc = false;
+	struct tld_map_value map_val;
+	struct tld_data_u *data;
+	void *data_alloc = NULL;
+	int err, tid_fd = -1;
+
+	tid_fd = syscall(SYS_pidfd_open, gettid(), O_EXCL);
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
+	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
+	 *          total size of TLDs defined via TLD_DEFINE_KEY()
+	 */
+	data_alloc = (use_aligned_alloc || tld_meta_p->size * 2 >= TLD_PAGE_SIZE) ?
+		aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
+		malloc(tld_meta_p->size * 2);
+	if (!data_alloc) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Always pass a page-aligned address to UPTR since the size of tld_map_value::data
+	 * is a page in BTF. If data_alloc spans across two pages, use the page that contains large
+	 * enough memory.
+	 */
+	if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)data_alloc) >= tld_meta_p->size) {
+		map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data_alloc);
+		data = data_alloc;
+		data->start = (~TLD_PAGE_MASK & (intptr_t)data_alloc) +
+			      offsetof(struct tld_data_u, data);
+	} else {
+		map_val.data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
+		data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
+		data->start = offsetof(struct tld_data_u, data);
+	}
+	map_val.meta = TLD_READ_ONCE(tld_meta_p);
+
+	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
+	if (err) {
+		free(data_alloc);
+		goto out;
+	}
+
+	tld_data_p = data;
+	tld_data_alloc_p = data_alloc;
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
+	if (!TLD_READ_ONCE(tld_meta_p)) {
+		err = __tld_init_meta_p();
+		if (err)
+			return (tld_key_t){err};
+	}
+
+	for (i = 0; i < TLD_MAX_DATA_CNT; i++) {
+retry:
+		cnt = atomic_load(&tld_meta_p->cnt);
+		if (i < cnt) {
+			/* A metadata is not ready until size is updated with a non-zero value */
+			while (!(sz = atomic_load(&tld_meta_p->metadata[i].size)))
+				sched_yield();
+
+			if (!strncmp(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN))
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
+			if (off + TLD_ROUND_UP(size, 8) > tld_meta_p->size)
+				return (tld_key_t){-E2BIG};
+		} else {
+			if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE - sizeof(struct tld_data_u))
+				return (tld_key_t){-E2BIG};
+			tld_meta_p->size += TLD_ROUND_UP(size, 8);
+		}
+
+		/*
+		 * Only one tld_create_key() can increase the current cnt by one and
+		 * takes the latest available slot. Other threads will check again if a new
+		 * TLD can still be added, and then compete for the new slot after the
+		 * succeeding thread update the size.
+		 */
+		if (!atomic_compare_exchange_strong(&tld_meta_p->cnt, &cnt, cnt + 1))
+			goto retry;
+
+		strncpy(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN);
+		atomic_store(&tld_meta_p->metadata[i].size, size);
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
+	if (!TLD_READ_ONCE(tld_meta_p))
+		return NULL;
+
+	/* tld_data_p is allocated on the first invocation of tld_get_data() */
+	if (!tld_data_p && __tld_init_data_p(map_fd))
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
index 000000000000..432fff2af844
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -0,0 +1,237 @@
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
+#ifndef TLD_KEY_MAP_CREATE_RETRY
+#define TLD_KEY_MAP_CREATE_RETRY 10
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
+struct tld_meta_u {
+	__u8 cnt;
+	__u16 size;
+	struct tld_metadata metadata[TLD_MAX_DATA_CNT];
+};
+
+struct tld_data_u {
+	__u64 start; /* offset of tld_data_u->data in a page */
+	char data[__PAGE_SIZE - sizeof(__u64)];
+};
+
+struct tld_map_value {
+	struct tld_data_u __uptr *data;
+	struct tld_meta_u __uptr *meta;
+};
+
+typedef struct tld_uptr_dummy {
+	struct tld_data_u data[0];
+	struct tld_meta_u meta[0];
+} *tld_uptr_dummy_t;
+
+struct tld_object {
+	struct tld_map_value *data_map;
+	struct tld_keys *key_map;
+	/*
+	 * Force the compiler to generate the actual definition of tld_meta_u
+	 * and tld_data_u in BTF. Without it, tld_meta_u and u_tld_data will
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
+	int i;
+
+	tld_obj->data_map = bpf_task_storage_get(&tld_data_map, task, 0, 0);
+	if (!tld_obj->data_map)
+		return -ENODATA;
+
+	bpf_for(i, 0, TLD_KEY_MAP_CREATE_RETRY) {
+		tld_obj->key_map = bpf_task_storage_get(&tld_key_map, task, 0,
+							BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (likely(tld_obj->key_map))
+			break;
+	}
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
+	if (!tld_obj->data_map || !tld_obj->data_map->data || !tld_obj->data_map->meta)
+		return 0;
+
+	start = tld_obj->data_map->data->start;
+	cnt = tld_obj->data_map->meta->cnt;
+	metadata = tld_obj->data_map->meta->metadata;
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
+				if (likely((tld_obj)->data_map->meta) &&		\
+				    cnt < (tld_obj)->data_map->meta->cnt) {		\
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
2.47.3


