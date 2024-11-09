Return-Path: <bpf+bounces-44427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A389C2DFE
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D502829CB
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B819ABA3;
	Sat,  9 Nov 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OrJ1cRGx"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67871993B0;
	Sat,  9 Nov 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164692; cv=none; b=d2j7/T255gzjjxqLitXpKJn2z9DRiBOjMjtx9jzVMwWczGdKp26PfHvu+klrV2hYidteZXDvKSo543VLrZ4QVwZDGDX0kP1j9bEzpF2J8X5wVLNvXqs6hAWsdWGotaxlCyVLL0htSOnMiobM5hRC0oPqZUtWgE6R2jSCI971O3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164692; c=relaxed/simple;
	bh=TmOqh12jh/hd7LphsJcAycql0JOTzPp70qnsRLw7yoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4ykzYC9UXZznGNg9skzrGA5M+MbpdzV9z5UNFh2mvX86VXXk/wCEv21ZQ8aVgwLZkOCFI3ayYtrxbVDHSFvaWU9vJoDdE6xTi7qKByP2x0up7EHRXeY8DG/AvBcTUFwEKlO/gCp3DAt/uvmIPuSZsbsCFg8P/a9WRc1ZINthPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OrJ1cRGx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0k/F1
	pXcCWA4WV0EJbEaPLEqPNdG3UNWm4bGMccG7jw=; b=OrJ1cRGxnuaBUAVJTPDoD
	hqn9G//Lb/EUiAD0j3qs/E9PcvzvlnLfoYXKOHHxouHZ/+COSciGcMbfFa2OrJS4
	ZI90eQXhgqxgRDr0ILK6qikfu6zopsFbQYJB3dndkCmklDY4uZ+ibGf8cVx8Axrz
	SZ/MauBLINxkAzNDe5KHHI=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnT4exeS9n3Jk_GA--.36911S4;
	Sat, 09 Nov 2024 23:03:35 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add some tests with sockmap SK_PASS
Date: Sat,  9 Nov 2024 23:03:05 +0800
Message-ID: <20241109150305.141759-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109150305.141759-1-mrpre@163.com>
References: <20241109150305.141759-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnT4exeS9n3Jk_GA--.36911S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1rGrWfKry3ur13Wr17Jrb_yoW7CF4DpF
	y8Zw1jgF4kta42qF45Ga4Ikr45GFn3Zw45KF4Fg3sxCrs7ur1fZr4xKayYyr1rJrWIq3W5
	uw17WayrJw18CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pND73fUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwaSp2cvb9J4nQAAss

1. Add a new tests in sockmap_basic.c to test SK_PASS for sockmap
2. The return value of 'sk_skb/stream_parser' is used as a length, but
   the current eBPF program returns SK_PASS, which is semantically
   incorrect. This change modifies it to return skb->len. All tests
   related to this eBPF program have been tested
   (currently only in sockmap_basic.c).

All tests are passed.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
test result
310/1   sockmap_basic/sockmap create_update_free:OK
310/2   sockmap_basic/sockhash create_update_free:OK
310/3   sockmap_basic/sockmap sk_msg load helpers:OK
310/4   sockmap_basic/sockhash sk_msg load helpers:OK
310/5   sockmap_basic/sockmap update:OK
310/6   sockmap_basic/sockhash update:OK
310/7   sockmap_basic/sockmap update in unsafe context:OK
310/8   sockmap_basic/sockmap copy:OK
310/9   sockmap_basic/sockhash copy:OK
310/10  sockmap_basic/sockmap skb_verdict attach:OK
310/11  sockmap_basic/sockmap skb_verdict attach_with_link:OK
310/12  sockmap_basic/sockmap msg_verdict progs query:OK
310/13  sockmap_basic/sockmap stream_parser progs query:OK
310/14  sockmap_basic/sockmap stream_verdict progs query:OK
310/15  sockmap_basic/sockmap skb_verdict progs query:OK
310/16  sockmap_basic/sockmap skb_verdict shutdown:OK
310/17  sockmap_basic/sockmap stream_parser and stream_verdict pass:OK
310/18  sockmap_basic/sockmap skb_verdict fionread:OK
310/19  sockmap_basic/sockmap skb_verdict fionread on drop:OK
310/20  sockmap_basic/sockmap skb_verdict msg_f_peek:OK
310/21  sockmap_basic/sockmap skb_verdict msg_f_peek with link:OK
310/22  sockmap_basic/sockmap unconnected af_unix:OK
310/23  sockmap_basic/sockmap one socket to many map entries:OK
310/24  sockmap_basic/sockmap one socket to many maps:OK
310/25  sockmap_basic/sockmap same socket replace:OK
310/26  sockmap_basic/sockmap sk_msg attach sockmap helpers with link:OK
310/27  sockmap_basic/sockhash sk_msg attach sockhash helpers with link:OK
310     sockmap_basic:OK
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 53 +++++++++++++++++++
 .../bpf/progs/test_sockmap_pass_prog.c        |  2 +-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741c..03af463265ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -501,6 +501,57 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void test_sockmap_stream_pass(void)
+{
+	int zero = 0, sent, recvd;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	struct test_sockmap_pass_prog *pass = NULL;
+	char snd[256] = "0123456789";
+	char rcv[256] = "0";
+
+	pass = test_sockmap_pass_prog__open_and_load();
+	verdict = bpf_program__fd(pass->progs.prog_skb_verdict);
+	parser = bpf_program__fd(pass->progs.prog_skb_parser);
+	map = bpf_map__fd(pass->maps.sock_map_rx);
+
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+	if (err)
+		goto out;
+
+	/* sk_data_ready of 'p' will be replaced by strparser handler */
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
+		goto out_close;
+
+	/*
+	 * as 'prog_skb_parser' return the original skb len and
+	 * 'prog_skb_verdict' return SK_PASS, the kernel will just
+	 * pass it through to original socket 'p'
+	 */
+	sent = xsend(c, snd, sizeof(snd), 0);
+	ASSERT_EQ(sent, sizeof(snd), "xsend(c)");
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+	ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout(p)");
+
+out_close:
+	close(c);
+	close(p);
+
+out:
+	test_sockmap_pass_prog__destroy(pass);
+}
+
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
 	int err, map, verdict, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
@@ -923,6 +974,8 @@ void test_sockmap_basic(void)
 		test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
 	if (test__start_subtest("sockmap skb_verdict shutdown"))
 		test_sockmap_skb_verdict_shutdown();
+	if (test__start_subtest("sockmap stream_parser and stream_verdict pass"))
+		test_sockmap_stream_pass();
 	if (test__start_subtest("sockmap skb_verdict fionread"))
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
index 69aacc96db36..515a3869e56c 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
@@ -41,7 +41,7 @@ int prog_skb_verdict_clone(struct __sk_buff *skb)
 SEC("sk_skb/stream_parser")
 int prog_skb_parser(struct __sk_buff *skb)
 {
-	return SK_PASS;
+	return skb->len;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


