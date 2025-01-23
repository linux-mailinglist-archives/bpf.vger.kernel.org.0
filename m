Return-Path: <bpf+bounces-49589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE7A1A8D7
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A53A5DBD
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDD1547DC;
	Thu, 23 Jan 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ltx2Ndp1"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4212E13D520;
	Thu, 23 Jan 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652761; cv=none; b=bI1l4g6lCsbivvUKraFBBtJ9muK/Kgufn6Om8bLTc2GJRBtSfBwvQYTCeILiZ82y1rWmcuSbam0w7VLvuk2avi3olw/7sHaQlOo0L4TXYv60tpfVMUgDT436vCBgn6pVSD8sn/ssDwRPZ9Kyf1pbxwJpop0S9O0GGMJHMzWEp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652761; c=relaxed/simple;
	bh=l+eqW+5vF18jJFL7wpNgBpG+SdJRCdkLoucRJnocxAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B16CjnowrYW1d/IoAUy1m7vMnNLVM9Mz0CcqtVuinIpJHygFmSi/bTwX+kl6W2xPMH4EVcfy+WAuhJ3cEm5cb3GOL8qUXPs4TEYcPYisgjKu6Ulgj9+joHY38WNNzfUpJKhV4628vsGIJ2OZk24dbtrNNszXfW7ufpYJ048haiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ltx2Ndp1; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=oB3gQ
	epzdz1T2MZpa8mU0Bi2mHzAcq0dLl+Xr9/A4Sw=; b=Ltx2Ndp1ghMmlTkSll7Kk
	vmCxCxhSSNj8dR3NyYdXzTMSYBCRm/3GQkrVLfKNybVobsD3DuIZarlHO5wrWOmX
	cqIH/MysCKCUHR9lEUizRecc0IY38cxS8oFlPxBpIo+PSaANAhCx4jTWhTv8e9OR
	iEWJQ1Hbgg7MGGPXLhpyi8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnjmFKeZJnNajlHw--.26171S4;
	Fri, 24 Jan 2025 01:16:20 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v1 2/2] selftests/bpf: add ktls selftest
Date: Fri, 24 Jan 2025 01:15:52 +0800
Message-ID: <20250123171552.57345-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123171552.57345-1-mrpre@163.com>
References: <20250123171552.57345-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnjmFKeZJnNajlHw--.26171S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWxtry3JFyfuF47Xr48tFb_yoWxKw1Dpa
	y0yrW8KF48Jw1YqrZ5tr4xWrWSvF4jkw47Jr48Wr98AF1xXrn3XF1fKFW5tFnxWrZ8Zry5
	uwsa9F45ZrWUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zic4SrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWx3dp2eScl5PPwABsU

add ktls selftest

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 175 +++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  26 +++
 2 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..16acd8f345fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -3,13 +3,64 @@
 /*
  * Tests for sockmap/sockhash holding kTLS sockets.
  */
-
+#include <error.h>
 #include <netinet/tcp.h>
+#include <linux/tls.h>
 #include "test_progs.h"
+#include "sockmap_helpers.h"
+#include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_ktls.skel.h"
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
 
+static int init_ktls_pairs(int c, int p)
+{
+	int err;
+	struct tls12_crypto_info_aes_gcm_128 crypto_rx;
+	struct tls12_crypto_info_aes_gcm_128 crypto_tx;
+
+	err = setsockopt(c, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto out;
+
+	err = setsockopt(p, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto out;
+
+	memset(&crypto_rx, 0, sizeof(crypto_rx));
+	memset(&crypto_tx, 0, sizeof(crypto_tx));
+	crypto_rx.info.version = TLS_1_2_VERSION;
+	crypto_tx.info.version = TLS_1_2_VERSION;
+	crypto_rx.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	crypto_tx.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+
+	err = setsockopt(c, SOL_TLS, TLS_TX, &crypto_tx, sizeof(crypto_tx));
+	if (!ASSERT_OK(err, "setsockopt(TLS_TX)"))
+		goto out;
+
+	err = setsockopt(p, SOL_TLS, TLS_RX, &crypto_rx, sizeof(crypto_rx));
+	if (!ASSERT_OK(err, "setsockopt(TLS_RX)"))
+		goto out;
+	return 0;
+out:
+	return -1;
+}
+
+static int create_ktls_pairs(int family, int sotype, int *c, int *p)
+{
+	int err;
+
+	err = create_pair(family, sotype, c, p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		return -1;
+
+	err = init_ktls_pairs(*c, *p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		return -1;
+	return 0;
+}
+
 static int tcp_server(int family)
 {
 	int err, s;
@@ -146,6 +197,115 @@ static const char *fmt_test_name(const char *subtest_name, int family,
 	return test_name;
 }
 
+static void test_sockmap_ktls_offload(int family, int sotype)
+{
+	int err;
+	int c = 0, p = 0, sent, recvd;
+	char msg[12] = "hello world\0";
+	char rcv[13];
+
+	err = create_ktls_pairs(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_ktls_pairs()"))
+		goto out;
+
+	sent = send(c, msg, sizeof(msg), 0);
+	if (!ASSERT_OK(err, "send(msg)"))
+		goto out;
+
+	recvd = recv(p, rcv, sizeof(rcv), 0);
+	if (!ASSERT_OK(err, "recv(msg)") ||
+	    !ASSERT_EQ(recvd, sent, "length mismatch"))
+		goto out;
+
+	ASSERT_OK(memcmp(msg, rcv, sizeof(msg)), "data mismatch");
+
+out:
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+}
+
+static void test_sockmap_ktls_tx_cork(int family, int sotype, bool push)
+{
+	int err, off;
+	int i, j;
+	int start_push = 0, push_len = 0;
+	int c = 0, p = 0, one = 1, sent, recvd;
+	int prog_fd, map_fd;
+	char msg[12] = "hello world\0";
+	char rcv[20] = {0};
+	struct test_sockmap_ktls *skel;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto out;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	skel->bss->cork_byte = sizeof(msg);
+	if (push) {
+		start_push = 1;
+		push_len = 2;
+	}
+	skel->bss->push_start = start_push;
+	skel->bss->push_end = push_len;
+
+	off = sizeof(msg) / 2;
+	sent = send(c, msg, off, 0);
+	if (!ASSERT_EQ(sent, off, "send(msg)"))
+		goto out;
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(-1, recvd, "expected no data"))
+		goto out;
+
+	/* send remaining msg */
+	sent = send(c, msg + off, sizeof(msg) - off, 0);
+	if (!ASSERT_EQ(sent, sizeof(msg) - off, "send remaining data"))
+		goto out;
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_OK(err, "recv(msg)") ||
+	    !ASSERT_EQ(recvd, sizeof(msg) + push_len, "check length mismatch"))
+		goto out;
+
+	for (i = 0, j = 0; i < recvd;) {
+		/* skip checking the data that has been pushed in */
+		if (i >= start_push && i <= start_push + push_len - 1) {
+			i++;
+			continue;
+		}
+		if (!ASSERT_EQ(rcv[i], msg[j], "data mismatch"))
+			goto out;
+		i++;
+		j++;
+	}
+out:
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -158,14 +318,25 @@ static void run_tests(int family, enum bpf_map_type map_type)
 		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp", family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
-
 	close(map);
 }
 
+static void run_ktls_test(int family, int sotype)
+{
+	if (test__start_subtest("tls simple offload"))
+		test_sockmap_ktls_offload(family, sotype);
+	if (test__start_subtest("tls tx cork"))
+		test_sockmap_ktls_tx_cork(family, sotype, false);
+	if (test__start_subtest("tls tx cork with push"))
+		test_sockmap_ktls_tx_cork(family, sotype, true);
+}
+
 void test_sockmap_ktls(void)
 {
 	run_tests(AF_INET, BPF_MAP_TYPE_SOCKMAP);
 	run_tests(AF_INET, BPF_MAP_TYPE_SOCKHASH);
 	run_tests(AF_INET6, BPF_MAP_TYPE_SOCKMAP);
 	run_tests(AF_INET6, BPF_MAP_TYPE_SOCKHASH);
+	run_ktls_test(AF_INET, SOCK_STREAM);
+	run_ktls_test(AF_INET6, SOCK_STREAM);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
new file mode 100644
index 000000000000..e0f757929ef4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+int cork_byte;
+int push_start;
+int push_end;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+SEC("sk_msg")
+int prog_sk_policy(struct sk_msg_md *msg)
+{
+	if (cork_byte > 0)
+		bpf_msg_cork_bytes(msg, cork_byte);
+	if (push_start > 0 && push_end > 0)
+		bpf_msg_push_data(msg, push_start, push_end, 0);
+
+	return SK_PASS;
+}
-- 
2.43.5


