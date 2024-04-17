Return-Path: <bpf+bounces-27047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F58A835B
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5AB2366B
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0B13D892;
	Wed, 17 Apr 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yh7+pWcB"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A913D615;
	Wed, 17 Apr 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357989; cv=none; b=K672CdOOq/vSJ2y4ebO8J6rqpF9aRY9EEBc1/UaXgP/sadaYwyM2BsXSNPSjAwQAjsXq1QJcUXeZAc02jby6KrBrmPn6lP5iMlEgojSUIwEA5p+ALfF0uka97wqLF3HosUJp50DGB5mEde+vslbfq3vmU1/OlQYZnx+9Ju9n+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357989; c=relaxed/simple;
	bh=IsUADm42Ju8Paoa9spCg6rSr3NqKSSKje+5djKlmikA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rq/HfGixeHlAA7vwvEjfBQU9PH7Ny/j0AQyxYIyfxB+joWLl/iyYsqn4dpTwi+x0BHq59VVTZYN6WURT5z+Kt1O4mC9uk/3imV/3WQ1KUOLg3nuWb6DzqfAXFR5igOc1ItBvsC4jgQQwiglLfIj2o5ueOLjwe/K1WOIQXNmSsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yh7+pWcB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713357984; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qqVHcGfcShu8OGSh4TKhsqjzx9WGQzghYaSWCuR0TkU=;
	b=yh7+pWcBp0BD94oLtJ9hX7LmmH9HLj0OoPey3J2A5xnn7KgVrBEFwN8wiWiVGTaAWG1DiQqHvUCqY6/PiZewaATcqmkA6xlPe5NNZnLydicarvhVTFvcXZ6jZb1EQ6BeQx//d9oYsLdwhvd1GiHzVP+Lcbau5vhRcY4A4+wGnGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0W4lXBKV_1713357982;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4lXBKV_1713357982)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 20:46:22 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
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
	xuanzhuo@linux.alibaba.com,
	fred.cc@alibaba-inc.com
Subject: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
Date: Wed, 17 Apr 2024 20:46:22 +0800
Message-Id: <20240417124622.35333-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
program. Then we can get the retransmission efficiency by counting skbs
w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/net/tcp.h              | 14 ++++++++++++++
 include/uapi/linux/bpf.h       |  2 ++
 net/ipv4/tcp_output.c          |  9 +++++----
 tools/include/uapi/linux/bpf.h |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..7defe67183c9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2660,6 +2660,14 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	u32 args[4] = {arg1, arg2, arg3, arg4};
+
+	return tcp_call_bpf(sk, op, 4, args);
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2677,6 +2685,12 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	return -EPERM;
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cee0a7915c08..df6bb9a62e0b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6938,6 +6938,8 @@ enum {
 					 * Arg2: # segments
 					 * Arg3: return value of
 					 *       tcp_transmit_skb (0 => success)
+					 * Arg4: TCP_SKB_CB(skb)->sacked before
+					 *       TCPCB_EVER_RETRANS marking
 					 */
 	BPF_SOCK_OPS_STATE_CB,		/* Called when TCP changes state.
 					 * Arg1: old_state
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..370e6cee6794 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3387,15 +3387,16 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
 	}
 
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
+		tcp_call_bpf_4arg(sk, BPF_SOCK_OPS_RETRANS_CB,
+				  TCP_SKB_CB(skb)->seq, segs, err,
+				  TCP_SKB_CB(skb)->sacked);
+
 	/* To avoid taking spuriously low RTT samples based on a timestamp
 	 * for a transmit that never happened, always mark EVER_RETRANS
 	 */
 	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
-		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
-				  TCP_SKB_CB(skb)->seq, segs, err);
-
 	if (likely(!err)) {
 		trace_tcp_retransmit_skb(sk, skb);
 	} else if (err != -EBUSY) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cee0a7915c08..df6bb9a62e0b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6938,6 +6938,8 @@ enum {
 					 * Arg2: # segments
 					 * Arg3: return value of
 					 *       tcp_transmit_skb (0 => success)
+					 * Arg4: TCP_SKB_CB(skb)->sacked before
+					 *       TCPCB_EVER_RETRANS marking
 					 */
 	BPF_SOCK_OPS_STATE_CB,		/* Called when TCP changes state.
 					 * Arg1: old_state
-- 
2.32.0.3.g01195cf9f


