Return-Path: <bpf+bounces-51500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA9A35366
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA916E035
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48F85BAF0;
	Fri, 14 Feb 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjaRDfKz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F1134AB;
	Fri, 14 Feb 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494894; cv=none; b=mJXZ0A/vUdfQVF/CXsunBzhKbkGHJ7AP1SmV3UnE1WwmdMYhKYLEEx4hDEUHg1DqkxGgl0VqNG5509/MifUsCvfImXKSfjnKOnWXdMu7bpJ8og/U7+Pt7T5B+/x6DGmsz7mVlArje+r6PjYmJKIIaKI8CMlTJUsR6gRkeINixsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494894; c=relaxed/simple;
	bh=CiBuHwmFJE+tYlNMQfksDimJ22d/UNrckF/sMdvmVJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhqlOyeCCAHWTa04PladbVB5X/2HprZzRlVxqboXA2ZPpM+6vFPWPUQDX+z6J3X/C88OP0ZB84ikorJY8YzlOn6c6rnq5mFdtTPGsqGJgOwnl7E3yfJk+SF6kks+T9XwJGLTwPr4/a1UD4/c5ZKHu192vCwXND9lI1ZRm40AdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjaRDfKz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220bfdfb3f4so31093895ad.2;
        Thu, 13 Feb 2025 17:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494891; x=1740099691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eIXDtgolwHKU8f8SVw7JvRUwqk6inDRww5sm41aIxo=;
        b=VjaRDfKzL5wmgzWt0vfpVcvi9lm00B0XShCS+uShXSaAeMMSSk/ftpQSOLzIvSDaMx
         +FQZdkzbXfbuRQeU6Gw5YS2nzcWKJR5ekz3wyYL04V6YxKCAtxk1kItnQMx6XQwYD60v
         ad1zDp35U+gta6WcLyP7VnSn5BseYDqZ15uPj0+4AmJiuU4w5y0CQH0t0wvYe3oeMVc7
         8c63gHGGwCmeqPGLVKZCZjtnzYBHaoNMdQRq2CRH4PxQU5DmR2bGvK4ff+seCnQ17Pon
         tw3DQ53Nsi55MI/xzIJINsl40G1LZjNiFfHT8AMNChp9EGhMVhm5JRyFKTmOWfHvtr/i
         ZHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494891; x=1740099691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eIXDtgolwHKU8f8SVw7JvRUwqk6inDRww5sm41aIxo=;
        b=t2UgrknN5fWLZpV94L7mVx56K7b81Z0B7L6t7F/jFRiyADydG4YHNAWvxB6IKcUmN5
         877RA983oKP8OQquaW5FtwzgXqaXXZ6aPdeqB2vgaz43ufVxwJfLCEFMrhEXHm87aZcA
         vvUsheVYxHU0jIBfZxKZIymqIUDq4afmdFIqO6D/hEfsu6OlcEKB9vMqc+Y9FfwFe9RE
         WtmxY02lCaYMt3+nfs0foBdB7qDLxl1Mz92SLmjK0o0yj0/l97l8s/gsAtiUqfpptuGk
         EOgSSpkoU3AH3sF0MBUI8cD1IjwzTy0VWY2eZ1+kpEtp1IKUucen6YWIBjukwu3CuZkb
         EZxA==
X-Forwarded-Encrypted: i=1; AJvYcCVReINOxH6MgkBn/iTuBvfZotDcdz47dszklKO53zAWZ91r8sM+rHNabsq95lMf2zhGW6gdTZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zBRCZSQpeZCK/vYW7/pzrhewlWhIyXa2Xk2DCY10p2VQ7fq/
	iSo7Os6QP6yIMotnektNA5uSqFovcW2mPNxIg0cCYYeFcytOdk3p
X-Gm-Gg: ASbGncvvgnRDtSZ825uh88BS473RwIFU04h7OI3l5drw/QzGd8V5vlGNveSLcRouY9/
	943dot+wMDIe41TFKLIsPjg5S8tAn3881b+KBCrd/wT1Hcegq4/PnJZltuUx6Bz/V7Vg/8jEwJk
	H2yMTffznpsHS7jU+esXIe0n0MAr2gy4a06p2clhaCHUIEu2c2FP+MZ+ANFg0xgwzl+U+uwfzNO
	yl9xoZHoyla88FfymWaOVvkF5lTDd+frxfHFe7/q8p2kthHEFO/yN3ztDq9572aHs2HG10IsUcZ
	VuWK+fGe4zv5bxcifpjcb3lm1O8AMgl6cqQVKh2BnIfdKG1sb52XdA==
X-Google-Smtp-Source: AGHT+IEz8lGNospW3jKU3YDlc4O7+c51k1gg9BewZAqX4/s3okd+B4hWxvzz20e8IBW9QjTrw9yIMw==
X-Received: by 2002:a17:903:985:b0:21f:6584:208d with SMTP id d9443c01a7336-220bbc729d6mr167290385ad.43.1739494890936;
        Thu, 13 Feb 2025 17:01:30 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:30 -0800 (PST)
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
Subject: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
Date: Fri, 14 Feb 2025 09:00:34 +0800
Message-Id: <20250214010038.54131-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support hw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
callback will occur at the same timestamping point as the user
space's hardware SCM_TSTAMP_SND. The BPF program can use it to
get the same SCM_TSTAMP_SND timestamp without modifying the
user-space application.

To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
from driver side using SKBTX_HW_TSTAMP. The new definition of
SKBTX_HW_TSTAMP means the combination tests of socket timestamping
and bpf timestamping. After this patch, drivers can work under the
bpf timestamping.

Considering some drivers doesn't assign the skb with hardware
timestamp, this patch do the assignment and then BPF program
can acquire the hwstamp from skb directly.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/skbuff.c              | 11 +++++++----
 tools/include/uapi/linux/bpf.h |  4 ++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 76582500c5ea..0b4f1889500d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	SKBTX_HW_TSTAMP_NOBPF = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -494,6 +494,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(SKBTX_HW_TSTAMP_NOBPF | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b3bd92281084..f70edd067edf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7043,6 +7043,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 03b90f04d0b0..acafa05f7f58 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5547,7 +5547,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
 	case SCM_TSTAMP_SND:
-		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP :
+		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP_NOBPF :
 						    SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
 		return TCP_SKB_CB(skb)->txstamp_ack;
@@ -5568,9 +5568,12 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
-		if (hwtstamps)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		if (hwtstamps) {
+			op = BPF_SOCK_OPS_TS_HW_OPT_CB;
+			*skb_hwtstamps(skb) = *hwtstamps;
+		} else {
+			op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		}
 		break;
 	default:
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9bd1c7c77b17..7b9652ce7e3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7033,6 +7033,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


