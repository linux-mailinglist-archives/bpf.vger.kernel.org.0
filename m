Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0717DE75
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgCILOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:14:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35592 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCILNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so10552762wro.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXYQbvQcpVVfxQJOftOtLbw866myUq7cAFw4ms5hCzI=;
        b=xFcofdtjFoUwBtvCbSm2iPdfivasWRGJkR53WQmyBVLv04AbNSdHAfQQzmbA5OE88U
         Xt8vdTlWliLZDQUymfBQ2a3NH8if6G8qj3NeUYwyvFq4bURnnlr8GWPtcsjfqcLDcDfk
         UF9KyEq4LGXwQHSjcsfqCE1p9eoq5cN2bVGZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXYQbvQcpVVfxQJOftOtLbw866myUq7cAFw4ms5hCzI=;
        b=SL6Q/+z5jUvOeRYMsCTUlD9pzUUv++MxrtYMYJN0pwV7rvWtWRLWIi8Zvvl0od6h4V
         70j117+BfhJmiUS/+D5wCzMO6o9ez4Nj2jArV1ZoF3r7ggRJpH9fGm8yzXeglKenSrBI
         pm17J8cA/ecaMO7y82GgBjZwe2ZzJxp7OG0sRbrAMFJR9ZU9Q2hT2coQzEKVyL6E8B3s
         fFtnuhgn16lty86U41Qeu39eT0fX2wM+4AryDo4H3ACfHVPifgQ8g/L+UIBTpX95EUCf
         AP2kcqfi8Xu+qhGXhqq/HFbRde8S0qUJrD0nU9BX9PrZ0FS2pdxvOmERzvha8xuxEJU1
         4o4w==
X-Gm-Message-State: ANhLgQ0N4HlzUVlcEtDx3QhxBPNfBdcYhszkU8cotOOfvEowl2zS3WXF
        ON/JbkK363/n9IqIJIy8+LPQMA==
X-Google-Smtp-Source: ADFU+vt7604NF4aclxTrcoVHcTHYp7wb/YpuXMQtBXRHz5ddOg6tyku4iGXZWaw8xkvrhcLh77Zqpw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr21767238wrx.25.1583752392194;
        Mon, 09 Mar 2020 04:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:11 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 02/12] skmsg: update saved hooks only once
Date:   Mon,  9 Mar 2020 11:12:33 +0000
Message-Id: <20200309111243.6982-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only update psock->saved_* if psock->sk_proto has not been initialized
yet. This allows us to get rid of tcp_bpf_reinit_sk_prot.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h | 20 ++++++++++++++++----
 net/ipv4/tcp_bpf.c    | 16 +---------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 4d3d75d63066..2be51b7a5800 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -347,11 +347,23 @@ static inline void sk_psock_update_proto(struct sock *sk,
 					 struct sk_psock *psock,
 					 struct proto *ops)
 {
-	psock->saved_unhash = sk->sk_prot->unhash;
-	psock->saved_close = sk->sk_prot->close;
-	psock->saved_write_space = sk->sk_write_space;
+	/* Initialize saved callbacks and original proto only once, since this
+	 * function may be called multiple times for a psock, e.g. when
+	 * psock->progs.msg_parser is updated.
+	 *
+	 * Since we've not installed the new proto, psock is not yet in use and
+	 * we can initialize it without synchronization.
+	 */
+	if (!psock->sk_proto) {
+		struct proto *orig = READ_ONCE(sk->sk_prot);
+
+		psock->saved_unhash = orig->unhash;
+		psock->saved_close = orig->close;
+		psock->saved_write_space = sk->sk_write_space;
+
+		psock->sk_proto = orig;
+	}
 
-	psock->sk_proto = sk->sk_prot;
 	/* Pairs with lockless read in sk_clone_lock() */
 	WRITE_ONCE(sk->sk_prot, ops);
 }
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 7d6e1b75d4d4..3327afa05c3d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -637,20 +637,6 @@ static void tcp_bpf_update_sk_prot(struct sock *sk, struct sk_psock *psock)
 	sk_psock_update_proto(sk, psock, &tcp_bpf_prots[family][config]);
 }
 
-static void tcp_bpf_reinit_sk_prot(struct sock *sk, struct sk_psock *psock)
-{
-	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
-	int config = psock->progs.msg_parser   ? TCP_BPF_TX   : TCP_BPF_BASE;
-
-	/* Reinit occurs when program types change e.g. TCP_BPF_TX is removed
-	 * or added requiring sk_prot hook updates. We keep original saved
-	 * hooks in this case.
-	 *
-	 * Pairs with lockless read in sk_clone_lock().
-	 */
-	WRITE_ONCE(sk->sk_prot, &tcp_bpf_prots[family][config]);
-}
-
 static int tcp_bpf_assert_proto_ops(struct proto *ops)
 {
 	/* In order to avoid retpoline, we make assumptions when we call
@@ -670,7 +656,7 @@ void tcp_bpf_reinit(struct sock *sk)
 
 	rcu_read_lock();
 	psock = sk_psock(sk);
-	tcp_bpf_reinit_sk_prot(sk, psock);
+	tcp_bpf_update_sk_prot(sk, psock);
 	rcu_read_unlock();
 }
 
-- 
2.20.1

