Return-Path: <bpf+bounces-29953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9E8C8976
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB61C21003
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF212FB03;
	Fri, 17 May 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efgBE+zA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248112F5A9;
	Fri, 17 May 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960439; cv=none; b=dRKzplkEDPpCA66HGRt+ycJIpdfq7BL615PN4n4lij8Bl+n5b3MvbtCLT9x1A+DL8gV04ybQixNI5rLtjXMXh44KdKyhaz0MbkSUyNK75TrMqSCh2hZQTz8vQbrm+bZ0SBhgxEED+KjsPsPH2kKWiWww+kFb19AMYFhIaTqwOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960439; c=relaxed/simple;
	bh=iNsDA5SLvPhu0JbRwQ06u+xbMDVE3hHQVYQf02Bb1H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tyUA5M+cTPveD5vGrb3UicsbPxY8cq9aMc1HHu+VMWba5D/gI16FGOEFA4JqzZ/Z6zolGk9G0ygz41FNebho8KIhCeLyApB3ypgcGcKd75F8fs40HZEXTlGwYSkx8XpluHAAOGl6ay0IJ4wPYZVzJtAo0Wn1OZ4z7SUI79hs0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efgBE+zA; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so12868965ad.1;
        Fri, 17 May 2024 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715960437; x=1716565237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeBHstQjIre4Wfpl7kdLCjbinS3o2KJnHNzvvNjFeMA=;
        b=efgBE+zAOPgMAKpKlPDdN+a1doIdMBMnA5PCJe5gL/1y8bYfNlHc06+ssAStNXrvpN
         /xuInGfFxot7ehI8gDm7OdWH/7EGSa+FbNwk5C4DG5Jc2rAwEDYGEu10gFKgH1YbFcJX
         uINa+/7EWO2WDBPqSzG0RJhVrPq54daq6VdxFqqEtNDXFeIx4RQwk9Yla5TXOnBIKkVS
         /yXgxp4oJsTT+2G/8nKPeVrxgCoRZ/phmZSjWv9Ahb+Odu5ZJOfFwL5LgPRdMU5yPKXZ
         p8/o4ze3yJyXY4emVi33GM5Xr5Zw+PlXhJ7pgWm5VlFg5umQJWt59UQyFw0SAbsxhoaF
         5y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960437; x=1716565237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeBHstQjIre4Wfpl7kdLCjbinS3o2KJnHNzvvNjFeMA=;
        b=BuXnFlWVr+UD+awvsJlTkkdw1w8TbSr+UBU7+JWUEBTKJkACFtIBsD9M4cN3tCR6Ta
         KgQ5uM805FO2tG4EOmY1GsGFxXBcr5kBwXCRRv2XBxlV7HvvOSr96SVYafooPnKfx/Uj
         f8Qwz1vFOofGkEsAOkZZ4mjAaCn4qJ4l7lQ0QNfW81z6BD3CYpEt4E0deXQ6+rQp3HJt
         GGoE05nIlqs2woojCHSQhO0aNPHBp2HazNuvfOAft2CCY2f8Ixrcut8iBYc4Hb9KEIw+
         Uh9bSJlySEosTuMly5M8TCjGX7iSrnWQAVdW0Xp6Tw/QgdelT3bLRrVerDpX7iBNGS9T
         ClOg==
X-Forwarded-Encrypted: i=1; AJvYcCWIFZ5nUeLzRHcqOmXiJFh+0vLGKB3jaDddPJ9bPdZTUWfUAF0WOkHk/vgA5kt3CxNHM061og0Zjz2uC2JRQZRCQyff3Uiml4ngdwbUv8tG1XwaAVe8K1p4jWhAOR4ryV1Xsu8DykkyUOdN+TI4MXyGdxY+S6SYoizs
X-Gm-Message-State: AOJu0YxTD2v+vRZouAMyfMN4mUmvBjDALfGypfdXoJaw3D42pKp6E0po
	zwG7GPp7Wv/e+vRJg2IzOYLwHHSTe953e6NU+XMTgmyfytflrZY4
X-Google-Smtp-Source: AGHT+IFAxssLZ3RlB8pKZO/643cGL8ZseaQ/GUvaESDKuEXqQJ08vNFDKkMH7OAtEz24bk4QezyrPA==
X-Received: by 2002:a05:6a00:1824:b0:6ec:ff1b:aa0b with SMTP id d2e1a72fcca58-6f4e02d3698mr24977798b3a.18.1715960437452;
        Fri, 17 May 2024 08:40:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:26be:370:d9bb:b9a0:16e:48c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f66e4bed05sm6328779b3a.100.2024.05.17.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:40:37 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: dracodingfly@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	kafai@fb.com,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	songliubraving@fb.com,
	yhs@fb.com
Subject: [PATCH] test_bpf: Add an skb_segment test for a non linear frag_list whose head_frag=1 and gso_size was mangled
Date: Fri, 17 May 2024 23:40:28 +0800
Message-Id: <20240517154028.70588-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240515144313.61680-1-dracodingfly@gmail.com>
References: <20240515144313.61680-1-dracodingfly@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch was based on kernel 6.6.8, the skb properties as
mentioned in [1]. This test will cause system crash without
the patch described in [1].

[1] https://lore.kernel.org/netdev/20240515144313.61680-1-dracodingfly@gmail.com/

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 lib/test_bpf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ecde42162..a38d2d09c 100644
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


