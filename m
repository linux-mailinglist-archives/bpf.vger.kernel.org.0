Return-Path: <bpf+bounces-46355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5C9E814C
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F97281629
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B314E2E2;
	Sat,  7 Dec 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYoxA+id"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488214A629;
	Sat,  7 Dec 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593118; cv=none; b=PgKLnY+b3Ub5mVd6eEM8Yry9/mglPz08vW1Cg4BzXGblRujzcp2XvmbdjAhzu2a8gPO6Ko1xTEdlKzhI+5KyXpbcwc/HeOaxiTp/xu5o6G345WN9PJ3D6hdIq11Z3AbyQquqlnMNXhdp+ZHzOHvD6kZS1tLc2RjrsOErM5/dUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593118; c=relaxed/simple;
	bh=XZ9yhdLBkOOATrEjuka/l5gpBfnbcttnXOiVkwd6S44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVmKpmfu/1ob1oIozfI/jAjlVwCEsonA1SqwgMzHQpn4f+filbz5sdSXRY0DG2yotGUs/vSvGWdlYAqe9DD/RLZGz7E1E0Me1Vm06+dY/fTJc8PpYFfCyYDNJyBl9es9arZ62qiyMsV9x/0wbzuudQCjAXLcl8DLLdRW3I64T1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYoxA+id; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef748105deso1200325a91.1;
        Sat, 07 Dec 2024 09:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593116; x=1734197916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tH1jrNLWzUMNeOqq1mufm7OO/Hdzdumd/JJob+n7dw=;
        b=IYoxA+idUsXj5ZKTItihpLjVN6W32WlPIv4EdqafChiNzThcluPF+4y/Fhl3IQsl4C
         Y/yiKhPSg8cbjZsWch+ZEWxtmUYLGJ0O5pSr75WzlrnabqPCusUhcmEnXbwtLlqhQNLP
         SvhXUIi0F4Wp1bfaO/jMAmrKyubtmMTzc/u+cwUJERoyEUWl2dhG/xiU21J8+IhsFMU0
         3Gl/0J76pncrLi1BFY7vukwUMc6m9YOyffNVqaOw6RVyVq23s0/+x0wZ3fPXUCO3/fm7
         nmKcMhRm19LcHTaXigPn5OXvDR2yQinW/FR1pVqCprrai+5qzOV6aj2NSP8dkv6bWoN+
         OLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593116; x=1734197916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tH1jrNLWzUMNeOqq1mufm7OO/Hdzdumd/JJob+n7dw=;
        b=N6kwt59RXlVNNI5LwE2Of6xhWCRi2VAc3OYCcCDMhrqGcnfnR6FPy6mCQw+WbXJ8fo
         vruhYJS7iXv1WxBgiwa5xoTYV/9cJ38TN7eBa9s56KAwB09MUS2xethnH2jm/nNfVNhD
         VFf5Ie1r/7NqUZNQ9nG0i+RL9lycwj/zrbgSlNXTxsSVCi7hDD8oLIeZXhmukxACp2na
         ctKJRQwKAn1aujiQZPqi8zBYwjU9OyzlBvFcBKpFSHOhZcYnGlGO++6mslu0AmotYlzZ
         C3aH1b8ryIuUY3x7NuRs3JpVonTnpt3B73aFGHBKBcWveB49V6MvmgkHcav57Hg3wFjj
         5l8A==
X-Forwarded-Encrypted: i=1; AJvYcCXiQ/y5BbGeNnB9DeNAKXsaFJTPqDttT+2UeWDKhiaMBzsSanwZwTIlUvWfoneDpYyOIewzWeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaugSPqQ3I0YbpApDVyAPGoJvKnDLwkIgJHocdcpo0StBxBYum
	gDJhudhLRRqb7ph93ZBOCpcf3EH+RyL2BvLF6WSxhZy0lSbrgvIS
X-Gm-Gg: ASbGncuS7aRaYke3lTkSM8vbCQt/Q75l7yqkeN+isc4H3KEYpOUwu/RqdVMh3/v014F
	AWLgimLO3NrONEIFoCmT2IgBVsGCtPCbpk4OslVpvjYANwI4mpq0tIf7gei8N7YdI7/JvXquMz1
	EU9GxCqHeS8ZobXSBkjTC6rG5trwtLdoa431qPJSo17zFtGyE/GPlfld0AK6sStYvuDmPyWbYDP
	fBH/1px3Qdcwtmbhc1SndasUv1P6330pNYzqc0C2kqXcfAXceMVH/MeQj93OeCzJgEnnHoNKqNe
	9B3ewvZkDin5
X-Google-Smtp-Source: AGHT+IGA8WD10pHGH5MzJfIUiWSdLRH1sHN+5pv8NRsolB/JBkuHc4dDbbM1ZZ37fgmGi3fwl1GroQ==
X-Received: by 2002:a17:90b:3f4d:b0:2ee:b6c5:1de7 with SMTP id 98e67ed59e1d1-2ef69560129mr9329302a91.2.1733593115820;
        Sat, 07 Dec 2024 09:38:35 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:35 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 04/11] net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
Date: Sun,  8 Dec 2024 01:37:56 +0800
Message-Id: <20241207173803.90744-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing SKBTX_BPF is used as an indicator telling us whether
the skb should be traced by the bpf prog.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 29 ++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 53c6913560e4..af22c8326ca5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -490,10 +490,14 @@ enum {
 
 	/* generate software time stamp when entering packet scheduling */
 	SKBTX_SCHED_TSTAMP = 1 << 6,
+
+	/* used for bpf extension when a bpf program is loaded */
+	SKBTX_BPF = 1 << 7,
 };
 
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
-				 SKBTX_SCHED_TSTAMP)
+				 SKBTX_SCHED_TSTAMP	| \
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
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74b840ffaf94..fd4f06b88a2e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,24 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype)
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
 static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 				 const struct sk_buff *ack_skb,
 				 struct skb_shared_hwtstamps *hwtstamps,
@@ -5595,11 +5613,14 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
-static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype)
+static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype, bool bpf_mode)
 {
+	int flag;
+
 	switch (tstype) {
 	case SCM_TSTAMP_SCHED:
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+		flag = bpf_mode ? SKBTX_BPF : SKBTX_SCHED_TSTAMP;
+		if (unlikely(skb_shinfo(skb)->tx_flags & flag))
 			return true;
 		return false;
 	case SCM_TSTAMP_SND:
@@ -5620,8 +5641,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
 		     struct sock *sk, int tstype)
 {
-	if (unlikely(skb_tstamp_is_set(orig_skb, tstype)))
+	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, false)))
 		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
+	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
+		__skb_tstamp_tx_bpf(sk, orig_skb, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
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
2.37.3


