Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017D4E030C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfJVLhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 07:37:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45375 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfJVLhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 07:37:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so16780653ljb.12
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xqrpc0hIvk7cC/XR6fxs+NuIUEIOeQSw7Q47oAnYusw=;
        b=BxyCCZY9d8ui0xczegbvwu8M0rvjNkHJJNWKBFcE3Wn0vdq7qeM7umSTxmwjPx+hF2
         AAExR35Po1dhjm9aCm3RLXiFjqiffq7JCy8IN0+TZGOIXfYa6Bbodl8CCEWP8gSlWMNj
         NjBQ/z0r0drJ1Jmlr844bX8/IoRSR2/+loNIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xqrpc0hIvk7cC/XR6fxs+NuIUEIOeQSw7Q47oAnYusw=;
        b=h1GIClgxMhLDHNM65bVgMeUyhUeEtBnQ4AoSLkgDkuWKVFiNYrds1zynFeGtUhgdpz
         B1ulkkT5e3TXp97i3KR0FWmR/fx72adwW6WboVr415NDahG0GnGCWymh8BvfY23/75Z1
         5yrj/zagIZTEW7+ujmUkDvFyFlfN2SVFuGTjX0i/A7EoLD7NowUwvERCwuKqQJkMr8zg
         +LogDcDtN9vwdqsgyWrSQoJu2B8O1Fzk+ILIaK+Npxp2kK1Cldx5hAqBfd4v3Eu75z6i
         2SZzJAYw7imrgwpbDbRZKNcdHBwLRWfjhlWU/RX/LkmnlCuHsavACOCh4D2eUthQEevB
         DhUg==
X-Gm-Message-State: APjAAAWcVCJIHl80F/ELYKuzVfgZee2liSf/7Ks4jg77NhVl8FSQ9qsy
        Nb3kwThfWmkjPcDaRbQ8ZilHpf1nB+h3VA==
X-Google-Smtp-Source: APXvYqxf2UQaxeP8A49EhisZtxHdK55KwLl2SealOI3tDBkDqZEVySUJViRPSOZNmIdk6IBxD1mB4w==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr17749694ljg.192.1571744256224;
        Tue, 22 Oct 2019 04:37:36 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id o196sm6362575lff.59.2019.10.22.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:37:35 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [RFC bpf-next 3/5] bpf, sockmap: Don't let child socket inherit psock or its ops on copy
Date:   Tue, 22 Oct 2019 13:37:28 +0200
Message-Id: <20191022113730.29303-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022113730.29303-1-jakub@cloudflare.com>
References: <20191022113730.29303-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

New sockets cloned from listening sockets that are in a sockmap must not
inherit the psock that has the link to the sockmap. Otherwise child sockets
unintentionally share the sockmap entry with the listening socket, which
leads to double-free on socket close.

Prevent it by overloading the accept callback. In it we restore the
protocol and write buffer callbacks and clear the pointer to psock.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/tcp_bpf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8a56e09cfb0e..5838aaba4ce0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -582,6 +582,35 @@ static void tcp_bpf_close(struct sock *sk, long timeout)
 	saved_close(sk, timeout);
 }
 
+static struct sock *tcp_bpf_accept(struct sock *sk, int flags, int *err,
+				   bool kern)
+{
+	void (*saved_write_space)(struct sock *sk);
+	struct proto *saved_proto;
+	struct sk_psock *psock;
+	struct sock *child;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		return sk->sk_prot->accept(sk, flags, err, kern);
+	}
+	saved_proto = psock->sk_proto;
+	saved_write_space = psock->saved_write_space;
+	rcu_read_unlock();
+
+	child = saved_proto->accept(sk, flags, err, kern);
+	if (!child)
+		return NULL;
+
+	/* Child must not inherit psock or its ops. */
+	rcu_assign_sk_user_data(child, NULL);
+	child->sk_prot = saved_proto;
+	child->sk_write_space = saved_write_space;
+	return child;
+}
+
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
@@ -606,6 +635,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].close		= tcp_bpf_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
+	prot[TCP_BPF_BASE].accept		= tcp_bpf_accept;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
-- 
2.20.1

