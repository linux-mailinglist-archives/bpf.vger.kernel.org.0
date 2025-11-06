Return-Path: <bpf+bounces-73827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B728CC3ADCB
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65FA23425F3
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683132A3D9;
	Thu,  6 Nov 2025 12:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-10.21cn.com [182.42.147.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937FA320CB8;
	Thu,  6 Nov 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.147.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431608; cv=none; b=lk/23buAzyLcqtTKJc7MuihWqlk9/gH+S7xisuVmRfCTNJMXnc2K8Oq2nNUgT+TG7jIdSBzS2T/XxlV/NkEkbJuSWA+hAEL/zyb2lLfecRmCgc/NrFH1ld5+N0g0/qx6Wn7dA17Fr6hXzyKiSlv0KFS4ujsGgyZYR3gDl/bsvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431608; c=relaxed/simple;
	bh=THd+TLOhbiZWGGrpFPIb65TDZfa8nA8sP7C99JBBVjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NO7zHRaERwzWavUW0LHuD1Xa4dIHVqNRDeOY0yI5PTtTNj68YCyW6wCnpVFuA351T+z3Aan1wRMxj6eKpnH7HKRS7K2kBKEKCQQDCROVNLwcrD77XGmrrOp1EU32mVjpRctHAPycSVtxU5X6+PTvppfq6UNglUi8011lNHTc/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.147.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.403271223
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 276FDB0CA534;
	Thu,  6 Nov 2025 20:09:45 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id c163011a5d974d14be5feb89a4a41c16 for john.fastabend@gmail.com;
	Thu, 06 Nov 2025 20:10:01 CST
X-Transaction-ID: c163011a5d974d14be5feb89a4a41c16
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <a9db819e-37fc-4075-984b-f8c836d71f77@chinatelecom.cn>
Date: Thu, 6 Nov 2025 20:09:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEpvaG4gRmFzdGFiZW5k?=
 <john.fastabend@gmail.com>, jakub@cloudflare.com, davem@davemloft.net,
 =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEVyaWMgRHVtYXpldA==?=
 <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
From: zhengguoyong <zhenggy@chinatelecom.cn>
Subject: [PATCH] bpf, sockmap: Fix tp->copied_seq update in,
 tcp_bpf_strp_read_sock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the tcp_read_sock_noack function, received packets may be
destined for either the current sk or another sk.

In my test case, the first packet of the connection is sent to
the current sk, while subsequent packets are sent to another sk.

When the first packet is forwarded, tp->copied_seq is updated in
tcp_bpf_recvmsg_parser. However, since psock->copied_seq
accumulates the length of every processed packet,
using psock->copied_seq to update tp->copied_seq when
processing the second packet would lead to incorrect behavior.

Therefore, we only need to update tp->copied_seq in cases where
packets are forwarded to another sk.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 net/ipv4/tcp_bpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d7fa22a..9c99db7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -804,9 +804,11 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 	 * For SK_REDIRECT, we need to ack the frame immediately but for
 	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
 	 */
-	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
-	tcp_rcv_space_adjust(sk);
-	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+	if (!psock->ingress_bytes) {
+		tp->copied_seq += copied;
+		tcp_rcv_space_adjust(sk);
+		__tcp_cleanup_rbuf(sk, copied);
+	}
 out:
 	rcu_read_unlock();
 	return copied;
-- 
1.8.3.1

