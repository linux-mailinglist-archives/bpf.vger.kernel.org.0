Return-Path: <bpf+bounces-52056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7BA3D248
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B136E16D1B4
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02A1E9B19;
	Thu, 20 Feb 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJUtXSEF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A91C5D5E;
	Thu, 20 Feb 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036646; cv=none; b=XVKHN0lJ3o31CuuqSrv/3ZJJRF8o1ZlqfU2h9yshLHid0aZwFnsWtkQsNpGfcsbBZxQ5INiMPFraXnjni7Wn7YcMKCZ/A/P2+g74YcvdgiZQbvHC++A1jwfo7vGOOD7H7cRQpWd41zB6Q2TufwXRsV5hTIB05CSx20nDDcZ4ycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036646; c=relaxed/simple;
	bh=pR9zQpfGxWDpMnOrXN6Jpazai6FhriaUKtjsEv8XPGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mV7DHpQjzVWejmmhIoJcinYIWvuwFu3Yh1uA/hto9jf5ox8Gjm2NEehZKYEXzXkimr4vVKc3ZR32K0MiIKfS8AOtzLYoJm4e+c64ZM9rg6g3AlAaVoJKscedKyRTk1uyuPX1SLuuBN2gOxMrBRdvtlcuga3pi80ZrIJTIMOKZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJUtXSEF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so11821525ad.0;
        Wed, 19 Feb 2025 23:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036644; x=1740641444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVedz6vK3X/jikH9HldxENXdxMpSZlQIWb+EwsIWA6E=;
        b=XJUtXSEF36o3sxV5eTu8vnMNIxt3SE/1Y4taptl2Zk201bYmdgoYnP9ONgQIuL9Zu2
         HrYfsK4a7YmMm9ttd1gIo+ETYNXseqabAtio3Cn/MuDPaZYqd1RwzdDP/85AOTLlLpU6
         M7nTKlt3zaSpkGM29gz+7kVGeuTha4wZt8nrv6dyGF5MkMMqut++0wY2IHt76vWM/9R3
         KPkSTOn2iQPKY2rC50PeYcOYmY9M5IHU+d9/esw9IOuiy4KdUfkWahUWJZu5yHRHRePh
         58TLZd8MJTblBHpygXuibMLhfOiTvyqY9m2roqFdqxXx1fMPqjPqKXLcNDp2uhjS9SDj
         6O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036644; x=1740641444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVedz6vK3X/jikH9HldxENXdxMpSZlQIWb+EwsIWA6E=;
        b=qIvMyYu05VjDdCHeFCBFF3aZNjlVXak+HY4Na6s0cZF/0sheh0qrb5H9E3xPmbdYMR
         Cs8c5O7aLjPLiVuz+njBgzBLQ4WbwL41ni/wy3nuFnWgEuEoQKOCaHPQ+3i2yE935FeF
         JpNwsN+QxRreC72+zLC1u5wgSJoFDwc0tSMmVWdJTrtJ2tAPDZWryCKehOpyRT8bT5l1
         PC0GlB1MUnJac7HPK2PT6lSp4aWrAG59iuqbLQMJTK5L4hvH2p2CzrP4DMkplwZdlu4f
         ljwhYorsrUal4gBk/3d34YJuTNHckMa1Re7vG1nHyBkOUrKkPqVVzigb5VlpMwv15nU+
         p5iw==
X-Forwarded-Encrypted: i=1; AJvYcCUbgjEhkI5+/DcYzdgbYlJtcpZhv45uTyMyQNdMIgHtfy49G9MUEklVZfcaU4iXhmtCkfYJNgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqj8XyHbP2WhAKODUKSmTlRQp0phEwdtNwi0neNpmN1lpeAsoI
	QDGj/TAtIEQYtaBs2vuGybda9oq3HZbVSSIMS5l2m4BjivbcWfJp
X-Gm-Gg: ASbGncuriLYFgfvWHyDQCdG+4pNEXJPW2tujtwuTUgFpTKcYTXoVZjEYJt0vH7q2x4I
	0czEHi9iiuGrHKz2MnxfiPJPyw5eEnOCELRBhnGfAtnZg9E55gGB7eQqd4SQCjU1DjtHMPYAnfa
	IJdGRpv8Y23TGlLS3DEcALGr4kyUOdmazW5nslfzSdcF4WkQXUAV+evxJ9p6coLrcakRC8T0Wae
	7zLZ9A1hS0/iqo/ZV5cqT2G8W5ooJZLj2X/KOwg7TKd8wp9jwtfSYcfJ10vDbz8Ak6ALseKZk3x
	CgkZzTcxghM6AeUsGFj4HM4BEVSqKq3KBOJ3ykkvqe4XeGd4aS05gC/AZ3ncsvw=
X-Google-Smtp-Source: AGHT+IE85mZ3dsJgMoTFUrjjjQilbTC8gfmR0ATRmv6p81XdmnXHuAlK43mN25l9Fclqy9joFWNcdg==
X-Received: by 2002:a17:903:32c3:b0:220:ce37:e31f with SMTP id d9443c01a7336-2210403dcc7mr298966345ad.17.1740036644174;
        Wed, 19 Feb 2025 23:30:44 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:43 -0800 (PST)
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
Subject: [PATCH bpf-next v13 09/12] bpf: add BPF_SOCK_OPS_TSTAMP_ACK_CB callback
Date: Thu, 20 Feb 2025 15:29:37 +0800
Message-Id: <20250220072940.99994-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the ACK case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TSTAMP_ACK_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_ACK. The BPF program can use it to get the
same SCM_TSTAMP_ACK timestamp without modifying the user-space
application.

This patch extends txstamp_ack to two bits: 1 stands for
SO_TIMESTAMPING mode, 2 bpf extension.

Reviewed-by: Willem de Bruijn <willemb@google.com>
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
index 4ec1a86288ef..6f728342fabc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7048,6 +7048,11 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING feature
 					 * is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_ACK_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 77b8866f94c5..dd33c12f00ca 100644
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
 			op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
 		}
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TSTAMP_ACK_CB;
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
index 0a7db1440653..11d9fc3e3434 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7045,6 +7045,11 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING feature
 					 * is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_ACK_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


