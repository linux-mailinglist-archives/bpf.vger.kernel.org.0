Return-Path: <bpf+bounces-69820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE9BA32DE
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0865117B17B
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9512C11C5;
	Fri, 26 Sep 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuj7WRGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E82C0F96
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879305; cv=none; b=XahrplLZkevdc+oj1ChBxXaOhsdJOHkG05ghnddDM9cGOopmqE1XYA1nT/VmIM3K5ZjIfXkGp1N4/7eVQLuY9PjYL+PjXZS7vVZKsnZAb8i/rJOUwARExTsEmSuHshOg5jWTGDYzjbzKQc9w+3KU7EmG5fDr5+aHz9LjFaN/HLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879305; c=relaxed/simple;
	bh=HBmJaZcDUZzcrC81eiCJDGIY48KrzLAuQ2+UCr8xkqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4VZ/zPXkYgIPXL2uJuK6S76x/XI0U/lLWttyi0xofb9qzt8f4ZVdWSALEfIbHsjUUllCeT4VUY+b3q94YeRQM7s57PzNhqPJWm7Dnhj2K71edBLLIQ/olYiIrOankF/litHOHDx9KMBFI8nFeH4JTVeO8nBxISibln10Ppq1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuj7WRGm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b586551e3cdso216571a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879303; x=1759484103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KejkPMgGRvReGxuBAv36+hrv4MPOBVSti8PCSW2auKE=;
        b=Tuj7WRGmflzMYd55lgdtWQ6wdMvkJpx++Rra89hqoM8ukhf9f0/t4A01+2JuRlHwWA
         UAgsA5cAo8SdBBVVOj6UIRZxXDq109d4lJEJn2S+nMyj3EOVi+sKvmJ3OuR9n+WmdJNZ
         GWFhNbCgCOdOTesC2WjK127YhRwTUCpPh+lFLK4uxcV3MZmifbnOR2sWvRXJY0IoSHDA
         WX/eY1SFqZkxvbilusCNnlIZcJBEpOWu6lYdhd+2ii6EVWMCqzMBvK+bBS+Czs3bIB88
         tbfspq7iEE9h9QT0dVn3H26PORBtIHURc5Ftudb314SctaqUQI7Ed2Db1aOZ/M60/d7G
         OmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879303; x=1759484103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KejkPMgGRvReGxuBAv36+hrv4MPOBVSti8PCSW2auKE=;
        b=PNSmyRhfMZl5PW0o+LHyRfMMEWOaN+yvZFrfLoLekY6rtLBDt7sPj8aIiDkbLJarGg
         8tOavXUsXgLa63yGRqb4Bt7CgDb7Fw6z/bgvkwvzOPVXPIR9XhbYaN1wKanJTXDmIC7B
         LZSIEpBTOS6sD8MQhf1jC3PWbtlvIwH1FLKx+wgbAoft07y9+ddEFTiF/9IrsF1TPZM0
         Kv+bAdVhtaTmjmaV0Sd/54ME1dxepXrqiVcaSXlvRS6Ay098U+Q1dlHcUVg3EwZ0wDsN
         KLrCpWc6WGGA4rvRa/OSHSDEQPMRr8HWOVA92sJ5GnRdSWUmNXGpPLYxlQKCxYjvAGnh
         /4Uw==
X-Gm-Message-State: AOJu0YzB2llUG9QW9LE6cOqNjBziA1Tqo/AY3BYACbhfShZ3fwbY/Aak
	9alu7niWJSfbJsfVo9jCf98CUVKP0bZrkycg+ClxQitx742voZGC0TFr
X-Gm-Gg: ASbGncu8qzF1WlzxtuRv3O0PrKYk8c12S7ztV9ytTOX4EyK+t3yMY3cesMeUlal486V
	7PGQ25HzmLG+VerjKt41epeTGhGS09dXIRuYwzACZ6mr66RuUvdTM/iWPYm/RKKs/r2K4GDhdDi
	0qQKUQeIJUPv4fxppPuguM8HtbaB4987EeM33y8saWjMg/Ghwq0GiIVmeCJlbuGuDlHRCqhqpb7
	9yC6ym7yetzHDbfVli2Bfp54n9dbPP7oJFVsfu/qZ44a9MtTHOD5R9/C6dfEZOw6FrkuLSWDLF5
	Xn8dJH3gA293I/C1xc+RxDpyqBlxPEX7jpAskHsSMOxQ99Zhsm3umnAWAiAy75KwU816VN+aAdQ
	E/qM9xdwcapNNiTt/xTgMkuTQIoxlZ+iKq0OTenkih1qdQn371NKn8fY/abraa6pvdocceEWUoD
	zMy5LYKcrw7W30
X-Google-Smtp-Source: AGHT+IHJMvMRnfOqzEak3qmEUf11dLxaZn5jFt91kzwtU8AVAcW525LzqoVivLg7u9BwGX2hLSfT8w==
X-Received: by 2002:a17:902:e749:b0:27d:6cdc:99e4 with SMTP id d9443c01a7336-27ed49e6cacmr73186945ad.21.1758879303020;
        Fri, 26 Sep 2025 02:35:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:35:02 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 09/12] selftests/bpf: add a simple BPF based THP policy
Date: Fri, 26 Sep 2025 17:33:40 +0800
Message-Id: <20250926093343.1000-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case implements a basic THP policy that sets THPeligible to 1 for
a specific task and to 0 for all others. I selected THPeligible for
verification because its straightforward nature makes it ideal for
validating the BPF THP policy functionality.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 258 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  41 +++
 4 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be34b2a64fd..c1219bcd27c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16260,6 +16260,8 @@ F:	mm/huge_memory.c
 F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
+F:	tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+F:	tools/testing/selftests/bpf/progs/test_thp_adjust*
 F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8916ab814a3e..7ccb9809e276 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -26,6 +26,7 @@ CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL=y
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
index 000000000000..b14f57040654
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <math.h>
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "test_thp_adjust.skel.h"
+
+#define LEN (16 * 1024 * 1024) /* 16MB */
+#define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
+#define PMD_SIZE_FILE "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+
+static struct test_thp_adjust *skel;
+static char old_mode[32];
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
+static char *thp_alloc(void)
+{
+	char *addr;
+	int err, i;
+
+	addr = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (addr == MAP_FAILED)
+		return NULL;
+
+	err = madvise(addr, LEN, MADV_HUGEPAGE);
+	if (err == -1)
+		goto unmap;
+
+	/* Accessing a single byte within a page is sufficient to trigger a page fault. */
+	for (i = 0; i < LEN; i += pagesize)
+		addr[i] = 1;
+	return addr;
+
+unmap:
+	munmap(addr, LEN);
+	return NULL;
+}
+
+static void thp_free(char *ptr)
+{
+	munmap(ptr, LEN);
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
+static int get_thp_eligible(pid_t pid, unsigned long addr)
+{
+	int this_vma = 0, eligible = -1;
+	unsigned long start, end;
+	char smaps_path[64];
+	FILE *smaps_file;
+	char line[4096];
+
+	snprintf(smaps_path, sizeof(smaps_path), "/proc/%d/smaps", pid);
+	smaps_file = fopen(smaps_path, "r");
+	if (!smaps_file)
+		return -1;
+
+	while (fgets(line, sizeof(line), smaps_file)) {
+		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
+			/* addr is monotonic */
+			if (addr < start)
+				break;
+			this_vma = (addr >= start && addr < end) ? 1 : 0;
+			continue;
+		}
+
+		if (!this_vma)
+			continue;
+
+		if (strstr(line, "THPeligible:")) {
+			sscanf(line, "THPeligible: %d", &eligible);
+			break;
+		}
+	}
+
+	fclose(smaps_file);
+	return eligible;
+}
+
+static void subtest_thp_eligible(void)
+{
+	struct bpf_link *ops_link;
+	int elighble;
+	pid_t pid;
+	char *ptr;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		return;
+
+	pid = getpid();
+	ptr = thp_alloc();
+	if (!ASSERT_OK_PTR(ptr, "THP alloc"))
+		goto detach;
+
+	skel->bss->pid_eligible = pid;
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 1, "THPeligible");
+
+	skel->bss->pid_eligible = 0;
+	skel->bss->pid_not_eligible = pid;
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THP not eligible");
+
+	skel->bss->pid_eligible = 0;
+	skel->bss->pid_not_eligible = 0;
+	elighble = get_thp_eligible(pid, (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THP not eligible");
+
+	thp_free(ptr);
+detach:
+	bpf_link__destroy(ops_link);
+}
+
+static int thp_adjust_setup(void)
+{
+	int err = -1, pmd_order;
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	pmd_order = get_pmd_order();
+	if (!ASSERT_NEQ(pmd_order, -1, "get_pmd_order"))
+		return -1;
+
+	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
+		return -1;
+	if (!ASSERT_GE(thp_mode_set("madvise"), 0, "THP mode set"))
+		return -1;
+
+	skel = test_thp_adjust__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto thp_reset;
+
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
+	return err;
+}
+
+static void thp_adjust_destroy(void)
+{
+	test_thp_adjust__destroy(skel);
+	ASSERT_GE(thp_mode_reset(), 0, "THP mode reset");
+}
+
+void test_thp_adjust(void)
+{
+	if (thp_adjust_setup() == -1)
+		return;
+
+	if (test__start_subtest("thp_eligible"))
+		subtest_thp_eligible();
+
+	thp_adjust_destroy();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
new file mode 100644
index 000000000000..ed8c510693a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid_not_eligible, pid_eligible;
+int pmd_order;
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(thp_eligible, struct vm_area_struct *vma, enum tva_type tva_type,
+	     unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int suggested_order = 0;
+	struct task_struct *p;
+
+	if (tva_type != TVA_SMAPS)
+		return 0;
+
+	if (!mm)
+		return 0;
+
+	/* This BPF hook is already under RCU */
+	p = mm->owner;
+	if (!p || (p->pid != pid_eligible && p->pid != pid_not_eligible))
+		return 0;
+
+	if (p->pid == pid_eligible)
+		suggested_order = pmd_order;
+	else
+		suggested_order = 30;	/* invalid order */
+	return suggested_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_eligible_ops = {
+	.thp_get_order = (void *)thp_eligible,
+};
-- 
2.47.3


