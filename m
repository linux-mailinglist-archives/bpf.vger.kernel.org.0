Return-Path: <bpf+bounces-41809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3F99B0BC
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165031F2409C
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FF135A63;
	Sat, 12 Oct 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Ve4XRf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945314286;
	Sat, 12 Oct 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706081; cv=none; b=M8I2gSdhSXHp7xMnHJj639/zC8xJk1qyDOHhBRzC4t6Pzaf3Dwknj0SXucAu8fMcjwItE1SLJpn3XNtu7uRWmrM8Rttp1cVKltOZ+MkRVX4nY1FYI5FvwZ4hv0/OVwEMvWbZRDwRu1TnC5iggbtYLepNUPVwwWi7n48OsuZv1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706081; c=relaxed/simple;
	bh=qIqMMsuuW7/dMCR/tUJLumUyy1VrwV9j6vcdlyn31bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POcfpd2e7bjtpqsjZCt/2XHUSeicyzUHfH7VS6g0O3veWd52nnD6Erjr9ULLwYWB+tTv4+ZXzA9Lu25Nqh/caq4OMWsoy/lvRFca9u4+5ZY8lKaV2OLBF0R0FFTAOUXT5r7TJEPKv+4AGWHHE2AyqRWByqFLSdcqXh9b3DNHuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Ve4XRf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7edf2872so21137945ad.1;
        Fri, 11 Oct 2024 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706079; x=1729310879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXSRG9m3FKtgekDc3MRYZh3dVuzXvgaCMmLFhQ0EFoU=;
        b=F/Ve4XRf/w2U1Pkk/xj3peo+H2dv0MAN+PCosrkvADEImPUj3kwdAdMsgq1dY9g9X3
         vOvHEYaw0ue9u0H5W0R64HalgiN27yEAgefrtp+pV6r2yJTxprzaYQgyKJiYTMcwtt1Z
         +8Yj7hHbVUv7zySe+Gv19LPnpmDPt/ketrVHhRJTFeb9bYcGjzYjkzFYfNT0efFn6N+9
         La+K50akxeX2FBe98K7aV0xmUTIAoGjF/cRfHgt8/igsfrmMo/weSTgAuTgbhREvt8kM
         Bgccc4p9f/FQj73qD5knaikcTxdYqRTzjKTeX2/Z4xN/sytzJYwOEvihV1xWFDkKF6MO
         sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706079; x=1729310879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXSRG9m3FKtgekDc3MRYZh3dVuzXvgaCMmLFhQ0EFoU=;
        b=Uez4UXCCx1QcURzM4qEyCu7Q5vmMrHgOfWLIooC0CnQIox/HsYjW8NuoZlBZNGabcI
         hwhtz+4v2QR7M6F25S+Pn13nE4q/dQpgk95JlNlzr4JdlwyHKuiYCFTKL0CugU8tFEja
         fCokevwtG9FYJMy27Zp/Pt0tXAnkfIYniw7/UehxQgO3kcH0q50hxWXBuefawYCvq7M/
         Ge1pg+eoUfNG9DQizLhdE5Yh4w0DCM6dKZTcKyzXaXij1BkmSLL8YXorSJaKhZH+xTNO
         /VjLgwQYno4oGQ1wHB7AEnNsaAQQiZc65mviI5o/g/vnaoigl7vIAq92HYiA4Api3awy
         DukQ==
X-Forwarded-Encrypted: i=1; AJvYcCWADXFcaztOSCBALKR+MQ5Pi6j4kwFrSuth9py0O9mTd9fsKdnOisLRquqlGKTZqLDrNKCyvhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlDqcchEZdK7ysaCmrpjEGDZhwucIv1Ux2xvHrZJS4sHet8vr
	AJNm6g8/JA2rECTJtoKKBj5OIIiJi3K9KH60aEwttacyFpF6Sksn
X-Google-Smtp-Source: AGHT+IH3pGZCRY3FoWyBeAj0q9jDDhE8OVwQdVVKndIpPw57a83KwNROIZl0TjUZFCqKELFxVBx/hw==
X-Received: by 2002:a17:902:f60c:b0:20c:5a7b:dcb3 with SMTP id d9443c01a7336-20c8052b62bmr126649005ad.30.1728706079297;
        Fri, 11 Oct 2024 21:07:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:59 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 12/12] net-timestamp: add bpf support for rx software/hardware timestamp
Date: Sat, 12 Oct 2024 12:06:51 +0800
Message-Id: <20241012040651.95616-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to let the bpf for rx timestamp take effect.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h              | 14 ++++++++++++++
 include/uapi/linux/bpf.h       |  5 +++++
 net/ipv4/tcp.c                 | 29 +++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 728db7107074..5a7893379ef7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2676,6 +2676,14 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	u32 args[4] = {arg1, arg2, arg3, arg4};
+
+	return tcp_call_bpf(sk, op, 4, args);
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2693,6 +2701,12 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	return -EPERM;
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d2754f155cf7..3527c20c8396 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7037,6 +7037,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_RX_OPT_CB,	/* Called when tcp layer tries to
+					 * receive skbs with timestamps when
+					 * SO_TIMESTAMPING feature is on
+					 * It indicates the recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0891b41bc745..14bc7283f574 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2262,10 +2262,35 @@ static int tcp_zerocopy_receive(struct sock *sk,
 
 static void tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
 {
+	u32 tsflags = READ_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
-		return;
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG)) {
+		u32 hw_sec, hw_nsec, sw_sec, sw_nsec;
+
+		if (!(tsflags & (SOF_TIMESTAMPING_RX_SOFTWARE |
+		      SOF_TIMESTAMPING_RX_HARDWARE)))
+			return;
+
+		if (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) {
+			sw_sec = tss->ts[0].tv_sec;
+			sw_nsec = tss->ts[0].tv_nsec;
+		} else {
+			sw_sec = 0;
+			sw_nsec = 0;
+		}
+
+		if (tsflags & SOF_TIMESTAMPING_RX_HARDWARE) {
+			hw_sec = tss->ts[2].tv_sec;
+			hw_nsec = tss->ts[2].tv_nsec;
+		} else {
+			hw_sec = 0;
+			hw_nsec = 0;
+		}
+
+		tcp_call_bpf_4arg(sk, BPF_SOCK_OPS_TS_RX_OPT_CB,
+				  sw_sec, sw_nsec, hw_sec, hw_nsec);
+	}
 }
 
 /* Similar to __sock_recv_timestamp, but does not require an skb */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 331e3e6f1ed5..fad942abc36a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7036,6 +7036,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_RX_OPT_CB,	/* Called when tcp layer tries to
+					 * receive skbs with timestamps when
+					 * SO_TIMESTAMPING feature is on
+					 * It indicates the recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


