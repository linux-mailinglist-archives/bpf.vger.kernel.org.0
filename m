Return-Path: <bpf+bounces-64601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC5B14B0A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2477A4423
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C823535E;
	Tue, 29 Jul 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlHUvMEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A82217701
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780748; cv=none; b=TH4iRNKHWmhjaCh0+nlWMoIYqR1iNox7YyYNKTSdIWtE+V0tKOU8e72eb7Sw0jCXa0NQcWbNXbT7/oYduOdo1ksfEB5NQpNvncfmbh7xY8/1T5HW53yZwfD47+pt0N+btgnudcjDO2fhAn3ly1IZBTul5YC4DpapGL5F391NENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780748; c=relaxed/simple;
	bh=qomLlLAg4zoW0Hw+tvf8RjTVA9cKSDOe6ypp0sQgbLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5LOP8cx1ZZVGTloy3kV3lB6Yz2xj0/lNE4ct4RwiRJWFaLgV+gonDVnxng65kC3KFIKcxXbiQIwMzSyTn8+edK9qsR/fmtnMUrT3bB7pDDPvxfNVs0xe63/GH/+UdVL2l5ZCzUfnNySma7ESuQnkuC+2miwtEtZ1wXkQaVXCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlHUvMEO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167afeso47158705ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780746; x=1754385546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT/+Vj/WgCPErlp9XpFLiKV4dpfirygddhdeMhc0Kt0=;
        b=JlHUvMEOgZMTBK8/dIq4QTMHXL7JjMq3TVo8QxZNNy7KnaOp4VQXvXpOZyBqvIER17
         +2ld2kiZUvGwvft2VSaSRE4C+D5Kcu3e0gxHRiCVsjphdUSzC56P3n8kD0Hwffh/cIpT
         BX12HYJeVKjecAjN29Yp85Tk12XLXnWOFySS8gGCH1aw5sSPDIMmdFPVZmwZ4gnBJKdB
         cCPcak9E8D8SDdwqxA3p7JLjMBBpKbHmAnVClz3rm+53MWJC5IFw3smFXT+s6FTEwvGR
         AMJxy4ikjuCEuZhww9Hi4EbPwNTu+uPr91BBhnp4rNDwgG99ZmwoR90VFqe56mTaE6dR
         u4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780746; x=1754385546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT/+Vj/WgCPErlp9XpFLiKV4dpfirygddhdeMhc0Kt0=;
        b=EJcXFaqIFBE7lGuG+CVOGTUSf5Oe3hjllOkOCk4gEpoHW4yn5MSbvHSmrRdYM89OKH
         hed4JPN0aNQsWcBgSsPMA60OThFeI4YH4qSqrBPuoVQ3zEBsyK0o8jb9rYTc96mM4v17
         xlOeMYRBRZUoaLybU7j5Z7f8VYO+3nNKM4qWlcoo1E3aQPm5m2PbfLlb/y5t3J0S18fu
         nD0nhjB5/c7q6pb7Se3wb09n5i+Gh0GCXoTRTlFFytI4LCkajADI7Jxe0tLbI0qCPezw
         kn6d3I2iag78jDb98NqApBJVRlhoOv3966U3VZp3dfSebxZpIHi2uzVStftMXSJ+807j
         11FQ==
X-Gm-Message-State: AOJu0YzEG+gG7PlxbL03jH+nG7odwo5LMov4TtIzVwlWNIaoFMpmQYFo
	ftsa/dxI5ebgnX1Ir36JFG/F6ANobOq4rw1TJZmuUqiAdxQQF7fIFKF+
X-Gm-Gg: ASbGncvnkTvzwAUxzyqmDgov0vFMj1wXGv+gvwsDwxboR+tvl5H3sb3llbNxeEPjfS7
	vHktnXY8M7TEmuC2aySRPYK41q4HLKy+gdqOJaxn9qcwJQi5yBNnCAI2pCd638KUclOgo307CDP
	5OoZKhZ/O0bVi1NounsyVRcnalCH+p1zssNGB5VD4+agbTPmkjWWLkqgX7GA/NEOjEdTKsxS9xL
	RlcVR+ZJhODbDo+TGyWY6XuXGK6kQkp652zj4TnwaKGAt7Qjen6p5BckKsZy6vUS/XIQ7ax6h28
	xVBVD6WF9aumdx250yeX6BvRlnvYAM5qGVRzr2VYtYBPwVQjxaNZycUcpOtM8rFEcV82cZ0tSZz
	/PR2qipZR2esFf+1fk9aHYuqpz7BHKbrIVNGwkBFcBkeVd85F
X-Google-Smtp-Source: AGHT+IGa4X0xRoc67h+AzZSsejMIDdMXqt6jt6opygwXwUJngDgycWDtdoNq7WirJcTySXhCP2ekaA==
X-Received: by 2002:a17:902:f30b:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-23ff9835e51mr94639005ad.12.1753780745487;
        Tue, 29 Jul 2025 02:19:05 -0700 (PDT)
Received: from localhost.localdomain ([101.82.174.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30be01sm74337015ad.39.2025.07.29.02.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 02:19:04 -0700 (PDT)
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
	ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 4/4] selftest/bpf: add selftest for BPF based THP order seletection
Date: Tue, 29 Jul 2025 17:18:07 +0800
Message-Id: <20250729091807.84310-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250729091807.84310-1-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This self-test verifies that PMD-mapped THP allocation is restricted in
page faults for tasks within a specific cgroup, while still permitting
THP allocation via khugepaged.

Since THP allocation depends on various factors (e.g., system memory
pressure), using the actual allocated THP size for validation is
unreliable. Instead, we check the return value of get_suggested_order(),
which indicates whether the system intends to allocate a THP, regardless of
whether the allocation ultimately succeeds.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 183 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  69 +++++++
 .../bpf/progs/test_thp_adjust_failure.c       |  24 +++
 4 files changed, 278 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f74e1ea0ad3b..0364f945347d 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -118,3 +118,5 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_MEMCG=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..31d03383cbb8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_failure.skel.h"
+
+#define LEN (16 * 1024 * 1024) /* 16MB */
+#define THP_ENABLED_PATH "/sys/kernel/mm/transparent_hugepage/enabled"
+
+static char *thp_addr;
+static char old_mode[32];
+
+int thp_mode_save(void)
+{
+	const char *start, *end;
+	char buf[128];
+	int fd, err;
+	size_t len;
+
+	fd = open(THP_ENABLED_PATH, O_RDONLY);
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
+int thp_set(const char *desired_mode)
+{
+	int fd, err;
+
+	fd = open(THP_ENABLED_PATH, O_RDWR);
+	if (fd == -1)
+		return -1;
+
+	err = write(fd, desired_mode, strlen(desired_mode));
+	close(fd);
+	return err;
+}
+
+int thp_reset(void)
+{
+	int fd, err;
+
+	fd = open(THP_ENABLED_PATH, O_WRONLY);
+	if (fd == -1)
+		return -1;
+
+	err = write(fd, old_mode, strlen(old_mode));
+	close(fd);
+	return err;
+}
+
+int thp_alloc(void)
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
+	for (i = 0; i < LEN; i += 4096)
+		thp_addr[i] = 1;
+	return 0;
+
+unmap:
+	munmap(thp_addr, LEN);
+	return -1;
+}
+
+void thp_free(void)
+{
+	if (!thp_addr)
+		return;
+	munmap(thp_addr, LEN);
+}
+
+void subtest_thp_adjust(void)
+{
+	struct bpf_link *fentry_link, *ops_link;
+	struct test_thp_adjust *skel;
+	int err, cgrp_fd, cgrp_id;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "cgrp_env_setup"))
+		return;
+
+	cgrp_fd = create_and_get_cgroup("thp_adjust");
+	if (!ASSERT_GE(cgrp_fd, 0, "create_and_get_cgroup"))
+		goto cleanup;
+
+	err = join_cgroup("thp_adjust");
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto close_fd;
+
+	cgrp_id = get_cgroup_id("thp_adjust");
+	if (!ASSERT_GE(cgrp_id, 0, "create_and_get_cgroup"))
+		goto join_root;
+
+	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
+		goto join_root;
+	if (!ASSERT_GE(thp_set("madvise"), 0, "THP mode set"))
+		goto join_root;
+
+	skel = test_thp_adjust__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto thp_reset;
+
+	skel->bss->cgrp_id = cgrp_id;
+	skel->bss->target_pid = getpid();
+
+	err = test_thp_adjust__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	fentry_link = bpf_program__attach_trace(skel->progs.thp_run);
+	if (!ASSERT_OK_PTR(fentry_link, "attach fentry"))
+		goto destroy;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		goto destroy;
+
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto destroy;
+
+	/* After attaching struct_ops, THP will be allocated only in khugepaged . */
+	if (!ASSERT_EQ(skel->bss->pf_alloc, 0, "alloc_in_pf"))
+		goto thp_free;
+	if (!ASSERT_GT(skel->bss->pf_disallow, 0, "alloc_in_pf"))
+		goto thp_free;
+
+	if (!ASSERT_GT(skel->bss->khugepaged_alloc, 0, "alloc_in_khugepaged"))
+		goto thp_free;
+	ASSERT_EQ(skel->bss->khugepaged_disallow, 0, "alloc_in_pf");
+
+thp_free:
+	thp_free();
+destroy:
+	test_thp_adjust__destroy(skel);
+thp_reset:
+	ASSERT_GE(thp_reset(), 0, "THP mode reset");
+join_root:
+	/* We must join the root cgroup before removing the created cgroup. */
+	err = join_root_cgroup();
+	ASSERT_OK(err, "join_cgroup to root");
+close_fd:
+	close(cgrp_fd);
+	remove_cgroup("thp_adjust");
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+void test_thp_adjust(void)
+{
+	if (test__start_subtest("thp_adjust"))
+		subtest_thp_adjust();
+	RUN_TESTS(test_thp_adjust_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
new file mode 100644
index 000000000000..bb4aad50c7a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TVA_IN_PF (1 << 1)
+
+int pf_alloc, pf_disallow, khugepaged_alloc, khugepaged_disallow;
+int cgrp_id, target_pid;
+
+/* Detecting whether a task can successfully allocate THP is unreliable because
+ * it may be influenced by system memory pressure. Instead of making the result
+ * dependent on unpredictable factors, we should simply check
+ * get_suggested_order()'s return value, which is deterministic.
+ */
+SEC("fexit/get_suggested_order")
+int BPF_PROG(thp_run, struct mm_struct *mm, unsigned long tva_flags, int order, int retval)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+
+	if (current->pid != target_pid || order != 9)
+		return 0;
+
+	if (tva_flags & TVA_IN_PF) {
+		if (retval == 9)
+			pf_alloc++;
+		else if (!retval)
+			pf_disallow++;
+	} else {
+		if (retval == 9)
+			khugepaged_alloc++;
+		else if (!retval)
+			khugepaged_disallow++;
+	}
+	return 0;
+}
+
+SEC("struct_ops/get_suggested_order")
+int BPF_PROG(bpf_suggested_order, struct mm_struct *mm, unsigned long tva_flags, int order)
+{
+	struct mem_cgroup *memcg = bpf_mm_get_mem_cgroup(mm);
+	int suggested_order = order;
+
+	/* Only works when CONFIG_MEMCG is enabled. */
+	if (!memcg)
+		return suggested_order;
+
+	if (memcg->css.cgroup->kn->id == cgrp_id) {
+		/* BPF THP allocation policy:
+		 * - Disallow PMD allocation in page fault context
+		 */
+		if (tva_flags & TVA_IN_PF && order == 9) {
+			suggested_order = 0;
+			goto out;
+		}
+	}
+
+out:
+	bpf_put_mem_cgroup(memcg);
+	return suggested_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.get_suggested_order = (void *)bpf_suggested_order,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
new file mode 100644
index 000000000000..b080aead9b87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/get_suggested_order")
+__failure __msg("Unreleased reference")
+int BPF_PROG(unreleased_task, struct mm_struct *mm, bool vma_madvised)
+{
+	struct task_struct *p = bpf_mm_get_task(mm);
+
+	/* The task should be released with bpf_task_release() */
+	return p ? 9 : 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.get_suggested_order = (void *)unreleased_task,
+};
-- 
2.43.5


