Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE660697E66
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 15:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBOOda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBOOd2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 09:33:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5843638E8E;
        Wed, 15 Feb 2023 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676471604; x=1708007604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjbSoT8ChIHW0+uvtStscNPPtzAWkHto7nEOVYxT0GM=;
  b=cTivuFDXn1UDlP6Bn+Vzx7B7XLpF8LUQW9cY2z+/xp1V7aRu0vi8U5fr
   dkdxN0NNr46iynBXLZqbERBjWNLdrNjk6xTLhJMgW9QUmKO5UNIoonqMV
   4I+TcF7Mfp+HcCXIWdjwR4aOVSK9ocVJZ0g5pWquZaXVleAsx8CeYt1tk
   09Z5gZ/oUS5ZOQ0onUUiryS9NyggFrOOHJ6pQTmKEnfv/WBjbjwh9/Rjj
   CswBrprlVBi1cfV0+QlKWGz8f6lje5ZneznnfsCyeacThXkJCL1LghT5s
   0t3XrC5gkZEi6iGCadkZPLbUahNug4msUlBBBCY2KPJRf5mJGi6DIBxNF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358862084"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358862084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 06:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998508215"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="998508215"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2023 06:33:12 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, michal.kubiak@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf] xsk: check IFF_UP earlier in Tx path
Date:   Wed, 15 Feb 2023 15:33:09 +0100
Message-Id: <20230215143309.13145-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xsk Tx can be triggered via either sendmsg() or poll() syscalls. These
two paths share a call to common function xsk_xmit() which has two
sanity checks within. A pseudo code example to show the two paths:

__xsk_sendmsg() :                       xsk_poll():
if (unlikely(!xsk_is_bound(xs)))        if (unlikely(!xsk_is_bound(xs)))
    return -ENXIO;                          return mask;
if (unlikely(need_wait))                (...)
    return -EOPNOTSUPP;                 xsk_xmit()
mark napi id
(...)
xsk_xmit()

xsk_xmit():
if (unlikely(!(xs->dev->flags & IFF_UP)))
	return -ENETDOWN;
if (unlikely(!xs->tx))
	return -ENOBUFS;

As it can be observed above, in sendmsg() napi id can be marked on
interface that was not brought up and this causes a NULL ptr
dereference:

[31757.505631] BUG: kernel NULL pointer dereference, address: 0000000000000018
[31757.512710] #PF: supervisor read access in kernel mode
[31757.517936] #PF: error_code(0x0000) - not-present page
[31757.523149] PGD 0 P4D 0
[31757.525726] Oops: 0000 [#1] PREEMPT SMP NOPTI
[31757.530154] CPU: 26 PID: 95641 Comm: xdpsock Not tainted 6.2.0-rc5+ #40
[31757.536871] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[31757.547457] RIP: 0010:xsk_sendmsg+0xde/0x180
[31757.551799] Code: 00 75 a2 48 8b 00 a8 04 75 9b 84 d2 74 69 8b 85 14 01 00 00 85 c0 75 1b 48 8b 85 28 03 00 00 48 8b 80 98 00 00 00 48 8b 40 20 <8b> 40 18 89 85 14 01 00 00 8b bd 14 01 00 00 81 ff 00 01 00 00 0f
[31757.570840] RSP: 0018:ffffc90034f27dc0 EFLAGS: 00010246
[31757.576143] RAX: 0000000000000000 RBX: ffffc90034f27e18 RCX: 0000000000000000
[31757.583389] RDX: 0000000000000001 RSI: ffffc90034f27e18 RDI: ffff88984cf3c100
[31757.590631] RBP: ffff88984714a800 R08: ffff88984714a800 R09: 0000000000000000
[31757.597877] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000fffffffa
[31757.605123] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000
[31757.612364] FS:  00007fb4c5931180(0000) GS:ffff88afdfa00000(0000) knlGS:0000000000000000
[31757.620571] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[31757.626406] CR2: 0000000000000018 CR3: 000000184b41c003 CR4: 00000000007706e0
[31757.633648] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[31757.640894] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[31757.648139] PKRU: 55555554
[31757.650894] Call Trace:
[31757.653385]  <TASK>
[31757.655524]  sock_sendmsg+0x8f/0xa0
[31757.659077]  ? sockfd_lookup_light+0x12/0x70
[31757.663416]  __sys_sendto+0xfc/0x170
[31757.667051]  ? do_sched_setscheduler+0xdb/0x1b0
[31757.671658]  __x64_sys_sendto+0x20/0x30
[31757.675557]  do_syscall_64+0x38/0x90
[31757.679197]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[31757.687969] Code: 8e f6 ff 44 8b 4c 24 2c 4c 8b 44 24 20 41 89 c4 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 e7 48 89 44 24 08 e8 b5 8e f6 ff 48
[31757.707007] RSP: 002b:00007ffd49c73c70 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[31757.714694] RAX: ffffffffffffffda RBX: 000055a996565380 RCX: 00007fb4c5727c16
[31757.721939] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[31757.729184] RBP: 0000000000000040 R08: 0000000000000000 R09: 0000000000000000
[31757.736429] R10: 0000000000000040 R11: 0000000000000293 R12: 0000000000000000
[31757.743673] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[31757.754940]  </TASK>

To fix this, let's make xsk_xmit a function that will be responsible for
generic Tx, where RCU is handled accordingly and pull out sanity checks
and xs->zc handling. Populate sanity checks to __xsk_sendmsg() and
xsk_poll().

Fixes: ca2e1a627035 ("xsk: Mark napi_id on sendmsg()")
Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9f0561b67c12..13f62d2402e7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -511,7 +511,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 }
 
-static int xsk_generic_xmit(struct sock *sk)
+static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
 	u32 max_batch = TX_BATCH_SIZE;
@@ -594,22 +594,13 @@ static int xsk_generic_xmit(struct sock *sk)
 	return err;
 }
 
-static int xsk_xmit(struct sock *sk)
+static int xsk_generic_xmit(struct sock *sk)
 {
-	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
-	if (unlikely(!(xs->dev->flags & IFF_UP)))
-		return -ENETDOWN;
-	if (unlikely(!xs->tx))
-		return -ENOBUFS;
-
-	if (xs->zc)
-		return xsk_wakeup(xs, XDP_WAKEUP_TX);
-
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = xsk_generic_xmit(sk);
+	ret = __xsk_generic_xmit(sk);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
@@ -627,17 +618,31 @@ static bool xsk_no_wakeup(struct sock *sk)
 #endif
 }
 
+static int xsk_check_common(struct xdp_sock *xs)
+{
+	if (unlikely(!xsk_is_bound(xs)))
+		return -ENXIO;
+	if (unlikely(!(xs->dev->flags & IFF_UP)))
+		return -ENETDOWN;
+
+	return 0;
+}
+
 static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
 	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct xsk_buff_pool *pool;
+	int err;
 
-	if (unlikely(!xsk_is_bound(xs)))
-		return -ENXIO;
+	err = xsk_check_common(xs);
+	if (err)
+		return err;
 	if (unlikely(need_wait))
 		return -EOPNOTSUPP;
+	if (unlikely(!xs->tx))
+		return -ENOBUFS;
 
 	if (sk_can_busy_loop(sk)) {
 		if (xs->zc)
@@ -649,8 +654,11 @@ static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len
 		return 0;
 
 	pool = xs->pool;
-	if (pool->cached_need_wakeup & XDP_WAKEUP_TX)
-		return xsk_xmit(sk);
+	if (pool->cached_need_wakeup & XDP_WAKEUP_TX) {
+		if (xs->zc)
+			return xsk_wakeup(xs, XDP_WAKEUP_TX);
+		return xsk_generic_xmit(sk);
+	}
 	return 0;
 }
 
@@ -670,11 +678,11 @@ static int __xsk_recvmsg(struct socket *sock, struct msghdr *m, size_t len, int
 	bool need_wait = !(flags & MSG_DONTWAIT);
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
+	int err;
 
-	if (unlikely(!xsk_is_bound(xs)))
-		return -ENXIO;
-	if (unlikely(!(xs->dev->flags & IFF_UP)))
-		return -ENETDOWN;
+	err = xsk_check_common(xs);
+	if (err)
+		return err;
 	if (unlikely(!xs->rx))
 		return -ENOBUFS;
 	if (unlikely(need_wait))
@@ -713,21 +721,20 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	rcu_read_lock();
-	if (unlikely(!xsk_is_bound(xs))) {
-		rcu_read_unlock();
-		return mask;
-	}
+	if (xsk_check_common(xs))
+		goto skip_tx;
 
 	pool = xs->pool;
 
 	if (pool->cached_need_wakeup) {
 		if (xs->zc)
 			xsk_wakeup(xs, pool->cached_need_wakeup);
-		else
+		else if (xs->tx)
 			/* Poll needs to drive Tx also in copy mode */
-			xsk_xmit(sk);
+			xsk_generic_xmit(sk);
 	}
 
+skip_tx:
 	if (xs->rx && !xskq_prod_is_empty(xs->rx))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (xs->tx && xsk_tx_writeable(xs))
-- 
2.34.1

