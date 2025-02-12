Return-Path: <bpf+bounces-51216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD7A31E9B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D92F188C4C1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699EF1FCD00;
	Wed, 12 Feb 2025 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTinfbBy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B51FBCAF;
	Wed, 12 Feb 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341198; cv=none; b=D6VRU6/fGMNHXglK9ByJUsdlUiPbEvDR+MZyecghqGctovt7kPxO8kWd/LvmtbZXA6C0S+uJbPOxBHYxPNOvg0Z+h2jNMrwvkJc8Ou8kKN2M8PHHHTw/9hxnlWl3XKalCeZAh+b8+anKaODPNj+TPOoe+MJb9FY+ehxKi+A3jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341198; c=relaxed/simple;
	bh=++XxUsoe9c8vRRs7lQV47NTRLNQXnM6dnLPnqu3awYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLn8O0SXXv/fRebzwzqq5mwWc4AO6rzyiFK9bfj56y1mMM61T5EGGnbNsn+WwmziPADC46oZ6UEXLDwygYEF50Jd6voXDhkRAH4o2ciyNwZvD0jJ6tx8oLSn+JeeXjllV9DploL2P7hiRD5LoXp3xltAb6kXHbdNrkNZ0jWEHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTinfbBy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso154592685ad.0;
        Tue, 11 Feb 2025 22:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341196; x=1739945996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/7d7ZielQNW/e0NOiBavq3xBFMDYCSH3FuhIzXwLwQ=;
        b=dTinfbBy6ZUivH1dfF8pY1HOd93JyqV+eiOfca3z2MOM7b0NLgsI2NKiYZ/jVaKlCY
         AZIiqhfW6kJGqmCDSxkNzQwZWgcAY7FsfkFaDch6PtQNUHhNvqu0O9C2zw/A1FkqH3yU
         bdVshTB6/WmNyPuUbXpIyKgZZRQaY8WqYyGn0zPdhGmVxjr+DB3gq60yBaTCtK0qMlL5
         7nTeVKu0AwPGUyyixjTKgSzisYdsDXzNfPPXxczlb+8dFOCaC1N2UHr+xMSGlN98viz/
         XeqBVeyAyn5Z90MadutMWeS/slZGZ89vsyBKLzZOKyEQms43xnOezPMZ3CCWSIwTbFO1
         XsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341196; x=1739945996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/7d7ZielQNW/e0NOiBavq3xBFMDYCSH3FuhIzXwLwQ=;
        b=bpPj7uC6o7rLkDvbxx107CAodaa2kPvpAFVpOsYTE80hn+4gUxoiRo/xK6P0kbZM2S
         25G6LsorcZP/6YhZ2GabWGUMKN/KuW1bhCymXvcMzo1HHKEkSnDN+Vi6P4KaFvP1icxZ
         bypxLg91vNlvziTCaxQEmZy6hZyeenCxhtHGIsY2a46RHGiEpOWmFUUq4Pxeg2bOhq+g
         oBaBJiRq6C8ia+ep0AdkMs7tomLjOgpBVw9Efmn/3rjlXVEYitWDXrgkWX+Mky6BN1xx
         SRpMISTO+iFIFpSsVvswH32TDs2Y/BruBRroVTu4nmWeLaPStdGUcyyhUkOg4xVJWIrR
         eZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUFPDY5jRGEsRa0VBlVT3nd2CW6ERfTYBPL9uAeJMFeMs3Y1q7r2wtF6wPo0aWyQ8QWADJtMUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySg30OEptBlelizogE3ZS47Pd/KmAlNJV4I5ieW6epUTw8X+XI
	b/3ufKNQM/0aYQLkAeg/GOp2fF1egKhUSLogK+j09+1ByK7dtqxw
X-Gm-Gg: ASbGncsCawWqsTHC3QBwVEsstcSEYsg3Oc8/7j2vStMIxo2GqHjsh+OqWGsnfavhlKI
	9xOg9h6mOChIkA3QJgLW+MjmofvpWY7M/a15tDuuMTc34Hk5r/1WCBj9ioD05TVDNu8vmWr45fo
	efMsr0ItfFnUiwfkBHuosq9QFgtnxEawBXxlIV9qqxk8N5Y10kkGPdDYoI3dSnQEOFjLHSZE1qP
	DCZRPiTEdO3J8pkirTnWGrME639kdv9IrI6lure/LFwOG8TfT07aoUUradrjavWXjt2uM1kw701
	vPMX/P5upHQ6P6ym3bslITf06dd7aJiHfncKbt++AywiQtVxCfHu2RetL1ts50E=
X-Google-Smtp-Source: AGHT+IFyUUOv5+HAt9h5c+Rijk00+2eYrlfqTwWJuJ/bhHpNNshkob/jCBZ2I59cX5E9ulHskMKDlA==
X-Received: by 2002:a17:902:d481:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-220bbb0fccbmr35237825ad.26.1739341195673;
        Tue, 11 Feb 2025 22:19:55 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:55 -0800 (PST)
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
Subject: [PATCH bpf-next v10 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
Date: Wed, 12 Feb 2025 14:18:52 +0800
Message-Id: <20250212061855.71154-10-kerneljasonxing@gmail.com>
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

Support the ACK case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_ACK. The BPF program can use it to get the
same SCM_TSTAMP_ACK timestamp without modifying the user-space
application.

This patch extends txstamp_ack to two bits: 1 stands for
SO_TIMESTAMPING mode, 2 bpf extension.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/tcp.h              | 6 ++++--
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 5 ++++-
 net/dsa/user.c                 | 2 +-
 net/ipv4/tcp.c                 | 2 +-
 net/socket.c                   | 2 +-
 tools/include/uapi/linux/bpf.h | 5 +++++
 7 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4c4dca59352b..2e2fc72e115b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -958,10 +958,12 @@ struct tcp_skb_cb {
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
-	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
+#define TSTAMP_ACK_SK	0x1
+#define TSTAMP_ACK_BPF	0x2
+	__u8		txstamp_ack:2,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f70edd067edf..9355d617767f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7047,6 +7047,11 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING feature
 					 * is on.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4930c43ee77b..9f01dde12e3a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5550,7 +5550,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP_NOBPF :
 						    SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
-		return TCP_SKB_CB(skb)->txstamp_ack;
+		return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
 	}
 
 	return false;
@@ -5572,6 +5572,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 		if (hwts)
 			*skb_hwtstamps(skb) = *hwts;
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
 	}
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..aa080f7ccea4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 
 		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
-			tcb->txstamp_ack = 1;
+			tcb->txstamp_ack = TSTAMP_ACK_SK;
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
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
index 7b9652ce7e3c..d3e2988b3b4c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7037,6 +7037,11 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING feature
 					 * is on.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


