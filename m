Return-Path: <bpf+bounces-41234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690829944CB
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C21C22659
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6719340A;
	Tue,  8 Oct 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpBXrqkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BC19306A;
	Tue,  8 Oct 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381118; cv=none; b=NVzO8jHrEpbvwQdkNgmVja89GA41o103a6n0EU2MKKoNfDVhF/tzV+FoD8S9Hy4I25ydQK1Qu39ZYmj5ec7XsIDwEGEvej0iGpijc0fcQtznhC5TIXc8x47nx9f0Hm1YHMzUHq4Vd/DHk9TivRgmuURysYsPnDOsEHhZMVqXzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381118; c=relaxed/simple;
	bh=9s9tiUCmpImBPc47pKVxWqPQw0HbL0lnTHINMAEmuNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfrSHfFOetsEyGx7lBiq9i3aU8yqoPUUSFJ15Z0gwrxziks8OvNohNhJ33jcCLnXfKzrv5RDavgB3Oc8fpUXWkdtUwZtRLlb0B1HzW9GFa3nU54A/dqiwiS5NNMTi7kE0zx1XJW/P7uln30ttS7C8IldVfUVRrgHqFrswbJIQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpBXrqkz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c56b816faso4415525ad.2;
        Tue, 08 Oct 2024 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381117; x=1728985917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIhWhCgJWsvdGp4bMg47enlFeTpz7yKdIzPKml3Bzck=;
        b=IpBXrqkz+04LYEbvW1CnD0SeDcq2QAM/ScqDgTZn7k98I074WffEy4Kna5ASWaVce9
         dpEfUyGZHg1TlHnL4TDNPghM7NVTv/3iEB3B1ZGRD4AXwmFiCyfRDGcsK8GbZPNA5GWf
         rmejvm38ZCOi0lP7sb277Fj7Ab6LUNazrzS2Dg/9L1wdwQWJF+TR9TNhRDJCBg1gJwuO
         zQz1JMnE8C8CCp/30UFopRSx9dn8fvoVrtwF0ZhYB2bzlmoceAJnhjWg8ml5iDSlvb4C
         +V9LnaldPrhSbXVOR6ZGYxkPC13WC97cuEeYEn9BCXJYpZewtLJj/RqcaUBJdRBJom5+
         HJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381117; x=1728985917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIhWhCgJWsvdGp4bMg47enlFeTpz7yKdIzPKml3Bzck=;
        b=e9doNbBh7DseilIJZk1aRgH4fp7ao3Ne8xXUqcpjj5S4NaDOmdW/imS2xOIzaO38zr
         2zEXzlfAS986HpWgD0FLETfYiRV2+8MpZh/Ml+FrReght/jt+0wwO9PrkOQ9Mpb+YXDL
         MwB7/BSfkqgbSp+O5iW6ZjbEzF3qPphyo6t34NcWghqdRH9Bn/JlC/hJ5XNs9xJjOJ/I
         9sqNvoq3BNZPMxe1St/6CBssfC/qbTqWtjFYCNagcsp+4BwxBr+Sy8JMGt37gosTJGz7
         rM40VoDl580SwkgjqLtaAeBiOPOJooFTY4n4BPJTPSh0BtiSVbVa7HzZdWPCxMv91TZS
         85kw==
X-Forwarded-Encrypted: i=1; AJvYcCVsiFHXljpNtxCCnDJpl20JFrvrUjSnF1kw/I/HIUm8rvLMioBxBjxys12RwrFtsBZG0Kl8mEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb14zT/mTePE3dmWVm1xL8o6GgrOAupUbOIydg8yuukfSSCteY
	wI+S09Enlx6KY5tdSUvOh58kqlWVnD9HyPAmSOZljntzn7HCqfIeY7+tkg==
X-Google-Smtp-Source: AGHT+IGbZeqMg/RUtIu9e4yP9Z2QIgfcjPygcmyFmZ7EqlalK9G12Uirt1yaXE5WRNcPyxbENMD4cg==
X-Received: by 2002:a17:902:ec8f:b0:20b:7731:e3dd with SMTP id d9443c01a7336-20bfdf6d0damr227314535ad.2.1728381116690;
        Tue, 08 Oct 2024 02:51:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:56 -0700 (PDT)
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
Subject: [PATCH net-next 8/9] net-timestamp: add bpf framework for rx timestamps
Date: Tue,  8 Oct 2024 17:51:08 +0800
Message-Id: <20241008095109.99918-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
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
 include/uapi/linux/bpf.h       |  5 ++++-
 net/ipv4/tcp.c                 | 13 +++++++++++++
 tools/include/uapi/linux/bpf.h |  5 ++++-
 4 files changed, 22 insertions(+), 3 deletions(-)

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
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6bf3f2892776..3c28d74d14ea 100644
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1d52640f9ff4..938e2bff4fa6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2276,6 +2276,16 @@ static int tcp_zerocopy_receive(struct sock *sk,
 }
 #endif
 
+static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
+		return true;
+
+	return false;
+}
+
 /* Similar to __sock_recv_timestamp, but does not require an skb */
 void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
@@ -2284,6 +2294,9 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
+	if (tcp_bpf_recv_timestamp(sk, tss))
+		return;
+
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d3bf538846da..ff17cd820bde 100644
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


