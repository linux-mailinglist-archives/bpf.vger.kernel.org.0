Return-Path: <bpf+bounces-68169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65198B53964
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BDC5A2447
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12B32A802;
	Thu, 11 Sep 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZZQ2x96"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDA34F476
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608440; cv=none; b=ciTXl28dF7J06MXanqWkkBvHsePeoSgrGWkM1HhNoCN0yLP4Ule2oLSOtuBDSwvAFw9YJ81zl/zjhnWbO8eVc+bHAMI+ZVy0afKc3XzXwC/GX6shAw0lU2sSiqPSJK6YSYYT6axatdAyMX+jXreZQK9JW75V88lfztTUtAcSdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608440; c=relaxed/simple;
	bh=Hlz86QcAg9HduWyQHFXfPxhaqsVy/NqL7LiZG41KJOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWlLulmpa7S+C2KRttUdpVZupNkeltASqWDw3fILProuZ4mUooH0ypT7krieTsuLIkCOohi/2zwhFXxkoWU9+LNpQAqAmYiX4RNi2Bdn9WsB6HkkZr6zvY6xakSFFLXgKwhpoQNK6zanNJm9fcH9UpiNSPEz0H3DTkFHuiFUn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZZQ2x96; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+ZDmEjjJLXoAmrlZvvTOPRQVRlyoah5ttAvk0PAh3k=;
	b=cZZQ2x96yBLorZMUgwrr6NFXZ9ACsQ/V4HK6Mj0qS4A6xZyL1GpFuAZezsnc9QvKiXeFnm
	v6WjT1B4ryGkmGp9GraYXefaeiDPNOKxxZf92vdaTv7uzkUZTdcVPnKpfKzR+LJ0MrTxpI
	mwVF39zJSfLjQHBNgokwKMeYYdomf6g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 6/6] selftests/bpf: Add cases to test map create failure log
Date: Fri, 12 Sep 2025 00:33:28 +0800
Message-ID: <20250911163328.93490-7-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-1-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As kernel is able to report log when fail to create map, add test cases
to check those logs.

cd tools/testing/selftests/bpf
./test_progs -t map_create_failure
191/1   map_create_failure/invalid_vmlinux_value_type_id:OK
191/2   map_create_failure/invalid_value_type_id:OK
191/3   map_create_failure/invalid_map_extra:OK
191/4   map_create_failure/invalid_numa_node:OK
191/5   map_create_failure/invalid_map_type:OK
191/6   map_create_failure/invalid_token_fd:OK
191/7   map_create_failure/invalid_map_name:OK
191/8   map_create_failure/invalid_btf_fd:OK
191     map_create_failure:OK
Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_init.c       | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 14a31109dd0e0..ee7c73f5700c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -212,3 +212,127 @@ void test_map_init(void)
 	if (test__start_subtest("pcpu_lru_map_init"))
 		test_pcpu_lru_map_init();
 }
+
+static void test_map_create(enum bpf_map_type map_type, const char *map_name,
+			    struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	char log_buf[128];
+	int fd;
+
+	log_buf[0] = '\0';
+	opts->log_buf = log_buf;
+	opts->log_size = sizeof(log_buf);
+	fd = bpf_map_create(map_type, map_name, 4, 4, 1, opts);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create"))
+		goto out;
+
+	ASSERT_STREQ(log_buf, exp_msg, "unexpected log_buf");
+out:
+	if (fd >= 0)
+		close(fd);
+}
+
+static void test_map_create_simple(struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test_map_create", opts, exp_msg);
+}
+
+static void test_invalid_vmlinux_value_type_id(void)
+{
+	const char *msg = "Invalid use of btf_vmlinux_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_vmlinux_value_type_id = 1,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+static void test_invalid_value_type_id(void)
+{
+	const char *msg = "Invalid btf_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_key_type_id = 1,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+static void test_invalid_map_extra(void)
+{
+	const char *msg = "Invalid map_extra.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_extra = 1,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+static void test_invalid_numa_node(void)
+{
+	const char *msg = "Invalid or offline numa_node.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NUMA_NODE,
+		    .numa_node = 0xFF,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+static void test_invalid_map_type(void)
+{
+	const char *msg = "Invalid map_type.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(__MAX_BPF_MAP_TYPE, "test_map_create", &opts, msg);
+}
+
+static void test_invalid_token_fd(void)
+{
+	const char *msg = "Invalid map_token_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_TOKEN_FD,
+		    .token_fd = 0xFF,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+static void test_invalid_map_name(void)
+{
+	const char *msg = "Invalid map_name.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test-!@#", &opts, msg);
+}
+
+static void test_invalid_btf_fd(void)
+{
+	const char *msg = "Invalid btf_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_fd = -1,
+		    .btf_key_type_id = 1,
+		    .btf_value_type_id = 1,
+	);
+
+	test_map_create_simple(&opts, msg);
+}
+
+void test_map_create_failure(void)
+{
+	if (test__start_subtest("invalid_vmlinux_value_type_id"))
+		test_invalid_vmlinux_value_type_id();
+	if (test__start_subtest("invalid_value_type_id"))
+		test_invalid_value_type_id();
+	if (test__start_subtest("invalid_map_extra"))
+		test_invalid_map_extra();
+	if (test__start_subtest("invalid_numa_node"))
+		test_invalid_numa_node();
+	if (test__start_subtest("invalid_map_type"))
+		test_invalid_map_type();
+	if (test__start_subtest("invalid_token_fd"))
+		test_invalid_token_fd();
+	if (test__start_subtest("invalid_map_name"))
+		test_invalid_map_name();
+	if (test__start_subtest("invalid_btf_fd"))
+		test_invalid_btf_fd();
+}
-- 
2.50.1


