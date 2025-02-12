Return-Path: <bpf+bounces-51213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9025A31E95
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F85188C18A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC71FBE9C;
	Wed, 12 Feb 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M487hFMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557881FBC99;
	Wed, 12 Feb 2025 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341180; cv=none; b=dmo4CN/OtZ5Ej5qWGAT1t1kImpyy3FyJdfvREC1aXpaVlQqTf228mgRpLO3ql/hfkToDdMvyQyITu7A1JJno6eCBR5GzIDAW2ctscXMZIGYPdaw7X8V7zE06K+stRsCXuizc7uzr0JCdZEZw8dCdt7INb6Vsfo7fsSIR5phPkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341180; c=relaxed/simple;
	bh=1/K+YFup1V5WdkZzpqow9Jdjw+Gvuw0FeItJAsEYmvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCYMnYPjWrAipd1BOp5HuPn2pRoS1NYgmeFST47cCNYksJlFm94O5MtoKPRqjHVOyTcoEro0zsXEpQCPRNNkvPqNEvgCDXiFON8MUxAOcRZGwAtDqZJH8Y7/9e5E1XcetCiU3/7C4pWW+gbEhWt6qGJ9Ho4j/gD69xgfrxsvcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M487hFMH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220bfdfb3f4so6358115ad.2;
        Tue, 11 Feb 2025 22:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341178; x=1739945978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvdRa4IFahM5QYZdycPU2SyfihA+7wdfNVxVqE8pm0c=;
        b=M487hFMHa6S0Mj/61Axew6RxohVZAYA0AsYU+a0crqzhvAHZsJtkMnAJNMNItRAijl
         KhkWRcUhcszeGXr5JYDzRtxfhQPH8RKhIclwcXdQ1BURpLoJwacOfUnCznRH4uVepWmi
         Iwc1GbcjMp+fjgk1KyyoJOJ6SyszrOdspaPUw4anFNcutxI2I1HFOsI16jDvR4kqks5Z
         Ow7Ueve7RjKhPAWgZxtUe+CgMACs76fXfQpSDo8HSargEv8yRKhlaZDmzmWPyLeHIv9P
         aFUTDHfIoX9rz0sFwBW/dns0GDHlAToTkuPQ9vSN7gedFDVu0Onv83tJK2uHyM+HPnaM
         jwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341178; x=1739945978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvdRa4IFahM5QYZdycPU2SyfihA+7wdfNVxVqE8pm0c=;
        b=l5hRuz0yFm19lgn7jWBTjLewRD/TiFL+hU88Qpgu4eDwTdGS+QDiX37Zmy3OSc0y+A
         PXoXUDaN6X9qH/Fwbr5YIcVZJmXc3CYLe5rdBa0xlrqD0I9MxtA4uIoo5Q1skS5DrnWA
         M56JYKX8lph1YCgSo0c6RmrZjFIlrB+z77rAGVoeKQzD6TGTKZ57mlRnuO2Rew0zbknM
         PUnWJMeD1fViwIKNjleT7gzKniIJmHuLNXo7bFE2bqmELaju0Ct/Xse4sNjSQubM24HW
         Xf/yvSR1cg0rhXHjJxUbet8Px261DXP5r8xlOVPCfDnizpx4SUOD69h/LoVv83Pzulnf
         hvLw==
X-Forwarded-Encrypted: i=1; AJvYcCX3xuo08jkk4UoDjSbvYBW8boeFN6RKjKJicnz5+o4ByiLr7jIGUx/5HRG013d6JyX7dhI+AGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qxaVPlDUHhqYBEy459K7asPkfQGaksyfyQdoHnQJm2IFPkYo
	Dq5xJBYIYVJWqeQ05lYXIVjXoZEL0YPu+DE8hLpadfQm9T6QVPHk
X-Gm-Gg: ASbGnctLrTBuxTcxqhfK10FNOGu6eje6m2yRYTtEyKcpd241ifbRjpGIwbOFPjXNmWZ
	1Haip8Z+OepTcNPozo+kPR5/gTdXJ2yE/rOWQc/nmxx32/8N9UhGNtVdmu4vqCUWE1Mwn+atcg0
	Sz+kw0f7um178PhdWuLc1G1DVx6wHd4VMfUmV7QzM8t7W0VnfLCbeFMCFkLJNjSgVpj0l2OSb27
	5kySGFcqsIhJlAQnUvWBSJn6oB1S7Bj53qYdXp8EXJN9SERiDi0I3IIOfnttufc8RxCzPOdnQQP
	iBplz46Lv08cIrxwfWwi+z9134gLRIjA/qn3VcyvJPrEASXM+5y+RcEXVV54w0U=
X-Google-Smtp-Source: AGHT+IEKZDKkeiH4f9ybJK0MQTf0D7EpX6r57RrPCvBKVZ5fzexvBI9GTn9PNQHD9VvCOSwtPcz3fA==
X-Received: by 2002:a17:902:cf07:b0:216:4853:4c0b with SMTP id d9443c01a7336-220bbc5a223mr34907525ad.33.1739341178522;
        Tue, 11 Feb 2025 22:19:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:38 -0800 (PST)
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
Subject: [PATCH bpf-next v10 06/12] bpf: add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback
Date: Wed, 12 Feb 2025 14:18:49 +0800
Message-Id: <20250212061855.71154-7-kerneljasonxing@gmail.com>
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

Support SCM_TSTAMP_SCHED case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_SCHED. The BPF program can use it to get the
same SCM_TSTAMP_SCHED timestamp without modifying the user-space
application.

A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags,
ensuring that the new BPF timestamping and the current user
space's SO_TIMESTAMPING do not interfere with each other.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 35 insertions(+), 2 deletions(-)

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
index fa666d51dffe..68664ececdc0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7035,6 +7035,10 @@ enum {
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
index cd742dcad052..7bac5e950e3d 100644
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
@@ -5568,6 +5585,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
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


