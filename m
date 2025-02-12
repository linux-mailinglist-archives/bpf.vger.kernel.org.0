Return-Path: <bpf+bounces-51218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FBA31E9E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E2168959
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0081FCF43;
	Wed, 12 Feb 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNrLDBag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03671F0E55;
	Wed, 12 Feb 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341209; cv=none; b=XaVedX6WhYk0QGk/2nwfiAUJBZ1P0P06ah2CFYe/gPEcWWaYFfPN8sr3Wv9u3JZPpycxIo9Bi3Qi5R+BeQ7QRhwbcLPmQLmT4B5zYGcQiJhc1vvGafNCa755eLjD7rWB1xGZzvsp0xujjGydq4NPpWHkeICcQs7D/x45DKbGA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341209; c=relaxed/simple;
	bh=edz10u5PBBsN0bO2zRDp8bMno1m0VwEWReFs/QnFqLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzrzU1HN7Men2oShkk31cDOfbgrdl57WCybfB81l7lz5CifvJ3lz8QbWN00WE5HrKK+ayrsvSZblOSh60EPK/3ZaZvrmfUF9Rg1EO35PatoMJB3jbqxF90k4FUJNU3I5HglVcvgb7X204aAP2X5Dt2C28I3aDuj+CX077kPQV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNrLDBag; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f6d2642faso99319585ad.1;
        Tue, 11 Feb 2025 22:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341207; x=1739946007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2x9zrThs0Vs2O2AwfeUwlmxgw8gNGu85vJ4SwgMYK8=;
        b=gNrLDBag77hk3L4+TMx4EV1olA6WQPZu7JGCBcJG25FuDRWhU8VivIqSxK7mAJTBdC
         P5uutf1zvZPXNokDeXoFnYg0qNYgmoSKlXd1vq1rGGD4nXo6l8U0bMhdJvXBaRiRM0ej
         Cn3YRyk+UtNmaHloJY6C/f2OMvuG4xhQIDvmVuPNirztsvS6kM03Vz5LNpwRRGlmKwpC
         yYMStopXnVYNP4tN4hsRM4pn0l5ga2indVde1zEKmJKTgTcXF72lTAZ0nxc+17FJktIf
         FYRLQ5XUOryakZq2uOM9zdP2qpKxrrBiRAdmsCcyK9vszHWPVmbcIs9DvnxqITyD1TVU
         nfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341207; x=1739946007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2x9zrThs0Vs2O2AwfeUwlmxgw8gNGu85vJ4SwgMYK8=;
        b=W/tUOPu7ZYsc4yQ5ovoPU+4eoA2Gnblyjoh8t2Elf9Uqd7KYxb+awQdUNaBCVxwScw
         CYp0h3hW84aKjsDA9eIBRolxx/fkM6TiGbInuMJFjQvquYSAGvvzqINIlf20W+PcGcjd
         OyTUZc7FefP9NskHzOSifZwQxb6WdR4zwBLPm7WVgPgYHm5F2BqHbIdAsXAAuUdks97y
         kPb6AxIrhyBj938KUrcqyoS/j6qe4NnoB6X9PNi6URY18V9penGuLxtvT01CxX4NSCex
         SWovJMSF+2efh3kZzwWekx4YgdG7TgM6+yWQWbdgJEb6XBH7m2nBcDqtjHEG+cj2TCKr
         LTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1lSZVOZdedr3vlHAMpfNaTdIs8ouhlzf3RMjIi9gmXdVk7lm7uHc3j2/xRpRaY2hbd2dDhOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLN6VtWWCv2dCQwSsWXxW1I5vG2GpjI+yr7YEYWrQVgw8Yffo6
	WU47FoPR+zIz7NvqEL1uD39xRHdw+uNOq9K3u/ZBNILUm9/oceLSKDY1Gb3d3YWt+Q==
X-Gm-Gg: ASbGncvN3djcg/yw4vjmsWUUwXCR2koCpWuGBB7FV0axpWSoPU1zbJlwt8s/TDQ66WO
	Qql1K2i+TDVBt40CujCQu92zGiv7RKbCUK0E2EeMriYqIGck0tPy7J/HZphXM/dZ0UxsC/T7tzZ
	i/q0AkJT7tUsKmWvcINjg9l2wx+tKjapDPdSmsZHnr6cjV2bbaQU2OaGODMRTExVSYZqXVPh7be
	b/pvADZXXqkt72XTYHbeGb9Vc7ScxHe4MXZcemrzuy8oB1pTtrNFNe9edD5s11Ao3qWw1TbrzM8
	wUrZjSZVNG5S15kkBqVibX9qO4JMVoXdH3BaI/2Rfoep95I4V8+6tk92CYd1DZY=
X-Google-Smtp-Source: AGHT+IEs97fKXeklN+GB1qGDHkyo1NJS6iZ/UWhtL6INha8YZGQE4BK0X3AH2uQXDi/CUBVcA4gAuQ==
X-Received: by 2002:a17:903:2f8c:b0:21f:49bd:4bbf with SMTP id d9443c01a7336-220bbc85b0emr34847665ad.50.1739341207271;
        Tue, 11 Feb 2025 22:20:07 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:20:06 -0800 (PST)
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
Subject: [PATCH bpf-next v10 11/12] bpf: support selective sampling for bpf timestamping
Date: Wed, 12 Feb 2025 14:18:54 +0800
Message-Id: <20250212061855.71154-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
selectively enable TX timestamping on a skb during tcp_sendmsg().

For example, BPF program will limit tracking X numbers of packets
and then will stop there instead of tracing all the sendmsgs of
matched flow all along. It would be helpful for users who cannot
afford to calculate latencies from every sendmsg call probably
due to the performance or storage space consideration.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 kernel/bpf/btf.c  |  1 +
 net/core/filter.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9433b6467bbe..740210f883dc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SOCK_OPS:
 		return BTF_KFUNC_HOOK_CGROUP;
 	case BPF_PROG_TYPE_SCHED_ACT:
 		return BTF_KFUNC_HOOK_SCHED_ACT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7f56d0bbeb00..36793c68b125 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12102,6 +12102,26 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
+					      u64 flags)
+{
+	struct sk_buff *skb;
+	struct sock *sk;
+
+	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
+		return -EOPNOTSUPP;
+
+	skb = skops->skb;
+	sk = skops->sk;
+	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	if (sk_is_tcp(sk)) {
+		TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
+		skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12135,6 +12155,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12155,6 +12179,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
 	.set = &bpf_kfunc_check_set_tcp_reqsk,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_sock_ops,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12173,7 +12202,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
 
-- 
2.43.5


