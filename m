Return-Path: <bpf+bounces-51806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E1DA39250
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ED07A373D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513441B0F14;
	Tue, 18 Feb 2025 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjsLPMdb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986A1ACECF;
	Tue, 18 Feb 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854974; cv=none; b=LfXmZvDwJ+c9qrk0s9+qFg6gMGjjPa3eMoYj4JCWZ61Q6M3+Z2O5cHU3MD5FEpGvcXUA+5B+ohxi5vbYyTcyH98sm+U7pbN1Aydma7WYST2r0D2XdnGAZY/YpmoW2XdwVBGI0PKMDUK0xzQLdCZi6JXar/fGFyxI/3eknyB0cC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854974; c=relaxed/simple;
	bh=KmC/1wQSvEc5h2YZU90pwy7s8cYyQeNpKxYvTEl8WO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfuz7I0dMZQh/+QSDYqnYbwu1V/M1y/sNHug99v7LeH0ibf67mom0FVbZdlQpP0zO0vE8oN5piUlUuUJ89HPnQLraDdoOrPAZqQFfdTqbA18lNZ7ALhMriQKDM628/yJlsktBdpBfhV5axJLN15x4aUxc+sQlefCyXGFRXdgQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjsLPMdb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22104c4de96so41236415ad.3;
        Mon, 17 Feb 2025 21:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854973; x=1740459773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l2sahMfyVzXLK9+XiQ8AOEzAxEpWK00yzRyIH205+Y=;
        b=KjsLPMdbM+jPPbQLqTTN61QFQGxPVth+Q9gT1KHbY5lq6rihk6hd4ngCQTgWEutEHC
         AOEfViYZDzZHXoPFhDDzraQYBgHLbIKE5PnNbc/u3JBX8bWV8HzaZXeqgFkh/mioIHH1
         OuwKc90gPnEeJ3prFHChvkNB0f3RO2A2gbBPznc9wjI1hZ+/S1I+xHuiHq8GBqGcO3QQ
         MwO+DCWsrmjieq9L6XKVG9i02ULMiMuJfzY/FLCXCWU8m2++nqFx9haU4JohFZWzlPmz
         NrTqqkwuyiRbuKF0U3H6bNBxiIBR77qHLI07SVMzIKHXEa5Prhs7bFk0xd+o4LLpwk7b
         MfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854973; x=1740459773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l2sahMfyVzXLK9+XiQ8AOEzAxEpWK00yzRyIH205+Y=;
        b=SOTWIyCBX1U27BJucUdWWXkEAXwk5cOZad2bc/DlEzYxhcYTElm0e5f9FU8MWiCZt1
         F2Eo7UHyGZqzLCGH4E4iI6LnDFIyFUpbHJEIV3IZ53TbGttJz7/RmBjj4u6ySTH4cmzf
         8ASa3HLDkc7Ja9JmM/vk9cbQdJipI1TgFx7bAX1xajChpHWRORHOndp54ubk24SPTuOT
         Q4a2EGnMCYPNlw4Bm2ZSZRuXTcd+B9ezPNFgrncASbpifXG6aOWcJS2bzmuEhE13vi5b
         pTvwxJOIMFglgYEaz8/Z1lBfkjRP1Vtvq9l51OqATQExum8wFEuYGRYTr7jZsavo0hY/
         N/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ03a2ii3NdWqq4R0FPuQn3czCU8bCCRet+Fa9yYkTg3YcCACClhaXP5VldJPCusUxn9pZEHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzKoo9v9ydW3CSbHqTVHZSnWXfhyWMUFD9bwqJ3lwzstEQD/U
	YMGgoFjLU1fLM8ZcKH66R1UMbR0sRJ0NEeu4eWCs+RZwmcm922hLAyWs0lZ7Zo4k1g==
X-Gm-Gg: ASbGnctmYN6gHKtC6T0F8V3a40Ot/faFbeTig0eUnF7UJMnUY0RyJtVAI/QuPRolVka
	75IOFjX+NLvqoBXzaCkMKZMUCbP9BEO0zGhENblwkARpY2xwMxEA45L9p7KeaQdj+iuELJvddqc
	r7gYwLyG/4Jlk/Ll85nebCK4XO5wbrhyG1JjMx7QR5uANq7qnZFHjzjurgPqi944m83w48RJUxd
	k8ntrxh6zMpjzJpgGe2dufPw0vb7oHyes5vk+tzqTkGI6fectZZL/INbqTynAWrqA/8n80IzuuA
	d0uFDd8ji7M8r44NULAAQLsZ6asZdaqbC/4rMbvVPFAT7tstcAiXj1FVQGw65Ds=
X-Google-Smtp-Source: AGHT+IFcyWnuPtK4F2+F/fF2LMRqZphdqRNBz7UzSwzTOpFSmMS39Aa3GMCu2w4ECNaz3NMozG0M9g==
X-Received: by 2002:a17:903:3d0c:b0:21f:7964:e989 with SMTP id d9443c01a7336-221040d84ccmr190990025ad.52.1739854972729;
        Mon, 17 Feb 2025 21:02:52 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:52 -0800 (PST)
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
Subject: [PATCH bpf-next v12 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
Date: Tue, 18 Feb 2025 13:01:21 +0800
Message-Id: <20250218050125.73676-9-kerneljasonxing@gmail.com>
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

Considering some drivers don't assign the skb with hardware
timestamp, this patch does the assignment and then BPF program
can acquire the hwstamp from skb directly.

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


