Return-Path: <bpf+bounces-46356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC19E8150
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CD1281DDC
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAB14A619;
	Sat,  7 Dec 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfbLhUMt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01E14A4DE;
	Sat,  7 Dec 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593125; cv=none; b=Q6zfAFNsjFDHfm0COQlzMITRounC28vMdO1UAmayIrVDBx0JZMC/JPnSpAW94lXLbYqu8bTnFhj2oL1LVWQSFyy4sGelRoVa1AXHMeOOMeAdDTfw0BCGHvi3A9zMs9qTCvt7fVErkoyGgVP+DG8Up8/g6xNaCQCz7ZHSFbqve9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593125; c=relaxed/simple;
	bh=ftYAVh9rmioZceajdTV7/uaNHZekMWSTkdkM41Id7eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOYa7b4fHCXR3AkCGRoBZ8huye0ploesi8vzHJAi63CWH7ZBN6MlPV6NYyEjf7Hpk0Ybb4Ws1KB9jBzNfqOus/ZZ9xGNZtsqVtGFZLAWIRI+Mxkzh5d4rIQm3edP6+b1J4UQasb8/2cxRsgZZYJ3xeVBQFa2Ca5uCSEE6MaQkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfbLhUMt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso450866a91.1;
        Sat, 07 Dec 2024 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593123; x=1734197923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKoy6iqJ49BYWGFo2qh7d6f3PIHUmFuFD1/KnEgMqak=;
        b=KfbLhUMt7WpMWGAHDuRsEMkkpOb0FIu1m0poQKf7ZB093xNio7Xyc0oWcev/B5S12U
         kMdo1S0o+mRN1r/qX5fcvB9qSpyetfP9J7e12w+q21K8inyKWl8PhPxtf8fLefOg3FQr
         zn8ZKH6p2dpI8RXtBj+fXJ9fcWll4fBcfIBbe3kFmrI4y3pdAp4J4oKKMU/DEEXap7Yg
         tvHLvD8WSny0HNnLXVSTBfJJjylsiZQBELHz97201IoatUtYBXnesGXV2sSthQ10OhHn
         e6G8U6nk4zYBWaOa8/LGWdtLI0EtrsciQgjXq0XkGxMgoIlJrzrY2sPNSxvL2TuA/tVy
         XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593123; x=1734197923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKoy6iqJ49BYWGFo2qh7d6f3PIHUmFuFD1/KnEgMqak=;
        b=IefpL2FlMIOYtUdu8XnPH785ZiDoU54JNSYC4Tb6ed28o0eNvgDmgfeJz05VAVzOsn
         kXnKHw4B46C9EBV8VJWX/UmjfocTVfYEe3brLhnYisTRNvajfjQEZe/4P5IW9SfvEV8u
         1Pa9e4cwyP2nogr03H3ASTucGgqHzVGTMLqz5li5y/l0CmORTCoRSXK4OOLE7bgv+Dlp
         H7WguQUvx94GZUazKcH3j7Lh8EBAKH4coYD9N2wfKELjKP7XU+mnhQ3Xn/N+pmcF5QgC
         tWzuHg1lhzHRjVnJi13jtVc2FL6dKiJJR8IKPDlVN91rKzAF7hvHng4ZJpREZifNE/G2
         ngLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSbz4o6/0bx8wAZUXtzf4E50OApJ67uTR3mlfeqX64Nes3JU3bT3YcKQJapYaS2nILpvPwkZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5qs/lk7SNMGKXK8wb6YIU1jshEXWbSxa8/8EJsYTuRtJyER3
	Pwt6q0E3BKJxy7elh7lRkKmWCMrr5gN1iCavT7bPMt8h9ak7bAUr
X-Gm-Gg: ASbGncvNg1b+ix914wHfY41egigtUKlH+wtazUPUq+OXaP/aWxqvB+91Q1rP14O0oRJ
	+6zksZj9PrIWD9CdzJj+zdUi62oq/gIJ7Bq1K4ZU18mUq/AmZuS1Atd/Wv88SPUBA+5qD+or0B0
	gB9jr0lav4qLpZGZ0M72mObK2cepmrtGUfqVRYKjFeexstIkba3QjutNF4X+6k9d61LG0O6ddM4
	VhlWh5cyHZKkNEgHxhen4wo4oxpZ/hSFGTs7/KdaeSeRaMebuggCnauiXEIGEjef+jJXaQLab2L
	hiUC1b8MOJg2
X-Google-Smtp-Source: AGHT+IG/694wLbZRrE0evVDcGzE9R7lTEIzOAjywzuHOhAJhoIU9IdRq+eXI+sF70VFr66uGb0F6DQ==
X-Received: by 2002:a17:90b:2fc3:b0:2ee:ab29:1a65 with SMTP id 98e67ed59e1d1-2ef69559aebmr10931365a91.4.1733593121377;
        Sat, 07 Dec 2024 09:38:41 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:40 -0800 (PST)
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
Subject: [PATCH net-next v4 05/11] net-timestamp: support SCM_TSTAMP_SND for bpf extension
Date: Sun,  8 Dec 2024 01:37:57 +0800
Message-Id: <20241207173803.90744-6-kerneljasonxing@gmail.com>
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

Support SCM_TSTAMP_SND case. Then we will get the timestamp
when the driver is about to send the skb.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 13 ++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 72f93c6e45c1..a6d761f07f67 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7027,6 +7027,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fd4f06b88a2e..73b15d6277f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5550,6 +5550,9 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5624,7 +5627,8 @@ static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype, bool bpf_mo
 			return true;
 		return false;
 	case SCM_TSTAMP_SND:
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP))
+		flag = bpf_mode ? SKBTX_BPF : SKBTX_SW_TSTAMP;
+		if (unlikely(skb_shinfo(skb)->tx_flags & flag))
 			return true;
 		return false;
 	case SCM_TSTAMP_ACK:
@@ -5651,8 +5655,11 @@ EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps)
 {
-	return skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk,
-				    SCM_TSTAMP_SND);
+	int tstype = SCM_TSTAMP_SND;
+
+	skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk, tstype);
+	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
+		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, tstype);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 891217ab6d2d..73fc0a95c9ca 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7020,6 +7020,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


