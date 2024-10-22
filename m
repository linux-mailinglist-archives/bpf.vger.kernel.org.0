Return-Path: <bpf+bounces-42828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4A9AB7F9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474791C2310C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC71CC8BB;
	Tue, 22 Oct 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJEoon9Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215E126C05;
	Tue, 22 Oct 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630154; cv=none; b=mo2IeuAlQo6oNDhTHQEGUP+U/6sohTNlUkxHthP7vdYg/6oNCEDbkjNzVBMAAcGXKA9sI+cvLGoENpdANVcJgcFSfNiVGOvw6q/K4Cjin6GkZL3qLh8SdPf9Pxak2C6LSur7BKzIgsyeXrSo3Um4dn2n0+Fr44ozyrIxPbmmRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630154; c=relaxed/simple;
	bh=dittf4YLWlk6FyJunLkXtq1goowtssRJG7mp7ZtbN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3eGnkmV88nYfefa1BSPtwMxVypF84pLFo7oLx29/sHk2xuETCRCHgkevL+842eCZLkwT5B6Ee34qzY4S4clDztyzHlni645lklIc5tVjvlnpLppwqg7OchVK/JI8wZAcXDPp37QlKL1zHaVL8S0hm3AWpqQbchgzBifRDVU08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJEoon9Z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e52582cf8so4294446b3a.2;
        Tue, 22 Oct 2024 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729630152; x=1730234952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ffGPoSlqwPV+RaSbIJ/P8DdxGIkGwkezqZ29HBWiZ4=;
        b=DJEoon9ZpSTp4i3ynI1Ye1Rj2pV98B4iNYXJIOP9/4xB4btedc5uNFLOTc/wkQ87Z9
         GjxpJgf3OXMe0D0wdm03yJ+Yxov2GOHtKqL8dKUS32J/66TCtSo5+Xrs6TWFq2iV3vqq
         UMwxawws0FSeD8ZY817YaZ23rI299GIZM4jth/yBltdjPits5VBz9CYNMPg7YPvHOlvl
         kiFwc30xbUMFah7T2bumaUcfezhjQCX3bKVNo8dPtuIXdqZ5vLTLlkTHBywaVvStQYKw
         ccyNvhzWWu4yIjEAyOqHTIyPI2OjcBHPS8SVK3XtosMaI/k25FqMWChWGpcZz9pFYxq+
         g7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630152; x=1730234952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ffGPoSlqwPV+RaSbIJ/P8DdxGIkGwkezqZ29HBWiZ4=;
        b=F9Bf5aodNsqxLv61Rz0+oxEBqFxEPqPsrcTqHo3VX7JDCA7crN6OUopWNbX2gCeYi2
         NPJMbVSnolauWJqthpoZoYEL9yLJitVszH+5fUsf4kc7uTNTMc40zq5uFEPX+30eUxbY
         wWZeGpDsr9bpPBEUsi5stHQnnE4k1wdMVjS+nysx5doOlm9OCqzC3SGdrsdAHxZnbSf9
         6HvkM+g0omfK9ciLpY9QhS2TTkWvwN86feuwtLUnvTUrQtBLIZReMJOIwUIz1CtCYHk4
         XyNyR7XH+e4uM0SoliwfnSdABovDlFveo4mweH3B0lqS8b9lSepA3ze58G5G7UHTdlZk
         08Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUv5tkbOvDmbbo0dIcN0PzjSuWnvKLOOSFV4xPnjBEHpMXGtblCkzCnSUPJpYl0CBL3wo6BEymrTT2+kmJ9@vger.kernel.org, AJvYcCUzH8lXGJuaRgcVimUbyl/rQAhCM5o9s0zBuVaL5ppj1Ho4u8vo3o2YxtkdNgDKdjpVios=@vger.kernel.org, AJvYcCW9Ri2Pz2+NVOq2oO4R/yzGI9LmAFFlEtDcWO98mHq+DZv0Auvha35IKKqG/mdE+CFaHhiwKNm1nC7U47xA@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsC3jBgaUpwo71X+8ifrOdX0dNs780P3Np58wxA2rnudZ4V73
	o/QD5cerztv+OYMXyrljhQi7BVEuw5bWCscrLP+wXiHop8Rlu9mHydQHMqk2
X-Google-Smtp-Source: AGHT+IEt6paVVR5iJbEJAuGo6CnfteGATce4ywHLHC1CFvA/2HmuoSJo5fx+ZhAfak0QRGBMpqNw9A==
X-Received: by 2002:a05:6a00:4610:b0:71e:ed6:1cab with SMTP id d2e1a72fcca58-72030cf05d3mr654027b3a.26.1729630151673;
        Tue, 22 Oct 2024 13:49:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312e2bsm5133906b3a.42.2024.10.22.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:49:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Rosen Penev <rosenp@gmail.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH] net: mana: use ethtool string helpers
Date: Tue, 22 Oct 2024 13:49:08 -0700
Message-ID: <20241022204908.511021-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the data pointer.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 55 ++++++-------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 349f11bf8e64..c419626073f5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -91,53 +91,34 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
-	u8 *p = data;
 	int i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++) {
-		memcpy(p, mana_eth_stats[i].name, ETH_GSTRING_LEN);
-		p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
+		ethtool_puts(&data, mana_eth_stats[i].name);
 
 	for (i = 0; i < num_queues; i++) {
-		sprintf(p, "rx_%d_packets", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_%d_bytes", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_%d_xdp_drop", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_%d_xdp_tx", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_%d_xdp_redirect", i);
-		p += ETH_GSTRING_LEN;
+		ethtool_sprintf(&data, "rx_%d_packets", i);
+		ethtool_sprintf(&data, "rx_%d_bytes", i);
+		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
+		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
+		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
 	}
 
 	for (i = 0; i < num_queues; i++) {
-		sprintf(p, "tx_%d_packets", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_bytes", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_xdp_xmit", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_tso_packets", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_tso_bytes", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_tso_inner_packets", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_tso_inner_bytes", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_long_pkt_fmt", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_short_pkt_fmt", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_csum_partial", i);
-		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_%d_mana_map_err", i);
-		p += ETH_GSTRING_LEN;
+		ethtool_sprintf(&data, "tx_%d_packets", i);
+		ethtool_sprintf(&data, "tx_%d_bytes", i);
+		ethtool_sprintf(&data, "tx_%d_xdp_xmit", i);
+		ethtool_sprintf(&data, "tx_%d_tso_packets", i);
+		ethtool_sprintf(&data, "tx_%d_tso_bytes", i);
+		ethtool_sprintf(&data, "tx_%d_tso_inner_packets", i);
+		ethtool_sprintf(&data, "tx_%d_tso_inner_bytes", i);
+		ethtool_sprintf(&data, "tx_%d_long_pkt_fmt", i);
+		ethtool_sprintf(&data, "tx_%d_short_pkt_fmt", i);
+		ethtool_sprintf(&data, "tx_%d_csum_partial", i);
+		ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
 	}
 }
 
-- 
2.47.0


