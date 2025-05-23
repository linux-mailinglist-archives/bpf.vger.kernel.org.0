Return-Path: <bpf+bounces-58841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C466CAC278A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639A07BEDF2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87108296FCB;
	Fri, 23 May 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EcYmAI+s"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A1294A06;
	Fri, 23 May 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017354; cv=none; b=kQGu2dF7zpSzAQ5UnRiYtwmk1PAAgWjn6co460sOH/NXJAQB9HHLtlbMZH8RspIq2BrAuAx15TeCJ3Xk5EBTpUl0aMdo+A7IqPayVel2xSvplQVwMpvOEpcK+dJVLYnrpY8q35KSST/8hI9wJRXDAIewEUYQ6fBJAlf6ng019bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017354; c=relaxed/simple;
	bh=LAkicZJyK/FGZjxwtLmT18YGpM4Dm/qAEb9YYZlSY88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKoGudRD0tmofexxdLyWTLPFTS/PIOPguY4d9TrNgGYzbKbZAK7w54X0CZAYgU6rtze6LahJrtPGMSPSC9GKS5T4WOMqWsw2ODnuhS2fR8Rcr/wUNxt6fXYydpcMIbTztj+Zfz/lmGcIHJ6tZJQvJldzMLWXCP9pIC2pq9874/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EcYmAI+s; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748017350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p8BaeXySDEnnoBAKxDxDRFr2nIyJdWCYaT15SV7DAQI=;
	b=EcYmAI+sjd3M9P4tTqpTRafycWBQZR/9qBIAjVmmsoeTIA2aoyZgGTdS44r+Pukf31wjd5
	VfR2+BkJPxWJMrj5aJRQM2FOyhW/v5LjiJ5tvBn1SNxDwG0qWJHOs8GG5JAPBFa+HoNPsG
	ANhWGgqUpZLOM5Yir+Cv2zKH3BrF3yQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] bpf, sockmap: Fix psock incorrectly pointing to sk
Date: Sat, 24 May 2025 00:22:19 +0800
Message-ID: <20250523162220.52291-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We observed an issue from the latest selftest: sockmap_redir where
sk_psock(psock->sk) != psock in the backlog. The root cause is the special
behavior in sockmap_redir - it frequently performs map_update() and
map_delete() on the same socket. During map_update(), we create a new
psock and during map_delete(), we eventually free the psock via rcu_work
in sk_psock_drop(). However, pending workqueues might still exist and not
be processed yet. If users immediately perform another map_update(), a new
psock will be allocated for the same sk, resulting in two psocks pointing
to the same sk.

When the pending workqueue is later triggered, it uses the old psock to
access sk for I/O operations, which is incorrect.

Timing Diagram:

cpu0                        cpu1

map_update(sk):
    sk->psock = psock1
    psock1->sk = sk
map_delete(sk):
   rcu_work_free(psock1)

map_update(sk):
    sk->psock = psock2
    psock2->sk = sk
                            workqueue:
                                wakeup with psock1, but the sk of psock1
                                doesn't belong to psock1
rcu_handler:
    clean psock1
    free(psock1)

Previously, we used reference counting to address the concurrency issue
between backlog and sock_map_close(). This logic remains necessary as it
prevents the sk from being freed while processing the backlog. But this
patch prevents pending backlogs from using a psock after it has been
freed.

Note: We cannot call cancel_delayed_work_sync() in map_delete() since this
might be invoked in BPF context by BPF helper, and the function may sleep.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
Thanks to Michal Luczaj for providing the sockmap_redir test case, which
indeed covers almost all sockmap forwarding paths.
---
 include/linux/skmsg.h | 1 +
 net/core/skmsg.c      | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8..b17221eef2f4 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -67,6 +67,7 @@ struct sk_psock_progs {
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
 	SK_PSOCK_RX_STRP_ENABLED,
+	SK_PSOCK_DROPPED,
 };
 
 struct sk_psock_link {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 34c51eb1a14f..bd58a693ce9a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -656,6 +656,9 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	if (sk_psock_test_state(psock, SK_PSOCK_DROPPED))
+		return;
+
 	/* Increment the psock refcnt to synchronize with close(fd) path in
 	 * sock_map_close(), ensuring we wait for backlog thread completion
 	 * before sk_socket freed. If refcnt increment fails, it indicates
@@ -867,7 +870,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	sk_psock_stop(psock);
-
+	sk_psock_set_state(psock, SK_PSOCK_DROPPED);
 	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
 	queue_rcu_work(system_wq, &psock->rwork);
 }
-- 
2.47.1


