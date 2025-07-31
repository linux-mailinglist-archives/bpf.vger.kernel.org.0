Return-Path: <bpf+bounces-64801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24135B16F92
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03022625005
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DD2BF3FB;
	Thu, 31 Jul 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PW5q86Hb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAB2BE625
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957730; cv=none; b=eKV0NFFZ/NnuGvtpoo5jjEta4I/K46RSi4Q68UM9lvgwe+/GCD/gpRZWCC2QuHBNd5qnfzwROo6pykZy9mIxI3gHpKCVUr9nxbUZI6G0FJmjoNvb/wCNaFvctY9xU7Lzm104LMJMRf//YllgJCMjhhZWGEzuZ6Oe49qkR9sP/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957730; c=relaxed/simple;
	bh=7UvyphdaVIB//XC4RA5/U67KMJuU1XG+T1JFMrFABC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/3/Y+llfB+2wAVjJF+7HqpvDDbivSDXq/faBYxuHtZNEzQgOqIjwqHAzIAIwPVxDnKnLl2hbgfN1njiN90tN9qgeiSTtayG7MdrpIYgZl/qBlmxKcz4P/b0tC70xyXp2tw6khK5LmArJKA+383lWHG/BJwcsxtsgkvb0mCrwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PW5q86Hb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so774495a12.2
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957726; x=1754562526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKWHRUWZ4bCkrFyfjSsPUbbQJJxOld/CeXkJl8Rm6cQ=;
        b=PW5q86HbKo2X0yHKCqLC0AIR++oi1ZaFAc9UsaXAYcAp6cy9CvXA+TU0sB7Y1tEehD
         VgN8BflTb5GmTJD6wIp6rYYVQkH8TpXlhYlvdwzUTGyhGhmDh4S6Ci/iICqIvqvqL4hQ
         8HfkXrz/0YOA5xlbhNsdrlE1aYTjCxm5aw5EL4tBLkG3QRn1bdO5c1gQU8XM6Q3O61rz
         HRPN09PJBSd9oGIDZmOlzfGg1jLOxuYYvX3MY5gvQhkSiC2brkyNGYvigJGRaMBTATOH
         oJPMXXcGJv2OJ2XjLxYgjcrKUu/Qqo9/NP0J/rVZrOC7pyQ1MH5/AAXqNJxPgwjMih06
         x93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957726; x=1754562526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKWHRUWZ4bCkrFyfjSsPUbbQJJxOld/CeXkJl8Rm6cQ=;
        b=FBxC3RC75qNETP4QmCHgjkDHzUvgwMcR7VKB9olg+E6av0HQP+hULSx0TQHaaTprlF
         3yWQGy/iIzJNDlsmGyypXgyOsanf4X9vE119Rx0VXa5tdUvj/xYFaB24LkPFPJVYlTQu
         MdHE523llMU8bCCK+OOfwO2Lt5QuJlyzoGjKf1fpXRjBTp5+HiLYvbsiQlE00IgFu0Q/
         fhtFYJyO45ILPyfCq9GmkjSa9vi09mec9CAAuQbxXR+/a6xjtlIfU6rFe3uE6mMiLH0V
         G+MNeY9nQqwTlMgV1uL+1zM8BzoLRXuWuT2fWcN8T8VnFvpZihPCebKHFqeBqk8tGq9y
         3+7g==
X-Gm-Message-State: AOJu0Yykk9oR24w/vtyBU147eC2mXf6Le1wptNdI1txYaA88JLp9cJkc
	tUVBEF8pLHBGizuG450tPBd8/9YpFiIq9uoPcQv/X9GLocVSIAd5Se+A7Zifq4ZIMD4=
X-Gm-Gg: ASbGncsN2BnBWgAU/FqyOmKnUxQ8nYFh6KiBrwh88pavsgirZrYWN3ez2lcAWPupP7K
	R3oB+JOOTRXUMkzJ2bRY2BsdXTRWRBz6ZiaRbLrMIxZ8ERHPb5AMPSewsS7/AHxSN0Bve4jqijA
	QBk9lO7lSNcCzKvamq3M4UXSJOHJjkpGr5qee9OImCN625/gmOFv2sjSpsJgrzIv3aFZdKPU9z2
	wnB2TpL9ZzGUWIY3mRHVvM2Gg+oAx8gMBiwpY2G9AcrHVpgnd/tjIwM8Pm8mAHUrhpz81PZF3Hz
	m1PVB3VGhqp1eE2ZTuqyJawQln9E5/uQDt+by4o1zJcrcOOUATsOQBxSvMwKP8xejO4RcoYkk3O
	9dhgTNxrGfz1wBoo=
X-Google-Smtp-Source: AGHT+IHViiWrFkxObOmApmzHCjOcn8xoGdCp8fk00pwc8CyCvgiRWvb4IeKJOgdcLpPd7QPTB1gMQw==
X-Received: by 2002:a17:907:7f29:b0:ae3:6390:6acc with SMTP id a640c23a62f3a-af8fd779571mr857948866b.27.1753957726387;
        Thu, 31 Jul 2025 03:28:46 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8365sm88014166b.76.2025.07.31.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:23 +0200
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-9-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Demonstrate that skb metadata currently gets cleared when a BPF program
which might modify the payload processes a cloned packet.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 107 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  52 ++++++++++
 2 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 24a7b4b7fdb6..9bb249ff23c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -9,6 +9,7 @@
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
 #define TAP_NAME "tap0"
+#define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
@@ -156,6 +157,22 @@ static int send_test_packet(int ifindex)
 	return -1;
 }
 
+static int write_test_packet(int tap_fd)
+{
+	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	int n;
+
+	/* The ethernet header doesn't need to be valid for this test */
+	memset(packet, 0, sizeof(struct ethhdr));
+	memcpy(packet + sizeof(struct ethhdr), test_payload, TEST_PAYLOAD_LEN);
+
+	n = write(tap_fd, packet, sizeof(packet));
+	if (!ASSERT_EQ(n, sizeof(packet), "write packet"))
+		return -1;
+
+	return 0;
+}
+
 static void assert_test_result(const struct bpf_map *result_map)
 {
 	int err;
@@ -276,7 +293,6 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *ns = NULL;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
 	int ret;
@@ -322,19 +338,82 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
 
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+	assert_test_result(result_map);
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+/* Write a packet to a tap dev and copy it to ingress of a dummy dev */
+static void test_tuntap_mirred(struct bpf_program *xdp_prog,
+			       struct bpf_program *tc_prog,
+			       bool *test_pass)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_fd = -1;
+	int tap_ifindex;
+	int ret;
 
-	ret = write(tap_fd, packet, sizeof(packet));
-	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
+	*test_pass = false;
+
+	ns = netns_new(TAP_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Setup dummy interface */
+	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
+	SYS(close, "ip link set dev " DUMMY_NAME " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_NAME);
+	if (!ASSERT_GE(dummy_ifindex, 0, "if_nametoindex"))
 		goto close;
 
-	assert_test_result(result_map);
+	tc_hook.ifindex = dummy_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	/* Setup TAP interface */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
+		goto close;
+
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog), 0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	/* Copy all packets received from TAP to dummy ingress */
+	SYS(close, "tc qdisc add dev " TAP_NAME " clsact");
+	SYS(close, "tc filter add dev " TAP_NAME " ingress "
+		   "protocol all u32 match u32 0 0 "
+		   "action mirred ingress mirror dev " DUMMY_NAME);
+
+	/* Receive a packet on TAP */
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(*test_pass, "test_pass");
 
 close:
 	if (tap_fd >= 0)
@@ -385,6 +464,14 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    skel->maps.test_result);
+	if (test__start_subtest("skb_clone_data_meta_empty"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.ing_cls_data_meta_empty,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("skb_clone_dynptr_empty"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.ing_cls_dynptr_empty,
+				   &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index ee3d8adf5e9c..b2363852479c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -26,6 +26,8 @@ struct {
 	__uint(value_size, META_SIZE);
 } test_result SEC(".maps");
 
+bool test_pass;
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -43,6 +45,56 @@ int ing_cls(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Check that skb->data_meta..skb->data is empty */
+SEC("tc")
+int ing_cls_data_meta_empty(struct __sk_buff *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	/* Expect no metadata */
+	if (ctx->data_meta < ctx->data)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/* Check that skb_meta dynptr is empty */
+SEC("tc")
+int ing_cls_dynptr_empty(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	struct ethhdr *eth;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));
+	if (!eth)
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	/* Expect no metadata */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_size(&meta) > 0)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 /* Read from metadata using bpf_dynptr_read helper */
 SEC("tc")
 int ing_cls_dynptr_read(struct __sk_buff *ctx)

-- 
2.43.0


