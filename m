Return-Path: <bpf+bounces-14918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E063F7E8EF5
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515611F20F9D
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E16FC4;
	Sun, 12 Nov 2023 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBXXigIE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381D6FA4
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:35:10 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09530C2;
	Sat, 11 Nov 2023 23:35:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2898931b3a.3;
        Sat, 11 Nov 2023 23:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774509; x=1700379309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50vht9sq3pC6AQ0DqKDnr2Ivz9GlP8f6LKYeDBUf3lU=;
        b=HBXXigIErt/LXDvGHvWXujgiBgFiWHIJs9mZOJ4W4ZNHD8xLa9HEkH3oVhBD+XN+24
         7p/W3GMYv+lZcEuQzxHvhBOvbxCrKsgyJiV9dGpKp448VmGx6rudS2a86SBm/m8lviAz
         DkpT5zPXVg3ULy6pAbwa4vHdLilQU/kKpSiH6f4gOmOUWsBEFOYJtpAuXkDlSQyo5E8I
         4vM7y1MiYSfut/jzBwdyQ5jLojgwEU3swMsLE26thaAUshQK3bpmkawJQSp+6gDTp3KW
         r8KzWtJ0AHUrQ1rYLj3GDgkgJP/+Gt9Hwk/r2jHCihwPhQHAY2bbEkvDAxXtOWUavqvO
         Gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774509; x=1700379309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50vht9sq3pC6AQ0DqKDnr2Ivz9GlP8f6LKYeDBUf3lU=;
        b=vEu6Oj3Hoh3YcHjray3/PZXLU7uGK9u6godqJY8ZBHvs+ZgfpqlOExEtLTVjp+7nhu
         atREzt3g8fkIoS0DaDHoT9V7TI/RZJWKOQdC7Onn7a7hFoJ04WTUxn3nGyBJveFgvZQZ
         /ONLqrWQdmoD/LKfgBrwEhGV13NfXXI7JeEH9WV6yyfuvGCwgo9z3TDAFn6XWwO/ELWL
         Zzq5K819bUj7SVpdl5gteBjxlm+vNbz+qCplocPkwbPtkojnFZtllrc2FQX1p9+dsKYz
         ByLB82DN6cH1KTEVWJegVQaj1V+Pf6PrG/0b3rAgq3CXojWbfgudH1DzZz72BbzxfPls
         JE0Q==
X-Gm-Message-State: AOJu0YzO+3whrRkwFR5Kc3+XFfpVeYKesnzWqr6oHu2ZTi5ORn0zPNzv
	UArEeQpaj5XhwXfi9wcJ1uk=
X-Google-Smtp-Source: AGHT+IGH2gtxhjldYT1quj3TLtuuVLLB6B2UrqBde4ZiVUZJi/ui1uancDFmFfDtAVJ0Dgb6cAfDkQ==
X-Received: by 2002:a17:902:a985:b0:1cc:5549:aabd with SMTP id bh5-20020a170902a98500b001cc5549aabdmr2353792plb.8.1699774508821;
        Sat, 11 Nov 2023 23:35:08 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:49b3:5400:4ff:fea5:2304])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001ca4c20003dsm2217394pli.69.2023.11.11.23.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:35:08 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	mhocko@suse.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH -mm 4/4] selftests/bpf: Add selftests for mbind(2) with lsm prog
Date: Sun, 12 Nov 2023 07:34:24 +0000
Message-Id: <20231112073424.4216-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112073424.4216-1-laoar.shao@gmail.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result as follows,
  #142/1   mempolicy/MPOL_BIND_with_lsm:OK
  #142/2   mempolicy/MPOL_DEFAULT_with_lsm:OK
  #142/3   mempolicy/MPOL_BIND_without_lsm:OK
  #142/4   mempolicy/MPOL_DEFAULT_without_lsm:OK
  #142     mempolicy:OK

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mempolicy.c | 79 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_mempolicy.c | 29 ++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_mempolicy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mempolicy.c b/tools/testing/selftests/bpf/prog_tests/mempolicy.c
new file mode 100644
index 0000000..e0dfb18
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mempolicy.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <numaif.h>
+#include <test_progs.h>
+#include "test_mempolicy.skel.h"
+
+#define SIZE 4096
+
+static void mempolicy_bind(bool success)
+{
+	unsigned long mask = 1;
+	char *addr;
+	int err;
+
+	addr = mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_OK_PTR(addr, "mmap"))
+		return;
+
+	err = mbind(addr, SIZE, MPOL_BIND, &mask, sizeof(mask), 0);
+	if (success)
+		ASSERT_OK(err, "mbind_success");
+	else
+		ASSERT_ERR(err, "mbind_fail");
+
+	munmap(addr, SIZE);
+}
+
+static void mempolicy_default(void)
+{
+	char *addr;
+	int err;
+
+	addr = mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_OK_PTR(addr, "mmap"))
+		return;
+
+	err = mbind(addr, SIZE, MPOL_DEFAULT, NULL, 0, 0);
+	ASSERT_OK(err, "mbind_success");
+
+	munmap(addr, SIZE);
+}
+void test_mempolicy(void)
+{
+	struct test_mempolicy *skel;
+	int err;
+
+	skel = test_mempolicy__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = test_mempolicy__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	/* Attach LSM prog first */
+	err = test_mempolicy__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto destroy;
+
+	/* syscall to adjust memory policy */
+	if (test__start_subtest("MPOL_BIND_with_lsm"))
+		mempolicy_bind(false);
+	if (test__start_subtest("MPOL_DEFAULT_with_lsm"))
+		mempolicy_default();
+
+destroy:
+	test_mempolicy__destroy(skel);
+
+	if (test__start_subtest("MPOL_BIND_without_lsm"))
+		mempolicy_bind(true);
+	if (test__start_subtest("MPOL_DEFAULT_without_lsm"))
+		mempolicy_default();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_mempolicy.c b/tools/testing/selftests/bpf/progs/test_mempolicy.c
new file mode 100644
index 0000000..2fe8c99
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_mempolicy.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+int target_pid;
+
+static int mem_policy_adjustment(u64 mode)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (mode != MPOL_BIND)
+		return 0;
+	return -1;
+}
+
+SEC("lsm/mbind")
+int BPF_PROG(mbind_run, u64 start, u64 len, u64 mode, const u64 *nmask, u64 maxnode, u32 flags)
+{
+	return mem_policy_adjustment(mode);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


