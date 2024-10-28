Return-Path: <bpf+bounces-43288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82D9B2E74
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86028B23137
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4691DF744;
	Mon, 28 Oct 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU9eSi+b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02E1D63C2;
	Mon, 28 Oct 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113600; cv=none; b=SZwMJp14DySZDfAUFgMmZ0mTafPBuGce9dW4g+D4NKiv3k7fZRMx5/kIECSMc1O2SGEsWriqCuYomARgB/pUY3NcwnH19ZMfNWAaVEfF9wZOnBba1DN9NB34MP4COybCcZBhwLIdUwXDpFE3AcLvljgBnPEbz2uz6DCF2NttYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113600; c=relaxed/simple;
	bh=ySuwdMV87AWtr1VxqSWLwcOLY8k1uhHE9g6jUBh91QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mU4xC/gJ0k20VcCnnacBbilU+QsOagrVQyxg5goA9z84H4oUfZUyOwc4sFLYIkvZrvNMhlQ1e3lAI8vtchU4D+r+4qUrYqR6WM4A+cH3nqInz7PLPin1JGRMMKqLGTx4+fKSdR7Q6joKsF5rNHEPpZ0mRbm2FfURJRsox7L90bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU9eSi+b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8b557f91so36789365ad.2;
        Mon, 28 Oct 2024 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113598; x=1730718398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BDPPLPrw1/fTqchv4EoQofqTfNJuNEjYPrOv25d2dU=;
        b=CU9eSi+bAoHQHv7SiTAXR2VSZhHRWpN0a2S5DwcRHkexDSG7zWktMtvJcbn0T7bOl4
         sKPwhNKmc1f91A+rADqrOR1V78qC/7I0TUc+LoUifBe7Xi1tpBPFmS72RL+Xup2fwcIx
         FlwHFHbtKENbHZGyVhplkxXW6pC1RNI5WGA4AycnT7POct3oF+7YoDL7XwzicSSoeDWU
         AnN70ixrgy1RHNBGbgSLL0dMxtake05zTo2wlX/uk3YH+VAJpd8uQgf6+/baKkg0nsED
         TvjRclO45ali82HVEQt0ag1ytThntZIvS/bz5gmbTdICiwaIw95gMVIBcWZ+qyKus299
         TyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113598; x=1730718398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BDPPLPrw1/fTqchv4EoQofqTfNJuNEjYPrOv25d2dU=;
        b=lPQIw0VbU87g0mGeSHYVksuFOMbERaejfTfMnQELy2wRVPFWfjuUqOwDO6hUa13UoP
         TD+xuYR/vYxpOlHhR0jdx6r6EoDj39Zv6BMJJTMOgJLcjcH3eqSjQ6sLGzXvwLvUn+zl
         3SQxm8b78UV23boiEVA19K8b12kREjufkpXcHslO4o+Ghvd0gMiboRkcP1as7Zvc+ENA
         AJA2+KLA+w6ute84TaqFR4qy7GmFqIkxvMOZceBJUrzxbJmzH4EXV8IAEauKkCR6nnLI
         pjKD3OAX5oJYABXsY9xm9QPEflBYFnkD6R+m/axTIf6kcF57OKT3kceG7tC1RVoECqzI
         695Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmHBkLlLzwO1Rbw013lafK2m0L0ONc0hmFRF0IpjfmwJzCji1CN9v4pOxZCoUz0aSPby08DUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTX8Qu/SYV/wPbaizkzmURG4UBRoI9rViynJMVyxM1aRUuvcdE
	tqLIAmxdAJolRfsB50WzoW7qViY2FT5k7+UECfD/hlSxUExewnyF
X-Google-Smtp-Source: AGHT+IHTG6q/BJ3iOrUGFVqhqIVWDERZQa46oRt9o8vCvmkSqWx+Ttgv+5uXqa2GjVxyW+NniTIs0w==
X-Received: by 2002:a17:902:ea12:b0:20c:c9db:7c45 with SMTP id d9443c01a7336-210c68dd56amr104043585ad.20.1730113596119;
        Mon, 28 Oct 2024 04:06:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:35 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 05/14] net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
Date: Mon, 28 Oct 2024 19:05:26 +0800
Message-Id: <20241028110535.82999-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the skb is about to send from driver to nic, we can print timestamp
by setting BPF_SOCK_OPS_TS_SW_OPT_CB in bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 19 ++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 324e9e40969c..b0032e173e65 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7018,6 +7018,11 @@ enum {
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
index e6a5c883bdc6..e29ab3e45213 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5640,8 +5640,10 @@ static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 }
 
-static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype)
+static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
+				     struct skb_shared_hwtstamps *hwtstamps)
 {
+	u32 args[2] = {0, 0};
 	u32 tsflags, cb_flag;
 
 	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
@@ -5652,11 +5654,22 @@ static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype)
 	case SCM_TSTAMP_SCHED:
 		cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
 
-	timestamp_call_bpf(sk, cb_flag, 0, NULL);
+	if (hwtstamps) {
+		struct timespec64 ts;
+
+		ts = ktime_to_timespec64(hwtstamps->hwtstamp);
+		args[0] = ts.tv_sec;
+		args[1] = ts.tv_nsec;
+	}
+
+	timestamp_call_bpf(sk, cb_flag, 2, args);
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
@@ -5667,7 +5680,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
-	skb_tstamp_tx_output_bpf(sk, tstype);
+	skb_tstamp_tx_output_bpf(sk, tstype, hwtstamps);
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 324e9e40969c..b0032e173e65 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7018,6 +7018,11 @@ enum {
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
2.37.3


