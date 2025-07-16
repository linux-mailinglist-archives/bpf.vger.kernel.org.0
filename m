Return-Path: <bpf+bounces-63463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1AB07B03
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3138456697E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A82F85C7;
	Wed, 16 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KKyjr2Ln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AC2F7D05
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682703; cv=none; b=lKb6zCxsGh+RCG5FMOQrjYGg5cZTT/GP/7A3u9yt1ZigetdZ0MtxB16pSNINlcqSvoTerZRFya2OQCVCAeTNcV2Aw308HJNLlECoke8zvuWVETXOVb38V0gZvfj8eKyGhc3JP6eQnsd2qwVq7s9poS3p9XaPBC0aOoa281yQ6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682703; c=relaxed/simple;
	bh=nmrWICZ6sC0GiCREMZnd4dDFEn/w1jxMkGsMLm5qZBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2QiSRXiLPKmwx7N9wUZOVRdHmW3CJa55109T3C30wR4awofVFUu+NinZIcPO4WM8VGJbXW4384hQSyrDaeApQCn/6JGnAvbNunZi2PaICsZq59W9oMLmu+qcwjDKhEsy+0VtEw12S5lys0B8tBI0a6qZjxPEo6Kj+LLloBcUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KKyjr2Ln; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55502821bd2so66355e87.2
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682700; x=1753287500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK7lG1pDGeFo+ydjUJgmH+GwzbMyw2KIaRIMzfyHLto=;
        b=KKyjr2LnRG6RtxgvXvF7cYhoOzhmsWzZF39GRypPvhBDAz3l+rix/f65rzRKy+y1Mo
         yuPiWcLjLE4P/Vaf4qoyVaYicS2/npSaesejXSTu8Jh89DJgoz/PGytW2W5H0TYTBBaG
         6XdR0M1TJs/SWPJgBhq06xx/oul4h4LkvlLfY4UvX00qX1dPsXA8mZ+OAHRdmPUseTgj
         pPx2q5GTASnMLwboeDl7Uj0dXQRCyTonSWZuEJDC1DnuEoUYakAmIh750IxD6IBwR3HL
         k+JKnuZjeQ4MlFUDaxfhIDuO8jrE9RI/qkCuZwKNSzLh+JGtFqg0ky3qRGmEFRCD1/2C
         +x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682700; x=1753287500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK7lG1pDGeFo+ydjUJgmH+GwzbMyw2KIaRIMzfyHLto=;
        b=tlP0JOw4gNuxownBN3G7Hm7IpzxRfJy8Z1Z2LIOUnqDrEN06JDrg7zng4Dpsub0vhG
         NfUpCqSfCjBwF5GKoCj3HHYoHgjTfCmQwdd0sZbt5AkQfHjPlEeQT1KBQZL3B21OZd0r
         CyBLUXhsqWnJ3tyAidXVm2O/j/OD+691c2npO2J3iKEuqTcFDj9Vz471pg3rhx9h/BaD
         kmNpWubKb1WfMsjD3zhIo6TYJ8TpylaUi84nzsxAvrHMVB7w7H9UMnmvKYytcB/0HFsR
         UinMYHWVUOFf1Pq9MdkTIzm2OY3CXCCxPzgJorCkey6Qn0Ch0M3jTTBKU9NIYbzS7xLh
         A/vQ==
X-Gm-Message-State: AOJu0Ywho0xCUfnHRH87t0J5gWLF0v8FnOjFbHjQRxDLKIgKIx4gicuc
	jE6VRQAePPAKlxGTVDwXuHVW/1xHIbSAlAiIlntETcYuw+PJgf8ZwCNkbdItaEzDCXE=
X-Gm-Gg: ASbGnctB8Eca4VhyGBrodcmxQZw6qNK3lIOeRUEPx39fof9ZuNPCbjKtaOVG7fOYPFY
	UMWByEjbr6VmlEpcv3TKwJ1stiYoaOJ9xj7vtL/QO2eao6jskl/50eahTv9aXpz++lzqZb47hI8
	Ab2xFTYbvMoOLUV2sL2l4xj6/tTI9F22uAlLy66aNjs/ZMLMgj4iOVImFnG/8ySM4rGhGrfeonS
	Mo+/rDyX0nA4I14FstzLma3qBODX3gs4n8aKFMdv3Qwg0bEFCXzMrrV9UeMoXTGi+hRmzOi3yRi
	k/leemJcL+rASq818WYt2AVa2TRKGlourzuImtns6YbtaOfy7EMr9Ko+WPX6iCwRoX6G9T0htjM
	RTNsZLQJ7rbme2PWZJPlLPDl1vGmjVTdp9NmC1QJ5z5fo96TqYptJLz7O29X8aLVdhvNn
X-Google-Smtp-Source: AGHT+IHnCLWsB2WxfIEk0mLNqCQPeyAvaHgBKIMKvdI5vsI5r875f6X+MQfBE+kbZ501qPpsGIBSPQ==
X-Received: by 2002:a05:6512:61c:10b0:553:3492:b708 with SMTP id 2adb3069b0e04-55a23f87f69mr728217e87.49.1752682699484;
        Wed, 16 Jul 2025 09:18:19 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbf49sm2676931e87.15.2025.07.16.09.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:56 +0200
Subject: [PATCH bpf-next v2 12/13] selftests/bpf: Cover lack of access to
 skb metadata at ip layer
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-12-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Currently we don't expect skb metadata to persist beyond the device hooks.
Extend the test run BPF program from the Netfilter pre-routing hook to
verify this behavior.

Note, that the added test has no observable side-effect yet. This will be
addressed by the next change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 95 ++++++++++++++++------
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 64 ++++++++++-----
 tools/testing/selftests/bpf/test_progs.h           |  1 +
 3 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 602fa69afecb..97e1dae9a2e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -19,6 +19,9 @@ static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+#define PACKET_LEN \
+	(sizeof(struct ethhdr) + sizeof(struct iphdr) + TEST_PAYLOAD_LEN)
+
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
 			    __u32 data_meta, __u32 data, __u32 data_end,
 			    __u32 ingress_ifindex, __u32 rx_queue_index,
@@ -120,18 +123,38 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_test_run__destroy(skel);
 }
 
+static void init_test_packet(__u8 *pkt)
+{
+	struct ethhdr *eth = &(struct ethhdr){
+		.h_dest = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 },
+		.h_source = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 },
+		.h_proto = htons(ETH_P_IP),
+	};
+	struct iphdr *iph = &(struct iphdr){
+		.ihl = 5,
+		.version = IPVERSION,
+		.ttl = IPDEFTTL,
+		.protocol = 61, /* host internal protocol */
+		.saddr = inet_addr("10.0.0.2"),
+		.daddr = inet_addr("10.0.0.1"),
+	};
+
+	eth = memcpy(pkt, eth, sizeof(*eth));
+	pkt += sizeof(*eth);
+	iph = memcpy(pkt, iph, sizeof(*iph));
+	pkt += sizeof(*iph);
+	memcpy(pkt, test_payload, sizeof(test_payload));
+
+	iph->tot_len = htons(sizeof(*iph) + sizeof(test_payload));
+	iph->check = build_ip_csum(iph);
+}
+
 static int send_test_packet(int ifindex)
 {
+	__u8 packet[PACKET_LEN];
 	int n, sock = -1;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
-
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
 
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+	init_test_packet(packet);
 
 	sock = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
 	if (!ASSERT_GE(sock, 0, "socket"))
@@ -271,17 +294,18 @@ void test_xdp_context_veth(void)
 static void test_tuntap(struct bpf_program *xdp_prog,
 			struct bpf_program *tc_prio_1_prog,
 			struct bpf_program *tc_prio_2_prog,
+			struct bpf_program *nf_prog,
 			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
-	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *nf_link = NULL;
 	struct netns_obj *ns = NULL;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	__u8 packet[PACKET_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
 	int ret;
 
-	if (!clear_test_result(result_map))
+	if (result_map && !clear_test_result(result_map))
 		return;
 
 	ns = netns_new(TAP_NETNS, true);
@@ -292,6 +316,8 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
 		goto close;
 
+	SYS(close, "ip link set dev " TAP_NAME " addr 02:00:00:00:00:01");
+	SYS(close, "ip addr add dev " TAP_NAME " 10.0.0.1/24");
 	SYS(close, "ip link set dev " TAP_NAME " up");
 
 	tap_ifindex = if_nametoindex(TAP_NAME);
@@ -303,10 +329,14 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(tc_prio_1_prog);
-	ret = bpf_tc_attach(&tc_hook, &tc_opts);
-	if (!ASSERT_OK(ret, "bpf_tc_attach"))
-		goto close;
+	if (tc_prio_1_prog) {
+		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1,
+			    .prog_fd = bpf_program__fd(tc_prio_1_prog));
+
+		ret = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(ret, "bpf_tc_attach"))
+			goto close;
+	}
 
 	if (tc_prio_2_prog) {
 		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 2,
@@ -317,28 +347,33 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 			goto close;
 	}
 
+	if (nf_prog) {
+		LIBBPF_OPTS(bpf_netfilter_opts, nf_opts,
+			    .pf = NFPROTO_IPV4, .hooknum = NF_INET_PRE_ROUTING);
+
+		nf_link = bpf_program__attach_netfilter(nf_prog, &nf_opts);
+		if (!ASSERT_OK_PTR(nf_link, "attach_netfilter"))
+			goto close;
+	}
+
 	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
-
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
-
+	init_test_packet(packet);
 	ret = write(tap_fd, packet, sizeof(packet));
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(result_map);
+	if (result_map)
+		assert_test_result(result_map);
 
 close:
 	if (tap_fd >= 0)
 		close(tap_fd);
+	if (nf_link)
+		bpf_link__destroy(nf_link);
 	netns_free(ns);
 }
 
@@ -354,32 +389,44 @@ void test_xdp_context_tuntap(void)
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_read"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_write"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_write,
 			    skel->progs.ing_cls_dynptr_read,
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice_rdwr"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_offset"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_offset_wr,
 			    skel->progs.ing_cls_dynptr_offset_rd,
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_nf_hook"))
+		test_tuntap(skel->progs.ing_xdp,
+			    NULL, /* tc prio 1 */
+			    NULL, /* tc prio 2 */
+			    skel->progs.ing_nf,
+			    NULL /* ignore result for now */);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 8f61aa997f74..a42a6dd4343c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,15 +1,25 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
+#include <linux/ip.h>
 #include <linux/pkt_cls.h>
 
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_kfuncs.h"
 
+#define META_OFFSET (sizeof(struct ethhdr) + sizeof(struct iphdr))
 #define META_SIZE 32
 
+#define NF_DROP 0
+#define NF_ACCEPT 1
+
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
+struct bpf_nf_ctx {
+	struct sk_buff *skb;
+} __attribute__((preserve_access_index));
+
 /* Demonstrates how metadata can be passed from an XDP program to a TC program
  * using bpf_xdp_adjust_meta.
  * For the sake of testing the metadata support in drivers, the XDP program uses
@@ -60,6 +70,20 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Check that we can't get a dynptr slice to skb metadata yet */
+SEC("netfilter")
+int ing_nf(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	struct bpf_dynptr meta;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (bpf_dynptr_size(&meta) != 0)
+		return NF_DROP;
+
+	return NF_ACCEPT;
+}
+
 /* Write to metadata using bpf_dynptr_write helper */
 SEC("tc")
 int ing_cls_dynptr_write(struct __sk_buff *ctx)
@@ -68,7 +92,7 @@ int ing_cls_dynptr_write(struct __sk_buff *ctx)
 	__u8 *src;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
-	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	src = bpf_dynptr_slice(&data, META_OFFSET, NULL, META_SIZE);
 	if (!src)
 		return TC_ACT_SHOT;
 
@@ -108,7 +132,7 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 	__u8 *src, *dst;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
-	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	src = bpf_dynptr_slice(&data, META_OFFSET, NULL, META_SIZE);
 	if (!src)
 		return TC_ACT_SHOT;
 
@@ -169,7 +193,7 @@ int ing_cls_dynptr_offset_wr(struct __sk_buff *ctx)
 	struct bpf_dynptr meta;
 	__u8 *dst, *src;
 
-	bpf_skb_load_bytes(ctx, sizeof(struct ethhdr), payload, sizeof(payload));
+	bpf_skb_load_bytes(ctx, META_OFFSET, payload, sizeof(payload));
 	src = payload;
 
 	/* 1. Regular write */
@@ -199,14 +223,18 @@ int ing_cls_dynptr_offset_wr(struct __sk_buff *ctx)
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 {
-	struct ethhdr *eth = ctx_ptr(ctx, data);
+	const void *data_end = ctx_ptr(ctx, data_end);
+	const struct ethhdr *eth;
+	const struct iphdr *iph;
 	__u8 *meta;
 	int ret;
 
-	/* Drop any non-test packets */
-	if (eth + 1 > ctx_ptr(ctx, data_end))
+	/* Expect Eth | IPv4 (proto=61) | ... */
+	eth = ctx_ptr(ctx, data);
+	if (eth + 1 > data_end || eth->h_proto != bpf_htons(ETH_P_IP))
 		return XDP_DROP;
-	if (eth->h_proto != 0)
+	iph = (void *)(eth + 1);
+	if (iph + 1 > data_end || iph->protocol != 61)
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -226,7 +254,8 @@ SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
 	__u8 *data, *data_meta, *data_end, *payload;
-	struct ethhdr *eth;
+	const struct ethhdr *eth;
+	const struct iphdr *iph;
 	int ret;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -237,18 +266,15 @@ int ing_xdp(struct xdp_md *ctx)
 	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	eth = (struct ethhdr *)data;
-	payload = data + sizeof(struct ethhdr);
-
-	if (payload + META_SIZE > data_end ||
-	    data_meta + META_SIZE > data)
+	/* Expect Eth | IPv4 (proto=61) | meta blob */
+	eth = (void *)data;
+	if (eth + 1 > data_end || eth->h_proto != bpf_htons(ETH_P_IP))
 		return XDP_DROP;
-
-	/* The Linux networking stack may send other packets on the test
-	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their ethertype of zero.
-	 */
-	if (eth->h_proto != 0)
+	iph = (void *)(eth + 1);
+	if (iph + 1 > data_end || iph->protocol != 61)
+		return XDP_DROP;
+	payload = (void *)(iph + 1);
+	if (payload + META_SIZE > data_end || data_meta + META_SIZE > data)
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index df2222a1806f..204f54cdaab1 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -20,6 +20,7 @@ typedef __u16 __sum16;
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/filter.h>
+#include <linux/netfilter.h>
 #include <linux/perf_event.h>
 #include <linux/socket.h>
 #include <linux/unistd.h>

-- 
2.43.0


