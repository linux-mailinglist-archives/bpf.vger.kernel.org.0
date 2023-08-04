Return-Path: <bpf+bounces-6956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641376FAFF
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974B51C2177E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92C9477;
	Fri,  4 Aug 2023 07:16:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A029448;
	Fri,  4 Aug 2023 07:16:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F02A3588;
	Fri,  4 Aug 2023 00:16:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHH822PdHz4f3lXj;
	Fri,  4 Aug 2023 15:16:34 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAHF+jMpcxkm1vaPQ--.64994S6;
	Fri, 04 Aug 2023 15:16:34 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH bpf v3 4/4] selftests/bpf: Add sockmap test for redirecting partial skb data
Date: Fri,  4 Aug 2023 03:37:40 -0400
Message-Id: <20230804073740.194770-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230804073740.194770-1-xukuohai@huaweicloud.com>
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHF+jMpcxkm1vaPQ--.64994S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xKF47KF1xCF13ZF47urg_yoWrZr43pa
	yrCa4DKF4xtFyYgr4Yqa18GF4Fg3WFq345tF4rGwnIvrsrGr1rXrn2gayUtFnxKrZYqayF
	y3ZIgrWfW3yDJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

Add a test case to check whether sockmap redirection works correctly
when data length returned by stream_parser is less than skb->len.

In addition, this test checks whether strp_done is called correctly.
The reason is that we returns skb->len - 1 from the stream_parser, so
the last byte in the skb will be held by strp->skb_head. Therefore,
if strp_done is not called to free strp->skb_head, we'll get a memleak
warning.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 72 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_listen.c | 14 ++++
 2 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index ba35bcc66e7e..5674a9d0cacf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -869,6 +869,77 @@ static void test_msg_redir_to_listening(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_MSG_VERDICT);
 }
 
+static void redir_partial(int family, int sotype, int sock_map, int parser_map)
+{
+	int s, c0, c1, p0, p1;
+	int err, n, key, value;
+	char buf[] = "abc";
+
+	key = 0;
+	value = sizeof(buf) - 1;
+	err = xbpf_map_update_elem(parser_map, &key, &value, 0);
+	if (err)
+		return;
+
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	if (s < 0)
+		goto clean_parser_map;
+
+	err = create_socket_pairs(s, family, sotype, &c0, &c1, &p0, &p1);
+	if (err)
+		goto close_srv;
+
+	err = add_to_sockmap(sock_map, p0, p1);
+	if (err)
+		goto close;
+
+	n = xsend(c1, buf, sizeof(buf), 0);
+	if (n < sizeof(buf))
+		FAIL("incomplete write");
+
+	n = xrecv_nonblock(c0, buf, sizeof(buf), 0);
+	if (n != sizeof(buf) - 1)
+		FAIL("expect %zu, received %d", sizeof(buf) - 1, n);
+
+close:
+	xclose(c0);
+	xclose(p0);
+	xclose(c1);
+	xclose(p1);
+close_srv:
+	xclose(s);
+
+clean_parser_map:
+	key = 0;
+	value = 0;
+	xbpf_map_update_elem(parser_map, &key, &value, 0);
+}
+
+static void test_skb_redir_partial(struct test_sockmap_listen *skel,
+				   struct bpf_map *inner_map, int family,
+				   int sotype)
+{
+	int verdict = bpf_program__fd(skel->progs.prog_stream_verdict);
+	int parser = bpf_program__fd(skel->progs.prog_stream_parser);
+	int parser_map = bpf_map__fd(skel->maps.parser_map);
+	int sock_map = bpf_map__fd(inner_map);
+	int err;
+
+	err = xbpf_prog_attach(parser, sock_map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (err)
+		return;
+
+	err = xbpf_prog_attach(verdict, sock_map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (err)
+		goto detach;
+
+	redir_partial(family, sotype, sock_map, parser_map);
+
+	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_STREAM_VERDICT);
+detach:
+	xbpf_prog_detach2(parser, sock_map, BPF_SK_SKB_STREAM_PARSER);
+}
+
 static void test_reuseport_select_listening(int family, int sotype,
 					    int sock_map, int verd_map,
 					    int reuseport_prog)
@@ -1243,6 +1314,7 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	} tests[] = {
 		TEST(test_skb_redir_to_connected),
 		TEST(test_skb_redir_to_listening),
+		TEST(test_skb_redir_partial),
 		TEST(test_msg_redir_to_connected),
 		TEST(test_msg_redir_to_listening),
 	};
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index 325c9f193432..464d35bd57c7 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -28,12 +28,26 @@ struct {
 	__type(value, unsigned int);
 } verdict_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} parser_map SEC(".maps");
+
 bool test_sockmap = false; /* toggled by user-space */
 bool test_ingress = false; /* toggled by user-space */
 
 SEC("sk_skb/stream_parser")
 int prog_stream_parser(struct __sk_buff *skb)
 {
+	int *value;
+	__u32 key = 0;
+
+	value = bpf_map_lookup_elem(&parser_map, &key);
+	if (value && *value)
+		return *value;
+
 	return skb->len;
 }
 
-- 
2.30.2


