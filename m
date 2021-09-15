Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829A40C707
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhIOOHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 10:07:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9878 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhIOOHO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 10:07:14 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8hhj5gh4z8yLV;
        Wed, 15 Sep 2021 22:01:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 22:05:52 +0800
Received: from huawei.com (10.175.101.6) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 15
 Sep 2021 22:05:51 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <lmb@cloudflare.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH] skmsg: lose offset info in sk_psock_skb_ingress
Date:   Wed, 15 Sep 2021 22:06:29 +0800
Message-ID: <20210915140629.18558-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If sockmap enable strparser, there are lose offset info in
sk_psock_skb_ingress. If the length determined by parse_msg function
is not skb->len, the skb will be converted to sk_msg multiple times,
and userspace app will get the data multiple times.

Fix this by get the offset and length from strp_msg.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/core/skmsg.c | 49 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2d6249b28928..83f76e568fad 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -9,6 +9,8 @@
 #include <net/tcp.h>
 #include <net/tls.h>
 
+static void sk_psock_strp_data_ready(struct sock *sk);
+
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
@@ -494,6 +496,7 @@ static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
 }
 
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
+					u32 off, u32 len,
 					struct sk_psock *psock,
 					struct sock *sk,
 					struct sk_msg *msg)
@@ -507,11 +510,11 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	 */
 	if (skb_linearize(skb))
 		return -EAGAIN;
-	num_sge = skb_to_sgvec(skb, msg->sg.data, 0, skb->len);
+	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
 	if (unlikely(num_sge < 0))
 		return num_sge;
 
-	copied = skb->len;
+	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
 	msg->sg.end = num_sge;
@@ -522,9 +525,11 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb);
+static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
+				     u32 off, u32 len);
 
-static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
+static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
+				u32 off, u32 len)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
@@ -535,7 +540,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
 	 * correctly.
 	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb);
+		return sk_psock_skb_ingress_self(psock, skb, off, len);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -547,7 +552,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -557,7 +562,8 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
  * skb. In this case we do not need to check memory limits or skb_set_owner_r
  * because the skb is already accounted for here.
  */
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb)
+static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
+				     u32 off, u32 len)
 {
 	struct sk_msg *msg = kzalloc(sizeof(*msg), __GFP_NOWARN | GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -567,7 +573,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 		return -EAGAIN;
 	sk_msg_init(msg);
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -581,7 +587,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	return sk_psock_skb_ingress(psock, skb);
+	return sk_psock_skb_ingress(psock, skb, off, len);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -604,6 +610,9 @@ static void sk_psock_backlog(struct work_struct *work)
 {
 	struct sk_psock *psock = container_of(work, struct sk_psock, work);
 	struct sk_psock_work_state *state = &psock->work_state;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	struct strp_msg *stm = NULL;
+#endif
 	struct sk_buff *skb = NULL;
 	bool ingress;
 	u32 len, off;
@@ -624,6 +633,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	while ((skb = skb_dequeue(&psock->ingress_skb))) {
 		len = skb->len;
 		off = 0;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+		if (psock->sk->sk_data_ready == sk_psock_strp_data_ready) {
+			stm = strp_msg(skb);
+			off = stm->offset;
+			len = stm->full_len;
+		}
+#endif
 start:
 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
@@ -930,6 +946,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 {
 	struct sock *sk_other;
 	int err = 0;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	struct strp_msg *stm = NULL;
+	u32 len, off;
+#endif
 
 	switch (verdict) {
 	case __SK_PASS:
@@ -949,7 +969,16 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		 * retrying later from workqueue.
 		 */
 		if (skb_queue_empty(&psock->ingress_skb)) {
-			err = sk_psock_skb_ingress_self(psock, skb);
+			len = skb->len;
+			off = 0;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+			if (psock->sk->sk_data_ready == sk_psock_strp_data_ready) {
+				stm = strp_msg(skb);
+				off = stm->offset;
+				len = stm->full_len;
+			}
+#endif
+			err = sk_psock_skb_ingress_self(psock, skb, off, len);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.17.1

