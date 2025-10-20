Return-Path: <bpf+bounces-71343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF94BEF2D6
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 05:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2AB4EBDC5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 03:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B2BE056;
	Mon, 20 Oct 2025 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhoAoSDi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDA2BDC03
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930260; cv=none; b=XvCkHGG3ELK2VLaiWzTdKWFGVNGBGj+Lu9u2K3foKLZKTXa1avlsYPtIOBQKBokKYI1ZZBmU/Y22W5zH++XRN4YQIUnLBVYrxy0R4zrMZs9npOeOve/Dihq+tBJ/UA+WVOpcM21Ooqyi8ry8v64v8NEnBtIkR3HOHbIqAyE0lJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930260; c=relaxed/simple;
	bh=qlrK8jqku2r/4LeLCOgSbuwg1RSfApkHeE6X+8By41U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoP8tAJArhOMvCbj1YSl7hWWMwya9ArnzTcJRpr9cvmTkqK/z7cyqncYF2rZpEjS3ioo7iKS8lJY3TrFVt/BQWpj49BxdZKsuroIdq0Ld6Fsc1hO7c9kHDdmnarzOgVfNQoz+/9UfNYWATUllL4UKZfF5gVMoQN1mhmvpK9sheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhoAoSDi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so2662145a12.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930257; x=1761535057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODPaRNudblRqFy9JUc368eS/DdFyEosuZnJ/nJRki7o=;
        b=QhoAoSDibAySfpJhQC2OBdouvgGdtfih7EtvFlR7nWIU3sSfku1DfpCMfwhAzDH09z
         Fqi1PaL0mjw3PgOT78EHSyYhMnW9Q32Usru3q+gjOdkg8mZkqywYWJR3Vy9Qb6awa5Ka
         R2Qo05QxXR0bYiVdf0yp/VdYqoeGZsFJhcuBTmEPBwSplSGdlDflIvxNMLPzmvShw2xW
         7Sqb9eWi+/dvlzmJ79K0m0fiehOxfEVB1AViQFW/RwpLOFCbIUHGw80xuNIKWvXnFzGd
         SFPMgfUG/f/1+7De3xPtQHbgGoNtREaBWsJ9hUBbMzNDoeuC8YoHhMGZSFszNtAb+3ad
         P8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930257; x=1761535057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODPaRNudblRqFy9JUc368eS/DdFyEosuZnJ/nJRki7o=;
        b=wi4bc9DnL3rE9mhbQMeaMBpu2gcKJIwI2WUKvXRxoU5Gs6QogVV0J9oWCGYiw7Skg8
         7e5svD812646M/ZRbZWr7+Hc/wnGlaeBF38nWkSCS0WfQC93qugAKjFGJ0UuxeYUi4nH
         rpgPIIAWYnS7vY0fAvKrmnEEg4y4RR7f8jJS/Z564gBevn5EBpJDET7qECjkWP1/n7gh
         E360P84GYRxWQcVEhGfqsBbfW+byyATRu7LoClXRuJX+eXTJYwbtC/2R4NLfLykqvCt8
         42FtEe8ip9O0zOaWmn3dqPpwqfRQZcez+Fu2z4+P83wgNtL39vxx6SjIhCsVH9jY7CP2
         4AHw==
X-Gm-Message-State: AOJu0Yxc/WCnuKJHmvnbSbFNwbGKrjasyRmOn5u2/wpVK8K3lxY79jFY
	oeV8yHjxuQM/acy6eOcHV7Gt8j126fHTDKGJMSSK3UdWJ0UcTJtUnKFX
X-Gm-Gg: ASbGncsEwv7NOLFISXL2/shVol+yhiE2/TYObhYw2quIqyGI77qasnRiDTvJhANz1yA
	ynYoeOv5Ph1Fu0wt6vtMpzBU0fXFLmcr9WdpxgBJsRf4A/kl2gpDf8lQAMX+3aDai3hH2DtTyQY
	Pr5BOvOGuM9OE+ItiGJvVcIVyT4+a0qBbudbImODx5mdUa4EkbM35ePFgHzljmgVrW1DfA9LAKD
	JsLDXnTiQAXA4z4tJMNvRgOYwevWkX8UhXVikBNp9zw4A7X6Gow+zvoXOzWrl8DN7Y6X7Q4/lbg
	VNHuZFuvr/6lAZgQozgms9/Qfj9MOaWsPohGa3LhnkNyN1Qxe6hJCI9b14NEyw1Bf5AQJScKJOs
	HRkSl9l8jA6JcprTqm0dQnnPFzGGzln38TL6eIumMNVftnR+05y7QQg5aPfVH0NtpjQ9m1CpgsY
	rVFvE+6+fM8w+x8U4TLrikGSC5//fvWeVaHJorc2YLX4dzVg==
X-Google-Smtp-Source: AGHT+IGOBjp3trHQon1RiKTkHvnyhNWFPxll3OTbBEoNjqhhZpOKT8ELp9LCl0TFv0EiwWwI1kAdeg==
X-Received: by 2002:a17:902:db09:b0:290:a3ba:1a8a with SMTP id d9443c01a7336-290ccac6d3cmr145711245ad.53.1760930256915;
        Sun, 19 Oct 2025 20:17:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
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
Subject: [PATCH v11 mm-new 08/10] selftests/bpf: add a simple BPF based THP policy
Date: Mon, 20 Oct 2025 11:16:53 +0800
Message-Id: <20251020031655.1093-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031655.1093-1-laoar.shao@gmail.com>
References: <20251020031655.1093-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case implements a basic THP policy that sets THPeligible to 0 for
a specific task. I selected THPeligible for verification because its
straightforward nature makes it ideal for validating the BPF THP policy
functionality.

Below configs must be enabled for this test:

  CONFIG_BPF_MM=y
  CONFIG_BPF_THP=y
  CONFIG_TRANSPARENT_HUGEPAGE=y

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 245 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  24 ++
 4 files changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50faf3860a13..7febdd8b17b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16523,6 +16523,8 @@ F:	mm/huge_memory.c
 F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
+F:	tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+F:	tools/testing/selftests/bpf/progs/test_thp_adjust*
 F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 70b28c1e653e..8e57c449173b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,8 +7,10 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
+CONFIG_BPF_MM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_THP=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
@@ -115,6 +117,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_UDMABUF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..2b23e2d08092
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,245 @@
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
+	char *ptr;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp_eligible_ops);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		return;
+
+	ptr = thp_alloc();
+	if (!ASSERT_OK_PTR(ptr, "THP alloc"))
+		goto detach;
+
+	elighble = get_thp_eligible(getpid(), (unsigned long)ptr);
+	ASSERT_EQ(elighble, 0, "THPeligible");
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
+	skel->struct_ops.thp_eligible_ops->pid = getpid();
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
index 000000000000..b180a7f9b923
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pmd_order;
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(thp_not_eligible, struct vm_area_struct *vma, enum tva_type type,
+	     unsigned long orders)
+{
+	/* THPeligible in /proc/pid/smaps is 0 */
+	if (type == TVA_SMAPS)
+		return 0;
+	return pmd_order;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_eligible_ops = {
+	.thp_get_order = (void *)thp_not_eligible,
+};
-- 
2.47.3


