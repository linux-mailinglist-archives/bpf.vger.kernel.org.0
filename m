Return-Path: <bpf+bounces-67979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD908B50BC5
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87392540C28
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC9425A642;
	Wed, 10 Sep 2025 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1dju9gu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEA2571C7;
	Wed, 10 Sep 2025 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472378; cv=none; b=U8KnOe5nTfdAZuVvAJBgsywxIYKGG/l9FL9gt5Sghrkd7SpANUrig4Q0cI6zXEsjonV/Ts9KtcHLPL1T3bffRDhlVyZXtDQk4m/AwLcTiZGdVbGaXbMGnuSc6e2JLk4CQll30fL0oUrurm01Xz54I+37bHSBBWetS5HLPhkxko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472378; c=relaxed/simple;
	bh=zyoIzYuw7nrdWKPxj4Ys65KXT7z9JOzwotORPZjKzN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfLPCywJmr5D+fydrQ8Zl+IVjtTmn9ArfqkhWZTkHRBvupgWsBMAGGzFpVpGM/wgzM9V89irFbNSZ53cEJRD58O7D8PXiNkfjMAofBGDgDRyE+zNC36RrRjfKfk1oruH2dDLpbTQIIASUXgcCeob2vzDI8V7ZrPU5gkBP3G0TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1dju9gu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so5255796a91.2;
        Tue, 09 Sep 2025 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472376; x=1758077176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmjjT9DR/3tljJqq0GB/FfILlFmOzlQS2r75W53W/R0=;
        b=I1dju9guoUJRtuvVg03JlRSUP8Hv6w2L8Hz0K5FGq/PJFm9F40JgSukOI/c0Qur9FV
         ILoAet9BB2RnTul8URLvJut2KvK2hRZFcOG0qCHyd7Nl0RIDCK+JF0gjkvNUADErMYJq
         40rhkRXrFcZ9YcpkdAVleUwRJs+S4cgHuHXLRm48RRdtG2J/wmVriuh0RUGGz0bCwC69
         1AXgtfKU2EEIPcwJR4iAAWS2UQAXZC/UBn4XOqwzZg1u9bbHBK4qhQS7J4lma6Mwa88a
         5ugloo1DBdmWxhq9mqwem8WauEQh5ZDb+Ft/6T8dGqn7Xbad3z1cpEkPoW/XBDIT7VU+
         2QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472376; x=1758077176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmjjT9DR/3tljJqq0GB/FfILlFmOzlQS2r75W53W/R0=;
        b=Xd/uMPup8GdE9iUQAK5hnFSyAC3CxLvQTPy4EGmRos+o6O1j+GVu+iNM/U9SQyizWz
         n0U2P1vgZBwvaqdnDIREK31LjBckLSOj70SlmZCv96O3RLQVaK9vCYRuj0LAx/W6xwPW
         a2UzP68wpHlcmYw3WrhDK4WNA02EvLIuWH51kSq2EDLqSNcusayu9OTgMWwcVc0OEc+9
         rNjFPF9ki5FnfaUUoNThKEm8KhcA9pGcP6AOkDTgmww9VfxdfLoJfWY8/MZ5aZwE4nQ7
         jCy8HUIea+Y1kSSddeouVeAiZhy7tF/ACKhZKPDKeqF9etEVaLjCpozxZ2ZAZL2ZSCT2
         vj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3T1fqdvAEsYYFFMY8236ZNAPk8V1QdtxgcK6P0RSrheFNrFFWRRVcePAsjqTaiZwoq2c5dCc44yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3spNd28izvaIFKEdyrw3jyQuQyq8TSLETCy190MdbfPASsSEF
	4UU+45E+CLSp4otP7WIzrO6mUwnlDOZMwPFSz6pSki+8uQ9OPuX3zep1
X-Gm-Gg: ASbGnct3xi/bkOex7cuRg/5l2gY41HEEJAxsUELHBBVnmN0xc+HK58sVzcyihdFfpS6
	23KPZSDm1ZGmSNNSF+ahkP3zoJkTCItSPa6FShYuWL0ohe0w3TgcFJt0JH3r4FF92slcYFRXLz5
	t9HRhN74JpTZz6WVGaWd4ovZGL/YqmvW68qBfNOUn3uepnk3b1A8zLk8U4bWHKvnyp9jnNUmrrO
	2Ppi0ibyAiy2QFdOzLxmyF2sLJSxqwwxOb4P6UYEbwtBvLxr7pej1jSzjA8DZOmkaM8yr3vHQ0s
	hoA46uAXjWXn0C9QfX+/qI5MU68LOMdIVDvDCxOsjiS8/lnSkEJNKT6Z0x6tnJ2YaQ1iuxExti1
	SjkEX2K/+HJIel7BPIkkH2/E0DyVswBMrhhbZtL4i304YqfjJWXmLJqHLPnZ9yXs42aOuggOY7B
	a1sCc=
X-Google-Smtp-Source: AGHT+IFQGh0hjvn/NOruUGlSVh8st5OVWC2h57uNrMSSLbhOEzYSk4xyiaT+mU+W5Iq+IXv8sVwFZw==
X-Received: by 2002:a17:90b:17c8:b0:32b:be45:6864 with SMTP id 98e67ed59e1d1-32d43f6da5bmr16537904a91.25.1757472375751;
        Tue, 09 Sep 2025 19:46:15 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.46.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:46:15 -0700 (PDT)
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
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 07/10] selftests/bpf: add a simple BPF based THP policy
Date: Wed, 10 Sep 2025 10:44:44 +0800
Message-Id: <20250910024447.64788-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
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
page fault handler.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 254 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 100 +++++++
 4 files changed, 359 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d055a3c95300..6aa5543963d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16255,6 +16255,8 @@ F:	mm/huge_memory.c
 F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
+F:	tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+F:	tools/testing/selftests/bpf/progs/test_thp_adjust*
 F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8916ab814a3e..b2c73cfae14e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -26,6 +26,7 @@ CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_BPF_GET_THP_ORDER=y
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
index 000000000000..93c7927e827a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+int pf_alloc, pf_disallow, khugepaged_disallow;
+struct mm_struct *target_mm;
+int pmd_order, cgrp_id;
+
+/* Detecting whether a task can successfully allocate THP is unreliable because
+ * it may be influenced by system memory pressure. Instead of making the result
+ * dependent on unpredictable factors, we should simply check
+ * bpf_hook_thp_get_orders()'s return value, which is deterministic.
+ */
+SEC("fexit/bpf_hook_thp_get_orders")
+int BPF_PROG(thp_run, struct vm_area_struct *vma, u64 vma_flags, enum tva_type tva_type,
+	     unsigned long orders, int retval)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm != target_mm)
+		return 0;
+
+	if (orders != (1 << pmd_order))
+		return 0;
+
+	if (tva_type == TVA_PAGEFAULT) {
+		if (retval == (1 << pmd_order))
+			pf_alloc++;
+		else if (retval == (1 << 0))
+			pf_disallow++;
+	} else if (tva_type == TVA_KHUGEPAGED) {
+		/* khugepaged is not triggered immediately, so its allocation
+		 * counts are unreliable.
+		 */
+		if (retval == (1 << 0))
+			khugepaged_disallow++;
+	}
+	return 0;
+}
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(alloc_in_khugepaged, struct vm_area_struct *vma, enum bpf_thp_vma_type vma_type,
+	     enum tva_type tva_type, unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct task_struct *p, *acquired;
+	int suggested_order = 0;
+	struct cgroup *cgrp;
+
+	if (orders != (1 << pmd_order))
+		return 0;
+
+	if (!mm)
+		return 0;
+
+	/* This BPF hook is already under RCU */
+	p = mm->owner;
+	if (!p)
+		return 0;
+
+	acquired = bpf_task_acquire(p);
+	if (!acquired)
+		return 0;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp) {
+		bpf_task_release(acquired);
+		return 0;
+	}
+
+	if (bpf_task_under_cgroup(acquired, cgrp)) {
+		if (!target_mm)
+			target_mm = mm;
+
+		/* BPF THP allocation policy:
+		 * - Allow PMD allocation in khugepagd only
+		 * - "THPeligible" in /proc/<pid>/smaps is also set
+		 */
+		if (tva_type == TVA_KHUGEPAGED || tva_type == TVA_SMAPS)
+			suggested_order = pmd_order;
+	}
+	bpf_cgroup_release(cgrp);
+	bpf_task_release(acquired);
+	return suggested_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops khugepaged_ops = {
+	.thp_get_order = (void *)alloc_in_khugepaged,
+};
-- 
2.47.3


