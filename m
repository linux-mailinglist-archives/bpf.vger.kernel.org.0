Return-Path: <bpf+bounces-17122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8C809ECB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF8C281559
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6B11731;
	Fri,  8 Dec 2023 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuolUJgw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC381730;
	Fri,  8 Dec 2023 01:06:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0538d9bbcso16774275ad.3;
        Fri, 08 Dec 2023 01:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026409; x=1702631209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU9j6PmyAYnwHf3ycIBsVG8xT88NU3yJVsd2qrFmMpI=;
        b=YuolUJgwG50jo9OqMQw63g7B8R2HuRF9bkS8yrqdR3r+y9XYXVcykhZHb/eheWpW+5
         51ORqVWaUt8h/T+dQauHPO8CVlA475Hkte78hL9RnWmD9I1gSHSIim9iEdUgM/DLR3ip
         LvWXq7UApSxUqUc3gyydx+gvxM4bbGDSLQejH+CQTewaShPqlN4ra00TSr6HA3bTT3UM
         2brwTfSQO6XQyUu0V+GSjz1r3ytSf6h/W4N/i9kA2TEltYqvZ2SdEwU7SCXKAkIejKn2
         Ldps65E94dX0QzL09aDgPCQLNbUY5AfZTA4hPoe8v6UlBPjuBrGBg+YVDa5tzZN/NSOq
         92wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026409; x=1702631209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU9j6PmyAYnwHf3ycIBsVG8xT88NU3yJVsd2qrFmMpI=;
        b=EUYbm46bn416fjsDy1KRuElMAcVrm6wjbLAPhy4kDQUb8g1XZqYCUYdiOQatC9tmIX
         cNbMIWR3VezkoPr6tdPm2QYSmysSWm8rMKP3rppgirXr9iPSYDByHIimD2OCah2agrcK
         mooV1URIpk2qLwu9eWvwpMwgK1oweLlc/9OY4UaBRdFw9S25394/dH7cGGEblpDdOYuy
         3LQawL3BskA5vwW1S5T9vPvjnkzMp2UAfmp3CsvQIMSd9asZARUIHv2nEDyhGa4IkWgI
         Ug991jbWX4OaNwgUrC/cm6vGRYfw623nj4hk/+g9joSLtO4NCHuI/J+q+fXJL5yNjrSx
         +ieQ==
X-Gm-Message-State: AOJu0YzY85AFveseQWnSd95yzc9OeJlZJqEcGtUJeb6irqDMzn8l5f/8
	I4bX64YMs++jOPilnfc8UUg=
X-Google-Smtp-Source: AGHT+IFStUfBJJa8ImSvTVzgn8M/BHq8OdIdJjzD8odHwdrF3muYRwZVDrOvFB6m8GWXoMywE/1+TQ==
X-Received: by 2002:a17:903:1d1:b0:1d0:bcb2:b914 with SMTP id e17-20020a17090301d100b001d0bcb2b914mr4703824plh.129.1702026408724;
        Fri, 08 Dec 2023 01:06:48 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:48 -0800 (PST)
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
Subject: [PATCH v4 5/5] selftests/bpf: Add selftests for set_mempolicy with a lsm prog
Date: Fri,  8 Dec 2023 09:06:22 +0000
Message-Id: <20231208090622.4309-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231208090622.4309-1-laoar.shao@gmail.com>
References: <20231208090622.4309-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result as follows,
  #263/1   set_mempolicy/MPOL_BIND_without_lsm:OK
  #263/2   set_mempolicy/MPOL_DEFAULT_without_lsm:OK
  #263/3   set_mempolicy/MPOL_BIND_with_lsm:OK
  #263/4   set_mempolicy/MPOL_DEFAULT_with_lsm:OK
  #263     set_mempolicy:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/set_mempolicy.c       | 81 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
new file mode 100644
index 0000000..736b5e3
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
+	if (test__start_subtest("MPOL_BIND_without_lsm"))
+		mempolicy_bind(true);
+	if (test__start_subtest("MPOL_DEFAULT_without_lsm"))
+		mempolicy_default();
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


