Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491E0585BCB
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiG3Tkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jul 2022 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiG3Tko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jul 2022 15:40:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64534167C4;
        Sat, 30 Jul 2022 12:40:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC4675C00D3;
        Sat, 30 Jul 2022 15:40:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 30 Jul 2022 15:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659210040; x=1659296440; bh=dP
        xSBr5Vd3gl0nFWhvgR0cMB3HmS0oxvmaY/XsKKQ90=; b=Nyzm7ibEc5LCHT6gCZ
        7gbLuSxnDUxS8Qh5f/AS/4QiLU/OZTR3Tk1wWaYbKU8rwIp1bZIUZ3lSwyjyrKHo
        aPTvoFiupq+wvjJ7VmFm/0FK0hC7BT5JVRKZD0woUv/kPeLmw/o/9Q5wHk+4g5P4
        zAZqJCfUvx9M6Ojg++ezNYGlMapOO/uk8ldd+xJmnznH7Ma5C/0UG3jyuoI8TI12
        4x/pvJ6oH3wQgLbsFnOw9bn4GWNu56brwUQQs2MytXDm1+sIHq2u+59MkqVL4Y0n
        edN7V3G/DskTII+Ur94maZ5+Ziup3YmoP8pC6g2nJqWMwxJDsEva6CiaHJUtKYka
        PKWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659210040; x=1659296440; bh=dPxSBr5Vd3gl0
        nFWhvgR0cMB3HmS0oxvmaY/XsKKQ90=; b=CuT0YccXhTpbK5OBM5SFNFeLBLghm
        8ut0zbxb/lnVW+wCDgCkAO8oH2VcbKe7YDZES8NQx+xrbZc5EkRZVMpBDrxGXFCv
        Kul3AfS5G1sCI4HCSgnx6LWcnez+NfkM6hMk2sxuC/l+NYABdeKjkoPxjl5upv7B
        0wqMxqS8dILZ3c7nb+JdstXPlk1rsei56otFNd7nfvlEC+B22Ps26qmHOOoW0E/u
        XQoMB6jgX5uBHPUDYLnDHIo2PdTq+afTsQYVaep1SKxZ1l84axOPcM44L5hByJym
        gxMa055YQkBPis5TtHrMhrMyYBXeyJHVn8T5loeG4r/JCKq5P++pKKxtQ==
X-ME-Sender: <xms:OInlYmeWeqWxqTBLmK09Vzilm-Ls3rwDb1thslBWarELrnMuPzVbWA>
    <xme:OInlYgOwPNlAezorFNGfyJ01pzu6J_9g32s1j1WwI8yWJfnURX-Z1e8-QSKzt6o_n
    wUSNooS0GSOGk23aw>
X-ME-Received: <xmr:OInlYnj7Hdl2qMu-ghclupneYHIkIuZ4a9rODYS4-9zJbmklZavhOnVQcKixfaPSv5jDsAL9uXJR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduledgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefhjeehjeeljedtle
    eifedujedvuedtteeuveekheduueehleettefhueektdeifeenucffohhmrghinhepihhp
    vhegrdhsphhorhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:OInlYj9ONYknAtvW53ql_WHCSZxxvK_au4do3TTz1nLdLfQzk6s_-Q>
    <xmx:OInlYiuvVlCEMmlaKJxQe_MAQFRlX2uPexRToqOhkO6o2fNpuRQkcg>
    <xmx:OInlYqHT01wYa-ic7MShzXaPk6cB2d8cygEnAKGtIAzJ7EbtsEc6uQ>
    <xmx:OInlYkWbJnIDEdeetW53UqMnSf1gU3cmEsiktQCyMQGHtr43q9gStw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Jul 2022 15:40:40 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add existing connection bpf_*_ct_lookup() test
Date:   Sat, 30 Jul 2022 14:40:29 -0500
Message-Id: <275291d40d75d4b39b805d4c155f258131f67264.1659209738.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659209738.git.dxu@dxuuu.xyz>
References: <cover.1659209738.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test where we do a conntrack lookup on an existing connection.
This is nice because it's a more realistic test than artifically
creating a ct entry and looking it up afterwards.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c | 59 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 18 ++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index 7a74a1579076..317978cac029 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -24,10 +24,34 @@ enum {
 	TEST_TC_BPF,
 };
 
+#define TIMEOUT_MS 3000
+
+static int connect_to_server(int srv_fd)
+{
+	int fd = -1;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto out;
+
+	if (CHECK_FAIL(connect_fd_to_fd(fd, srv_fd, TIMEOUT_MS))) {
+		close(fd);
+		fd = -1;
+	}
+out:
+	return fd;
+}
+
 static void test_bpf_nf_ct(int mode)
 {
+	const char *iptables = "iptables -t raw %s PREROUTING -j CT";
+	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
+	struct sockaddr_in peer_addr = {};
 	struct test_bpf_nf *skel;
 	int prog_fd, err;
+	socklen_t len;
+	u16 srv_port;
+	char cmd[64];
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
@@ -38,6 +62,32 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
 		return;
 
+	/* Enable connection tracking */
+	snprintf(cmd, sizeof(cmd), iptables, "-A");
+	if (!ASSERT_OK(system(cmd), "iptables"))
+		goto end;
+
+	srv_port = (mode == TEST_XDP) ? 5005 : 5006;
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", srv_port, TIMEOUT_MS);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto end;
+
+	client_fd = connect_to_server(srv_fd);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
+		goto end;
+
+	len = sizeof(peer_addr);
+	srv_client_fd = accept(srv_fd, (struct sockaddr *)&peer_addr, &len);
+	if (!ASSERT_GE(srv_client_fd, 0, "accept"))
+		goto end;
+	if (!ASSERT_EQ(len, sizeof(struct sockaddr_in), "sockaddr len"))
+		goto end;
+
+	skel->bss->saddr = peer_addr.sin_addr.s_addr;
+	skel->bss->sport = peer_addr.sin_port;
+	skel->bss->daddr = peer_addr.sin_addr.s_addr;
+	skel->bss->dport = htons(srv_port);
+
 	if (mode == TEST_XDP)
 		prog_fd = bpf_program__fd(skel->progs.nf_xdp_ct_test);
 	else
@@ -63,7 +113,16 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_LE(skel->bss->test_delta_timeout, 10, "Test for max ct timeout update");
 	/* expected status is IPS_SEEN_REPLY */
 	ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
+	ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
 end:
+	if (srv_client_fd != -1)
+		close(srv_client_fd);
+	if (client_fd != -1)
+		close(client_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	snprintf(cmd, sizeof(cmd), iptables, "-D");
+	system(cmd);
 	test_bpf_nf__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 196cd8dfe42a..84e0fd479794 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -23,6 +23,11 @@ int test_insert_entry = -EAFNOSUPPORT;
 int test_succ_lookup = -ENOENT;
 u32 test_delta_timeout = 0;
 u32 test_status = 0;
+__be32 saddr = 0;
+__be16 sport = 0;
+__be32 daddr = 0;
+__be16 dport = 0;
+int test_exist_lookup = -ENOENT;
 
 struct nf_conn;
 
@@ -160,6 +165,19 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		}
 		test_alloc_entry = 0;
 	}
+
+	bpf_tuple.ipv4.saddr = saddr;
+	bpf_tuple.ipv4.daddr = daddr;
+	bpf_tuple.ipv4.sport = sport;
+	bpf_tuple.ipv4.dport = dport;
+	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		       sizeof(opts_def));
+	if (ct) {
+		test_exist_lookup = 0;
+		bpf_ct_release(ct);
+	} else {
+		test_exist_lookup = opts_def.error;
+	}
 }
 
 SEC("xdp")
-- 
2.37.1

