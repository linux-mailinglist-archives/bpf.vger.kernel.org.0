Return-Path: <bpf+bounces-51805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2BA3925B
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67BE1610E9
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394021B0438;
	Tue, 18 Feb 2025 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDDjggxm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547991B0409;
	Tue, 18 Feb 2025 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854968; cv=none; b=ArBysinNXqfT/vD9G8O0JVd5RxdPlm10AQYvSYHcFKm4a0YEumH/U72SBenbUYWNJF2DgV1lv3yJLAES92CfcN5Sqiol8u8I8WE7d8tOFRNiX269GN8SgyN9vU6Bi9fi/lTK1LcLukZ05+NFtqBKGXCp3zqvCJaf8QniZCMj2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854968; c=relaxed/simple;
	bh=IXLUCYhCNHZgztCruzDU0ZGKFctaGuPZNEaKlMrXO4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeDxwu68OrUasmg/Ig8dnOfekHM9noBcFJzLxQpCvwJeZEMqSOCDMEuB9bT03cC4ZD0TdUl4h+ac7GbusdjciepKDLzdnhR6/WCL+KU4DXBr3+FmK6a0MPwcSfkHoqwChbBlaSqYqy8FPHm3WaR0zfJWakYDtnkCB9U7SNwG4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDDjggxm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220dc3831e3so72062845ad.0;
        Mon, 17 Feb 2025 21:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854967; x=1740459767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVlgz+q5Bkt8Btds59rDLuHiYriySzR73dW98PkMWw0=;
        b=bDDjggxm6gxwsJsnmAr/QhMrD6vkwwAhKqENNpECF9gbrpU+0xQkCrUDAhtOqQRqDk
         4DS9FcAszT/fdaDxGsandC4HjacI5S91J4JQz+cVK8GiPvFENEfb8n5QLm6QGVpogcMd
         EZVpubrAWZqNthjnUjbM1yO86nnfeL/QPllZRRW+xdaDOOLo80TBqqAmYwalaQFtIf5m
         t8m1dE5pfV75PyJ6rClntVkzCqXF3DOe3FlJpFHoW2Scsv4vZwgc8Q6De27NYnQK+Ds8
         dDO+UUXhmlYawGSK6Y+0mibFP4vJkfSTsQPsc4bjz9hgXAY3/ABv6kTiAvQSl6p88yzP
         MFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854967; x=1740459767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVlgz+q5Bkt8Btds59rDLuHiYriySzR73dW98PkMWw0=;
        b=UXzDfo8tWLsHXu/JB3A05a0K0Fs4ha/B7Q/q7wwoytjKYKmeKIU2TVhx0UKK1azbdP
         RrmplPf70Bm0GDfgAx6SVb4VfA46KujqP87vD3pqSYYIzWb0+ui8HjNUdeWc3MBqgG33
         HxsMnqtQXo7YjTlF6fbB46PSY8dNvPTmu/SLCoZq4b53ERe2WylUfi4OGpn5vVMX2LIi
         f2ctE71iMl7l51eSQWs22c091YQMwiF6vpjMSnttAp0cbOVTP6HiKkqxcecrQofXaG4D
         HSuzJ5SSDVfANr0XnRs1x81XbQ9N4zKQ7D2+DN+eFOMYIsv5/C2aDdNUbCkIht0JLzwn
         MDGw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/nsjvLG3sfBZPabYcc6M1HEsCOCU8WoYlSGfOuGEVc75SW/w/3sYEz1XT92HmI/QzPxPMk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvk2zfGkKQZkLhm4YGHv2HEYJmWy/F1IZAbjdpej/eSH/gCzUp
	C5izE3cfUDiKtM0mS3Wn2cSNSJFCTUkFyenaf2AlDDPewseivFfz
X-Gm-Gg: ASbGncs3MhGAcv0LNBYdiun6BZBMCpdtpyZMtRsJx4Ox8R2mV0+CXa7gwUjBxp9fYLt
	gzM3OBbtOBYCGYkVerWq1H943i1n9rcnbFqLZzcNg6G3aGM3wEANI+Gjs4Vh4cOVrdcG6vvl1c3
	uHGSDK00nkmxa4p0GEXdM1sFQHqzVf0bdREyOBUWC1xFB5fcNv7dSw/BHHYr49hmwh2jLWbd0DI
	XH33r3mWdUYQpZTgGGOiWOY5SNkfL/llwF44F0GyCIV/PGilwUhdiT0frejeXzdMJ/11ZRWRpXT
	RlAeCAyGEGcveUd1zTsoM0GqbwRnfmPSxJxyBIRYNrFXw8yVXGLw7LeeCzECrQU=
X-Google-Smtp-Source: AGHT+IE4gN00x+MBMbm+YHE83mUYVOOcg+U3qdaIY+3bCk3PcDqtRpXCAoNzPuL7ZZNeYnhkFnYjpQ==
X-Received: by 2002:a05:6a21:6da7:b0:1ee:47e7:7e00 with SMTP id adf61e73a8af0-1ee6c6ad940mr32536063637.13.1739854966683;
        Mon, 17 Feb 2025 21:02:46 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:46 -0800 (PST)
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
Subject: [PATCH bpf-next v12 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB callback
Date: Tue, 18 Feb 2025 13:01:20 +0800
Message-Id: <20250218050125.73676-8-kerneljasonxing@gmail.com>
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

Support sw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SW_OPT_CB. This
callback will occur at the same timestamping point as the user
space's software SCM_TSTAMP_SND. The BPF program can use it to
get the same SCM_TSTAMP_SND timestamp without modifying the
user-space application.

Based on this patch, BPF program will get the software
timestamp when the driver is ready to send the skb. In the
sebsequent patch, the hardware timestamp will be supported.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 2 +-
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/skbuff.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 52f6e033e704..76582500c5ea 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4568,7 +4568,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		skb_tstamp_tx(skb, NULL);
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 68664ececdc0..b3bd92281084 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7039,6 +7039,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0aa54d102624..03b90f04d0b0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 }
 
 static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct skb_shared_hwtstamps *hwtstamps,
 						  struct sock *sk,
 						  int tstype)
 {
@@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (hwtstamps)
+			return;
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5586,7 +5592,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
+						      sk, tstype);
 
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index eed91b7296b7..9bd1c7c77b17 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7029,6 +7029,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


