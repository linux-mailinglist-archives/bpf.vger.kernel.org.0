Return-Path: <bpf+bounces-15056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE37EAF68
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B728115D
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CC3E49E;
	Tue, 14 Nov 2023 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58983A28E;
	Tue, 14 Nov 2023 11:42:24 +0000 (UTC)
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 795DEA9;
	Tue, 14 Nov 2023 03:42:22 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADX3QkZXVNlXr9cAA--.24900S3;
	Tue, 14 Nov 2023 19:42:18 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next 1/3] skmsg: Calculate the data length in ingress_msg
Date: Tue, 14 Nov 2023 19:41:58 +0800
Message-Id: <1699962120-3390-2-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID:SyJltADX3QkZXVNlXr9cAA--.24900S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4UWF1UGw15uw45WryUJrb_yoW5Xw4xpF
	1DAa1UAa1UAFWxW393tFZ8Aw1agw1kGFyjkry7Aw4Sqr90kr1rJas8Jr1a9F1rtr1kCa1a
	qrsFgrs0kF13Ww7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VCjz48v1sIE
	Y20_Gr4lYx0Ec7CjxVAajcxG14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fU2CD7DUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Currently we cannot get the data length in ingress_msg,
we introduce sk_msg_queue_len() to do this.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 include/linux/skmsg.h | 24 ++++++++++++++++++++++--
 net/core/skmsg.c      |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c1637515a8a4..3023a573859d 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -82,6 +82,7 @@ struct sk_psock {
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				eval;
+	u32				msg_len;
 	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
@@ -131,6 +132,11 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
 bool sk_msg_is_readable(struct sock *sk);
 
+static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len)
+{
+	psock->msg_len -= len;
+}
+
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
 {
 	WARN_ON(i == msg->sg.end && bytes);
@@ -311,9 +317,10 @@ static inline void sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
-	else {
+		psock->msg_len += msg->sg.size;
+	} else {
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
@@ -368,6 +375,19 @@ static inline void kfree_sk_msg(struct sk_msg *msg)
 	kfree(msg);
 }
 
+static inline u32 sk_msg_queue_len(struct sock *sk)
+{
+	struct sk_psock *psock;
+	u32 len = 0;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock)
+		len = psock->msg_len;
+	rcu_read_unlock();
+	return len;
+}
+
 static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 {
 	struct sock *sk = psock->sk;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6c31eefbd777..b3de17e99b67 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -481,6 +481,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx = sk_psock_peek_msg(psock);
 	}
 out:
+	if (likely(!peek) && copied > 0)
+		sk_msg_queue_consumed(psock, copied);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
@@ -771,9 +773,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 
 	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
 		list_del(&msg->list);
+		sk_msg_queue_consumed(psock, msg->sg.size);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
+	WARN_ON_ONCE(psock->msg_len != 0);
 }
 
 static void __sk_psock_zap_ingress(struct sk_psock *psock)
-- 
2.38.1


