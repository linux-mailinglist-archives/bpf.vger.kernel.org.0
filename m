Return-Path: <bpf+bounces-72245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D310C0A981
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FA0A4E8CD7
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80482EBDF4;
	Sun, 26 Oct 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S8bQ+vj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B432EB850
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488340; cv=none; b=Mb2AHNk9bplTEYrCNNaJkp9A/FRDPtcQOMUvB8k8jVz23OguBI+AWr4PBxbQNm1xh184mmDEJbwkJ2v3GwAffuiL2irb4YlOsavMUg+tmDFS22WBljY97lzkhbYqkvWUD+qSMI/2E/QoNWub6lMKKB9+vq6z7MDU3uZeoeQZLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488340; c=relaxed/simple;
	bh=oJ9QfoLjX5Jii7c+6MVmVibF5sDfyaIxBsN16AJb4Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUzUUyxGzDRTjcIpRsWENUvFBnQfcsRGc9ov0K8E9oSQeoD+pPqc8/vhAyaOmInxmI5+xMZp1sXDqvDoKNxuGyKGvk1P9jTjFbNLedcxaDnxl+6IN8H6vnJbfcwDsK8oU96JeW14CPUij35flRQ5XPcTwfoYYe7wbNs6XTg0LhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S8bQ+vj3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5c18993b73so672375666b.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488337; x=1762093137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iehzV8G3eRI8z6XXgoYnZujxtmssUiC+nTOrLGI8+fo=;
        b=S8bQ+vj3xqZXxinTN30FCT+7jzo/lha57oKOytVd5AJJc/O4OtP/vV9LllumlIa4OZ
         /G4Q9F1NAqIQ+GsfFk0Cx14Verq+btSrn/mwPkPag38m+QENICuOD44PhNOnFYARQXIV
         vvDnhkuWFx8DTEvWWFRtZAH6wcuahAMuDJfD9xOgmCAzI9+RxIpbR3W2/bDcM12lg/c6
         M+w5kPeJgi1PSjWJFg0zIMZtwgeoGN1VfKSwB+D6npawKA3tc62HTXj3AcSqo4dxDMnT
         ikZVD/eP0oIfr0vDEfAJWbeESEKlHiCkEBwu5Z558fL9Lz4G9w6y7tjnXhUABolEY+RX
         fKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488337; x=1762093137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iehzV8G3eRI8z6XXgoYnZujxtmssUiC+nTOrLGI8+fo=;
        b=v9jPWoKymd/dp3CKyQCkX+8h5LAbK/5zvCcvN6O6sk8Yx+yCn5vn1YZVMF0r9YUL8/
         qWLDc5nO4Rvxh4+AsDljTozZJv5NUf1Z1SUH7YS94RibIcQy/m9ZLBN9tneTCyH0K5Fa
         fOQya5BCOqe7TomSnsRs+MBfnLegiLCdzJTWrL5PY0lYRiRpwf1pphdrJkPOAofTX/af
         YJ7Iaff42iSJjIh3M4ueAM6iXjfgY2bs5nryW0Ls2jraWZHh7U7/KGPtq6ElRUNuxt7E
         N4VceplzeakTH43uxmG/f8xHf4KKJMYqcYFdrcIJz3SAlIcm2ZQHi5R558pXyMsuYdsQ
         iacQ==
X-Gm-Message-State: AOJu0YwP6iR56o38n4/EKku8N7XrXyBfp2MCrrp/7njnQylZ0Zw/m3O1
	E4UomQtnvAVY0LK4+EHjkVcl2sdfhI0keZ9/4k7Fti0yldtO3+yqJGXiAvHG5jeWteM=
X-Gm-Gg: ASbGncvHvB0N4cvJnmqVkYe9hj7snhEJJ3L/iHjTnhrVwiOKveWkBZn9ad2wwKjWjRu
	4NwuNRXwzhcpdDXFYOHFung8Ao9TJRUae0lJqE88J0yHb805MrX7GUDZFAaQ2CGse0w6ZiCXlW/
	04ZQsW4XiKekqpiDOIchLZyiD+VDDNmrHrsWO/jxCcysLVY+rJJw1XNoZTRmoEhDrb/hB00KF5B
	vcRL+7bDrdpdp3WUd+cdDhM8UO7KUsWbj2mMcjuWteTu6tzSbngR3sOWSFnueJRPw4UcclEy/Fq
	x4bIqZuc6RjKr3epr3QR/VO+WbAqkw07VaVF6tkYxw0AZPPNZtkoostl6ZxiEq0poPd2JgKILqk
	gVpJgsq3K0bhSJyiCosrIAiV2Wpp4qqn5OyGupoRCHe+4IZQZYoFbb2+mXebhQsuTg29PEOm2w3
	ePD6DDT6zf3IXZGx0MCnr0oQdnR/in1ZJYTOnTE2q0j4L2hnCVTOKwVWE0
X-Google-Smtp-Source: AGHT+IEhjWYEQgLe2cipV1H1Q80xl2Q5D3ZgUH1bmYGC9sxaUd6A4NFH0XCVbJUWPvtq7wMuQNmtRg==
X-Received: by 2002:a17:906:fe0c:b0:b45:420c:81c0 with SMTP id a640c23a62f3a-b6d6ff25529mr882778066b.36.1761488336958;
        Sun, 26 Oct 2025 07:18:56 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0fabsm3821228a12.34.2025.10.26.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:34 +0100
Subject: [PATCH bpf-next v3 14/16] selftests/bpf: Cover skb metadata access
 after bpf_skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-14-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
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
index 97c8f876f673..a3b82cf2f9e9 100644
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
@@ -484,6 +492,11 @@ void test_xdp_context_tuntap(void)
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
index 41e1d76e90a0..29fe4aa9ec76 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -20,6 +20,10 @@
 
 bool test_pass;
 
+static const __u8 smac_want[ETH_ALEN] = {
+	0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF,
+};
+
 static const __u8 meta_want[META_SIZE] = {
 	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
@@ -27,6 +31,11 @@ static const __u8 meta_want[META_SIZE] = {
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
@@ -281,7 +290,7 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 	/* Drop any non-test packets */
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		return XDP_DROP;
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -321,9 +330,9 @@ int ing_xdp(struct xdp_md *ctx)
 
 	/* The Linux networking stack may send other packets on the test
 	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their ethertype of zero.
+	 * The test packets can be recognized by their source MAC address.
 	 */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
@@ -343,7 +352,7 @@ int clone_data_meta_survives_data_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -373,7 +382,7 @@ int clone_data_meta_survives_meta_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -406,7 +415,7 @@ int clone_meta_dynptr_survives_data_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -435,7 +444,7 @@ int clone_meta_dynptr_survives_meta_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -469,7 +478,7 @@ int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
@@ -511,7 +520,7 @@ int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
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


