Return-Path: <bpf+bounces-54919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69663A75D95
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C881679D4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E682866;
	Mon, 31 Mar 2025 01:22:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEC33F3;
	Mon, 31 Mar 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384122; cv=none; b=A3bmAKBlDSqyeldkbSecchkOBJ2E3UZWp5ntTaexUdXroCh6vYVFD/CcwiqGx8D+DWU/l/3DpVc0BC9o+pXhzRvKwWA9k6o+ZZJ3poCGQ0d1jxRraWSoCMkoD4WFi9IuYsY6cPl9aYSfvcS76yX3KhzsF46sig0RJMeLRdu6tTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384122; c=relaxed/simple;
	bh=400QaFdEbB8ZZWSPlzN1aIw7EMTI7fMl9MaoSlcbtts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vl62XUHkrfq1ZJ6S744qya7UDVU9VD2wd+LYpygwyTwtZk6SKHkQgLTTB+yeKl66+kvH9hmX6o+6oEALzB4Xe0XfclHdedsXjw58DAakMFnQQ1JA5q3HvtrKLplbXKjMLSzYBb/lC8beXdguMjc1HfYaXO/qLqMCPHNF3Cakghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZQtX41TZNz1jBCh;
	Mon, 31 Mar 2025 09:17:08 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5016D1A0188;
	Mon, 31 Mar 2025 09:21:53 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 09:21:52 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>, <xiyou.wangcong@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stfomichev@gmail.com>,
	<mrpre@163.com>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v2 2/2] selftests: bpf: Add case for sockmap_ktls set when verdict attached
Date: Mon, 31 Mar 2025 09:21:26 +0800
Message-ID: <20250331012126.1649720-3-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250331012126.1649720-1-dongchenchen2@huawei.com>
References: <20250331012126.1649720-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100023.china.huawei.com (7.221.188.33)

Cover the scenario when close a socket after inserted into the sockmap
(verdict attach) and set ULP. It will trigger sock_map_close warning.

Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..d54bd5f41d4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -9,6 +9,7 @@
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
+#define SOCKMAP_VERDICT_PROG "test_sockmap_skb_verdict_attach.bpf.o"
 
 static int tcp_server(int family)
 {
@@ -132,6 +133,73 @@ static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family, int map
 	close(s);
 }
 
+/* close a kTLS socket after removing it from sockmap. */
+static void test_sockmap_ktls_close_after_delete(int family, int map)
+{
+	struct sockaddr_storage addr = {0};
+	socklen_t len = sizeof(addr);
+	int err, cli, srv, zero = 0;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	int verdict;
+
+	obj = bpf_object__open_file(SOCKMAP_VERDICT_PROG, NULL);
+	if (!ASSERT_OK(libbpf_get_error(obj), "bpf_object__open_file"))
+		return;
+
+	err = bpf_object__load(obj);
+	if (!ASSERT_OK(err, "bpf_object__load"))
+		goto close_obj;
+
+	prog = bpf_object__next_program(obj, NULL);
+	verdict = bpf_program__fd(prog);
+	if (!ASSERT_GE(verdict, 0, "bpf_program__fd"))
+		goto close_obj;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto close_verdict;
+
+	srv = tcp_server(family);
+	if (srv == -1)
+		goto detach;
+
+	err = getsockname(srv, (struct sockaddr *)&addr, &len);
+	if (!ASSERT_OK(err, "getsockopt"))
+		goto close_srv;
+
+	cli = socket(family, SOCK_STREAM, 0);
+	if (!ASSERT_GE(cli, 0, "socket"))
+		goto close_srv;
+
+	err = connect(cli, (struct sockaddr *)&addr, len);
+	if (!ASSERT_OK(err, "connect"))
+		goto close_cli;
+
+	err = bpf_map_update_elem(map, &zero, &cli, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto close_cli;
+
+	err = setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto close_cli;
+
+	err = bpf_map_delete_elem(map, &zero);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
+		goto close_cli;
+
+close_cli:
+	close(cli);
+close_srv:
+	close(srv);
+detach:
+	bpf_prog_detach2(verdict, map, BPF_SK_SKB_STREAM_VERDICT);
+close_verdict:
+	close(verdict);
+close_obj:
+	bpf_object__close(obj);
+}
+
 static const char *fmt_test_name(const char *subtest_name, int family,
 				 enum bpf_map_type map_type)
 {
@@ -158,6 +226,8 @@ static void run_tests(int family, enum bpf_map_type map_type)
 		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp", family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
+	if (test__start_subtest(fmt_test_name("close_after_delete", family, map_type)))
+		test_sockmap_ktls_close_after_delete(family, map);
 
 	close(map);
 }
-- 
2.25.1


