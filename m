Return-Path: <bpf+bounces-37160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48DA9516E3
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E57BB2343E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DB1428E0;
	Wed, 14 Aug 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hg5UqsW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FA2BAE8
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625121; cv=none; b=oARslkrtpB7iQYVZf5GmN0RFZt5W1jDxjlq+UsWuGiuSHxWVXlQq7Y7j/8D1O7xbyFOzY8xEzZiA2MDy/XlMfYWMzaK76Kq+DgNral9+h/ThcueNRs2cEor+J5tIvhgJ4CGrbvhGNEvQMIU+4cFZg4jb0WVtFVo7L/x5dd0O+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625121; c=relaxed/simple;
	bh=rP0BJSU43YUuU9/R8Fx0nn/NVCzVpX9I9QY7RttkZh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PL3FAKxOmkq5Zn8hwC0v1KRdSHbdRgeTFzKLj2Dyw/1AXOawxurBYD0jkvXAWd+wV1fAr0EjeMXgGbfc/nS6MpnSSz0NwgiZIL7qmQdgKLP5jpgFsuMuiiMgkOkDc9BuWl2Y5Wra7pCTGN3ORHpt5iMu67LK0uOkMBVnS82JGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hg5UqsW6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201d6ac1426so5275105ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723625119; x=1724229919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TH1M4v3WVE7mB9RLKtgXX+m2D/YPKIYBQHunV/cYH4Y=;
        b=hg5UqsW6IsFbRosFffN4LvKAELoXaTvCfXyJOAdpMzq7g0U4nEtsbyDGNNFW6ylPYZ
         jC7A47Uvy8eBoztewlm6JaHf9yuLfQBoD5iULAaLnUcS3igg/TbMGdfymwWMLcJ5ixmA
         E/VbOh5ckbjgglidHDgHCVOcnZLPY5aF1jYOB5MoEioSQNcNftZusFkk0cbmzFNpShD7
         430ajNK0ImEvudbLQGh49IR/wAe5mDj8eMJMTVhVdxjIkr4fULp7k1/bhklV5guepmdf
         sxb9Q52rkfp8wDMgyGFolQfWwvfIlakc+rr6Y2M/rYIYhjvoIh18eRiCvJqt2ErJAcbz
         p0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625119; x=1724229919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TH1M4v3WVE7mB9RLKtgXX+m2D/YPKIYBQHunV/cYH4Y=;
        b=De3Q9B65TTcsiI01TpMD/SBQgGQCbyDRljTi9eJx7H/oVM2WZiWvb2Aa4m0V/gpfOE
         nMpB05vW3tSqL8f8afS9yEWIfnyaB+gAfJAWxaYymn7Y1+6ofE812q7aabetFdjuDgH8
         tsKSW7qtWHXAcnMUKALdOJTPboBV6NXgfD2dkkPNAYbpTDyH6SSEaaBXr7OhiBabhVvF
         8oDzKEJNxuBFlvFDSAisENUxIaV/jig/XOtyOTUZUrUUjPVS1qZzH/mkHCo+QoVmSza/
         Cr4JPM61UdQgXNFGx6gMUucY6u47PDy3in1VIFCASlMG72FMd+nC88JlVaDni2KNyypO
         jtlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVkT6c5uKGrkiwW2ElrCeqWGxX0GiupBv77EMankCG0dgNpyZIplhEjCZfraOtLxlf4ySVAa1nSEvel9F9ghyCyEDH
X-Gm-Message-State: AOJu0YxoDkN7JzWDHN7xSBZ+gIWcZ+EAYBLTYNhn4oJ3gaDCsY9EVTPD
	JsMnJkM79hlmTn8RpURgy1xdZMrQt/QUJuIeOdPjZB3ykpTBHkS4DYBgKAwjErk=
X-Google-Smtp-Source: AGHT+IF6U/jKHy8IrZmFjWfX+RHKB/V6pImruUUL82Kvd3FD/Ry4bV66gBZEGB2/4lRsfrz+jjEL7Q==
X-Received: by 2002:a17:903:41c9:b0:201:e634:d84f with SMTP id d9443c01a7336-201e634db7fmr189975ad.59.1723625119315;
        Wed, 14 Aug 2024 01:45:19 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a940esm25151785ad.159.2024.08.14.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:45:17 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
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
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
Date: Wed, 14 Aug 2024 16:45:04 +0800
Message-Id: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

So bpf_get/setsockopt needs add the judgment of this case. Just check
"inet_csk(sk)->icsk_af_ops == &ipv6_mapped".

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 include/net/tcp.h   | 2 ++
 net/core/filter.c   | 2 +-
 net/ipv6/tcp_ipv6.c | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..ea673f88c900 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct tcp_options_received *tcp_opt,
 					    int mss, u32 tsoff);
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk);
+
 #if IS_ENABLED(CONFIG_BPF)
 struct bpf_tcp_req_attrs {
 	u32 rcv_tsval;
diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..9798537044be 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5399,7 +5399,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+	if (sk->sk_family != AF_INET && !is_tcp_sock_ipv6_mapped(sk))
 		return -EINVAL;
 
 	switch (optname) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12f..84651d630c89 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -92,6 +92,11 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
 #define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
 					      struct tcp6_sock, tcp)->inet6)
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk)
+{
+	return (inet_csk(sk)->icsk_af_ops == &ipv6_mapped);
+}
+
 static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-- 
2.30.2


