Return-Path: <bpf+bounces-48646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F2DA0A8A1
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7503A8411
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C991B0F3C;
	Sun, 12 Jan 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM1GYkTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D1AD3F6;
	Sun, 12 Jan 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681917; cv=none; b=inxeNopoO4FK3tolyG96HR1d3n/QI7BOu6MlLMcggh+qO7U3DvC8zy2maZ9r1LstH40cpo8y2lkdlaUgc+FMmR4D4YlzHOuNAxW057mwPA33w1RWdkFX4DUFxU7YKG2mdSZYmQxNXpjziDXpb2jBqvDtlXEgfqKt00pw65ouK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681917; c=relaxed/simple;
	bh=Hhvd0hmHqkWjBZwc8xc/MVJ4wpsWacTxStTLosIT/bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MddRqAH6P+5rG5WT7M984LJmSdizno1Ue0vnXxQr4ikO7bQ8peuzXZYxCzjXmgKQ6xD83wjQcgaM0lOYIjNYGYqv8zwqaPOeAmIUCRphWQZYPrMp6aIiFwjxHZgma6RH8J6Bm9bY6K7N1i9ZpF88dnkSLsEQIiMyC0NF+kcEvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM1GYkTM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21649a7bcdcso55829125ad.1;
        Sun, 12 Jan 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681915; x=1737286715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T46OJJ70WGat//Ojd9KW5PyoOlR3VuuKBTjr81P+Sec=;
        b=lM1GYkTMtoDhZwNP+KrJZIfyhAuVfa8fxAOC6ItKPdjx+Muu+UAPsiSYczmhZFWB6v
         VY1bto14js/9hjQjDnbntVRe+8PCnXGowGm0WEjeS7sO6qGrXIODCa/6XXjfOTeKmqt+
         +GFTbzh/XrVPv4xQMrMutMva0Ou4hn1mpv8JWgePWGmbiqWxFmZbcEIKBtAKWMA2AAgC
         qaKizX/bDfqSNHq81VT/wjP2SPGrZ/d+c9ByFIrxg9GTeMC1397Xedn9codRCD9b6V/i
         wNti+Ny1yI88uOu9LrpKgPTPvdn5DGWITeeDnshlSELFgsmmVG1x8FZnZgzepk7dPjVQ
         IOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681915; x=1737286715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T46OJJ70WGat//Ojd9KW5PyoOlR3VuuKBTjr81P+Sec=;
        b=dJB2bdJ9Bm23bJy87LKCa2ALxLzS7IXmirXmtLszTFPwWLf71ugsFNyl7762+dMSop
         Y8pa5/t+dTNnBVWjkAZ31tpb/kE5YQQIfTymOy0IRUsVrmodqYhYxUwBnQjloBmKIUfp
         0CjtCQEVwe8bRlK9CRGrsGXZeVhrTqJm2hBl1KK4B7IbTkMKvf5Qk5FAAS4dLI34vfjL
         6T8j+8pCv3jUyhReaSyDY9TalyGM2vK+04kMrj2YpZ6q9V1ezNjNCaZIsgTqM6hqt7HC
         dm17D5UnPOI+DoWxCMA9etnoM5TQVF7mQCT5Hy9lLLaEe7qnFMGzJYAVk70tXclIjSwj
         qNlw==
X-Forwarded-Encrypted: i=1; AJvYcCVcbO2oF8Pm+t9Xb2z5GjkXCN2GnjXY7C5HNJtXMNyYuYIH9rMXpx0grHirPenOQjCAecyb67g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjPmp53kh0Mt6zbvnQevaPYu3PB0AsJOdNbTgHKEFBkePv0EO
	m4Q9U9P/g5wUvTVzr/DXDAr0CfxN2r+w5Ie0MgwtCaVOKOlW/pxH
X-Gm-Gg: ASbGncuRSMxcbVd4hVn/maqB9H9XiXztkfS5uZUUUslxXu/VJqa/M+EQHyHb8k8XOW8
	cEwX5f/XMqb7OTN7ElcU6YHJ89ERLjFNez+sGGh1+7lWJ9SDLjINvgVwzIbql+VWnHvSAUPn7I1
	5xFK9F7ilY5Yw+FVywO4MHiw1/PrqnhHJSviWUrCbnDk5mX0F74yRxraODri7/hukw797p7L1U9
	hNVFPB/ag+zkv0i6Cq5Ka4TextvvQ2YCPhYF7WW0lrOoJcqvKmnLCVrHWfwikPlD8PzteCXuG4V
	VFVBZBROhwr9RpRZfl0=
X-Google-Smtp-Source: AGHT+IEDWnidsn58sdHKgFs0VQdQy6MoPfkCjTdT5c11pxClfbw0ZtoQdH6FIOHcu/geolmjnFLUAg==
X-Received: by 2002:a17:903:1248:b0:216:282d:c67b with SMTP id d9443c01a7336-21a83fc042dmr249393025ad.35.1736681915314;
        Sun, 12 Jan 2025 03:38:35 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:34 -0800 (PST)
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
Subject: [PATCH net-next v5 07/15] net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
Date: Sun, 12 Jan 2025 19:37:40 +0800
Message-Id: <20250112113748.73504-8-kerneljasonxing@gmail.com>
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

Introducing SKBTX_BPF is used as an indicator telling us whether
the skb should be traced by the bpf prog.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 09461ee84d2f..30901dfb4539 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -489,10 +489,14 @@ enum {
 
 	/* generate software time stamp when entering packet scheduling */
 	SKBTX_SCHED_TSTAMP = 1 << 6,
+
+	/* used for bpf extension when a bpf program is loaded */
+	SKBTX_BPF = 1 << 7,
 };
 
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
-				 SKBTX_SCHED_TSTAMP)
+				 SKBTX_SCHED_TSTAMP | \
+				 SKBTX_BPF)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
 				 SKBTX_HW_TSTAMP_USE_CYCLES | \
 				 SKBTX_ANY_SW_TSTAMP)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e629e09b0b31..72f93c6e45c1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7022,6 +7022,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/dev.c b/net/core/dev.c
index 397fbcd5e4de..3e0cee0b3a0b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4397,7 +4397,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+	if (unlikely(skb_shinfo(skb)->tx_flags &
+		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b34c7ec3d5e9..169c6d03d698 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5567,6 +5567,24 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 	return false;
 }
 
+static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
+{
+	int op;
+
+	if (!sk)
+		return;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
+		break;
+	default:
+		return;
+	}
+
+	bpf_skops_tx_timestamping(sk, skb, op);
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5578,6 +5596,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	if (!sk)
 		return;
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		__skb_tstamp_tx_bpf(orig_skb, sk, tstype);
 
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b0a5b787b12..891217ab6d2d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7015,6 +7015,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


