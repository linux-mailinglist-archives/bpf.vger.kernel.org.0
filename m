Return-Path: <bpf+bounces-55969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A0A8A436
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBAB172A35
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242DEAC7;
	Tue, 15 Apr 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A/8m2sBh"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243FC2F2
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734836; cv=none; b=bgcbpXDm0BFlHzNWwLX571vjb2jaPLPTAgE01v3edCd8lkJKAAFaw93UWUzUjSzaPyOFO2aqmxWR1ZspgXhFUn2M5PgjeEAO2s6J/rchGBzOMtMzjxvfNdXQVDeYjtBthpTIcBZJe1/tLaNdhdfrJYL67ybx9USHjLeX6S4ozl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734836; c=relaxed/simple;
	bh=X27JfEupbcsXG644U/u+MULFwDDbLJw1VrpiWfaKdfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5aEag2K21sxjmQu9+QX6xr6noSEulCCogzQ2oJhO3YhlU1v7wxTP92za6wTjaw2yAdlbrnwW3PbH5mCodAS2RPNo5ZFO9PLYAyx89eTPGCQaN3947Q1BHmO08np8WqHQAH2CItegaxvVAExS6RnMGOU2HfafQ1hp8UA1dBVsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A/8m2sBh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744734820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MdEMsn+hmjsufhmYDZVu2cn/qJfy9kG1mD5f0WM+WyU=;
	b=A/8m2sBh+IcMBXY7Nh7qVSeSo6pPpakVd7xCCyI6Rkri0PDytiEeIvZfm+YcSOoTWDzp/m
	Mdl2FI5qpazwGoy6Ol1goT8uMxKyxH8RuYhDk+PMB4+6cKzZboR1DlsqI1DqY9BVxto4UG
	ecr4wzwlCrGtJiCpuOR1dERcKitaxPE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf] selftests/bpf: remove sockmap_ktls disconnect_after_delete test
Date: Tue, 15 Apr 2025 09:33:32 -0700
Message-ID: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid. Remove it from the suite.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 68 -------------------
 1 file changed, 68 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..47c0701e0938 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -10,72 +10,6 @@
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
 
-static int tcp_server(int family)
-{
-	int err, s;
-
-	s = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err = listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
-static int disconnect(int fd)
-{
-	struct sockaddr unspec = { AF_UNSPEC };
-
-	return connect(fd, &unspec, sizeof(unspec));
-}
-
-/* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
-static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
-{
-	struct sockaddr_storage addr = {0};
-	socklen_t len = sizeof(addr);
-	int err, cli, srv, zero = 0;
-
-	srv = tcp_server(family);
-	if (srv == -1)
-		return;
-
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
-		goto close_srv;
-
-	err = connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
-	err = bpf_map_update_elem(map, &zero, &cli, 0);
-	if (!ASSERT_OK(err, "bpf_map_update_elem"))
-		goto close_cli;
-
-	err = setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
-		goto close_cli;
-
-	err = bpf_map_delete_elem(map, &zero);
-	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
-		goto close_cli;
-
-	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
-
-close_cli:
-	close(cli);
-close_srv:
-	close(srv);
-}
-
 static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family, int map)
 {
 	struct sockaddr_storage addr = {};
@@ -154,8 +88,6 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		return;
 
-	if (test__start_subtest(fmt_test_name("disconnect_after_delete", family, map_type)))
-		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp", family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
 
-- 
2.49.0


