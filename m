Return-Path: <bpf+bounces-49939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F33A2067D
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E6E3A29C9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CFD1DFD84;
	Tue, 28 Jan 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aesQOHB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5951DE4E3;
	Tue, 28 Jan 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054041; cv=none; b=cQACwkWKituYCKSMIcfnTtV0xBVRWhZLeId8PUu6ZCVZookl6Thj9plAncqCazoBes9WPU4OuRmooA+osSuZeVYHH82gflOebvUqzwTbd8yMf1GkVJzqNtaAxvw7iY+p48LLhSk4VgK/XuMsqRIou0bM61HPuf+myUUzQtUglcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054041; c=relaxed/simple;
	bh=BdNB/GGRAZb8/epyZCnM9bOLQPXObRKF9ZTMJJ2FsWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjYyyWnYu7mgGQEsCD12CASfd5ppk0EAcZU4WcOb4t28vIS8CRYUdY0SOtrf4lKc8QmyZaZRIiddhOMusSkng3qpL1ayBI+lEaB96/TX/Jb1Aim33uRlO992pQMbyK3W/YU9Gc8u0s0N8YFSPLItFfMucZhRRUQbKUANUJZfSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aesQOHB0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21a7ed0155cso87710115ad.3;
        Tue, 28 Jan 2025 00:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054038; x=1738658838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLm7BAECDHVjsR7lqQUOHfEEMf58hoJW0MlcXzl0Asc=;
        b=aesQOHB0WkK2NXCYiUf3F+dBmA0KBa6luYN7xC6pMne1Qa0ai4Ymn5s5P1WHqXW1Uq
         thXTzOfTTKiy3z5Ue7ebtx1YtIiubJmU43G7oRKSoXxiy7mDHtdMCEZbMQdjSE8vAsD8
         fNntlFytDC6x1KBUHSy1l6KInE7pa6P1RAxEllwGn+fOfUwLwAtOVbSVMKhJAzXSmKl2
         OfRlAlSSKpUW2Eg5ltJrb+LwDU3iIzI1uBlraCZ0CWF28PsO/0eB9U8olaytpMRYr0pF
         Tsouc6tMFPrhxhfWsClLbmJQplyCnA7+n3HaWxFvAk1cuuPcsRVASE6YLZolyqhJaIfo
         C4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054038; x=1738658838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLm7BAECDHVjsR7lqQUOHfEEMf58hoJW0MlcXzl0Asc=;
        b=cw1EEeWK4hbDlLJzXyj1FhHZ+2N3NGakXE+G3pRfNxaxmR8AKjOCeqqPUumB8XR/y1
         WFZBCI7Pd4MQyt/2Oa8gkgnXiMWzBzFQFQ2IEOAZlbWaAM8ChZ1EuuBDpx4C092xzl7N
         0aZbgfbmhIXkCJ8WHrit4QRh8C7ZhFZ6XXXYMkwn+F98Wd9MjOr51fuoPVHqBAA+LT+b
         yAPRAq8rfw/1FLcpyx54nD312DqZ1Ub2KEOVn8/sGvRZyHG+CHfQRy1bGqvxhvS0NS3G
         jn30QOu6hcWmTS9eNAPidUPS2WJgSIrZRYjF0XAthCyBTNMFM0c1xcFbcuoMc9VSUUn+
         LHuA==
X-Forwarded-Encrypted: i=1; AJvYcCWcixDkF/5fV338MR07384rL5FryEgtX1Jza+m3D88OWNDPAw/JmWM+2YXhHq9IgT23WsMsj7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YznzIiVNuaE/lRA3S5UPC1uKeVQ2T9UgORejMv05wSGFVJHGvm9
	fm5b8sbU12vqsI1iVdPxxXMojgJ/q03JLZ0HQ+Ye3qS4hW6Huwnf
X-Gm-Gg: ASbGncsLgg9o2NqdzifsdCRoAgvWTxRGiBJNDlT9Nujnn+1vl9O4KngoK5PtKHfygx+
	P17N3Ei89W/0LqqebUd7IZKqyaogg9RnLGii2rc9/M/mjYRJg+Ito5dEoHl8HATzfH++oQrScNm
	Gk4inyFoYkROj7Fzl6J+L+4EXDrUfue75iML6asXKhMpY9kTwHhkjnzWUwk2kNIrxCcZbft5jhg
	Iwbi0+EKqsNgfKWmnU+Mc5Ctsl/3mpgzhOHXIoeTR62i+pa274TTCBRy7lPyc+3PWapJgUilpsp
	QSYHD04smOAES6wfPMwOxFjP+fyQgZALu5UyoHvmS9aYaIyWfih4gg==
X-Google-Smtp-Source: AGHT+IEQRAbljmz3IUYoIAWT6T/2agG5jGLBP0XowJYvZjdG+EQrmuF60AkaX21Ml7ciCoMu5yiwyg==
X-Received: by 2002:a17:903:2b0f:b0:216:69ca:7707 with SMTP id d9443c01a7336-21c35586204mr663584025ad.30.1738054037965;
        Tue, 28 Jan 2025 00:47:17 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:17 -0800 (PST)
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
Subject: [PATCH bpf-next v7 08/13] net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
Date: Tue, 28 Jan 2025 16:46:15 +0800
Message-Id: <20250128084620.57547-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch, we finish the hardware part. Then bpf program can
fetch the hwstamp from skb directly.

To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
use this simple modification like this patch does to support printing
hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/skbuff.c              | 11 ++++++-----
 net/dsa/user.c                 |  2 +-
 net/socket.c                   |  2 +-
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 25 insertions(+), 8 deletions(-)

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
index 288eb9869827..c769feae5162 100644
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
 
@@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
+		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
 		if (!sw)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+			*skb_hwtstamps(skb) = *hwtstamps;
 		break;
 	default:
 		return;
@@ -5602,7 +5603,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
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


