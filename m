Return-Path: <bpf+bounces-50447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6214A279D6
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1810A16781F
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A39217F56;
	Tue,  4 Feb 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F56kZcCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002121773E;
	Tue,  4 Feb 2025 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693881; cv=none; b=OIMZh6ZNbFjcusAEE4zpG4zSu0bq7OFbBjfeDJ22043M6klliZOlr13TTqmY24948/gZzSdG0WJME/1GUgc3E540gn2wvCQjdCj4WetoK0H28rzVCyV1je0Ip/GJGNYb6X2WEWhR4kBeCnuotzuTGmJ8aztLacke8kvvQ5Do4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693881; c=relaxed/simple;
	bh=oM7XkVVat4qAlEjVYfEOrLYrMTv3B0NycZ9+FtJuHSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tikCNCXqBhtugv69qQRdq0ZjTqG7Br7Fna+Fu/vkosljWuLOSk5pnBL/HHOuuFraN+9/VKKQ8T2NEoOYIa8ZXsyeOnx4Zku9VPl6LcbPuiQ1DF/0sozSMPpkyPVtu9C+Ay4XXfBJ1BrAVIWC797gANLjXBIl5fx84qDGAaZibhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F56kZcCz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso47563635ad.2;
        Tue, 04 Feb 2025 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693879; x=1739298679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYg/nh4POHwrnpFnyvVBhE9O9tOUTJqQ4AkISCdkSOU=;
        b=F56kZcCztHSTWna2GptD7jGaeiJUfNAQ94LBXof+G9ZGTsN/kFaohCO/5+9NNk03a4
         3F7NW7SATkQNcMaJqm5uX1aid/Tbrmr/hjmhhx1FLQ0fDbHNOYn5DQTFr+7YVl8beJq8
         dy8vqeQlHb+RiVHNawcXIJPnJGZlOj61eeBu49Dkpao8HLHX0klvqwL9p/g7uDSIb57/
         zUE0XfoOf5pWhDvFX9taHmFTqGfZywm0A7wOnQOOnf8CF/H4s8y12AfaTkZdtD9h9dbL
         dVllTznzy1V1zEgbu+52MMs/GdCOAV+CF4/0FBT5mNaA7z3H9J9bx2PaA0VuZYnmz+SJ
         4WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693879; x=1739298679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYg/nh4POHwrnpFnyvVBhE9O9tOUTJqQ4AkISCdkSOU=;
        b=GXDS7fpXAcPk/BPRzRKgqDmLCigDhvRGUFVsYixETgSQPrDocTjdtzSET/5bdj3Nv2
         LAlglpG1xiKiKzX97gUwfeofM5qljeCclrZBP+pe9Kj3H3eAV1SYFACwsZQboP+jr23Z
         eOkvXzRz+IfKLpiXYGwKXgZtWm110IjcJU142XbGHlCK6BmKcg9yc/rSl2GgpHuoiYEU
         fP3s4x8k+/c/u29RxKPaA6FT2dxfm7emGMAIT/wbxIMnZK2aK82tUfDYqPy+0wf68RRa
         n55YFufGT9t6axXiehV6iPdodTkWzp+1VqVVYUAflRslu9lsCkCka65Si9c5RdjKANAm
         ahDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdUyOSr8y4EaFwq8HWjn9uYRK79kCtlXBV9NnM2clhn+P6N2xTZaDG9EANz7ZGpJrtid7mlT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO45R05cGtE2QlE/zcsBCOGaSSiS5SZQ4DT/Gijrjg3MyuYPEU
	5aqTMjg/X69y4tNnpBlG737FBRlSCheNjY5jgLOYF6QK3/NR/iQ3
X-Gm-Gg: ASbGncuJilHU+MKPQEHdl8BWSxVLvPL2OfVDP1kIFb/QQxCpZr0RehwuA+1MJ99YLmf
	k9UKoeIgPh9/ACaapYs313Yoi2O2j/8/g7TTf40feiKuDkBdf0OjEkpXZ9BuGsSp0klv64UggIl
	8NZqYR8l8zGdft2x2NC9Ppbygyxg4e8byQRlK5dFix0X+nJdJw25iwZPVbIdaDiehHkfEHnGdb2
	iZlqUSezFzlrV8SaauNSd5yQasdlqlbl9DLMVEup7TTs9IV0K9Dkb2ehi6S79HMz0Jp7H+Fcd8B
	dcScR6TjvLMt1B/Cpw8DlBrlM6PFH8QxZZpHT14XbaO0LxNbtFiNVw==
X-Google-Smtp-Source: AGHT+IH427CxnNWIfprunXdRhbzc9MuohuuMP9sV1n817QtpDc8LvRnciRay3+VliUHMHWCrlU9RAA==
X-Received: by 2002:a17:903:298f:b0:21f:1549:a55a with SMTP id d9443c01a7336-21f1549a709mr6568825ad.1.1738693878677;
        Tue, 04 Feb 2025 10:31:18 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:18 -0800 (PST)
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
Subject: [PATCH bpf-next v8 08/12] bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
Date: Wed,  5 Feb 2025 02:30:20 +0800
Message-Id: <20250204183024.87508-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch finishes the hardware part. Then bpf program can fetch the
hwstamp from skb directly.

To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
use this simple modification like this patch does to support printing
hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/skbuff.c              | 13 +++++++------
 net/dsa/user.c                 |  2 +-
 net/socket.c                   |  2 +-
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index de8d3bd311f5..df2d790ae36b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	__SKBTX_HW_TSTAMP = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -495,6 +495,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(__SKBTX_HW_TSTAMP | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6a1083bcf779..4c3566f623c2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7040,6 +7040,13 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on. At the same time, hwtstamps
+					 * of skb is initialized as the
+					 * timestamp that hardware just
+					 * generates.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b22d079e7143..264435f989ad 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5548,7 +5548,7 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 		flag = SKBTX_SCHED_TSTAMP;
 		break;
 	case SCM_TSTAMP_SND:
-		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
+		flag = sw ? SKBTX_SW_TSTAMP : __SKBTX_HW_TSTAMP;
 		break;
 	case SCM_TSTAMP_ACK:
 		if (TCP_SKB_CB(skb)->txstamp_ack)
@@ -5565,7 +5565,8 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 }
 
 static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
-			      int tstype, bool sw)
+			      int tstype, bool sw,
+			      struct skb_shared_hwtstamps *hwtstamps)
 {
 	int op;
 
@@ -5574,9 +5575,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
-		if (!sw)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
+		if (!sw && hwtstamps)
+			*skb_hwtstamps(skb) = *hwtstamps;
 		break;
 	default:
 		return;
@@ -5599,7 +5600,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	/* bpf extension feature entry */
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
 
 	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..ae715bf0ae75 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
 {
 	struct dsa_switch *ds = p->dp->ds;
 
-	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+	if (!(skb_shinfo(skb)->tx_flags & __SKBTX_HW_TSTAMP))
 		return;
 
 	if (!ds->ops->port_txtstamp)
diff --git a/net/socket.c b/net/socket.c
index 262a28b59c7f..70eabb510ce6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	u8 flags = *tx_flags;
 
 	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
-		flags |= SKBTX_HW_TSTAMP;
+		flags |= __SKBTX_HW_TSTAMP;
 
 		/* PTP hardware clocks can provide a free running cycle counter
 		 * as a time base for virtual clocks. Tell driver to use the
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9bd1c7c77b17..974b7f61d11f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7033,6 +7033,13 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on. At the same time, hwtstamps
+					 * of skb is initialized as the
+					 * timestamp that hardware just
+					 * generates.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


