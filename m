Return-Path: <bpf+bounces-51214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513AA31E96
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A203168122
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469F1FBEB1;
	Wed, 12 Feb 2025 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDopRKkn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84F1FBC99;
	Wed, 12 Feb 2025 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341186; cv=none; b=tfYXphhXrY1lm2Zy+oOPgpgW4LvZa6ej1HHvOrk0DYI7BoF4ah6gX0hSHqH0ay/NUiFAXa+9AMVXilJxcVaf45wfNM2tOeaBq9b+dNW8GaZ9vdNkWVVp/lTtSNb7ihuzH5d3s7+J/+q5y4U26YxJ2m533LvIenQeNmTjoQA/SdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341186; c=relaxed/simple;
	bh=ovfCd741KvrnSNfSgIxzbK8xJDcuXA5SHCeaHNA948E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2YNNyBEB0jWC72SZ00Ess6shKRcTrMmLU4Dt8OVMkbRKQFSQVypw6j98gEoEKCeBAynbmyb/MPSynH5HuX+btoUjkO23yDd263jeLWG6IJQPdpcrfSpqZITIsxWz44wP7/J4RT/KB9uXKRHyp+PR6e+DuZbDS5YL7AfxQE3tVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDopRKkn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso776594a91.1;
        Tue, 11 Feb 2025 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341184; x=1739945984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqIXI5YQpipEn3c4k1sFCYTGXO6fINcSXi0hMaJlDlI=;
        b=KDopRKknu5czJLPOrtl46yCUt+bn1TDQHqmBB/SxyO9/r2aX4rTaBQ9pMNOrr+PMiQ
         BdiVM6jBYD+/B009UNkaEgP8cyGgH5s2AWZylY4zjt52wzjA9u0M+y/++iJKmzoXtEry
         FWuyAheFWOp10sVXLuFqKG5t10v4mMGvle/KWYa5dKCe+BalJE3iaTkiZbKwr/nkAqTY
         sMypulWSmiwVcKDn+vkATQX8ioRFJ7iPvzX4P8CS3fCOelf1ZKF6tBUAvs0m6UUnZdjS
         AYsIBfJueM//QtT/dE0eSNNU1qPONzBccjRVhKv7QdxQNv5Q6bxKbPHrE9Cr2m/VIq4K
         Jc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341184; x=1739945984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqIXI5YQpipEn3c4k1sFCYTGXO6fINcSXi0hMaJlDlI=;
        b=LcxM/YTaMAmeXGUg3wB7u6qHMQ+7ubEVW+p63OaqceLCWFrdeCynyZvWIm7ZrYbc9n
         QfXhunrQRPAEYWFRRu/XWKumrEcjVujUgZuvbReCUqQhwSQs5kMdDXNSpD3dbwPwmZXq
         BtrWwkBJPhhpyl18wkajzn+2Y9qcTGVTsFoE/4OEymmun/DzQ8Oyp76OketajUmgfH2k
         e6DszektiqRRw40cqVi4no6wmO1eE4pEgPHQ+LP63Wl5wI2TngQxjvJlgMvLQga8ETTW
         ++N5WD1BKeWm3F2WzlPopjP0HzbKViS3vfCUL9PCEYfGVkoO1UqgxLlt25Mk5ghqtr4w
         LofQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAelcAzrW2TKLLvdJUcrCPdzuXezWx3yElcRBeod9ctRGhdASy4Itzi95HYQ5i7bdDe+oISvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDcWZV4A0IUS2ckLR8tuRWPIQFzKdc/bxkY1+j/CeJHgHFbzF
	7lARlzyY88Fg/pM7lPt9+ppxHIQEQrbVR0IW9zo+5OTTS7GjWIX0
X-Gm-Gg: ASbGncta798pr0Kray5kjRIlD1I0W1deGqwOfpBZ7jPLBCH5wOUgPInIvvtaI4jm1Uf
	iyh2S/C6Ipo5NGUjxQDFdSRhriiJjBClHZlmHF/QESsRqNFsdvNdmgPA38HaPrHMutCqmsiMW/Z
	5KJQfQRc05kzaLPOSiqmyOpkg7XvVQ0zMmJo5KgV0BQ8Uj3weCRNRIW5sQsOgG8ORUyATY/6wcw
	uH9FKkBTxdFgdbIPkzosWYIF642nW6sudLxFgYJihjVIkxx9yBgd8vTFjPKJZE6NTE2GxAJtRFq
	DXH2Y0yAV6XV7EN8KalvWN+GjzvargwTGrAqMN9j+dMTp+rWNu8LQg1nTtiTDIo=
X-Google-Smtp-Source: AGHT+IGoVUpbeMR4IGDwrOfW6SbYShXSHbf3e7X2Kh68vlnb3okmIO/uXTguK5tsibRnJCfluLSAbw==
X-Received: by 2002:a17:90a:d88c:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2fbf5be094amr3118779a91.3.1739341184263;
        Tue, 11 Feb 2025 22:19:44 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:43 -0800 (PST)
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
Subject: [PATCH bpf-next v10 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB callback
Date: Wed, 12 Feb 2025 14:18:50 +0800
Message-Id: <20250212061855.71154-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
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
index 7bac5e950e3d..d80d2137692f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 }
 
 static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct skb_shared_hwtstamps *hwts,
 						  struct sock *sk,
 						  int tstype)
 {
@@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (hwts)
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


