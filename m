Return-Path: <bpf+bounces-47197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE79F5E54
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70F1666A7
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A63154457;
	Wed, 18 Dec 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PjL4cx0d"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492821474C9;
	Wed, 18 Dec 2024 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500202; cv=none; b=KWQnPXQYRY7maWRZ7xeeCIuYigArpm4g6b/fuLt5U6dl5IkQrJzh11iJrlXSKEtqtwWwoEVERRNOjxqEA1zvUZQ7BahZ+1CBH2O4Hm3QoucLgKA0SJD+mmsASU3e0pdCb+MHKzErflCRDYV/F4KYja8KXIbHqg3IDa7UUU12XCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500202; c=relaxed/simple;
	bh=dIUP7WdiNL+gacq4RzMEJCyL7wZSCrcOzOwR8uvJg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH36NvC88n/jGWXYvSSYFF/g30gmwsU24ck6uSyskJ5ZXKKMWMAow7MYqCBCPjmFHi9hPZVHPIcNmbosItx4HtnXSCMwsUa92IrQelV+2xKBSZ9miUAlvvx66GD/Z0XClE/hKX9SdJIor19GiCRbtbwKbEa1mfCNay2KuKfr3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PjL4cx0d; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=iC8jk
	3Ez3kXmPN1ZIXjPdlYnL0nYGf90nwsAxr8CmYg=; b=PjL4cx0dFWsTzG+M7lGll
	R59H3nNT7oOleWAGIS+tgLIkClAzoj6/CMeIVEPpcQCeAATMqOAnih3hFVE1vWS9
	6vuafgCVBucg+CkmcnzHpSFc/Ar5n+e2H2J9UQ6iDGGRx+1EUwLVCQixFVjutfPA
	NXYm1UuYoPuY4F6CubceHk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXf3juXmJn1VZZBQ--.30577S4;
	Wed, 18 Dec 2024 13:35:05 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: add strparser test for bpf
Date: Wed, 18 Dec 2024 13:34:08 +0800
Message-ID: <20241218053408.437295-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218053408.437295-1-mrpre@163.com>
References: <20241218053408.437295-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf3juXmJn1VZZBQ--.30577S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF1fXr18Cw1DJw1fJFyrJFb_yoW8WF13Co
	Z3Gan8J3yxGrnxJ34kG3yDCa1fWF4xWw4kWw47J3y5XFyjyrWj9ayUGws3W3Wa9r4Sgr93
	JFWqva4rWr15Jr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RPWrWUUUUU
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxC5p2diVznRhwAAso

Add test cases for bpf + strparser and separated them from
sockmap_basic. This is because we need to add more test cases for
strparser in the future.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 ---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 344 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  51 +++
 3 files changed, 395 insertions(+), 53 deletions(-)
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
index 000000000000..0398658d4787
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+
+#include <test_progs.h>
+#include "sockmap_helpers.h"
+#include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_strp.skel.h"
+#define STRP_PACKET_HEAD_LEN 4
+#define STRP_PACKET_BODY_LEN 6
+#define STRP_PACKET_FULL_LEN (STRP_PACKET_HEAD_LEN + STRP_PACKET_BODY_LEN)
+static const char packet[STRP_PACKET_FULL_LEN] = "head+body\0";
+static const int test_packet_num = 100;
+
+static struct test_sockmap_strp *sockmap_strp_init(int *map)
+{
+	struct test_sockmap_strp *strp = NULL;
+	int verdict, parser;
+	int err;
+
+	strp = test_sockmap_strp__open_and_load();
+	verdict = bpf_program__fd(strp->progs.prog_skb_verdict_pass);
+	parser = bpf_program__fd(strp->progs.prog_skb_parser_partial);
+	*map = bpf_map__fd(strp->maps.sock_map);
+
+	err = bpf_prog_attach(parser, *map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto err;
+
+	err = bpf_prog_attach(verdict, *map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto err;
+
+	return strp;
+err:
+	test_sockmap_strp__destroy(strp);
+	return NULL;
+}
+
+/* we have multiple packets in one skb
+ * ------------ ------------ ------------
+ * |  packet1  |   packet2  |  ...
+ * ------------ ------------ ------------
+ */
+static void test_sockmap_strp_multi_packet(int family, int sotype)
+{
+	int i, zero = 0;
+	int sent, recvd, total;
+	int err, map;
+	int c = -1, p = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char *snd = NULL, *rcv = NULL;
+
+	strp = sockmap_strp_init(&map);
+	if (!ASSERT_TRUE(strp != NULL, "sockmap_strp_init"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (err)
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(zero, p)"))
+		goto out_close;
+
+	/* construct multiple packets in one buffer */
+	total = test_packet_num * STRP_PACKET_FULL_LEN;
+	snd = malloc(total);
+	rcv = malloc(total + 1);
+	if (!ASSERT_TRUE(snd != NULL, "malloc(multi block)")
+		|| !ASSERT_TRUE(rcv != NULL, "malloc(multi block)"))
+		goto out_close;
+
+	for (i = 0; i < test_packet_num; i++) {
+		memcpy(snd + i * STRP_PACKET_FULL_LEN,
+		       packet, STRP_PACKET_FULL_LEN);
+	}
+
+	sent = xsend(c, snd, total, 0);
+	if (!ASSERT_EQ(sent, total, "xsend(c)"))
+		goto out_close;
+
+	/* try to recv one more byte to avoid truncation check */
+	recvd = recv_timeout(p, rcv, total + 1, MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, total, "recv(rcv)"))
+		goto out_close;
+
+	/* we sent TCP segment with multiple encapsulation
+	 * then check whether packets are handled correctly
+	 */
+	if (!ASSERT_OK(memcmp(snd, rcv, total), "memcmp(snd, rcv)"))
+		goto out_close;
+
+out_close:
+	close(c);
+	close(p);
+	if (snd)
+		free(snd);
+	if (rcv)
+		free(rcv);
+out:
+	test_sockmap_strp__destroy(strp);
+}
+
+static void test_sockmap_strp_partial_read(int family, int sotype)
+{
+	int zero = 0, recvd, off;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char rcv[STRP_PACKET_FULL_LEN + 1] = "0";
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
+	off = STRP_PACKET_HEAD_LEN - 1;
+	xsend(c, packet, off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 5);
+	if (!ASSERT_EQ(-1, recvd, "insufficient head, should no data recvd"))
+		goto out_close;
+
+	/* 1.2 send remaining head and body */
+	xsend(c, packet + off, STRP_PACKET_FULL_LEN - off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, STRP_PACKET_FULL_LEN, "should full data recvd"))
+		goto out_close;
+
+	/* 2.1 send partial head, 1 byte header left */
+	off = STRP_PACKET_HEAD_LEN - 1;
+	xsend(c, packet, off, 0);
+
+	/* 2.2 send remaining head and partial body, 1 byte body left */
+	xsend(c, packet + off, STRP_PACKET_FULL_LEN - off - 1, 0);
+	off = STRP_PACKET_FULL_LEN - 1;
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(-1, recvd, "insufficient body, should no data read"))
+		goto out_close;
+
+	/* 2.3 send remaining body */
+	xsend(c, packet + off, STRP_PACKET_FULL_LEN - off, 0);
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, STRP_PACKET_FULL_LEN, "should full data recvd"))
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
+	int zero = 0, pkt_size, sent, recvd, avail;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	int read_cnt = 10, i;
+	struct test_sockmap_strp *strp = NULL;
+	char rcv[STRP_PACKET_FULL_LEN + 1] = "0";
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
+	/* Previously, we encountered issues such as deadlocks and
+	 * sequence errors that resulted in the inability to read
+	 * continuously. Therefore, we perform multiple iterations
+	 * of testing here.
+	 */
+	pkt_size = STRP_PACKET_FULL_LEN;
+	for (i = 0; i < read_cnt; i++) {
+		sent = xsend(c, packet, pkt_size, 0);
+		if (!ASSERT_EQ(sent, pkt_size, "xsend(c)"))
+			goto out_close;
+
+		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT,
+				     IO_TIMEOUT_SEC);
+		if (!ASSERT_EQ(recvd, pkt_size, "recv_timeout(p)")
+		    || !ASSERT_OK(memcmp(packet, rcv, pkt_size),
+				  "recv_timeout(p)"))
+			goto out_close;
+	}
+
+	if (fionread) {
+		sent = xsend(c, packet, pkt_size, 0);
+		if (!ASSERT_EQ(sent, pkt_size, "second xsend(c)"))
+			goto out_close;
+
+		err = ioctl(p, FIONREAD, &avail);
+		if (!ASSERT_OK(err, "ioctl(FIONREAD) error")
+		    || ASSERT_EQ(avail, pkt_size, "ioctl(FIONREAD)"))
+			goto out_close;
+
+		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT,
+				     IO_TIMEOUT_SEC);
+		if (!ASSERT_EQ(recvd, pkt_size, "second recv_timeout(p)")
+		    || ASSERT_OK(memcmp(packet, rcv, pkt_size),
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
+	int zero = 0, one = 1, sent, recvd, off;
+	int verdict, parser;
+	int err, map;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char rcv[STRP_PACKET_FULL_LEN + 1] = "0";
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
+	sent = xsend(c0, packet, STRP_PACKET_FULL_LEN, 0);
+	if (!ASSERT_EQ(sent, STRP_PACKET_FULL_LEN, "xsend(c0)"))
+		goto out_close;
+
+	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, STRP_PACKET_FULL_LEN, "recv_timeout(p1)")
+	    || !ASSERT_OK(memcmp(packet, rcv, STRP_PACKET_FULL_LEN),
+			  "received data does not match the sent data"))
+		goto out_close;
+
+	/* send again to ensure the stream is functioning correctly. */
+	sent = xsend(c0, packet, STRP_PACKET_FULL_LEN, 0);
+	if (!ASSERT_EQ(sent, STRP_PACKET_FULL_LEN, "second xsend(c0)"))
+		goto out_close;
+
+	/* partial read */
+	off = STRP_PACKET_FULL_LEN/2;
+	recvd = recv_timeout(p1, rcv, off, MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	recvd += recv_timeout(p1, rcv + off, sizeof(rcv) - off, MSG_DONTWAIT,
+			      IO_TIMEOUT_SEC);
+
+	if (!ASSERT_EQ(recvd, STRP_PACKET_FULL_LEN, "partial recv_timeout(p1)")
+	    || !ASSERT_OK(memcmp(packet, rcv, STRP_PACKET_FULL_LEN),
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
+	if (test__start_subtest("sockmap strp tcp multiple packets"))
+		test_sockmap_strp_multi_packet(AF_INET, SOCK_STREAM);
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


