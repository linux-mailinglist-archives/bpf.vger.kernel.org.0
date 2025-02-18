Return-Path: <bpf+bounces-51809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1DA3925E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778B73B506E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51E1B0F30;
	Tue, 18 Feb 2025 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6pS3435"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAA1AF0C2;
	Tue, 18 Feb 2025 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854992; cv=none; b=NS7zrcRnIgusGRPjQTjiOvR3BRJIsWlYW0WRZ/PIaTEmbwXwHEePuEkLryK6bo07zKq6Dl4wEYPDYPwxnEg3vKh0NFDv2D++peCFlhM4ZeZ9Zwt3CU2kyeakbyXdCNW3Eu1SymUF34ZBJ7TeHa2h06728oQgYzkwntrWmsnTrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854992; c=relaxed/simple;
	bh=96hvCuSxCs+mUJ6LJEGW3IEdDKTIaTJ+daWiYKxNdCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3UIkQ2h0txY8Szze76WLomU1aWJ1e+UuM++loB1MbVlDAqTBFhJnVHqwTycwlGsKE6nLNzr5rMRvdRXOUSSmRWCKtZOsBM3BhiqY75Zp/2ENr1Tcg9DoZsk8LeglSprJ1Ptt32PC/bbeHSc9AMIljnYdppGjUgQ9pH35EdmPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6pS3435; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2339dcfdso75647765ad.1;
        Mon, 17 Feb 2025 21:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854990; x=1740459790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw0RyHf+BlC6NWbRId5LTA+LQRScTEJXKQpbnXvfIO4=;
        b=Z6pS3435r000U8K9zBzpFlJ7895KDX3qu/sIA327Rp5FZKH9S2pfGa3eQ3jZaCEqTT
         iVYXo5BXQpl5y2b4Ld6HhvcIMS9LU8j2eshsrY6Yje3dwKkyCKLsHLkBzSvecEoRO89z
         6u3DIhQn2U4wYh/JW58MlWDpj9DJc6YLt6CV6vGijxjFVw+eF9EVMcJECtgNKDVnMAFZ
         DOFx/KfGZox2fc7bvquT/i3mMoiS+f5J7T44jGrbmoa1zQ7a8LuEAzV9eFbNJ26xGiQv
         GPiWG6ctJ9b1nT0F8OAbeH9T1X0el5o5Mrc/BtsKn+iMPVOBOy5ZArvCW6NY9fSBeCJL
         3cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854990; x=1740459790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw0RyHf+BlC6NWbRId5LTA+LQRScTEJXKQpbnXvfIO4=;
        b=R/urew3x2NjvVUv7Qr8uVFGm9J8H3f8NigSQriAlYVkZHIagsYaParjw1vS45N3XwO
         TXnPK7mcltLJAr3s0bOMd37hEQ0HdvL6Zdnf37HI/HsRaNgmv1z0mgC2hJyM6bmi5wa/
         a1NeASO50EHSR5gFDiwcobNiRJysjKcM/zFSeyKYA/IHsVa+ZRoSF8aBUtWtUgbq3N8S
         kUVt6tERUjWQyeitYRceXx6/yeFErqMQWwbfticK+oB3bD6c+KpVlG2U3ONXPWs/iAZx
         oWQmOfa0pWdSFYM0ztVP1Fz8B+7qOIJyLaOaoOhlLXU6K8dd1g4wavZlbgRQTKZWBBsy
         Y88Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsyf8/ktvy4QImCThVhJNBoOsYlfy8MEloxkTzw6DbP8P20ICiTFhOLSyAtX6MZLTBpuBnyGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywee8OjuBgY1gT7sqpgwFDLjnXnN8F9LMcY1VaYqHr/NKDEdPAD
	ng6yo87BJe3MTBcmeUKtjp2bQiITetglyZsKJF/fgFaNypIomqzU
X-Gm-Gg: ASbGncvGm/bfzC7ScZxujECepfIkOz3BtuES2MDQAmgsF+9QkME/uEfpOnmiwAQrS/v
	cmOFuX0rHNFHNhhInj6ryp5mLuyHWeD65u1fXbcx8w7alteSmOvsYP4lMRBF644QWM0h/DZEcWh
	xzhRyCeW80sKcppcYhy4Z/pKm9QhsoQncIQbshdcph+DcRYdLr5GzIDkq4uM7OVXt5uDmriDlaF
	stNyjBqLKrt+B29cyRgVbp2/i+nW57bhOp1FaE+sMbLLMFmTKaGtt7yK7rwKfZOUx2Iq9VIjneJ
	zYAwk3vY085PCr5XUBc/n6hYLdi190RIFEUDJSdSgEcIaBa7/a/cnUN7HeatzX4=
X-Google-Smtp-Source: AGHT+IFDE3F9vH43EFtyXKUM6dm00EYG1y0nglUMeLGbSxtgNZF4yysZw5kPrlomLcWYIjZ9K0sRcg==
X-Received: by 2002:a17:902:da8f:b0:21d:dab4:b360 with SMTP id d9443c01a7336-220d32e4f9fmr314462275ad.0.1739854990379;
        Mon, 17 Feb 2025 21:03:10 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:03:10 -0800 (PST)
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
Subject: [PATCH bpf-next v12 11/12] bpf: support selective sampling for bpf timestamping
Date: Tue, 18 Feb 2025 13:01:24 +0800
Message-Id: <20250218050125.73676-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
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
 net/core/filter.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

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
index 7f56d0bbeb00..5611d4a7cf89 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12102,6 +12102,25 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
+					      u64 flags)
+{
+	struct sk_buff *skb;
+
+	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	skb = skops->skb;
+	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
+	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12135,6 +12154,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12155,6 +12178,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
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
@@ -12173,7 +12201,8 @@ static int __init bpf_kfunc_init(void)
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


