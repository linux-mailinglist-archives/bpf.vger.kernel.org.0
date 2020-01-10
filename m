Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC15136B50
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgAJKuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 05:50:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37607 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgAJKue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 05:50:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so1473455wmf.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSOc8HtZvYkJM5rYaYl9nPhVvbBd4A0Xwxb67WUxCEE=;
        b=n21GJdTBK2HRzsbeE+QhEL71dy1J+JQNQb9VbLXHTtNyF7GDCKfFFSy0MS2eTAcojD
         Ue2WUAoOUBJnhhPqotoCtYlfZkUtbzC+k80X9kSx9BvqXDK3CxrZDTK6RYGlFhlYLmYp
         1I72l+MzAhxbX9Yr4vmXF7o/JDfXVICIDoLdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSOc8HtZvYkJM5rYaYl9nPhVvbBd4A0Xwxb67WUxCEE=;
        b=Zi8GXMZ8yNeDNyt0+SskRgfLaUA98gM0zXYLTnyacgB9jXC/QQILPFjKwb8quEBXRv
         vQKo6Is7YTanM5vFYVIRBP2FogchQCgSH7hvDgvs1sZ/wuHyflKNaiC7i+84CAEXmhor
         +wczfnOp+gbPgtQQbtqIs9q3dpPJgASXFRJ2qLgbtQmk26b9IxJuQ41tY+yFHRx3OlNe
         D7PdbSEUcqRDwe9CTbO/GG68/D915nZwfMLAL4Nrt4nwzNv4ojFPTsr7BaR0Of9cZVVS
         xwHwBHKy8BG88zLBWE19P7Pw/qibJ7X/TZAcKb80LWoDOnJrt7CyRMGnOOTZ29yqYrym
         to0Q==
X-Gm-Message-State: APjAAAUpXjnoFjbZfgJC1FoB1fz2tD4EDEIfseN0xaFoNEn6dYp7dGvB
        LWC9NMW8TfwCdSHoOyhlgcRoq0lNHfEX5g==
X-Google-Smtp-Source: APXvYqwCd8w5/xPbkXXCTPkoEeYPvmC3xhFFCkvJzBbeEAWvw8X+I3OlXHaMG/rrVn6lnihquumVBw==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr3624456wmi.46.1578653432195;
        Fri, 10 Jan 2020 02:50:32 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n67sm1797185wmf.46.2020.01.10.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:50:31 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 02/11] net, sk_msg: Annotate lockless access to sk_prot on clone
Date:   Fri, 10 Jan 2020 11:50:18 +0100
Message-Id: <20200110105027.257877-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110105027.257877-1-jakub@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_msg and ULP frameworks override protocol callbacks pointer in
sk->sk_prot, while TCP accesses it locklessly when cloning the listening
socket.

Once we enable use of listening sockets with sockmap (and hence sk_msg),
there can be shared access to sk->sk_prot if socket is getting cloned while
being inserted/deleted to/from the sockmap from another CPU. Mark the
shared access with READ_ONCE/WRITE_ONCE annotations.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 2 +-
 net/core/sock.c       | 5 +++--
 net/ipv4/tcp_bpf.c    | 2 +-
 net/ipv4/tcp_ulp.c    | 2 +-
 net/tls/tls_main.c    | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 41ea1258d15e..d2d39d108354 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -352,7 +352,7 @@ static inline void sk_psock_update_proto(struct sock *sk,
 	psock->saved_write_space = sk->sk_write_space;
 
 	psock->sk_proto = sk->sk_prot;
-	sk->sk_prot = ops;
+	WRITE_ONCE(sk->sk_prot, ops);
 }
 
 static inline void sk_psock_restore_proto(struct sock *sk,
diff --git a/net/core/sock.c b/net/core/sock.c
index 8459ad579f73..96b4e8820ae8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1792,16 +1792,17 @@ static void sk_init_common(struct sock *sk)
  */
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 {
+	struct proto *prot = READ_ONCE(sk->sk_prot);
 	struct sock *newsk;
 	bool is_charged = true;
 
-	newsk = sk_prot_alloc(sk->sk_prot, priority, sk->sk_family);
+	newsk = sk_prot_alloc(prot, priority, sk->sk_family);
 	if (newsk != NULL) {
 		struct sk_filter *filter;
 
 		sock_copy(newsk, sk);
 
-		newsk->sk_prot_creator = sk->sk_prot;
+		newsk->sk_prot_creator = prot;
 
 		/* SANITY */
 		if (likely(newsk->sk_net_refcnt))
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e38705165ac9..e6ffdb47b619 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -649,7 +649,7 @@ static void tcp_bpf_reinit_sk_prot(struct sock *sk, struct sk_psock *psock)
 	 * or added requiring sk_prot hook updates. We keep original saved
 	 * hooks in this case.
 	 */
-	sk->sk_prot = &tcp_bpf_prots[family][config];
+	WRITE_ONCE(sk->sk_prot, &tcp_bpf_prots[family][config]);
 }
 
 static int tcp_bpf_assert_proto_ops(struct proto *ops)
diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 12ab5db2b71c..211af9759732 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -104,7 +104,7 @@ void tcp_update_ulp(struct sock *sk, struct proto *proto)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (!icsk->icsk_ulp_ops) {
-		sk->sk_prot = proto;
+		WRITE_ONCE(sk->sk_prot, proto);
 		return;
 	}
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index dac24c7aa7d4..d466b43c7eb6 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -740,7 +740,7 @@ static void tls_update(struct sock *sk, struct proto *p)
 	if (likely(ctx))
 		ctx->sk_proto = p;
 	else
-		sk->sk_prot = p;
+		WRITE_ONCE(sk->sk_prot, p);
 }
 
 static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
-- 
2.24.1

