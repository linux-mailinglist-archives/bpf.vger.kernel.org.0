Return-Path: <bpf+bounces-70678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D696BCA06E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D094FDB39
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5A2FB09A;
	Thu,  9 Oct 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh0krRK1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCF2F0673;
	Thu,  9 Oct 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025583; cv=none; b=nr7kCeLrxHIV2W5ZoCEasWZqslGeZPaFFt/yqaXm8WpiAumaeO0Ls5xmyOkBECxocjYkKIwh8MRkJQQTIC1rqWnfK2UdhlHaA1kJduD9Zkyyy9D3lw9sDF6/P+kk/UYLFyodfa2zLIpBjnMFm1kcmpJ21aCvlOdYMlq78FAqKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025583; c=relaxed/simple;
	bh=pwCS7DcqmB7VW978pKQjnokoVKezjc6Cbqb+Nle17es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSjeTT8CuA0KMn4jjTVScX24/t6CBGJ92fm3ZUKEvdFKRELs7aNBJtG+fUxh3d80yAdpsgwHck8VTslUi0DT/zICJqFRVdz0O6Zq3DU+tyiUo7gWFbgBwylqeMgPThfiB3GoFmh/FfSxbGTBFs/tdfoKGTgJEEAfBmeLBwTUjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh0krRK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC88C4CEE7;
	Thu,  9 Oct 2025 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025583;
	bh=pwCS7DcqmB7VW978pKQjnokoVKezjc6Cbqb+Nle17es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mh0krRK1DQt5XsHxc+yjH/lYDr5e4J1X2++dxcYfWcMuVUyf8WM7gFuoKpWT/VB8P
	 DsxPHY+dXBb+uVfmrCU2AVcM2Lpb4+lHbYqHmJkxBDCa4vurgp+HypUOf7ALlvpc8v
	 l5TFa34kKEFZ3reGuZgDDzbaLKdW3b8lKDJqnSZs6GMYy7NbXgJcPzeVnby9NDpe+o
	 1aPg4mTHVjIPEIwd+3lg9I+/4ja1Fd0rgJAVjN4VUQTmLJja4Wlperp4hhKqBEfyvb
	 h4PDeFqOiBXQQY9Z1FvkWDKwBJzwbJJlzeEP49XlLoNXJ7C4lnDq9IjvPJCgBFZNmy
	 ybVtJ4XHLJiPg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	mohsin.bashr@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] selftests: drv-net: Pull data before parsing headers
Date: Thu,  9 Oct 2025 11:55:23 -0400
Message-ID: <20251009155752.773732-57-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit efec2e55bdefb889639a6e7fe1f1f2431cdddc6a ]

It is possible for drivers to generate xdp packets with data residing
entirely in fragments. To keep parsing headers using direct packet
access, call bpf_xdp_pull_data() to pull headers into the linear data
area.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250922233356.3356453-9-ameryhung@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes and why it matters
  - The BPF selftest program parsed Ethernet/IP/UDP headers using direct
    packet access without guaranteeing those headers are in the linear
    area. On drivers/NIC configs that place header data entirely in XDP
    fragments (multi-buffer/HDS), this can lead to invalid accesses or
    verifier failures. The patch ensures headers are pulled into the
    linear area before parsing, so the tests behave correctly on such
    drivers.

- Scope and contained changes
  - Single selftests file only:
    tools/testing/selftests/net/lib/xdp_native.bpf.c.
  - Adds kfunc declaration for `bpf_xdp_pull_data()` at
    xdp_native.bpf.c:17 to request pulling bytes from non-linear XDP
    data into the linear region.
  - Updates the UDP header parsing helper to pull and then re-read
    pointers:
    - Pull L2 first, then re-load pointers (xdp_native.bpf.c:78–86 and
      96–106).
    - For IPv4, pull up to L3+L4 and re-load pointers
      (xdp_native.bpf.c:91–106).
    - For IPv6, same pattern (xdp_native.bpf.c:109–124).
    - This ensures `data`/`data_end` are refreshed after each pull to
      satisfy the verifier and correctness of direct accesses.
  - Updates TX path similarly:
    - Pull L2 then re-load pointers (xdp_native.bpf.c:182–190).
    - For IPv4, pull up to L3+L4, re-load pointers, then validate, swap
      L2 and swap IPv4 src/dst (xdp_native.bpf.c:196–221).
    - For IPv6, same flow including `eth = data` reload before swapping
      MACs (xdp_native.bpf.c:233–261).
  - No kernel subsystem logic is changed; only test-side BPF program
    logic.

- Backport suitability vs. stable rules
  - Fixes a real-world issue affecting test correctness on drivers that
    produce non-linear XDP frames (user-visible in CI/selftests).
  - Minimal, self-contained change confined to selftests; no API or ABI
    changes; no architecture changes; low regression risk to the kernel
    proper.
  - Aligns with stable policy to keep selftests working on stable trees
    that already have the underlying feature.

- Important dependency to include
  - This change depends on kernel support for the kfunc
    `bpf_xdp_pull_data()` which is introduced by “bpf: Support pulling
    non-linear xdp data” (net/core/filter.c:12253). Ensure that commit
    is present in the target stable branch; otherwise the selftest
    program load will fail on kernels without this kfunc.
  - There is a follow-up fix that must be included to avoid verifier
    failures: “selftests: drv-net: Reload pkt pointer after calling
    filter_udphdr” (commit 11ae737efea10). It re-computes header length
    using a freshly reloaded `ctx->data` after `filter_udphdr()` because
    `bpf_xdp_pull_data()` invalidates earlier packet pointers. In this
    tree, that fix manifests as changing `hdr_len` calculations to `...
    - (void *)(long)ctx->data` (e.g., xdp_native.bpf.c:430–436 and
    582–590). Backport this fix alongside the main patch to prevent non-
    deterministic verifier errors depending on compiler codegen.

- Risk and side effects
  - Selftests-only; no effect on runtime kernel paths.
  - The only meaningful risk is missing dependencies: if
    `bpf_xdp_pull_data()` support isn’t in the target stable branch, or
    if the follow-up “Reload pkt pointer” fix is omitted, test load or
    verification can fail. With both present, changes are
    straightforward and low risk.

Given the above, this is a good candidate for stable backport on
branches that already include `bpf_xdp_pull_data()` support, and it
should be backported together with the follow-up “Reload pkt pointer”
fix to avoid verifier regressions.

 .../selftests/net/lib/xdp_native.bpf.c        | 89 +++++++++++++++----
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 521ba38f2ddda..df4eea5c192b3 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -14,6 +14,8 @@
 #define MAX_PAYLOAD_LEN 5000
 #define MAX_HDR_LEN 64
 
+extern int bpf_xdp_pull_data(struct xdp_md *xdp, __u32 len) __ksym __weak;
+
 enum {
 	XDP_MODE = 0,
 	XDP_PORT = 1,
@@ -68,30 +70,57 @@ static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 
 static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	void *data, *data_end;
+	struct ethhdr *eth;
+	int err;
+
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth));
+	if (err)
+		return NULL;
+
+	data_end = (void *)(long)ctx->data_end;
+	data = eth = (void *)(long)ctx->data;
 
 	if (data + sizeof(*eth) > data_end)
 		return NULL;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
+		struct iphdr *iph;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) +
+					     sizeof(*udph));
+		if (err)
+			return NULL;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		iph = data + sizeof(*eth);
 
 		if (iph + 1 > (struct iphdr *)data_end ||
 		    iph->protocol != IPPROTO_UDP)
 			return NULL;
 
-		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		udph = data + sizeof(*iph) + sizeof(*eth);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*ipv6h) +
+					     sizeof(*udph));
+		if (err)
+			return NULL;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		ipv6h = data + sizeof(*eth);
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
 		    ipv6h->nexthdr != IPPROTO_UDP)
 			return NULL;
 
-		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+		udph = data + sizeof(*ipv6h) + sizeof(*eth);
 	} else {
 		return NULL;
 	}
@@ -145,17 +174,34 @@ static void swap_machdr(void *data)
 
 static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	void *data, *data_end;
+	struct ethhdr *eth;
+	int err;
+
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth));
+	if (err)
+		return XDP_PASS;
+
+	data_end = (void *)(long)ctx->data_end;
+	data = eth = (void *)(long)ctx->data;
 
 	if (data + sizeof(*eth) > data_end)
 		return XDP_PASS;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
-		__be32 tmp_ip = iph->saddr;
+		struct iphdr *iph;
+		__be32 tmp_ip;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) +
+					     sizeof(*udph));
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		iph = data + sizeof(*eth);
 
 		if (iph + 1 > (struct iphdr *)data_end ||
 		    iph->protocol != IPPROTO_UDP)
@@ -169,8 +215,10 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
+		tmp_ip = iph->saddr;
 		iph->saddr = iph->daddr;
 		iph->daddr = tmp_ip;
 
@@ -178,9 +226,19 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 
 		return XDP_TX;
 
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 		struct in6_addr tmp_ipv6;
+		struct ipv6hdr *ipv6h;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*ipv6h) +
+					     sizeof(*udph));
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		ipv6h = data + sizeof(*eth);
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
 		    ipv6h->nexthdr != IPPROTO_UDP)
@@ -194,6 +252,7 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
 		__builtin_memcpy(&tmp_ipv6, &ipv6h->saddr, sizeof(tmp_ipv6));
-- 
2.51.0


