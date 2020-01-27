Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459A914A49B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgA0NLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:11:09 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:40347 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgA0NLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:11:07 -0500
Received: by mail-lf1-f47.google.com with SMTP id c23so6153129lfi.7
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2faYqygbR37aPPmSyvnvEVhP/Ol5xmiYUyhpksjiNI=;
        b=n0dRutttuiOQXNHt6goaOOl/wPAIh1uo+nuV4mlQfsmPf2mUi3GizIdu0vj0m790Bh
         pttKYRDMBdoYEk6WtRp1gggnUR++UYwD9steIeu92bAs2LqZCvStgbtGwurZx7LZmx3I
         YbJU+bwD5JH41rL694/xcxv6sUsnelonGLn7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2faYqygbR37aPPmSyvnvEVhP/Ol5xmiYUyhpksjiNI=;
        b=h88H3GPTDkKajdX1dI7VN77f9dMJbD0nSYGs5FUKm2WdBSkT1PBrRQVtZYgZDJpcDu
         o3BUaSBoZFaHKicdNeDN7f56EPNN1vrOw0BNEHNW6qZmRah5useRVd1cHYaeOmlzHWWj
         7KTZKyFH6fTN/XK6BvEvIe/Ymz1VMP+diZ+e0HHIVk3/JR6pH+Tk9OZVU7hRkTeraRiM
         zqggexHacB6eHJXAAiTn0yMAgkkF3vgigolhMSfs+3tjOmnYilSyGUlcTY5ufH4QgyuT
         BbZtPh+x/F0mVZJc+zJjUcZhijWeYKg8A8dJFB+ycI42YsjOSpe0pIIH59bEE94LhU8D
         Dp7Q==
X-Gm-Message-State: APjAAAUbnSe59+CZyJU7ZnUNEgOFSI8907ZE9kRBf/f+0bH+X2+PrjhB
        B1pQZklbEYC+yXpK/quM6IAu+3CBHoQiUQ==
X-Google-Smtp-Source: APXvYqwovWpjMOYr07eqNQd6q/rC0gXf35T+0qOq7zq7J6cbCA3QPQDU/XSMTqlPm+lIHXx0KWYC1A==
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr8021692lfz.195.1580130665036;
        Mon, 27 Jan 2020 05:11:05 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j7sm4328317ljg.25.2020.01.27.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:11:04 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v6 04/12] tcp_bpf: Don't let child socket inherit parent protocol ops on copy
Date:   Mon, 27 Jan 2020 14:10:49 +0100
Message-Id: <20200127131057.150941-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127131057.150941-1-jakub@cloudflare.com>
References: <20200127131057.150941-1-jakub@cloudflare.com>
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
index a5ea27df3c2b..07f947cc80e6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2203,6 +2203,13 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
index dd183b050642..c0439c015341 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -579,6 +579,19 @@ static void tcp_bpf_close(struct sock *sk, long timeout)
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

