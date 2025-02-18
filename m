Return-Path: <bpf+bounces-51804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86CA3924E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66E116E2F3
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF341B041F;
	Tue, 18 Feb 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyLZNlYn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617719D89D;
	Tue, 18 Feb 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854962; cv=none; b=Fpjtj0LWZeVlrXZSP+uopo7H+pftgIyzEbAVQP6LRqCVTfYuue6VPLTlVcZ8yTCCXY6zYbJYUiTOTmKyfzUnM1SfUeCmrCJoidi9XYomz/v8H+kjgGMvVnzRTX3mSV8KySOP//tN4AED6MhFAxq7OfLvc7JQUqzHqIKFY4whn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854962; c=relaxed/simple;
	bh=MwnhAchlDNKve5J+/cAJpVlmx6+Xk3aqDL+WS1Pv+Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isMP7BuNVotO50rD/+BhK8NknA+4h9EZkNwvdrUSP7LfnElyemfAfqF7CJ/oaTYuS7aNDOIykqQb6aG18bwDp4Qtw+ZghOunQ1WfwstO+qDTLRvoCyBc1mhBP3j/5GdFSTuLN/8Pmy8f04xezyJtjJB7bCT2DEwM8oXq8dbF+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyLZNlYn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c2a87378so69262035ad.1;
        Mon, 17 Feb 2025 21:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854960; x=1740459760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeqW566o5arTPjVwkcb4h3wmjpR1zsB/qZsvzlvgmI4=;
        b=IyLZNlYnSst5/pwyQhTbMIZxSfodlt4xAnTh51++e2fFA3fLecMYv+uCe5528YtwAJ
         z5S0jLvs5217Ltn1bowcx6HSTWWr5NIMsAlAICFFqowJ7swLG2pj7R11b2HgWVa4lklm
         7Kr17CJrcDB899iLm9ERyU12ytZLZbIjriD0JUYxXiIttEtu5Bb/iFFLJmJwl4941nLA
         aS/WoYItffnQXReppvhJ3rmjazBea86owrViIx4ptk2hYr17RO8RSJ9U7ETCCG+xlXIT
         KlT3S71rZFrrnbdmAsf8YY4hYK9M5Q94krKN+C//itiGopi1P8FSNP05ix4CNqyqGNq0
         WVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854960; x=1740459760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeqW566o5arTPjVwkcb4h3wmjpR1zsB/qZsvzlvgmI4=;
        b=UCWMDq6J/+f0WNNd05sUnVGHVDh3nyGaLaci/KwmmEPh0YlfyyS4HT+vX0Cp4Vrg8G
         93HMKVMXeFtrtPt/cQygcQ1H/no8BTgh2SWa+449YyC6LUgpMO6UIH9Q7CQKb0v63Nc8
         A3FW2QWeo1TpBPjav2plQKEYMP4ePFLeK3nNFcK2WKzk+Y9tCu3+/ugbjYg4QNl+EgWa
         B9nvm5WHVtfm1jCfjysEoIHgOmL4nQMxydkejrTWvNsTrKDzEGHODnFQtJOU4JDD0sT9
         ssNclnZUGpUiWQFBUviGI5O7ML57EHuZ3Tgt7tE2U/IgCOZ0irGinG91wlN24OUg6tAy
         hccw==
X-Forwarded-Encrypted: i=1; AJvYcCVoUZ5YvGj8ZUHTj74CHbxnQGFLRfs91s9BCs+z5awnuVnR7UwuPpvmxDHBZpIEbfmiBQTQjM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCv/5rS9pWZOr+ZsrCiAwxaaiYHHh1pGd4caDAow3wRlHjBC8
	fKTUpPAeG8ZBS2kvICi/HKTOE84TPBKSkL7LI0aLBGd1e8TxI31Z
X-Gm-Gg: ASbGnctzG86FN18Rao7/AY+Ud9Jl5xxIO1Y5UMSxCtqL7tWmeRAlaehdP/UmWw0EAh+
	mS3p5fmuMuVH35dLyK9nbyYSeN8ynP1+W4SnMPjgRFJlNEPJb0aGigQ+Y3J2Ufu9Wf+spe5Np1d
	kbhl+ZjelP6PnksYUmm3jJ06tYV2gHTUnZRccODGnLO2o589WQ0LyfDA0CasPNRFI8TACXOTbsH
	GuYgsxFtktFIahYGbzjkECR1wUnhnpuzhHp+d3aAvY4Emck2v2Bolt2q+bQICAnGdtwFPinhSRT
	6s+p/LiKp5iSJQN8bSrz5bTQ+TDRoj8zwh9LZHU8g4ixQsf3JhLThguDOJM2qi4=
X-Google-Smtp-Source: AGHT+IHD2o7+vVGjFxLyBdympf/mXmQa90Uu3NaJ8fllrALp6+mnFBukciz3QXbsbo3eCzUfEZ+yhQ==
X-Received: by 2002:a05:6a00:2351:b0:730:f1b7:9bd2 with SMTP id d2e1a72fcca58-73261799a56mr19945923b3a.6.1739854960568;
        Mon, 17 Feb 2025 21:02:40 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:39 -0800 (PST)
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v12 06/12] bpf: add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback
Date: Tue, 18 Feb 2025 13:01:19 +0800
Message-Id: <20250218050125.73676-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_SCHED case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_SCHED. The BPF program can use it to get the
same SCM_TSTAMP_SCHED timestamp without modifying the user-space
application.

A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags,
ensuring that the new BPF timestamping and the current user
space's SO_TIMESTAMPING do not interfere with each other.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..52f6e033e704 100644
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
index fa666d51dffe..68664ececdc0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7035,6 +7035,10 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..cbbde68c17cb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+	if (unlikely(skb_shinfo(skb)->tx_flags &
+		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 341a3290e898..0aa54d102624 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5556,6 +5556,23 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 	return false;
 }
 
+static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct sock *sk,
+						  int tstype)
+{
+	int op;
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
@@ -5568,6 +5585,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
 		return;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70366f74ef4e..eed91b7296b7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7025,6 +7025,10 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


