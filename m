Return-Path: <bpf+bounces-60006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81BAD1176
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EA7A4FD8
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C971FAC23;
	Sun,  8 Jun 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGV8eASj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBB1632C8
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368195; cv=none; b=AmYhKuYN2Om5T4T3g5X0j+uWp7zAhSz+8KaYRqOC6eT7snO4lbHUIOp/j3axwsC1bNVph9mbA6xTMOw0A4J5QBiMAtqPP03DFnd5C2RLFG8ieC/wdMywpZuiaMbtgnXWhIlfRzlcaF5nRLmtKqwhltnKpTjGz7XBFhkJjCAn6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368195; c=relaxed/simple;
	bh=QpcZpybBVcgxni5MbzhH2ZuHK8J6dsPvzct7OeWjlmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWd9LoEscfylh/h4fvNnFSenOTxN3fsSxes1LxyFoeGAB3v4S+BYQqguOzlnk/G1USDNyg8F3m+hbptFt7bGBcZ5IxRJIn0UwTLEwG3RewC6v/A7kt67kqIXixpqkiYMz89nHTZ1IIkcvuNPHmN5maKrZE1wl2lXfYb9A40JrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGV8eASj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2555452a12.3
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368193; x=1749972993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9lEJCOWjCrNLanGPK9i8bcj5uBRqN1K5GYShhRAjFY=;
        b=NGV8eASjEjohYwdoJom4+ME+XmiAch4Dt/112gdCrJvrCo5IkGvFHG/T9IDlDECS+6
         x03Bemvo0kQAgSjHyo5fF1gV1BA7wIkDswe1QLXtiCpysyFem/t+WfuXkSLCGoi5o/zj
         XlZnCWdZug0P/eDxSf66W48ckbo9W9ZAy3GZQhcpCF02qQg/HVgLAMkyLZgxP/oJTwjT
         ZT/yKBQgfd/fZ29neV93jWS2lPUNcrK/bT3nPQzuxNXb52ArAWOddIT0mxIs0Lj1V1cM
         hdA9Z/BunwtcTR8pEiCipEoUfAxyjU/LET/GCGIPiLPlxvcjq2UxWJCzol6ZfvSBDL4L
         HhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368193; x=1749972993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9lEJCOWjCrNLanGPK9i8bcj5uBRqN1K5GYShhRAjFY=;
        b=XskHbjRlXxABbPHYQ//wVuK1vWpLuOv4UxIV07BzGJMXBSm/eyC2G3bZVM6Les+Yu3
         6OyTSaPLYFAbMukSU9nJbh5L4oit1khxhk+bH6Q+o6m9YEV0kQqMez0Nehh2HpbXp+2m
         9UuL4olUXwjAlPKTP3Zmaqln1pV0WwT+IJWentYZlRNuXwKkUeForU27hbv6CAV6Oy02
         pqncSLy+YCdn5gnNwj/0uO+w7KhLQW2m6M0zgoxuTrDnwTEtaR5pZVWM434ikVrjrwy3
         h6PuxAElW+fMm+Fb6pgPVgmGbr0siplNSoBFCVRZTLSiZNYrXpmETo4XMZQPiFKeEorH
         KZ4Q==
X-Gm-Message-State: AOJu0YyFm4Jg8oJnUgnKwNGA6YHKR7J3toITzZgrmJ4kAv4Hxgnrg800
	0uqCTomR9wfEIVeILS7zThmW9yLwpjWDksGsbPEYyyrFdOjazR2EoAN3
X-Gm-Gg: ASbGnctPw/3p4auHh5G9sq1Tns96XeSSpjOlNSaQJEvO6fs1SX8qfVzShq+QB6NXmqP
	qroKTLt3FmZOo1fw9xvqXFjOVCM1VquG0arxPZ6t+s6q7GrSKnuuZ1mfsDCQZYUcUFNhGZJ5lIq
	Jwtw0nntndsvwBZQdD/ol6vwjauiXxs80PYgmd54jnoV3uSGg+ilxXHOgUTc/CtaCo16Pbauj+D
	gvabplU+lXz6bAM/QLWEX5kXDbUQZ5/4f+iMeDLNut3P+QYeVpfCtzLlIfDTE13+wa7xbZiOwy0
	RwOX/heLKeRrcrZx2awz9uKRr0enbV0U/7THjp1agVvzWFZ4+eeXUhIChkdZlBohHpZ+7llAcBA
	=
X-Google-Smtp-Source: AGHT+IH+roLvCwL0RLEOwGDdimU3DFVb+abEuCH4pjflLQlZie2hiEZ/+bR/mB7zOMXl8Ear6n6mFA==
X-Received: by 2002:a17:90b:3503:b0:312:639:a06a with SMTP id 98e67ed59e1d1-313470738f1mr11748734a91.31.1749368193162;
        Sun, 08 Jun 2025 00:36:33 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.36.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:36:32 -0700 (PDT)
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
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 5/5] selftests/bpf: Add selftest for THP adjustment
Date: Sun,  8 Jun 2025 15:35:16 +0800
Message-Id: <20250608073516.22415-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250608073516.22415-1-laoar.shao@gmail.com>
References: <20250608073516.22415-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case uses a BPF program to enforce the following THP allocation
policy:
- Current task will wakeup khugepaged to allocate THP

The result is as follows,
  $ ./test_progs --name="thp_adjust"
  #437     thp_adjust:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

CONFIG_TRANSPARENT_HUGEPAGE=y is required for this test.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 158 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  38 +++++
 3 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f74e1ea0ad3b..1c3c44fd536d 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -118,3 +118,4 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..ee8a731f53d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "test_thp_adjust.skel.h"
+
+#define LEN (4 * 1024 * 1024) /* 4MB */
+#define THP_ENABLED_PATH "/sys/kernel/mm/transparent_hugepage/enabled"
+#define SMAPS_PATH "/proc/self/smaps"
+#define ANON_HUGE_PAGES "AnonHugePages:"
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
+	for (i = 0; i < LEN; i += 4096)
+		thp_addr[i] = 1;
+
+	err = madvise(thp_addr, LEN, MADV_HUGEPAGE);
+	if (err == -1)
+		goto unmap;
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
+void test_thp_adjust(void)
+{
+	struct bpf_link *fentry_link, *ops_link;
+	struct test_thp_adjust *skel;
+	int err, first_calls;
+
+	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
+		return;
+	if (!ASSERT_GE(thp_set("madvise"), 0, "THP mode set"))
+		return;
+
+	skel = test_thp_adjust__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto thp_reset;
+
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
+	/* After attaching struct_ops, THP will be allocated. */
+	if (!ASSERT_GT(skel->bss->khugepaged_enter, 0, "khugepaged enter"))
+		goto thp_free;
+
+	first_calls = skel->bss->khugepaged_enter;
+
+	thp_free();
+
+	if (!ASSERT_GE(thp_set("never"), 0, "THP set"))
+		goto destroy;
+
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto destroy;
+
+	/* In "never" mode, THP won't be allocated even if the prog is attached. */
+	if (!ASSERT_EQ(skel->bss->khugepaged_enter, first_calls, "khugepaged enter"))
+		goto thp_free;
+
+thp_free:
+	thp_free();
+destroy:
+	test_thp_adjust__destroy(skel);
+thp_reset:
+	ASSERT_GE(thp_reset(), 0, "THP mode reset");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
new file mode 100644
index 000000000000..9a3d8bfcd124
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define THP_ALLOC_KHUGEPAGED (1<<1)
+
+int target_pid;
+int khugepaged_enter;
+
+SEC("fentry/__khugepaged_enter")
+int BPF_PROG(thp_run, struct mm_struct *mm)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+
+	if (current->mm == mm && current->pid == target_pid)
+		khugepaged_enter++;
+	return 0;
+}
+
+SEC("struct_ops/allocator")
+int BPF_PROG(bpf_thp_allocator)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+
+	/* Allocate THP for this task in khugepaged. */
+	if (current->pid == target_pid)
+		return THP_ALLOC_KHUGEPAGED;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.allocator = (void *)bpf_thp_allocator,
+};
-- 
2.43.5


