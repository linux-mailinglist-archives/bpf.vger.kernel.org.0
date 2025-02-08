Return-Path: <bpf+bounces-50855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F4A2D582
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5875F188D558
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD131B0F32;
	Sat,  8 Feb 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkReZ84S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04893192D8E;
	Sat,  8 Feb 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010762; cv=none; b=gMgJmstrAWUZVd6d251F0Vki1eXiDADbITBleXauN8uudBZ9ygcFvpAN4ihOUeOZEYEOagtFuXwud3zKayobhM1Vk+JdyS4PPEcimux2lAVp+aya/emrMwTcexO+zN5jhpvsTGVfNkFlRXIROgMMpscYD5SlIYPNMS8IGYtapyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010762; c=relaxed/simple;
	bh=r4VaYJrwHCXDlAcfMr7sr6lS0pk7V2NSw4LKzmX9i5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYOxpv3H1nVkbGfi1NhwVby0rOkP85OgYD8CXQkxbPhtb2hMMu1CP+q04K25aBDIMxuWe2doZvr8dD1cI71LQHNoLcO6kgvGLPN6RNmpu3SPyzFe2/tOkCrnnvaHT6P4N1D+CCpqJFLpZanbS4Zn/bTCuJ5Nq4wdCelkx6I375s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkReZ84S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f4a4fbb35so33156825ad.0;
        Sat, 08 Feb 2025 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010760; x=1739615560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM0Dc99ZK+Ah2fMPgdFn/MAVtyk4O2Sk7UtUiTgjHeU=;
        b=NkReZ84S4VauNZI2oTtxfR/iHzw/AxnkPXfvzCExlI0g3NE8zzlqm5NToV+B9IYlQR
         d7m0dKGVKThlGr24Iyjxkyc+JGS5bYUOHhV1i926UHCBeqYqx9bXn6drhg9nAwPgMeoc
         j8zIkD9EhuTynbeFJZrkO0HLWqaOvKrmjPKjVxNCNx4WXI19V7CTQPVVGfyyBic1oFaU
         RXgHVVszVHtM/N4wZScvYEFKghhaqVgLmbAqsURnIA1OORF2Rq7bhyU6ZQ2v4zDYTNhk
         4wF0AtmS1RD8zOPfQY1amtKchnVRCUTXAxsTqixNkJPGk0CMfdzSFdVjkeavEFVUKsah
         dxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010760; x=1739615560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM0Dc99ZK+Ah2fMPgdFn/MAVtyk4O2Sk7UtUiTgjHeU=;
        b=VR2fCm2cSLo5bG8NW22L/YmJ5HR6NnyJPqtOsGRROROXr0IOKLiYso8c0W7i0UJClm
         sW9YwLjs6Oh30BSgFpuLcrVQz8pmZ8lxpD/UZHA/qaJHy4mdf0wCac+BmnpY6UnyrGkh
         tbQ011+zV+jGBIFXvt7SgGP+P9FeoAomJ/uhBOMt2C30SJvtFXAT7Z3gKU002dwbPseG
         sEW29EbU4u7ecbfrMm2d2zNSB80bw0n3pfBQ1yPZXCvr7q74ZVYok7u/0jK0nbIKn1dB
         RDlIXq1VD8aY6i5qVhT2aOyOvq0O+LFkta4i5UEfW5m+DdcPUHy9aLJAkRm5fpr6B715
         YGpA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwZdNB4EkkID8g4R6f6qLjpsvcsXGr4E1H/LDre+w8K+pvL80S/0C2mL8hkTacjWSH0aqlfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySMcrpJ/o68pUIFYDgERAjShxDw5MWzQPN7Y5bLj+ZsYIFlze
	1jw5alCSkL67tHfEw4SFSx2/bYMc8xUEDrsiKeBzpiG5IkjzOW33lUw14VUmqwQ=
X-Gm-Gg: ASbGnctwipURYyG4YrpiCoMIjkXpPzMzz1gT54TXgiezSJmIK4U0RH6qKrBbP/m4Jlk
	gAN6HzY+AMIlCwCbzdWTrxVCWaYCQq4Ed+kn+YvkS2Y4WfhMoH84bvAkC+/Wapv19lNdTQHZzbK
	0uqGh4MCewhtGmgiRaKG4g5Bs0LuxY56glpyTsWTcyllntlEaokg9+TmmLtPKJ0yGoBoPBR+rW7
	Ck5t8Q+iBMAeVlzGyipRwQpnns2jFeq4gz1LbOm3RinYXi6N7AcjfMpBxTK7b7aQeWvune92/S7
	lNDhnAsVmcFW5DEeLMzT2EX4nZ45BF/hihsVObNy/c/y1zbdDY3NGA==
X-Google-Smtp-Source: AGHT+IGgSiVktLlqw0nSJT28srkIGTZ5xlwxIo9az+0pFTqB/sonF9/JDP6rar2LVl+mLfj+fw5KTw==
X-Received: by 2002:a17:902:db12:b0:21f:65b0:de38 with SMTP id d9443c01a7336-21f65b104c0mr43348365ad.21.1739010760140;
        Sat, 08 Feb 2025 02:32:40 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:39 -0800 (PST)
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
Subject: [PATCH bpf-next v9 02/12] bpf: prepare for timestamping callbacks use
Date: Sat,  8 Feb 2025 18:32:10 +0800
Message-Id: <20250208103220.72294-3-kerneljasonxing@gmail.com>
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

Later, four callback points to report information to user space
based on this patch will be introduced.

As to skb initialization here, users can follow these three steps
as below to fetch the shared info from the exported skb in the bpf
prog:
1. skops_kern = bpf_cast_to_kern_ctx(skops);
2. skb = skops_kern->skb;
3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);

More details can be seen in the last selftest patch of the series.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7916982343c6..6f4d54faba92 100644
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
index eae2ae70a2e0..41db6407e360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
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
+	/* Timestamping bpf extension supports only TCP and UDP full socket */
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


