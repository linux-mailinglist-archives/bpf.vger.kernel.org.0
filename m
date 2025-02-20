Return-Path: <bpf+bounces-52058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD0A3D253
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9517D7A7C90
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F611EA7C1;
	Thu, 20 Feb 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/g4QyyP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A461E7C28;
	Thu, 20 Feb 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036658; cv=none; b=YovXmJZtNlPn9FwtJ+UeakM1rG3pJSsG+jwdtsBOdxJ7wz+sHamMCEE6idaiY3IzX84rBINGkPVzAo3CTZgqsDI2CmgdnKVxrv5PQjc/5Yzrb1W1CYhC0QyvVMXOl6ggYjbo1/peTH4osd54/xNM4zu247jdQBRtnELwQW6r2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036658; c=relaxed/simple;
	bh=DuwBsmdyCTo+cinAC8/Ea5sGzPUwGddRI8TSZBF9dcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hsnn52ImJvoMlA0eM4PUnXwH39houn4pRK5KguvxZaOSBwqaURIItr3sdh7oXIhEG9VAds65k7v/CiNtx1Kdo7mjKnEXbjsCPBZaZLjKuhF7sNK9Aq4i5ILYuc4nik3aKW5qEtx9Oy/XDhCJm5T2coDXa8R1RaC726en7X6Fj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/g4QyyP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc3db58932so899604a91.2;
        Wed, 19 Feb 2025 23:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036656; x=1740641456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r05UJr0uzwoUXWnrUBpOZC+aSB1ejZmiLmZcOtCjpk=;
        b=J/g4QyyPgjAqBOOguwc45u5aivkdKoQn3zYUXFcWc6NXxZMF4lUQP9m2aEz45MSzyK
         AKkAWuRk/i+uyvdf7ShiDM2x8KE/uXTIpOHzQXZ+Ieg9wY3QLubuvpe4sbQcOEicyM41
         JeZmlNXQncYEoN7KfcP5OczkFRneT54jmHGzZWv2NDRzvV0uzTiJOg/a/awXNPxdS0ca
         5TAtfb6XYLVggi9tG286zTJ2wsd1ej36FKpvv7NO5ODej9XTTyJKHcGnscxtVO68R2ar
         ndVovg3pZHI1+9fE4TcV/tUEeNTojiJlIdw8VSIf9PWGxKkGKk3yxJ38+uXWYSDunfKm
         iJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036656; x=1740641456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r05UJr0uzwoUXWnrUBpOZC+aSB1ejZmiLmZcOtCjpk=;
        b=HTNhR2r+hQIzvThmuohUOXN9Ccvl9CoZG893ybXbhXVUx55Y3iE8dPknRfDtuuD5sX
         KpytOLrtsAmuCluavdwhwLwfY79NBSCshc+VtCoRh7yohLTO8ctULo0irXet3LGunjti
         jY6muVHSTfazjzhiNGvneqJonXFmBYyWH/kqh0aRdBvb7vcMt78sQ1iNNBQGeRI7viNs
         Kv+irLnHeXYOalga6T8ENVXNTz4GdX6XcmCHgo/4+wEnfpR9abZEbEnh/fznVQYPTIGT
         tOgd40ZcLHjXSB48W2wh19aZ/yB4J4zpNWqShA6khBpHmcEcHupGPs2U5vklVe+sAtKx
         RYDw==
X-Forwarded-Encrypted: i=1; AJvYcCXUq7J+4IYygSLvwqobPJJQPZ6IyiOAS/lw68jIYtOCjdR/sRTayUTcFjf+PMOWDxwYHtglw0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISu6p0yF1wvDuNfPF7f6OWx4gHI3zOSefSZWadj2FBU7nNOJQ
	+z9d9DoQYLPmcQkRA29SJEHGjZItjMAx0BENUL8MsWRqYhQ3PaVa
X-Gm-Gg: ASbGncuPixYhUDgtpe9jiWahdqmj26d1uTfMPg4lLpfjf9/bSWNProlYYMw7a6SNcz/
	Qgr2LF503a6iU+H3e8MnaOHMyKdwgkiZ/kjqw+yttHv90UF/7EqvQdZMloL3cveJXjl+laSMK3R
	jne2zKA4HOFY51NDy7S/qjCmwEzioQoqXjv3N3J7nyaHbKim36Ee05ZXDkk2anmE2JodPVNBYDX
	7LiJmETlcG+5Xj5heWRZz3WYybYkV5OkREAVTg7Pw2g2+TCQjXnkhpu/n1qaqAUOi6ca4U7juK/
	HAfF5tefGZJw+BUseYRNmIupexU29tZ+eyhUEDccKfBlXmyop9MPooi82UhWiX8=
X-Google-Smtp-Source: AGHT+IHrRY697fD2ruGz3EKE+JU0HNs92QA5D6yvh2Ya7Q3CBnY4g4s3LJ3kF+mFpaQaDHTPiMeWSA==
X-Received: by 2002:a17:90b:2b8e:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2fcd0ca3b0bmr2848901a91.18.1740036656254;
        Wed, 19 Feb 2025 23:30:56 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:55 -0800 (PST)
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
Subject: [PATCH bpf-next v13 11/12] bpf: support selective sampling for bpf timestamping
Date: Thu, 20 Feb 2025 15:29:39 +0800
Message-Id: <20250220072940.99994-12-kerneljasonxing@gmail.com>
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
index 7f56d0bbeb00..2c8e986bceb3 100644
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
+	if (skops->op != BPF_SOCK_OPS_TSTAMP_SENDMSG_CB)
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


