Return-Path: <bpf+bounces-66444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE6B34B0C
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FB73BB88F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4628A3EF;
	Mon, 25 Aug 2025 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfxzdIlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75306287516;
	Mon, 25 Aug 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150771; cv=none; b=FZQrbyCf/WtYgEy4oqdvEwPtGexx+sqZNQwOEBCU2fOS9TdJhKuz59FUkdWYhix8RlCWZfQ+t/iQynWUlHpElOInGKT9ht+jq7b3NCSnzPHUbOEKXMiz8WJHa6aAwUIFFWEmfnYt3m1zeXlg0hXtX2a8ckbcqx2tG/upE00svCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150771; c=relaxed/simple;
	bh=CHuuwPMnvmoCAujfhGM2B374FKr5bpJINN2Jn4vtZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwTVXItkf7dKvcjnug9dUUh5o72NeMokksErOGBQaoahIfOZyResN9iKWD1OzYzOU8/8MJMXkpdkMdOG0WoogkaxTIoNwL/pgUKkOYL8+p8EGByjeWBKlrY2ekQacjq/PC08/uZJdM+r1gmpOWlrebXqvU/ZSPsnlIk1HlnDEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfxzdIlm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266d6f57so5049872a91.0;
        Mon, 25 Aug 2025 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150769; x=1756755569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4M9wArd94I6r74Yvpe66WNkmokzrNuVmc5Js2OfZVY=;
        b=DfxzdIlmvbbcMaWmV5lls0OQRK5Etkhu+WvmRQm+/3ubuQXzE9tEGG/XJUgjA1Wtd5
         kN0BX7RNBLOLMDHnv90J+t7ZosRXTuhLhVaThPTe2qo3UZWOekFx8E7vkryWvytPGB81
         mF1840c+ZsdhA3VwHRXpfveXoGe7LBBWuZVZ39TFxMqbSDFviXz7OLl1VuVX5BPmBEQi
         /sbu8T4/tQKw7EP7k8GYcYNtQfP2yMQ/H2ObeDn1Zq8iSGtEX+FofL/YqaBYBpvi6qwm
         5lFmzyJodNkjf8QhODFp8iRlZrhmgqovYWdkNbmgA7il4gdUUyBTV2PJHSoemzwRIRs5
         SGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150769; x=1756755569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4M9wArd94I6r74Yvpe66WNkmokzrNuVmc5Js2OfZVY=;
        b=s1bmh/uL+AP8Mxq7+ESJkbAigeE29MpAVbCeacokKTg51vyeisAbEdup+uBaWmEGYO
         DE3SORmCD1BaWqQvI3/UQqZJVuSjqW6oQWG12nRJ12yci8Ft+AOjHoWHZguz3owi6IyI
         M//GJcDv8cXbMF7pPq4sopx1n/9zJzR6/y65yZW5oEjFLflcTvGi1A0PtQn9fd2c+02J
         ggAeA0wR7k/yrXvbAZ1UCze4nYvPZo3X1fWYqw9ywVrbZv1bur6i1w6F6zQIKVo+Gf8M
         5xH7WYZHmumJdzGtxRmISN2T9zwMhl+BptMTHSWJUN0rZxzxiOZbYPbNYbjZR+76XCvp
         dFag==
X-Gm-Message-State: AOJu0YyNa3oSv+iYbcvnVcR8yWPLbg3TLyU3ct78Ik5Y+mbumWJ/0Nyd
	fbQhmlayCdgmZnuKV8EPbmqytJpDNApLatLnmKjCbeuk8wLLdyd4ufDncF9PJQ==
X-Gm-Gg: ASbGncuim5oWosXC02LKBNa+PoODUTR+yix57GGQZsLjJBqtoLWVmdu2kuNQqA/Vn1M
	lK2Kfjjr5i+tKH2EF/gPXEP2jF4CveAXw8BpDv+vb7LlyRUjWW+de2B5wldZpy+Em5DfQuOXS7H
	u7eKpBGAlonBME/lvkOxP+KOIPa1lAUIeF/Vj2cPrWKoSAPCOEtZzrNF1+j5+HIwL8OeIpNww12
	Noqp3oF1kACl8nkPwDrxhgz7dWS/VT/wz+rcdPRAmsa07REfYTQLm7q+PxnUsdeguExDvD1pa8A
	75YIgRvROxL5FsZxv92vTIXC7QHELvBcrUk/njLL1GGAEFgrkJyhEg0O4DcXaMsMxzlbya4dooZ
	EvmYk0cqGG7Fevg==
X-Google-Smtp-Source: AGHT+IHGDc9MYBo7/23AbngNlYRYIZFTAl5+SnuwW9s10isFdxvgX1AyasPS1CjSsVOkqHBN6quFyQ==
X-Received: by 2002:a17:90b:4a46:b0:325:2e4e:5f66 with SMTP id 98e67ed59e1d1-3252e4e60ebmr15397819a91.26.1756150768560;
        Mon, 25 Aug 2025 12:39:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm7713417a91.18.2025.08.25.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 7/7] selftests: drv-net: Pull data before parsing headers
Date: Mon, 25 Aug 2025 12:39:18 -0700
Message-ID: <20250825193918.3445531-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
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
 .../selftests/net/lib/xdp_native.bpf.c        | 90 +++++++++++++++----
 1 file changed, 75 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 521ba38f2ddd..68b2a08055ce 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -14,6 +14,9 @@
 #define MAX_PAYLOAD_LEN 5000
 #define MAX_HDR_LEN 64
 
+extern int bpf_xdp_pull_data(struct xdp_md *xdp, __u32 len,
+			     __u64 flags) __ksym __weak;
+
 enum {
 	XDP_MODE = 0,
 	XDP_PORT = 1,
@@ -68,30 +71,57 @@ static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 
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
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth), 0);
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
+					     sizeof(*udph), 0);
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
+					     sizeof(*udph), 0);
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
@@ -145,17 +175,34 @@ static void swap_machdr(void *data)
 
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
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth), 0);
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
+					     sizeof(*udph), 0);
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		iph = data + sizeof(*eth);
 
 		if (iph + 1 > (struct iphdr *)data_end ||
 		    iph->protocol != IPPROTO_UDP)
@@ -169,8 +216,10 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
+		tmp_ip = iph->saddr;
 		iph->saddr = iph->daddr;
 		iph->daddr = tmp_ip;
 
@@ -178,9 +227,19 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 
 		return XDP_TX;
 
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 		struct in6_addr tmp_ipv6;
+		struct ipv6hdr *ipv6h;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*ipv6h) +
+					     sizeof(*udph), 0);
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		ipv6h = data + sizeof(*eth);
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
 		    ipv6h->nexthdr != IPPROTO_UDP)
@@ -194,6 +253,7 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
 		__builtin_memcpy(&tmp_ipv6, &ipv6h->saddr, sizeof(tmp_ipv6));
-- 
2.47.3


