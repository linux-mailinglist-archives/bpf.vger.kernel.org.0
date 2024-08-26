Return-Path: <bpf+bounces-38066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0695EE69
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A177282C6E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53DA1487FF;
	Mon, 26 Aug 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b="Pt88V1SG"
X-Original-To: bpf@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE814830F
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667824; cv=none; b=gxUFcQPpRPVJi+UMU7V9BCjO+qcCHBgZbxylE0YiUbpvYE3gyEb/GNiU+CsPVLSAL8xkO/btvLmOjREMwBB4Wjbf+YQ1caTyIPB5ONMoMFasHNxaWuNL9l6I4eU4TCls6jNht3rg/8wFsomisixX3negvpaGgf7NyhxEzm28gYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667824; c=relaxed/simple;
	bh=JpYMm2QPAmJNwfer4lrcZGTpUEZVHPaSngMPsKiDXRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRMAHyeUWOTvS8OJItojGrh5SBiIk65tKIkemw0UHVP0JzO5f8x5n1Ae7gqjP2Z2uU9FHMBTnxTW2XVKLd0i8s5kwolrByAms0B2OJWgGcMP5Kag2EL2HOEmVxkPhR5ynG1csoQNX8VvFIovUWO23WfQ8ponY+gNLD+z8za6DPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me; spf=pass smtp.mailfrom=kuroa.me; dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b=Pt88V1SG; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuroa.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
	t=1724667822; bh=OSXhgW8ZM5QC6cBJ+Hnw5KZOozXWvB4XmuwlJjC7fbM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Pt88V1SGm6TSk6ekv13NPCdpU9Ycy9f33eC4FEYdlfIdKyl1QhbRgUIij6QAc+e0e
	 rzIvr58TPFwJSf9uZybYKkUmrUQYNYRL6/K+YMztR6gE4mUeNHvsfEk3iln7ypbS3c
	 pXizcuxNwKZvCVrqhB+aeL1/dymYLpWTqa6TrR88jFYNPDLoQPDmRZ+095RSq1AV/W
	 St0dtSRzrCwlXz141m91VYRcL6wLWWI8/BLTkMbiVklciy5WRqs0vgK9u4sQNsMYbh
	 iFqjAv+zW5aIQJGJMEQbGMAazDEfhE0ceuEiThXnMdMCcvCX21/ueMvSf9xkMgexHp
	 nXUWf0xfnlwtQ==
Received: from tora.kuroa.me (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 3536B68033F;
	Mon, 26 Aug 2024 10:23:33 +0000 (UTC)
From: Xueming Feng <kuro@kuroa.me>
To: "David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Xueming Feng <kuro@kuroa.me>
Subject: [PATCH net,v3] tcp: fix forever orphan socket caused by tcp_abort
Date: Mon, 26 Aug 2024 18:23:27 +0800
Message-Id: <20240826102327.1461482-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4P1gZyMk_hqAtjqS-p-jAa2JOO-jzEji
X-Proofpoint-ORIG-GUID: 4P1gZyMk_hqAtjqS-p-jAa2JOO-jzEji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_07,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=846 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1030
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408260081

We have some problem closing zero-window fin-wait-1 tcp sockets in our 
environment. This patch come from the investigation.

Previously tcp_abort only sends out reset and calls tcp_done when the 
socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only 
purging the write queue, but not close the socket and left it to the 
timer.

While purging the write queue, tp->packets_out and sk->sk_write_queue 
is cleared along the way. However tcp_retransmit_timer have early 
return based on !tp->packets_out and tcp_probe_timer have early 
return based on !sk->sk_write_queue.

This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched 
and socket not being killed by the timers, converting a zero-windowed
orphan into a forever orphan.

This patch removes the SOCK_DEAD check in tcp_abort, making it send 
reset to peer and close the socket accordingly. Preventing the 
timer-less orphan from happening.

According to Lorenzo's email in the v1 thread, the check was there to
prevent force-closing the same socket twice. That situation is handled
by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
already closed.

The -ENOENT code comes from the associate patch Lorenzo made for 
iproute2-ss; link attached below, which also conform to RFC 9293.

At the end of the patch, tcp_write_queue_purge(sk) is removed because it 
was already called in tcp_done_with_error().

p.s. This is the same patch with v2. Resent due to mis-labeled "changes 
requested" on patchwork.kernel.org.

Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3-git-send-email-lorenzo@google.com/
Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Xueming Feng <kuro@kuroa.me>
Tested-by: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..831a18dc7aa6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
 		/* Don't race with userspace socket closes such as tcp_close. */
 		lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		if (!has_current_bpf_ctx())
+			release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
-		tcp_done_with_error(sk, err);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC,
+				      SK_RST_REASON_NOT_SPECIFIED);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
 	return 0;
-- 

