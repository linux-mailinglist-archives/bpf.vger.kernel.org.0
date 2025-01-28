Return-Path: <bpf+bounces-49938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE2A2067B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E4716161A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F51E0DEA;
	Tue, 28 Jan 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc2hJWS9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4D1DED67;
	Tue, 28 Jan 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054035; cv=none; b=FkqyFDpTKMU8YCmGbmHbuiS6/krulnr+XVWGwp2tJE4lSfXcyhnHVZHkjzJAWoRBw1Paw9o1jVzgJOt0nA/JtxawS0zIEWs9r0TYCGo3yD8m8+p5VE7q7EhhDgWfwQ9cdcCHcK0pBH4HonNdCZRzPZJ4zmKH8/VTYJDUb0P1iR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054035; c=relaxed/simple;
	bh=yq4u9sCpQJpiQpcF2aG5NYY4OkdQ+GiMFtfVSCms1oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Scy4N7lOjbexsFh10lBlRvi46alD/q2Majn0CUKv+3x839gekCjSqi/tet+9YlnJaJzgW7uBTwu/gsECxRQplzRILNMqCILXiRf0rgv6Py6hTrx2njkHrE4bEdrd+bf1kZWSm7lSSdn3SB7QfuNRzMb/Y53vNE/EKhYbntEXmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc2hJWS9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so117386305ad.2;
        Tue, 28 Jan 2025 00:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054033; x=1738658833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIucsfFknM8P1g1XyuwxrXdMWrf/7m2l5cECZ0rTqwI=;
        b=Dc2hJWS9ElsJ7CXhPq1lz2m58REjXfoWwHSFakpEyl6n1dcSLo9PgzZUpHFxq0hqrD
         mNw/zSKca6KR6ohF5QmlIGHEuzuQV6+2yiKQYe+ZC8FsssCVCqpLGdf0IKdrB0OW1p6U
         Q7PW6qhc/aq2zXZbdj3amdCMNYYvepdV+hKeunm5SEOgZJUMGLrBntw9baX3y22Rlxfi
         laf7Z8hs2dFXt954WCTvdDIe23G0ih5ws3T/kDXeakRcYkhORJGIHq+a1BZFDQMbW2hC
         RYlusrME61hkiazZgT/6rn7cZjIQY7doiENFafJc8bZh2KRXeJqHzCthiC5yYMiIrL1v
         SNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054033; x=1738658833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIucsfFknM8P1g1XyuwxrXdMWrf/7m2l5cECZ0rTqwI=;
        b=uIw7q2RZELik4iFEWBZ5PzPDkNfNj7G9BQU6YFQS84fy1axt+Q9zGr6Q7iR+2GRat4
         hcD8CkdQVX2MUS0bdrvD9/P8yCp7uliOO5gU2nuab3DWRxKsjBcOp4z3F7wcJeU6lQRS
         cRecJtsIseN6AJHhrLbrTlc3mE64iJbdbsTHvsXh/eJUHMBo6EKWzs8MO+Ai2I2dmJd9
         KZFncRIbQkTRA3CBMI8+U5io/B510sNU7QMuAWKbbzTgcT31D6ZZX/ncSYmCztm6eRL5
         8YvHh6+r7Lpuj+JwnEumu5KooFVs0Oz+edhR0cApOFvoB90j4K9cR94aSsrjZg5sA7ZH
         /lYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz5svMufcZVkaI0aImT+KG7ZhIHwjMiWpOMG3nnv43qgVFD1bSkouwCeR5uC4YI2HAzdcWXXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oai1b8gjOKLIaeVDzFXJliaVVdlZodI1zq77iFuOgIPUFR2z
	5JFe+0+m6nBmag3xSTM442ASsqu1hp1MC57pRkw4nNshFFV7+QxR
X-Gm-Gg: ASbGncvn+4FjhlQWCmwwDjRwH5V0Hz9JXW62C+cyq/oAaQbuC+bxcP/H1ul7prKrEx0
	nIsyX8Tg4Wzc/VK59kwbjXvF/kO8jHcwmisXLvoNaOWGq738xXbQvXdMBT+n6T0jPbrroGR6cXn
	mD0dlwVC00uyAnC0t7EB93gvPV2FO/sySD/Gd/9qpNTTyecesv/X5XOmYp6GGQc6PUJL1HF8hOr
	F65iTvpq6Vs8C19K9PLI0aHoVbuRcH0Hdnavvu/c5o/zK3hiUmzKi3b0OxK0LeKrFA9SfQMGiS3
	zgyHKz/n4w8E0DWwKwndDcJydDo5NsG5vE9cdG9xav0YDSI/Nbd7Dg==
X-Google-Smtp-Source: AGHT+IGqkybKjdMNj4H4r8LackhtuAO/uVSjScfRAJQkPM2hqjJAVMMhpdC/eeEbV4v/sPMRAC8OcA==
X-Received: by 2002:a17:902:e74a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21c35618995mr732278255ad.53.1738054032787;
        Tue, 28 Jan 2025 00:47:12 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:12 -0800 (PST)
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
Subject: [PATCH bpf-next v7 07/13] net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
Date: Tue, 28 Jan 2025 16:46:14 +0800
Message-Id: <20250128084620.57547-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_SND case. Then we will get the software
timestamp when the driver is about to send the skb. Later, I
will support the hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  2 +-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/skbuff.c              | 10 ++++++++--
 tools/include/uapi/linux/bpf.h |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 35c2e864dd4b..de8d3bd311f5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4569,7 +4569,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 30d2c078966b..6a1083bcf779 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7036,6 +7036,10 @@ enum {
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
index d19d577b996f..288eb9869827 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5564,7 +5564,8 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 	return false;
 }
 
-static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
+static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
+			      int tstype, bool sw)
 {
 	int op;
 
@@ -5575,6 +5576,11 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (!sw)
+			return;
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5596,7 +5602,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	/* bpf extension feature entry */
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_bpf(orig_skb, sk, tstype);
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
 
 	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
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


