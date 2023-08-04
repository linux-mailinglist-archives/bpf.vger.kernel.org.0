Return-Path: <bpf+bounces-6983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3E76FF18
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121F8282455
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA06AD4E;
	Fri,  4 Aug 2023 10:57:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07331AD3C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:57:54 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA534EE5
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 03:57:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc02bd4eafso16619735ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691146659; x=1691751459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfnvIH26QYz2Hc6LeF/jtZ5lbt9X7zEMh1y6gmkxK5I=;
        b=lJwmXbp1LHXYsP6Rbbg4mmkyB7HLy0bCl0J03pJzu2hXxCq/eNW69lhHu8etRu3gcQ
         w45CiI/6jve5JnEEIBXavVuU4iH1at7qy8P2tTCUx8yOh160/9vvommHqK2w0BefP/nc
         fr4KLPdBqiDY2zrzqZ8I/7/LPiacTKv8L8jWoq1Whg2chda/M33F6GVjl5YNMXDfYeUE
         qEeTfw5ixB1BxK6rLedcejWgj991iDddeWGDWYEhuguEZ3pB5G3Cxd6vCGS3hz+61PeC
         bueV8anhb5txnDuB4ucSuJ1vXKUj9SVQ0C9V71l3Em2aSK+9jq+rFg24Y+FxsUSLJFRJ
         G+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691146659; x=1691751459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfnvIH26QYz2Hc6LeF/jtZ5lbt9X7zEMh1y6gmkxK5I=;
        b=bwo5xLelml60QOp3cigPF7K+ju+nFQtFkTU6YGWwDl3DdoB6pRSg3VMOUdtK4msWoF
         ZjvFswEoVxJYxx9RYaeYgToFYK8yM2dS9pKeAJ8ZiQQGd6ukM0MCCI+6blKs/XPRhF25
         +rkcrLnydIbBOV/q3fpuqBam/inUKahrjG+etBFWWf30uOC0To1VZ8B/dmejT1eyd989
         ic8XjNqbv8CI8quNlMqp3m0T/O4w/99UkRmbljbPcZ2PJrAADVDHQcFK/gpss0j4x0S3
         SPAoaRwinXPnhQ90YJXR5lnQaY3fbPSIhNgcB55WygVIomQJcFcPpsJAzZ7IWw2oOJ2z
         R9oA==
X-Gm-Message-State: AOJu0YwCDjuAfu61H8cv2AoWtK2bfAdDgOw/zDVOxttdwrFAHaKeyeS1
	Qn5yS8RJe17zJGiDDuagictraTYwTPkYWafIz04=
X-Google-Smtp-Source: AGHT+IEqPMKeaq7dtzv55iVBbSFm+O/h8jNI2hHSPsSIxY1Iq8xJN+IWTY94C4pruxnJ3OV4GzcX/w==
X-Received: by 2002:a17:903:41c8:b0:1bb:cf58:531d with SMTP id u8-20020a17090341c800b001bbcf58531dmr1549364ple.10.1691146658944;
        Fri, 04 Aug 2023 03:57:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:c27:5400:4ff:fe87:9943])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001b850c9d7b3sm1457691pls.249.2023.08.04.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:57:38 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
Date: Fri,  4 Aug 2023 10:57:32 +0000
Message-Id: <20230804105732.3768-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230804105732.3768-1-laoar.shao@gmail.com>
References: <20230804105732.3768-1-laoar.shao@gmail.com>
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
  #79/3    fill_link_info/kprobe_fill_invalid_user_buff:OK
  #79/4    fill_link_info/tracepoint_link_info:OK
  #79/5    fill_link_info/uprobe_link_info:OK
  #79/6    fill_link_info/uretprobe_link_info:OK
  #79/7    fill_link_info/kprobe_multi_link_info:OK
  #79/8    fill_link_info/kretprobe_multi_link_info:OK
  #79/9    fill_link_info/kprobe_multi_ubuff:OK
  #79      fill_link_info:OK
  Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

The test case for kprobe_multi won't be run on aarch64, as it is not
supported.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
 .../selftests/bpf/prog_tests/fill_link_info.c      | 337 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 3 files changed, 382 insertions(+)
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
index 0000000..001a8b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -0,0 +1,337 @@
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
+#define KMULTI_CNT (4)
+
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
+				       bool retprobe, bool invalid)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
+		.attach_mode = PROBE_ATTACH_MODE_LINK,
+		.retprobe = retprobe,
+	);
+	ssize_t offset = 0, entry_offset = 0;
+	int link_fd, err;
+	long addr;
+
+	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
+								 KPROBE_FUNC, &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.kprobe_run);
+	addr = ksym_get_addr(KPROBE_FUNC);
+	if (!invalid) {
+		/* See also arch_adjust_kprobe_addr(). */
+		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
+			entry_offset = 4;
+		err = verify_perf_link_info(link_fd, type, addr, offset, entry_offset);
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
+	err = verify_perf_link_info(link_fd, type, 0, offset, 0);
+	ASSERT_OK(err, "verify_perf_link_info");
+	bpf_link__detach(skel->links.uprobe_run);
+}
+
+static int verify_kmulti_link_info(int fd, const __u64 *addrs, bool retprobe)
+{
+	__u64 kmulti_addrs[KMULTI_CNT];
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int flags, i, err = 0;
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
+		info.kprobe_multi.addrs = ptr_to_u64(kmulti_addrs);
+		goto again;
+	}
+	for (i = 0; i < KMULTI_CNT; i++)
+		ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addrs");
+	return 0;
+}
+
+static void verify_kmulti_user_buffer(int fd, const __u64 *addrs)
+{
+	__u64 kmulti_addrs[KMULTI_CNT];
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err, i;
+
+	memset(&info, 0, sizeof(info));
+
+	info.kprobe_multi.count = KMULTI_CNT;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "no_addr");
+
+	info.kprobe_multi.addrs = ptr_to_u64(kmulti_addrs);
+	info.kprobe_multi.count = 0;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "no_cnt");
+
+	for (i = 0; i < KMULTI_CNT; i++)
+		kmulti_addrs[i] = 0;
+	info.kprobe_multi.count = KMULTI_CNT - 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -ENOSPC, "smaller_cnt");
+	for (i = 0; i < KMULTI_CNT - 1; i++)
+		ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addrs");
+	ASSERT_EQ(kmulti_addrs[i], 0, "kmulti_addrs");
+
+	for (i = 0; i < KMULTI_CNT; i++)
+		kmulti_addrs[i] = 0;
+	info.kprobe_multi.count = KMULTI_CNT + 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, 0, "bigger_cnt");
+	for (i = 0; i < KMULTI_CNT; i++)
+		ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addrs");
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
+					     bool retprobe, bool buffer)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *syms[KMULTI_CNT] = {
+		"schedule_timeout_interruptible",
+		"schedule_timeout_uninterruptible",
+		"schedule_timeout_idle",
+		"schedule_timeout_killable",
+	};
+	__u64 addrs[KMULTI_CNT];
+	int link_fd, i, err = 0;
+
+	qsort(syms, KMULTI_CNT, sizeof(syms[0]), symbols_cmp_r);
+	opts.syms = syms;
+	opts.cnt = KMULTI_CNT;
+	opts.retprobe = retprobe;
+	skel->links.kmulti_run = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run,
+								       NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi"))
+		return;
+
+	link_fd = bpf_link__fd(skel->links.kmulti_run);
+	for (i = 0; i < KMULTI_CNT; i++)
+		addrs[i] = ksym_get_addr(syms[i]);
+
+	if (!buffer)
+		err = verify_kmulti_link_info(link_fd, addrs, retprobe);
+	else
+		verify_kmulti_user_buffer(link_fd, addrs);
+	ASSERT_OK(err, "verify_kmulti_link_info");
+	bpf_link__detach(skel->links.kmulti_run);
+}
+
+void test_fill_link_info(void)
+{
+	struct test_fill_link_info *skel;
+	ssize_t offset;
+
+	skel = test_fill_link_info__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* load kallsyms to compare the addr */
+	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+		goto cleanup;
+	if (test__start_subtest("kprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, false);
+	if (test__start_subtest("kretprobe_link_info"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE, true, false);
+	if (test__start_subtest("kprobe_fill_invalid_user_buff"))
+		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false, true);
+	if (test__start_subtest("tracepoint_link_info"))
+		test_tp_fill_link_info(skel);
+
+	offset = get_uprobe_offset(&uprobe_func);
+	if (test__start_subtest("uprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE, offset, false);
+	if (test__start_subtest("uretprobe_link_info"))
+		test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE, offset, true);
+	if (test__start_subtest("kprobe_multi_link_info"))
+		test_kprobe_multi_fill_link_info(skel, false, false);
+	if (test__start_subtest("kretprobe_multi_link_info"))
+		test_kprobe_multi_fill_link_info(skel, true, false);
+	if (test__start_subtest("kprobe_multi_ubuff"))
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


