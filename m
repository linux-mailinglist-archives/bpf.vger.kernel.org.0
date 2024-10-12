Return-Path: <bpf+bounces-41806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3E99B0B6
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CBFB21CF4
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70712FF9C;
	Sat, 12 Oct 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKNFEs8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0512BF32;
	Sat, 12 Oct 2024 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706066; cv=none; b=iwOh93CgqTBzU9fm1LgVG8Sj73YSTJ5cp1NsxWfj8ioHcut7AtDFgfh4HJUIDJKexjF49qXwyeo0g8QEvrK9Eocvpk8YiueFu4QnhiNyMkJKO/h6eKKb3MVGoXw89C56X5S58yfxUA2qAQGUrZR4ULF4b26/mk4NSjTEBq+7UPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706066; c=relaxed/simple;
	bh=kl0TitCeRlKaF4j98gdO50FA5YE6f5jA4tDxlmzCvKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uD9R1Rd1V/qhwnS1uYPrD8Tuf9Ejqa6k5hQIA/fGsDv4K8t7QG8Wh5qbsMhdsTBpPAMyCDRyEpvBoY+EMFdGL+8FJ4GBkXsWMP15E/T40PwrnDzrH+GwK8iUo7uUtpPo/FEmZydibwkxhrlgf/mSoGmidoJC3kCJxVEs7H3zX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKNFEs8T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bc506347dso21532665ad.0;
        Fri, 11 Oct 2024 21:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706064; x=1729310864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44HcBJ9zqFTsxi7lWcBcBpv3nz8LXm+r/QFBaxzQLOg=;
        b=eKNFEs8TAb7s0pHGYVolyOG9vCGog+jjJhWNG1Mtf9ta9w3Ksu5/+ZSmKPHPXH+T+5
         BuaLIPQgJWSp/v1ts4mumKCN4DO1i2E4JMMPDrQIevhpk54ycrY8duLi1tJI+Q+ZRONH
         4hSnJ/0jwAHzOfCapGgCklnXKPWQ48X4eOex2HpgGwXOKf/tSX7viOc6I97L641b7tB1
         p0beEiXKMmiibPaVnl6CI1J0wsj1jX7VyKhA5YVqtwNHfXrOfZkXhnNoV/gFdOqfWstq
         efdXVmK3/DmZSpnsXO4K3MkE7IWnHEHZWBQMyPAeFX315UB4fsx/NvSlkwC6BxjKfCN/
         NgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706064; x=1729310864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44HcBJ9zqFTsxi7lWcBcBpv3nz8LXm+r/QFBaxzQLOg=;
        b=rLVPqtnt1JtuzFzjAwy8IBLJh+Sw2mcS0bYhinruVqiuoLWLftANU+u7QjhmGo9QdX
         ueNnNcfMHkwqAxarFmniGUU6fHZF3aBF0GKyqASP8EtuEXREbAlOHFZUFEWxuAH2T5VI
         8dAXBx+BqfC68i/DX3wIGYlsWBQK+CgcCCV1IcjDZEW6yEkRIBIT50WJH0CWj9SsjR1C
         vNNaXuTeNkFHN5ZU1xo5hP4weEkKBgDmXXdgDeiJdlrC96ZGbZFv1t4AOuBJWS4zqGha
         7p4vvIlcwihd255fjrtGw/4OJXoowVTqaMJ8LEyEiRVMubJZIr9QpipxWj5CYOyLNpqr
         +QDA==
X-Forwarded-Encrypted: i=1; AJvYcCUgFG/Bw0KUaANJ6HKuvOdCvwK4jQgVCkWBUCW4418krZB5E/3gFfvs9HFlewtWeYb9+7KdI3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7svwa9tXORHMbzLbKT0V663RLYQDJOpvbAPaxLixIo0oiuogi
	u83rLF2pLsMvYHDyB9KqVC4pqJnCB6xxJA4NY+kwBZl4gVjNrWqN
X-Google-Smtp-Source: AGHT+IG1rBVFLVHyXF9Ks1TKkJIlsW22bQG+83W/5r/WH8eH5CMaUxRYN+s2LJd0GcHnGlWkoDtOlA==
X-Received: by 2002:a17:902:d501:b0:20b:c1e4:2d5d with SMTP id d9443c01a7336-20ca1677e53mr71579595ad.34.1728706064432;
        Fri, 11 Oct 2024 21:07:44 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:44 -0700 (PDT)
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
Subject: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP support for bpf case
Date: Sat, 12 Oct 2024 12:06:48 +0800
Message-Id: <20241012040651.95616-10-kerneljasonxing@gmail.com>
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

We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
from each sendmsg. We only set the socket once like how we use
setsockopt() with OPT_ID|OPT_ID_TCP flags.

Note: we will check if non-bpf _and_ bpf sk_tsflags have OPT_ID
flag. If either of them has been set before, we will not initialize
the key any more, or else it will affect the existing printing
from applications or BPF program behaviour.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  1 +
 net/core/filter.c  |  5 +++++
 net/core/skbuff.c  | 14 ++++++++++----
 net/core/sock.c    | 29 +++++++++++++++++++++--------
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b7c51b95c92d..2b4ac289c8fa 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2893,6 +2893,7 @@ DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
 int sock_get_timestamping(struct so_timestamping *timestamping,
 			  sockptr_t optval, unsigned int optlen);
+int sock_set_tskey(struct sock *sk, int val, int type);
 int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 08135f538c99..3b4afaa273d9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5210,6 +5210,7 @@ static int bpf_sock_set_timestamping(struct sock *sk,
 				     struct so_timestamping *timestamping)
 {
 	u32 flags = timestamping->flags;
+	int ret;
 
 	if (flags & ~SOF_TIMESTAMPING_MASK)
 		return -EINVAL;
@@ -5218,6 +5219,10 @@ static int bpf_sock_set_timestamping(struct sock *sk,
 	      SOF_TIMESTAMPING_TX_ACK)))
 		return -EINVAL;
 
+	ret = sock_set_tskey(sk, flags, BPFPROG_TS_REQUESTOR);
+	if (ret)
+		return ret;
+
 	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
 	static_branch_enable(&bpf_tstamp_control);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e18305b03a01..1ef379a87f88 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5619,7 +5619,7 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
-static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype,
+static void bpf_skb_tstamp_tx_output(struct sock *sk, struct sk_buff *skb, int tstype,
 				     struct skb_shared_hwtstamps *hwtstamps)
 {
 	struct tcp_sock *tp;
@@ -5635,7 +5635,7 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype,
 	tp = tcp_sk(sk);
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
 		struct timespec64 tstamp;
-		u32 cb_flag;
+		u32 cb_flag, key = 0;
 
 		switch (tstype) {
 		case SCM_TSTAMP_SCHED:
@@ -5651,11 +5651,17 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype,
 			return;
 		}
 
+		if (sk_is_tcp(sk)) {
+			key = skb_shinfo(skb)->tskey;
+			key -= atomic_read(&sk->sk_tskey);
+		}
+
 		if (hwtstamps)
 			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
 		else
 			tstamp = ktime_to_timespec64(ktime_get_real());
-		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
+
+		tcp_call_bpf_3arg(sk, cb_flag, key, tstamp.tv_sec, tstamp.tv_nsec);
 	}
 }
 
@@ -5668,7 +5674,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (static_branch_unlikely(&bpf_tstamp_control))
-		bpf_skb_tstamp_tx_output(sk, tstype, hwtstamps);
+		bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamps);
 
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index a6e0d51a5f72..c15edbd382d5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -915,21 +915,18 @@ int sock_get_timestamping(struct so_timestamping *timestamping,
 	return 0;
 }
 
-int sock_set_timestamping(struct sock *sk, int optname,
-			  struct so_timestamping timestamping)
+int sock_set_tskey(struct sock *sk, int val, int type)
 {
-	int val = timestamping.flags;
-	int ret;
-
-	if (val & ~SOF_TIMESTAMPING_MASK)
-		return -EINVAL;
+	u32 tsflags;
 
 	if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
+	tsflags |= (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
+		    sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
-	    !(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] & SOF_TIMESTAMPING_OPT_ID)) {
+	    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
 		if (sk_is_tcp(sk)) {
 			if ((1 << sk->sk_state) &
 			    (TCPF_CLOSE | TCPF_LISTEN))
@@ -943,6 +940,22 @@ int sock_set_timestamping(struct sock *sk, int optname,
 		}
 	}
 
+	return 0;
+}
+
+int sock_set_timestamping(struct sock *sk, int optname,
+			  struct so_timestamping timestamping)
+{
+	int val = timestamping.flags;
+	int ret;
+
+	if (val & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	ret = sock_set_tskey(sk, val, SOCKETOPT_TS_REQUESTOR);
+	if (ret)
+		return ret;
+
 	if (val & SOF_TIMESTAMPING_OPT_STATS &&
 	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
 		return -EINVAL;
-- 
2.37.3


