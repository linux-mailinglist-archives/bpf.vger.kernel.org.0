Return-Path: <bpf+bounces-46159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8939E54EF
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9376628201B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF1217F3D;
	Thu,  5 Dec 2024 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OAoCblwH"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662821767D;
	Thu,  5 Dec 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400322; cv=none; b=g+g+E8ExTmgyjf2UknUAqYG4U5+wLjolRG+f9Q/XlAB7BHfRwCk5K+GybVaGLjwDDFaE/G/hwlVta0x28/sX5puNP182zM3vvDKdablqb2OwHfjUnl/3om771m2Vd1dnq69wW8pwTZl9bFANs8i/f8CHX1u6KMx1W0aOTEgNTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400322; c=relaxed/simple;
	bh=v3RX0C8Km8hHRBJw5B5yUQEiTRsnyn7xztT+rCsKiSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxHVvF3hU+IDF6ltcBUIAllIs5ugFXTlzSxg3OTnRpgvRAFYJwtvA4u9UZ7ACe5MXtlX45WVdEnJ7fPB5w4cTV+ReL1ggwlHkjseg9HrgL//fDM1elh1zjRz6cZoXWAMEozSPn7hqyxFzIOv/yawoRn6nBO41rJcKT/kx/zh0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OAoCblwH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=1Rxol
	4B0gk12ZHYR5JiW6y4H6G/0t4/hRANWoP0Tr84=; b=OAoCblwHWv2FOWC+7pUye
	V2sDa8CLTmHj4QK2dQw+QDKpwbuoPyl8r6jt0DeYfwrfF8H2fqvaJQQXqqXApEra
	9dfQfxdEJH5qjNrpZ7lFeUSF3rbCOT6BF0JjLNAcK7LxirKTNg7H2GlLKZ2iaANB
	TK5O7WqvOvHRGVtxkzGqxI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA347I+llFnx_IkAQ--.41744S4;
	Thu, 05 Dec 2024 20:02:32 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add strparser test for bpf
Date: Thu,  5 Dec 2024 20:02:04 +0800
Message-ID: <20241205120204.229737-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241205120204.229737-1-mrpre@163.com>
References: <20241205120204.229737-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA347I+llFnx_IkAQ--.41744S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF1fXr18Cw1DJw1fJFyrJFb_yoW8Gr1xAo
	ZxGan8Xa1xCFnxJ34kG3ykCw4fWF4xW395Xw17J3y5ZF1jyrWY9FWUGws3X3WI9r4Fgry5
	GFWqvayrurs8Jr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R9L05DUUUU
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWwSsp2dRlGNCXQAAsK

Add test cases for bpf + strparser and separated them from
sockmap_basic. This is because we need to add more test cases for
strparser in the future.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 ----
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 255 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  51 ++++
 3 files changed, 306 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index fdff0652d7ef..4c0eebc433d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -530,57 +530,6 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
-static void test_sockmap_stream_pass(void)
-{
-	int zero = 0, sent, recvd;
-	int verdict, parser;
-	int err, map;
-	int c = -1, p = -1;
-	struct test_sockmap_pass_prog *pass = NULL;
-	char snd[256] = "0123456789";
-	char rcv[256] = "0";
-
-	pass = test_sockmap_pass_prog__open_and_load();
-	verdict = bpf_program__fd(pass->progs.prog_skb_verdict);
-	parser = bpf_program__fd(pass->progs.prog_skb_parser);
-	map = bpf_map__fd(pass->maps.sock_map_rx);
-
-	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
-		goto out;
-
-	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
-		goto out;
-
-	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
-	if (err)
-		goto out;
-
-	/* sk_data_ready of 'p' will be replaced by strparser handler */
-	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
-		goto out_close;
-
-	/*
-	 * as 'prog_skb_parser' return the original skb len and
-	 * 'prog_skb_verdict' return SK_PASS, the kernel will just
-	 * pass it through to original socket 'p'
-	 */
-	sent = xsend(c, snd, sizeof(snd), 0);
-	ASSERT_EQ(sent, sizeof(snd), "xsend(c)");
-
-	recvd = recv_timeout(p, rcv, sizeof(rcv), SOCK_NONBLOCK,
-			     IO_TIMEOUT_SEC);
-	ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout(p)");
-
-out_close:
-	close(c);
-	close(p);
-
-out:
-	test_sockmap_pass_prog__destroy(pass);
-}
 
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
@@ -1050,8 +999,6 @@ void test_sockmap_basic(void)
 		test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
 	if (test__start_subtest("sockmap skb_verdict shutdown"))
 		test_sockmap_skb_verdict_shutdown();
-	if (test__start_subtest("sockmap stream parser and verdict pass"))
-		test_sockmap_stream_pass();
 	if (test__start_subtest("sockmap skb_verdict fionread"))
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
new file mode 100644
index 000000000000..1157a9410f87
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+
+#include <test_progs.h>
+#include "sockmap_helpers.h"
+#include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_strp.skel.h"
+#define STRP_HEAD_LEN 4
+#define STRP_BODY_LEN 6
+#define STRP_FULL_LEN (STRP_HEAD_LEN + STRP_BODY_LEN)
+
+static void test_sockmap_strp_partial_read(int family, int sotype)
+{
+	int zero = 0, recvd, off;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char snd[STRP_FULL_LEN] = "head+body\0";
+	char rcv[256] = "0";
+
+	strp = test_sockmap_strp__open_and_load();
+	verdict = bpf_program__fd(strp->progs.prog_skb_verdict_pass);
+	parser = bpf_program__fd(strp->progs.prog_skb_parser_partial);
+	map = bpf_map__fd(strp->maps.sock_map);
+
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto out;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (err)
+		goto out;
+
+	/* sk_data_ready of 'p' will be replaced by strparser handler */
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(zero, p)"))
+		goto out_close;
+
+	/* 1.1 send partial head, 1 byte header left*/
+	off = STRP_HEAD_LEN - 1;
+	xsend(c, snd, off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 5);
+	if (!ASSERT_EQ(-1, recvd, "insufficient head, should no data recvd"))
+		goto out_close;
+
+	/* 1.2 send remaining head and body */
+	xsend(c, snd + off, STRP_FULL_LEN - off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, STRP_FULL_LEN, "should full data recvd"))
+		goto out_close;
+
+	/* 2.1 send partial head, 1 byte header left */
+	off = STRP_HEAD_LEN - 1;
+	xsend(c, snd, off, 0);
+
+	/* 2.2 send remaining head and partial body, 1 byte body left */
+	xsend(c, snd + off, STRP_FULL_LEN - off - 1, 0);
+	off = STRP_FULL_LEN - 1;
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(-1, recvd, "insufficient body, should no data read"))
+		goto out_close;
+
+	/* 2.3 send remain body */
+	xsend(c, snd + off, STRP_FULL_LEN - off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, STRP_FULL_LEN, "should full data recvd"))
+		goto out_close;
+
+out_close:
+	close(c);
+	close(p);
+
+out:
+	test_sockmap_strp__destroy(strp);
+}
+
+static void test_sockmap_strp_pass(int family, int sotype, bool fionread)
+{
+	int zero = 0, sent, recvd, avail;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	int read_cnt = 10, i;
+	struct test_sockmap_strp *strp = NULL;
+	char snd[11] = "0123456789\0";
+	char rcv[256] = "0";
+
+	strp = test_sockmap_strp__open_and_load();
+	verdict = bpf_program__fd(strp->progs.prog_skb_verdict_pass);
+	parser = bpf_program__fd(strp->progs.prog_skb_parser);
+	map = bpf_map__fd(strp->maps.sock_map);
+
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto out;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (err)
+		goto out;
+
+	/* sk_data_ready of 'p' will be replaced by strparser handler */
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
+		goto out_close;
+
+	/*
+	 * Previously, we encountered issues such as deadlocks and
+	 * sequence errors that resulted in the inability to read
+	 * continuously. Therefore, we perform multiple iterations
+	 * of testing here.
+	 */
+	for (i = 0; i < read_cnt; i++) {
+		sent = xsend(c, snd, sizeof(snd), 0);
+		if (!ASSERT_EQ(sent, sizeof(snd), "xsend(c)"))
+			goto out_close;
+
+		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT,
+				     IO_TIMEOUT_SEC);
+		if (!ASSERT_EQ(recvd, sizeof(snd), "recv_timeout(p)")
+		    || !ASSERT_OK(memcmp(snd, rcv, sizeof(snd)),
+				  "recv_timeout(p)"))
+			goto out_close;
+	}
+
+	if (fionread) {
+		sent = xsend(c, snd, sizeof(snd), 0);
+		if (!ASSERT_EQ(sent, sizeof(snd), "second xsend(c)"))
+			goto out_close;
+
+		err = ioctl(p, FIONREAD, &avail);
+		if (!ASSERT_OK(err, "ioctl(FIONREAD) error")
+		    || ASSERT_EQ(avail, sizeof(snd), "ioctl(FIONREAD)"))
+			goto out_close;
+
+		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT,
+							 IO_TIMEOUT_SEC);
+		if (!ASSERT_EQ(recvd, sizeof(snd), "second recv_timeout(p)")
+		    || ASSERT_OK(memcmp(snd, rcv, sizeof(snd)),
+				 "second recv_timeout(p)"))
+			goto out_close;
+	}
+
+out_close:
+	close(c);
+	close(p);
+
+out:
+	test_sockmap_strp__destroy(strp);
+}
+
+static void test_sockmap_strp_verdict(int family, int sotype)
+{
+	int zero = 0, one = 1, sent, recvd, off, total_sent;
+	int verdict, parser;
+	int err, map;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char snd[11] = "0123456789\0";
+	char rcv[256] = "0";
+
+	strp = test_sockmap_strp__open_and_load();
+	verdict = bpf_program__fd(strp->progs.prog_skb_verdict);
+	parser = bpf_program__fd(strp->progs.prog_skb_parser);
+	map = bpf_map__fd(strp->maps.sock_map);
+
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto out;
+
+	/* We simulate a reverse proxy server.
+	 * When p0 receives data from c0, we forward it to p1.
+	 * From p1's perspective, it will consider this data
+	 * as being sent by c1.
+	 */
+	err = create_socket_pairs(family, sotype, &c0, &c1, &p0, &p1);
+	if (!ASSERT_OK(err, "create_socket_pairs()"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p0, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
+		goto out_close;
+
+	err = bpf_map_update_elem(map, &one, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
+		goto out_close;
+
+	total_sent = sizeof(snd);
+	sent = xsend(c0, snd, total_sent, 0);
+	if (!ASSERT_EQ(sent, total_sent, "xsend(c0)"))
+		goto out_close;
+
+	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, total_sent, "recv_timeout(p1)")
+	    || !ASSERT_OK(memcmp(snd, rcv, total_sent),
+			  "received data does not match the sent data"))
+		goto out_close;
+
+	/* send again to ensure the stream is functioning correctly. */
+	total_sent = sizeof(snd);
+	sent = xsend(c0, snd, total_sent, 0);
+	if (!ASSERT_EQ(sent, total_sent, "second xsend(c0)"))
+		goto out_close;
+
+	/* partial read */
+	off = total_sent/2;
+	recvd = recv_timeout(p1, rcv, off, MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	recvd += recv_timeout(p1, rcv + off, sizeof(rcv) - off, MSG_DONTWAIT,
+			      IO_TIMEOUT_SEC);
+
+	if (!ASSERT_EQ(recvd, total_sent, "partial recv_timeout(p1)")
+	    || !ASSERT_OK(memcmp(snd, rcv, total_sent),
+			  "partial received data does not match the sent data"))
+		goto out_close;
+
+out_close:
+	close(c0);
+	close(c1);
+	close(p0);
+	close(p1);
+out:
+	test_sockmap_strp__destroy(strp);
+}
+
+void test_sockmap_strp(void)
+{
+	if (test__start_subtest("sockmap strp tcp pass"))
+		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, false);
+	if (test__start_subtest("sockmap strp tcp v6 pass"))
+		test_sockmap_strp_pass(AF_INET6, SOCK_STREAM, false);
+	if (test__start_subtest("sockmap strp tcp pass fionread"))
+		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, true);
+	if (test__start_subtest("sockmap strp tcp v6 pass fionread"))
+		test_sockmap_strp_pass(AF_INET6, SOCK_STREAM, true);
+	if (test__start_subtest("sockmap strp tcp verdict"))
+		test_sockmap_strp_verdict(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp tcp v6 verdict"))
+		test_sockmap_strp_verdict(AF_INET6, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp tcp partial read"))
+		test_sockmap_strp_partial_read(AF_INET, SOCK_STREAM);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
new file mode 100644
index 000000000000..db2f3b6c87ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict_pass(struct __sk_buff *skb)
+{
+	return SK_PASS;
+}
+
+
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict(struct __sk_buff *skb)
+{
+	__u32 one = 1;
+
+	return bpf_sk_redirect_map(skb, &sock_map, one, 0);
+}
+
+SEC("sk_skb/stream_parser")
+int prog_skb_parser(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_partial(struct __sk_buff *skb)
+{
+	/* agreement with the test program on a 4-byte size header
+	 * and 6-byte body.
+	 */
+	if (skb->len < 4) {
+		/* need more header to determine full length */
+		return 0;
+	}
+	/* return full length decoded from header.
+	 * the return value may be larger than skb->len which
+	 * means framework must wait body coming.
+	 */
+	return 10;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


