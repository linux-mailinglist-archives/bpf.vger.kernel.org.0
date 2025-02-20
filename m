Return-Path: <bpf+bounces-52055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC60A3D258
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927103ABEF3
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE31E885C;
	Thu, 20 Feb 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxge8Mi1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1911E7C08;
	Thu, 20 Feb 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036640; cv=none; b=nFRSrdyaOGgPXOmW4CXxkjrZ4vL415SXS/qosyCGa6nxF0ptJFHS1V7SVGvkeiTDjQ05hMQSLSScdArV9iOoWkN9T0mzBNvbkiCO8vCRPzbiSupsxY0fvrQNiFiDRDpDgglWv1rDyofO9OgUxvyoHrMWVIJvQC51qV9tAfNSJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036640; c=relaxed/simple;
	bh=BL6jk5+WNhi/FA/CAS87bIAkls1+bzgDfR+0WSaUfuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nONl7OtgjoH6b9vzy5MLKZiX+E3oevFrYTQq/N5CknUnj12HRe+ac3dYqhMQeAmvUEEBxkaND7VRNf9cpupG8lRxK3oMku/6ogRcy6zzi7eAngEogLqWrNrGCkybcHa9Xo949xhTY9PXSHBhF8Qg7LETAUoP9fy2j7I8gFg9kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxge8Mi1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211cd4463cso10482455ad.2;
        Wed, 19 Feb 2025 23:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036638; x=1740641438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4qUx08LGWRnLuJ7bCXGD0v8j0A90dZsifhXe0rQHuM=;
        b=dxge8Mi1y8l8xbSBF6HeHs/n1Bil7EN6FgL1LPNjk5XTA7d3L6yldksRNcpoLfJoLU
         38bXIvAm7LskQV79x5UymQFspsrPFZqhERQYdAMcMwojJTRNj9kg0VkGVsF6A2TlD9fF
         +lsI0u5JnJXHEjIjAPdVcyFEzLLk8XM+PnkfLcKKL3uWln+GdK5biZkbxevpUwWrrNzC
         pG5A+4B5ctKJb3zCxxbkYDY7F24zEjTDkevNMy4aEaUZvXBj3gaN/nDUIfwz9D5xMaPL
         rrqO2fejkErRfuFJKzsEGLMfNxeMXq8LLjBOw4475ImFJWzXbImo4Ny877fBlZArOZiH
         ws0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036638; x=1740641438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4qUx08LGWRnLuJ7bCXGD0v8j0A90dZsifhXe0rQHuM=;
        b=Cn+3rcp1/8GUpdaJFG1QUGp9keZdvJq6tm+bBszc5ZFqfBNfj1tIVTMnzIhejTRTlx
         VSZctmuUet7VmTlKctfGA3xu3zeDtkm1Rctg952NoTZldK62ya0NyiSlKGcqVF0cYx1v
         1V4dtdYBX0pisl/Ruu3mjXmstp90husDngfzjcUBYDT11fCCbZoCGjRWtHTx9c0OlSrq
         nF5qoBehILhWvi7x+OQ/YO1w2oxkp8OmcQGSHnQ08yIODc3q+sBqL+mjFjUho4DEU19N
         0nMHnkv4zbhSVuWSYk4bA2y82yCO4V51uyAki9Mbx6nT20C1mRaDnfILvXyscAuJxCtc
         Qr7g==
X-Forwarded-Encrypted: i=1; AJvYcCUbxB2dZmC6j3UfvhzBVsoPGlnHMiL2//Tikgvf1WLunR4oFVnx2qYJg2NkPlxWh+mpLmgBLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5IfxaJKVG1XcyJPNNv71gaz/FVpvdpPm81qQR6nOrJ70mizS
	qsrS5Lmjd+TcYbE/7iI144Prm/T457em2ssMnv0VMq1GnMKyM7ay
X-Gm-Gg: ASbGnctKKTidQTAHVCgC6RhSJaKYllwud5tS9bvBOSixWkU2YWJ73ZEz/bPOVc4au9H
	OLkSc7GVr7niNPODFKJV1ACzqqG3u+oOZUt0eaSUXH2bj6zvQw/XdzxQ2Xt2XS4BzlooHonCLr6
	rehFQTHC63W+vKwQ0/iEaNKbF5mI5k1IvHkiZiGoLoxdYYt9eCsemsKE6jACUAlX95J1cmYCd5T
	otsU3abNoA8e6N8Yq04ECiIYNvf4gyhEss/RnyZIqXT4rBDej3Z6D2CgdYc2gMzW3g7UBWoU+t4
	pHoA8uVwSI2wyZWDd1ULfAv2+VgzbU6/1/SNOeFh8n/jJlG6HOU4v14Y+qeckl8=
X-Google-Smtp-Source: AGHT+IEzXxOBkzwYOrCDoAlQ/aLNhemU3u6aSEHyKmgBoYUsVxkrFP63VkWpzmibJsAhL1E26OA6QQ==
X-Received: by 2002:a17:903:94e:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22104034f86mr352074285ad.17.1740036638131;
        Wed, 19 Feb 2025 23:30:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:37 -0800 (PST)
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
Subject: [PATCH bpf-next v13 08/12] bpf: add BPF_SOCK_OPS_TSTAMP_SND_HW_CB callback
Date: Thu, 20 Feb 2025 15:29:36 +0800
Message-Id: <20250220072940.99994-9-kerneljasonxing@gmail.com>
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

Support hw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TSTAMP_SND_HW_CB. This
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

Considering some drivers don't assign the skb with hardware
timestamp, this patch does the assignment and then BPF program
can acquire the hwstamp from skb directly.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/skbuff.c              | 11 +++++++----
 net/dsa/user.c                 |  2 +-
 net/socket.c                   |  2 +-
 tools/include/uapi/linux/bpf.h |  4 ++++
 6 files changed, 20 insertions(+), 7 deletions(-)

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
index 59adcef3326a..4ec1a86288ef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7044,6 +7044,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SND_HW_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 308db7dae1ab..77b8866f94c5 100644
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
 		op = BPF_SOCK_OPS_TSTAMP_SCHED_CB;
 		break;
 	case SCM_TSTAMP_SND:
-		if (hwtstamps)
-			return;
-		op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
+		if (hwtstamps) {
+			op = BPF_SOCK_OPS_TSTAMP_SND_HW_CB;
+			*skb_hwtstamps(skb) = *hwtstamps;
+		} else {
+			op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
+		}
 		break;
 	default:
 		return;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..794fe553dd77 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
 {
 	struct dsa_switch *ds = p->dp->ds;
 
-	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF))
 		return;
 
 	if (!ds->ops->port_txtstamp)
diff --git a/net/socket.c b/net/socket.c
index 262a28b59c7f..517de433d4bb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	u8 flags = *tx_flags;
 
 	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
-		flags |= SKBTX_HW_TSTAMP;
+		flags |= SKBTX_HW_TSTAMP_NOBPF;
 
 		/* PTP hardware clocks can provide a free running cycle counter
 		 * as a time base for virtual clocks. Tell driver to use the
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1ead1e9d31be..0a7db1440653 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7041,6 +7041,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SND_HW_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


