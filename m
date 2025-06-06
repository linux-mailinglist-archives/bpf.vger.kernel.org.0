Return-Path: <bpf+bounces-59891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25003AD0715
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4333B3482
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB028A1E0;
	Fri,  6 Jun 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOQVHkuM"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74C289375;
	Fri,  6 Jun 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229130; cv=none; b=fLiRlPD5XPHCyvCpXWjynteMAwLEwjMtGSTjWmDGdhAmaHwkCG2UWl+BEr/84fLggkDFcuNeoiESC8vSe58Hp4LblxdETJbVtRzl2KnK5Z34ToQ/tPciPTzK+g0VtvjfZNa/SyeIEQEq6a2NlF630HY1HvGKcb7jDUrnh2xZD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229130; c=relaxed/simple;
	bh=2oB22RlAdelwXL/0ev/Z3gQPRBpTfwO+IvDL8z2ibaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJqCQ8gOagYmKkxFMhxe4NlnChJ/zwoDq4Ptl7g3lLqkpiwisLqak5eqWAsu2fjGj+PDKZOckwEpv8tW5Q1Q/mNTXHHJilDEumLcBO+s1CqVgyX71n9Kd/Uj85NQv8AMi3YxXecrUcgfmpCGuMpFHWx6LsVxcd0oroXTLTIDoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOQVHkuM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7O2ud3V4WEaTf3FLO9W1kkRGHRVawHEgYNCRiL+E2g=;
	b=EOQVHkuMeF1GsC0WpDxbyC0c3fVz6nIanJWXBH+HT+YOWjhgpoZd+Qid2XVGF67UHctLam
	G1q2gs/AE/lWz5YWZ4JZF/cH1vP5cid4PUmEVv6J4ECpzDXbNCGyr8LUASLeUuzoeFHYw2
	UJEEaRZvTD67GaUDPq+q77N6m3D871I=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next  2/5] selftests/bpf: Add cookies check for tracing fill_link_info test
Date: Sat,  7 Jun 2025 00:58:15 +0800
Message-Id: <20250606165818.3394397-2-chen.dylane@linux.dev>
In-Reply-To: <20250606165818.3394397-1-chen.dylane@linux.dev>
References: <20250606165818.3394397-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Adding tests for getting cookie with fill_link_info for tracing.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 0774ae6c1be..4a0670c056b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -489,10 +489,28 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
 
+static int verify_tracing_link_info(int fd, u64 cookie)
+{
+	struct bpf_link_info info;
+	int err;
+	u32 len = sizeof(info);
+
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_TRACING, "link_type"))
+		return -1;
+
+	ASSERT_EQ(info.tracing.cookie, cookie, "tracing_cookie");
+
+	return 0;
+}
+
 static void tracing_subtest(struct test_bpf_cookie *skel)
 {
 	__u64 cookie;
-	int prog_fd;
+	int prog_fd, err;
 	int fentry_fd = -1, fexit_fd = -1, fmod_ret_fd = -1;
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
@@ -507,6 +525,10 @@ static void tracing_subtest(struct test_bpf_cookie *skel)
 	if (!ASSERT_GE(fentry_fd, 0, "fentry.link_create"))
 		goto cleanup;
 
+	err = verify_tracing_link_info(fentry_fd, cookie);
+	if (!ASSERT_OK(err, "verify_tracing_link_info"))
+		goto cleanup;
+
 	cookie = 0x20000000000000L;
 	prog_fd = bpf_program__fd(skel->progs.fexit_test1);
 	link_opts.tracing.cookie = cookie;
-- 
2.43.0


