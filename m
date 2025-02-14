Return-Path: <bpf+bounces-51502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D778A3536B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F17A413D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D77603F;
	Fri, 14 Feb 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY6DuX30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796A25776;
	Fri, 14 Feb 2025 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494904; cv=none; b=EMw18+BCvvobPZaSVkxO26JGtowHzXBC/GkgqiCUIpEk2KCFt3+5Ks1MWfKC57wcBvaNe9gge6o/Y7I76+Qgsgf+7CNY3gAUQmgY75n+X26Hqpqh3Pdc9cYZyhb8tOT3lnQ3tIjpoX3giwdNWeAG8c3BP91bGg8E/laNDf7Y+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494904; c=relaxed/simple;
	bh=JPoQgaS/t3HFTd09aBUhh/TgXSHh06+b57Va1cSIE4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCYGAPPdFq/x0hSMs6mmw7gpSlSDzmIAkOtbfnwpocyBtdaYVciKDTs73tXv6H5U+eG4F+tpdsW0uXxZnn2NextjGSXzXCBRpvPbfVaYGazHQik468WjeXvpVdkn5bYtMiaeS4FzmbKImseansqP0j4BJMZS35DyGQXdrDLSWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY6DuX30; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d398bea9so20688305ad.3;
        Thu, 13 Feb 2025 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494901; x=1740099701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS3SgII/6U7/5mkIGtNBNd4qXYAT6zWaOxbAl9i5SRo=;
        b=nY6DuX30GtAn626d7Jt7rCkl1rxASy9DEuFdxplbQNGnR3uXYfc1F775D01sgpJ8ga
         AW5oq+rqwgn032SIW+xsRuF75YeFm1tVATDCsYoZlur3+CkRy/Q0feCTQNyIAZOOf3UZ
         uDK62QXBBL5P4V1HdxncxFh2gzGQPV2VJdAIkoM8n9rwIW1zC+gYhz1IhD78ZbkiiheO
         2x7PS94xMEdw6EpTFjz4OhjATMHUZhcxX7HX2KktHC0ks/8nP8+dCqnFzt1qA/qrD5hX
         2xEOI98Ii+fI8nE84daVl6Pd1KmJi/6vGO4AATV1n1VPgJmmCTBmsHqngXevVc9DII8P
         jrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494901; x=1740099701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS3SgII/6U7/5mkIGtNBNd4qXYAT6zWaOxbAl9i5SRo=;
        b=ekrRlECweWh8D5/wmpdH7M637Hn4PnGidCGwNKr3snUVZR1t0K2WlljgKHb/A1Hety
         mYgDEQlAI1qqkEVML6amUrr7OTSJXM5g1F9NOGAzlF5cxj6iXvhc+0YAl11VlROErE19
         OWBeivlcPM4c07qOhxM3km4aMebEioGCKZrQrHifPASSqPsHKpnz2iDyaXq+gcJFlqKX
         4GeXmmxN0S+tQUdDJQzqOs4v3XZmk55c8WwWcw9zVI55AvTHuEkjS/OtyH1HKXPzswqO
         Gy5dkLLyUFYx4PdCnm2M5bYs/XCeFBkBWoc80jcNZ6kMhx2mPDAYxN5Usm9yhIhg/cfT
         Y4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV5b7VUB61hyP/PUiP+3WG7vGD8vGpV1jLc4fdW6rOun/4Pait7EFwhNAUnKVjzDvAYeL+zk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdGp/DtUJf7fwxz1CIqmpVZBTOvE0yRBTDDQsdvEuWB8iI0tL
	bwat/BopgXbg8bF1sMVC18Eylg/BAY0aPIJhoLxE78pz1jjKKUu4
X-Gm-Gg: ASbGncs46euDmtFC7yI9ysR8nhy8ICZmFoDJ2ZcyjfqcU8IwZoiLypj/olpaCOkoLZq
	2PyiNCZuYPftgAR2Zj+WjwdMuF5hzu1q+GbZZBSLObaec9hvXJS2KiETv6YYuoS1wGy/8Y7V43e
	WN8fqV4oQsdAtAu/W+ZL2xaYlot4MZ5KVgpr1vgOorhOncRwtdJReV5aNEFns6NBX6W/Xc+xrPA
	NLQIBjiuV77kZ2OtXP1HNnsA3v2+REJ8hL10U3fm4WPRRSKQsVKV8yvtP2jfT1J/xajCOsH2eJe
	MEMbq44XpduDxHz8r6U2LM0w3W3fQHmlqG5QFz3kXBmEP5uyqeUx0A==
X-Google-Smtp-Source: AGHT+IEFbNMCJ9tJN7JZpdtkegqlod6l4NWrg6046wPrniAzlwccv9e7vcGf9aaIMyqkjVJVbhrXPg==
X-Received: by 2002:a17:902:e881:b0:220:dff2:18ee with SMTP id d9443c01a7336-220dff21baamr57366275ad.14.1739494901604;
        Thu, 13 Feb 2025 17:01:41 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:41 -0800 (PST)
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
Subject: [PATCH bpf-next v11 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB callback
Date: Fri, 14 Feb 2025 09:00:36 +0800
Message-Id: <20250214010038.54131-11-kerneljasonxing@gmail.com>
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
index 12b9c4f9c151..4b9739cd3bc5 100644
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


