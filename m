Return-Path: <bpf+bounces-50930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEFA2E57D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70653164018
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C671AF0AF;
	Mon, 10 Feb 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IcVOWgm5"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F613AA53
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172965; cv=none; b=Pj+CbzMtEb0YNERtuCK7XSqwdCdLwH8eTWFFutNr7tsbdNoFHbHOR91HHSxIgIh0kcdwohhCtw6qnc87bkNSLd4IiobSU//DX3Hux0Fo2lUhvzBunE6Buj74YubWDXYps1fszHalvWquNpe1GdwNYozAHP1MPst/D/HCNWG2hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172965; c=relaxed/simple;
	bh=CjdRfzNR9OSPBWlghAaxoBRFRRDdiNm+u7mKY6c4/O0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+alC2g7T9l0QJ1RNAqP3jEPNpM1X/7gBYHFpEyBO1gjUeZCx8L0bQDK3XN8pxOfN+kXR44Idl865paWRGkZQVo4zFrkcLfFNkVBaFqW6FAS5R68Lilp29mUryBzWpMZZ6SVpFoCpXQcoO+NHYEdujGK0vNDzzvx4fI1yKKn5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IcVOWgm5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o8McU
	quDMMRW3+IRH3a3lXESxJ1rYxSK0uZzGxD6vyU=; b=IcVOWgm59tQc9Ie7DkYKa
	X4gVBqVIrn4CYqC6kUwGFoyoGZX+QBAsiFR8g4fPjigFoR6l30T2mC5THSd3K17g
	P4sRMOfIP2Bzoe2Dr/Vgz4joiiSwK83YNRxZk463b25ycnSusGXn9umsukYoDZ6z
	pRCzuNvNJRXbcqIgCzFgeo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHQY03rKlnG_C_LA--.33048S2;
	Mon, 10 Feb 2025 15:35:20 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH 1/3] Revert "tcp: Use skb__nullable in trace_tcp_send_reset"
Date: Mon, 10 Feb 2025 15:35:07 +0800
Message-Id: <20250210073509.232007-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHQY03rKlnG_C_LA--.33048S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr47ZFWkZFyUXFW5Gr4fuFg_yoW8Cr18pa
	1DC3s29r4kKrWY9w1fZr4DZr13Z3s3uryYkFWUWw4ayw1rtryrJF4Utr42yr95A3y2krZF
	qwnF9ry8C3WUZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD-BiUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhPveGeppbhVdAABs1

From: Feng Yang <yangfeng@kylinos.cn>

This commit 838a10bd2ebf 
("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL") 
has already resolved the issue, so we can roll back these patches.
This reverts commit edd3f6f7588c713477e1299c38c84dcd91a7f148.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 include/trace/events/tcp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dff..1c8bd8e186b8 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -91,10 +91,10 @@ DEFINE_RST_REASON(FN, FN)
 TRACE_EVENT(tcp_send_reset,
 
 	TP_PROTO(const struct sock *sk,
-		 const struct sk_buff *skb__nullable,
+		 const struct sk_buff *skb,
 		 const enum sk_rst_reason reason),
 
-	TP_ARGS(sk, skb__nullable, reason),
+	TP_ARGS(sk, skb, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
@@ -106,7 +106,7 @@ TRACE_EVENT(tcp_send_reset,
 	),
 
 	TP_fast_assign(
-		__entry->skbaddr = skb__nullable;
+		__entry->skbaddr = skb;
 		__entry->skaddr = sk;
 		/* Zero means unknown state. */
 		__entry->state = sk ? sk->sk_state : 0;
@@ -118,13 +118,13 @@ TRACE_EVENT(tcp_send_reset,
 			const struct inet_sock *inet = inet_sk(sk);
 
 			TP_STORE_ADDR_PORTS(__entry, inet, sk);
-		} else if (skb__nullable) {
-			const struct tcphdr *th = (const struct tcphdr *)skb__nullable->data;
+		} else if (skb) {
+			const struct tcphdr *th = (const struct tcphdr *)skb->data;
 			/*
 			 * We should reverse the 4-tuple of skb, so later
 			 * it can print the right flow direction of rst.
 			 */
-			TP_STORE_ADDR_PORTS_SKB(skb__nullable, th, entry->daddr, entry->saddr);
+			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
 		}
 		__entry->reason = reason;
 	),
-- 
2.43.0


