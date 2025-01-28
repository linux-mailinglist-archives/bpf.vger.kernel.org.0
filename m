Return-Path: <bpf+bounces-49933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E958DA2066E
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54232168D82
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8131DF752;
	Tue, 28 Jan 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0rYk6tr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1B1DED73;
	Tue, 28 Jan 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054009; cv=none; b=bGWRSXu/HGrJfi0aSr+00KHZFyS1K5Y8i2z6TbpIddp4bwX3Y8yD18bhND1NKYTyYKo+q3y82ehSsiIqsr+bMisu0lGeAbU6lNF/2u/YhplG9kJfaTAZ51Yx4Tt2F0xdsBLap6UMecaV70bIevUTGJz+vn03X2s453eDl1+NdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054009; c=relaxed/simple;
	bh=9wh26/MXjHI/IdCoIuwtAX4FzIaDdiPAMzB0iAcmueM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se2Jyj6GrId5fjOa0l9fnVqUQkz/JN1RuUReVnE7sBcyIamh2Rss+T4Z34UpxH9s7BzteJ//pAqJ3Ohyzf5Ts6EMFoRZMDMOy2p4LsdX1iBr1lYqKavBUh7jRr1zWFkUM4L68hXJsaXqX0Ond7c3xLZt8sp1wYqBnOOkpJW3j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0rYk6tr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21675fd60feso118992725ad.2;
        Tue, 28 Jan 2025 00:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054007; x=1738658807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGmDd20z27/LS1vdWXNTJekDTBka5SLdUJCvGwv1Mqo=;
        b=l0rYk6tr3EFgS6j+E7iSE+MJj01fNTBxxTmQIyIcr6hn2Q8px9m7zloimbtAHPDqQo
         bBY2/oxoB5RWCMcQK0l92hmskaCxWbAS6fLxCv5XqDUzzcFqxJjzYMILMKyw4LMMUjW5
         4611cGF2ih8V81qbLCgvAfrYlIiAxYyqUYZOCTzTPOS8s1Xyr7D/H+tqQAP10sNRg5wO
         jt93Rvtr7B9QoNXsjInBnQHqWDKbfCz+onKssHZb93vATVzlHlNRsjQR7UB9e2+7jYPK
         gITscBgOoMAlMXb6FaVd/Fbi2+dya9gRG+e62JS+5BsIN7Iz1PkpwIwgqYcn9Fqqe0kS
         YjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054007; x=1738658807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGmDd20z27/LS1vdWXNTJekDTBka5SLdUJCvGwv1Mqo=;
        b=IkzgjTjxqApHFYYxzCYGOD1wrZKf964H+5HiJG2pDg6eyVUQRIOT/9GMMgLlQPInNX
         ho3NXcQHUSJXDM7ojM+fGemY6axqD0wjHCwtZmV2kbxCeXxsrEJqCJrp7bD6vhF9MeSx
         ye8SD9CCEB92Vp3S4SfYYOOFl2jouhPh/j+An606hPfVZMTnlGbGFykWdp/m6QVEmfal
         g4qiTgPMLSGZnTp+UGvd/kvQurFWTX/Qo64+X34kp2YCLwYMyNLQh7UqOLVgL6l7qs22
         PdZywtNSkDjP0yRipIB87evqZFdhfqt41i1+b4VYiCcwyBNZReLxbqmg3MjgjRpXgiNu
         TAcw==
X-Forwarded-Encrypted: i=1; AJvYcCVytbKEsKKneAVXGUC3HmJzqVQh42hJuLJhYjcHyZg80raA7DpGHF7BbwFdb9BCuwIFk8PlvJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWVC3ynXATN63QDQzILQKxPx9egK2YjK5Ug58YYo8kj8sfp59
	WBBy17JPmr0cYTqAIct66B/r501qWDMBIT3StIDaCqxsq8WNW2egpw8MDR3Yi2k=
X-Gm-Gg: ASbGncvkuidEi1i2AsDfTW1Dsuxt9CEr9+hd7jUuJ9QXudNHuVGUv5fxhLzAzrOt0PX
	mWxAJb5BxDL25JpESSY2LBSdzmn23TAQVggDZxADoTAfKE721H34Lnrny13N9oPnqh7tB01Xdce
	tiAtd35bJapX3TRTL/lXBzrJTK8x6I9uE9T0e/U0FF4cOrYbnNsjchVg38MT1LwBimiuGerql9i
	6D1DklxmOaSNmUd7z0QFtRyOWmfuTBURlfsbjHmbaC7yyJjQc/+4y0zM9D+W2ZuECeMsz9cQRGW
	2uF2EkfUsZObA8mzKmeUTAoikTaX5VNqYXQRAqq8dUIrxHT4gzROaA==
X-Google-Smtp-Source: AGHT+IHNuKAw2dWKiRqkrBGbYZtOUvt6LdU9GJGk4vFwLSscNliHmlKwL8YlwCg7eMs3GppJESOOfA==
X-Received: by 2002:a17:903:186:b0:216:69ca:772a with SMTP id d9443c01a7336-21c3563ee3fmr748349215ad.53.1738054006889;
        Tue, 28 Jan 2025 00:46:46 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:46:46 -0800 (PST)
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
Subject: [PATCH bpf-next v7 02/13] net-timestamp: prepare for timestamping callbacks use
Date: Tue, 28 Jan 2025 16:46:09 +0800
Message-Id: <20250128084620.57547-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later, I would introduce four callback points to report information
to user space based on this patch.

As to skb initialization here, people can follow these three steps
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


