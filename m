Return-Path: <bpf+bounces-41803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7699B0B0
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5370C1F23E35
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFCF14286;
	Sat, 12 Oct 2024 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njwc6BG+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF0126C05;
	Sat, 12 Oct 2024 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706052; cv=none; b=IIVeaqDjh8mt59/AlIF7JRnf0B5rpI3q63S2mQUrGjI/O/9b+VQZGWEDZ7bqU3q0Df9qZ3X3vJSamQmaYlDzvToSf30dRa+YKqxyU/eUm5UtajCOX963fjWHsthBiI23uNX9E+dJZ3n/Sgn/1Z5X4aT82Pp+JkihHqf3HXZtLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706052; c=relaxed/simple;
	bh=mRjovR8ntaoJYkJ37dbujZTNw4gAKlf5NfpDDO5l9Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fvg24u5yH+021O2icvnsd6Gso9wVkxM2aB6Vrb9GdjLEQXQ67ShIANBOIbVFvQwG1TKpJ3pv/7p/GOWIdn2cuRa5YOmclgD1hja4W3JQXFZledxmyiXbrev7zC2FLaTnDqEmyBIBYY3kfFAoShBgFhIUbPY0AuMvOWbC4oBfDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njwc6BG+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b5affde14so15896455ad.3;
        Fri, 11 Oct 2024 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706050; x=1729310850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFTdxQiqpD6DA4ro2hHwuejKJqrt64jz2yhwwbkz8zI=;
        b=njwc6BG+2yMx0bTqw8UnU3UtO6YXgXKL18XC5KTsfNQusK+C4FcmNoEhmc/7mf9JKZ
         urRK1C5BY0VcQdpMDGO6lFacG1WbTamnGlX05mTI+tZIS2aSvNUm989RdxbfkQx3GjlF
         fKnK2kU25u+TnUP1xp6QQniiO9Vjv/qW1jjJS2opwedvOoODFPZxl5CKrIgbLMqkMvmC
         xoRlDOoHuUMzBHBHWeTdpmlR2D2q1HsOsT4lyZnyYXjVpFGM5U3AuxGhoLPlOu+8ghJO
         oiVmXjVycZe5QXucHMXEpTXNksfIipIpBo90FICBGRWFguAp83KaYDF6N2s/cHCcr+nE
         3h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706050; x=1729310850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFTdxQiqpD6DA4ro2hHwuejKJqrt64jz2yhwwbkz8zI=;
        b=aA5yZ6X1Libr0Q8NKtIzSj/CNtL2fWWlcwB6/qrb8mjyzfEFuUTaGRdAUuqHLLTLFX
         ELHyps9S6Iylst9nXLPZJHQ+FxS5bYfuiZCEx3gem1SMFzNW2w+lattw0DwWJk96Jqr6
         WAlwT7+BYw0zaP+dq19tgfisWMN9O27p4hXpfYAnaUuKQG/KKrEWmFax1rPh4zYlj7nL
         wve7ie/ybcOIf0hp09EqTRwnWI0F7RevQS+E0xfpvQB3oV4sCs621Dq0nNdXgeezVe5Y
         zmgNMC6S+ibe4JGmzs24b4hx6Imz0Ujaj07T2Nvw2c7anmEfyyavwPe1RNvg03bM02i2
         Pjvw==
X-Forwarded-Encrypted: i=1; AJvYcCVTDlO7NedsId/FR8cp3pk0Cnn/EE/ofoKtuRrRyx2VmGyaHdaJ3ysSq647lPL6Qmx50lpGFek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6+rayl9ESPJRlggsaadQzUrynI/3ZCOcV4XXOecZM1Hzk5Wr
	IiSN91LmeR1VayTqmHZtfuClL/uQXssePMVomaeY8V76xmmTX+wU
X-Google-Smtp-Source: AGHT+IFuGTd5fokqCVQPTgb9Xho914vTtq5dKo8iOrPse1q86SXIcu5RQpjb7XllQyWVYfiVpdVlxw==
X-Received: by 2002:a17:902:e5ca:b0:20c:6f6f:afe5 with SMTP id d9443c01a7336-20ca16cad0dmr71115575ad.50.1728706049811;
        Fri, 11 Oct 2024 21:07:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:29 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/12] net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit timestamp
Date: Sat, 12 Oct 2024 12:06:45 +0800
Message-Id: <20241012040651.95616-7-kerneljasonxing@gmail.com>
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

Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
print timestamps when the skb just passes the dev layer.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 17 +++++++++++++++--
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 157e139ed6fc..3cf3c9c896c7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7019,6 +7019,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3a4110d0f983..16e7bdc1eacb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
 		return;
 
 	tp = tcp_sk(sk);
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
-		return;
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
+		struct timespec64 tstamp;
+		u32 cb_flag;
+
+		switch (tstype) {
+		case SCM_TSTAMP_SCHED:
+			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
+			break;
+		default:
+			return;
+		}
+
+		tstamp = ktime_to_timespec64(ktime_get_real());
+		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
+	}
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 93853d9d4922..d60675e1a5a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7018,6 +7018,11 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


