Return-Path: <bpf+bounces-5599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7875C308
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375B02821FA
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B21417AB7;
	Fri, 21 Jul 2023 09:27:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09E14F8D
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:27:43 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509E31BD
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8bd586086so13055935ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689931661; x=1690536461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC5AxBYziP8Y9sYekrQ/s7e1Kj9Y13j8DfSo/Wi9xrM=;
        b=KkIEZcehMo86AHQncsDaNtAugPZL6KCr6sz1JyHC3DCg80WAyXT9AGLTEn6jU+x6nL
         K1BjJS5842jN634mnVsXe2nLoe3tP1VRsyiCQFyBgaoS4IAUbRxEaUA03Q3MuN7huumE
         McfjERcyOKQ3q/Yvqc0ro5AZYeEQ31u71cA4LAj9o3iUk4BJJl/GrJHAHknuWzmucZKr
         b/0FNQsUhUzfw7cZ5PJJjrmWX0Gdyj3OgrhK/Dsy1nFUOzpffk96uKuF3tK5qxByim0b
         otQoqz3abf4BexmPyj1v0jdHkcBxs9/aCbIvU0l9Rb1FEVxxtEC1/P7YsRGOYTsbbSoT
         ebrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931661; x=1690536461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC5AxBYziP8Y9sYekrQ/s7e1Kj9Y13j8DfSo/Wi9xrM=;
        b=bLZk2ErEOA3gY9RzOJCoM6xLwE/7ygGjt6Hdj28WAjaJnjDHOUcVKdIxS9n/rxyBhZ
         1VIt4qIJHw9QdtJ2/BVvh3AIWnfs4uhIS0Lishd22jIVMkG6cPzTovasUTGnlOmiuQa6
         krLqv4NdSTJNR2Kl3uzejzzCl/T7ozuTtsmGkMHXt4SFjCJ6EgneNJuRdB845td+4Xj2
         gLrEqz1QxVSTvgdey/6QjkJJF7i0QkcTikTHg+XAx/8m6hS1ncK1gs+u53v421SsN+Gr
         iZdHGq/GhjHnCyXI+17cfhjKpCItvNCG5K9GJ2gA7k0XCpNHrKmu+yqH24Mh+9v+yqDw
         phfg==
X-Gm-Message-State: ABy/qLZGsfNtJdRvvjw/+cGpfq08UBBqVHLkFu44R2HdK/QEhMxrCgdw
	rPW/50diUBnb/GCa8iCb64g=
X-Google-Smtp-Source: APBJJlGIV7s8oRcWqcGaThSrNaZ9PFgdMa1MWQ9oO7RGyHDhuzF1b1D1rtDi8lsFrkam+bg0GUwgqg==
X-Received: by 2002:a17:903:11c8:b0:1ae:8892:7d27 with SMTP id q8-20020a17090311c800b001ae88927d27mr1670051plh.42.1689931660679;
        Fri, 21 Jul 2023 02:27:40 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1303:5400:4ff:fe83:cf8a])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm2911072pls.285.2023.07.21.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:27:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
Date: Fri, 21 Jul 2023 09:27:25 +0000
Message-Id: <20230721092725.3795-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230721092725.3795-1-laoar.shao@gmail.com>
References: <20230721092725.3795-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
The result:

  #78/1    fill_link_info/kprobe_link_info:OK
  #78/2    fill_link_info/kretprobe_link_info:OK
  #78/3    fill_link_info/fill_invalid_user_buff:OK
  #78/4    fill_link_info/tracepoint_link_info:OK
  #78/5    fill_link_info/uprobe_link_info:OK
  #78/6    fill_link_info/uretprobe_link_info:OK
  #78      fill_link_info:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/fill_link_info.c      | 232 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  25 +++
 2 files changed, 257 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
new file mode 100644
index 0000000..9779a8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <string.h>
+#include <linux/bpf.h>
+#include <linux/limits.h>
+#include <test_progs.h>
+#include "trace_helpers.h"
+#include "test_fill_link_info.skel.h"
+
+#define TP_CAT "sched"
+#define TP_NAME "sched_switch"
+#define KPROBE_FUNC "tcp_rcv_established"
+#define UPROBE_FILE "/proc/self/exe"
+
+/* uprobe attach point */
+static noinline void uprobe_func(void)
+{
+	asm volatile ("");
+}
+
+static int verify_link_info(int fd, enum bpf_perf_event_type type, long addr, ssize_t offset)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	char buf[PATH_MAX];
+	int err = 0;
+
+	memset(&info, 0, sizeof(info));
+	buf[0] = '\0';
+
+again:
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	switch (info.type) {
+	case BPF_LINK_TYPE_PERF_EVENT:
+		if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_match"))
+			return -1;
+
+		switch (info.perf_event.type) {
+		case BPF_PERF_EVENT_KPROBE:
+		case BPF_PERF_EVENT_KRETPROBE:
+			ASSERT_EQ(info.perf_event.kprobe.offset, offset, "kprobe_offset");
+
+			/* In case kptr setting is not permitted or MAX_SYMS is reached */
+			if (addr)
+				ASSERT_EQ(info.perf_event.kprobe.addr, addr, "kprobe_addr");
+
+			if (!info.perf_event.kprobe.func_name) {
+				ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
+				info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
+				info.perf_event.kprobe.name_len = sizeof(buf);
+				goto again;
+			}
+
+			err = strncmp(u64_to_ptr(info.perf_event.kprobe.func_name), KPROBE_FUNC,
+				      strlen(KPROBE_FUNC));
+			ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
+			break;
+		case BPF_PERF_EVENT_TRACEPOINT:
+			if (!info.perf_event.tracepoint.tp_name) {
+				ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
+				info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
+				info.perf_event.tracepoint.name_len = sizeof(buf);
+				goto again;
+			}
+
+			err = strncmp(u64_to_ptr(info.perf_event.tracepoint.tp_name), TP_NAME,
+				      strlen(TP_NAME));
+			ASSERT_EQ(err, 0, "cmp_tp_name");
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+		case BPF_PERF_EVENT_URETPROBE:
+			ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
+
+			if (!info.perf_event.uprobe.file_name) {
+				ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
+				info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
+				info.perf_event.uprobe.name_len = sizeof(buf);
+				goto again;
+			}
+
+			err = strncmp(u64_to_ptr(info.perf_event.uprobe.file_name), UPROBE_FILE,
+				      strlen(UPROBE_FILE));
+			ASSERT_EQ(err, 0, "cmp_file_name");
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		switch (type) {
+		case BPF_PERF_EVENT_KPROBE:
+		case BPF_PERF_EVENT_KRETPROBE:
+		case BPF_PERF_EVENT_TRACEPOINT:
+		case BPF_PERF_EVENT_UPROBE:
+		case BPF_PERF_EVENT_URETPROBE:
+			err = -1;
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+	return err;
+}
+
+static void kprobe_fill_invalid_user_buffer(int fd)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err = 0;
+
+	memset(&info, 0, sizeof(info));
+
+	info.perf_event.kprobe.func_name = 0x1; /* invalid address */
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "invalid_buff_and_len");
+
+	info.perf_event.kprobe.name_len = 64;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "invalid_buff");
+
+	info.perf_event.kprobe.func_name = 0;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "invalid_len");
+
+	ASSERT_EQ(info.perf_event.kprobe.addr, 0, "func_addr");
+	ASSERT_EQ(info.perf_event.kprobe.offset, 0, "func_offset");
+	ASSERT_EQ(info.perf_event.type, 0, "type");
+}
+
+static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
+				       enum bpf_perf_event_type type,
+				       bool retprobe, bool invalid)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
+		.attach_mode = PROBE_ATTACH_MODE_LINK,
+		.retprobe = retprobe,
+	);
+	int link_fd, err;
+	long addr;
+
+	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
+								 KPROBE_FUNC, &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.kprobe_run);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		return;
+
+	addr = ksym_get_addr(KPROBE_FUNC);
+	if (!invalid) {
+		err = verify_link_info(link_fd, type, addr, 0);
+		ASSERT_OK(err, "verify_link_info");
+	} else {
+		kprobe_fill_invalid_user_buffer(link_fd);
+	}
+	bpf_link__detach(skel->links.kprobe_run);
+}
+
+static void test_tp_fill_link_info(struct test_fill_link_info *skel)
+{
+	int link_fd, err;
+
+	skel->links.tp_run = bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CAT, TP_NAME);
+	if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.tp_run);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		return;
+
+	err = verify_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0);
+	ASSERT_OK(err, "verify_link_info");
+	bpf_link__detach(skel->links.tp_run);
+}
+
+static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
+				       enum bpf_perf_event_type type, ssize_t offset,
+				       bool retprobe)
+{
+	int link_fd, err;
+
+	skel->links.uprobe_run = bpf_program__attach_uprobe(skel->progs.uprobe_run, retprobe,
+							    0, /* self pid */
+							    UPROBE_FILE, offset);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.uprobe_run);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		return;
+
+	err = verify_link_info(link_fd, type, 0, offset);
+	ASSERT_OK(err, "verify_link_info");
+	bpf_link__detach(skel->links.uprobe_run);
+}
+
+void serial_test_fill_link_info(void)
+{
+	struct test_fill_link_info *skel;
+	ssize_t offset;
+
+	skel = test_fill_link_info__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* load kallsyms to compare the addr */
+	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+		return;
+	if (test__start_subtest("kprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, false);
+	if (test__start_subtest("kretprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE, true, false);
+	if (test__start_subtest("fill_invalid_user_buff"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, true);
+	if (test__start_subtest("tracepoint_link_info"))
+		test_tp_fill_link_info(skel);
+
+	offset = get_uprobe_offset(&uprobe_func);
+	if (test__start_subtest("uprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE, offset, false);
+	if (test__start_subtest("uretprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE, offset, true);
+
+cleanup:
+	test_fill_link_info__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
new file mode 100644
index 0000000..f776134
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+SEC("kprobe")
+int BPF_PROG(kprobe_run)
+{
+	return 0;
+}
+
+SEC("uprobe")
+int BPF_PROG(uprobe_run)
+{
+	return 0;
+}
+
+SEC("tracepoint")
+int BPF_PROG(tp_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


