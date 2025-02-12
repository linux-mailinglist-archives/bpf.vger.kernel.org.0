Return-Path: <bpf+bounces-51217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF483A31E9D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E5D3A92E6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1801FBEA8;
	Wed, 12 Feb 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHMLdto0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A61F0E55;
	Wed, 12 Feb 2025 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341203; cv=none; b=UF6VSAtODd75gjuqCuPK9z+LMACcuBaZ8Id8aiAHPwkchW5ScL+5EvMtTOx2ve2uIEEpYuCFJyN3Xe/exlUqosqK8AlGXK/fyJUifW5EN/tQdSO1L9oysm851rec+SRH+HSc5m0VRkHbiSiP1/x61MuU5bGgeukfx3/zdzwlDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341203; c=relaxed/simple;
	bh=lAyQDo75f7djJBp0Wk+piFMQ/oCKu6A6rLvq8Hij9qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nj6aI80GQrgWxir/th0mYJiKeHvZ6iXTndynF/dSQQHx0c6ukp/RJa2QnF/33nmWE/GfE6AGa1KfGeoMIo2BqXVByYtjbOYihpB6l8fdDucVkPAq1d96hmz0O2jq7ZI8PQPly6h19gg+Waa3kagRLK1KcPxNdWBDS3P4Q34TIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHMLdto0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f50895565so73609755ad.2;
        Tue, 11 Feb 2025 22:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341201; x=1739946001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kWlfS6hI7GvC2PKUzdJg1ybKngDLJiHr3HBP4pTlJc=;
        b=PHMLdto0ZCNZKK5o5dlK/bdTvQe3KP2qHtu2B5G1EkyXw1mwrJATLS745U3GgbLsix
         VhpNxWc9RoueM5c8VPTeuxKddv3W4vaHR/7ctYw4V5U5CrfeHTsfM+xAavHKECGbAMDB
         KhWCEHjzoUZVLA4xdB1oiGynpSiXqbAifI5FQO+ccOC53r/zAIqZQsXP2xGB3B7lhrR4
         BA+nKhVn7qoTYHOBR2aQ93mI49QdJ3uR6N8KiiWKNGejhncVtnq076HRnAz25k6g9+U4
         gZwShqZoWzLxvpVmrxxE71lFvOO3RrIh0q9EtWqy64mcF7p975goYBoj7MOR4yGahS0+
         eEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341201; x=1739946001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kWlfS6hI7GvC2PKUzdJg1ybKngDLJiHr3HBP4pTlJc=;
        b=RwTuF6IH0yETVSZHgxiwUR42dsCjbN+Q8l3o7AG6VACF6oI9H26L6vgaSmbh11iBU6
         3jp1NkSX4yptPPcpm1x9V6vJ4VwVW/UFvolnK0giawsCeDQ6WhSdW2t08wfg+nTAtJpu
         2DPMT0R3khdUt7nyJLyKhLRVV84t0XjxSEJ6uHOAGMLc02su8nEOt9WyUGt2rjaR+aTb
         BUgapccH5+e+GzP5XCGsagpKGJc2Q8Sv4u/zlR46be0LTl5VueDyG8qsxqYA2WQs9pxt
         s8h6ndJXqeaorw6zSizxFIGGEG0Vfp/YX9F0HQFcdoQ2CIwW5rE4iJ4qy+D8QvZulE7x
         W6qg==
X-Forwarded-Encrypted: i=1; AJvYcCUic6custIIhGUhqWBFH0fUP7ewsKV5Bn0I7xi4Y1TdqnI8nhYiG1E9NtLO/8ffJ8yl+AY1qAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcfp4j0Php1iimrVPhz0uqofhzLLi8NX5Xs1Swx16Icf4LMaND
	mbNulwaG4CiceM3za7sH81GTTST93nb/AJR5JZ/WZH/UiPhq/HgU
X-Gm-Gg: ASbGncvO2pv5VlmljpgJO1Z5k4w9E8ppRGsVn3UBMr1hNGLaFBZV18wep8K5ePI/5nd
	nPnAZM2nBaY7prCIc85UqPyUD1GnFfbg0AT3Df+de34m+RwtUrlOX6RtP1/AORWkVfPNFyZLKAR
	mecVRJhyJxWcb/qtEUybrBCG8ju/QKcL9cSHnxTF5aQaR+KRXGa/7SAFPFQRWVRR2RFcIHMtYxZ
	xTDzdppwCl9HRU/sxSsPFYHDmCYpGmmogeJaA7VTVMUxoOc/uVGH+nSVSz8zFCfAQ9t9E+EBF/8
	cKzHHg0RX1VjtBzSg+w8jMB5xrXEdO+Zco/f/TIxIaoddsEVS3o7KxqWt59+Mqo=
X-Google-Smtp-Source: AGHT+IHaTjb8++NRczvfecHWfMCpYSXsNcD81AZ/wmsvoChDFIGAEJH0xs+2nML884aI9+sYL2mK0g==
X-Received: by 2002:a17:903:2b05:b0:21f:4b01:b985 with SMTP id d9443c01a7336-220be007160mr25304985ad.45.1739341201391;
        Tue, 11 Feb 2025 22:20:01 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:20:01 -0800 (PST)
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
Subject: [PATCH bpf-next v10 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB callback
Date: Wed, 12 Feb 2025 14:18:53 +0800
Message-Id: <20250212061855.71154-11-kerneljasonxing@gmail.com>
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

This patch introduces a new callback in tcp_tx_timestamp() to correlate
tcp_sendmsg timestamp with timestamps from other tx timestamping
callbacks (e.g., SND/SW/ACK).

Without this patch, BPF program wouldn't know which timestamps belong
to which flow because of no socket lock protection. This new callback
is inserted in tcp_tx_timestamp() to address this issue because
tcp_tx_timestamp() still owns the same socket lock with
tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
the timestamping related fields for the skb, especially tskey. The
tskey is the bridge to do the correlation.

For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
then stores the sendmsg timestamp at the bpf_sk_storage, correlating
this timestamp with its tskey that are later used in other sending
timestamping callbacks.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/ipv4/tcp.c                 | 4 ++++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9355d617767f..86fca729fbd8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7052,6 +7052,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index aa080f7ccea4..54424cd20557 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d3e2988b3b4c..2739ee0154a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7042,6 +7042,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


