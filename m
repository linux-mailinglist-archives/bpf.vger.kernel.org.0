Return-Path: <bpf+bounces-51807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE62A3925A
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCC63B46AC
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5141B042A;
	Tue, 18 Feb 2025 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5N1pixO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737271AF0C9;
	Tue, 18 Feb 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854980; cv=none; b=twIyzSP2HlpTn0nANpG74KRIOoWT79ENIwcRtt0bVRRjDp7MFgY6D6tF/ob/vf/3It1Zj8s9j6kcfvwSnB5qBRTsSg9FgWhtcadXO9Njiqy4XwMavi/KV+FjVAzNLBfIOULvHjkwyg0g+li5M7padFBhidkvJvasQzMOsDHzcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854980; c=relaxed/simple;
	bh=f6UPX8nqSzhpR5jLn4sqYvOct90ttv2Ux+uobqmyXyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdVYt4kR3qnuuPNB28DYrz+XTcdg/z5ZQfo0zL5GuQiyjuEEsFTIusT1Av66bYEPklpKMWPl1rdaMM1fDk1RPoxdu7+iCdbYaIf7RAnE2Z6NZMG953Wwdw0ILvIDp5YnrOpzbL4GLRINtbtzK40BfXorxSnk+myaW5+DE/nxDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5N1pixO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c665ef4cso73645025ad.3;
        Mon, 17 Feb 2025 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854979; x=1740459779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwKWPUXCleIrg1+YnGzh7tU7O5+lCSDVQCdHHSHmWTs=;
        b=D5N1pixO+DGwOQAYJJScXyMSyBIvHDdhuKPuZ88FtNDpDeUQzqXYO3b7b1BPgvlJAh
         youk4IgT+FNSFFJ/OFnt8bK7pjKpGTiA8bY74hnIXJu5uKHjWgRzReZgIyRf6+kmpfUI
         y1m0FTV/v6hjwfcWEGRYxgVpLIFvZC76oE0A9/Rxc9+F98Q8A9AqQUkR59hovkBA/eAl
         QT2s3jqoSkBI8MgrX0gI1YdrIGO8IbOkBTxdTZXDW4dkIc8T7zNhrR4hg8JI/11vrwrG
         kqvFme+MY/fCvmlnqZZRFKUarZZdFZ8+jAau5Yrq6GIZrW406h74bLrQuy8G4+T2oTPo
         6HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854979; x=1740459779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwKWPUXCleIrg1+YnGzh7tU7O5+lCSDVQCdHHSHmWTs=;
        b=dJcdGgSGZh2NPDE6k7aIsOklVfLommtAN40qeIw+O4BbH5YiYiEIU9p4a78/1f/uyG
         M9m3B/hXM0WRUShqMVCGpFLyZQEAg1DGf75hMXsTPbJyguEOl1/+7GUw5pzuLFmEBhH+
         4zFr124sRBtN3fcVG1NiKhYDtQ9/zhbRRya6/v5AuMyoSSNHCo2CC/zkI0YloLNo7TS5
         xLPS0W1bJal898VI5YCDn5Be/ek8/Dr86kdgI3wA7vYHbJs9Y1pGsZYBvnDPXL1bpmF3
         AxaJMOidoQPukcVolkCFQDnF3cTWGIw1TZwqWe7Q0v3XYVI3J7WSp3ZX2UjigLpBZb9Q
         z9zg==
X-Forwarded-Encrypted: i=1; AJvYcCUXCK/pwAQu3s1IraoW2YSg0iD2lRv8NouZgBdtLaNVY8x4NIcZ2TYO01Ie9rbtznaXrYjA/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1u8tr9OHHHL3TQOzgDAgH+qBkV6XPhnj9O3BsXzek9hiFbx18
	Ud41wMnhIpqYgKkB6Fiyq3k7XcLhLA5nZSc+KsyhJ4XTUXB1RiMU
X-Gm-Gg: ASbGncsjeF16GmhuGroP/CBcaEVF1JodZvAUUKTqncdBXubk/HEX3k4VaHFo1Zb4SF7
	3PX7WIpQMihRcZDhuBepbA5aCslrFAi2iUrys3HxEVcmvEAUGJWfePgD3HU3ysbwcpOLBNZlgnY
	vTrKoXSLGnD4l71Z236P/P26XTwNyXr4YYqsxyvgWub1NQuPYXw/LlAqhe/LyOVilw0a0RDu7ut
	LZwIzjkaLBQ8v1Z5LlPqWT8CMId6owHotvAEe75DSAZdgS9Wy3Ks83x0r6o+3CPeF8POO+O3lEb
	th8ziXnsC460200yUX0buccbOBmi765Fl+rupmGO4aBD9WTkVDLgRyBXf2WRsKc=
X-Google-Smtp-Source: AGHT+IHFIRwQHnq2ePwaF80rtxwcZ0D0O/3Vy0GD5n5EBqBnIxttX+8R2iarVx5rNFOgs/y8BKccBA==
X-Received: by 2002:a05:6a21:7a4c:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-1eec8e7219amr1911588637.24.1739854978661;
        Mon, 17 Feb 2025 21:02:58 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:58 -0800 (PST)
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
Subject: [PATCH bpf-next v12 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
Date: Tue, 18 Feb 2025 13:01:22 +0800
Message-Id: <20250218050125.73676-10-kerneljasonxing@gmail.com>
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
 net/ipv4/tcp.c                 | 2 +-
 tools/include/uapi/linux/bpf.h | 5 +++++
 5 files changed, 19 insertions(+), 4 deletions(-)

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


