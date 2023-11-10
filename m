Return-Path: <bpf+bounces-14749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24187E7B0F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 10:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB12C1C20E61
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60791134A7;
	Fri, 10 Nov 2023 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EA12E41;
	Fri, 10 Nov 2023 09:44:31 +0000 (UTC)
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 01:44:28 PST
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A8525100;
	Fri, 10 Nov 2023 01:44:28 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAHDgow+01ldQtXAA--.23046S2;
	Fri, 10 Nov 2023 17:43:12 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next] bpf, sockmap: Bundle psock->sk_redir and redir_ingress into a tagged pointer
Date: Fri, 10 Nov 2023 17:41:42 +0800
Message-Id: <1699609302-8605-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:SyJltAAHDgow+01ldQtXAA--.23046S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Jw4rZr1DAr1kJF47urg_yoW7ZFW5pF
	s0ya1rCF4UGFy7Wwn3WFWUZF13Ww1rta4j9r17Aw1Sqwn0kF4FqF95Jr1UZF15trWkWa13
	Jr4UGFZ8CF17Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4fMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UuMKZUUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Like skb->_sk_redir, we bundle the sock redirect pointer and
the ingress bit to manage them together.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/87cz97cnz8.fsf@cloudflare.com
Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 include/linux/skmsg.h | 30 ++++++++++++++++++++++++++++--
 net/core/skmsg.c      | 18 ++++++++++--------
 net/ipv4/tcp_bpf.c    | 13 +++++++------
 net/tls/tls_sw.c      | 11 ++++++-----
 4 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c1637515a8a4..ae021f511f46 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -78,11 +78,10 @@ struct sk_psock_work_state {
 
 struct sk_psock {
 	struct sock			*sk;
-	struct sock			*sk_redir;
+	unsigned long			_sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
@@ -283,6 +282,33 @@ static inline struct sk_psock *sk_psock(const struct sock *sk)
 							 SK_USER_DATA_PSOCK);
 }
 
+static inline bool sk_psock_ingress(const struct sk_psock *psock)
+{
+	unsigned long sk_redir = psock->_sk_redir;
+
+	return sk_redir & BPF_F_INGRESS;
+}
+
+static inline void sk_psock_set_redir(struct sk_psock *psock, struct sock *sk_redir,
+				      bool ingress)
+{
+	psock->_sk_redir = (unsigned long)sk_redir;
+	if (ingress)
+		psock->_sk_redir |= BPF_F_INGRESS;
+}
+
+static inline struct sock *sk_psock_get_redir(struct sk_psock *psock)
+{
+	unsigned long sk_redir = psock->_sk_redir;
+
+	return (struct sock *)(sk_redir & ~(BPF_F_INGRESS));
+}
+
+static inline void sk_psock_clear_redir(struct sk_psock *psock)
+{
+	psock->_sk_redir = 0;
+}
+
 static inline void sk_psock_set_state(struct sk_psock *psock,
 				      enum sk_psock_state_bits bit)
 {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6c31eefbd777..d994621f1f95 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -811,6 +811,7 @@ static void sk_psock_destroy(struct work_struct *work)
 {
 	struct sk_psock *psock = container_of(to_rcu_work(work),
 					      struct sk_psock, rwork);
+	struct sock *sk_redir = sk_psock_get_redir(psock);
 	/* No sk_callback_lock since already detached. */
 
 	sk_psock_done_strp(psock);
@@ -824,8 +825,8 @@ static void sk_psock_destroy(struct work_struct *work)
 	sk_psock_link_destroy(psock);
 	sk_psock_cork_free(psock);
 
-	if (psock->sk_redir)
-		sock_put(psock->sk_redir);
+	if (sk_redir)
+		sock_put(sk_redir);
 	sock_put(psock->sk);
 	kfree(psock);
 }
@@ -865,6 +866,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 			 struct sk_msg *msg)
 {
 	struct bpf_prog *prog;
+	struct sock *sk_redir;
 	int ret;
 
 	rcu_read_lock();
@@ -880,17 +882,17 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
-		if (psock->sk_redir) {
-			sock_put(psock->sk_redir);
-			psock->sk_redir = NULL;
+		sk_redir = sk_psock_get_redir(psock);
+		if (sk_redir) {
+			sock_put(sk_redir);
+			sk_psock_clear_redir(psock);
 		}
 		if (!msg->sk_redir) {
 			ret = __SK_DROP;
 			goto out;
 		}
-		psock->redir_ingress = sk_msg_to_ingress(msg);
-		psock->sk_redir = msg->sk_redir;
-		sock_hold(psock->sk_redir);
+		sk_psock_set_redir(psock, msg->sk_redir, sk_msg_to_ingress(msg));
+		sock_hold(msg->sk_redir);
 	}
 out:
 	rcu_read_unlock();
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62fd2c2..b3c847dc87dc 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -427,14 +427,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		sk_msg_apply_bytes(psock, tosend);
 		break;
 	case __SK_REDIRECT:
-		redir_ingress = psock->redir_ingress;
-		sk_redir = psock->sk_redir;
+		redir_ingress = sk_psock_ingress(psock);
+		sk_redir = sk_psock_get_redir(psock);
 		sk_msg_apply_bytes(psock, tosend);
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
 			eval = psock->eval;
 			psock->eval = __SK_NONE;
-			psock->sk_redir = NULL;
+			sk_psock_clear_redir(psock);
 		}
 		if (psock->cork) {
 			cork = true;
@@ -476,9 +476,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	if (likely(!ret)) {
 		if (!psock->apply_bytes) {
 			psock->eval =  __SK_NONE;
-			if (psock->sk_redir) {
-				sock_put(psock->sk_redir);
-				psock->sk_redir = NULL;
+			sk_redir = sk_psock_get_redir(psock);
+			if (sk_redir) {
+				sock_put(sk_redir);
+				sk_psock_clear_redir(psock);
 			}
 		}
 		if (msg &&
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e9d1e83a859d..c91cd07c1285 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -854,8 +854,8 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		}
 		break;
 	case __SK_REDIRECT:
-		redir_ingress = psock->redir_ingress;
-		sk_redir = psock->sk_redir;
+		redir_ingress = sk_psock_ingress(psock);
+		sk_redir = sk_psock_get_redir(psock);
 		memcpy(&msg_redir, msg, sizeof(*msg));
 		if (msg->apply_bytes < send)
 			msg->apply_bytes = 0;
@@ -898,9 +898,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		}
 		if (reset_eval) {
 			psock->eval = __SK_NONE;
-			if (psock->sk_redir) {
-				sock_put(psock->sk_redir);
-				psock->sk_redir = NULL;
+			sk_redir = sk_psock_get_redir(psock);
+			if (sk_redir) {
+				sock_put(sk_redir);
+				sk_psock_clear_redir(psock);
 			}
 		}
 		if (rec)
-- 
2.38.1


