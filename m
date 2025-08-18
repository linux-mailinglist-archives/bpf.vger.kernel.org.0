Return-Path: <bpf+bounces-65852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B245B29933
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F8A3B5A5A
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA7270576;
	Mon, 18 Aug 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrRY3T6d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519A2701BB
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496560; cv=none; b=SfhBRoKzb8sq0TVd/lmTw0Y3e03YsdV3RKJh3KIaos5dOdG9Av4+J1kfwfBlgAsDAoBeS4tRg2kFQXMFf+oOzTQp41AGc4zLDTNOib076IbrsFpUKMa/4TxHZ+0WX7uo4eg0trRhjeE7KeVnTtzj1AS4zcHtoDy7fIrt6MN2c5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496560; c=relaxed/simple;
	bh=YkmpHrx0MefYdSFfr3swtAlAE8U493pWioo5lKDmdcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR8jQ0sAyTbPpvA4MQxYe2krwP8DcrSiokmeRcKdZwEY1/GYGVCOZfNl9PmnyZbuEOC3yjjRqvwFlRUFKikVqY3jca2uTw039XmQRHDvQwBdmrf0f3i0RMVWTulCbgxH0ej/X2SRe4kZBYv/nUxSIgeIv2kV8bKnWvvHX31MgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrRY3T6d; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266d6f57so3724312a91.0
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496558; x=1756101358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1cSg2mylJT2HXAXhehOfDxoS7DeUn7ungYUUcoWyfY=;
        b=RrRY3T6dYYByhyWwDgB2WpOb+sOLI38ttnFvx7Dg0hHgManqWVYJ0amLpFFfSANrkL
         VG+W5e3LHzHeY3s1XjZ5HvC/ILjjuw4Nnx4sWxjbYRM8kd+jxMOBMuJCrCZ6rJN3q0Fs
         jogBQPl0DHHWIUY3rnPjgeWMW/D8fcFNFRa3mDOj9XBJphEGVRPIFFHjMrXnSa0Pv++O
         3Hmw6T57POIydAVFKSrPwB68vVTaX/35nqrg1qEC4F0KQwqSBa9pC1fYfC6r+J+reT5P
         kygISzUbiivfWM4egXsmM0qRejrZSVQnJxz6O/wCFE43dCZBgVoMFFwG+OFH+3WcwoV2
         rdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496558; x=1756101358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1cSg2mylJT2HXAXhehOfDxoS7DeUn7ungYUUcoWyfY=;
        b=NaIMES3fwb/1UMZph+rZPU9IP8dJFXIk2rrT1zrrZNiE48oz5GrJF6io00i3O8dACn
         5ChG8bUjbTIzwg2JgAqtE74qUDIbbXSzz+qJyXN/Y0cUXa3Umj80ezxohcFoTRr6XEHu
         k/4O364dJdRJOasxtbLPQEIKYOyFv5lwBCgzizHjC2HT/g2d1bYYT4li+okI78Arm+D5
         B9zLekP1HzOaOLYAvvW+vw0RiF1JjFex8m8T53N9qT/+Y5Zr/M1TM03OGoqpz0bo45JD
         3wasdtPhh3+mO/Bry927EQ8k9v0pSUK0QFvw1qOnyENimfnn/Q1+ZRYO8B2gzeiV9xow
         vW/A==
X-Gm-Message-State: AOJu0YwhFksDNr1Xc4gMeRhEhgyvNR+SNvyEu9a+EUst90jWI0TunD9q
	OcPXmTr5U1pPQPetLzmfSNAasZLAvy8Xxje5QdSvNEvyZcfs1Ab6Q///Q3Bb3+b8JWc=
X-Gm-Gg: ASbGncsalflgIFhPJr9BmYFVWF5dGxwlwSC8tADTtYt/58iMrztqks9KyJCWgqweCBR
	74jJf+Gxq0+Dxyy2ry5lIfbgD0IF2ICLCH16ezhIasVB29axiLIlh/Z7nLrpFgm9FkzNcx+fQq5
	5tNPVk6z1j4MQ2nvqi6CvQKHqhBWFMeVfPr85gn6CX9k5ignDOc0tUI4L65RGfIWL27Z5BgFQUg
	MAUELmzMzJ03HNdlu+fTa883YINkBEx2EuSBcXZ3aiWahTjNb/v8Z0atrR8m1VHw4RCWy0SAY4q
	XFZEFb7peXCVgT+i0V1XMyYFlsQlJr0X6JUxewjff1aLpOVNG/yKwfh7XR5MVgum0SEqCpgAmio
	zzzZ0Zcmv/kVNafL7cYVRNb2mOK8NrGmDI9S5aOcpsnGRi9Loq7av5ydn
X-Google-Smtp-Source: AGHT+IEDC63+iCxdsyaHczK9wCWNBIQSkfb3jqk8zUO9TF6ANYvT7bVEP3aziVfKZoseR9I+x/cVBQ==
X-Received: by 2002:a17:90b:53c5:b0:31e:b77c:1f09 with SMTP id 98e67ed59e1d1-3234213e452mr14701838a91.19.1755496558249;
        Sun, 17 Aug 2025 22:55:58 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439961c9sm7003413a91.13.2025.08.17.22.55.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 22:55:57 -0700 (PDT)
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
	rientjes@google.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v5 mm-new 5/5] selftest/bpf: add selftest for BPF based THP order seletection
Date: Mon, 18 Aug 2025 13:55:10 +0800
Message-Id: <20250818055510.968-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250818055510.968-1-laoar.shao@gmail.com>
References: <20250818055510.968-1-laoar.shao@gmail.com>
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
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 224 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  76 ++++++
 .../bpf/progs/test_thp_adjust_failure.c       |  25 ++
 4 files changed, 328 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c

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
index 000000000000..959ea920b0ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <math.h>
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_failure.skel.h"
+
+#define LEN (16 * 1024 * 1024) /* 16MB */
+#define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
+#define PMD_SIZE_FILE "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+
+static char *thp_addr;
+static char old_mode[32];
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
+int thp_alloc(long pagesize)
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
+static int get_pmd_order(long pagesize)
+{
+	ssize_t bytes_read, size;
+	char buf[64], *endptr;
+	int fd, ret = -1;
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
+	if ((ret & (ret - 1)) == 0)
+		ret = log2(ret);
+
+close_fd:
+	close(fd);
+	return ret;
+}
+
+static void subtest_thp_adjust(void)
+{
+	struct bpf_link *fentry_link, *ops_link;
+	int err, cgrp_fd, cgrp_id, pmd_order;
+	struct test_thp_adjust *skel;
+	long pagesize;
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	pmd_order = get_pmd_order(pagesize);
+	if (!ASSERT_NEQ(pmd_order, -1, "get_pmd_order"))
+		return;
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
+
+	fentry_link = bpf_program__attach_trace(skel->progs.thp_run);
+	if (!ASSERT_OK_PTR(fentry_link, "attach fentry"))
+		goto destroy;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		goto destroy;
+
+	if (!ASSERT_NEQ(thp_alloc(pagesize), -1, "THP alloc"))
+		goto destroy;
+
+	/* After attaching struct_ops, THP will be allocated only in khugepaged . */
+	if (!ASSERT_EQ(skel->bss->pf_alloc, 0, "alloc_in_pf"))
+		goto thp_free;
+	if (!ASSERT_GT(skel->bss->pf_disallow, 0, "disallow_in_pf"))
+		goto thp_free;
+
+	if (!ASSERT_GT(skel->bss->khugepaged_alloc, 0, "alloc_in_khugepaged"))
+		goto thp_free;
+	ASSERT_EQ(skel->bss->khugepaged_disallow, 0, "disallow_in_khugepaged");
+
+thp_free:
+	thp_free();
+destroy:
+	test_thp_adjust__destroy(skel);
+thp_reset:
+	ASSERT_GE(thp_mode_reset(), 0, "THP mode reset");
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
index 000000000000..97908ef29852
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
+#define TVA_IN_PF (1 << 1)
+
+int pf_alloc, pf_disallow, khugepaged_alloc, khugepaged_disallow;
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
+		if (retval == (1 << pmd_order))
+			khugepaged_alloc++;
+		else if (!retval)
+			khugepaged_disallow++;
+	}
+	return 0;
+}
+
+SEC("struct_ops/get_suggested_order")
+int BPF_PROG(bpf_suggested_order, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, enum tva_type tva_flags, int orders)
+{
+	struct mem_cgroup *memcg = bpf_mm_get_mem_cgroup(mm);
+	int suggested_orders = 0;
+
+	/* Only works when CONFIG_MEMCG is enabled. */
+	if (!memcg)
+		return suggested_orders;
+
+	if (memcg->css.cgroup->kn->id == cgrp_id) {
+		if (!target_mm)
+			target_mm = mm;
+		/* BPF THP allocation policy:
+		 * - Allow PMD allocation in khugepagd only
+		 */
+		if ((tva_flags == TVA_KHUGEPAGED || tva_flags == -1) &&
+		    orders == (1 << pmd_order)) {
+			suggested_orders = orders;
+			goto out;
+		}
+	}
+
+out:
+	bpf_put_mem_cgroup(memcg);
+	return suggested_orders;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.get_suggested_order = (void *)bpf_suggested_order,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
new file mode 100644
index 000000000000..0742886eeddd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
@@ -0,0 +1,25 @@
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
+int BPF_PROG(unreleased_task, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, u64 tva_flags, int orders, int retval)
+{
+	struct task_struct *p = bpf_mm_get_task(mm);
+
+	/* The task should be released with bpf_task_release() */
+	return p ? 0 : 1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.get_suggested_order = (void *)unreleased_task,
+};
-- 
2.47.3


