Return-Path: <bpf+bounces-49321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F30A175B7
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F12167AB6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA41494B2;
	Tue, 21 Jan 2025 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo2NXLSP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E242581;
	Tue, 21 Jan 2025 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422993; cv=none; b=X6Z/kvroezTayS3UIsoItVuffRrTgkaystDUzwhusAL0L0SPf+TUHCw+PZt/KAv5M/u2p5vwyn4MofxG843SlqyPFsVNNMbMrQeyEIfxOwEMRO8CzOrmxzl9jWXNbjN83gifQHkGZklbRwBSgPBHoeV0qkMAeNWO/q5BsfcOY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422993; c=relaxed/simple;
	bh=6vmDdhI/6JRu9Y9wYIUoQUpl3zcuP+H/1uR8El71qXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS/R4oQ0g/0Pc6NYIWtPx2jt4TJyZp4o8L9zd0bmjKb7SXUJn1KSnfJ6DPVRxihrFASucjyD7pM7wD1MUhbzAjeFs2ywYAWO0o4Izlgy+ZnnOGj5/MxwYnDFg+j02kTIsDy35KddfmSzC95cuNmcKswKPMV4bKJlaNjlWpq8a4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo2NXLSP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so6432807a91.1;
        Mon, 20 Jan 2025 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422991; x=1738027791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeKfs/0qgWaovT81hfUApgaUKeYeNmpYU4p0yGVSOos=;
        b=Oo2NXLSPEogTgyRIPmXaQdiklzVM0q+XneD4SoKZTg6QqRpQ/TPpMKiOH5+f59q8dN
         0sCDJ3+a5rJ9+3QSsWYVRW8YZzat5GmWMN9IUrhH1VXYsA74x+57Se40bUlkyq9LDfkt
         3mdCMwlUSoih7lP14hEhjaeUZHCWrVZDqGlFJ88WnHVcLMAOfrSrLxDUR24NLswFD5QE
         ou4ubn7+9FcNwhUhmWmxqrmOwkIN0J2GJ2UbZBKlnmyNI43/mn2miYSfteOx6HmqD/xR
         4fuu2ED6H+ucHpla0ctiBmFfOlEp/U9AqY1lg18q5X39NwrT8s4XzRlxodtBNUCLmU7B
         hUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422991; x=1738027791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeKfs/0qgWaovT81hfUApgaUKeYeNmpYU4p0yGVSOos=;
        b=G8o/eaH9SttHT0n8kmtGVQmh4p5rXwzN+szLH4brD08QwM3LDGuVPySizbv193bpON
         ZH0ouYpKLs5EtFcESTAnypoB6gVgbJmsvG1PdR/xi0XBKDNcDUS3bCWMGNgTr7W59cR5
         meiPukmttSQ2W5UHH8Gm0cF5Ikj+JTojZpLtccR8t5SXTlZLaFdC1iim+x0W4V7QJwT0
         7yyomOObDlO3OUS9dyVEyn3QneIugNV7cvlMGQyUp+3k80noA5MDA3oYLmSlvWoozeG5
         iAIyKd+B6uPFvitBTEKWhUR5S6JiBUnqLeyhvNWNYxiTnrvmF/dlx5Guu7br2XgwXPvN
         e9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUb08RkPHW9pBXNmU7bb9pGYycDDzAUJCWWmA8C6K/W49K0iIyIuGSK9gMswRxIs4EuZaj07Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWR8NihjMU4+6VSlXWNwNQcIKsYJJ5h7dbEply5iZoRcOTBIm
	tRtWkUrtD++0iNikkVoVOYfoZiewmmmgU1pIu3n8LSCrEgD9gGpE
X-Gm-Gg: ASbGncuCYEdQ+F4ZN0HDR6MFTLrISyc9RFC641kDnMbaoA8C8eQ3pHFj2nB2kY73srf
	LzUEkIrdeR3EfISc8jEHCQU7Qre6+9PIQhNMzabE0wYFOjQfGOqZclWS/E/ARTlNUmDs83pH6UZ
	u+NIFBgBf+yBRUguyrsLQHu7C1f072kxYi56aZPiiD3CVzA0XR/ddvdnx8LUiAHQt7DruaCSwlU
	pTiWNUa/JqRJwOHdtv8a0TjKcgLY79dlfmDGiDg5s3qAv5S/7uRUUQtcIvPAGk4ZWpcxU6fFfsc
	8oSWiIF3C7+0pBPTNfGACrwLuXB3i8kW
X-Google-Smtp-Source: AGHT+IHcOxle0YcQ0mJHert+LZBLpxvQUl03Ek+wliQP9DDm2PKmIULfzDPbKnX4QLNXIOj8MwpHuQ==
X-Received: by 2002:a05:6a00:2e24:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72daf948568mr25873623b3a.8.1737422991224;
        Mon, 20 Jan 2025 17:29:51 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:50 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 07/13] net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
Date: Tue, 21 Jan 2025 09:28:55 +0800
Message-Id: <20250121012901.87763-8-kerneljasonxing@gmail.com>
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

Support SCM_TSTAMP_SND case. Then we will get the software
timestamp when the driver is about to send the skb. Later, I
will support the hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  2 +-
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 10 ++++++++--
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 19 insertions(+), 3 deletions(-)

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
index 72f93c6e45c1..a6d761f07f67 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7027,6 +7027,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d19d577b996f..288eb9869827 100644
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
 
@@ -5575,6 +5576,11 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
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
@@ -5596,7 +5602,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	/* bpf extension feature entry */
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_bpf(orig_skb, sk, tstype);
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
 
 	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 891217ab6d2d..73fc0a95c9ca 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7020,6 +7020,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


