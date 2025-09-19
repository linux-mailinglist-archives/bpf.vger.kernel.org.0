Return-Path: <bpf+bounces-69015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4CB8B9CD
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377C558873A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3D2DA76A;
	Fri, 19 Sep 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrMiTKuJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9452D9EC8
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323402; cv=none; b=qyxMeV/kdoYOPG5HAYCnBM4DUBqk7VNF27z0Eu1OkPPhwHN54PpYOKz9k89plPC4qOYsrsyVOb3phCR5wNrewoxDpp31+ZgQZbmOFr31ivlFEAPJkPHt8CVQorsBkO2T3Jy9fNR84DGwAykigVAFXlye7UmI39ktNYW/8I0ZNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323402; c=relaxed/simple;
	bh=nDmjbXMAaaARovoem/jblg2PIL/t10TLTSxc9dzhj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubl9LxzXyE6EG45dC4gqmfNI1teWJ0TngUm8Ezl9kEXHF1m9ri5xxtCJ6kcTXup/lmsUHQtvyO72HmSgG7MY9Y3Eppi9myHyVIyHFxjPw1xjI/mn07pbjzZLlKqRJ8x3okeX3pOtnIZVyQqBCWVQcyRVXjigzuf3FQCm2ADuDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrMiTKuJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf605b1so35594515ad.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323400; x=1758928200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=jrMiTKuJVOCtcsqj9vz5zc73MAgAZkrkhb3rNlxqsqo/v8zEtqePb95Z4D9Ff1qJ12
         hBaP9YI3snKMnvAN9OczzkLQgSNDLYneGmWlChMhviBj0RxnnS1XBmBhg080TA1rGDEo
         vbUCtmPL1h6ObNbMKue53iiQ77KtXgpuw1jDojmdTCAqsYtX8A+ygqxMK86OtVy4RHYt
         aNMioN51chQiWhfd08S5sLmd3IkmuoKb/sVeBt/YPbluNeGtPmGPXJYtUe+jsWZetGI3
         iyb9IvzoaL0IV+BF6xoQptA7pwAKtChXvrslZtDAKa1U6TdjPIUWEuL5aoQrje+e7ppe
         Igcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323400; x=1758928200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=LKtR4BCCjHCAiUHnvlqWY0atmMpvxp/G1QXNvb4Ho+CD4RmsdBIGdnYT1asFWvlRE5
         cXavK1E781qG6WmO5pU9dZazHwW+DTi+n5r9DYeGNbofAxXyncxv+29QVw/RmnkNGGjG
         A8s8et5k1YBZNyurncFoOFjNQzYs0OVOQgIDecIU/h4pxIlnYEjHRrsqwnnXyGbvH0T6
         Rawwk55jVTVwb6xchWG/fKWCqQ1oULl9ZgumGIiq064I3+8P7qzk+ZM3Z9rV7T5vExiN
         0z1EDKn5ECoHzoptdCPOdVBHYm9F9XjobWJ8KMCzO7e/OOb6TXmeXY1YE5oFhJSx5uSO
         KWBQ==
X-Gm-Message-State: AOJu0Yz6H/KIkfjxX5CCT/FayI1X2HzFBFnvCeWbKV0WpzOiSEC0rHkR
	IqZEDgUWs0yX6oqoCwaF6wl67snazzrPs8n4vVbgQo0BoUcC5cpfxePDNDA7Yg==
X-Gm-Gg: ASbGncumcYrOFYx/PYbMKCtcPmDKswJHGXNgl4byX1K3iBaD7qW9fcesRx/qmgvmCDG
	mFz4sPIzh3mR81g5f+Y2tFOFw6jMCzyWUwEAN3xXeRQFYN3yLlSiIlQFvpVbIP1cTCXPyOImWWf
	gXI19VFXMqxggBTHQrbsHMlQHbccqg5qO2LefTN4eg8KuLNAJK50KYRRBw8fzrQSnbKyzi7kaVj
	seySItcTH0N2x5t+45KjfEB81HnuoH95drwxtOIwzAzOaQrbJ7Sdeo2zl1/fl7DZo41icCW+cHv
	8/d81r0B2CthppYjRYhSpvtVy7I0056PPay5Nf3mIhmA6ZChF7a3CAPi8yFFv+CVD5idRJElGZE
	Egm+1288SGN2N
X-Google-Smtp-Source: AGHT+IFcysuzP3rduPjropxaTA4EuKYQcJiZtfFTX6ouuJ2uh66xahLuCndpNW2YEKS+WRm1cLEPNw==
X-Received: by 2002:a17:902:f64f:b0:269:96a1:d96e with SMTP id d9443c01a7336-269ba46699fmr63403595ad.20.1758323400267;
        Fri, 19 Sep 2025 16:10:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980339e89sm63843625ad.130.2025.09.19.16.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 7/7] selftests: drv-net: Pull data before parsing headers
Date: Fri, 19 Sep 2025 16:09:52 -0700
Message-ID: <20250919230952.3628709-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
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


