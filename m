Return-Path: <bpf+bounces-71307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D9BEE572
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A6A188769A
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268AF2EA75A;
	Sun, 19 Oct 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="arfWoXI9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856E2E92BB
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877969; cv=none; b=VQKD1/CfPcAE4+8opEUBc/af9VX746l298X6zXKKMyxdIsQ48KqpgEC9o0O8wcdt7WDwJhJJj8ooh+12ZfKoM6prW3KxrxAUFctEuu7LMiadaogUQPAu1+TvbnSppExu4JbjRfDMOsvLTM1ZmCBXoa0Pa1b5idyAHmqtwe33bSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877969; c=relaxed/simple;
	bh=fJ7sHvp2VNOk+5vuQFLVSN56k5JUSvyWtZQOr9QReTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnIKyalul0rmKMoPA2xH15ZOiNKRrdaiYg21PGRmyygDwairk7US2gv5TSAuHrz4RozHQBFKy7b6bctEu76tqZ3I+pLQwC3P2ARC5zZaATnsrs2Y1Px4mC3PfWsjIagqBoUlCZdX6C9HjCVJ7/EfTL+Wy4M71JtmduODn/lZud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=arfWoXI9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so641428166b.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877964; x=1761482764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=193tino1NLIO0axy0qNRRwpRP6Cnwqovsjo7lrR4NWw=;
        b=arfWoXI9vAAKr7szXwXYFLefyMvFF+gk6lR/atxwLDeKInR/CDQI0mUCEjsKgRL0as
         L7KpRRhbNfzCJzCMoBqeVKkWGMk8LFt1+nAFkyKjuPxeaGP++/3yIwnUepw56TeyilZy
         Z/nIVyGNZrQY/yy8BoQtSVNeNuQ14z4TsYciI85D+y15h4xkND4UT4ZuqPDZi0CzujBG
         dFLo2Z/wSaCHMrwtdyhCnPFp51FF7uxaNyQMTvSex9tQAQcfe8fB0ZrbGprRXtT/C1e9
         9MoLfEKmVffVurcypSFzVVKEaCxNF40EQQsfLbd66d/rQCfGH+EUTcymvQ4RtGxouvk0
         v2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877964; x=1761482764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=193tino1NLIO0axy0qNRRwpRP6Cnwqovsjo7lrR4NWw=;
        b=mMrI0CBfc1K+x9q22IoNpk7Vo/krR7P7c8EYGIuYhCUX+ftRazL4AQ61lPyBwiLO70
         fqurDzWYvFrsepf+5mx/LSaFl2PHlHWM+8Y1krWOEcQBsUnkWSSaaESQtui4KSEiOoRS
         0XLTkb7OKeEPLIHjhwM79PMQykEGyBh0qKKjFDVJCkeIqnhQ4cz4ScNJQ03/9CW3AAFB
         m0LknKMdIuGkOBpPJShra+IsvA0Rr3Br+5Gijl32eqDr2xucGb/I6vSlqIYAc2IjeLrD
         jnFm/Y4flZ2kP/q01dCm2FRcGDDcEHa4OiSZ29WyBgFmYHnJ1TR2+wAZFcDtDNrQUuGp
         Szdw==
X-Gm-Message-State: AOJu0Yww9S6PWy3Ogsa3OXws4PoUzveKz3yY6i0XwPZVtBaGkXoO4NJA
	wbPrKcmxZlvR1FeXFdNAJVLQ91CxWBCYFeNuhxamar/xvtrIHgS4lxtsFlA7gvZmvsA=
X-Gm-Gg: ASbGncunU8ImyeJvpW+Ma4hZJx8gRcswE1imv3IiE5tURZzHcKtc1Wk17ZnTgAytOxw
	5s8q65ich9gINGqFYJ6JiH2mGvZDdm08NC6Qs74nk6aSxLW4cGLuqek83KaS55eq7xgaadWwejt
	GWOSEJQaSdBuKwAtxRR2w1cYctzfqE3DDSCminQ+jWfOlU8RMwFQtJX3CFERgS3ksAaa8T99Mvg
	boH64lkonMKnh6qTZVVT+ZkAH0fUwb8xlTBUvi2mfJQNrNHP/gF8FfbxGFGpMU7HwyAoS/waJrr
	TY47c2oF5j012ZyT1JES003ITdSpWETVL5uuTHxrvZG8FZx5hVpVOyEmlhbb1pNm/kQ9BuHiL/+
	Umy6HV2QL6w9sGT3yT1icqtvi0yvwqWwgrSqrf6+CXgMRb8MzO5VHk+eAaMMCtmAzQUwBEkcYYV
	V5eKh4and6EBnD7uGpcxTnjsm6geyVKxA9X9byQOHsVhVMDncx
X-Google-Smtp-Source: AGHT+IHCfUr5Ou2Q5FO35tyR6TxziwOW3pvt/V3mpXvxh3bghUvmDA3ZiukxneaohBv1xmM9TgSmvQ==
X-Received: by 2002:a17:906:c104:b0:b57:1d99:ac93 with SMTP id a640c23a62f3a-b64764e3f19mr1161534866b.51.1760877964133;
        Sun, 19 Oct 2025 05:46:04 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e89713ffsm496526166b.36.2025.10.19.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:37 +0200
Subject: [PATCH bpf-next v2 13/15] selftests/bpf: Cover skb metadata access
 after bpf_skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-13-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_adjust_room(), which modifies the packet headroom and can trigger
head reallocation.

The helper expects an Ethernet frame carrying an IP packet so switch test
packet identification by source MAC address since we can no longer rely on
Ethernet proto being set to zero.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 25 ++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 61 ++++++++++++++++++----
 2 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index e83b33526595..05d862e460b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -124,10 +124,10 @@ static int send_test_packet(int ifindex)
 	int n, sock = -1;
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
+	/* We use the Ethernet header only to identify the test packet */
+	struct ethhdr eth = {
+		.h_source = { 0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF },
+	};
 
 	memcpy(packet, &eth, sizeof(eth));
 	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
@@ -160,8 +160,16 @@ static int write_test_packet(int tap_fd)
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int n;
 
-	/* The ethernet header doesn't need to be valid for this test */
-	memset(packet, 0, sizeof(struct ethhdr));
+	/* The Ethernet header is mostly not relevant. We use it to identify the
+	 * test packet and some BPF helpers we exercise expect to operate on
+	 * Ethernet frames carrying IP packets. Pretend that's the case.
+	 */
+	struct ethhdr eth = {
+		.h_source = { 0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF },
+		.h_proto = htons(ETH_P_IP),
+	};
+
+	memcpy(packet, &eth, sizeof(eth));
 	memcpy(packet + sizeof(struct ethhdr), test_payload, TEST_PAYLOAD_LEN);
 
 	n = write(tap_fd, packet, sizeof(packet));
@@ -488,6 +496,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_vlan_push_pop,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_adjust_room"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_adjust_room,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 8d2b0512f8d3..e29df7f82a89 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -25,6 +25,10 @@ enum {
 
 bool test_pass;
 
+static const __u8 smac_want[ETH_ALEN] = {
+	0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF,
+};
+
 static const __u8 meta_want[META_SIZE] = {
 	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
@@ -32,6 +36,11 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+static bool check_smac(const struct ethhdr *eth)
+{
+	return !__builtin_memcmp(eth->h_source, smac_want, ETH_ALEN);
+}
+
 static bool check_metadata(const char *file, int line, __u8 *meta_have)
 {
 	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
@@ -286,7 +295,7 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 	/* Drop any non-test packets */
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		return XDP_DROP;
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -326,9 +335,9 @@ int ing_xdp(struct xdp_md *ctx)
 
 	/* The Linux networking stack may send other packets on the test
 	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their ethertype of zero.
+	 * The test packets can be recognized by their source MAC address.
 	 */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
@@ -348,7 +357,7 @@ int clone_data_meta_kept_on_data_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -378,7 +387,7 @@ int clone_data_meta_kept_on_meta_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -411,7 +420,7 @@ int clone_dynptr_kept_on_data_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -440,7 +449,7 @@ int clone_dynptr_kept_on_meta_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -473,7 +482,7 @@ int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-only metadata before unclone */
@@ -517,7 +526,7 @@ int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-only metadata */
@@ -568,4 +577,38 @@ int helper_skb_vlan_push_pop(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_adjust_room(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* Grow a 1 byte hole after the MAC header */
+	err = bpf_skb_adjust_room(ctx, 1, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Shrink a 1 byte hole after the MAC header */
+	err = bpf_skb_adjust_room(ctx, -1, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Grow a 256 byte hole to trigger head reallocation */
+	err = bpf_skb_adjust_room(ctx, 256, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


