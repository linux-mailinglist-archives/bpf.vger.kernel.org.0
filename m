Return-Path: <bpf+bounces-4541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A974C5CB
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C301C28122F
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055610787;
	Sun,  9 Jul 2023 15:15:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F5D51C;
	Sun,  9 Jul 2023 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE92C433CC;
	Sun,  9 Jul 2023 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915698;
	bh=DRqy4J0FbsDMHpC4wjeM+awMaitWaE1HmYJLSpVI+2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uc3zJkIKilxoCNzjIfG7yl0fFwIGo9JP1sKbHTqfgvtdRD5PXV4j9inbOmV77MF6J
	 8g3yZTCyDBMeN7bEkImS5B2U2eDnXBpmfRwdMlq/HgO/Mw2vZovsgfmSgkuUlshe1m
	 ddqA/3vDdnrXA3Pmjo/6EnRliVqRlcl1M95JzJ1zBZHEI9RXY5W5LXNT8CctnATBTQ
	 v9RtClsq03v1AoD9a9DB32etDGbDrqY3ht4yVbde2JdAXVaRRfdMiRtYXi7r3bZqhU
	 +muXv4VQvBkmaTglYC5X7/dMxoIn+vzqwv2hoE0WKoMHzckLgCVpZJAtK0ZiIRU+jn
	 5BM7X++V7EXCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
	Yonghong Song <yhs@meta.com>,
	Stanislav Fomichev <sdf@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/18] bpf: tcp: Avoid taking fast sock lock in iterator
Date: Sun,  9 Jul 2023 11:14:34 -0400
Message-Id: <20230709151446.513549-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151446.513549-1-sashal@kernel.org>
References: <20230709151446.513549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.38
Content-Transfer-Encoding: 8bit

From: Aditi Ghag <aditi.ghag@isovalent.com>

[ Upstream commit 9378096e8a656fb5c4099b26b1370c56f056eab9 ]

This is a preparatory commit to replace `lock_sock_fast` with
`lock_sock`,and facilitate BPF programs executed from the TCP sockets
iterator to be able to destroy TCP sockets using the bpf_sock_destroy
kfunc (implemented in follow-up commits).

Previously, BPF TCP iterator was acquiring the sock lock with BH
disabled. This led to scenarios where the sockets hash table bucket lock
can be acquired with BH enabled in some path versus disabled in other.
In such situation, kernel issued a warning since it thinks that in the
BH enabled path the same bucket lock *might* be acquired again in the
softirq context (BH disabled), which will lead to a potential dead lock.
Since bpf_sock_destroy also happens in a process context, the potential
deadlock warning is likely a false alarm.

Here is a snippet of annotated stack trace that motivated this change:

```

Possible interrupt unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
 lock(&h->lhash2[i].lock);
                              local_bh_disable();
                              lock(&h->lhash2[i].lock);
kernel imagined possible scenario:
  local_bh_disable();  /* Possible softirq */
  lock(&h->lhash2[i].lock);
*** Potential Deadlock ***

process context:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH enabled
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

bpf_sock_destroy run from iterator:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH disabled
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
tcp_abort+0x10d/0x200
bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
bpf_iter_run_prog+0x1ff/0x340
------> lock_sock_fast that acquires sock lock with BH disabled
bpf_iter_tcp_seq_show+0xca/0x190
bpf_seq_read+0x177/0x450

```

Also, Yonghong reported a deadlock for non-listening TCP sockets that
this change resolves. Previously, `lock_sock_fast` held the sock spin
lock with BH which was again being acquired in `tcp_abort`:

```
watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
Call Trace:
 <TASK>
 _raw_spin_lock+0x84/0x90
 tcp_abort+0x13c/0x1f0
 bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
 bpf_iter_run_prog+0x1aa/0x2c0
 ? preempt_count_sub+0x1c/0xd0
 ? from_kuid_munged+0x1c8/0x210
 bpf_iter_tcp_seq_show+0x14e/0x1b0
 bpf_seq_read+0x36c/0x6a0

bpf_iter_tcp_seq_show
   lock_sock_fast
     __lock_sock_fast
       spin_lock_bh(&sk->sk_lock.slock);
	/* * Fast path return with bottom halves disabled and * sock::sk_lock.slock held.* */

 ...
 tcp_abort
   local_bh_disable();
   spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)

```

With the switch to `lock_sock`, it calls `spin_unlock_bh` before returning:

```
lock_sock
    lock_sock_nested
       spin_lock_bh(&sk->sk_lock.slock);
       :
       spin_unlock_bh(&sk->sk_lock.slock);
```

Acked-by: Yonghong Song <yhs@meta.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Link: https://lore.kernel.org/r/20230519225157.760788-2-aditi.ghag@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b37c1bcb15097..a7de5ba74e7f7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2911,7 +2911,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2919,7 +2918,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2943,7 +2942,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
-- 
2.39.2


