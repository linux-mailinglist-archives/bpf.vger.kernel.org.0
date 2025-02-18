Return-Path: <bpf+bounces-51808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61AA39258
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06FF188B10F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8441B0F1B;
	Tue, 18 Feb 2025 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeTpup2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D241AF0C2;
	Tue, 18 Feb 2025 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854986; cv=none; b=j81NVqytUNGRiLm/A/RqoVEN0GsRDn7iScumWRX0c6wTvdGW+Ql53fYvQJBzPmKR5mx7Y0iIUBABroDPZhxt09w1IHvsT0zqHJavkcJV9EmRvgDp9WAaSDw0ieJ+qZf/K/QyvNYYGCkRbuG0/BxDFq6oPWPSBJG4QK1BP07K6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854986; c=relaxed/simple;
	bh=JPoQgaS/t3HFTd09aBUhh/TgXSHh06+b57Va1cSIE4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bp1raMa573gGALF+JB8qWt+5hxC1FH3dlWSZIrsg65Nr+Dv4VgiEKAqXGpv6kAiRfOXEF0wPJpFV9La9eJfLCxB3/a42ogYVlsZhYQNiy4i1BopLfeNwUySAf3LmWnr7X3w/1qA01GNvI7GHNHYN9wlTWCYTTm1uZjgHoVxkHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeTpup2X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e83d65e5so76535615ad.1;
        Mon, 17 Feb 2025 21:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854984; x=1740459784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS3SgII/6U7/5mkIGtNBNd4qXYAT6zWaOxbAl9i5SRo=;
        b=FeTpup2X00PiOhKy5rFgER1t5AA6XGANiLOUF0LyCXjSh2uBswzO64DQWyi6/BAymL
         IJI4ATMs6xm80tdDLPofR/U8qH3zl3wApTcgl3s9iXUo2+imHe/6NDKRQPJPvG+oq1oI
         gXLx9114cvS1eiFhX1dVk5K/7w6m+M10OGn451/bJSVY/ghEZ8A1DbKgP9KS9sjiDGAP
         U3peZywmBDxCy1NCmeK4r9U819hGi0hjM9w//Eb+aSRnNfHylN+DSw1mOEd16MhDNdUA
         +SmE7cfWVN9dhTuJbcEHHbTFdvp9S6AHRIRtJdxGHH0uLF1r9Rr++mSd+KM5wlxL3o5t
         Q9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854984; x=1740459784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS3SgII/6U7/5mkIGtNBNd4qXYAT6zWaOxbAl9i5SRo=;
        b=hVcIWic8QEDLP7tBr38WlooJOPbi/SJju85LHgWZk6h4gjDfJ0bokiDQyinHV1t0Rd
         1Pye4Cno4amPTWC59KPUjoFRrN6YYcWMyvHG7nbHyDrlvCCPLZgHK4Uta7IomDWilxof
         5rKKJCHS+nefSLtyGFWAzxX3vh9bNPoVbqwM4mJmW5vD/l9AUPpdOucgMcPw4g1TV69d
         YlAKxrzjm0ny7Pku/ftRCqC4h+lakgaHDRJnjQTk0ZHapyv6O/Rjoz6HyNeUmnhJPO7f
         RaOgNIGzTi/czgf38zXBGvnPK3+WRH711iLOp20yJqkjPA5/Rrm4IxwTeytY6MWRCNN7
         5Ymg==
X-Forwarded-Encrypted: i=1; AJvYcCVScMNsnl/u5mRWVe6vFrG7sTLJVDnJK6hzZZlyMsRokSLo95Zh6IWEu4iXGFUKPmi3zAtRwKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOeLwBzEh2Z5jALRoHn6X8gv2Zz1ymH7VlG+/FOD2lUuIXDKyc
	GUMbcU3rnyRFciFk3RdzA5vuZHY190NhYQgeCSQ2cOfDcxV9QkH7
X-Gm-Gg: ASbGnct99Q2+dlbBh0MwBHs5zuTFbNJcyLIqXGMEhkGEqVtdCrzLMUbzHUexn9kC9FB
	+BOM4PANYImSZj4vapgADL15WAujKGgEMLOZp2RjLk6Rpc+dbcmikuq9CHCCt/E7pAVtskSsFQf
	SjZQDa//x7fxkqvcg8kA9j1Zb8iBoM6Gop8+Otfm7+ummdGn9oSZcbmUlqfRGtb7mdKDgCoDaEm
	5BCIz9ijsh/6CwhI3WMGWi6G4ggVG2rBvb7u3fDEyJzaWGwiigWZXmmHgxLzIQognqQ99CIjyvv
	SdtOKQ1YaG9S3wIIDx97F0qCotSjjjsdqPwOPjXiWrbxi23HiRbFXaoX9YfA6iE=
X-Google-Smtp-Source: AGHT+IEz6xMo41QHYsr+T/pmGF28Lz//2TqP2lecZxbeYMrtWlLLua55udRa0CBPOKX2Z5yPmRWEiw==
X-Received: by 2002:a05:6a21:339b:b0:1ee:c7c8:c9d with SMTP id adf61e73a8af0-1eec7c80d8dmr2248683637.4.1739854984486;
        Mon, 17 Feb 2025 21:03:04 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:03:04 -0800 (PST)
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
Subject: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB callback
Date: Tue, 18 Feb 2025 13:01:23 +0800
Message-Id: <20250218050125.73676-11-kerneljasonxing@gmail.com>
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


