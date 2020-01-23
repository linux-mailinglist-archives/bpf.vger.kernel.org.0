Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE386146D87
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAWPzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:55:44 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52368 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAWPzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:55:43 -0500
Received: by mail-wm1-f47.google.com with SMTP id p9so3107002wmc.2
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gLiUpm7tHLBpKzGOWJV2RBszAk1RrfTJZPAZfNAcDo=;
        b=eMNWesv/5D3hPVTrHtqC32D7vxtsA9qOYmsvJfgu6us2GVHHEkqPcDYGw7j70xdube
         tWm0fElCIE/aquXPZiRfeEOk2UrLmOJXCH2m0CIU44y0MGvGOlo+NytSz+brE/py4tqs
         /+SGC+g935ZgN0qqIiJSuYbSpll9H8cshfd2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gLiUpm7tHLBpKzGOWJV2RBszAk1RrfTJZPAZfNAcDo=;
        b=lor1Gh8LcS8cpAg2liPepCHhNqo34hD7NfsR6ezE6dH0uffn2vWORa9k7X3RpEvpCX
         6WJYx+pioZiolP44vm34eaI1phr/CnCmOzYPIoyhiX0nlhMgoQ1+KV1HKO1Nu+sEanGW
         zRBVXvF4ycIzxw2d5ujrEU9N0wzjb3WvrWd8C3mXgRaZ9KuXu+uhF81VKcEnSGyZl6cq
         8PtrXITJJQ/acotZEKn+UEWQ4rSAHB+J7uHAN/8jCHtDViX5ZZuxnIWzj2+dzPCQk7ic
         N+s/uXt72uKLfqmujKrkptkNZCYTRG56xZHbn3XSv/ZtwtING4NWKROdL3uusIY3Nov2
         5QiQ==
X-Gm-Message-State: APjAAAV/Vt+DBJ60BfIak6HsjCrm30KTB59mrqmp6W5pr9QxA+9SuQ/D
        QZUnjkNvX3QR1IEAqb2XtCO0qbWKiE0c0Q==
X-Google-Smtp-Source: APXvYqzCs7g2q11RRR7TcnaNBUny8UtlK9D018Sz4iVoRuuycDwkM7UiF8eCTjM0EphglyBmWyD4sQ==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr4791030wmg.3.1579794941185;
        Thu, 23 Jan 2020 07:55:41 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id s10sm3443300wrw.12.2020.01.23.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:55:40 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 04/12] tcp_bpf: Don't let child socket inherit parent protocol ops on copy
Date:   Thu, 23 Jan 2020 16:55:26 +0100
Message-Id: <20200123155534.114313-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123155534.114313-1-jakub@cloudflare.com>
References: <20200123155534.114313-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for cloning listening sockets that have their protocol callbacks
overridden by sk_msg. Child sockets must not inherit parent callbacks that
access state stored in sk_user_data owned by the parent.

Restore the child socket protocol callbacks before it gets hashed and any
of the callbacks can get invoked.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/tcp.h        |  7 +++++++
 net/ipv4/tcp_bpf.c       | 13 +++++++++++++
 net/ipv4/tcp_minisocks.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9dd975be7fdf..b969d5984f97 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2181,6 +2181,13 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		    int nonblock, int flags, int *addr_len);
 int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 		      struct msghdr *msg, int len, int flags);
+#ifdef CONFIG_NET_SOCK_MSG
+void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#else
+static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
+{
+}
+#endif
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
  * is < 0, then the BPF op failed (for example if the loaded BPF
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 4f25aba44ead..16060e0893a1 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -582,6 +582,19 @@ static void tcp_bpf_close(struct sock *sk, long timeout)
 	saved_close(sk, timeout);
 }
 
+/* If a child got cloned from a listening socket that had tcp_bpf
+ * protocol callbacks installed, we need to restore the callbacks to
+ * the default ones because the child does not inherit the psock state
+ * that tcp_bpf callbacks expect.
+ */
+void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
+{
+	struct proto *prot = newsk->sk_prot;
+
+	if (prot->unhash == tcp_bpf_unhash)
+		newsk->sk_prot = sk->sk_prot_creator;
+}
+
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ad3b56d9fa71..c8274371c3d0 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -548,6 +548,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->fastopen_req = NULL;
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
 
+	tcp_bpf_clone(sk, newsk);
+
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
 	return newsk;
-- 
2.24.1

