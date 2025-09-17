Return-Path: <bpf+bounces-68723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB43B8235E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2FB2A892E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C0313548;
	Wed, 17 Sep 2025 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcm29txn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F100311C33
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149723; cv=none; b=nqC8RW+PpOZcZL4rWXjMagzdDwUuV0FQQJu+yq/uiiXMzj4IjUEH0QiOGwqyF7i/RBCsTcf7yM5h4pT8AbKTO2y8GZliqinsELBV11gukBe8uow2+l4KYvLC0sHT1ay80fgbVdhkUdRtF77MlRmW/ZUFS13cyrTIYeDweAFp17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149723; c=relaxed/simple;
	bh=nDmjbXMAaaARovoem/jblg2PIL/t10TLTSxc9dzhj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTrddzS+vj6t5V6IORa32pwGwmS5HSKLNVy5W/TLUcjBcKud8q1HBpjIHcGn3NxtJuMmUTuLnQ+ndv4jhd5sEqthOQX6rNqL21G2QRwdMuhXRH05+TRCppjdgCx8MnaFx/k63LFBjA5N7Vq7AONnYjcKMWXSgmGfB81j/OsfOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wcm29txn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7762021c574so389927b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149721; x=1758754521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=Wcm29txnjyVorSHkwZbnTaZYJzRa3FLlubyV01e/GG1cNwKpp3VPLfVJfnJjxMi1G5
         vaBTDQil4pTStp5XAG9JwZpS9flNVuV/RRk613F7+Y6jxIWePxi6SosWF4tuqQ9Mfrfg
         lfHKD6xnozw/t6ZHcVzyj89NP2Xx5aPjh3sqQT2Z/bGGYcrRxlKown/8aCCVonJ7Zn5s
         xtUBwek/TaR4TjL5mJLUrQkPFO9c+iwpB3IVTw07ZgWsRVxje6Ytzyx19VzLop8FqyZr
         q4g9YBHYjMNsZK/WAQoJzc7uOBGU6+/P/UB2epRo9qySyy7OGX4UeEVwb9EkzD0Bc35G
         Dppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149721; x=1758754521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=JRkeO6K6cS4CYJwqbigYGvOn2LXbJjiVRl/2tjddEYmfrdA4c/B/78rh4PWLI4bcxD
         K91hVv+NcLH/QFSjEMowpIz00SWxMtubCMdVFys1+I6J1N5PXo4OQRcgcSl0IkymjZ8S
         xB0kV8eF+rUqOL24LJSFHTr+Vq07Sk0o1Agl/EnGLdm3lwG7pw7ruI3I+Z7ADGzW/4Pj
         VpMzfHHBLe7hYu3Q9jceFspeVfpRGtdMMjlO5YM17S1mzym9NCSp71UI8RF5Rg/Y42Pk
         Cjt38+SKgoXVPvH8UBn4vjT10KzNf/qjv3/40zjyWLIiUMaqkpU3pJkkYfjvI9cT/nk7
         3B5A==
X-Gm-Message-State: AOJu0YzMUuW1qg9Q9Kz5HIZlAt6uDudCFGt+L/aiB6mSFSfGg1FAUmJj
	WSU1rTBUqr4gF0K2k9XoXd7cGX5U7UbNGanp0FhoRoCxy9tHkpT2imKaguLOmA==
X-Gm-Gg: ASbGncvQJ70jFFPSup5jSaYxgqePVlTl8EmO9KiptqGGrOG5m7jcHyAvptFq+HSSf28
	KLqDvtNiYsX33p+TLrqhe03phoZlkW6DNH026NPWfIvgRNDpeHjtGNxin/VLhxTwrmTQoWgD3m+
	NYxtuwS73OMpNu0DgNGGxxdq/unTqRl8oJsRSrJhtJsRWRfJYJ6qtMavXcQ4pbhQe1V/GeiAuaI
	gCKkERXBKPIgrAmbN19w2+wRCHjkcDyTvDwCDCUDI7vvwD84da2sHtLCt8q7R7fVGGgygoHu/Hb
	MtxDJSo/Fm0GFIFwTtpB2ErBlxY8FuqkblBFB6rbaxCAws2G7ClnhV01xtqYdH+/PATfsO+g7f5
	RT5f9utlbEir1bWbXEUNFA7g9LidheDU=
X-Google-Smtp-Source: AGHT+IF1zrNoixTvs/C1WaUcnMEKlIKBQMV+ZH/VhsbHfBv7/cSmvVUFPi/g5VwLcrWqz5jQFdrfsA==
X-Received: by 2002:a17:902:e54a:b0:269:6e73:b90a with SMTP id d9443c01a7336-2696e82fe56mr26439655ad.15.1758149720630;
        Wed, 17 Sep 2025 15:55:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm6053555ad.86.2025.09.17.15.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 6/6] selftests: drv-net: Pull data before parsing headers
Date: Wed, 17 Sep 2025 15:55:13 -0700
Message-ID: <20250917225513.3388199-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for drivers to generate xdp packets with data residing
entirely in fragments. To keep parsing headers using direcy packet
access, call bpf_xdp_pull_data() to pull headers into the linear data
area.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 89 +++++++++++++++----
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 521ba38f2ddd..df4eea5c192b 100644
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
2.47.3


