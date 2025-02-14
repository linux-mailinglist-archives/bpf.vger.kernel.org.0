Return-Path: <bpf+bounces-51503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59FA35373
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DFF3ACD89
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D581727;
	Fri, 14 Feb 2025 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7ez1te+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3D2D052;
	Fri, 14 Feb 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494909; cv=none; b=qGiNmGSAvuJ/LKG8VjPD4XwwbnTRU0qr4hVWLhHSLydO/Q16i0x2yep0294XMRSIRSk3+F8tkQrzumJbX0iHR/q9pTRx36qANMheKsiqByejG1pmD8ZdFH6gpjj+pMNQFuOm85FCmsA2TR3taOlFDGoxwpTtW0cnOcyHZFaqjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494909; c=relaxed/simple;
	bh=0tRHgcuwiwPX1DOW4gmLwwqaVyB3BLfzuCpbj6vjQg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRt6nTkRnncxKRWQcM0ybDQ0RUrp6MOGRdPhPVK7CMGEqiWwJ4qlmPR8802ItH8RnHRLZGvi7+hxyKb9SuUAm1VgAyh8/pLodxg1JkoHiiZefb58aRh+xnftWMbfeLmWWN0R9O83y1RzK/9dv27R3cdIelvX4GScE+1uM4LZd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7ez1te+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c92c857aso23934375ad.0;
        Thu, 13 Feb 2025 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494907; x=1740099707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4jU+6ZSmakS6zteNg0p1kJWMAaqHIPHqfUuFCQFa8U=;
        b=P7ez1te+RDn3wprr7BODAzIGeyYRcpSOTESoBNode1TkCY88GdSMO+relOjt9n7JC9
         XHp+kvAKgs0svoD2+EB3edOntnk7MN+5Ho/MahXYizqc2Xjpq8n/kTpcAyw+WZ8XHMcd
         SbgDw/o7w2krjMIRfPLprm9PMFq5cypRypQ1slxlFEnLklwmZhu3RtLQHiUx5uNhD++i
         A/CnRgUTKLuly8H7+NLbgv4a4dTs7Cs7tT7rv5QJy8i68rIkKBcS3nyBuFl+m5tk5xkj
         VnnHIG+xqgRa4Auu96MrYx+Iw4Lqau3KkYU9ubDz8RCnaocuJssGCG0tCi+0xxHQN29j
         NxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494907; x=1740099707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4jU+6ZSmakS6zteNg0p1kJWMAaqHIPHqfUuFCQFa8U=;
        b=urNHZYd1xfHGEvEapkRE8kgbA2OQVCqNddBeP3+c6u1lvDzmJO7ygL/SecugkYbmb2
         I4AzwdZc17tvCx4aUuF5MdpnbsWM93nn7Zq4l6VrUBuf48fXMWoaWJMCy8xVJI+eumrS
         sePTIiPCG3aP+EDuNwdRh3YGFEL6KQ2HdYf99iKeWkIL80gTvEOI8uMOuvbYM3PYaemS
         mlNoPFFjAHpOnqFcsCHtgOXH/yCckl2m0ACQA5A/RqG79WkUwxJpKLjxOHaYFWF8yBpO
         ovLdF7Q5e8sZbbI06cSu4wL8VTVtoewieISjXyjO4KeHA6EshkHJzNKIk85L+6cUwK9j
         MAwg==
X-Forwarded-Encrypted: i=1; AJvYcCXCXRrl3Wg/lyWAm8w/IiVUBnvr/EyKxF/0k8J7b/yPd49wWzbDxe73EkAfBN8NZpVWF71V+kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVF9Cz7xftoCr56WtTvmyfU7faildf54VKFH638dTF0SHpeGub
	ykWtYzdpH2ucXD7Z1iGf/sNhlLblTtr1KbnOotLIXbt4EMzZlkrqSd/ccZ/mloM=
X-Gm-Gg: ASbGncseEPDRpOstZEb3QaBDZpyA7slUfQwsM04YsftIBvCvDAtPaaBLQd6fxaY1v5+
	4ilxJs+9IGkUxyq/ru7MFxBRvlSnz9u4ar8NONi0IgbxHqmKVvhzVywvGow2Gl3sEUAhshbO74Y
	/32dsNYTdOZ0qxTPKHmp5A8DrzAItzZJ9AlR1XvRNwnMpCVx5b12oZ+TgZAJSPd69BwnBvgRKx+
	B4Msv/v63fCCC/3ew1muuFHZnrLEPifoInAjYxe/JkTOYh070k/eOaRKlNcAJ9/3x/6toJU5Dq0
	EqnDnwPWwBAtI7Zh7SOzMIXakjFJHtH8K+ssH3luoycrDeFAgshVug==
X-Google-Smtp-Source: AGHT+IGtbXf337tlvnRIkA+MN2in6MRMsplA6IcKu3MyOEC1Z4R2UyGhgG8KCCl4gofq2nSq03SrrQ==
X-Received: by 2002:a17:902:ce88:b0:21f:3823:482b with SMTP id d9443c01a7336-220d35e098dmr73238205ad.25.1739494907100;
        Thu, 13 Feb 2025 17:01:47 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:46 -0800 (PST)
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
Subject: [PATCH bpf-next v11 11/12] bpf: support selective sampling for bpf timestamping
Date: Fri, 14 Feb 2025 09:00:37 +0800
Message-Id: <20250214010038.54131-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
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
 net/core/filter.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 7f56d0bbeb00..3b4c1e7b1470 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12102,6 +12102,27 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
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
+	if (flags)
+		return -EINVAL;
+
+	skb = skops->skb;
+	sk = skops->sk;
+	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
+	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12135,6 +12156,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12155,6 +12180,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
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
@@ -12173,7 +12203,8 @@ static int __init bpf_kfunc_init(void)
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


