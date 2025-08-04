Return-Path: <bpf+bounces-64999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546EB1A26B
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C8B16B9A9
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778A26E71B;
	Mon,  4 Aug 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S/hH96Zl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4826E16F
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311983; cv=none; b=EgICJr5ZsDdWL9ZjznCDSGOfEe5YuCSxB1ftF4yVz+JBGwck93aUkIfZxg3rbJdL/fYNp7yKF2xJmAfunsPcpx+JA9gEVotXZfbdjfp6rfiAxWmVXODpmetp6EKLrVLoI+784FIvdFf2hjNlrFRtBGkJdZaAkf6/mIQhBVinOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311983; c=relaxed/simple;
	bh=hs4JAy0dLfj58EnblxsHu01VmyLeXShKcb3UewIRrl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9vemosnPlNDqTosBq2xEWPEsdbinjstlPZy71ADkmyxMPfO1zXr99DHQcl2INeN2Jh4BFDDx37BIFnPNXlleH4X+6MJB7Kv2+jZPo5V9qiVr4YHX1opVk8PNmZRSdRmRUOeF47d/DUsSF5Fg0vF9uLLuCrgbckdpJ/bp0g4FUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S/hH96Zl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so5834520a12.2
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311980; x=1754916780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4pQfdGG1z5XXA6Mz/eRbTIBT31qa408vIbK4b4R2Ys=;
        b=S/hH96ZlIvpYuf+rxrOsWqvL9TSiwx8nTDxtptvl7jtypi71uANkyGau66QlCaP8eI
         /rc9vKsDEuMUD7i+5XpPRSKATyq9ZpItfQXHrfVbHyAUXOKT+MxBSVZ4YXbAXuocYL4C
         TVnHyaaBZ3hpzME126eIO0GVL+38FfysKd8EC+V0TN40TKCTlgH4CX9r5hhiEG99Vg8c
         zT8wtTHV37JS5zsXFOPtnAF6kDUtnFEouVlN3YoM0cm/WqHasSoYnc05qlyBqamTHVOn
         4/cA9jT/eLgGoZ643mB6I94dH1I5zzC7J6nZAxZ42aorIWILqLR22OhpvocyiOK/WGMF
         Bwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311980; x=1754916780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4pQfdGG1z5XXA6Mz/eRbTIBT31qa408vIbK4b4R2Ys=;
        b=g5F1sIv67+r7oNKsXrTPg2Eu7lwCAT/uXsglm+uf3oejwX6sdN1FQUcgYD60rekamI
         RDBXNG6wYCHf+mNIqky1D8/Lo5a//Q9VDVP7XVYmm250Zx4MBrDObCtnqXimRlnu/gMc
         /m9LDxXU0dLR1IsBNC95hWF5NPEKJP56ZUI29r68qTMy2xRSso5EtnYoieMi83K/0Wxk
         BSCkZfiKHQGdloIpIeLLAox5QUKziAixuFptixqUdwplpg2G1OJ3xFJpEf4koCZYQ6tw
         1cxRZx4zcQ676YoEnJYakEL0KLBGc2uP4vu7vpDJcnxCCM4s2pZKo2QT/Djt7nqrdVHA
         NPpA==
X-Gm-Message-State: AOJu0YzKKpQ7AlfOxW9c+k3plswV6H/Mc1iWbAc9aTRO0EbWxnxOaMtq
	ITjRmzANnNup1bXltXfPiY8VkTXfPt1/atm/E1X+vAiT7xqmwRxU6V2PMk7yLbA+SSk=
X-Gm-Gg: ASbGncs+qi++lW9CEzsDmDg6i9PoZG6vlNmPvpSws5VxHalkDL0W/mwel3AoEW5Sa0O
	IqTIYP43O+SJgGEl2r/Z4uLsFAIwWQENx5UmSwii8ijZv8fdKF2S6LXAueinCbXl80ZDIAAWGjd
	lp7gy0u5z94hYNerKMiZeK3f/fKjJyYChu/mJHjN4uqpVTuTRlKdw2P8d1AcDWdRP93aYHKUYot
	MOaHZa6hj8z61xsssM2xmd1m0w7gmMbCY7DwVOt2RKExK/3eKTPF0qAXCvZv0r+vsEkhZ+6MJzb
	BvSf0vNgkb22SYtE1XjnDVTYaaHmFMq7kc9ys76wLrH+KYZjJl0Z3NTjZBk1cDj8PdHTV3iqs5T
	E8O/feKlp635dlDpzl32N/tNxcEtON5Y=
X-Google-Smtp-Source: AGHT+IFboy0SUNyOf5SrotPSmAV8WSaJe6NhkOucnxu+J+ZooQ08qDWDHLaF1HAdZBLlQQrdyB2Itw==
X-Received: by 2002:aa7:ce03:0:b0:615:6c92:aecc with SMTP id 4fb4d7f45d1cf-615e715f96bmr6485796a12.27.1754311979999;
        Mon, 04 Aug 2025 05:52:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f000c3sm6882825a12.4.2025.08.04.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:32 +0200
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
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
 tools/testing/selftests/bpf/config                 |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 107 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  52 ++++++++++
 3 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8916ab814a3e..70b28c1e653e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -61,6 +61,7 @@ CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
 CONFIG_NET_ACT_GACT=y
+CONFIG_NET_ACT_MIRRED=y
 CONFIG_NET_ACT_SKBMOD=y
 CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 24a7b4b7fdb6..6a59297f3f8d 100644
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
+		   "protocol all matchall "
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


