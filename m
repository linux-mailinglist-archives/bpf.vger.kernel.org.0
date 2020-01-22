Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA171454BB
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 14:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAVNGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 08:06:00 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:45901 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAVNF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 08:05:59 -0500
Received: by mail-lj1-f170.google.com with SMTP id j26so6666628ljc.12
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JjdJREQ2zttEU0s3bIX4pMOwpQo6iyj2JULQnJxcMk=;
        b=kC42uhHaySkK4xzi0ojC5CIT0K72E+g9zZxJ1P1yDEvOQ5yq5utvABTSW0P8lggXxc
         ZoyqN4+okFH/fWTU7+umN4PEEhcVQesw84OQtTYDZFT6tFLsQEjpfiW1Cchc+lXQ3zEL
         ZuVhMW4sQoMfn+l7IdGuFHxxmkS/nnKHbjlRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JjdJREQ2zttEU0s3bIX4pMOwpQo6iyj2JULQnJxcMk=;
        b=Vqsc98DtxLYn/o/qLZKFrusVtgSUGEPs9ceKclNyWrGCa77zAMCY9LzkRrHgaw9Bkm
         2cP3JVktbfzaLMvj7WrfwX2vaL5u5P2nrJpkm9+5YkmxX0iW8J0VtivdjXycHetWmTHR
         IE0xecoPt7urWlgKMK4STJMAzBFg0IZUtlsSzdrp5JqWwgrLKoRQWMs7wIhEyaAm2gF3
         wq8mJ6c9QOQEGgrl3GkLvyXdQepwNozLe94ORKh5T5qtju8qUbDsFFsRKCFRmyTG/opP
         /x7LO6PCFG6MG9qvKMCqaYEcQJUdNzy1oFfYKE5X0UpxmIQpP8meRXU7HX9iPtqD6dXr
         X/PA==
X-Gm-Message-State: APjAAAVlGvnU/5ORZruAEA8itjxeeIspS9YCi45yHxTiP3OyaPPHDYJi
        TjvjovLL+CKheqdkEMYCFeyMLtLsXdyZrw==
X-Google-Smtp-Source: APXvYqx9KQU+tz+UyVGHJ4cHw9kES1UYVSkM9qFHmPqeV1avljeo4OZ0TubCeky7Nd5kGhyNVwSd+g==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr19733735ljo.180.1579698357276;
        Wed, 22 Jan 2020 05:05:57 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i4sm23976820lji.0.2020.01.22.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:05:56 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 04/12] tcp_bpf: Don't let child socket inherit parent protocol ops on copy
Date:   Wed, 22 Jan 2020 14:05:41 +0100
Message-Id: <20200122130549.832236-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122130549.832236-1-jakub@cloudflare.com>
References: <20200122130549.832236-1-jakub@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/tcp.h        |  7 +++++++
 net/ipv4/tcp_bpf.c       | 13 +++++++++++++
 net/ipv4/tcp_minisocks.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9dd975be7fdf..ac205d31e4ad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2181,6 +2181,13 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		    int nonblock, int flags, int *addr_len);
 int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 		      struct msghdr *msg, int len, int flags);
+#ifdef CONFIG_NET_SOCK_MSG
+void tcp_bpf_clone(const struct sock *sk, struct sock *child);
+#else
+static inline void tcp_bpf_clone(const struct sock *sk, struct sock *child)
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

