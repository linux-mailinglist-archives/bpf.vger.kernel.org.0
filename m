Return-Path: <bpf+bounces-7513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D021C778587
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4176A281C02
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F62EBF;
	Fri, 11 Aug 2023 02:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEDEA9
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 02:36:55 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411F171D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-563f752774fso1014598a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721414; x=1692326214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txHdwRA6CmFO169hbAMxW9lYuqVfmYVhpA70RC0DeFg=;
        b=iaPh6NQlo5ehWihyDc/usuWb6fDuYFMU2u+UIHfnQ4pAcLlWYsxjTGmN81+B9IRtpK
         d8XtOZT1T38omBv4ULLMmYcXhvEaixQlDl5OYsAdSqnsxxUtDnjP0rIK2ggqE2PXEf08
         JRW6m9LHys9fWi2icuTDSIHbKUlzroDLxxrVEI8+RAlP9PBFr/wdWB/1iWuvUEQ1RN4f
         2liARaUFZgS7YkJuUhYBR/C5NVgThVXwfWI8cknj/NEXuigl8eS6Gmjx9G9/JRlC8hNy
         4uI8nlGS15E+j7UnM47Q6C622AhtHRH9tJmgBXTLd+QuiXXHeZDWMPm688aesS+8bcSF
         j8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721414; x=1692326214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txHdwRA6CmFO169hbAMxW9lYuqVfmYVhpA70RC0DeFg=;
        b=I7twRQkrK3ruklu5eECX6jJhcX769WIdllrpdAa6j6oD1dXTXHKRpLUv87bJbSd1Kn
         vboWJQ+oJkv/3IPKsz+cVvhfbFRelekd6rF/smgJeF7ntjnYwg6h+AheXe0eZKAWPxcy
         2EHykZYdq9t2jCftn1NEiV5o3YE0cczyseJejmUWHf63dwBlQTNgc9Wp+q5engPHPlQa
         GRF7CXn5RTXmyWfHiMtdNUBOoA0HEgsamzLvw7WWBNjBiP+5NVcZvIjIocrBwgFG2Ge8
         fBKyXSkBg++8w48qnZViKPN7lNibxr/xZwweHYh+OX5IGnyMeQpCJe+VJAeuCLCQarWU
         8jUg==
X-Gm-Message-State: AOJu0YyBM5lL4+S/uxcIRvG2GeNHjU5km7I41AIpUSNYeedaoR9X0YMI
	Snw5kfy8N8FN0fhXX+Mr8+I=
X-Google-Smtp-Source: AGHT+IHmOXm0LhLYvkstQkjENHNWjglYKcLIz9K/x6ZziObYyV1LKzQr0aKpOngkBI5LXZVysRniSg==
X-Received: by 2002:a05:6a20:5499:b0:11f:2714:f6f3 with SMTP id i25-20020a056a20549900b0011f2714f6f3mr913541pzk.11.1691721413626;
        Thu, 10 Aug 2023 19:36:53 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:925:5400:4ff:fe89:58d6])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm1038304plb.265.2023.08.10.19.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:36:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for fill_link_info
Date: Fri, 11 Aug 2023 02:36:47 +0000
Message-Id: <20230811023647.3711-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230811023647.3711-1-laoar.shao@gmail.com>
References: <20230811023647.3711-1-laoar.shao@gmail.com>
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

Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
The result:

  $ tools/testing/selftests/bpf/test_progs --name=fill_link_info
  #79/1    fill_link_info/kprobe_link_info:OK
  #79/2    fill_link_info/kretprobe_link_info:OK
  #79/3    fill_link_info/kprobe_invalid_ubuff:OK
  #79/4    fill_link_info/tracepoint_link_info:OK
  #79/5    fill_link_info/uprobe_link_info:OK
  #79/6    fill_link_info/uretprobe_link_info:OK
  #79/7    fill_link_info/kprobe_multi_link_info:OK
  #79/8    fill_link_info/kretprobe_multi_link_info:OK
  #79/9    fill_link_info/kprobe_multi_invalid_ubuff:OK
  #79      fill_link_info:OK
  Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

The test case for kprobe_multi won't be run on aarch64, as it is not
supported.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
 .../selftests/bpf/prog_tests/fill_link_info.c      | 342 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 3 files changed, 387 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 3b61e8b..b2f46b6 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # libbpf: failed to load BPF sk
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
 fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
 fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
+fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+fill_link_info/kprobe_multi_ubuff                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
new file mode 100644
index 0000000..9d768e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -0,0 +1,342 @@
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
+
+static const char *kmulti_syms[] = {
+	"bpf_fentry_test2",
+	"bpf_fentry_test1",
+	"bpf_fentry_test3",
+};
+#define KMULTI_CNT ARRAY_SIZE(kmulti_syms)
+static __u64 kmulti_addrs[KMULTI_CNT];
+
+#define KPROBE_FUNC "bpf_fentry_test1"
+static __u64 kprobe_addr;
+
+#define UPROBE_FILE "/proc/self/exe"
+static ssize_t uprobe_offset;
+/* uprobe attach point */
+static noinline void uprobe_func(void)
+{
+	asm volatile ("");
+}
+
+static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long addr,
+				 ssize_t offset, ssize_t entry_offset)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	char buf[PATH_MAX];
+	int err;
+
+	memset(&info, 0, sizeof(info));
+	buf[0] = '\0';
+
+again:
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "link_type"))
+		return -1;
+	if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_match"))
+		return -1;
+
+	switch (info.perf_event.type) {
+	case BPF_PERF_EVENT_KPROBE:
+	case BPF_PERF_EVENT_KRETPROBE:
+		ASSERT_EQ(info.perf_event.kprobe.offset, offset, "kprobe_offset");
+
+		/* In case kernel.kptr_restrict is not permitted or MAX_SYMS is reached */
+		if (addr)
+			ASSERT_EQ(info.perf_event.kprobe.addr, addr + entry_offset,
+				  "kprobe_addr");
+
+		if (!info.perf_event.kprobe.func_name) {
+			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
+			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
+			info.perf_event.kprobe.name_len = sizeof(buf);
+			goto again;
+		}
+
+		err = strncmp(u64_to_ptr(info.perf_event.kprobe.func_name), KPROBE_FUNC,
+			      strlen(KPROBE_FUNC));
+		ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
+		break;
+	case BPF_PERF_EVENT_TRACEPOINT:
+		if (!info.perf_event.tracepoint.tp_name) {
+			ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
+			info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
+			info.perf_event.tracepoint.name_len = sizeof(buf);
+			goto again;
+		}
+
+		err = strncmp(u64_to_ptr(info.perf_event.tracepoint.tp_name), TP_NAME,
+			      strlen(TP_NAME));
+		ASSERT_EQ(err, 0, "cmp_tp_name");
+		break;
+	case BPF_PERF_EVENT_UPROBE:
+	case BPF_PERF_EVENT_URETPROBE:
+		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
+
+		if (!info.perf_event.uprobe.file_name) {
+			ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
+			info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
+			info.perf_event.uprobe.name_len = sizeof(buf);
+			goto again;
+		}
+
+		err = strncmp(u64_to_ptr(info.perf_event.uprobe.file_name), UPROBE_FILE,
+			      strlen(UPROBE_FILE));
+			ASSERT_EQ(err, 0, "cmp_file_name");
+		break;
+	default:
+		err = -1;
+		break;
+	}
+	return err;
+}
+
+static void kprobe_fill_invalid_user_buffer(int fd)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err;
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
+				       bool invalid)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
+		.attach_mode = PROBE_ATTACH_MODE_LINK,
+		.retprobe = type == BPF_PERF_EVENT_KRETPROBE,
+	);
+	ssize_t entry_offset = 0;
+	int link_fd, err;
+
+	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
+								 KPROBE_FUNC, &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.kprobe_run);
+	if (!invalid) {
+		/* See also arch_adjust_kprobe_addr(). */
+		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
+			entry_offset = 4;
+		err = verify_perf_link_info(link_fd, type, kprobe_addr, 0, entry_offset);
+		ASSERT_OK(err, "verify_perf_link_info");
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
+	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
+	ASSERT_OK(err, "verify_perf_link_info");
+	bpf_link__detach(skel->links.tp_run);
+}
+
+static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
+				       enum bpf_perf_event_type type)
+{
+	int link_fd, err;
+
+	skel->links.uprobe_run = bpf_program__attach_uprobe(skel->progs.uprobe_run,
+							    type == BPF_PERF_EVENT_URETPROBE,
+							    0, /* self pid */
+							    UPROBE_FILE, uprobe_offset);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.uprobe_run);
+	err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0);
+	ASSERT_OK(err, "verify_perf_link_info");
+	bpf_link__detach(skel->links.uprobe_run);
+}
+
+static int verify_kmulti_link_info(int fd, bool retprobe)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	__u64 addrs[KMULTI_CNT];
+	int flags, i, err;
+
+	memset(&info, 0, sizeof(info));
+
+again:
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_KPROBE_MULTI, "kmulti_type"))
+		return -1;
+
+	ASSERT_EQ(info.kprobe_multi.count, KMULTI_CNT, "func_cnt");
+	flags = info.kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN;
+	if (!retprobe)
+		ASSERT_EQ(flags, 0, "kmulti_flags");
+	else
+		ASSERT_NEQ(flags, 0, "kretmulti_flags");
+
+	if (!info.kprobe_multi.addrs) {
+		info.kprobe_multi.addrs = ptr_to_u64(addrs);
+		goto again;
+	}
+	for (i = 0; i < KMULTI_CNT; i++)
+		ASSERT_EQ(addrs[i], kmulti_addrs[i], "kmulti_addrs");
+	return 0;
+}
+
+static void verify_kmulti_invalid_user_buffer(int fd)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	__u64 addrs[KMULTI_CNT];
+	int err, i;
+
+	memset(&info, 0, sizeof(info));
+
+	info.kprobe_multi.count = KMULTI_CNT;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "no_addr");
+
+	info.kprobe_multi.addrs = ptr_to_u64(addrs);
+	info.kprobe_multi.count = 0;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "no_cnt");
+
+	for (i = 0; i < KMULTI_CNT; i++)
+		addrs[i] = 0;
+	info.kprobe_multi.count = KMULTI_CNT - 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -ENOSPC, "smaller_cnt");
+	for (i = 0; i < KMULTI_CNT - 1; i++)
+		ASSERT_EQ(addrs[i], kmulti_addrs[i], "kmulti_addrs");
+	ASSERT_EQ(addrs[i], 0, "kmulti_addrs");
+
+	for (i = 0; i < KMULTI_CNT; i++)
+		addrs[i] = 0;
+	info.kprobe_multi.count = KMULTI_CNT + 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, 0, "bigger_cnt");
+	for (i = 0; i < KMULTI_CNT; i++)
+		ASSERT_EQ(addrs[i], kmulti_addrs[i], "kmulti_addrs");
+
+	info.kprobe_multi.count = KMULTI_CNT;
+	info.kprobe_multi.addrs = 0x1; /* invalid addr */
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "invalid_buff");
+}
+
+static int symbols_cmp_r(const void *a, const void *b)
+{
+	const char **str_a = (const char **) a;
+	const char **str_b = (const char **) b;
+
+	return strcmp(*str_a, *str_b);
+}
+
+static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
+					     bool retprobe, bool invalid)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	int link_fd, err;
+
+	opts.syms = kmulti_syms;
+	opts.cnt = KMULTI_CNT;
+	opts.retprobe = retprobe;
+	skel->links.kmulti_run = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run,
+								       NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.kmulti_run);
+	if (!invalid) {
+		err = verify_kmulti_link_info(link_fd, retprobe);
+		ASSERT_OK(err, "verify_kmulti_link_info");
+	} else {
+		verify_kmulti_invalid_user_buffer(link_fd);
+	}
+	bpf_link__detach(skel->links.kmulti_run);
+}
+
+void test_fill_link_info(void)
+{
+	struct test_fill_link_info *skel;
+	int i;
+
+	skel = test_fill_link_info__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* load kallsyms to compare the addr */
+	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+		goto cleanup;
+
+	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
+	if (test__start_subtest("kprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false);
+	if (test__start_subtest("kretprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE, false);
+	if (test__start_subtest("kprobe_invalid_ubuff"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, true);
+	if (test__start_subtest("tracepoint_link_info"))
+		test_tp_fill_link_info(skel);
+
+	uprobe_offset = get_uprobe_offset(&uprobe_func);
+	if (test__start_subtest("uprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE);
+	if (test__start_subtest("uretprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE);
+
+	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);
+	for (i = 0; i < KMULTI_CNT; i++)
+		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
+	if (test__start_subtest("kprobe_multi_link_info"))
+		test_kprobe_multi_fill_link_info(skel, false, false);
+	if (test__start_subtest("kretprobe_multi_link_info"))
+		test_kprobe_multi_fill_link_info(skel, true, false);
+	if (test__start_subtest("kprobe_multi_invalid_ubuff"))
+		test_kprobe_multi_fill_link_info(skel, true, true);
+
+cleanup:
+	test_fill_link_info__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
new file mode 100644
index 0000000..564f402
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+
+/* This function is here to have CONFIG_X86_KERNEL_IBT
+ * used and added to object BTF.
+ */
+int unused(void)
+{
+	return CONFIG_X86_KERNEL_IBT ? 0 : 1;
+}
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
+SEC("kprobe.multi")
+int BPF_PROG(kmulti_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


