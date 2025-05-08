Return-Path: <bpf+bounces-57734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F396EAAF3AA
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 08:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C13AAA9C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359822135A6;
	Thu,  8 May 2025 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6vSFg8z"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97354AEE0
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685492; cv=none; b=L1tQLAQLXr9eDyy8S4fW/kVZgJNU/LoDWO5xvDjl9bbS7qjilPYRprZddtnm92JLoKbLWX5FGbxKRyyfDFQ3nmO9r8i8xIdVXUzw8FB8PtneCuB5NPtCwPt21/SUs8LBPfY3thuG/Z5R15LdpQqQ7IFU1tUBcYPB63HrtqNMipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685492; c=relaxed/simple;
	bh=p/VdULAVeF4K2Q+upl4+rwoadWVrqvXYpynC63s0o6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1kzNGFBJATcVpwXEuyswuGcgIYhqOQdZhho6VZi6qFA8gT0GcXQUCvhVNMKjWysr03h4wMU5DpfJH6WRfn+UzM4ZyfXW/ktYSuyEIqLowiNzjfRVI78auL3Vrit5BGy+Csc5vfSgLTT84UTILHJZygvWL3vRnZPNWzQWzqdkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6vSFg8z; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746685478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ei4PX0Vl85kv5sOEPUuFgHeGfJKMG2wW4+tzyXrfHA4=;
	b=j6vSFg8zlUnRI+4FgIxe8tjodDfHTAMbx/eAL+u4pKT4ndQ5QNRHZ94lMh/TRF/Cqqbi+W
	/bsYj5tiGWCmhD49SeWQOoH0x0IJc1GfOXvOr4eXAYeVCXciB4L2f90Ckd3Z5BRBfjQHtT
	Cq3VhrozBKPGFLEp7qGa3tzyOtsrzRI=
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
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] bpf, sockmap: Fix concurrency issues between memory charge and uncharge
Date: Thu,  8 May 2025 14:24:22 +0800
Message-ID: <20250508062423.51978-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Triggering WARN_ON_ONCE(sk->sk_forward_alloc) by running the following
command, followed by pressing Ctrl-C after 2 seconds:
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
'''
------------[ cut here ]------------
WARNING: CPU: 2 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct

Call Trace:
<TASK>
__sk_destruct+0x46/0x222
sk_psock_destroy+0x22f/0x242
process_one_work+0x504/0x8a8
? process_one_work+0x39d/0x8a8
? __pfx_process_one_work+0x10/0x10
? worker_thread+0x44/0x2ae
? __list_add_valid_or_report+0x83/0xea
? srso_return_thunk+0x5/0x5f
? __list_add+0x45/0x52
process_scheduled_works+0x73/0x82
worker_thread+0x1ce/0x2ae
'''

Reason:
When we are in the backlog process, we allocate sk_msg and then perform
the charge process. Meanwhile, in the user process context, the recvmsg()
operation performs the uncharge process, leading to concurrency issues
between them.

The charge process (2 functions):
1. sk_rmem_schedule(size) -> sk_forward_alloc increases by PAGE_SIZE
                             multiples
2. sk_mem_charge(size)    -> sk_forward_alloc -= size

The uncharge process (sk_mem_uncharge()):
3. sk_forward_alloc += size
4. check if sk_forward_alloc > PAGE_SIZE
5. reclaim    -> sk_forward_alloc decreases, possibly becoming 0

Because the sk performing charge and uncharge is not locked
(mainly because the backlog process does not lock the socket), therefore,
steps 1 to 5 will execute concurrently as follows:

cpu0                                cpu1
1
                                    3
                                    4   --> sk_forward_alloc >= PAGE_SIZE
                                    5   --> reclaim sk_forward_alloc
2 --> sk_forward_alloc may
      become negative

Solution:
1. Add locking to the kfree_sk_msg() process, which is only called in the
   user process context.
2. Integrate the charge process into sk_psock_create_ingress_msg() in the
   backlog process and add locking.
3. Reuse the existing psock->ingress_lock.

Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  7 +++++--
 net/core/skmsg.c      | 37 +++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8..3967b85ce1c0 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -378,10 +378,13 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
 	return psock ? list_empty(&psock->ingress_msg) : true;
 }
 
-static inline void kfree_sk_msg(struct sk_msg *msg)
+static inline void kfree_sk_msg(struct sk_psock *psock, struct sk_msg *msg)
 {
-	if (msg->skb)
+	if (msg->skb) {
+		spin_lock_bh(&psock->ingress_lock);
 		consume_skb(msg->skb);
+		spin_unlock_bh(&psock->ingress_lock);
+	}
 	kfree(msg);
 }
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..77c698627b16 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -480,7 +480,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx->sg.start = i;
 		if (!sge->length && (i == msg_rx->sg.end || sg_is_last(sge))) {
 			msg_rx = sk_psock_dequeue_msg(psock);
-			kfree_sk_msg(msg_rx);
+			kfree_sk_msg(psock, msg_rx);
 		}
 		msg_rx = sk_psock_peek_msg(psock);
 	}
@@ -514,16 +514,36 @@ static struct sk_msg *alloc_sk_msg(gfp_t gfp)
 	return msg;
 }
 
-static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
+static struct sk_msg *sk_psock_create_ingress_msg(struct sk_psock *psock,
+						  struct sock *sk,
 						  struct sk_buff *skb)
 {
+	spin_lock_bh(&psock->ingress_lock);
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		return NULL;
+		goto unlock_err;
 
 	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		return NULL;
+		goto unlock_err;
+
+	/* This will transition ownership of the data from the socket where
+	 * the BPF program was run initiating the redirect to the socket
+	 * we will eventually receive this data on. The data will be released
+	 * from consume_skb whether in sk_msg_recvmsg() after its been copied
+	 * into user buffers or in other skb release processes.
+	 */
+	skb_set_owner_r(skb, sk);
+	spin_unlock_bh(&psock->ingress_lock);
 
+	/* sk_msg itself is not under sk memory limitations and we only concern
+	 * sk_msg->skb, hence no lock protection is needed here. Furthermore,
+	 * adding a ingress_lock would trigger a warning from lockdep about
+	 * 'softirq-safe to softirq-unsafe'.
+	 */
 	return alloc_sk_msg(GFP_KERNEL);
+
+unlock_err:
+	spin_unlock_bh(&psock->ingress_lock);
+	return NULL;
 }
 
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
@@ -585,17 +605,10 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 */
 	if (unlikely(skb->sk == sk))
 		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-	msg = sk_psock_create_ingress_msg(sk, skb);
+	msg = sk_psock_create_ingress_msg(psock, sk, skb);
 	if (!msg)
 		return -EAGAIN;
 
-	/* This will transition ownership of the data from the socket where
-	 * the BPF program was run initiating the redirect to the socket
-	 * we will eventually receive this data on. The data will be released
-	 * from skb_consume found in __tcp_bpf_recvmsg() after its been copied
-	 * into user buffers.
-	 */
-	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
 		kfree(msg);
-- 
2.47.1


