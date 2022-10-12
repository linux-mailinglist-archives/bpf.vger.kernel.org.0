Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313EA5FCE3B
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJLWNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJLWNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 18:13:02 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CF1C7
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 15:12:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665612767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1tK3z5j2suAdyr7k44ieMwf0RSff7wXk+c5K5KVORxY=;
        b=qPZ7if+Bw7CXeI734zJ2ulkX66Eld9ATrKCAGU5N+V4KNRVqRBHVZNDhXZQYPiF5Vrtid0
        VQ03s2zfxmjK0ux2zBtsFU6fIU9qcbXbrrGajSb90yXoODWnbbFd8GaeZkbyOX+tDlQLL/
        2CYvt9uDCZBq+ZAfYcYg6o0Fmi/uuUE=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        kernel-team@fb.com, Manu Bretelle <chantra@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: s/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test
Date:   Wed, 12 Oct 2022 15:12:35 -0700
Message-Id: <20221012221235.3529719-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The recent vm image in CI has reported error in selftests that use
the iptables command.  Manu Bretelle has pointed out the difference
in the recent vm image that the iptables is sym-linked to the iptables-nft.
With this knowledge,  I can also reproduce the CI error by manually running
with the 'iptables-nft'.

This patch is to replace the iptables command with iptables-legacy
to unblock the CI tests.

Cc: Manu Bretelle <chantra@meta.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c       | 6 +++---
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index 8a838ea8bdf3..c8ba4009e4ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -49,14 +49,14 @@ static int connect_to_server(int srv_fd)
 
 static void test_bpf_nf_ct(int mode)
 {
-	const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
+	const char *iptables = "iptables-legacy -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
 	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
 	struct sockaddr_in peer_addr = {};
 	struct test_bpf_nf *skel;
 	int prog_fd, err;
 	socklen_t len;
 	u16 srv_port;
-	char cmd[64];
+	char cmd[128];
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
@@ -69,7 +69,7 @@ static void test_bpf_nf_ct(int mode)
 
 	/* Enable connection tracking */
 	snprintf(cmd, sizeof(cmd), iptables, "-A");
-	if (!ASSERT_OK(system(cmd), "iptables"))
+	if (!ASSERT_OK(system(cmd), cmd))
 		goto end;
 
 	srv_port = (mode == TEST_XDP) ? 5005 : 5006;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index 75550a40e029..c72083885b6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -94,12 +94,12 @@ static void test_synproxy(bool xdp)
 	SYS("sysctl -w net.ipv4.tcp_syncookies=2");
 	SYS("sysctl -w net.ipv4.tcp_timestamps=1");
 	SYS("sysctl -w net.netfilter.nf_conntrack_tcp_loose=0");
-	SYS("iptables -t raw -I PREROUTING \
+	SYS("iptables-legacy -t raw -I PREROUTING \
 	    -i tmp1 -p tcp -m tcp --syn --dport 8080 -j CT --notrack");
-	SYS("iptables -t filter -A INPUT \
+	SYS("iptables-legacy -t filter -A INPUT \
 	    -i tmp1 -p tcp -m tcp --dport 8080 -m state --state INVALID,UNTRACKED \
 	    -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460");
-	SYS("iptables -t filter -A INPUT \
+	SYS("iptables-legacy -t filter -A INPUT \
 	    -i tmp1 -m state --state INVALID -j DROP");
 
 	ctrl_file = SYS_OUT("./xdp_synproxy --iface tmp1 --ports 8080 \
-- 
2.30.2

