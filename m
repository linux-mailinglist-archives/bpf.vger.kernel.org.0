Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFC62BC6A
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKPLrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiKPLq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 06:46:26 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 39A652C5;
        Wed, 16 Nov 2022 03:32:37 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltADX31tDynRjv7gBAA--.7945S4;
        Wed, 16 Nov 2022 19:32:36 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf 2/4] bpf, sockmap: Fix missing BPF_F_INGRESS flag when using apply_bytes
Date:   Wed, 16 Nov 2022 19:29:19 +0800
Message-Id: <1668598161-15455-3-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668598161-15455-1-git-send-email-yangpc@wangsu.com>
References: <1668598161-15455-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID: SyJltADX31tDynRjv7gBAA--.7945S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7uF1xJr47Ar4kKF4xXrb_yoW8KryUpF
        sYya1fCFW7CrWjgw1ftFWvqF43uw1rKFyjkr1a9w1ft397Kr40qFn5GFy3ZF1Fyrs7Ca1S
        qF4UWrW5GF17Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When redirecting, we use sk_msg_to_ingress() to get the BPF_F_INGRESS
flag from the msg->flags. If apply_bytes is used and it is larger than
the current data being processed, sk_psock_msg_verdict() will not be
called when sendmsg() is called again. At this time, the msg->flags is 0,
and we lost the BPF_F_INGRESS flag.

So we need to save the BPF_F_INGRESS flag in sk_psock and assign it to
msg->flags before redirection.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 include/linux/skmsg.h | 1 +
 net/core/skmsg.c      | 1 +
 net/ipv4/tcp_bpf.c    | 1 +
 net/tls/tls_sw.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 48f4b64..e1d463f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -82,6 +82,7 @@ struct sk_psock {
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				eval;
+	u32				flags;
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 188f855..ab2f8f3 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -888,6 +888,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 		if (psock->sk_redir)
 			sock_put(psock->sk_redir);
 		psock->sk_redir = msg->sk_redir;
+		psock->flags = msg->flags;
 		if (!psock->sk_redir) {
 			ret = __SK_DROP;
 			goto out;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ef5de4f..1390d72 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -323,6 +323,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_REDIRECT:
 		sk_redir = psock->sk_redir;
+		msg->flags = psock->flags;
 		sk_msg_apply_bytes(psock, tosend);
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fe27241..49e424d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -838,6 +838,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		break;
 	case __SK_REDIRECT:
 		sk_redir = psock->sk_redir;
+		msg->flags = psock->flags;
 		memcpy(&msg_redir, msg, sizeof(*msg));
 		if (msg->apply_bytes < send)
 			msg->apply_bytes = 0;
-- 
1.8.3.1

