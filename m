Return-Path: <bpf+bounces-67596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930BB46048
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831633A5762
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A0352FD1;
	Fri,  5 Sep 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOQj3tXK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74106374263;
	Fri,  5 Sep 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093643; cv=none; b=hnPEIVpDyX1EqKMQc1Oy5V+2TsKc0MOuCS82Ovx5t7HXp3nx8RKZWR479oEmMmYcN7MBM7u3XKufs3ONoCBRDjBcl3RfTxo8qET/1tIZEAy/Gvf19WgOrtz9nNv/0OtVc5de7Da/YpMkSRQ8hFj+DvtubXUNl9KUvPFVX6RUaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093643; c=relaxed/simple;
	bh=CHuuwPMnvmoCAujfhGM2B374FKr5bpJINN2Jn4vtZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMp8Rum59CtwGLJXLIVUfv95Qf2J7r8er8v2I/O2fd8pn4diekEW7DdJx49LYD74+qqsB/MaUzOe4nv/Wt0qQ2UwqyUD9VFdlmtu+9mOLVL1OxuZHeeq/mnyrKzSRvhbhym5dfG7wmuEznOQccWDolZCkciK41JH2f9N2fnvjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOQj3tXK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248df8d82e2so25901675ad.3;
        Fri, 05 Sep 2025 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093641; x=1757698441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4M9wArd94I6r74Yvpe66WNkmokzrNuVmc5Js2OfZVY=;
        b=MOQj3tXK/Icmdxa+IxAso0YozyywSEU0J+Hed/+STouwrZ195+pEM99q8dUBfCy1xN
         z3YDxoa6XVfepIHzvFIBVw6tvrsofZxLL9a2EBSFs0piVc2RAOkhI2BtR51kinxh8BQH
         SfmgFjG5f2FxDhmzvZK6ViPW9eXirt1ZN80TJ5r72PfEU/IKA5C8366JWGeICfD7ukAe
         9mjp8G1VhOoZre/W6uQ1XODuECdF4u9THnbKMUFaay4Qe2dREUsJcuAqKnyo11mNqNdH
         XxjYkSgfJBhYly9KgzR716FVlqd0NpxbKxwqQM5oQnbIYtvBDInyybrauaRWJWNgMxBK
         gLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093641; x=1757698441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4M9wArd94I6r74Yvpe66WNkmokzrNuVmc5Js2OfZVY=;
        b=wHUDRZMg9dx2zLenJRtRuSRL1UfMdbfLbWOuo31t6Qt3W21QM2cLDsVVOmb2AS2IDK
         W4i1GOGU99PNJ+tFJRRR4fainTbaVLkbieqjqeEAugun9acVxRqd5kGzZAooxY4Uhzko
         TlUDhAMdim6vR/SEsXBdtacHDF57gk1maA0/rmawseYFo06Da2UNJORm5Nz6UQ1taCNC
         TDoxXTfRBYWUafd44Zz6rVzpaY6NlVHWE7GL9o1z96pG3JdIj9rDkWdrga5tJYldSgv5
         z7YKpO18j+RXQDiN+eBPja26Qvfd/3wVJAaacK/mibfuD/KPmmt1+mqgo7Dlo+4EWQhe
         E5pg==
X-Gm-Message-State: AOJu0YwdyMa9jHAHMwxSvzt/ln/2WnedjXBNKRzg2OEkEp6xYN+D/dA/
	hb6szipr2NzbfLIwP2k9r/O0XpBL0BEBhRZuJBydXcMnU7WNBV2/x3+ioZK94g==
X-Gm-Gg: ASbGnctUyqVA/7hO46lR+hMulnlZLF0hxsewQOSiwUQbvchgqj97R9VgJpg/IH4oo3J
	4EOGGR/ALxbgtEsuGFNoEfbxC2qbpd5zAFJDuAZ8WOC3Ln8pHWQ5CbgaDG8l6V/dnIo0qUEVTrC
	SyHOAXRhd9a7Wc8avoso6ZiqRuUTjgDYhiM32J9jtuE19ORWRot2fTXJN+EToZHx1wUe70V9eAI
	VZsfffBocfjyvwm4XRnFfvNGwzCvhxAW3Q9ln6ymGkJ9ztrnR/fGff/6AdKLZlEIN6wTMf0Qs6k
	c6vTp7iui8pfRkDmVHUqChh5SYPDw7PafKdcWmnCh9ok4l1eZzlnwIs3Mgswrsx/opZrr8S5eJb
	RSSYIAoqUD6sE5HJxWzNmSfEN
X-Google-Smtp-Source: AGHT+IHYOfaHMmeCH51bLesQcrAXB4eF3W6DLgKcIK/G2JENcl7SwLI0MlAe1MoHb+Q+QNJxxZJjkQ==
X-Received: by 2002:a17:902:e806:b0:24c:be1f:c1f7 with SMTP id d9443c01a7336-24cbe1fc663mr99340045ad.39.1757093640606;
        Fri, 05 Sep 2025 10:34:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3147sm59264345ad.73.2025.09.05.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:34:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v2 7/7] selftests: drv-net: Pull data before parsing headers
Date: Fri,  5 Sep 2025 10:33:51 -0700
Message-ID: <20250905173352.3759457-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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


