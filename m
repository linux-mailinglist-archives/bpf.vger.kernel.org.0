Return-Path: <bpf+bounces-15653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB117F48B8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBECB212C9
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A15B20D;
	Wed, 22 Nov 2023 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH/5+/7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021019E;
	Wed, 22 Nov 2023 06:16:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c4d06b6ddaso5745887b3a.3;
        Wed, 22 Nov 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662587; x=1701267387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42bpqVzHBF23qzcSwgVCWgOUmb+BqnKFGPkAIPmzQRk=;
        b=QH/5+/7z752qsHax/mfWb85MHjlveJJAhG1o9yjGOD8WoO5MEdLkkbZ5b4bhgPq2WG
         ruYninx1erAlGDpHB/LmLWi9qs9X4tX1hDVL2RKm1ZGaa/D6f5UxZUJtKU+v6ciwW0+Y
         N4emx6OVXSjrEUIEBUmjyMZghAFklUatKqgZSV1rhL8Mb3wmS0NccRRRZFAvOKF2cZkC
         6Z4j/wbAviOZwwVUCiglT9KMA35HjOxhjBGpxdO2vNOhbIXk0Rutd0ae4Jmew6tLn2J/
         WeoGbsL1pCUvyjMLW5tWvoqY/EXmWXt9nZcYE3mZFPGeFWOHSa2glsawrVqsHXbXD7nn
         3pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662587; x=1701267387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42bpqVzHBF23qzcSwgVCWgOUmb+BqnKFGPkAIPmzQRk=;
        b=Tk7yRFTuX99ahkHFjM2mcuUIqRRhoJZDCerLpZqZssVl9XQLzRMYLghuqxHDyanN2g
         Fsxo48TU0NAXI8xB4GM7XrXkTRpR9+xw/l6vPfRV5P0sBJGKeP1qAlS120rQNxCe9gi4
         VL9uLMY8sVl7t1MCCmBL5eeQiL3wSb1Wdc6+uvin9dc4sruk0LoVFZI+0kSMVjv9i6Z7
         1zJ6COh1n3VJK5PbgYJW9wyePlRmzA2pwY6mpvy50+hagnejow2fdYD4RoKMoJjssUTC
         UXkyxSr++Qr4L0mls25HC1U68KBp3NdF0OavzDUV66R956nriqZAteWiqi6lylwpHzQ/
         jrYw==
X-Gm-Message-State: AOJu0Yy5eBj9hNAMWp0418otTMnOQrmyXtsfyMkizT/kTOMupMLN9sJl
	5tWYWLxrxY9CorBXOwjLdMss9o7vJFhtFWDp
X-Google-Smtp-Source: AGHT+IH9TJv1IbJvzrwzu5iTZh4KrlS6UUEMOLV3hX6Kk58543Idex8psVvUw1lHrI+Zle6LTEek0A==
X-Received: by 2002:a05:6a20:548c:b0:187:ce9f:e1ab with SMTP id i12-20020a056a20548c00b00187ce9fe1abmr2457912pzk.33.1700662586874;
        Wed, 22 Nov 2023 06:16:26 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:26 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 6/6] selftests/bpf: Add selftests for set_mempolicy with a lsm prog
Date: Wed, 22 Nov 2023 14:15:59 +0000
Message-Id: <20231122141559.4228-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231122141559.4228-1-laoar.shao@gmail.com>
References: <20231122141559.4228-1-laoar.shao@gmail.com>
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
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/set_mempolicy.c  | 79 +++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c  | 29 +++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c27b67bc7b1..3c3c3b7d5dcd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -35,7 +35,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += -lelf -lz -lrt -lpthread -lnuma
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
diff --git a/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
new file mode 100644
index 000000000000..0dc3391b29fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <numaif.h>
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
index 000000000000..31eeaa580a17
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_set_mempolicy.c
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
+SEC("lsm/set_mempolicy")
+int BPF_PROG(setmempolicy, u64 mode, u16 mode_flags, nodemask_t *nmask, u32 flags)
+{
+	return mem_policy_adjustment(mode);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.1 (Apple Git-130)


