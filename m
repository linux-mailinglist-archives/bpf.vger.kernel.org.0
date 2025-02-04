Return-Path: <bpf+bounces-50446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9AA279D4
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7F91883FDE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15595217F48;
	Tue,  4 Feb 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkRqU619"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E321766A;
	Tue,  4 Feb 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693875; cv=none; b=RlHhgwJAAc+y0ZOEdLDhMQnpmHkBxgWhFq41utscLZMXWA2tRMzHPW/KbXaR7tV4+1/lex+SYP5jpiZqVNc2EQo/4B8zr+zz4lGb8MKiGIU392oXnTmaNShMwGYw5kUpwmoJ5//K27pyeDFoOxI+Nm2NrFJmjMjrSz/iT23lx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693875; c=relaxed/simple;
	bh=2+Mx6kV1VSAikZ82dxLsxx9efaivsDaqvC2z/QxRAgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKhMmy3kf44TyeyfgHhl5sFqRQXbNGjqLO4hMEA4RmixSolFn1r2uJ4TtAmtVgh8ZkLxH/FGHFQc/2csosAmAbRSuaqWWPEXgwHNxp87Wl9qxmafOTD3xnV2Mk0ZjobUOBumh3SSOtKkKl5O8KWEQTZO8koM0mNyLWaSADCWFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkRqU619; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9d17ac130so963596a91.3;
        Tue, 04 Feb 2025 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693873; x=1739298673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0Ir8DfOrpNhUdkogqzsydsefm/NSMJd0tTbrurxr8Y=;
        b=lkRqU619VtHK6vOrkSMTxJYVYkRN3OozjieDJ4jeKnPSUkVbTfkhplXdVsftyBGVeO
         CYS0JvrNfsc8jNWefV/+692x7tRv0FmXPb+NvJ3FH0NMqe3PXrgvVkCY3I3aRawpCgxX
         Nzufo08vE/vhWnK3ktgIAyPnIPFqFbFJ1qKWwRXU6Hf5NvWIE1wXYYn7JeQLMGYLaUvO
         +jCV9ay3M0zfvL6sFJt5ro20MHpthPecd26qPMKjyZu3nubE3s58Mt9UCGsBlzKFv/xi
         7DNAX2QPnIvxg1SK9PDz/zWiiB1H8u6Dt09JIDVrRMZU41JaouKstpqwyTbLN6kCK+8o
         VuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693873; x=1739298673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0Ir8DfOrpNhUdkogqzsydsefm/NSMJd0tTbrurxr8Y=;
        b=u9iiWVxJWQDGSUl8AMZEvWuXsw0i1Sx/enV2fD2zf9ZiGJJptf59qj0hTZ8f7lRV3S
         6vtBXcRr+4JqNfit4JfXcmamzvBKpt9RepWLuSV3n+KyGatIUEuah7gEujiE6mzji0TA
         tAdg5wHc/W34fQpkKQWrSuRKdZxma1uyIZY/Mbr/Z8xxKaSFhLrr+vybMmech1Ko9OJr
         H5rylyWy439drcd87FLYqVoQW782UkyFUhxV7je5KufgTtvRxDUagkn1P7+85K2PW00t
         1evE9XBLkvynzkM9Ay6DOuU/8uX92kN0DAcZEtcohzUOUAIn8p9AoJifzytCXQBbssid
         KZlA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5NNBrFK3+QLglkIwl6khFFFLw4CYf8Df+bLMr0IBni6GbpALkUnerfCcXgU+/O95aSAa4Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LjYlfuI+QMalPMjjoIXSVNqANlceB2XkR40UqqXqNzuCjant
	aoQTeHwiX9y+GvAmQ0Nd7E5zGmWtrQgiMk48cqzITqZRjVDeiyx7
X-Gm-Gg: ASbGnctHoslV2WiG5q7j+2h7lgXoqCU9aEjUDtORNS7108PY8V6JLniL9AuqCq2iSU8
	9xPPcDQfBYy5IjwDFE1hTkGv/GLopdwGN6dqTXsH86+0J+kz81O84ukqPeqyLBuFFr2DCs1D+px
	p6lTlvqJM+v/Q2x003Sl5AmIZTDJvfgdXVuQQHabchb7S715NM+WBOQ9OaVx5MRG/+Lr32PMA+W
	/rhFTLz//Dcn2SiojMUH5SqpC1HIGdbgQ5mYw+Usb3726568oaGNuDUxy/QG9uh9tKBT+aCnUx3
	4iEJQ65BybqtsbknxPYCASyP7f/yjCmRtKGgcfPRl4GhJsHoqXYJcw==
X-Google-Smtp-Source: AGHT+IFRS6/UXgcip4QgTIQRGbwOPZtRW4N0lj99BNDhssScbe1M6N3IUVLf/LTLyLWTIrye25iWvA==
X-Received: by 2002:a17:90a:fc44:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f83abfa2f3mr41228826a91.15.1738693872963;
        Tue, 04 Feb 2025 10:31:12 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:12 -0800 (PST)
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
Subject: [PATCH bpf-next v8 07/12] bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
Date: Wed,  5 Feb 2025 02:30:19 +0800
Message-Id: <20250204183024.87508-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sw SCM_TSTAMP_SND case. Then users will get the software
timestamp when the driver is about to send the skb. Later,
the hardware timestamp will be supported.

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
index b7261e886529..b22d079e7143 100644
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
 
@@ -5572,6 +5573,11 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
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
@@ -5593,7 +5599,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
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


