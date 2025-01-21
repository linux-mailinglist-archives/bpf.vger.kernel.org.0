Return-Path: <bpf+bounces-49322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931AA175B9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BED3A5D82
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED60260DCF;
	Tue, 21 Jan 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+pbwcdT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395013B2A4;
	Tue, 21 Jan 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422999; cv=none; b=Qreowv/czB28I2dvLAsTWG7UeNiZ55yhAqvoT0H+rdvuxdTQuQi66tXj8wfsTSQqOCvUlh+te0CkTGhCSKyJHe+OW2W4GIX5x9+R4fjJpYNpEDT2OrCoOuesAP0QUQHIF5KMGXACfZyo4cKi7KDHQFMQo9KDA6XxjDqC3zZnePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422999; c=relaxed/simple;
	bh=OeMn2IqojtMI4IcEEeJOx8GAJ6e6rHinISfToriGhAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jae+ZshsbhLkdlBctigKluizMdO5AZUop3wsfDigrDRr+7LaMthzh0UmaTBir5h3CVk0ln2fEF//zxXiDo99OOfJt9Pt9RVLeKhzLhMDSfnf9mrxYZCELvgPiWpdEMSWWA7M/EY8pStDnCtt0N7XxLEsRCrBCbuI7hM2TGcEvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+pbwcdT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so9057231a91.3;
        Mon, 20 Jan 2025 17:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422997; x=1738027797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2bVhj2fiEFwl9RekvLPToYuCRpij9Y8kNfLli/okws=;
        b=S+pbwcdTNzmWdFlrGNsFKjz6ZxbXGt856doqc2vNrA5TS27HXMa6oyoErvSindkQx4
         JpNVO6WaeTuSoPe5/Uvjmtkyi5uR6Cz5a6V8WsxuHOptQjCFfR5uf8zqOvRJ//NfyZMp
         k1qtzwGr+hqtLsAybuMWuNcXCeDobIRXV5Vrc8ql8+LLa4ICOQj3lTVihztpj8XYaeVb
         LKnmuxozswAulpCrPG3F8s7ckrewRQ9GkwW6b5vopzUiCiOB51pX1XKKYfJmXNlnIReP
         L7l7G7tHnRHok7N1AqUKtkLyP0gR/f+YP9j7exfEJ6Fvtli+zIbRXeQ8QNVZk3W9qNix
         UEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422997; x=1738027797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2bVhj2fiEFwl9RekvLPToYuCRpij9Y8kNfLli/okws=;
        b=Ri0MeXP2mpRqAVkaRjmXWJGroFwYuxxVCU5R+5g398fQqRyxeMDUxGplyME/Br7cEq
         B2SaB1HrTDnG7i/w38/abh84lSS+4mpq7KAxi4kD93xE+bUio1B3zhS6/FSy2iyKTAls
         t8o+059KNNRz3uFnKoG5FoqAKtiVjVtG9NXA/qaj4ad6h5X2UklI72JOug9+ntZ9WK+v
         TYop50VqMH2twdiEyedOTKhtqI1RO2GmZ01aeKCke5Djt/a1gaN0HLh0IiR+9/iY7ij7
         Au9+COz5w/3ZfJgEnUWuCBHCNfYQcmRCBwS8kf5ODN8filq6XxiBrDSOcT7QGaUn8JL+
         klgg==
X-Forwarded-Encrypted: i=1; AJvYcCUEI1Nosj88+qg9TsrHvUQrIy73iIs4UUMbJwj5Ebx9uIGz1UZ7bXegkPbJey/m9jVIPyo+juA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIK0Yb2mABqsbNgqIXLprX3DIQSVGa6PVN04CNCmm4fUX3N+Z5
	kO81TwO5FyyLP9KG4hR1cfpqu1CJOAgFzS0+2bTcAj6zseWSslSl
X-Gm-Gg: ASbGnctU/tw43Cy1jt8TA0YDYvCFVl4APoq0scSE+n0ZVvFW+Tm1Okb/yEWwUFXIOnG
	EyC9e3k0wWMhY6vydapkfE+80KpZhv6Rz/xQDFs5n8P1vVIcADOUFtQcvHBN+r5N7SJezkbK8EV
	fCleJWiwmDv/tTbXavCI2biBsz2NUPLZaKzszv+5as37O0nO6ZcOkWVy+nCbX/WI38/KdToIT+J
	AAImUjhtt2vmOwcHOmqztbEExDPAvjHipmLw+SurezvDrH089Cwzh5q2s3jukEhSLDCriB4n42K
	pKI2qqeU4rMnY2bXU4M6Glp1bZQibLHU
X-Google-Smtp-Source: AGHT+IFGtDW1e9JvBJ4rSLfGwnSFIk/gKwkMhmWQNmEUb2pUGLYuve4/Gg2nYiry0NG6+yFN6jR8TA==
X-Received: by 2002:a05:6a00:3c8a:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72dafa45104mr21972382b3a.12.1737422997144;
        Mon, 20 Jan 2025 17:29:57 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:56 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 08/13] net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
Date: Tue, 21 Jan 2025 09:28:56 +0800
Message-Id: <20250121012901.87763-9-kerneljasonxing@gmail.com>
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

In this patch, we finish the hardware part. Then bpf program can
fetch the hwstamp from skb directly.

To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
use this simple modification like this patch does to support printing
hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++-
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 11 ++++++-----
 net/dsa/user.c                 |  2 +-
 net/socket.c                   |  2 +-
 tools/include/uapi/linux/bpf.h |  5 +++++
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index de8d3bd311f5..df2d790ae36b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	__SKBTX_HW_TSTAMP = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -495,6 +495,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(__SKBTX_HW_TSTAMP | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a6d761f07f67..8936e1061e71 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7032,6 +7032,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SO_TIMESTAMPING feature is on.
+					 * It indicates the recorded
+					 * timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 288eb9869827..c769feae5162 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5548,7 +5548,7 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 		flag = SKBTX_SCHED_TSTAMP;
 		break;
 	case SCM_TSTAMP_SND:
-		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
+		flag = sw ? SKBTX_SW_TSTAMP : __SKBTX_HW_TSTAMP;
 		break;
 	case SCM_TSTAMP_ACK:
 		if (TCP_SKB_CB(skb)->txstamp_ack)
@@ -5565,7 +5565,8 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 }
 
 static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
-			      int tstype, bool sw)
+			      int tstype, bool sw,
+			      struct skb_shared_hwtstamps *hwtstamps)
 {
 	int op;
 
@@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
+		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
 		if (!sw)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+			*skb_hwtstamps(skb) = *hwtstamps;
 		break;
 	default:
 		return;
@@ -5602,7 +5603,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	/* bpf extension feature entry */
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
 
 	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..ae715bf0ae75 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
 {
 	struct dsa_switch *ds = p->dp->ds;
 
-	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+	if (!(skb_shinfo(skb)->tx_flags & __SKBTX_HW_TSTAMP))
 		return;
 
 	if (!ds->ops->port_txtstamp)
diff --git a/net/socket.c b/net/socket.c
index 262a28b59c7f..70eabb510ce6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	u8 flags = *tx_flags;
 
 	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
-		flags |= SKBTX_HW_TSTAMP;
+		flags |= __SKBTX_HW_TSTAMP;
 
 		/* PTP hardware clocks can provide a free running cycle counter
 		 * as a time base for virtual clocks. Tell driver to use the
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73fc0a95c9ca..f1583b5814ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7025,6 +7025,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SO_TIMESTAMPING feature is on.
+					 * It indicates the recorded
+					 * timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


