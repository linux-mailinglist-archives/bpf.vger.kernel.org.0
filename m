Return-Path: <bpf+bounces-49937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B934A20679
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A03A4E8A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445231E0487;
	Tue, 28 Jan 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3u4DfsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE51DF727;
	Tue, 28 Jan 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054029; cv=none; b=T3FAvkJdtYUn7kAxe32R85LqeK4nyDLjluP06dSwupOQ0INp623Zjqi7mjvGsTEUWwjznL4bCxc2/Q+CuoI9cqK+IhvDEkJvVH7p0HhP1eioDQzjfJPQ4OITU4FPwY79E+FqH6OUtjz9GYTatiG4verT9kOBQpRT/YpnwGWES00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054029; c=relaxed/simple;
	bh=EtQXoTBugP9oThfrVJpumYlGe78MM7EKLtfwPsC3lz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukJXgVUaGHea0YDgADVb2UnXw0r+Z+wa3oJJ4tq6jHDZ4nBMYr3JXTgnkVflHb49Z+gqLXkosweHEOSPJC1McQ5ijWwrIh/d2WN5s6P5HtnoPe2Vv1JHfRPbRQNvkxLeAEBF4y6mO88gS5etFPp2gBZHVo6hEraPV/dDMk+xClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3u4DfsV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21680814d42so87552425ad.2;
        Tue, 28 Jan 2025 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054027; x=1738658827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YI7fXIJNvl0GMc/bb7iVhvTzXGdQVV12ax4M++Lb08=;
        b=j3u4DfsVrc/F+zfD309hB1iryZ5mOsBMdaXt7xyKyqXyoq63E3sCOa3M5pH1w8+pl4
         th7jGU0ckI1mBEXKqZO/ptvBAQb0cBx+MheRbmk2gfhZQQbUaj3ARC3f3cXk2rxd5iDe
         KxT6g54U33yzQd9UJSZgPiOlcki9S5Y10L7dYz/MqtgHQUi/oIoDpe5BCRNkqdmDDwe6
         A/iQObs6fUW0UUk1fzqNhN3bBaGeeGgOrlvGJhX9UEpPP4YY1A7FYsn4Q4LzaNdGJPqd
         69GEbWBb//pFBCkiNQf6Ca1hvzjjsQFkZKeg0C3dDHn5yV4ZGupeKBdgxGVaAXGzoIyg
         H9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054027; x=1738658827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YI7fXIJNvl0GMc/bb7iVhvTzXGdQVV12ax4M++Lb08=;
        b=bXqT+kz/AfjvUuPI2CVKIwENBsZa8hyYlTMmYC+LpwGPbA40uv+RO7QiKUl8/UOJzI
         SucX2rnJAMb+5io0+Srx2dy5XHF88HQhg6KqR5Rhep8VRNUaPZgDerkyHZNTNlEa84Wb
         qydaqKPFRafwEGshOHu12vIPLHvM7TyBbJSCMS8oPEziBkZ71Ya0NcASCpX+FgLTyQFr
         MzwkcIo8M5X6lmeQnup+hj0Kw4rfq35KZw6iNyaeVYnJBS5kXeyEuJZPpBhmslwno4QP
         Ce6jc8CzWV9GNMNsgOb+W1uZShFQfX5xvDxzS0IWIx94N76u01lQfuK/QAJ9WPhJDww0
         9wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo/i8sh70MWRdUQEuU+I8zOoE6B8Q8k2hniLNRwykInkFugBRwtwdXD0yk154Qan1Fl9Us8bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuithX9/oh8+ELpoaKCdEMedhjA3p10B/RR7Eh+TU7YiRQLJp
	v5fK4wAzzMXGnKHjaKkvqWNpez8XuZJzuZ83EN3w/OtOGMlaws8b
X-Gm-Gg: ASbGnctvkyDYRuF9LPg66RXULPluE0CAnaqjz+mxhNZJVQkdwHjM8GL8eqcxpwvp8+J
	04sUrfuqDzlJ6eQgjbKqdLeFyCJsDCHeb04KB30NXOEpeWFIxq4j7C+iFhXdBbpGbo/r0bbokLt
	wbS5CzcpLyPJEpxwy9oHFaZAx/6n9bR0H/P9GxeCPCxQae6kriypMKxfekf8CJzUa9xQenjQkH3
	cU6iWVJWSoDeNqgX+2uunJON96iuXHaDCcAJCmSuuI7RwZEgcz+1hSwYFNStkO5x5RIGY/dCxH0
	fbTYJ7GWGS4mU8a9bKBTMu6HROlgmk9634w3+r5ceXj+Ysnl1jhxFg==
X-Google-Smtp-Source: AGHT+IFrmdHW539M3buebpADp0DPSeyoOL/nbvGJLY38UFxJG53G/Yy0LsEltUEYFozcxbJylkQEYw==
X-Received: by 2002:a17:902:cf0e:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21c356093bcmr687653195ad.46.1738054027618;
        Tue, 28 Jan 2025 00:47:07 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:07 -0800 (PST)
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
Subject: [PATCH bpf-next v7 06/13] net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
Date: Tue, 28 Jan 2025 16:46:13 +0800
Message-Id: <20250128084620.57547-7-kerneljasonxing@gmail.com>
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

Introducing SKBTX_BPF is used as an indicator telling us whether
the skb should be traced by the bpf prog.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dfc419281cc9..35c2e864dd4b 100644
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
+				 SKBTX_SCHED_TSTAMP | \
+				 SKBTX_BPF)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
 				 SKBTX_HW_TSTAMP_USE_CYCLES | \
 				 SKBTX_ANY_SW_TSTAMP)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6116eb3d1515..30d2c078966b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7032,6 +7032,10 @@ enum {
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
index d77b8389753e..4f291459d6b1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+	if (unlikely(skb_shinfo(skb)->tx_flags &
+		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6042961dfc02..d19d577b996f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5564,6 +5564,24 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 	return false;
 }
 
+static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
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
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5576,6 +5594,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	/* bpf extension feature entry */
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype);
+
+	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
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


