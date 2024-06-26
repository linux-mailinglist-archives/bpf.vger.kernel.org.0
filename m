Return-Path: <bpf+bounces-33131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC647917942
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0AC28274E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC028156668;
	Wed, 26 Jun 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeKKPO4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757FC142;
	Wed, 26 Jun 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384969; cv=none; b=tmEh1SBr+V9nFPKbHDEIbXMczY0XXh0kuLTSQmefEVoTTRUCIkb9ZH2XomOrRinneh9DDTlVcFf2+iP62RDFcjVKNQo5N6yzJzbPMYSc1iK6Vxep9w6o5+uCP8mSZIGeUTkOc557aby7SldGTgfwQ/X8M7wdN7RlUegUbI9UePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384969; c=relaxed/simple;
	bh=0G7En6E1v4/3YZONAWTSLmWAQftOdfPRjvuZDQqoMDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7uq/EM7yV5IleydOKrBNSw6W85vnKy81c8LnjEfzBIZScWOPEOlxQ+hQ/QmjtK3cL7aQOjpKAbznDBngiNqWrNkVUYwnsXlild+nDJrW+B5wmt+fLEQXQV43HuX8VT56J3EsSfxEyRE6+n6Nf2L0wg0wBqxk7ZrgX9Edye6mR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeKKPO4E; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso4546273a12.3;
        Tue, 25 Jun 2024 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384965; x=1719989765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fu+i01llNGhvIb4PFAt9GRrQeoF+y3OOCcYVRJn/Tkc=;
        b=IeKKPO4ELnuwCrqfK+aaOEJ33VoKNR584vfekzVCwkP1AgAnjmOmMdNxXXJf+eFarx
         eudrAbE2uRYjM8KtsSJhQMUmqRNMl5q5fhAG0ONGXt9MpRT7GCjjcLkNp5Onczc1idKZ
         8T53TKtfs5kFvvgFowfv8u215wAx1yTDmSq1gbApVJwFx0NFlNVFDN0IK90teJ7xAO98
         AZaLaPIhc8vMgjYeXPhWy2QpDvfPAUcBLmEwnFrN73WkGY2dU6DdAtgouxNjxVSMCCbj
         LUgaXojZO4zHGCahtErtdhaNSmZtti0qrL1TG6iFqEsaNE4YEF2fRCDBvga/HhyYbdrE
         iFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384965; x=1719989765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu+i01llNGhvIb4PFAt9GRrQeoF+y3OOCcYVRJn/Tkc=;
        b=ZhQ/yBAFyUcpwaLkoQffqP1qc9eq5pmT+2awF/Xdq3/M3NrPJRwjBBx5Dk5JTquTeU
         tcc0/AJ3TttJWJyx66PVvQ9IS4c6JoJMmVJA0b1jqF/700MBxpuN4Gs2yjtGkG/+H2LE
         f9o9qyw6CdDXaqUKLAB4VwViwuMVfHsHexQXQuPSAbj2MIUGlN5e/A86kLcFaXfGwJ9C
         i+ghTs09jyipKtlv5b6+qsU5teAbFepE66/d66F+hBe+ivplbrb1HwvCvxNf6347Lp4z
         YV6v8vGyVA4IIHmKAH7snvsQJ2VWvXLLIjrUMuVzUZJiwaF3B1POZY6Q9HjRj1gZXaZz
         7aWw==
X-Forwarded-Encrypted: i=1; AJvYcCWUKfiKWdUOSVZHhVL6WirWgnVHjC3lmGSLH6ii5kXUVTScVmUVm87kLTXuto2NOe1J+zm/kVMNcuaP8B6jhyTYgpH3fgy5MKPkcgvPogErxwaSBNay8FzNZFiOJPK5x1so
X-Gm-Message-State: AOJu0Yz8rc8guFNeGlIz/y3QU8q4sNFCxLq1WqZpfeRlV8QxuIgDg1mv
	3T01Da4lLie9Eg0RJ4XGLtHWwgx/s/WL9CYUmPK/SjsYowQM5mpz
X-Google-Smtp-Source: AGHT+IH5PEWYglzX2R+CewsoiePW9QiVbzzd2USWnD3jSuHRPjaSIrCIm+RfzQPXiGQmDdrYxK4Ndg==
X-Received: by 2002:a05:6a21:3288:b0:1b7:dd1f:b7fe with SMTP id adf61e73a8af0-1bcf7eece58mr10222820637.29.1719384965539;
        Tue, 25 Jun 2024 23:56:05 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:9d04:e74d:2a89:713])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5f87sm92776495ad.166.2024.06.25.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:56:05 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	sashal@kernel.org,
	linux@weissschuh.net,
	hawk@kernel.org,
	nbd@nbd.name,
	mkhalfella@purestorage.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH v2 2/2] test_bpf: Introduce an skb_segment test for frag_list whose head_frag=true and gso_size was mangled
Date: Wed, 26 Jun 2024 14:55:53 +0800
Message-Id: <20240626065555.35460-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a reproducer test that mimics the input skbs
that lead to the mentioned BUG_ON and validates the
fix submitted in patch 1.

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 lib/test_bpf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ecde4216201e..a38d2d09ca01 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14706,6 +14706,63 @@ static __init struct sk_buff *build_test_skb_linear_no_head_frag(void)
 	return NULL;
 }
 
+static __init struct sk_buff *build_test_skb_head_frag(void)
+{
+	u32 headroom = 192, doffset = 66, alloc_size = 1536;
+	struct sk_buff *skb[2];
+	struct page *page[17];
+	int i, data_size = 125;
+	int j;
+
+	skb[0] = dev_alloc_skb(headroom + alloc_size);
+	if (!skb[0])
+		return NULL;
+
+	skb_reserve(skb[0], headroom + doffset);
+	skb_put(skb[0], data_size);
+	skb[0]->mac_header = 192;
+
+	skb[0]->protocol = htons(ETH_P_IP);
+	skb[0]->network_header = 206;
+
+	for (i = 0; i < 17; i++) {
+		page[i] = alloc_page(GFP_KERNEL);
+		if (!page[i])
+			goto err_page;
+
+		skb_add_rx_frag(skb[0], i, page[i], 0, data_size, data_size);
+	}
+
+	skb[1] = dev_alloc_skb(headroom + alloc_size);
+	if (!skb[1])
+		goto err_page;
+
+	skb_reserve(skb[1], headroom + doffset);
+	skb_put(skb[1], data_size);
+
+	/* setup shinfo */
+	skb_shinfo(skb[0])->gso_size = 75;
+	skb_shinfo(skb[0])->gso_type = SKB_GSO_TCPV4;
+	skb_shinfo(skb[0])->gso_type |= SKB_GSO_UDP_TUNNEL|SKB_GSO_TCP_FIXEDID|SKB_GSO_DODGY;
+	skb_shinfo(skb[0])->gso_segs = 0;
+	skb_shinfo(skb[0])->frag_list = skb[1];
+	skb_shinfo(skb[0])->hwtstamps.hwtstamp = 1000;
+
+	/* adjust skb[0]'s len */
+	skb[0]->len += skb[1]->len;
+	skb[0]->data_len += skb[1]->len;
+	skb[0]->truesize += skb[1]->truesize;
+
+	return skb[0];
+
+err_page:
+	kfree_skb(skb[0]);
+	for (j = 0; j < i; j++)
+		__free_page(page[j]);
+
+	return NULL;
+}
+
 struct skb_segment_test {
 	const char *descr;
 	struct sk_buff *(*build_skb)(void);
@@ -14727,6 +14784,13 @@ static struct skb_segment_test skb_segment_tests[] __initconst = {
 			    NETIF_F_LLTX | NETIF_F_GRO |
 			    NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_STAG_TX
+	},
+	{
+		.descr = "gso_with_head_frag",
+		.build_skb = build_test_skb_head_frag,
+		.features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_GSO_SHIFT |
+			    NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID | NETIF_F_TSO6 |
+			    NETIF_F_GSO_SCTP | NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST
 	}
 };
 
-- 
2.33.0


