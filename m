Return-Path: <bpf+bounces-73714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67967C37B32
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30917188A389
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51EA34EEED;
	Wed,  5 Nov 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XVbwjTLW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDD34EF16
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374013; cv=none; b=j+uyQq0jH+N6VuYBHrfGHiYHEhGb7gRqZphY5loQIVE5iKQKioaAw/fVxU3jwFvRgPiQHIxM90vWwGjtL11dqN5k8cTGWIBxEFyY7XFDwi+IOxiKh1xR8n2h2W8OCEGtMsbH4opGYRijHkMglXDFuKFxjwG+VddcQMbXNhO63eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374013; c=relaxed/simple;
	bh=s9dOPdDssh9uVh8xXJwS8S9YL3U/YhGMODTknNjjdN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTpezRQ/2qHdgEc9Imk0jG7FSe3UmGIJtqCylQAAeMyWCufgDZaXK2lU4rao9psLByWVWlkIfYdmSvNc+QHaOgADiWt+gYq8gymZEmQebt6/N3H/SnnvK5p/MBaBAlZu59tcvGCjzKV1b/Zi4klQ0HSHuoD3Bl+UMB2daPjWtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XVbwjTLW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7155207964so33130966b.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374010; x=1762978810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRjMGQekhCJm4Cmv78QCqTEMQUlb7WHtroQaPtNLGo4=;
        b=XVbwjTLWlBlWH0nRSR0aVDd0DMt7WWMPGooo8JHrqzI6G8/cXtBnOsC6PZqo9EOvHt
         SsiRhIXfRRB0bEPMAzWvMa0y5w8enYgqjgorIXZFLDQfFCEQ68oxgWnlIGK2bb02WkJ4
         i4jWSChcUBrnhHuHHVyKFVGCIxOusDW0QpkPx21hkdwh4UJRvjiGAhmw7hc740zCFtEO
         bBnpxHLhFIYLX8yXIwyJbWun38mvh3qE6HStA85PZ56+a7UImbMf8fJQiohneq4dgtBv
         CVo3YsJp3TE7zPWd1y4Mo05Sat8ej/8INH1dPztwN+u6CQexVpp1LLBtAFRgeDcILhrZ
         p8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374010; x=1762978810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRjMGQekhCJm4Cmv78QCqTEMQUlb7WHtroQaPtNLGo4=;
        b=PX9Fxd/QgeI24btZmr3dpQrX8hBefDNfvQCq+7FQDq+MeNiYWumW9Kcn0Rs+DLXuug
         kc8OkXyWIM62Yh8l0rg3ONfVOjGvL+FoR7cHHaoWMtgdIpM5xH4sQ8UWnrrAVGd0zsJn
         ABnegpZmbtGhoBcUPwJ5wzbcZWMiIno2JJsJaEeP3d6/IQ6AD7mZtWqEaPVmjNWbUWTJ
         i0SAwdP4Dl/hd5sFaKFQyRRWE19dzo/imPflkGduo0HG4NV5GwBO5ZHWoJJbOvh7SZYV
         Xx8ZxsN67SfaDCwdBA2vYKG5Kx52Eh6u/a3kylRyS2r525z5rtFQjlYBmj8nFi7ko+h9
         2ogg==
X-Gm-Message-State: AOJu0YzDfVgwBukSIMASIAb2d5iNT9MNbh8+7j2WMQMAfdvHCtsQnojA
	AI07NUgGLVwPh+6wa1kYjqEFKALH7taGzqF4fmN511GxVZtDLrdRsK/QGYOBCvSEd1k=
X-Gm-Gg: ASbGncv4eZq4D6/ZPR6bTiPIQjJZ5G2IjHzckUaKKuCv46Bidv/H2wzea9yPiLOdRbG
	rMh4A7CMH45mQwFuamgq3QgTJgcLfHQAPgJDiy8rxMhtxVgOIgv6ggrygU1vvImAxCpNa6XP0/e
	94NTUbhKaLdCEXNh/MEvBDqF8bakkrGfUX8OqR/PXDs1vyOgG0kH3DVR04VKDYJ4WoMlnv5eWj6
	BjCKwTS92q5Z/bOLLshqIX9Q7oexdLJmlG4/t7iNuYsxwa/dcY22QSmIjTKYPgFmBkGv01QVM4v
	NA7F/0DeAS4FrCNvZUpQmnTlgVxnPaud1YXw7LTPZfdO/6GeHWrTVZml6ziebzDBBuNpGqR5zSd
	KcoJOn0d+ATyvBmbI4/5QupB9tCa/0LL/7gEKJWBDOkbXwGfeWpkyqU8YL5AEc/ZQortz9Jk2Ii
	NVBJAEiWHdYvSjxMVV7PncdTeLBa81Xo8NHWuTycIgxF7sCQ==
X-Google-Smtp-Source: AGHT+IEhGhixETesMpLTec3fAJha6wS8Rr/XsZkgmK206DjQaxhuiWXjLA43Y61AwEoN5oCsTubcVg==
X-Received: by 2002:a17:907:9711:b0:b40:6d68:349a with SMTP id a640c23a62f3a-b72654dd598mr424571966b.39.1762374009704;
        Wed, 05 Nov 2025 12:20:09 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8127sm45823466b.73.2025.11.05.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:51 +0100
Subject: [PATCH bpf-next v4 14/16] selftests/bpf: Cover skb metadata access
 after bpf_skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-14-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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
index 04c7487bb350..6edc84d8dc52 100644
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


