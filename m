Return-Path: <bpf+bounces-68954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE4B8ADFD
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D813565A53
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB73275870;
	Fri, 19 Sep 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2TfxLFa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A026F2AE
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305376; cv=none; b=O10x/+lYeLZfQAH0LEvdNFtADKB0wTfBjF4kig93QgT8q3jv1i06rFOPsOndqfmHpR383JAtkQcYa3lNzZU8e1ztJOnquDu5orrkt8mRx6RjrgYi81slO0qb+TrcBfJgi7IsDSdX2igcYOHp1EFfRlkLIdLnOzAIozH/iV6FFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305376; c=relaxed/simple;
	bh=nDmjbXMAaaARovoem/jblg2PIL/t10TLTSxc9dzhj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZZQUNd3hv5+oNfJ3Qz4T1BHPKfpCytvgvjQLl+Hb1p35qzdcm0S7CYyLPe74STepG4CqA1o81MhHX4l7i4xuNaC3NEpSpLyDXaS0bSu5uKQVh2awJuS0W3/taCyF9Lgjcw9fy+76U7lPB/ziZ6pIXVJ+/20INRJ53hXyn5hOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2TfxLFa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1903330a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305374; x=1758910174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=k2TfxLFaXppLvBGLz1G543ViiR6Q5wx15UJWrlpsgPNBMfvjDWtaW91UPCjtH7iZzT
         RaP9Y0QJK9lrBGkj57nZG0kQdW2IWNFk3xuh4qI8yu1HnT7ee4hC87gxJObYtO4wy35D
         ipu6ZiUMPsgc2n8y7S8eWLVYCC+DT78BJCaKQWoCyzBdYQDec8noy+J2qFNZd0v44fKS
         8/jjD/4A10V8DIE4PcCHcEl2fl4wa6YoV6v678D4X50iz+qnDBLwIADxho7sO/Ec4JhH
         fcRNzukHkoi969wVrvnh2f3ncquRwuPFMJdjqALBS5jGr2pF4MHUia0/8tQhGaSzxw4Q
         sCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305374; x=1758910174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=F6peyUYFymzGnkmPlHVo3g8gPr/bQU/9P9zHZ/4oI03yYnvw7M84rg2S4VjJNSMrzb
         37DclJX2niNu8IJ4NnqH3YkzPv6d4tnTxuY3Rlc94Lh8r88JQYwKTElaGQiEtbVBypd/
         TNmfQ6/4IY/MoIA57vMIglVxMbuPqgYDtYxwTKie2HjTI4YzAc+VgmzyE3aKVembFmzA
         mOX88MfNLq+RQsf6OnPoTFTltN+W6rpcLQtEiphDX10U5UBfXKvkc6GtnQsJVll/82pM
         OrstkxZDiIMh72K2nIRTPGZJ84F/bg4dxHNrrFCviYwzA006/X1uwEagnUrW+FksaiU6
         5bjA==
X-Gm-Message-State: AOJu0YxoKiGAJFpVqFMbwcGqBCSvAa1Y1bWbqcbhcntTC8SmLxSNtQDq
	rSMrxuoqpwAY5/s3MX8hb1N3rklHE9wpKh0abxsmUvxVo+MsRE8XlvPCPJ3wxg==
X-Gm-Gg: ASbGncuBCxSrKVg26OiA8MJxWc6RkpBCUmjQb2UhB6iZihYgF9qjO9Rz1YQaVlOG3dX
	RySt0Kfa++8wExZIIEWo71rlN/CGd+iDILKikDJqnhs95iOf2PFLsE2pYFQ71uKG/x7NcXOX9F9
	ANlYV9zsXIoloqN+YM9azw2oYNPdTJ7pkHsNcqmTqT2VrSg+ScEOBilGdEkE7yl9/TYPM21wEOp
	ylnzPHLwAcCkJL16ZjOZWAHfh/ziIHE0yA3GMdHG8ctie1RWa9/Fg3ut+TWtZIkSdBgXWGSCW1k
	30JPBnNktUgh5zo8eGDZHgR3GpHTFIdkB9LRMP0rX0GMyzph4HQ9hL8y5fnQ4NmwbPjZzgZu6pQ
	hnKsetuF5YENBww==
X-Google-Smtp-Source: AGHT+IHAEbFtFk7dF3N9fQrs0mxAGeblMkUYPo5Wv/lzbMZrzDWaqq7AdCeZKehtCIWYf2wRsSHYUQ==
X-Received: by 2002:a17:90b:5547:b0:31f:5ebe:fa1c with SMTP id 98e67ed59e1d1-33097c2bdc3mr5050222a91.0.1758305373781;
        Fri, 19 Sep 2025 11:09:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3fc6ea0sm5285475a91.9.2025.09.19.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:33 -0700 (PDT)
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
Date: Fri, 19 Sep 2025 11:09:26 -0700
Message-ID: <20250919180926.1760403-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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


