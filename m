Return-Path: <bpf+bounces-37928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7495C86E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C8283B02
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75011149C63;
	Fri, 23 Aug 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SUMuf+H/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB444C76
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403209; cv=none; b=XxNegC41wPylI3NxUsEDD8bnA390EHm+DbLQIb74o6JLubOvTwUtsIMKmz5ZqeCZSh3iWa9Jx/2+0UlM8/90LZPfmgZfN5kJBhtVbopocGiSuFwraWQNBXBysqp9mudXvOTiQL57qNQ9cZSE0kkxj4Lt7CtcPW7JEZ5wXIs9bmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403209; c=relaxed/simple;
	bh=Czg/K8OYgGDUZKZ32LDsFwF1lH6BFPUIGzT9yRSBDJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YRORd1QRisJoo2gdRe0hPay/ad7rC7mwqGEnfOXgQSSsBB0YqiuLWxEFG4KDorbHFeHK18OEuqrvlD27iIBEs3G/+355Tpspl3c0zJPxnL9gKWeX9YuVmS+O1WsgKRtMEYxTApS5JcZvRdJFIu232v3M30xXqVcr5Ye/7DCA6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SUMuf+H/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso1261219a91.3
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724403206; x=1725008006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezFQroxpGkaUsSdMcah57ZHaQ9w5KjbUOSox/PwRH50=;
        b=SUMuf+H/LY7unKIiQ3uFyTTubrpi0/t7bx/ytZuaDRyZFqkf9E2tiBMh31X9H5NYZ0
         qBnee29k7Th69WqQKu5Ev9nKraQ0BInB/QZJIMpR9WZwRuPfC24DL+1ge8NJdyN/SdhK
         UtXZIO8KH579RCdKWOstRNNb9+XqB+5Oep+TRFeC78cOeDbMzBCB34DL63DB7ETrv4fw
         aG6AD3/c6/a5QH5ZrHF4S+tkdTEkO14B1MkDJ7ngCyIiy6ZjA1Vf9eOkMi8GomOlPV15
         pXlBu2yArknbGKrZAinhdyfLU0bjEPPJwNEZzWjGkCw4rKujChMVT60eSYEEPQ6rGWPW
         ZYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403206; x=1725008006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezFQroxpGkaUsSdMcah57ZHaQ9w5KjbUOSox/PwRH50=;
        b=noEEHFNrpGKzm7Zls1qKtkE1x1dtW/NV1ZLN6b19y8WV2JaektnPWoR4L3J/YwSk7A
         76fYNncX9e+My7/VcG5u/HtgV2hoFU/vdqyK08QyNaHrWdbPkqMYAKtNME9ByJjdVsQy
         9O2fD3eOTih+0tLLOjt8iV3QVsxXamNaXCQlzVf5+d1Moq4090hS5Ber8bmB7Gf9edAO
         nojLxNLZK8t99ASvgCTQbNdsN6pvQWw56Mnx8OjILZ3W6SkEHWDJzCM8aanyXH24pXgQ
         n9hNh61UWWxqWucAPsDJaT/y0EB5z2WmdonRYH6hFC0Jqw6r8NLfonq3DrLfKvwjpaUV
         ze2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzROUYapy+yhhtllqGAyl24IEObKci7ewLsteUaD33OlhUlq/uzCNbRksdlamnr2KZo1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmrAPS3CoICGID4SezzGq1MnlRoY9FsNDR9EFfJCdxSLgZIkD
	wOnaFF6/zVGOjF3dS+X96Hfaa/SY1yRKjS5A0eYYCxGnwagkZrYpzU01j4wWBPc=
X-Google-Smtp-Source: AGHT+IFaylOAd/toGYXIX2p8c9dCa2PThSma27XXT7LPRvz9cAudRL9wgkqY+ZW7DLfNiPVNny90yw==
X-Received: by 2002:a17:90a:2ce2:b0:2cb:4b88:2aaf with SMTP id 98e67ed59e1d1-2d646bb512amr1410015a91.12.1724403205819;
        Fri, 23 Aug 2024 01:53:25 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b2048fsm3430129a91.54.2024.08.23.01.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:53:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
Date: Fri, 23 Aug 2024 16:53:13 +0800
Message-Id: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

So bpf_get/setsockopt needs add the judgment of this case. Just check
"inet_csk(sk)->icsk_af_ops == &ipv6_mapped".

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
Changelog:
v1->v2: Addressed comments from kernel test robot
- Fix compilation error
Details in here:
https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/

 include/net/tcp.h   | 2 ++
 net/core/filter.c   | 6 +++++-
 net/ipv6/tcp_ipv6.c | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index ecf2ddf633bf..02a825e35c4d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+	if (sk->sk_family != AF_INET
+#if IS_BUILTIN(CONFIG_IPV6)
+	    && !is_tcp_sock_ipv6_mapped(sk)
+#endif
+	    )
 		return -EINVAL;
 
 	switch (optname) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12f..125c69f1d085 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -92,6 +92,12 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
 #define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
 					      struct tcp6_sock, tcp)->inet6)
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk)
+{
+	return (inet_csk(sk)->icsk_af_ops == &ipv6_mapped);
+}
+EXPORT_SYMBOL_GPL(is_tcp_sock_ipv6_mapped);
+
 static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-- 
2.30.2


