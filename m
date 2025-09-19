Return-Path: <bpf+bounces-68963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A8B8AE6B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8CBC4E05E6
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB93279DD8;
	Fri, 19 Sep 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwXCAb/A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC75279346
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306071; cv=none; b=EZVqMIbDoj9XYCA1GJUV8gfJf03Eiolz7RVwrz5gkSAUNIrR8ues60XdydB2GXjHkMcVTHL5tKDmubMUCtKa6rYWfsSYeYDWwnoXYXybx0r3AqMrrVBvYWEVqzyMvKNhn/4ltmfeB3FXO9g+T6NlMA8X6LhLhMBYFRzmC6RAOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306071; c=relaxed/simple;
	bh=nDmjbXMAaaARovoem/jblg2PIL/t10TLTSxc9dzhj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1TwkYTHFoD6Bi0DDG+yKwNe8wblwyUQFkn4oJrLbOARISht/BKgUSwg0eILZnw8IW5qQ5u5NN2+ZLnPYcSpeG8E++gBJMFYuEztdbB8t6uqSBUX0P5omqtn41abdebDPRqDSsznvq4Wg0dZN6ayEAKRFeZ1ePYH2vZsYz4EZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwXCAb/A; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7724df82cabso3011154b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306069; x=1758910869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=IwXCAb/AXm9t3CvNNzBj75yETEeqB9hy6p2kh3q6MQ/ViHllE2Dp6Pr/ISVHs868Ru
         Iwv9q7OMf9ZRfBDYP/aU/Qe/SQyGd4ro7aJai5Vh/owIQkolvUQT21B64VqQT9caBAhF
         j8/l7sB3A3Y7S6r39MQiLqUjva9DOk/Z7UzTl8pyA17D+8y/k/b/WB/kRAmZoftqeqRK
         QmJeWb0erhqwju1ng4cm4zPrMajeop+lYrmWwZJ0EmpVhtVSLFA6oKjMw2APaJBO1lgU
         MSmPsHFbTrijorY4SAQKyeuOVF58suYXbrrk+xmmq7TSL0kF2ICqUw4SRoYe/eSoG081
         z7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306069; x=1758910869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=PzG5omCPmZatK8yB1K/w4YNj552u5xa2RFI/2UHOsusi3kfzva4HEHhhDpauj5t8eV
         IZBKr7MUo3P07AJEdxMF6yfZA+u5ewkzwbr+A23VXUFUP8F/ei02mgKIMYcSoUdjF64u
         5VuW+6WFIZI1rMBAh0VbOU1+tIl14twlQZg14paR0c68qb1IS4XKfUDMz1+gJeJSx6+j
         n+/3RhemsWQiRH7Fyln9x9fZqT7oKMRniqEgxjzbnU13cbEvYZxcDVzqu4CgwLRTCUVe
         1a+WuKuaS+zIrgcYXUHfiXjnH/fSakBwOFnD9qM7nPHLumRXdIabWn1wforHfannHdtD
         1MGA==
X-Gm-Message-State: AOJu0Yw262QlIk/2AH5TF/HHSXS3Acg+U5A+EeaLblsNeq/Ne3x4i667
	wWGH4vKdUR/y+Z34cLYm+WB5Th9F4NWWqHuNGcKPOfF6K8Exd/592Cl0o1FemQ==
X-Gm-Gg: ASbGncvJmEFbYYQv2F6mrbN7/VmPVc4LHsU6oh33RSGHBKClZko/s3wNoQC2C0WhaGW
	osr3sh+VZVzYoMGDa15E92csfpMV2kazqFI9AWCUCgKwQG5tRsbZmPQuFvvyzUQo5SQLK0PZeJp
	14bemjO5t94Dl0KZHrpcNoCDn2MekpoPoNdMjnSVpGnZUTzEGAz3O+ZGu9a08wkiFmzZJ0upTJP
	2jlhiIj5F2Kwk/5de2ULEU9VGF5GMrpHDawTKa+O0QUZWEhoZeCP7zxkIB9ijzC6kHVyewjgENA
	qgV2FTZzfiJQhInK1gim8Zwf7zxTqHdkr4BiODMf8FxX0nKpjsF30BZvH50I3RX2Viq31nd6aNH
	vwgBrbF3ZEV82eQ==
X-Google-Smtp-Source: AGHT+IE36S9k5lpTrGeJlvbGtSz1lrC9/LBJsU6I964nM8zdfGmxXi1+riNNVd2n6eF0q6LS2DTZ9g==
X-Received: by 2002:a05:6a00:71c1:b0:77e:a3ca:4208 with SMTP id d2e1a72fcca58-77ea3ca444dmr3303800b3a.21.1758306068840;
        Fri, 19 Sep 2025 11:21:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe75e320sm5968626b3a.64.2025.09.19.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 7/7] selftests: drv-net: Pull data before parsing headers
Date: Fri, 19 Sep 2025 11:21:00 -0700
Message-ID: <20250919182100.1925352-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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


