Return-Path: <bpf+bounces-52053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E40A3D247
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609827A8FB5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECAA1E9B09;
	Thu, 20 Feb 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/m98moO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CF1B4236;
	Thu, 20 Feb 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036628; cv=none; b=ULpJoIv2INryiE4Yf+jbUG5H17b0GZphZ5tOrM6vexTgCWan6hzwHtq+BbOqyZivN0a89/g6jwVmTTjFL4slQQnzUvvFdR2h7ufwdZKkOTHbc/SAJd1zjflEjNyIShxeq6BHDOA2NoPzaW7Hz9JvnjW/XDUzJ/coG1GrUO2NnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036628; c=relaxed/simple;
	bh=6uYVTz2gJSY8H3PtNKoONElW/xXfMWaFm2pm9IGwdRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewdceeSjl1a4PRogJrX312flBh12usloABzgFEhmBJVtxa0fHvQpxwfSomql6zOqv7Xdj7IgTNP6vtu56ChoK2ioyIl8tonlHvctCGI/W7ck894FxqbMD5QyOnpFOsToWLPW+rSbTN8F4O8OFGWEkeuM8M5XRPit2rBRVizzON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/m98moO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21c2f1b610dso15824825ad.0;
        Wed, 19 Feb 2025 23:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036626; x=1740641426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUQLHRT/pqNOpAj8Sq4vgFRFXpsqaM61vdZmkVHjc3E=;
        b=c/m98moO9SmG9otDf7osDP/dMifqv3JDePea2RwT99QcSfAUFAS4S3HSHyTn1j2rf7
         y761RI7JegcyEqbrOA3SJr7ltvCWT+PGMi5RXOC0mLFCu8zTXmIrtifQgQHAxyKTALgw
         kLbSAWsjvVrQV9v88KysPwcbs9RsQsKq5xDMR62EnKCoQ1VXR8uF8hfo/wGhsmGvDwNS
         HXktLhJXRZlH07Z1gh9q637j7JvpyRgMj3xK/jhyYVenW3jomz3nhw9n6wwKzaJC1vB3
         jtDqZSF2LFq8IGaP66nI5Qjc01Xmz+aTJNGRpq+S/RZjR+PWb/emgECPB4KNCsvexcGL
         6Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036626; x=1740641426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUQLHRT/pqNOpAj8Sq4vgFRFXpsqaM61vdZmkVHjc3E=;
        b=UvyusxRQiHfxYcstCdMIUTrGNriLqMSxEHS+RTQ4DPiArD4J6xHX1BRqSwpqFuuewh
         io70WZEmSve5pGppjAP5ybF5zgoxouU/cOpq5JPZ+UVCzfZpb0/WnsFBssrOhem1QzlP
         x6Ws3sCCIXsxFqayjXsxzKB0rBvOKtTv4ua/Xi5QfILbxQIcui/CnphoMk0lV7f0z/gd
         VNsReujhh2FK/gJCCsih5fRU530u/wRW6yt/GyycZTXR4tY7ogMjqKLs7f/guf26VN0B
         dlY6HJvk0VdbnBo59r51QcWAnHzvl7TbI7I2IDX+Xjzl7IDZYJgqq3UAY6IoUmnq0X1g
         nKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUazrYc+GnlIwGVCusTXljrmMSwfo4XfZ9CcLXRRucqyO1IpaGN0bjvbamBAL+bXkIJa35R8J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLDLJTRGQwCG7nSUExcS4oTRzHmjmXleo1X1GExRlZDrvKdei
	DJOiOVCYI4yS8tid91xRuaLpTJ1+riizcoGhRX+FW80K3Mr+yKW0
X-Gm-Gg: ASbGncsCJKBqIv2IEg+aJw5QcA+8m5npx1HhxSE2w8sQnSRIXPVnXJuCIvXuo214tRz
	9qQ2jA0KbKMcS7BnTwKDdRDvFVcCPLIfvWdUpskxIx4tfj9z2+c33b9dNBGkjBkN4FLQxLmat93
	sYKAOVP3MJF31MWHW5Mv/roBH6ZwEbhLZtdatxSjaIkFq8z8hcYc/kI4wkKofttWs+SF/PrMZH8
	pV7Ngvqob9Jt82LZqKNggFHgpPY1afcO3Ksr1dPdA6nlxhEHIkVPjuU0+pAv8yPECRAJgkw35V8
	gfJA8rikFHYGjiISQcbYpJgqZK4wjTcujDKqNUocmvvE250R9hVSZwnHxhi3pzA=
X-Google-Smtp-Source: AGHT+IFUMB9Gshc/8cToe6h+rCcQ4EFwQ8+HzBBlcaiokstUia1FqFJRwZ+BSP14Xju5P2BqSj4lkw==
X-Received: by 2002:a17:903:1cc:b0:21f:3e2d:7d36 with SMTP id d9443c01a7336-22103efebf9mr370657385ad.1.1740036625809;
        Wed, 19 Feb 2025 23:30:25 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:25 -0800 (PST)
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
Subject: [PATCH bpf-next v13 06/12] bpf: add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback
Date: Thu, 20 Feb 2025 15:29:34 +0800
Message-Id: <20250220072940.99994-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_SCHED case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TSTAMP_SCHED_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_SCHED. The BPF program can use it to get the
same SCM_TSTAMP_SCHED timestamp without modifying the user-space
application.

A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags,
ensuring that the new BPF timestamping and the current user
space's SO_TIMESTAMPING do not interfere with each other.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 37 insertions(+), 2 deletions(-)

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
index 3a2af105fff0..7bcd8b955598 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7035,6 +7035,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SCHED_CB,	/* Called when skb is passing
+					 * through dev layer when
+					 * SK_BPF_CB_TX_TIMESTAMPING
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
index 341a3290e898..3206f7708974 100644
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
+		op = BPF_SOCK_OPS_TSTAMP_SCHED_CB;
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
index 0d4c348e42de..c3b950325846 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7032,6 +7032,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SCHED_CB,	/* Called when skb is passing
+					 * through dev layer when
+					 * SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


