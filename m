Return-Path: <bpf+bounces-38959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28B96D0EC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99898B21114
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A0194123;
	Thu,  5 Sep 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UQlpqKa9"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A0BE4A;
	Thu,  5 Sep 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522994; cv=none; b=qtg/oH/oLXg9Q8SJZ5+vqUIEK5GJrIXbUW3nM6XA4WpF0EyFl9t2UGNztJjCBft6AjrtJS+YKrcByRXDT/4tDzcXkBg5/1JBpd8B/Ypuwmo8Ci/+7/k6uPf1yGhHF4EyScS8asJwmV9oQbx4Zzv4t8jiBy7nmCSkwGnwve/CZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522994; c=relaxed/simple;
	bh=K0e6mQkeHBgMEA2rErVI/IFaj39YX4medY8VKPXIqoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aC5uOvwPJ/XbhUdOEG8SvpqbMWbNKPk0mNBf21qi/KAnBy5wbex6FH8OfOitH20SX1sxDgtbv5opR/2s2g+PFJeN6LcWHPev6QWEcz2DD2z9sn09xl5wz8bNbKqcvxtsp94x5BrPQxgkqu0RI31GkYKkAhS0TCCecJe+vXLOdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UQlpqKa9; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725522989; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NomjT5FnOgrVw/o0cAzY3uTGKhJT56vZeS0KR7kFDPo=;
	b=UQlpqKa9/TjNKv1/sEacSBmPjVyyJfJJh5JtnJbS70V+NDEdB0Y7/g71nq+A/hUg+pJpnPdhGQAKvcLeHY6Ln7jU49VgSGf1MUERpARXIBJ/09531FGSCzj6tZjwzuunvoW7AFaP3ISPS5+ucbODoUljboBON0k/NNXOS0gk1LA=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEKkPf-_1725522986)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 15:56:27 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	juntong.deng@outlook.com,
	jrife@google.com,
	alan.maguire@oracle.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	vmalik@redhat.com,
	cupertino.miranda@oracle.com,
	mattbobrowski@google.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in trace_tcp_send_reset
Date: Thu,  5 Sep 2024 15:56:20 +0800
Message-Id: <20240905075622.66819-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240905075622.66819-1-lulie@linux.alibaba.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace skb with skb__nullable as the argument name. The suffix tells
bpf verifier through btf that the arg could be NULL and should be
checked in tp_btf prog.

For now, this is the only nullable argument in tcp tracepoints.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/trace/events/tcp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1c8bd8e186b89..a27c4b619dffd 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -91,10 +91,10 @@ DEFINE_RST_REASON(FN, FN)
 TRACE_EVENT(tcp_send_reset,
 
 	TP_PROTO(const struct sock *sk,
-		 const struct sk_buff *skb,
+		 const struct sk_buff *skb__nullable,
 		 const enum sk_rst_reason reason),
 
-	TP_ARGS(sk, skb, reason),
+	TP_ARGS(sk, skb__nullable, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
@@ -106,7 +106,7 @@ TRACE_EVENT(tcp_send_reset,
 	),
 
 	TP_fast_assign(
-		__entry->skbaddr = skb;
+		__entry->skbaddr = skb__nullable;
 		__entry->skaddr = sk;
 		/* Zero means unknown state. */
 		__entry->state = sk ? sk->sk_state : 0;
@@ -118,13 +118,13 @@ TRACE_EVENT(tcp_send_reset,
 			const struct inet_sock *inet = inet_sk(sk);
 
 			TP_STORE_ADDR_PORTS(__entry, inet, sk);
-		} else if (skb) {
-			const struct tcphdr *th = (const struct tcphdr *)skb->data;
+		} else if (skb__nullable) {
+			const struct tcphdr *th = (const struct tcphdr *)skb__nullable->data;
 			/*
 			 * We should reverse the 4-tuple of skb, so later
 			 * it can print the right flow direction of rst.
 			 */
-			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
+			TP_STORE_ADDR_PORTS_SKB(skb__nullable, th, entry->daddr, entry->saddr);
 		}
 		__entry->reason = reason;
 	),
-- 
2.32.0.3.g01195cf9f


