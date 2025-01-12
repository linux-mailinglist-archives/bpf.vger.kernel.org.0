Return-Path: <bpf+bounces-48649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED012A0A8AA
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672B31889A66
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CB1B424F;
	Sun, 12 Jan 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxS7MJVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DB1AF0BA;
	Sun, 12 Jan 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681934; cv=none; b=ZAH2LnceMxjJ5J9GN6lUnccFldSBuEdfwEypDORoLomSTavF3H616+We+Uc/n49sUEoI7VZaEPjAR3zaxIMDSNu4Jc6zNCsXxoShMD5FVaiTJAGRM1DN+7BG82vjbAljU9k2/9iScEvY5OelZxlvDUvwf17T53TsnXxEih7o1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681934; c=relaxed/simple;
	bh=5HWKNWNgHZkoYZJi0DE7QoeYQsWYf/i2DNgj7lr+MIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oyn2gposIyRM7X0ZUteBH1k2BiNoJB3dfXCtxkKgXzXBl7EfbqRrNDetiXpOJoiJtQgcmmnjCaj2+2KZi59HahaOwI8bXsuEaf7LJ9VyJWDhu9uW+rRK30I/crzv/yQ5dvzYQDsX8bZwAdWOOqpI4A2R0DoMexCvjsZ/kqieYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxS7MJVn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216281bc30fso69447095ad.0;
        Sun, 12 Jan 2025 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681932; x=1737286732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg3LyyWwzGuTKgZbU2qb3KZUFeqEKmzFTLkXqDFWKec=;
        b=FxS7MJVnyH+u3ZfU3pXm2YqIREEch1xIF6ZVelIu7eWfABom5+C14wRf1Gn2ueudk2
         fU0hatMq1G504JhinHei1SbgBxsoa4l9MhMpWSF8zkPnU9fRKppoWcCl5+krtUFjPs+N
         VEobJNlf4HkqhlOmq7j+jeIpJrzkNuf0yuYhj8QfYm8kiA2LFEripnXVa1f64D1Wg6Kr
         2IJ3keKnyzF87OeTWCU8SZp1ynazrL/5Z7YYBdmiDVDsrZs14FBuluuwb3hxz8XQCL7W
         1FZdnG7lz4iho28kyfrs+ZPJOnOM6RDrY2nmtD6tOjNIoy9h4evbopzFg1nyjF7q0Cxz
         5HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681932; x=1737286732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg3LyyWwzGuTKgZbU2qb3KZUFeqEKmzFTLkXqDFWKec=;
        b=OOOOgF5h4jEtcQTHq/RG/ICQtgG4slqvts4TEHAEWwsScCfcriCszPpP5WF9Q8/lw4
         npPYP4SBUOACP+ItAaZrLBaNW6z/xc/dgRvRAbDYkLY6nfVesquPtzhg/2aMuEnpCqrI
         FttLlK8vhcU+2gZCsFa5XL31ymQoSOIvExoyzdX213pQR65Q9ZVeS8/C4JXGSbXt2q7r
         PrywsZnOfE70sYEhhhLZeXyiRg4G3qZNOh2qGML7NsSum4kG6dhIbM+z7wpm2AxMvoB0
         e5ubuw4R6rOXtXe/1ISQBFl7lSj8NS9YhbQLm0j1H2isnDfnYknJ3MIV9h+/6Tl2bEqn
         IwZg==
X-Forwarded-Encrypted: i=1; AJvYcCUqshjqcbmd0zAtwhZl47p7t8+fMeZPkFPiGpNCOiCqRbslVgLtmc+4Nc0BHyh41Onx7W6wTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfLrjycZH3PLmYBV8Ccv1poihtAj+szeWpu5kk6yjwIb0csbS
	/7Om0ChseFudjyirf/SEGKG7GVirdfdbtI+iDF93dBA5lQA7zOKQ
X-Gm-Gg: ASbGncuWoHc6sM0iv9leidOIWdDBZW64FJih2k73gCtKo5U+q68FAlvXE0dXB0BDoyu
	Yq4ip0P3f9zc5h1kEZYi070se9Hf+AWht8fPQAYqTb63R8rlQTxfkDtkmLmH8CutgYmg/Z+Q27N
	fcu1G3c2pk/DT/xXK803Fln+2M0JiIOfZGsuxIsNEyLz4NFaBfhyxAZiftAoSssnkqyMm2DsvN6
	HNWmSNFp7rHK97Y9fEfRsmWAymI5l1u29i+VzSZUsO0XxTBOFj2wsr/y0tVTRmCR4iWOswg/ub0
	ZiO15qnf+96doaRnGGg=
X-Google-Smtp-Source: AGHT+IHBvOQsLwQ7wA3eT//puYcIHB+YgHgTSSxHE3DUTZaoAnYzpMxFh/JWktsZTojy+RBzRFsJCg==
X-Received: by 2002:a17:903:230d:b0:216:2e6d:babd with SMTP id d9443c01a7336-21a83f502a0mr273920945ad.15.1736681932156;
        Sun, 12 Jan 2025 03:38:52 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:51 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 10/15] net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
Date: Sun, 12 Jan 2025 19:37:43 +0800
Message-Id: <20250112113748.73504-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
use this simple modification like this patch does to support printing
hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h | 4 +++-
 net/core/skbuff.c      | 2 +-
 net/socket.c           | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4f38c17c67a7..d3ef8db94a94 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	__SKBTX_HW_TSTAMP = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -494,6 +494,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(__SKBTX_HW_TSTAMP | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 17b9d8061f04..4bc7a424eb8a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5551,7 +5551,7 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 		if (sw)
 			flag = SKBTX_SW_TSTAMP;
 		else
-			flag = SKBTX_HW_TSTAMP;
+			flag = __SKBTX_HW_TSTAMP;
 		break;
 	case SCM_TSTAMP_ACK:
 		if (TCP_SKB_CB(skb)->txstamp_ack)
diff --git a/net/socket.c b/net/socket.c
index 4afe31656a2b..57343341bfb6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	u8 flags = *tx_flags;
 
 	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
-		flags |= SKBTX_HW_TSTAMP;
+		flags |= __SKBTX_HW_TSTAMP;
 
 		/* PTP hardware clocks can provide a free running cycle counter
 		 * as a time base for virtual clocks. Tell driver to use the
-- 
2.43.5


