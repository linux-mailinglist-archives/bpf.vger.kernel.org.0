Return-Path: <bpf+bounces-50862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7CA2D58F
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EB18825D9
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B211B6547;
	Sat,  8 Feb 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVQ29rh0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FB1B041F;
	Sat,  8 Feb 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010798; cv=none; b=FwokpeaWJpI1tbNXhikftzJMkHwAXt7Us4tC4WmZKbaYF+R9/Uyve6dKrZVJLC5cKJv1TByO1pBsTXxN48Ip/F57tphL6+O6OodcSg7Z3hqEGeJ6AVLDkoZ/pm24Et5UpEPh6rjcCGqHJ4TtNUXc1cSVbwKpvBsKMKxkQNhbqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010798; c=relaxed/simple;
	bh=qgsv1VqKjRs+Ff0Exskc85JfkVurnlKkg4zVvXfcb2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjNzo9HfjOo1fP2yptq3jNUjPrZLojznizspA4pXEGCCL74aBhEu9kwedRLDaSTMTzbhBk7Hl8VHts6vXuVcQWvRGaFtW8b6TwERzQuQx12kpBREMgNj8GpAEMRFQwgSx5pU8vZchisr6YOs56k3xVLHmANO9WE1KOm1ESWkcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVQ29rh0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f4500a5c3so51602015ad.3;
        Sat, 08 Feb 2025 02:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010796; x=1739615596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qhv0JTaoXaPlF6nnBulWKhjTUAKBoxL0OOJBGDySDA=;
        b=NVQ29rh0/tB02882zs2Y99m6CL5O0Iw9SxovxUFDxMI0wj7bw6Zwj2limnQwqBl9dm
         wvbqon5sSgxoYPI/pYcxnxqV+kDa0WXbGvazre24WHl1nRmHGAFt0kJlKhuo4gpVmt1Z
         rtOaXiB6QrQKeyt9lPBrJ3JLqjtARwf33BzGpxr7090x+KLnRzpDLA57NOh3+O7GDV/a
         C5TqO1k5Vg2MwLptjpzaBtMvGiggkiYWSTMkoobdWI+ZTeHL0RxfxZ3XorBmqmq+5evT
         ZGp8MU41k6UJnNXedM2FAxuCFa10Qq5r7Ww+29VYId8OfBMGcjSR1fbaRuncf3YOtFMC
         zUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010796; x=1739615596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qhv0JTaoXaPlF6nnBulWKhjTUAKBoxL0OOJBGDySDA=;
        b=C1VZ14sEZX8QrYW5Eb4EEwIo6xaVaCaf+wGY3QHiU2ZvQQvbzrgs97vOErGVvD2OMe
         bHS8G/ZlvEhiX0xGfB09eqvuS/GHoKFwV5wmlCX2wm8GsF4OHxSq+fbdqrP3JIqUhUw2
         I6kUZTgXW6AtAE1whki1S5hYEND3oculDKOEPeI1A3tEd0stOCgOQFeaJglwhDpLZbgr
         ZCMi6kjnlEJQun2n/uBY7lZsOlhGauRAeBPp/ou4IrNanW9bqawIhvuz5CINuzbru9Nz
         T7JqQa07o9S2YE6bgB0RQ+Ouv8lNVmsq5BywNybyYrS2aYMVdWHk/FiYPn70ou/HxO7y
         erAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdQSXGIiGOSseyh5BQCjnEXxvP2GJV118eQVo8ofpLtRRQneA1AgtBbL2BpOE7thP6gFgHQ7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqo2fYnTZQg5GNNg4XUUhBhz/Qji+XCPhhLwVR0qGSf055m//e
	IEsbT2cPuh040Q05KQwwhoxr9uuqgl0N6Xluu9fNTSz5B0T45EWLHZ1JH9jZRUY=
X-Gm-Gg: ASbGncvlz0fZ0DHNwNfJruCHJwogb5qDmJISETjSolIbNM+JXYir9x55kY6w+xxpEnW
	7uNvTi3UCog/FUzCDr5cu5YdWgJm3sE740MCah66d2IZcCJx4RWbrosWeWB9bVPEdlAeEUSG7nL
	QCaDNnKsLkfTo6DcLq9v3dUhVz6j9Bgm2QpUm+pNiJ64aIg29snYU5yNVq+7U1V5H7bhDUD2/3/
	oI7yOmbNXbFqRW++rQt5+DBSj5/FSMaJf83DLK2BRHmiUznKvigel9r4psZWwxUgvL9/KH7rkaD
	0QJdD52q91L476O6RxDLwN624X+OWJRwEaB9hx+muuBDgN6IUA59Mw==
X-Google-Smtp-Source: AGHT+IHb9WdZ1K55BL0VgR1gV0QW7f7s0aNeNML6KRctipBIoqhHel2eFO1uKVvgQi23DRl6r9R/mg==
X-Received: by 2002:a17:902:d2cb:b0:21f:60cd:e8b with SMTP id d9443c01a7336-21f60cd2b67mr65273465ad.14.1739010795926;
        Sat, 08 Feb 2025 02:33:15 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:15 -0800 (PST)
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
Subject: [PATCH bpf-next v9 09/12] bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
Date: Sat,  8 Feb 2025 18:32:17 +0800
Message-Id: <20250208103220.72294-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the ACK timestamp case. Extend txstamp_ack to two bits:
1 stands for SO_TIMESTAMPING mode, 2 bpf extension. The latter
will be used later.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/tcp.h              | 4 ++--
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 5 ++++-
 tools/include/uapi/linux/bpf.h | 5 +++++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4c4dca59352b..ef30f3605e04 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -958,10 +958,10 @@ struct tcp_skb_cb {
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
-	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
+	__u8		txstamp_ack:2,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e71a9b53e7bc..c04e788125a7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7044,6 +7044,11 @@ enum {
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
index ca1ba4252ca5..c0f4d6f6583d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5549,7 +5549,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 		return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
 						    SKBTX_HW_TSTAMP_NOBPF);
 	case SCM_TSTAMP_ACK:
-		return TCP_SKB_CB(skb)->txstamp_ack;
+		return TCP_SKB_CB(skb)->txstamp_ack == 1;
 	}
 
 	return false;
@@ -5569,6 +5569,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SND:
 		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
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


