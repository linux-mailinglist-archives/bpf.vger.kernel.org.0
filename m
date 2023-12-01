Return-Path: <bpf+bounces-16368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4380076A
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2BC1C20D1C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88F200BD;
	Fri,  1 Dec 2023 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foRr5VBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDC13E;
	Fri,  1 Dec 2023 01:47:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso2866525ad.1;
        Fri, 01 Dec 2023 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424033; x=1702028833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc/JnQzKFnW7sQYk0Nc9Zpaw4UcMe6UJECHeJqeWNU0=;
        b=foRr5VBt8ndzC5REdlLq+fFwHZVIhFhP31Emy2Xk2OSyuy/ZO8Gg4/jOKN/nMlaQH3
         Wycopa7TZa6Ee12xfkgkl3vLD4EhphwOTxlZSaGHLG0a2W7oPMeBZ9dUaGxVvP0dgW1x
         NebgW4Qp7se1tSaz0DxfCDm7sAqodUoBS0QG3a0F7aocMPYuWWkZhf6AjYzxw99caOKu
         jXq2CgNiFP4miT+oGmM7bTxX4azdc/ux2pZoLAYcoRv6RWy791IT+O65hRxlBBHUCzZd
         0Yag61wSNzQ9Sg2yngL6FOcgJ2ss1YSs/84XqcgLYS7G75UfxDlzGjy2UXXurqUT0Oxd
         lZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424033; x=1702028833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc/JnQzKFnW7sQYk0Nc9Zpaw4UcMe6UJECHeJqeWNU0=;
        b=eF11fMaVNjtSwLWKZCMMuIXnLXEms1n2GWGLkkN1Q7gVXyb8wrMwpf7iJVf1y/8T4/
         JAFMtktJfBGLychCbzBUkiraNvRYqZ0+15umiS3j9Sns+MknKJx/fdXe0yQXR7N8psiL
         oP2/1zsbOooJ/7Cp8J6IfXhtCkYU7YMSNd2g+TwULbqEc0lIhybXv389FhVcilhlrMt+
         vqlMiqYCnrPcS0Am2TAvqEDCvn2lnH4C4Sm6fyG60eG2noklsXWx78ssG4r8Jq1qsFO4
         bKJSCbYsjl2G1SAYdI9kZpR0I0QqtS68DLIpY+HXi5JZQ95awKv4pdjsBNHaOJdq5/Ni
         UTYQ==
X-Gm-Message-State: AOJu0Yz2Qd+ZMOYMvucO3gTyTeFBK6ZiSfwFU3ed0u9EIoEVr58KkFEm
	MDecKJGJ98Jt7HipC7dGS6U=
X-Google-Smtp-Source: AGHT+IHzDiK6o6MOlN3a1X1HHIiCln1ILc6SVwnXbjY0NMbXK8wHeCruOVe9g11XZtiAGRL7ZsnvhA==
X-Received: by 2002:a17:902:e88b:b0:1cf:d404:5e7c with SMTP id w11-20020a170902e88b00b001cfd4045e7cmr20071237plg.42.1701424033643;
        Fri, 01 Dec 2023 01:47:13 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:13 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 6/7] selftests/bpf: Add selftests for set_mempolicy with a lsm prog
Date: Fri,  1 Dec 2023 09:46:35 +0000
Message-Id: <20231201094636.19770-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231201094636.19770-1-laoar.shao@gmail.com>
References: <20231201094636.19770-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result as follows,
  #261/1   set_mempolicy/MPOL_BIND_with_lsm:OK
  #261/2   set_mempolicy/MPOL_DEFAULT_with_lsm:OK
  #261/3   set_mempolicy/MPOL_BIND_without_lsm:OK
  #261/4   set_mempolicy/MPOL_DEFAULT_without_lsm:OK
  #261     set_mempolicy:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/set_mempolicy.c  | 81 +++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c  | 28 +++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
new file mode 100644
index 000000000000..6d115ecedb10
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <linux/mempolicy.h>
+#include <test_progs.h>
+#include "test_set_mempolicy.skel.h"
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
+	/* -lnuma is required by mbind(2), so use __NR_mbind to avoid the dependency. */
+	err = syscall(__NR_mbind, addr, SIZE, MPOL_BIND, &mask, sizeof(mask), 0);
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
+	err = syscall(__NR_mbind, addr, SIZE, MPOL_DEFAULT, NULL, 0, 0);
+	ASSERT_OK(err, "mbind_success");
+
+	munmap(addr, SIZE);
+}
+
+void test_set_mempolicy(void)
+{
+	struct test_set_mempolicy *skel;
+	int err;
+
+	skel = test_set_mempolicy__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = test_set_mempolicy__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	/* Attach LSM prog first */
+	err = test_set_mempolicy__attach(skel);
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
+	test_set_mempolicy__destroy(skel);
+
+	if (test__start_subtest("MPOL_BIND_without_lsm"))
+		mempolicy_bind(true);
+	if (test__start_subtest("MPOL_DEFAULT_without_lsm"))
+		mempolicy_default();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_set_mempolicy.c b/tools/testing/selftests/bpf/progs/test_set_mempolicy.c
new file mode 100644
index 000000000000..b5356d5fcb8b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_set_mempolicy.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+SEC("lsm/set_mempolicy")
+int BPF_PROG(setmempolicy, u64 mode, u16 mode_flags, nodemask_t *nmask, u32 flags)
+{
+	return mem_policy_adjustment(mode);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.1 (Apple Git-130)


