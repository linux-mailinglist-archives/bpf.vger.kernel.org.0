Return-Path: <bpf+bounces-15847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8817F8DF8
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7179E281544
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F20D2F865;
	Sat, 25 Nov 2023 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXKGcU7N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BD28E03
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 19:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1371C433C7;
	Sat, 25 Nov 2023 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940750;
	bh=2QaKHoyBJs4djbH53+lZMwd1NJU3YKbGecfvU5t+4oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXKGcU7NlBY7hIZ8/uMS5UdXKC8SUV/Q/GnN5gU91FNsl2w59AFQLHHr5k9sqEYwo
	 brpVuVcVGJgQR1/yD/JjsUEW61GdCdzoi1S+3d6z97RqJ+qvbjHb5RHxwue/Bl+Zaf
	 ovlh9+32YHA7t8nPlzT2sToLL1nF+7kIAmuRdcVmkY/qCVciu4++dfyPpi7kv6meDy
	 XXczLEUkXNjN7YvejSLOcBFkeTfAhDyVyg2xatiz/Aj62KOH2RV42eXBQVaql9W/YF
	 n2vX2RSPP+/MMC/AiLKqH6UaZE48N5IbkaTMEoXkytV9BRSc7ksJqpt/Fj8jR6v8EG
	 GqL3CbL5Lhahg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv4 bpf-next 5/6] selftests/bpf: Add link_info test for uprobe_multi link
Date: Sat, 25 Nov 2023 20:31:29 +0100
Message-ID: <20231125193130.834322-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125193130.834322-1-jolsa@kernel.org>
References: <20231125193130.834322-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding fill_link_info test for uprobe_multi link.

Setting up uprobes with bogus ref_ctr_offsets and cookie values
to test all the bpf_link_info::uprobe_multi fields.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 198 ++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c |   6 +
 2 files changed, 204 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 9294cb8d7743..d4b1901f7879 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -7,6 +7,7 @@
 #include <test_progs.h>
 #include "trace_helpers.h"
 #include "test_fill_link_info.skel.h"
+#include "bpf/libbpf_internal.h"
 
 #define TP_CAT "sched"
 #define TP_NAME "sched_switch"
@@ -300,6 +301,196 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
 	bpf_link__destroy(link);
 }
 
+#define SEC(name) __attribute__((section(name), used))
+
+static short uprobe_link_info_sema_1 SEC(".probes");
+static short uprobe_link_info_sema_2 SEC(".probes");
+static short uprobe_link_info_sema_3 SEC(".probes");
+
+noinline void uprobe_link_info_func_1(void)
+{
+	asm volatile ("");
+	uprobe_link_info_sema_1++;
+}
+
+noinline void uprobe_link_info_func_2(void)
+{
+	asm volatile ("");
+	uprobe_link_info_sema_2++;
+}
+
+noinline void uprobe_link_info_func_3(void)
+{
+	asm volatile ("");
+	uprobe_link_info_sema_3++;
+}
+
+static int
+verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
+			__u64 *cookies, __u64 *ref_ctr_offsets)
+{
+	char path[PATH_MAX], path_buf[PATH_MAX];
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	__u64 ref_ctr_offsets_buf[3];
+	__u64 offsets_buf[3];
+	__u64 cookies_buf[3];
+	int i, err, bit;
+	__u32 count = 0;
+
+	memset(path, 0, sizeof(path));
+	err = readlink("/proc/self/exe", path, sizeof(path));
+	if (!ASSERT_NEQ(err, -1, "readlink"))
+		return -1;
+
+	for (bit = 0; bit < 8; bit++) {
+		memset(&info, 0, sizeof(info));
+		info.uprobe_multi.path = ptr_to_u64(path_buf);
+		info.uprobe_multi.path_size = sizeof(path_buf);
+		info.uprobe_multi.count = count;
+
+		if (bit & 0x1)
+			info.uprobe_multi.offsets = ptr_to_u64(offsets_buf);
+		if (bit & 0x2)
+			info.uprobe_multi.cookies = ptr_to_u64(cookies_buf);
+		if (bit & 0x4)
+			info.uprobe_multi.ref_ctr_offsets = ptr_to_u64(ref_ctr_offsets_buf);
+
+		err = bpf_link_get_info_by_fd(fd, &info, &len);
+		if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+			return -1;
+
+		if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_UPROBE_MULTI, "info.type"))
+			return -1;
+
+		ASSERT_EQ(info.uprobe_multi.pid, getpid(), "info.uprobe_multi.pid");
+		ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
+		ASSERT_EQ(info.uprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
+			  retprobe, "info.uprobe_multi.flags.retprobe");
+		ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1, "info.uprobe_multi.path_size");
+		ASSERT_STREQ(path_buf, path, "info.uprobe_multi.path");
+
+		for (i = 0; i < info.uprobe_multi.count; i++) {
+			if (info.uprobe_multi.offsets)
+				ASSERT_EQ(offsets_buf[i], offsets[i], "info.uprobe_multi.offsets");
+			if (info.uprobe_multi.cookies)
+				ASSERT_EQ(cookies_buf[i], cookies[i], "info.uprobe_multi.cookies");
+			if (info.uprobe_multi.ref_ctr_offsets) {
+				ASSERT_EQ(ref_ctr_offsets_buf[i], ref_ctr_offsets[i],
+					  "info.uprobe_multi.ref_ctr_offsets");
+			}
+		}
+		count = count ?: info.uprobe_multi.count;
+	}
+
+	return 0;
+}
+
+static void verify_umulti_invalid_user_buffer(int fd)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	__u64 buf[3];
+	int err;
+
+	/* upath_size defined, not path */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.path_size = 3;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "failed_upath_size");
+
+	/* path defined, but small */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.path = ptr_to_u64(buf);
+	info.uprobe_multi.path_size = 3;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_LT(err, 0, "failed_upath_small");
+
+	/* path has wrong pointer */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.path_size = PATH_MAX;
+	info.uprobe_multi.path = 123;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "failed_bad_path_ptr");
+
+	/* count zero, with offsets */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.offsets = ptr_to_u64(buf);
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "failed_count");
+
+	/* offsets not big enough */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.offsets = ptr_to_u64(buf);
+	info.uprobe_multi.count = 2;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -ENOSPC, "failed_small_count");
+
+	/* offsets has wrong pointer */
+	memset(&info, 0, sizeof(info));
+	info.uprobe_multi.offsets = 123;
+	info.uprobe_multi.count = 3;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "failed_wrong_offsets");
+}
+
+static void test_uprobe_multi_fill_link_info(struct test_fill_link_info *skel,
+					     bool retprobe, bool invalid)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.retprobe = retprobe,
+	);
+	const char *syms[3] = {
+		"uprobe_link_info_func_1",
+		"uprobe_link_info_func_2",
+		"uprobe_link_info_func_3",
+	};
+	__u64 cookies[3] = {
+		0xdead,
+		0xbeef,
+		0xcafe,
+	};
+	const char *sema[3] = {
+		"uprobe_link_info_sema_1",
+		"uprobe_link_info_sema_2",
+		"uprobe_link_info_sema_3",
+	};
+	__u64 *offsets = NULL, *ref_ctr_offsets;
+	struct bpf_link *link;
+	int link_fd, err;
+
+	err = elf_resolve_syms_offsets("/proc/self/exe", 3, sema,
+				       (unsigned long **) &ref_ctr_offsets, STT_OBJECT);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_object"))
+		return;
+
+	err = elf_resolve_syms_offsets("/proc/self/exe", 3, syms,
+				       (unsigned long **) &offsets, STT_FUNC);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_func"))
+		goto out;
+
+	opts.syms = syms;
+	opts.cookies = &cookies[0];
+	opts.ref_ctr_offsets = (unsigned long *) &ref_ctr_offsets[0];
+	opts.cnt = ARRAY_SIZE(syms);
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.umulti_run, 0,
+						"/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto out;
+
+	link_fd = bpf_link__fd(link);
+	if (invalid)
+		verify_umulti_invalid_user_buffer(link_fd);
+	else
+		verify_umulti_link_info(link_fd, retprobe, offsets, cookies, ref_ctr_offsets);
+
+	bpf_link__destroy(link);
+out:
+	free(ref_ctr_offsets);
+	free(offsets);
+}
+
 void test_fill_link_info(void)
 {
 	struct test_fill_link_info *skel;
@@ -339,6 +530,13 @@ void test_fill_link_info(void)
 	if (test__start_subtest("kprobe_multi_invalid_ubuff"))
 		test_kprobe_multi_fill_link_info(skel, true, true);
 
+	if (test__start_subtest("uprobe_multi_link_info"))
+		test_uprobe_multi_fill_link_info(skel, false, false);
+	if (test__start_subtest("uretprobe_multi_link_info"))
+		test_uprobe_multi_fill_link_info(skel, true, false);
+	if (test__start_subtest("uprobe_multi_invalid"))
+		test_uprobe_multi_fill_link_info(skel, false, true);
+
 cleanup:
 	test_fill_link_info__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 564f402d56fe..69509f8bb680 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -39,4 +39,10 @@ int BPF_PROG(kmulti_run)
 	return 0;
 }
 
+SEC("uprobe.multi")
+int BPF_PROG(umulti_run)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.0


