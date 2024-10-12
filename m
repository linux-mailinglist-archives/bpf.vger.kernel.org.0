Return-Path: <bpf+bounces-41801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC5F99B0AC
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA4B2342E
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2712C52E;
	Sat, 12 Oct 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc/Mj5cN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C0A41;
	Sat, 12 Oct 2024 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706042; cv=none; b=jK/C28gcGpveNb1ntg4iAMa+RH8/PidHcYKuHm7pCjwNLmmcSWPE744AN4JajrRRoUF6MEAKpwBUw2NOo8KlYsOKlltEm5QoJdKysK6BLRq3BVh8AD0t2XpvxjuDjb3jRWSPVt7ex5woL4m6uzbIfLlqVbC6BctXX5E81emWNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706042; c=relaxed/simple;
	bh=yDVcNuKpmUuzLhzWpSjCSmxwkZNlvKM9ebIlcVMXVEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uM1nMWKsPRvMrZEwgnqe3xsn9i2mFfVPJZv11HPp3oLKvOskBXgpg/lRhhBTnkk+ilJQqDrTBPdiC8tqNtUZw93/h+XktpbcLb7rjrr3dL4YVWEgPoxiQ8xRO5cHaKXi9zobmUyIRAvp7da/KfkQb8vtgvaHU/7H0DEyo/I7e6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc/Mj5cN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20caccadbeeso11356125ad.2;
        Fri, 11 Oct 2024 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706040; x=1729310840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iExl0TWCr0WCpl/DT2bqOun0j97t9gABBnV9Yni75fc=;
        b=Vc/Mj5cNIKipGTb7th/fsPjl676LSbTJ9/eg4elETLwqjrhMf8AFY/v409dljs6cM+
         A5HIklLR+A1uPFbtheBzOCU7AdzswpWMaK8/zfY/7c13q4Qr+wsP81EgDcRY11rtVj5B
         WFrk7USNJ6iRz9iu9+3FY7NGFZvwItL1oSHaltNAryE5mCIwQuZ931mVsN9LCU/xR6EN
         Hq/dQbBDCb1DOPaEu/y43ih7WaM0DnKTqabLzb+/suSQB2wcjzQeOOlZVBbMOPsyLCJQ
         OqoPjDEq2fr6+15SAMtRDaxlx1OrWN4IbjrxPwba+zM1fLJRrQdDCvV9IRZ43NWXTZnU
         N/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706040; x=1729310840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iExl0TWCr0WCpl/DT2bqOun0j97t9gABBnV9Yni75fc=;
        b=tOKZNJFK8UjQ8KB9V9YLsEOG+6f2DpyF3zNSOZtKXKIDJFShdxxNwg4PIQ4W9voACO
         /K/w5tuKEf8ZmF3ju9j0lhQlPDqghKpNq5ySpU66UHglQ5RDY7krjtO3iGZBSA1ZHQeJ
         m4xkHPQdrklCOdxT+aMF8MXykL9qgQDS3f5unE3BS3hmntEqU8vRSEam6sWqQ8dRpXio
         E87ZOE4eodEHEy3IWWPtkg5Q/SbiOVkt5CrMeM82vmsp/zMgsRwrUpn6s1D7Aphh0vdk
         97arEyqRXW8X3wQisDh/ChKvinfCun9bEwAWEDM7L+a4TQkdwG7q3baqWOHbhquURMfz
         BHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFTnDIhjMBZvkGHmnqEmigmBswX1WDBCtK0pftEGrWV5qNZvdtaDbPLBuf2ggibm0fIehSFB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqutcQy9tbn6EfhokvkxNJmW2XHYBinTdIh9uksF3NkQF4lrBy
	tHRVA2OsrzzQArTcQjj5XRcPT/UXmu4XXBLkHw115b4P089ybwWu
X-Google-Smtp-Source: AGHT+IEutiaFkNyS8KftXpa5gOzRtWwtA5FTZUX0iuTue4MVYg8DtY8TBxxWHh9yKlx+lZLp7JOwtA==
X-Received: by 2002:a17:903:2284:b0:20c:b483:cce2 with SMTP id d9443c01a7336-20cb483d145mr37711985ad.60.1728706040157;
        Fri, 11 Oct 2024 21:07:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:19 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/12] net-timestamp: add static key to control the whole bpf extension
Date: Sat, 12 Oct 2024 12:06:43 +0800
Message-Id: <20241012040651.95616-5-kerneljasonxing@gmail.com>
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

Willem suggested that we use a static key to control. The advantage
is that we will not affect the existing applications at all if we
don't load BPF program.

In this patch, except the static key, I also add one logic that is
used to test if the socket has enabled its tsflags in order to
support bpf logic to allow both cases to happen at the same time.
Or else, the skb carring related timestamp flag doesn't know which
way of printing is desirable.

One thing important is this patch allows print from both applications
and bpf program at the same time. Now we have three kinds of print:
1) only BPF program prints
2) only application program prints
3) both can print without side effect

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  1 +
 net/core/filter.c  |  3 +++
 net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 66ecd78f1dfe..b7c51b95c92d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
+DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
 int sock_get_timestamping(struct so_timestamping *timestamping,
 			  sockptr_t optval, unsigned int optlen);
diff --git a/net/core/filter.c b/net/core/filter.c
index 996426095bd9..08135f538c99 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
+
 static int bpf_sock_set_timestamping(struct sock *sk,
 				     struct so_timestamping *timestamping)
 {
@@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct sock *sk,
 		return -EINVAL;
 
 	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
+	static_branch_enable(&bpf_tstamp_control);
 
 	return 0;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f36eb9daa31a..d0f912f1ff7b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstype)
+{
+	u32 testflag;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		testflag = SOF_TIMESTAMPING_TX_SCHED;
+		break;
+	case SCM_TSTAMP_SND:
+		testflag = SOF_TIMESTAMPING_TX_SOFTWARE;
+		break;
+	case SCM_TSTAMP_ACK:
+		testflag = SOF_TIMESTAMPING_TX_ACK;
+		break;
+	default:
+		return false;
+	}
+	if (tsflags & testflag)
+		return true;
+
+	return false;
+}
+
 static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 				 const struct sk_buff *ack_skb,
 				 struct skb_shared_hwtstamps *hwtstamps,
@@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	if (!skb_may_tx_timestamp(sk, tsonly))
 		return;
 
+	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
+		return;
+
 	if (tsonly) {
 #ifdef CONFIG_INET
 		if ((tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
@@ -5593,6 +5619,15 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
+static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
+{
+	u32 tsflags;
+
+	tsflags = READ_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
+	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
+		return;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5601,6 +5636,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (static_branch_unlikely(&bpf_tstamp_control))
+		bpf_skb_tstamp_tx_output(sk, tstype);
+
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
-- 
2.37.3


