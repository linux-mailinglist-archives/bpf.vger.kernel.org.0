Return-Path: <bpf+bounces-19890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383E832850
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EF5281117
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4B4C60F;
	Fri, 19 Jan 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us7E+DyT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861F4C602
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662363; cv=none; b=PgfdWoPFimvQyxczWA9SlJa525XFe0AlkaJ2FghvEiNzYGRYwHdsoPCfaGGjlYXSMI2wdPcxytXeOlnEMlUNWo2t+JHWQ37FskJ4PJHraSJVwKso6x6yGV30vwqUuFYhgFpxe1FpteHQXzQMKdaxvJl9RCkQRpEeF+qOEqC2IPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662363; c=relaxed/simple;
	bh=OavprCKKKpgkzngILy9HXhlHMcR+iu2fHqzSzcMBcbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXe7GLvia5hp0d/KLNpk+MDgj4i/qriWyh5qR3CbLrmVy60cKCD3Vmf1OE4TaPd5ln3FZTBwlXe1fIxdol4dqe80gLf5V8I+iCs71L9kNTQt2dkMI+WB+YlUNRcOJUO6UtmTYDylj3bI/Nx4/ljc4bANYKs2Yg/ChLeVbS+VBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us7E+DyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C465AC433C7;
	Fri, 19 Jan 2024 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662362;
	bh=OavprCKKKpgkzngILy9HXhlHMcR+iu2fHqzSzcMBcbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Us7E+DyTPIxzRB7tbmczJOYANYUMdqh/aQW1RrwRoznxT1CgYW7kIL85rRh5VxtZd
	 mXeMpzzapibt0k/gbwnVt6n4BBj0Bs/UNoIFnK7x2GWe+e4xaSy8jwpicfr+AFCGZl
	 xHZZRWFz3Wx98finVRW7rOOrv6u1PdxL10ENw4kRdXql2fT6uAt01tBr1xK1JLRK9M
	 8/Wj04xM1NJLuORYXUutfyY1D4Z5q2V2iIjRZ4fQ3KvGDrTsIApCn1q9tRbo4eM07I
	 VjwqeYhPa8z+xrO3YoohlU6UFIIMTg4nBsxCj8SUMccz8ymTRke91S5j/tAcK6lCNd
	 JCaO3vL0FNCgA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 4/8] selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
Date: Fri, 19 Jan 2024 12:05:01 +0100
Message-ID: <20240119110505.400573-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding cookies check for kprobe_multi fill_link_info test,
plus tests for invalid values related to cookies.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 48 ++++++++++++++-----
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index d4b1901f7879..2c2a02010c0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -19,6 +19,7 @@ static const char *kmulti_syms[] = {
 };
 #define KMULTI_CNT ARRAY_SIZE(kmulti_syms)
 static __u64 kmulti_addrs[KMULTI_CNT];
+static __u64 kmulti_cookies[] = { 3, 1, 2 };
 
 #define KPROBE_FUNC "bpf_fentry_test1"
 static __u64 kprobe_addr;
@@ -195,11 +196,11 @@ static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 	bpf_link__destroy(link);
 }
 
-static int verify_kmulti_link_info(int fd, bool retprobe)
+static int verify_kmulti_link_info(int fd, bool retprobe, bool has_cookies)
 {
+	__u64 addrs[KMULTI_CNT], cookies[KMULTI_CNT];
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
-	__u64 addrs[KMULTI_CNT];
 	int flags, i, err;
 
 	memset(&info, 0, sizeof(info));
@@ -221,18 +222,22 @@ static int verify_kmulti_link_info(int fd, bool retprobe)
 
 	if (!info.kprobe_multi.addrs) {
 		info.kprobe_multi.addrs = ptr_to_u64(addrs);
+		info.kprobe_multi.cookies = ptr_to_u64(cookies);
 		goto again;
 	}
-	for (i = 0; i < KMULTI_CNT; i++)
+	for (i = 0; i < KMULTI_CNT; i++) {
 		ASSERT_EQ(addrs[i], kmulti_addrs[i], "kmulti_addrs");
+		ASSERT_EQ(cookies[i], has_cookies ? kmulti_cookies[i] : 0,
+			  "kmulti_cookies_value");
+	}
 	return 0;
 }
 
 static void verify_kmulti_invalid_user_buffer(int fd)
 {
+	__u64 addrs[KMULTI_CNT], cookies[KMULTI_CNT];
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
-	__u64 addrs[KMULTI_CNT];
 	int err, i;
 
 	memset(&info, 0, sizeof(info));
@@ -266,7 +271,20 @@ static void verify_kmulti_invalid_user_buffer(int fd)
 	info.kprobe_multi.count = KMULTI_CNT;
 	info.kprobe_multi.addrs = 0x1; /* invalid addr */
 	err = bpf_link_get_info_by_fd(fd, &info, &len);
-	ASSERT_EQ(err, -EFAULT, "invalid_buff");
+	ASSERT_EQ(err, -EFAULT, "invalid_buff_addrs");
+
+	info.kprobe_multi.count = KMULTI_CNT;
+	info.kprobe_multi.addrs = ptr_to_u64(addrs);
+	info.kprobe_multi.cookies = 0x1; /* invalid addr */
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "invalid_buff_cookies");
+
+	/* cookies && !count */
+	info.kprobe_multi.count = 0;
+	info.kprobe_multi.addrs = ptr_to_u64(NULL);
+	info.kprobe_multi.cookies = ptr_to_u64(cookies);
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "invalid_cookies_count");
 }
 
 static int symbols_cmp_r(const void *a, const void *b)
@@ -278,13 +296,15 @@ static int symbols_cmp_r(const void *a, const void *b)
 }
 
 static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
-					     bool retprobe, bool invalid)
+					     bool retprobe, bool cookies,
+					     bool invalid)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	struct bpf_link *link;
 	int link_fd, err;
 
 	opts.syms = kmulti_syms;
+	opts.cookies = cookies ? kmulti_cookies : NULL;
 	opts.cnt = KMULTI_CNT;
 	opts.retprobe = retprobe;
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run, NULL, &opts);
@@ -293,7 +313,7 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
 
 	link_fd = bpf_link__fd(link);
 	if (!invalid) {
-		err = verify_kmulti_link_info(link_fd, retprobe);
+		err = verify_kmulti_link_info(link_fd, retprobe, cookies);
 		ASSERT_OK(err, "verify_kmulti_link_info");
 	} else {
 		verify_kmulti_invalid_user_buffer(link_fd);
@@ -523,12 +543,16 @@ void test_fill_link_info(void)
 	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);
 	for (i = 0; i < KMULTI_CNT; i++)
 		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
-	if (test__start_subtest("kprobe_multi_link_info"))
-		test_kprobe_multi_fill_link_info(skel, false, false);
-	if (test__start_subtest("kretprobe_multi_link_info"))
-		test_kprobe_multi_fill_link_info(skel, true, false);
+	if (test__start_subtest("kprobe_multi_link_info")) {
+		test_kprobe_multi_fill_link_info(skel, false, false, false);
+		test_kprobe_multi_fill_link_info(skel, false, true, false);
+	}
+	if (test__start_subtest("kretprobe_multi_link_info")) {
+		test_kprobe_multi_fill_link_info(skel, true, false, false);
+		test_kprobe_multi_fill_link_info(skel, true, true, false);
+	}
 	if (test__start_subtest("kprobe_multi_invalid_ubuff"))
-		test_kprobe_multi_fill_link_info(skel, true, true);
+		test_kprobe_multi_fill_link_info(skel, true, true, true);
 
 	if (test__start_subtest("uprobe_multi_link_info"))
 		test_uprobe_multi_fill_link_info(skel, false, false);
-- 
2.43.0


