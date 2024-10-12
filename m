Return-Path: <bpf+bounces-41808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761A99B0BA
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A342815F2
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416C136328;
	Sat, 12 Oct 2024 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXIr2KH1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397512C526;
	Sat, 12 Oct 2024 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706076; cv=none; b=Qie5LB+SMI7KKGgBIQE2IE8yRv1GLupTBvYRPASF7j2sRr5mxrVd5a33BlGc7VM4WlZ3ekIRlDPW+MFO1hwjJ/DEgG18hOqYiUQ86pYel/LpkO2XSCufHvVxEgAk1x0Wq88fqTf3yzd0lpyEakXclJniPuFp5oD4ISYkPWnyUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706076; c=relaxed/simple;
	bh=Ka2TUReOnfu7Vc5byOS3a3IpkLzeL0ivzs2vSdAKqQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+zNpYtCsr5kZzisyNTFRjlae7seUB4SR+vH4+h2JWTHiJlBf+LGZZNaVtuDMp4xAFJ0L3rj7Mg5phpo0lgISQds8XDYP7ZX5htrwd2iAjd7kpp4v1oX+Ks6BQw+kZfaIiDWb2liTIL8LryfnCtv+XdVHkYNrGxZQNTolVGLh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXIr2KH1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca1b6a80aso11021685ad.2;
        Fri, 11 Oct 2024 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706074; x=1729310874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzBpETB03ZUe/110lcAyhd5MMiyuu9Scyituu4R86q8=;
        b=kXIr2KH1rTZbC0vNgL8MYbTfF3PpXsjUpBQoaF0pk055rfn2EBqnwk8NIAI7wxEYxN
         xNOz8QAJQ1c978cf1GoSJdHEhumXNXnMBJHiXzU4nsBISQT2daE/mqtzbXLHoMN9BH+Q
         g9fcwjblbgWlIdNJwgLqqKkX5xsaIi3z4EEbBvcYmNFZqjFqtn7Q9SmUDEHQ8/xtPMQg
         R6hFR+lIWOlyYroeuov90U3L5txBnxnKH6620f2FRmqS3qXt1H4+G5/Xi5w4sm1P4Zlx
         GMMUJTJe4WtsWqUSCKBQ9oVfbEx4fBkv55gBhJsW0TJxL3I7wQrB6/rOfxVwANuBGb0P
         66Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706074; x=1729310874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzBpETB03ZUe/110lcAyhd5MMiyuu9Scyituu4R86q8=;
        b=PSk1YD/u/4pEXt7ZDJfRTpxYxeHuxJo7viuPR7iU+wOZ8zc9yVKsAprYCjGDV+pc6i
         IaOmpzUcBaHnwxh+lZ+RjHDgKLxE2PAEnaF92DHZ28nWkqs8lK6o9VtPkaXMvD0hCIRG
         m2MAWprVDF7D/JWZB6hOUQbUCZLT2fy8r4nLULrSscurZenUTVWBm1FGR5I3ljc6ho41
         Mia+p1VEjjP9u1mmN8RiP0Niz5FdD5b74AgsjiOHBAxFqgvPGdLY5nCjT4wMhlpBGgIW
         28jZS2VLgh/7E0DqVt4RJcziBM0IGxPa8GKHVB9FdPHIgQd787hmSqL1Vg1t8cDUdpnH
         bv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXev3ysUSsksLr08iVFgvZ1SSTac2CuJK9bdEvi5PnmwlgIkJhsXgYzJWSMQxgjhDvTFXahNlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytzDrox1eRd3NYeVt8fsPdyeMiu1SSPdGA+cwte0/lElJ148aC
	0QLGqTtUyBAxqFu1VDRQuAXnURFgxG5htAm9iyJAuqz4pj5q62wo
X-Google-Smtp-Source: AGHT+IH18q3JtvyXGNgLAW2lweTyBJSfRvx/c6MUPbcvtqEaLXV6r7RwkT2v/QbZlXGmiblZHe8yiw==
X-Received: by 2002:a17:903:41c2:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20cbb1c407emr26860265ad.35.1728706074424;
        Fri, 11 Oct 2024 21:07:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:54 -0700 (PDT)
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
Subject: [PATCH net-next v2 11/12] net-timestamp: add bpf framework for rx timestamps
Date: Sat, 12 Oct 2024 12:06:50 +0800
Message-Id: <20241012040651.95616-12-kerneljasonxing@gmail.com>
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

Prepare for later changes in this series. Here I use u32 for
bpf_sock_ops_cb_flags for better extension and introduce a new
rx bpf flag to control separately.

Main change is let userside set through bpf_setsockopt() for
SO_TIMESTAMPING feature.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/tcp.h            |  2 +-
 include/net/tcp.h              |  2 +-
 include/uapi/linux/bpf.h       |  5 ++++-
 net/core/filter.c              |  6 +++++-
 net/ipv4/tcp.c                 | 13 ++++++++++++-
 tools/include/uapi/linux/bpf.h |  5 ++++-
 6 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..e21fd3035962 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -446,7 +446,7 @@ struct tcp_sock {
 
 /* Sock_ops bpf program related variables */
 #ifdef CONFIG_BPF
-	u8	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
+	u32	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
 					 * values defined in uapi/linux/tcp.h
 					 */
 	u8	bpf_chg_cc_inprogress:1; /* In the middle of
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..728db7107074 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -423,7 +423,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
 void tcp_update_recv_tstamps(struct sk_buff *skb,
 			     struct scm_timestamping_internal *tss);
-void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
+void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
 			struct scm_timestamping_internal *tss);
 void tcp_data_ready(struct sock *sk);
 #ifdef CONFIG_MMU
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1b478ec18ac2..d2754f155cf7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6903,8 +6903,11 @@ enum {
 	/* Call bpf when the kernel is generating tx timestamps.
 	 */
 	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
+	/* Call bpf when the kernel is generating rx timestamps.
+	 */
+	BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG = (1<<8),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x1FF,
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/filter.c b/net/core/filter.c
index 3b4afaa273d9..36b357b76f4a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5216,14 +5216,18 @@ static int bpf_sock_set_timestamping(struct sock *sk,
 		return -EINVAL;
 
 	if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
-	      SOF_TIMESTAMPING_TX_ACK)))
+	      SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_RX_SOFTWARE)))
 		return -EINVAL;
 
 	ret = sock_set_tskey(sk, flags, BPFPROG_TS_REQUESTOR);
 	if (ret)
 		return ret;
 
+	if (flags & SOF_TIMESTAMPING_RX_SOFTWARE)
+		sock_enable_timestamp(sk, SOCK_TIMESTAMPING_RX_SOFTWARE);
+
 	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
+
 	static_branch_enable(&bpf_tstamp_control);
 
 	return 0;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d37e231b2737..0891b41bc745 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2260,14 +2260,25 @@ static int tcp_zerocopy_receive(struct sock *sk,
 }
 #endif
 
+static void tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
+		return;
+}
+
 /* Similar to __sock_recv_timestamp, but does not require an skb */
-void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
+void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	u32 tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	bool has_timestamping = false;
 
+	if (static_branch_unlikely(&bpf_tstamp_control))
+		tcp_bpf_recv_timestamp(sk, tss);
+
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fc9b94de19f2..331e3e6f1ed5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6902,8 +6902,11 @@ enum {
 	/* Call bpf when the kernel is generating tx timestamps.
 	 */
 	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
+	/* Call bpf when the kernel is generating rx timestamps.
+	 */
+	BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG = (1<<8),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x1FF,
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.37.3


