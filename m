Return-Path: <bpf+bounces-59514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A92AACCA73
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7DA170DCD
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2B165F16;
	Tue,  3 Jun 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UN/w+TX/"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFC23E329
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965408; cv=none; b=SW0vhS8h5wzWYrWyKDDeghw1T0F0SMLXtYLHm36hb77TWfD8B68X6cDgK1AahCPHKs07qRvBFupOlBK9P1cYl4NBgdgd0W0FpN9QuGbHvc90YTGKD36bZjggTRfRjNCvqUZddKqlvj2n9qCrSROk31edhK9ULJ2Hw+fJRh1rNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965408; c=relaxed/simple;
	bh=yeEgVOeRQBohMakSW24/fjiAKV1LjwRVUheQ3bT1sw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hFoi3mjGYNDokcKIV7TJIjtKy71ElGq/JU0PWRcfMqcJXfAabG2BO3KDhSQKN+G6M69PHjAdyYoF8AY7CwkFO2w1KCXzYNKC4WWmsbDH8Qk8oPvyoFxu5JgVLKY6x3ioL7JbST6fUsNtsVEYqlhMRUcdI3rrv40K+JQszprsTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UN/w+TX/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748965403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saGKRi85LZc20gmcf12rdr16DABtpgnG05FQgFGbqJI=;
	b=UN/w+TX/QhMUAAnyiSqJyEXjzHi1ZMVhnLSfy0Y/Y6c13Ial9MHGl1ayoIyF3tF9UfPeGu
	EB1qCdIkNeymtaF46YbKpEjmEQVJxfceU+5ziYfX2lXk1RUdmLHaRXpI43vQCljEWmhj7J
	grtiF9w86xaERTlsE0GbxJMaIgORM+8=
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
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Add cookies check for raw_tp fill_link_info test
Date: Tue,  3 Jun 2025 23:43:08 +0800
Message-Id: <20250603154309.3063644-2-chen.dylane@linux.dev>
In-Reply-To: <20250603154309.3063644-1-chen.dylane@linux.dev>
References: <20250603154309.3063644-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Adding tests for getting cookie with fill_link_info for raw_tp.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 6befa87043..0774ae6c1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -635,10 +635,29 @@ static void tp_btf_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
 
+static int verify_raw_tp_link_info(int fd, u64 cookie)
+{
+	struct bpf_link_info info;
+	int err;
+	u32 len = sizeof(info);
+
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_RAW_TRACEPOINT, "link_type"))
+		return -1;
+
+	ASSERT_EQ(info.raw_tracepoint.cookie, cookie, "raw_tp_cookie");
+
+	return 0;
+}
+
 static void raw_tp_subtest(struct test_bpf_cookie *skel)
 {
 	__u64 cookie;
-	int prog_fd, link_fd = -1;
+	int err, prog_fd, link_fd = -1;
 	struct bpf_link *link = NULL;
 	LIBBPF_OPTS(bpf_raw_tp_opts, raw_tp_opts);
 	LIBBPF_OPTS(bpf_raw_tracepoint_opts, opts);
@@ -656,6 +675,11 @@ static void raw_tp_subtest(struct test_bpf_cookie *skel)
 		goto cleanup;
 
 	usleep(1); /* trigger */
+
+	err = verify_raw_tp_link_info(link_fd, cookie);
+	if (!ASSERT_OK(err, "verify_raw_tp_link_info"))
+		goto cleanup;
+
 	close(link_fd); /* detach */
 	link_fd = -1;
 
-- 
2.43.0


