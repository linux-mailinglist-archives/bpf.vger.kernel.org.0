Return-Path: <bpf+bounces-7725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9177BBC0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431651C20ADE
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D11C150;
	Mon, 14 Aug 2023 14:33:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7DBA34
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 14:33:58 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABAE4
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso15579645ad.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023637; x=1692628437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv4yUrMyWBhLHqAH2ovg1Sj3+silqXptyM0b5G7vsNI=;
        b=kGUe+mJFGFg9aC/s8merWTnWNun1P0VmxQ/LRkfNSvUQ0uUuDuEolcDXuqcHeWfziC
         D8rrmnR6x7jeoTyVP1H0orcQdmDU3ZnFBeu7KfabJKFghZQyCtg94EQn0KAmjAaJYsJe
         EiX6QNpT/+4GNyfD5gATADfzcJbwLICnYbgUuxmsTT8WrsTFvYOoOVx7F3r89bjL9EXZ
         IfY27oXcYjsYYzNqkxaMI1U8Z6/pH87jn/rQDJKKvbC6gHMJvI47e49fSlPc80t4hwGC
         mRlk12kdux/nO/5hJjh6+4QUtC967+exEfxSWE5QOllttf3MrKsWh0uzXMObRtF/Iz/R
         4KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023637; x=1692628437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv4yUrMyWBhLHqAH2ovg1Sj3+silqXptyM0b5G7vsNI=;
        b=Kt4D132tBMCKKjrYjP4lyMplaqHHsa2NIpWBLoF7I5FoaffKM7g+zaHSDcN3kR9HKx
         8WOA+ZTffRAHdxOqUhonCmYFxqV1sCgUWk6L1Bw69tI3wHl9IKiCF7AtMYgugTl3JsVb
         FaB6E+UWVCfXjeRv1TVZPaeJpg3/x1yi/B0COWfk7zycXnOw31WOUSN5t6Q6VX0qz1Ok
         QM/STxKBTOgUb+PjlSl1IUrdpys2TdrrZjO0ep6NVUetBJekz+8rWZzidPmEtUIpyXqr
         s2aGEE3FSUUtRrVcYfad8ePxCK3ar7YCz7aM5weucGjw55Ze2PKEvFqzofeIXfs37LBt
         gEUQ==
X-Gm-Message-State: AOJu0YwwR2OHwmFJUo0Hs1ePUhWpAy1N8ngioDhel0PepnajjWc1MYDo
	b6jJ1iYJtVe43q8+3XEdGrvXa0rjgbZh0s6+
X-Google-Smtp-Source: AGHT+IH7dsJH26H/nkFXa68jzmQQIpzL3bo9qMkvtmk9p2dGcKieaMc1ZD8WOQj8ic0AzNh0KMx/CQ==
X-Received: by 2002:a17:90a:9ee:b0:267:c21f:ce0d with SMTP id 101-20020a17090a09ee00b00267c21fce0dmr6655310pjo.27.1692023636965;
        Mon, 14 Aug 2023 07:33:56 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a031300b002677739860fsm8640390pje.34.2023.08.14.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:33:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add selftest for bpf_current_capable
Date: Mon, 14 Aug 2023 14:33:41 +0000
Message-Id: <20230814143341.3767-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814143341.3767-1-laoar.shao@gmail.com>
References: <20230814143341.3767-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add testcase for the newly added bpf_current_capable.

The result:
  $ tools/testing/selftests/bpf/test_progs --name=bpf_current_cap
  #13      bpf_current_cap:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_current_cap.c     | 80 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_current_cap.c     | 37 ++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_current_cap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_current_cap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_current_cap.c b/tools/testing/selftests/bpf/prog_tests/bpf_current_cap.c
new file mode 100644
index 0000000..6952908
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_current_cap.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <linux/perf_event.h>
+#include <linux/bpf.h>
+#include <test_progs.h>
+#include "cap_helpers.h"
+#include "test_bpf_current_cap.skel.h"
+
+void serial_test_bpf_current_cap(void)
+{
+	struct test_bpf_current_cap *skel;
+	struct perf_event_attr attr = {};
+	int pfd, link_fd, err;
+	__u64 caps = 0;
+
+	skel = test_bpf_current_cap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.freq = 1;
+	attr.sample_freq = 1000;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (!ASSERT_GE(pfd, 0, "perf_event_open"))
+		goto cleanup;
+
+	/* In case CAP_BPF and CAP_PERFMON is not set */
+	err = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_PERFMON, &caps);
+	if (!ASSERT_OK(err, "set_cap_bpf_perfmon"))
+		goto close_perf;
+
+	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, NULL);
+	if (!ASSERT_OK(err, "disable_cap_sys_admin"))
+		goto restore_cap;
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.perf_event_run), pfd,
+				  BPF_PERF_EVENT, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_create_without_lsm"))
+		goto restore_cap;
+	close(link_fd);
+	ASSERT_EQ(skel->bss->cap_sys_admin, false, "cap_sys_admin_init_value");
+	ASSERT_EQ(skel->bss->cap_bpf, false, "cap_bpf_init_value");
+	ASSERT_EQ(skel->bss->cap_perfmon, false, "cap_perfmon_init_value");
+
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		goto restore_cap;
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.perf_event_run), pfd,
+				  BPF_PERF_EVENT, NULL);
+	if (!ASSERT_LE(link_fd, 0, "link_create_without_sys_admin"))
+		goto restore_cap;
+	ASSERT_EQ(skel->bss->cap_sys_admin, false, "cap_sys_admin_disable");
+	ASSERT_EQ(skel->bss->cap_bpf, true, "cap_bpf_enable");
+	ASSERT_EQ(skel->bss->cap_perfmon, true, "cap_perfmon_enable");
+
+	err = cap_enable_effective(1ULL << CAP_SYS_ADMIN, NULL);
+	if (!ASSERT_OK(err, "enable_cap_sys_admin"))
+		goto restore_cap;
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.perf_event_run), pfd,
+				  BPF_PERF_EVENT, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_create_with_sys_admin"))
+		goto restore_cap;
+	close(link_fd);
+	ASSERT_EQ(skel->bss->cap_sys_admin, true, "cap_sys_admin_enable");
+	ASSERT_EQ(skel->bss->cap_bpf, true, "cap_bpf_enable");
+	ASSERT_EQ(skel->bss->cap_perfmon, true, "cap_perfmon_enable");
+
+restore_cap:
+	if (caps)
+		cap_enable_effective(caps, NULL);
+close_perf:
+	close(pfd);
+cleanup:
+	test_bpf_current_cap__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_current_cap.c b/tools/testing/selftests/bpf/progs/test_bpf_current_cap.c
new file mode 100644
index 0000000..6dd97a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bpf_current_cap.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define CAP_SYS_ADMIN	21
+#define CAP_PERFMON	38
+#define CAP_BPF		39
+
+extern bool bpf_current_capable(int cap) __ksym;
+bool cap_sys_admin, cap_bpf, cap_perfmon;
+
+int link_create_audit(union bpf_attr *attr)
+{
+	cap_bpf = bpf_current_capable(CAP_BPF);
+	cap_perfmon = bpf_current_capable(CAP_PERFMON);
+	cap_sys_admin = bpf_current_capable(CAP_SYS_ADMIN);
+	return cap_sys_admin ? 0 : -1;
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+	return link_create_audit(attr);
+}
+
+SEC("perf_event")
+int BPF_PROG(perf_event_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


