Return-Path: <bpf+bounces-50861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AAA2D58D
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D2B16ACCC
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F21B87E4;
	Sat,  8 Feb 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAANAoUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275C1B4153;
	Sat,  8 Feb 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010793; cv=none; b=dHToWWYpD/yvvjEYtctFogMKkZL86vGq+XsGTB2PQOB621ZfRqKPG6KIZPActtys/vKvgPLBLlTPOgy82iYWVTn2YsR32SQXftvx6F5SwDSnPddM2obaT8wTSjdCPxUr16d5+Uey/1lfKRU3CNHqN6otUSX85D/qAY6/fEbt8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010793; c=relaxed/simple;
	bh=3nZS3vqGw8yHludq8kN8FHhfniImBxyp98kTkdC6ZPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=payz4bI7mnnSQ6fv4LOrz4Sl2FPaOUyqI7fcXjZ58Gvy/CxId1nQvtXmMhZghxDO+l85nVyKHLSTgssugwb6Mgr1FtN5rlACK3zXt+R2MJL+flU+lGlgNTNIh0yzaSFz4LyiALlM0q/8xSyZXEh1u+c3iE0INXEIdh0uWdDeKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAANAoUu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2339dcfdso46288375ad.1;
        Sat, 08 Feb 2025 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010791; x=1739615591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbohNPgSlhgIpWwmcL0JHmqTvviK0stebjaAV2QRRy4=;
        b=dAANAoUupDOl3BfjvAHn0nfI7t0dZIlkmUukC/r/LHz2aFQdtY3tHOi4e0Br3Ccqkm
         vbXbteCEXIZn6gP3ItWhKkSTtfGn+qBQBbL0GwG+pe8VJPifzKkYMEqWmKPhz/k39BDx
         LoZKEgGzyveJdiPuLCqCCAg9T+5DDUy4QF1+wP1mN+R3PBKc3ONR0+GCF2SJm+59vYxw
         jNgNAqlktEKo2radCnMEnLD15bZ3bM53zm2K5qqmikdokpS6XpPl7k2BiJXbz2TAILwZ
         MfWOjB4LWJyR9UGfkqRHKFl6/fbjJpxxt1vYzYwq2kWFIMdoBEjD5iNS8o1VlRtqOWQ4
         ao0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010791; x=1739615591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbohNPgSlhgIpWwmcL0JHmqTvviK0stebjaAV2QRRy4=;
        b=NBPfJN7MDTyhK78/u9G9Y5q/HmIsBhJnaz3smJgXjaCENzB6DL5rBucl1aGevOxzYl
         KyzNQmqzXYSY4iCydSFOGLbjv0Fq/Ymlo1HtFTl5RHLSeiexWaBgboWBkY3vwfRvOKWW
         UWBAgD3KetRWem+JTm7rHcaWeTg1laElSZhup9iR+yNWh0PWfJO/XHKMOmbrBUdTTCM8
         CmEbrOlYH6CkwxDr5jXIKxM1rx4plsXVplJr2QRl0meG6ijfDuJhAkSeCB5/caen2HIG
         0I9IdDDy//rydR+Qf1RpmVUa7xisXyEv5TSWYoI3QdUEBY/c+AJadY4RBk2+UME5cTaa
         g+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxdwB7EE13bFJenbjDyLrr9V6XULWS/qlNvT5DllQ5eN/XhSlx/vxVZx+rzVeGz2DZOOBizZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvOVavSzldVX0j/Y24ZuOnvgtAWafi32eLeeLfqgsTFJS8085
	nta5gjS3IoKO5upN8F6k6m2MyHQ5HWde15OqiIhyGTJluedBC7Qi
X-Gm-Gg: ASbGncv/53fuPuuHo8QgHWvw5MjpzIB6CGU1TWQ6r0z7dvRVGYo1M643G48MQaUmOyB
	lPkBkrToYm2jnZHP8eeVzHVGKCN8VnZ+D/ThstzWfVwMqf4zlyU2kxMeD5smmwlcmDstw7olamj
	QZm5hDkZe+4P/wcCJ8PfVQWEeBRCyOUAcbzzO2rvSS4AMrU1iFaL5IQbJzdM7DXn8VhkwdOICzf
	r+p0UFRSmGPRPwclOCunHn8U8P4xYwb0qpif28NGG6BcbAgqYNc0OCkEb+LWbGzZDcSUVnCFwhG
	LkqL9an9w4dreLLa9ogVYOTvPo7KpnnSTxMgM7beFUKNd1pfZYtfqw==
X-Google-Smtp-Source: AGHT+IHq54v9ZG8GjBYERmaqIh8DqVG3l2dPh07XBMK+jwr0TN2GWz6qsqc4MpfrRlT8AG7D1r17Lg==
X-Received: by 2002:a17:903:251:b0:21f:4c8b:c4da with SMTP id d9443c01a7336-21f4f7a25acmr88014095ad.18.1739010790870;
        Sat, 08 Feb 2025 02:33:10 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:10 -0800 (PST)
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
Subject: [PATCH bpf-next v9 08/12] bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
Date: Sat,  8 Feb 2025 18:32:16 +0800
Message-Id: <20250208103220.72294-9-kerneljasonxing@gmail.com>
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

Support hw SCM_TSTAMP_SND case. Then bpf program can fetch the
hwstamp from skb directly.

To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
replace SKBTX_HW_TSTAMP with SKBTX_HW_TSTAMP_NOBPF.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 4 +++-
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/skbuff.c              | 6 ++----
 net/dsa/user.c                 | 2 +-
 net/socket.c                   | 2 +-
 tools/include/uapi/linux/bpf.h | 4 ++++
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 76582500c5ea..0b4f1889500d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -470,7 +470,7 @@ struct skb_shared_hwtstamps {
 /* Definitions for tx_flags in struct skb_shared_info */
 enum {
 	/* generate hardware time stamp */
-	SKBTX_HW_TSTAMP = 1 << 0,
+	SKBTX_HW_TSTAMP_NOBPF = 1 << 0,
 
 	/* generate software time stamp when queueing packet to NIC */
 	SKBTX_SW_TSTAMP = 1 << 1,
@@ -494,6 +494,8 @@ enum {
 	SKBTX_BPF = 1 << 7,
 };
 
+#define SKBTX_HW_TSTAMP		(SKBTX_HW_TSTAMP_NOBPF | SKBTX_BPF)
+
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6a1083bcf779..e71a9b53e7bc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7040,6 +7040,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74c04cbe5acd..ca1ba4252ca5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5547,7 +5547,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
 	case SCM_TSTAMP_SND:
 		return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
-						    SKBTX_HW_TSTAMP);
+						    SKBTX_HW_TSTAMP_NOBPF);
 	case SCM_TSTAMP_ACK:
 		return TCP_SKB_CB(skb)->txstamp_ack;
 	}
@@ -5567,9 +5567,7 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
 	case SCM_TSTAMP_SND:
-		if (!sw)
-			return;
-		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
 		break;
 	default:
 		return;
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
index 9bd1c7c77b17..7b9652ce7e3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7033,6 +7033,10 @@ enum {
 					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
+					 * SK_BPF_CB_TX_TIMESTAMPING feature
+					 * is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


