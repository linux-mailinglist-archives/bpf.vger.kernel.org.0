Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07E4A3612
	for <lists+bpf@lfdr.de>; Sun, 30 Jan 2022 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354723AbiA3Lz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Jan 2022 06:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354718AbiA3LzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Jan 2022 06:55:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF15C061714
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 03:55:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q22so15595367ljh.7
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 03:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OGuBVpqNFoYG8JaqojzZFjInF6N6dne6kUNztCH0Hk=;
        b=GgYxwBxBFNUvM69PA4aVJgdAwsPNg3AMKxZsYKFrFMuQap7+6DLM9+GouRro/PmbqM
         6I6bY9waOh3DhD2LxX6XZeI8FR8nTqNQgJaQNbWzDVIXUbZ+81wKH+Ah06+YPkU04c1j
         fVwwPz2nq01FvCmJm07Tv3jrzTKTyGyK0RgKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OGuBVpqNFoYG8JaqojzZFjInF6N6dne6kUNztCH0Hk=;
        b=cbUCBpzaMXZFZiIpts+h0g3p0DNlRyUTkM3LobGzj6H+tlfWtJdEfiK6s7cDdIFFmY
         Me47RNQBp6bYlc83XAIWl9GOlrb75YSmo8GVXnZD5A6IygnscRuNl7lwRZy79iSGfTmg
         WCqU+3i0q45dj6dEaQg/+IvRHymfU06KkiMAhmDwUPgIqsrVPosQWJInw6oeRHSa9YY4
         A5vMI0GQf5seGwl8mAsEnB3BENh+34f21RbTyDQuTwQthDYGvZDBmXwSa/u9WfVpCtCo
         36gR3NhzG7FCe72xQbYIsrhc6alhRcB+uBsSTi2Mcp2AuxdARep0oZC+jB69jTPG45qD
         l09A==
X-Gm-Message-State: AOAM531pi4YZEcrK14h2DomlNCkoVhKsFab95oGKJYVeSY14GgnGtkR0
        BCP7oUKUm4n6D1YzwFwYUjb9ftpa2RqbsQ==
X-Google-Smtp-Source: ABdhPJwv1XUE+9Qj+xaGcUzHp7DH76pSasv49x8cSJv5vXTTWeZa5uB8CyZHxjyBUh48YCTplW9p5Q==
X-Received: by 2002:a2e:a7ce:: with SMTP id x14mr10812274ljp.222.1643543721914;
        Sun, 30 Jan 2022 03:55:21 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0e00.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id q14sm1503194lfm.120.2022.01.30.03.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:55:21 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads
Date:   Sun, 30 Jan 2022 12:55:18 +0100
Message-Id: <20220130115518.213259-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220130115518.213259-1-jakub@cloudflare.com>
References: <20220130115518.213259-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add coverage to the verifier tests and tests for reading bpf_sock fields to
ensure that 32-bit, 16-bit, and 8-bit loads from dst_port field are allowed
only at intended offsets and produce expected values.

While 16-bit and 8-bit access to dst_port field is straight-forward, 32-bit
wide loads need be allowed and produce a zero-padded 16-bit value for
backward compatibility.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h                |  3 +-
 .../selftests/bpf/prog_tests/sock_fields.c    | 58 +++++++++----
 .../selftests/bpf/progs/test_sock_fields.c    | 41 ++++++++++
 tools/testing/selftests/bpf/verifier/sock.c   | 81 ++++++++++++++++++-
 4 files changed, 162 insertions(+), 21 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4a2f7041ebae..a7f0ddedac1f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5574,7 +5574,8 @@ struct bpf_sock {
 	__u32 src_ip4;
 	__u32 src_ip6[4];
 	__u32 src_port;		/* host byte order */
-	__u32 dst_port;		/* network byte order */
+	__be16 dst_port;	/* network byte order */
+	__u16 :16;		/* zero padding */
 	__u32 dst_ip4;
 	__u32 dst_ip6[4];
 	__u32 state;
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 9fc040eaa482..9d211b5c22c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 
+#define _GNU_SOURCE
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <unistd.h>
+#include <sched.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -20,6 +22,7 @@
 enum bpf_linum_array_idx {
 	EGRESS_LINUM_IDX,
 	INGRESS_LINUM_IDX,
+	READ_SK_DST_PORT_LINUM_IDX,
 	__NR_BPF_LINUM_ARRAY_IDX,
 };
 
@@ -42,8 +45,16 @@ static __u64 child_cg_id;
 static int linum_map_fd;
 static __u32 duration;
 
-static __u32 egress_linum_idx = EGRESS_LINUM_IDX;
-static __u32 ingress_linum_idx = INGRESS_LINUM_IDX;
+static bool create_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return false;
+
+	if (!ASSERT_OK(system("ip link set dev lo up"), "bring up lo"))
+		return false;
+
+	return true;
+}
 
 static void print_sk(const struct bpf_sock *sk, const char *prefix)
 {
@@ -91,19 +102,24 @@ static void check_result(void)
 {
 	struct bpf_tcp_sock srv_tp, cli_tp, listen_tp;
 	struct bpf_sock srv_sk, cli_sk, listen_sk;
-	__u32 ingress_linum, egress_linum;
+	__u32 idx, ingress_linum, egress_linum, linum;
 	int err;
 
-	err = bpf_map_lookup_elem(linum_map_fd, &egress_linum_idx,
-				  &egress_linum);
+	idx = EGRESS_LINUM_IDX;
+	err = bpf_map_lookup_elem(linum_map_fd, &idx, &egress_linum);
 	CHECK(err < 0, "bpf_map_lookup_elem(linum_map_fd)",
 	      "err:%d errno:%d\n", err, errno);
 
-	err = bpf_map_lookup_elem(linum_map_fd, &ingress_linum_idx,
-				  &ingress_linum);
+	idx = INGRESS_LINUM_IDX;
+	err = bpf_map_lookup_elem(linum_map_fd, &idx, &ingress_linum);
 	CHECK(err < 0, "bpf_map_lookup_elem(linum_map_fd)",
 	      "err:%d errno:%d\n", err, errno);
 
+	idx = READ_SK_DST_PORT_LINUM_IDX;
+	err = bpf_map_lookup_elem(linum_map_fd, &idx, &linum);
+	ASSERT_OK(err, "bpf_map_lookup_elem(linum_map_fd, READ_SK_DST_PORT_IDX)");
+	ASSERT_EQ(linum, 0, "failure in read_sk_dst_port on line");
+
 	memcpy(&srv_sk, &skel->bss->srv_sk, sizeof(srv_sk));
 	memcpy(&srv_tp, &skel->bss->srv_tp, sizeof(srv_tp));
 	memcpy(&cli_sk, &skel->bss->cli_sk, sizeof(cli_sk));
@@ -262,7 +278,7 @@ static void test(void)
 	char buf[DATA_LEN];
 
 	/* Prepare listen_fd */
-	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0xcafe, 0);
 	/* start_server() has logged the error details */
 	if (CHECK_FAIL(listen_fd == -1))
 		goto done;
@@ -330,8 +346,12 @@ static void test(void)
 
 void serial_test_sock_fields(void)
 {
-	struct bpf_link *egress_link = NULL, *ingress_link = NULL;
 	int parent_cg_fd = -1, child_cg_fd = -1;
+	struct bpf_link *link;
+
+	/* Use a dedicated netns to have a fixed listen port */
+	if (!create_netns())
+		return;
 
 	/* Create a cgroup, get fd, and join it */
 	parent_cg_fd = test__join_cgroup(PARENT_CGROUP);
@@ -352,15 +372,20 @@ void serial_test_sock_fields(void)
 	if (CHECK(!skel, "test_sock_fields__open_and_load", "failed\n"))
 		goto done;
 
-	egress_link = bpf_program__attach_cgroup(skel->progs.egress_read_sock_fields,
-						 child_cg_fd);
-	if (!ASSERT_OK_PTR(egress_link, "attach_cgroup(egress)"))
+	link = bpf_program__attach_cgroup(skel->progs.egress_read_sock_fields, child_cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(egress_read_sock_fields)"))
+		goto done;
+	skel->links.egress_read_sock_fields = link;
+
+	link = bpf_program__attach_cgroup(skel->progs.ingress_read_sock_fields, child_cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(ingress_read_sock_fields)"))
 		goto done;
+	skel->links.ingress_read_sock_fields = link;
 
-	ingress_link = bpf_program__attach_cgroup(skel->progs.ingress_read_sock_fields,
-						  child_cg_fd);
-	if (!ASSERT_OK_PTR(ingress_link, "attach_cgroup(ingress)"))
+	link = bpf_program__attach_cgroup(skel->progs.read_sk_dst_port, child_cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(read_sk_dst_port"))
 		goto done;
+	skel->links.read_sk_dst_port = link;
 
 	linum_map_fd = bpf_map__fd(skel->maps.linum_map);
 	sk_pkt_out_cnt_fd = bpf_map__fd(skel->maps.sk_pkt_out_cnt);
@@ -369,8 +394,7 @@ void serial_test_sock_fields(void)
 	test();
 
 done:
-	bpf_link__destroy(egress_link);
-	bpf_link__destroy(ingress_link);
+	test_sock_fields__detach(skel);
 	test_sock_fields__destroy(skel);
 	if (child_cg_fd >= 0)
 		close(child_cg_fd);
diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 81b57b9aaaea..246f1f001813 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -12,6 +12,7 @@
 enum bpf_linum_array_idx {
 	EGRESS_LINUM_IDX,
 	INGRESS_LINUM_IDX,
+	READ_SK_DST_PORT_LINUM_IDX,
 	__NR_BPF_LINUM_ARRAY_IDX,
 };
 
@@ -250,4 +251,44 @@ int ingress_read_sock_fields(struct __sk_buff *skb)
 	return CG_OK;
 }
 
+static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
+{
+	__u32 *word = (__u32 *)&sk->dst_port;
+	return word[0] == bpf_htonl(0xcafe0000);
+}
+
+static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
+{
+	__u16 *half = (__u16 *)&sk->dst_port;
+	return half[0] == bpf_htons(0xcafe);
+}
+
+static __noinline bool sk_dst_port__load_byte(struct bpf_sock *sk)
+{
+	__u8 *byte = (__u8 *)&sk->dst_port;
+	return byte[0] == 0xca && byte[1] == 0xfe;
+}
+
+SEC("cgroup_skb/egress")
+int read_sk_dst_port(struct __sk_buff *skb)
+{
+	__u32 linum, linum_idx;
+	struct bpf_sock *sk;
+
+	linum_idx = READ_SK_DST_PORT_LINUM_IDX;
+
+	sk = skb->sk;
+	if (!sk)
+		RET_LOG();
+
+	if (!sk_dst_port__load_word(sk))
+		RET_LOG();
+	if (!sk_dst_port__load_half(sk))
+		RET_LOG();
+	if (!sk_dst_port__load_byte(sk))
+		RET_LOG();
+
+	return CG_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index ce13ece08d51..8c224eac93df 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -121,7 +121,25 @@
 	.result = ACCEPT,
 },
 {
-	"sk_fullsock(skb->sk): sk->dst_port [narrow load]",
+	"sk_fullsock(skb->sk): sk->dst_port [word load] (backward compatibility)",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = ACCEPT,
+},
+{
+	"sk_fullsock(skb->sk): sk->dst_port [half load]",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
@@ -139,7 +157,64 @@
 	.result = ACCEPT,
 },
 {
-	"sk_fullsock(skb->sk): sk->dst_port [load 2nd byte]",
+	"sk_fullsock(skb->sk): sk->dst_port [half load] (invalid)",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = REJECT,
+	.errstr = "invalid sock access",
+},
+{
+	"sk_fullsock(skb->sk): sk->dst_port [byte load]",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
+	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = ACCEPT,
+},
+{
+	"sk_fullsock(skb->sk): sk->dst_port [byte load] (invalid)",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = REJECT,
+	.errstr = "invalid sock access",
+},
+{
+	"sk_fullsock(skb->sk): past sk->dst_port [half load] (invalid)",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
@@ -149,7 +224,7 @@
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 1),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_sock, dst_port)),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-- 
2.31.1

