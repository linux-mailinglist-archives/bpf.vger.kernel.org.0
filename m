Return-Path: <bpf+bounces-50864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DDA2D595
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6942B3ABD76
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC081BC07A;
	Sat,  8 Feb 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+qOeDWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C551B392B;
	Sat,  8 Feb 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010808; cv=none; b=eT2rgBq0Nou6NWkCUAlbybIIG4WJQsj27XdzctgeibixLSIjoCEeDRV7AB9/KREqHFcquyX0tpOuqpuAtOaky1rg0xG2Z9WRXtCADqpwjWSPZSXdU1ykoGO25X2NxA2OIMRz44cist5xf0iQ2mk+RpmJLVGo2/50yE1WHlTHejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010808; c=relaxed/simple;
	bh=rQhkzZC0XwepZLpR15aNKbaCjAhsCesfAKmrbNdL94Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHq/hxC/rGqTN+rR4QZ0xkm2EMUMIH+5jdqXx62RvtZj/hkmSp5e/DIn76p8TuHoAV1cicFRM63RT57+Y/QU5VkWbi7LhARhUFdwBfPcB/WK8EGvwmMegZxewbw1L+0mt57GGIwjzx1qgNyem16NqU0Q9uoCfKtuVRQ1iJPbDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+qOeDWh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f49bd087cso33258525ad.0;
        Sat, 08 Feb 2025 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010806; x=1739615606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ/kKM4K/pezqgv9p+bZB0MGsAMTBtR8FE1S3tCeUM8=;
        b=a+qOeDWhPr5sSmqKbPP8w9g3qFnqEvYsR/CFzWjT1/hIK/bR5+X1bYpGYdLtc8j7qd
         QzTA/cyCtnEUbW99Qr2ze53Qp24so+3+HVMbUQTSGWGRT01z4idnJ5hmd+dqP7umgKIY
         g3Av9KmoaVgJY780UfFmqTQcANtI3eZKyjYtcZC8lw5LDHaBRraptyw/S+pbLWTL7e+G
         cYyKwTxWwh/e3nX4UsrP5X6hS5pitN/QAHHXcf96SmIwbDKHBOrOo5WqbBCiZhYy6z2l
         t+acT3MSherift6OBXm8aLEW5CePYvxAqE2YyBy1MCDXD5xgFUbDvsP1DbdpXlFfcf0s
         VFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010806; x=1739615606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ/kKM4K/pezqgv9p+bZB0MGsAMTBtR8FE1S3tCeUM8=;
        b=rL33IJopZlShuK8jQed2YxzLiOWIi6lB8S+ru5RdhXrah//jAKeEn7uXB1iN8gopxW
         19muGuUQNgKmd1WEGITpvKhZiVzKsBunOBjqHvhepldWFvBLp4jneLeJyQWzkLPjfx75
         eWDPwCpzY9KZrEvzvKfKbed/6F9D97jvK9C3RAEWhVmKWmAFDptEkuYmykeEIftTg5s2
         jGLjYDKly1PG+hCJhU+F4PPkBC1phcDqPanJ4HaMuoxnobKGIInHH/rUPFIh6JLRkUOb
         709M+CawJgRNqvzb0pApqPIO6o9qzCFVG4yvZM4CTeXuYlo8eoxJCdL1b8E6J3cGnqc0
         NPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn0rSd7yQ22NxVSDBxrfGYL2rqmwNc48dGuXoLTuAhpr9IWoDWxqJSUzAozIP5nTnswaTCcQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVtglMn+YXl85SogzddFOspQePlSax3rqieb3vu0567pVId7G
	rZ/2gOQWPynA6hU7XaGbEvQ+M4S2iUfBqxUvXeUm1zH1EdcBmapL
X-Gm-Gg: ASbGncuiXrlahs6B2OdMuvt/9ErYU0k3vB1npa0bUhUU+UIFaPfDxzlHwzebQm0tW5G
	c0tcVFVWCJTGQeZwoun/cZ4b1Wz5g0p5cIDmt7MIeleoa4hDMJ1cArNpdv0hq/VfSWEzXKXl8BZ
	gXdfVpXNG8xFzjJQWwTk2c/GkS+JzWqfgWB51Tj0ve6rGBaSPveCM/YuuSINohlfsWUQcMwAPt+
	Oz7xpH3jPljQd1fP5RJTbBOqdzeMXOIFGYgAn4Ads361H66jP8vLa5mI5tJEfWT9LdNyraT4FyZ
	EQBvBI9UH5ErRG/zI6lbSX8MiMYeou48kZbHuXK+2msgH31pytknOQ==
X-Google-Smtp-Source: AGHT+IH6V2ZaQtGEJ9gkdP+GjNe/hzcgfocw9H3auyhUiwNYHTtVkwPh+GJiWZLjgu5vKphZzylK0Q==
X-Received: by 2002:a17:902:e943:b0:216:6901:d588 with SMTP id d9443c01a7336-21f4e6afb39mr107336875ad.15.1739010806205;
        Sat, 08 Feb 2025 02:33:26 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:25 -0800 (PST)
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
Subject: [PATCH bpf-next v9 11/12] bpf: support selective sampling for bpf timestamping
Date: Sat,  8 Feb 2025 18:32:19 +0800
Message-Id: <20250208103220.72294-12-kerneljasonxing@gmail.com>
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

Use __bpf_kfunc feature to allow bpf prog dynamically and selectively
to sample/track the skb. For example, the bpf prog will limit tracking
X numbers of packets and then will stop there instead of tracing
all the sendmsgs of matched flow all along.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 kernel/bpf/btf.c  |  1 +
 net/core/filter.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba..a65e2eeffb88 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8535,6 +8535,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SOCK_OPS:
 		return BTF_KFUNC_HOOK_CGROUP;
 	case BPF_PROG_TYPE_SCHED_ACT:
 		return BTF_KFUNC_HOOK_SCHED_ACT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7f56d0bbeb00..db20a947e757 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12102,6 +12102,21 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops)
+{
+	struct sk_buff *skb;
+
+	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
+		return -EOPNOTSUPP;
+
+	skb = skops->skb;
+	TCP_SKB_CB(skb)->txstamp_ack = 2;
+	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12135,6 +12150,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12155,6 +12174,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
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
@@ -12173,7 +12197,8 @@ static int __init bpf_kfunc_init(void)
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


