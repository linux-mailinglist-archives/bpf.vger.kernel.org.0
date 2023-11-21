Return-Path: <bpf+bounces-15514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5B7F2B9F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE16AB21878
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C548782;
	Tue, 21 Nov 2023 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73662CA;
	Tue, 21 Nov 2023 03:22:32 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAXHQnxklxl4VxoAA--.27190S3;
	Tue, 21 Nov 2023 19:22:29 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next v2 1/3] skmsg: Support to get the data length in ingress_msg
Date: Tue, 21 Nov 2023 19:22:03 +0800
Message-Id: <1700565725-2706-2-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID:SyJltAAXHQnxklxl4VxoAA--.27190S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43ZFy5JF1rtF47GFy7Awb_yoWrXFWfpF
	1DAa1UAa1DArWxWwsayF45Aw1a9348Xa4jkry7Aw4SyrnYkr1rJF98Gr1YvF1rtr1kC3W7
	trsFgFs0kF13WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VCjz48v1sIE
	Y20_Gr4lYx0Ec7CjxVAajcxG14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8KwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7VU1Hq2tUUUUU==
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Currently msg is queued in ingress_msg of the target psock
on ingress redirect, without increment rcv_nxt. The size
that user can read includes the data in receive_queue and
ingress_msg. So we introduce sk_msg_queue_len() helper to
get the data length in ingress_msg.

Note that the msg_len does not include the data length of
msg from recevive_queue via SK_PASS, as they increment rcv_nxt
when received.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 include/linux/skmsg.h | 26 ++++++++++++++++++++++++--
 net/core/skmsg.c      | 10 +++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c1637515a8a4..423a5c28c606 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -47,6 +47,7 @@ struct sk_msg {
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				flags;
+	bool				ingress_self;
 	struct sk_buff			*skb;
 	struct sock			*sk_redir;
 	struct sock			*sk;
@@ -82,6 +83,7 @@ struct sk_psock {
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				eval;
+	u32				msg_len;
 	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
@@ -311,9 +313,11 @@ static inline void sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
-	else {
+		if (!msg->ingress_self)
+			WRITE_ONCE(psock->msg_len, psock->msg_len + msg->sg.size);
+	} else {
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
@@ -368,6 +372,24 @@ static inline void kfree_sk_msg(struct sk_msg *msg)
 	kfree(msg);
 }
 
+static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len)
+{
+	WRITE_ONCE(psock->msg_len, psock->msg_len - len);
+}
+
+static inline u32 sk_msg_queue_len(const struct sock *sk)
+{
+	struct sk_psock *psock;
+	u32 len = 0;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock)
+		len = READ_ONCE(psock->msg_len);
+	rcu_read_unlock();
+	return len;
+}
+
 static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 {
 	struct sock *sk = psock->sk;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6c31eefbd777..f46732a8ddc2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -415,7 +415,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 	struct iov_iter *iter = &msg->msg_iter;
 	int peek = flags & MSG_PEEK;
 	struct sk_msg *msg_rx;
-	int i, copied = 0;
+	int i, copied = 0, msg_copied = 0;
 
 	msg_rx = sk_psock_peek_msg(psock);
 	while (copied != len) {
@@ -441,6 +441,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			}
 
 			copied += copy;
+			if (!msg_rx->ingress_self)
+				msg_copied += copy;
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
@@ -481,6 +483,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx = sk_psock_peek_msg(psock);
 	}
 out:
+	if (likely(!peek) && msg_copied)
+		sk_msg_queue_consumed(psock, msg_copied);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
@@ -602,6 +606,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 
 	if (unlikely(!msg))
 		return -EAGAIN;
+	msg->ingress_self = true;
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
 	if (err < 0)
@@ -771,9 +776,12 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 
 	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
 		list_del(&msg->list);
+		if (!msg->ingress_self)
+			sk_msg_queue_consumed(psock, msg->sg.size);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
+	WARN_ON_ONCE(READ_ONCE(psock->msg_len) != 0);
 }
 
 static void __sk_psock_zap_ingress(struct sk_psock *psock)
-- 
2.38.1


