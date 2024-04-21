Return-Path: <bpf+bounces-27325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C718ABE95
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 06:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAE281139
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 04:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D76FB1;
	Sun, 21 Apr 2024 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hu2xbfOq"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F094431
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713673497; cv=none; b=UOF+oEzbXSr2ZZpRhfOzVtzAwrP9SyTt/J+FW/yxm+js4RSfes2EA31AmkwrIOBLPgiNys+WzGZOby0WKtXos1f6eL8nKn5YK1CR5KqLMTN/sc9buGxJOJc/rBoj4hoxa30nJBLkyBjDomAgjaNHlPNo/QQKIGe108vUNqK3aeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713673497; c=relaxed/simple;
	bh=n2PYjq0P3beuqGqWkzITxlHB7H2W5QDyiRY084gcMJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PnHq/Qh923rDS9nFL2gZyjqGEXAB8JwRyqbR6dZoQWlu8hNfXG8sgudWinDac8dUPJ4dBSOmH6T9BoOLCSyil+7pcoXhqQndIfP7XWebf3LWmqzULy+2wHmBCbAPHeWWWPKmE1DzQQm9ZJgh8op4UbzEw1cvEpeR3UXzd1NEbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hu2xbfOq; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713673482; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gm6Wjmg+lIQBKwflFEgmOErBDNtfZvaowDxawJI4aRg=;
	b=Hu2xbfOqRvvEMGRQrzK14wdn6GoMb50MEbf0+KwPQBE+jUXOAbQPbaU1VGN3r4bp9Eyr8QmMVL6/cRowis2Ehp4dYQ22H2Ej21DgmWSVuzkAXK5fXbTGfNDzH8/D6dZ5TqRf4iwJ8etIXoIHIXIMK/tgIQISejMDMhP8rdo6TTs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W4w4ycu_1713673480;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4w4ycu_1713673480)
          by smtp.aliyun-inc.com;
          Sun, 21 Apr 2024 12:24:41 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
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
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	dsahern@kernel.org,
	laoar.shao@gmail.com,
	fred.cc@alibaba-inc.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next] bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
Date: Sun, 21 Apr 2024 12:24:40 +0800
Message-Id: <20240421042440.33125-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two important arguments in RTT estimation, mrtt and srtt, are passed to
tcp_bpf_rtt(), so that bpf programs get more information about RTT
computation in BPF_SOCK_OPS_RTT_CB.

The difference between bpf_sock_ops->srtt_us and the srtt here is: the
former is an old rtt before update, while srtt passed by tcp_bpf_rtt()
is that after update.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/net/tcp.h              | 4 ++--
 include/uapi/linux/bpf.h       | 2 ++
 net/ipv4/tcp_input.c           | 4 ++--
 tools/include/uapi/linux/bpf.h | 2 ++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3c..0f75d03287c25 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2706,10 +2706,10 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
 	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN, 0, NULL) == 1);
 }
 
-static inline void tcp_bpf_rtt(struct sock *sk)
+static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
 	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
-		tcp_call_bpf(sk, BPF_SOCK_OPS_RTT_CB, 0, NULL);
+		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
 }
 
 #if IS_ENABLED(CONFIG_SMC)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cee0a7915c08a..d80bef9bbdc15 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6947,6 +6947,8 @@ enum {
 					 * socket transition to LISTEN state.
 					 */
 	BPF_SOCK_OPS_RTT_CB,		/* Called on every RTT.
+					 * Arg1: measured RTT input (mrtt)
+					 * Arg2: updated srtt
 					 */
 	BPF_SOCK_OPS_PARSE_HDR_OPT_CB,	/* Parse the header option.
 					 * It will be called to handle
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d874817a78db..d1115d7c3936a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -911,7 +911,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 			tp->rtt_seq = tp->snd_nxt;
 			tp->mdev_max_us = tcp_rto_min_us(sk);
 
-			tcp_bpf_rtt(sk);
+			tcp_bpf_rtt(sk, mrtt_us, srtt);
 		}
 	} else {
 		/* no previous measure. */
@@ -921,7 +921,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 		tp->mdev_max_us = tp->rttvar_us;
 		tp->rtt_seq = tp->snd_nxt;
 
-		tcp_bpf_rtt(sk);
+		tcp_bpf_rtt(sk, mrtt_us, srtt);
 	}
 	tp->srtt_us = max(1U, srtt);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cee0a7915c08a..d80bef9bbdc15 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6947,6 +6947,8 @@ enum {
 					 * socket transition to LISTEN state.
 					 */
 	BPF_SOCK_OPS_RTT_CB,		/* Called on every RTT.
+					 * Arg1: measured RTT input (mrtt)
+					 * Arg2: updated srtt
 					 */
 	BPF_SOCK_OPS_PARSE_HDR_OPT_CB,	/* Parse the header option.
 					 * It will be called to handle
-- 
2.32.0.3.g01195cf9f


