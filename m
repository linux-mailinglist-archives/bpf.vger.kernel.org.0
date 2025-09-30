Return-Path: <bpf+bounces-70004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F336BAB9E8
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342E51883402
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6428726B;
	Tue, 30 Sep 2025 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTvvEGdx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80C285C9F
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212011; cv=none; b=knLig8gQNPRlb7RnC+AflN53oduvHZBoQso6qki6oKHiYUxo/prRg/uJaMDjUSvGMz52TE1OWs7uoBJGXv7teDk4ESoA/eZhaA3MknRiceetuzV35axJ0I0EGgWgq1fSnNLgXgugxZxtgjLI9BxWR151peoVvEV/Pwdc0qlFQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212011; c=relaxed/simple;
	bh=+qf9s7Xdxiy4sr7f2TT6UbIoM16KyqoO4xQCqkCt2gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESs63QwOeO6Y1qfP0VzuYLQD7FIT9AAxYOj4APp49rdDNBtNbEkt5TILPsGKIlZUlyjG0W9+C58mw0XyX73OHBEWT43ZVbrY/27IMirNMDuocGt7PnHG1IAlRTwFwEoYI3Y09fZv2by8xnsEvdFYNZLeLhzfwQrL0bfBHs6Hl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTvvEGdx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-269639879c3so53383335ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212009; x=1759816809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9AJux588gWgrV0mh0Bl4XWK/14sRfUKl951c+dMtJo=;
        b=mTvvEGdxC3uZf/9tPAufQYY0Zj7Jj2LEug/Q/dY32LzMHkW0A55Pzum+PnfoQ0wcHd
         iUXpmWKDgg/2LlYB0X2tet89vAHEBH2qDoA7F5PdHwnH6FHlQ4u3i9a9kndbutmfEhS9
         ekX22GQeH9TkVnsNH5TV4LiWDsdq1gEZ3t3oTlXNmYbQD8CyqgUd59GS486Pm1legy7h
         2/cm6xJEKS+NUXkXvRU+Rx7H9VhIpTc7/LmFDiKK5N7CAnO2shpYj2T/J6zcGjydj1/k
         9An0iGN84ggvusbYZgnxLcEYKvvHbpVQwOszASwPOTuLBQga8tiDleoSD9AssTCC3SVD
         /4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212009; x=1759816809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9AJux588gWgrV0mh0Bl4XWK/14sRfUKl951c+dMtJo=;
        b=tvuJ9u172YZ6ya8hrLj+PrTWVHBf2khdiTOiqD1etCLYljh8TIJ6vt52y9i9fq8DwK
         ppQd09vP6S+T6Be2st7dOarBVhP+/XDAolO9i0LnK7ZCCyA/wkFquHqkNPoudo+xX5sa
         WxfwhTNbxz74HV3CBHIqLSGcPnBH4t3OGqwN493p8OvFo0deJK2c9yKqXNHe1pPyi0ga
         jOu3GilMHPWfAHfZHJAlaiJ66MyZ6CnAWTiWW1T3fJsweXwPyhUXXJV2ZRkxsQOZ5dB9
         Hq0H9cTUv27DlkeOC0fwjt4cMyhGUHFMI0IkrOuA2nZCIYUbTBdCBdRKp92zqhDmuJbk
         IDDw==
X-Gm-Message-State: AOJu0Yz0CeMSzvA/UuviJWDdHxxL4kRtwx20/pkLHA/ICaDiv2F5nFhL
	8IkIY2vQN+TplKiBt68Jh4FYVdx+Kauc+wW0dT6cG1Medfg2Wn8S8ktz
X-Gm-Gg: ASbGncvJHu1AafHF/fpAO01zLJUv7L7gdN8IhdoJnaPVVVfE5qyZJht5QfkY0celxsI
	T5gdxahFhV62Y6QWxfihVelepfidu/5KGyBuq+7UKacQocSQs1u3gbjiVXrCeLzRf2AqbhG0iGa
	E3G9WkbvObQTju95GN8YBQCxgj3xGaoxCZtyCDPTp7VsrI85H9lzBzbyhLwrFlri9haqQVDMyZP
	6nXQU5p7xMH1T+hDK2jHv5XwqCJ8MqfkwQu82VXbu+aPmsHuWM3o3NnTBZ7yz/oolaQiy6mrG82
	xIWCwFoxTYCv06ZrNpbT0Jly8gmyWbfRkLQYY7XxoJO8d/zsITfq7XbjhzSPuJRShpqoI5tZd2e
	1fFdW+WFz8v/MWYpI9AxwGS7fKpW5m8CLd6uS2uoC/49WT6imZ03tK9lJ0MwCyG1Ur+1hnTNZd1
	WeSHzMCnvxsXqfuFBQDKNqPGXjOHVoC8ofhtcj/Q==
X-Google-Smtp-Source: AGHT+IFxOy+OVpj7YYQUa1xeFuFT66rHzPXVfIt7SgvZyLCGZHlY21OivixoSzSZemCeMeGafMhUvg==
X-Received: by 2002:a17:902:fc8d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-27ed4a6e9e4mr225370925ad.42.1759212008758;
        Mon, 29 Sep 2025 23:00:08 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:00:08 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 08/11] selftests/bpf: add a simple BPF based THP policy
Date: Tue, 30 Sep 2025 13:58:23 +0800
Message-Id: <20250930055826.9810-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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

Below configs must be enabled for this test:

  CONFIG_BPF_THP=y
  CONFIG_MEMCG=y
  CONFIG_TRANSPARENT_HUGEPAGE=y

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 257 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  41 +++
 4 files changed, 303 insertions(+)
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
index 8916ab814a3e..13711f773091 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -9,6 +9,7 @@ CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_THP=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
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
index 000000000000..0a5a43416f2f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..74ad70c837ba
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
+int BPF_PROG(thp_eligible, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int suggested_order = 0;
+	struct task_struct *p;
+
+	if (type != TVA_SMAPS)
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


