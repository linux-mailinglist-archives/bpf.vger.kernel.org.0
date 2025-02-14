Return-Path: <bpf+bounces-51501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E1A35369
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1E07A1CAF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28613AA27;
	Fri, 14 Feb 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVBL3xls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033225776;
	Fri, 14 Feb 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494898; cv=none; b=cAtRMFPi1ZRgLvkDyMZYfe+6mwDUuaVbVtXtnWb2Biz8KUcUNuZaRtRGyC/sNo9xoSfhXCJVzXhvoxBVrPKW3if1XOt1fCsRQuSsJHJYasW2ZonIzQXPk5FrN/DRN8tixS8UNBPF07gbFtO1J/XrRVyg70len8v8+tGeM+Qxbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494898; c=relaxed/simple;
	bh=E8UHKud99Fu9f2BVbg9Pcd7DJcoCLPzksMrcw2+5VVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBh/bVRiUfJfRFrNwNiKC/neI+y+UKsusxv7U36IPamVDfqBgHQL1IqqLE5D1fsooXgALLSGee/q3zCojDNfc4IMGkOMoc8jjPraN1seA87iRPw0MFK0YC9zB/ElqAYQc6/TH8YLCsKwPmZOjtBddXhRWSmU4FJmc0V3hLq7E7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVBL3xls; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f44e7eae4so27728075ad.2;
        Thu, 13 Feb 2025 17:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494896; x=1740099696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY6onKURQRdrENgrbc1FwSconAR3JFw0QnOfThCUE3o=;
        b=bVBL3xls1gXGo5rmWn8jDHVl9w3OlDOrcEzCu5J+YTHss7aXw3l9dg2DH2T3rUx6AT
         WumeWEwAu0Nl/+hhH/24US8gJrGeRlcwmatWcUYV36dOHSBGMicup/b+H+f5UV9R+O50
         d+/qJZYb2x4q7257jfMqeKJ620WfTrSGB5ywbtQtGTUuuIk92P+fIxB2n2rQ7wiVcHf2
         q1p82W3MbZtdwQxJoBfKSay2hhl4gE0SpxxbuAqSi/++U7XVjPkw9p5ozPNpIVbB3lWq
         GaVW7VynkpU10TmMiTKPFaklWnY2v7WDc704Ca/3il6Fsw/uvioMN98vZfjzL2hJ/VzO
         zs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494896; x=1740099696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XY6onKURQRdrENgrbc1FwSconAR3JFw0QnOfThCUE3o=;
        b=w45GllCVz1y9Zah7h9m5LYbqgZ6AOUF7if7buMN6I+aU6NfddfKBTVvNaM04JFrZU6
         s7k33dujyKagiera+MVfz4Vz7f0BIipLp06H267dn23d0xUzHq2wYyYt7y83eMTidKQ5
         1maTCAj4R8HzDzfk/99RwFHjEXHs2eAyPcXN+wrpkHQMTxHT2ZIbjGS3AnvD0oUBiQfZ
         uw0JB8mMlg4zH/4r41/fcn5hRJcd5o2NXUTZYmJA/nOkyz0XYlG+T438WHZO8ZvaDFIN
         KoZQhFriHOjb509EJMLvr3S+m7p4G7RwMHzRdcL2mIHLyPf0z8VGyy0AG9ZgnGTLKRgI
         TPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVujPZXjLvdxEIzq5CzjZpCyPmtveLNdoXV2jnRuYDuCoVVvDa86pMI0LCIdKUdeltYgjUmMow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHq8gJ9N1/mY79MSUKA21AYFTLnyzJIM342NhWH0bdBjW5rnQ
	5Mhit9ceT3Ri2mYvRtbS6qRAVYBEIzlg9UaellJvKd6AeH8n5OnU
X-Gm-Gg: ASbGnctha4E3ZIhFWuvB5vGIDJzXHsPCHCdcYyUwEO95rCSNTW0vF/AawEsXL4ykwqt
	mphJSf4t+jOHGGv5gHJltFyNyJmOwzIbtovCl0RKKV9CSvexsOMX8Y/soXQ5I/yDBJbY+AlyaVI
	Adr70tCBmL0owOwkFz6T3ftrWu605/Tu5vu6BMMDJ5B58DDDP/4EesbhtpUIqLY1cb+4okXy1Eb
	gvvYblOY+mvRv7WBHMf1vxPviZl3jr5/EN6fpB43Tdobznf5Eu5MKdDr88vbSIJBB6U98r3QHdR
	BSXdEn60gz/o642KAKeqM3+7rgJ21SlERMoVxN9yPE3jova0yr8rkQ==
X-Google-Smtp-Source: AGHT+IF3cPIV2DMGGMpvlgsnfIdoHH1G/fd1WhZT+7ZGbRNeqrzK7zh6RLRaNVny25+rsDBmzdgrgQ==
X-Received: by 2002:a17:903:1a03:b0:21f:8453:7484 with SMTP id d9443c01a7336-220bbb24afemr143707025ad.30.1739494896251;
        Thu, 13 Feb 2025 17:01:36 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:35 -0800 (PST)
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
Subject: [PATCH bpf-next v11 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
Date: Fri, 14 Feb 2025 09:00:35 +0800
Message-Id: <20250214010038.54131-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
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
index acafa05f7f58..f096ca6c2ced 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5550,7 +5550,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP_NOBPF :
 						    SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
-		return TCP_SKB_CB(skb)->txstamp_ack;
+		return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
 	}
 
 	return false;
@@ -5575,6 +5575,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 			op = BPF_SOCK_OPS_TS_SW_OPT_CB;
 		}
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
index 0d704bda6c41..12b9c4f9c151 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 
 		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
-			tcb->txstamp_ack = 1;
+			tcb->txstamp_ack |= TSTAMP_ACK_SK;
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


