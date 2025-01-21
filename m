Return-Path: <bpf+bounces-49320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B1A175B4
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE1167C0F
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0A14D2A0;
	Tue, 21 Jan 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJxXDEtb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428542581;
	Tue, 21 Jan 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422987; cv=none; b=dtqMw7/YxUV/kBHIDhQsMcDjJGTyZXynQwOJyCTIMPOWgV+Fe4P+GDuBG/Dhk4FiZWLdHz9/RpN4gJOzRL05P266aNwaGtmzdejgsxVrCWSTzHnzDMb3vW0HbmsuBNWroVqCrQTi+/abtMrwsWtJHTOe146OxouY18MiyttEm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422987; c=relaxed/simple;
	bh=3ehC059E8P0YJsa9N9W43mW9N+qn2dsDqB3tRC+oQDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZQ4f3033xhuMp7CU+5K1j7vzP7PGMUVZAxPS+GBldwWAx99i9Taf5eXs22mYvOjtCJSsQZg5qD94fBnySrmkyy3RbJUWRTb6zNJAHnmrRcKqFHT3GbNGsMElw+cIsQ9bgSYu97VaumsKlOeg6Jg6YzpV68arQVPIa9Ufhl1Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJxXDEtb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163b0c09afso91358195ad.0;
        Mon, 20 Jan 2025 17:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422985; x=1738027785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBkByw7MJZnIZPopS1d4zywcttHBuBp3gP2jDMpGN4Q=;
        b=RJxXDEtbj2tOwt2uBfrmwsuGkVXXweAli9fOL9s/9TkcidkLBWuWjDSgFPyXC+4Di1
         4umwaLe9Ec2G8mLm5Wr+gUXFYwo1ASepsODQ8CS1RH0TWBuR5UCifomGtvlWNLSvr9tw
         rAl/AI3odNvB62UXmjKq74FtFG9viADGKaeRYifxG6pakpkYyIyJIu9FA7ycmtdTiNjQ
         0LrYGEipZZ/trViLvsZSrw5WoS/evw3TOYUIyYdUzOlrEurGU1ZZAed4G2/WL4EN6QNs
         qaGD0KNG93QJzuAgxBTPws9XPthaDEavlpzgsmz+xFUpjz2nnSoRHl8uJQV4u6KwNoO0
         0QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422985; x=1738027785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBkByw7MJZnIZPopS1d4zywcttHBuBp3gP2jDMpGN4Q=;
        b=IlIU7cnCpeuxIZSBh7OhrI1QxizbKcdLJgb5992XZ99lqa4w2GzHAQUIxCQ5M3ucyY
         RKTTaM5fjEtxBv5OwkW8MJGYXEDLBYmZqZRW8U/R4bYId2Bo8AxM+3YhScyLfhHT93LY
         YTMkC/tmDzx3ZK8yje1b5LfdKOm3TgWrJz7Zbmn/mZl3iyV6cvBPa25FbnQcyVxJzll2
         xZFJMI6BAiu+fDIYP0qwaLCJqU5Znc7WMmn/TJR9CQ5i3Sq46rVyRG/mYYNfo3lINCMJ
         bRe//5H6Die+D00tOQwDOWc59adkNcIrrO0C211u5+Dqr6xr6Aazv1cFZLlOBbpkTAS8
         grBg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kbiWuL3Yy4TfixYyGU/Z+dEaZvV97yJgYj2qldL1ZLevJWOyd0SmF1jToz7/p+lJ6Dtk7xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBkcTt6Lti73CFqfR2gGh60IP+PRG2vlF2fvbHsyO3Jo7kdvt
	+UbQmvQO82B0lSUi2k67E7yRRX9Tb+Re0IvkCsHUUSM++O5wNrma
X-Gm-Gg: ASbGncuTplBzf8O2lHQWcog0F166ayB1PMnuSzCa6AuiWWdQz2glChlaRNN0b9kr1h8
	alg3oH7eiFLlzOfdK9JneYPSb/Lpp1vNxp/f0RL9nU9xnlrzBy397oyji4HsJbFT5VbT9Gp51O5
	quZKdVD2KkGT4xXMYRRAcA7qMsx1QWUS1vn1nYenCk2xeZHdFpHOgN2sI410kpfTK8wXRzPB5nv
	oCbjT1SPIVfZd9ldWZB/+j7GDdo9v2PDu/YzKMugxVyE6xJX/2WeZaLW/lxnYq1iG2+ASuqDZpB
	KZtDuQa2Q3wFX7SvTM/jByH+g9+6Q90P
X-Google-Smtp-Source: AGHT+IGwlazqOMicQGliwYqr8XbTFYFjPdGvu1jNP+1O6OrknLC+d7A+ejynwcP0fB8mbGFey7LcWA==
X-Received: by 2002:a05:6a21:6d8a:b0:1ea:f941:8da0 with SMTP id adf61e73a8af0-1eb214e52damr22026713637.24.1737422985443;
        Mon, 20 Jan 2025 17:29:45 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:44 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 06/13] net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
Date: Tue, 21 Jan 2025 09:28:54 +0800
Message-Id: <20250121012901.87763-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 40 insertions(+), 2 deletions(-)

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
2.43.5


