Return-Path: <bpf+bounces-52049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC8A3D240
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEC216F569
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B36B1E9916;
	Thu, 20 Feb 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SucWRgmb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACA1E7660;
	Thu, 20 Feb 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036603; cv=none; b=s4lcQqvEZojcMk3oXrqYyXSuh3Q9+w4QiWLEefzr+DmwpixzZuPv7z9VMukgQC76HbPrZKVa6A86KUzfAeoUpIurpRAuBdRID3ZXMG4SWhgaT14keE/aOhSq1aGKG8FcPrf8ywQWirbO08DhPSmncN1lr6ybfx9fA0rblky8+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036603; c=relaxed/simple;
	bh=fdGpchZoGSlb5vKPY6i549xOdFj4Bj/Z/DVhj+lTEDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K67PBgfrqNuXc7yb7igwPZIyoswgH9iGlROXBkdkqU2fBrjqjgxPWTAj9fC3AScUWqoMQjVruSNTcRiE5LlC7uO5wk3dHuCx9fSeYaFjJqpriqECewFcl+lEeMIhCpYG8vX/Qng76/ZmwpfQaFeZxP7qBo+5I5WS8KXTyEb3GMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SucWRgmb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211acda7f6so11120605ad.3;
        Wed, 19 Feb 2025 23:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036601; x=1740641401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pssKYgW/7sA/8gWm1fZ533hOVjuNqc6I9BqF6wMFUD4=;
        b=SucWRgmbfeQdsnd3SCp/9+0pI8z5ktltxbrYXd5gnUT1tlWUpmdaf+fJPd6Ypc3JuB
         XRUsAZTdIQZqOKUH7xRSCBtdt5PvjyQJyafAI31pwFeRizpWu+2TiJ1zazIO6onU2ycv
         KxA60mcV8VE8GYFfIE5f3Z/3Yt7AP5owwZINBqMN/lWufHEF/t2nK0y85cLQXlQ8m0Rr
         qGnMzpouJWdatRIsyHrT6TAMc86JAHzyD1S6v8fo8R0BrOEIsStpbTcLw+L5clLBMuKz
         axeL8k/LuwxKi7TMx9GECBIHydAEUy5XlJZ8DzVU3LPg2ckVm8gkJA3U8U8gk44p6KFW
         BfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036601; x=1740641401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pssKYgW/7sA/8gWm1fZ533hOVjuNqc6I9BqF6wMFUD4=;
        b=m5CUYpQAg9I37myKemPOadwl73XtK/+LRBVa27usIVLQidkE4XZSY9LpXK43f51o/q
         m+g6RaSScCV1QNE2cTvXGbsYuffxPO116M2zASy6hxLXrc3sk9lbd4HrBuGGtoX1bolL
         /sRdsaVjJRW271dNnXmXDrsnOUZcTBDEiMiw+VhnwqfPRoS7JmRkDjr5KtShMNTpeYdH
         LQDGCwWiEswuJVqMBBqD/w97nYagpPEEKOWEgH7/vFIUrucbvbcrg7F05ypiwvTUKqmk
         o3pdKCYqerHriI411jwI4ckkak+rDr6RZlSCASG2f1zMNpMLVr/fyZMYTocMCLNtFH4u
         3BLA==
X-Forwarded-Encrypted: i=1; AJvYcCVVR7+ZFvCb4saM/1/SyO+KV95KSnB1wWEb5B/qD43frxP3Ph1DgM7NFP925ySYraPvI+fkoDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgy6UYnR5nFM/SIEYsqYS77FC00SmTy+N6opXhBbNKrbuQjDtU
	AgPLKgzgzehB2vYgiauSdIlH9/bEtzpZAn21QAaueXiJhoCLvrdk
X-Gm-Gg: ASbGnctci/T4PFwaVxZXy0UeqdJ9ugJiRVcuY3PEWZtzQ9Al5u4gSoApUEIK99TGH6N
	ALmPLdvGY3bNTqmkmHDFO3cFZqu7h2AV03cmSVverX34ygH7+Ow7Kfjn1OdYJhkx0Lfwpt+XAvd
	hfvLQZljodcGIzHJLcT2VwgvC3AOZ5W9jgJb7ioQsl9lxbbJgKYXyPzVwWz1riB3bsjCFYn6fhx
	OveL0ftVfBWWx3dhTu3OJq0L/dJ18Hxc7pxYXZIc/7KTC+sbhrd2/Br8XK2s/ztcQeLpSgKswij
	eOvo9uv5nbW14V2mqeJITDetyulOQufamwRNtB9w1CIKZH9VdAUOhOjuDSQOs1A=
X-Google-Smtp-Source: AGHT+IEoFsdrY68TSvtv3OsJixPWIjk8QRDN5vMaNZ7SM5Pew0tDYfINcWqqksvjl1YGVMAv/Ywaww==
X-Received: by 2002:a17:903:2346:b0:220:d81a:bebf with SMTP id d9443c01a7336-2216f43f09bmr106926875ad.0.1740036601390;
        Wed, 19 Feb 2025 23:30:01 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:01 -0800 (PST)
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
Subject: [PATCH bpf-next v13 02/12] bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
Date: Thu, 20 Feb 2025 15:29:30 +0800
Message-Id: <20250220072940.99994-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new bpf_skops_tx_timestamping() function
that prepares the "struct bpf_sock_ops" ctx and then executes the
sockops BPF program.

The subsequent patch will utilize bpf_skops_tx_timestamping() at
the existing TX timestamping kernel callbacks (__sk_tstamp_tx
specifically) to call the sockops BPF program. Later, four callback
points to report information to user space based on this patch will
be introduced.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 870c3672d9af..9fa27693fb02 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
 void sock_enable_timestamps(struct sock *sk);
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+#else
+static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+}
+#endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..bde45569d4da 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


