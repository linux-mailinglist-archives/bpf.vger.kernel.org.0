Return-Path: <bpf+bounces-17821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987481309C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E25B216B5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0327A537F0;
	Thu, 14 Dec 2023 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIfbfkFQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F60115;
	Thu, 14 Dec 2023 04:51:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d367e7092eso5218505ad.0;
        Thu, 14 Dec 2023 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558309; x=1703163109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyrHpozxlKgTFPeXDtkYdtWnntKkuOFgibrMNmUzOUE=;
        b=HIfbfkFQeonZbdJmlwW1p7RSjAC/yIFnJB/8NuNTYcUCFHB7YfKydEjO77gFRT3GdK
         CQdRCz/TllrELmE5OCiENBPxJBKsMjurdilOiBW8mmISBXhyd5efgMacci3+Gye2OcTw
         Sl+KpVKSz/LqW3Eo5pdm6gnWOsO4WlPhMrklybdV+6mPkTvIDZGvehydJ6i4TaJar7AS
         xcBctylZqoKYRnNr9MW9UGeIT5nGIuXa0dN8OxoHIsMrYyG8PTeuAOHlvIpsAYcOGZou
         RtdY3s55JN7AUp64jmkncjRuk973PGEBi/rECw6GHQ8QKm/MBlwKttCKEzGW9t2MuTy7
         2JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558309; x=1703163109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyrHpozxlKgTFPeXDtkYdtWnntKkuOFgibrMNmUzOUE=;
        b=mn6yAvztEZP5OSpf0ZVv4YG24oD5JB0fXTgmZEgIljg8dMVDrqqQHHlMM+PIKNYLBQ
         PXUOAgJ6eFTPzv2ca1mUq6YBq/vpbnZsrOQBWqjw3HmwmxqudoAefA70vGJRm83eDA/4
         LgPLGfiOuISYcB82sTu3xucivGkjWMwNRWZOSch6/UkrX+bFCj3GaqTdlzkpkYYgMnCD
         uHcSN2bRV5nu2H9SUgtE4vpZvi8ldLAtK3ePn179RkUrI/JW2zfD0qhdg5ZtNxbeu9To
         z5F23Bd8fBJMHfVc9QIsChYDC0ILCCrQNCH8WvIi7GDvloGBwnJyhwcwJNldL73Iu5c3
         bMhA==
X-Gm-Message-State: AOJu0YwaCN17r9zsiEYX2yUsw5KiVHTE28XmCSQavg+1XA5Jf8l5/mBH
	eHECIRcpaS6dBIXc/s7h1Ik=
X-Google-Smtp-Source: AGHT+IHKABTJfb+UE9Rl0k944YTPHTs0rNUemBBzZ7HjNhQ1RB6o1I8s72VFPWyQj+fYjdmi8hT7kw==
X-Received: by 2002:a17:902:ebcd:b0:1d0:c906:f5e0 with SMTP id p13-20020a170902ebcd00b001d0c906f5e0mr11350823plg.72.1702558309099;
        Thu, 14 Dec 2023 04:51:49 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:48 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kpsingh@kernel.org,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 5/5] selftests/bpf: Add selftests for set_mempolicy with a lsm prog
Date: Thu, 14 Dec 2023 12:50:33 +0000
Message-Id: <20231214125033.4158-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214125033.4158-1-laoar.shao@gmail.com>
References: <20231214125033.4158-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the straightforward LSM prog, it denies the use of mbind(2) with the
mode MPOL_BIND and permits other modes.

Consequently:

- Absent the LSM prog, mbind(2) should invariably succeed regardless of
  the mode
    #263/1   set_mempolicy/MPOL_BIND_without_lsm:OK
    #263/2   set_mempolicy/MPOL_DEFAULT_without_lsm:OK

- With the LSM prog
  - mbind(2) with the mode MPOL_BIND should result in failure
    #263/3   set_mempolicy/MPOL_BIND_with_lsm:OK

  - mbind(2) with the mode MPOL_DEFAULT should succeed
    #263/4   set_mempolicy/MPOL_DEFAULT_with_lsm:OK

- Summary
  #263     set_mempolicy:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
new file mode 100644
index 0000000..4d3fe1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
@@ -0,0 +1,84 @@
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
+	/* Without LSM, mbind(2) should succeed regardless of the mode. */
+	if (test__start_subtest("MPOL_BIND_without_lsm"))
+		mempolicy_bind(true);
+	if (test__start_subtest("MPOL_DEFAULT_without_lsm"))
+		mempolicy_default();
+
+	/* Attach LSM prog, in which it will deny MPOL_BIND */
+	err = test_set_mempolicy__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto destroy;
+
+	/* MPOL_BIND should fail. */
+	if (test__start_subtest("MPOL_BIND_with_lsm"))
+		mempolicy_bind(false);
+
+	/* MPOL_DEFAULT should succeed. */
+	if (test__start_subtest("MPOL_DEFAULT_with_lsm"))
+		mempolicy_default();
+
+destroy:
+	test_set_mempolicy__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_set_mempolicy.c b/tools/testing/selftests/bpf/progs/test_set_mempolicy.c
new file mode 100644
index 0000000..b5356d5
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
1.8.3.1


