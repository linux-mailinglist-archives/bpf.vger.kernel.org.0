Return-Path: <bpf+bounces-13679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D57DC62F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88637B20FD1
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4F101C3;
	Tue, 31 Oct 2023 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUxJq1Hw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642DDF5D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:01:12 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07791F4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:01:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c434c33ec0so40465985ad.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732049; x=1699336849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMitVK3rOTDVbT4Z+8x0bS93zlRA2h7260oX1PRTrQE=;
        b=hUxJq1Hwyb9l03FRPO0HLffR+E7eJu9Aai1DYQsWT4dG2Cfy4PhLGar1qk1YH/99pN
         5nqfKPXh76oUBDWLd1iqueUCysBI89nfq65j+DgWo++hgd7Cd5ilJiivO1tVfWyJi95k
         1mLU5z5+zTWNco8Gqfp3O2l57lW/+qRUHCEwLG9knG0P+/5wyVHfBnliaYXW00vvc/UO
         1WNOC0IQhZw4uzHp2nFSy/RK42oyPf6Y68FXifQZ9Y01B/v4atRtzsD9hMzYQqMIrOwv
         xBWFDBIo90vvHNsDKHzCOxvbUX97kbNaFvLJGbop9nBIuhZD+GYapBZRm3VBPiMeIGcq
         XDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732049; x=1699336849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMitVK3rOTDVbT4Z+8x0bS93zlRA2h7260oX1PRTrQE=;
        b=jHVLTCYIoRAg/SdWWK0mzc9Ui2spIGpHC+JP3Z2//QypPyQx7W3Jpm9Tse7LYQLDUp
         PnaddtLbF0w9E87/u5flpoCDgEoLZS7lt86MrQSVMn+nV4sZmSGWdQ5i5jILeDz6nRET
         D09ogrrw6J7oQE3tiyb6xiPS3pSssWRR0H/e/rEJmWzzSuyYH5zeJdo/gU2QrMLIu16p
         9Nl91gYjxema5iYWDG7EhnkArnA2pt1x2J1nVcf/UKAJ168/nwWiOOnd+uF4urJjjPEB
         dXHJ92TcCyTUUsU01JrYsyAiSZ3XQXPlRXzUJvT+GYPxHiHidEd7lulMe2rKyb8Au+g7
         T1KQ==
X-Gm-Message-State: AOJu0YzkReuer3ai6Pq/XODEvcPXIJLK+gY6aE7+ugvoL4WRfI0ULBUr
	mLugcl/XsAJiPTMlyVqtJu7tQaf7rWIqZg==
X-Google-Smtp-Source: AGHT+IHij17j15v/dEVO7nUcwFHlvhQi2eRQdf72y00nNcRRXLxzEUYBzkpOLoD6lOZKix231/WTaQ==
X-Received: by 2002:a17:903:1104:b0:1c9:ea6e:5a63 with SMTP id n4-20020a170903110400b001c9ea6e5a63mr12217788plh.32.1698732048725;
        Mon, 30 Oct 2023 23:00:48 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:48 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 6/6] selftests/bpf: Test BPF_PROG_TYPE_SECCOMP
Date: Tue, 31 Oct 2023 01:24:07 +0000
Message-Id: <20231031012407.51371-7-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031012407.51371-1-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testcase to exercise BPF_PROG_TYPE_SECCOMP.

  # ./test_progs -n 194
  #194     seccomp:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/include/uapi/linux/seccomp.h            |  2 +
 .../selftests/bpf/prog_tests/seccomp.c        | 40 +++++++++++++++++++
 .../selftests/bpf/progs/test_seccomp.c        | 24 +++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/seccomp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_seccomp.c

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..f0fcfe0ccb2e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -995,6 +995,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
index dbfc9b37fcae..db792dc96b5a 100644
--- a/tools/include/uapi/linux/seccomp.h
+++ b/tools/include/uapi/linux/seccomp.h
@@ -25,6 +25,8 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Indicates that the filter is in form of bpf prog fd */
+#define SECCOMP_FILTER_FLAG_BPF_PROG_FD		(1UL << 6)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/tools/testing/selftests/bpf/prog_tests/seccomp.c b/tools/testing/selftests/bpf/prog_tests/seccomp.c
new file mode 100644
index 000000000000..fc7db6af7d64
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/seccomp.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Hengqi Chen */
+
+#include <test_progs.h>
+#include <linux/seccomp.h>
+#include "test_seccomp.skel.h"
+
+static int seccomp(unsigned int op, unsigned int flags, void *args)
+{
+	errno = 0;
+	return syscall(__NR_seccomp, op, flags, args);
+}
+
+void test_seccomp(void)
+{
+	struct test_seccomp *skel;
+	int fd, flags, ret;
+
+	skel = test_seccomp__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->rodata->seccomp_syscall_nr = __NR_seccomp;
+	skel->rodata->seccomp_errno = 99;
+
+	ret = test_seccomp__load(skel);
+	if (!ASSERT_OK(ret, "skel_load"))
+		goto cleanup;
+
+	fd = bpf_program__fd(skel->progs.seccomp_prog);
+	flags = SECCOMP_FILTER_FLAG_BPF_PROG_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_OK(ret, "seccomp_set_bpf_prog");
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1, "seccomp should fail");
+	ASSERT_EQ(errno, 99, "errno not equal to 99");
+
+cleanup:
+	test_seccomp__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_seccomp.c b/tools/testing/selftests/bpf/progs/test_seccomp.c
new file mode 100644
index 000000000000..c53e75b8c0ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_seccomp.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define SECCOMP_RET_ERRNO	0x00050000U
+#define SECCOMP_RET_ALLOW	0x7fff0000U
+#define SECCOMP_RET_DATA	0x0000ffffU
+
+const volatile int seccomp_syscall_nr = 0;
+const volatile __u32 seccomp_errno = 0;
+
+SEC("seccomp")
+int seccomp_prog(struct seccomp_data *ctx)
+{
+	if (ctx->nr != seccomp_syscall_nr)
+		return SECCOMP_RET_ALLOW;
+
+	return SECCOMP_RET_ERRNO | (seccomp_errno & SECCOMP_RET_DATA);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


