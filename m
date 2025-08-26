Return-Path: <bpf+bounces-66515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F4B3557A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427365E2D79
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A972FE573;
	Tue, 26 Aug 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1DQkrqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A27CB04;
	Tue, 26 Aug 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192874; cv=none; b=lYGryWHnqgghABC4IvBhfNaxrQlQfMRfcnJHcBaGhD0O6LsWXoCx4CW0nQebJaq0cMfeMXtSSz0kkgnT1mijSUlY99c2eKTICCfPYrdhrk0KnE0uCU6TZXRbKVLLRQOl9m9GrtVsfTBz2coqNRmaVkFzzRB0VkrGAutaewJ5ySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192874; c=relaxed/simple;
	bh=ulnZMLb/KuYeo8ysNrbEj4ojmabbhT+i+oX2fXgxWMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGFx60/A7vrV1KaT8ZAxw4rW/K3qYrNOTL89SX3du8EKLe5ag8xLbQ2/r6/+EZFbAj13uaTKI1Sp2HTKII1phVsveNfxWgorc9kEqueh7ZOw2tNJMUNy9lcI4HZtPSgh1YZe6hpTDZfw9FC4BJMZcjo13MXRjN5YaG2zucLTh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1DQkrqU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771e15ce64eso1392831b3a.0;
        Tue, 26 Aug 2025 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192867; x=1756797667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGB9Y8Xro5EcYuOr6YGEfLC07C5z6V9YadzxMUUT2ks=;
        b=b1DQkrqUtwc1EiC3S+An2p742EPAKUqavTPBmZGJ7QdKMamY8JvdrHod582jwk3/H7
         UcGBSHq8sXXQneaYHK1DtFNvrYbqCxpzWhgTPbigVhedUuqKulov/9ErFeWhNUoEVeUX
         1bRRBm3+MBI+lGnPEEb3IsAQATdKcUGu1gb61N4NoWY//amcze3d6ewESaQiScZKtNK7
         0I2ZUEXLOROspprb3vY91fWaGYvBNTyylmrE7ZhxRJpLdqpj0MIGbX+gtUUCYmbKmdQ4
         XOoHPDhLSMq2w/5r21xdviurbmMD4xI6kyLCT2pIbzMeos6k4YJEoRR6OD26XQBmFVKj
         4fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192867; x=1756797667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGB9Y8Xro5EcYuOr6YGEfLC07C5z6V9YadzxMUUT2ks=;
        b=gDzfAJao09py3rhD54Hhs5ooZCdlrxcaVUPE7G5xR2Y0zgC3jY4ZZS+e6iPO8AxSFl
         afkv/WeFbmWQuHBYklc3cdW+s40byy/uEgg2txX6zrJZIcsbx89BLRxPVzQtglRQo/Cr
         gF2VqNaxVsBComGROxSDu78LBaTRaJejBuzfwCAphu6Dei74eX9cxrV+JMZqAP5lyN8c
         LkjYv1aUULaYPgJ9Qmcg13lS4j2TD4W+iLwZYsQFCwp6S2KEBzYA0q6smrimzZz9UStH
         k4SSa6Y6tCZy/eNqHXqU8ZMXhg6TLzZfUAMZakjmjo3mYnBNd4Mv/ZfUJEULwap88RIZ
         A+HA==
X-Forwarded-Encrypted: i=1; AJvYcCWH9D4cPWOgJQ0rDprvNrf1qd2D7wvLNfbHQxWVa9SoFsj1wIzduwyMpnRI40bPP0LyEjuueGDBSoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygn8y+B8XJ5Sgp7Efb1XYrVFji0Dgnld2qft/yH4GdyuBrd4yA
	VkgvdImcj6yT3vMGgaOCygNiI7vRPgrUf+7mnIb6brSSe/beAXbECQMT
X-Gm-Gg: ASbGncs/lgfy6rUWG2PU+2jrP/2wcN+OeBl2S8ocG7loEIGceTARozZR9WgygZii+LJ
	5GqvlcWfipyRBl2NPMFpu9omOQZkQtoKBtosjYec9VsDlIkmZt6HiG8efzo4tWZ1PqE0RV5va3r
	VprmXmdDzXKRE4qO1NW4nVo3KU4tCxCBi+ovIEJodOniec86Q8/wo1m/TJqvK60FbD3DCdyQ+zu
	YI4NH5JvkrrmDO4cdqH+fzwXFugX3la0EGCMmCiV9HvGsefkIxuHtDH7TWyTVzOwlMribc2Tenw
	0v8rtwj36G6qHcCDQ14n7IX1DcDrM0nRh+Sd7JwzYRwICrSVY48EBED0EakuB2h962ZcZty8NZf
	sOuZOIUC9W/4eh3PSMQOngocCK/qrLpeqLeW4YuznkedNQ/fJuSAGUEH2g7ddPbdVt1sXDFKd3H
	bcVSjdC3qK2iFZ6g==
X-Google-Smtp-Source: AGHT+IEuzHfOcMwGQYabj+FZdsdhYqnkn3QUeqG3upN+hixq2fMPWnAPeOug0HXFBBhydpDgPCXXhQ==
X-Received: by 2002:a05:6a00:99e:b0:76c:503:180d with SMTP id d2e1a72fcca58-7702f9e8eb1mr19500788b3a.8.1756192867161;
        Tue, 26 Aug 2025 00:21:07 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.20.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:21:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 05/10] selftests/bpf: add a simple BPF based THP policy
Date: Tue, 26 Aug 2025 15:19:43 +0800
Message-Id: <20250826071948.2618-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This selftest verifies that PMD-mapped THP allocation is restricted in
page faults for tasks within a specific cgroup, while still permitting
THP allocation via khugepaged.

Since THP allocation depends on various factors (e.g., system memory
pressure), using the actual allocated THP size for validation is
unreliable. Instead, we check the return value of get_suggested_order(),
which indicates whether the system intends to allocate a THP, regardless of
whether the allocation ultimately succeeds.

This test case defines a simple THP policy. The policy permits
PMD-mapped THP allocation through khugepaged for tasks in a designated
cgroup, but prohibits it for all other tasks and contexts, including the
page fault handler. However, khugepaged might not run immediately during
this test, making its count metrics unreliable.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 254 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  76 ++++++
 3 files changed, 333 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8916ab814a3e..27f0249c7600 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -26,6 +26,7 @@ CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
@@ -51,6 +52,7 @@ CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
+CONFIG_MEMCG=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_MODULE_UNLOAD=y
@@ -114,6 +116,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_UDMABUF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..a4a34ee28301
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <math.h>
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_thp_adjust.skel.h"
+
+#define LEN (16 * 1024 * 1024) /* 16MB */
+#define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
+#define PMD_SIZE_FILE "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+
+static struct test_thp_adjust *skel;
+static char *thp_addr, old_mode[32];
+static long pagesize;
+
+static int thp_mode_save(void)
+{
+	const char *start, *end;
+	char buf[128];
+	int fd, err;
+	size_t len;
+
+	fd = open(THP_ENABLED_FILE, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	err = read(fd, buf, sizeof(buf) - 1);
+	if (err == -1)
+		goto close;
+
+	start = strchr(buf, '[');
+	end = start ? strchr(start, ']') : NULL;
+	if (!start || !end || end <= start) {
+		err = -1;
+		goto close;
+	}
+
+	len = end - start - 1;
+	if (len >= sizeof(old_mode))
+		len = sizeof(old_mode) - 1;
+	strncpy(old_mode, start + 1, len);
+	old_mode[len] = '\0';
+
+close:
+	close(fd);
+	return err;
+}
+
+static int thp_mode_set(const char *desired_mode)
+{
+	int fd, err;
+
+	fd = open(THP_ENABLED_FILE, O_RDWR);
+	if (fd == -1)
+		return -1;
+
+	err = write(fd, desired_mode, strlen(desired_mode));
+	close(fd);
+	return err;
+}
+
+static int thp_mode_reset(void)
+{
+	int fd, err;
+
+	fd = open(THP_ENABLED_FILE, O_WRONLY);
+	if (fd == -1)
+		return -1;
+
+	err = write(fd, old_mode, strlen(old_mode));
+	close(fd);
+	return err;
+}
+
+static int thp_alloc(void)
+{
+	int err, i;
+
+	thp_addr = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (thp_addr == MAP_FAILED)
+		return -1;
+
+	err = madvise(thp_addr, LEN, MADV_HUGEPAGE);
+	if (err == -1)
+		goto unmap;
+
+	/* Accessing a single byte within a page is sufficient to trigger a page fault. */
+	for (i = 0; i < LEN; i += pagesize)
+		thp_addr[i] = 1;
+	return 0;
+
+unmap:
+	munmap(thp_addr, LEN);
+	return -1;
+}
+
+static void thp_free(void)
+{
+	if (!thp_addr)
+		return;
+	munmap(thp_addr, LEN);
+}
+
+static int get_pmd_order(void)
+{
+	ssize_t bytes_read, size;
+	int fd, order, ret = -1;
+	char buf[64], *endptr;
+
+	fd = open(PMD_SIZE_FILE, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	bytes_read = read(fd, buf, sizeof(buf) - 1);
+	if (bytes_read <= 0)
+		goto close_fd;
+
+	/* Remove potential newline character */
+	if (buf[bytes_read - 1] == '\n')
+		buf[bytes_read - 1] = '\0';
+
+	size = strtoul(buf, &endptr, 10);
+	if (endptr == buf || *endptr != '\0')
+		goto close_fd;
+	if (size % pagesize != 0)
+		goto close_fd;
+	ret = size / pagesize;
+	if ((ret & (ret - 1)) == 0) {
+		order = 0;
+		while (ret > 1) {
+			ret >>= 1;
+			order++;
+		}
+		ret = order;
+	}
+
+close_fd:
+	close(fd);
+	return ret;
+}
+
+static void subtest_thp_policy(void)
+{
+	struct bpf_link *fentry_link, *ops_link;
+
+	/* After attaching struct_ops, THP will be allocated only in khugepaged . */
+	ops_link = bpf_map__attach_struct_ops(skel->maps.khugepaged_ops);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		return;
+
+	/* Create a new BPF program to detect the result. */
+	fentry_link = bpf_program__attach_trace(skel->progs.thp_run);
+	if (!ASSERT_OK_PTR(fentry_link, "attach fentry"))
+		goto detach_ops;
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto detach;
+
+	if (!ASSERT_EQ(skel->bss->pf_alloc, 0, "alloc_in_pf"))
+		goto thp_free;
+	if (!ASSERT_GT(skel->bss->pf_disallow, 0, "disallow_in_pf"))
+		goto thp_free;
+
+	ASSERT_EQ(skel->bss->khugepaged_disallow, 0, "disallow_in_khugepaged");
+thp_free:
+	thp_free();
+detach:
+	bpf_link__destroy(fentry_link);
+detach_ops:
+	bpf_link__destroy(ops_link);
+}
+
+static int thp_adjust_setup(void)
+{
+	int err, cgrp_fd, cgrp_id, pmd_order;
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	pmd_order = get_pmd_order();
+	if (!ASSERT_NEQ(pmd_order, -1, "get_pmd_order"))
+		return -1;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "cgrp_env_setup"))
+		return -1;
+
+	cgrp_fd = create_and_get_cgroup("thp_adjust");
+	if (!ASSERT_GE(cgrp_fd, 0, "create_and_get_cgroup"))
+		goto cleanup;
+	close(cgrp_fd);
+
+	err = join_cgroup("thp_adjust");
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto remove_cgrp;
+
+	err = -1;
+	cgrp_id = get_cgroup_id("thp_adjust");
+	if (!ASSERT_GE(cgrp_id, 0, "create_and_get_cgroup"))
+		goto join_root;
+
+	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
+		goto join_root;
+	if (!ASSERT_GE(thp_mode_set("madvise"), 0, "THP mode set"))
+		goto join_root;
+
+	skel = test_thp_adjust__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto thp_reset;
+
+	skel->bss->cgrp_id = cgrp_id;
+	skel->bss->pmd_order = pmd_order;
+
+	err = test_thp_adjust__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+	return 0;
+
+destroy:
+	test_thp_adjust__destroy(skel);
+thp_reset:
+	ASSERT_GE(thp_mode_reset(), 0, "THP mode reset");
+join_root:
+	/* We must join the root cgroup before removing the created cgroup. */
+	err = join_root_cgroup();
+	ASSERT_OK(err, "join_cgroup to root");
+remove_cgrp:
+	remove_cgroup("thp_adjust");
+cleanup:
+	cleanup_cgroup_environment();
+	return err;
+}
+
+static void thp_adjust_destroy(void)
+{
+	int err;
+
+	test_thp_adjust__destroy(skel);
+	ASSERT_GE(thp_mode_reset(), 0, "THP mode reset");
+	err = join_root_cgroup();
+	ASSERT_OK(err, "join_cgroup to root");
+	if (!err)
+		remove_cgroup("thp_adjust");
+	cleanup_cgroup_environment();
+}
+
+void test_thp_adjust(void)
+{
+	if (thp_adjust_setup() == -1)
+		return;
+
+	if (test__start_subtest("alloc_in_khugepaged"))
+		subtest_thp_policy();
+
+	thp_adjust_destroy();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
new file mode 100644
index 000000000000..635915f31786
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pf_alloc, pf_disallow, khugepaged_disallow;
+struct mm_struct *target_mm;
+int pmd_order, cgrp_id;
+
+/* Detecting whether a task can successfully allocate THP is unreliable because
+ * it may be influenced by system memory pressure. Instead of making the result
+ * dependent on unpredictable factors, we should simply check
+ * get_suggested_order()'s return value, which is deterministic.
+ */
+SEC("fexit/get_suggested_order")
+int BPF_PROG(thp_run, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, u64 tva_flags, int orders, int retval)
+{
+	if (mm != target_mm)
+		return 0;
+
+	if (orders != (1 << pmd_order))
+		return 0;
+
+	if (tva_flags == TVA_PAGEFAULT) {
+		if (retval == (1 << pmd_order))
+			pf_alloc++;
+		else if (!retval)
+			pf_disallow++;
+	} else if (tva_flags == TVA_KHUGEPAGED || tva_flags == -1) {
+		/* khugepaged is not triggered immediately, so its allocation
+		 * counts are unreliable.
+		 */
+		if (!retval)
+			khugepaged_disallow++;
+	}
+	return 0;
+}
+
+SEC("struct_ops/get_suggested_order")
+int BPF_PROG(alloc_in_khugepaged, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, enum tva_type tva_flags, int orders)
+{
+	struct mem_cgroup *memcg;
+	int suggested_orders = 0;
+
+	if (orders != (1 << pmd_order))
+		return 0;
+
+	/* Only works when CONFIG_MEMCG is enabled. */
+	memcg = bpf_mm_get_mem_cgroup(mm);
+	if (!memcg)
+		return 0;
+
+	if (memcg->css.cgroup->kn->id == cgrp_id) {
+		if (!target_mm)
+			target_mm = mm;
+
+		/* BPF THP allocation policy:
+		 * - Allow PMD allocation in khugepagd only
+		 */
+		if (tva_flags == TVA_KHUGEPAGED || tva_flags == -1)
+			suggested_orders = orders;
+	}
+
+	bpf_put_mem_cgroup(memcg);
+	return suggested_orders;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops khugepaged_ops = {
+	.get_suggested_order = (void *)alloc_in_khugepaged,
+};
-- 
2.47.3


