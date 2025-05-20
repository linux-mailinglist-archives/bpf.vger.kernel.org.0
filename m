Return-Path: <bpf+bounces-58524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C918DABCEFB
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B311891F33
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5642550A6;
	Tue, 20 May 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKTb75rz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A22571B9
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721199; cv=none; b=fr4g1RhLreh47mmDODFqJUGZb0FIZ3aFYa/veZC5UNlGwQQE3k/T1ntpZnqiGvcwdbpAMQ05/Xca7Bjwpu74D20ku6WyHMqqeRFF5jz+AIUHr5aGb5iEVrJmNHdhGhOocBxRaWHm4Q9dZTs+d/ffIExnIsDhcsCUTq8Gmbd1tdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721199; c=relaxed/simple;
	bh=6AEau35TUhKfcCIyPUxsLWPSp8bK8h4v7pgJyT8qg4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7Sgs9WB7Et+mryqgYB8MOEHv2KUu3fHVQwTmT0QUJpAmeRfR2C1MfCW4BmYnTYyEvkR3DWcBPDygNSmIWo7qx0WGjUW8VkNugzlT84OyheCwnzmZY4bYsrW8UI1l5cQK130STB8uof/J6nJSkYgTIJluz67CvfzrNjw280FedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKTb75rz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74264d1832eso6815879b3a.0
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721196; x=1748325996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R/i6XORP4JHXXce5hw/20wRcCywtoWhALSIpSSgNY8=;
        b=DKTb75rzvKv4ILudS+0murD7kUW/ge1rEJGDe51pX86wkJiotliB5HkcvJIBfsyb1D
         uViD6q5SNgi0lvuSZNYugT3l2MtbNJHaIsCFTxnV2HxQgck2pYo3PMLZTlxRFFCSED2b
         eb2BNhhOPi8imWTK8OoDnZlHszRof/xmkaSZL8Ebx8PFM8xnVJ7LZVfS7ZIrlNYyP0t5
         VgvM8HyThRPa+6pxjqs5womjk+jjT0WSkrIrgt49MduxEiaZV+ByzLAPkrKTMZMXk3Cz
         1lQNwdosiO+eL1qNgN6GOfKoOq1108axWaZFBkFUEwfcdZHXLh1RoTkBjpLWwRygUQQq
         9qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721196; x=1748325996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R/i6XORP4JHXXce5hw/20wRcCywtoWhALSIpSSgNY8=;
        b=SWYt0XBwShLlTiXkAKLjNKStEzLPUHTEgavlcQr7jwomAq4xcRpwjQliN2F7I3AONR
         t3kzd6cadFMICjCGGEYDA3WIREyLvqjGC472aO7hffMprWzPb8vW4oGnLd/uaqxFUR2X
         9RCXjPAgl8fjCMjSsoob33eNhJ385a2JZwXsqx70KshFqN1IE5utETcSeKBtCYRle2N4
         uXFVhO8F3ToMwrPR7dCMDB+dv7I4y0EK7ReNt9dMOGIxFQQ1YvBDlA7nbANpm+ATA+Eq
         TeSEsbJikDVzVJtoGDkRQDufXVCczNCBWQ9R8HlsPfu6XmraFTNdvxFtF4QDbUr2bJsz
         tDAA==
X-Gm-Message-State: AOJu0Yxj0EiSWd9XGF3wgmiiiVvomkSXXQ1g9pDLSHpP6cmSbq5pmAbi
	eoz398rKMqO0MU7JlIfQfxukFuJV2lFqDpL6g5ljPEGuSSWCjhOqqHk5
X-Gm-Gg: ASbGncsssQQQE/M61JaBY4m2qGzILievJ0ZL4MRazLjddGJSHhZ5U+UXdW1Jvmmn2qh
	6aG37vDm9qgaXPBlf8sQKdOIh2bLbm3UQy3gmaNGU4Tm335OFt3AX4X5696RDAbhhakWbHh1suI
	5gydLONFj4KBUYWxxpKlRKFsO+mxrPQJ4ykJEbfUpDKlmDhuLhP3zpK4UNqu+ywsf/4BWtQvEXb
	Vh9NcU9EmouVTqwBnJ6NQXVYSyRutT+oqD3v2xS+1TXt2jvurCaXqSuwUpy+vFhBn+/ylNG6yST
	0FozgkI7VZqFjXBs/NXmetN7R+QSxAT1gLvbzDbOaN9MYNdsojtYdWc3cFVsB2c/WaaZSrLkWbk
	2TDOlYC0l3g==
X-Google-Smtp-Source: AGHT+IE2rBbZvH4irE/20NJlvaM3UDbLqDjYTZCkVzQCmBeAMxjUOuRhmrpPMwxQw/CjLKcvbCgkWw==
X-Received: by 2002:a05:6a20:7f8c:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-21621882888mr24979864637.6.1747721196460;
        Mon, 19 May 2025 23:06:36 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.06.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:06:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 5/5] selftests/bpf: Add selftest for THP adjustment
Date: Tue, 20 May 2025 14:05:03 +0800
Message-Id: <20250520060504.20251-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case uses a BPF program to enforce the following THP allocation
policy:
- Only the current task is permitted to allocate THP.
- All other tasks are denied.

The expected behavior:
- Before the BPF prog is attached
  No tasks can allocate THP.
- After the BPF prog is attached
  Only the current task can allocate THP.
- Switch to "never" mode after the BPF prog is attached
  THP allocation is not allowed even for the current task.

The result is as follows,
  $ ./test_progs --name="thp_adjust"
  #437     thp_adjust:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

CONFIG_TRANSPARENT_HUGEPAGE=y is required for this test.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 175 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
 3 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..bb8a8a9d77a2 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -113,3 +113,4 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..6accd110d8ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,175 @@
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
+void test_thp_adjust(void)
+{
+	struct bpf_link *fentry_link, *ops_link;
+	struct test_thp_adjust *skel;
+	int err, first_calls;
+
+	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
+		return;
+	if (!ASSERT_GE(thp_set("bpf"), 0, "THP mode set"))
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
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto destroy;
+
+	/* Before attaching struct_ops, THP won't be allocated. */
+	if (!ASSERT_EQ(skel->bss->thp_calls, 0, "THP calls"))
+		goto thp_free;
+
+	if (!ASSERT_EQ(skel->bss->thp_wrong_calls, 0, "THP calls"))
+		goto thp_free;
+
+	thp_free();
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		goto destroy;
+
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto destroy;
+
+	/* After attaching struct_ops, THP will be allocated. */
+	if (!ASSERT_GT(skel->bss->thp_calls, 0, "THP calls"))
+		goto thp_free;
+
+	first_calls = skel->bss->thp_calls;
+
+	if (!ASSERT_EQ(skel->bss->thp_wrong_calls, 0, "THP calls"))
+		goto thp_free;
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
+	if (!ASSERT_EQ(skel->bss->thp_calls, first_calls, "THP calls"))
+		goto thp_free;
+
+	ASSERT_EQ(skel->bss->thp_wrong_calls, 0, "THP calls");
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
index 000000000000..69135380853c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+int thp_calls;
+int thp_wrong_calls;
+
+SEC("fentry/do_huge_pmd_anonymous_page")
+int BPF_PROG(thp_run)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+
+	if (current->pid == target_pid)
+		thp_calls++;
+	else
+		thp_wrong_calls++;
+	return 0;
+}
+
+SEC("struct_ops/thp_bpf_allowable")
+bool BPF_PROG(thp_bpf_allowable)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+
+	/* Permit the current task to allocate memory using THP. */
+	if (current->pid == target_pid)
+		return true;
+	return false;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp = {
+	.thp_bpf_allowable = (void *)thp_bpf_allowable,
+};
-- 
2.43.5


