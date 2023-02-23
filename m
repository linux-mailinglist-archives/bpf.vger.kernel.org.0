Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662C6A1252
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBWVxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBWVxV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:53:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1037B5C
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c23so9618114pjo.4
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35lc6n2VyrJft9B4AEHWYTRNg0rcyVdGd4m6J+XpmF8=;
        b=Bchgv42bNqzPCf6Hn9manJQZwfOmAH7d2ReC1x6uAiCiTbeKcY9JL5D5Kjhb0An1ix
         oMnRPt9HvzxiQD8STFcdXltRS918AKnisJngwZ9ZyO2qyEx2ZvUVriu6b1EioX0FeASi
         6qQvO3rQ7uWEljyD9t978X/UzNGHYlxAFeiaBo7Y0cmiGzaQsBGSPnDkUh0J35NzY1BR
         l2K/lwP+1p5vF9R8T7IfBkg0VaipwsKWgYjGtkXxxQcrCtB+FcNyIHTyPI1/33KnEvOY
         FjamJB3cnAQgpRcmoTJOmxlvQmOaw3fbmMEfR4fiO3bY16xYiu+RmdCNfjU+qDuw9Kru
         TH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35lc6n2VyrJft9B4AEHWYTRNg0rcyVdGd4m6J+XpmF8=;
        b=OpjX8ehDwtnaclvlP9whywrWr3mIFOHWbs7xIUEf3zzgUPtyY1+fC6V5pMKzQM6beo
         NYeyTXL/3heNeKrHxm5JyRX6+9srw+gjrXmxMx9TEvtviPI+i3SSike2anDwTdiMKIAI
         Jv30WQ9AEr6ZsfK4ghgfYQ07trNDpDMc3PTPTJB4caWcrjucAYq9AapitAxGNIUXxB+1
         2b4s2zV1exLl2ov8UCBksLgH9cuOedJkZCs0t8cI1raXttOzyUMJPBxQRHtt8fMZ7hrO
         Lc4yWcpcJm231fIgymjbjgrNSCYVrQsrRm4EwwmVYsOdpoTDpPUyLgS9BccDviEWJSKK
         nuww==
X-Gm-Message-State: AO0yUKWfvJr3qv/zzOF6oBYixaBcBBc3gUbfM1fe9CrOH3IECevtibmT
        0BH7PDlSUGqLU77he0i/FTVtSkYZVTfRjmx3hnI=
X-Google-Smtp-Source: AK7set9Dyp4VaV6bHXl5bCUQYRwAd5yA7uz1+06mwQMzvC6qyireNvkonTV7MxTk7smO9TGJnj9hJQ==
X-Received: by 2002:a17:903:1205:b0:19c:36c9:2449 with SMTP id l5-20020a170903120500b0019c36c92449mr17100776plh.17.1677189199665;
        Thu, 23 Feb 2023 13:53:19 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0019c33ee4730sm8292686pld.146.2023.02.23.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:53:19 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
Date:   Thu, 23 Feb 2023 21:53:10 +0000
Message-Id: <20230223215311.926899-3-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223215311.926899-1-aditi.ghag@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The socket destroy kfunc is used to forcefully terminate sockets from
certain BPF contexts. We plan to use the capability in Cilium to force
client sockets to reconnect when their remote load-balancing backends are
deleted. The other use case is on-the-fly policy enforcement where existing
socket connections prevented by policies need to be forcefully terminated.
The helper allows terminating sockets that may or may not be actively
sending traffic.

The helper is currently exposed to certain BPF iterators where users can
filter, and terminate selected sockets.  Additionally, the helper can only
be called from these BPF contexts that ensure socket locking in order to
allow synchronous execution of destroy helpers that also acquire socket
locks. The previous commit that batches UDP sockets during iteration
facilitated a synchronous invocation of the destroy helper from BPF context
by skipping taking socket locks in the destroy handler. TCP iterators
already supported batching.

The helper takes `sock_common` type argument, even though it expects, and
casts them to a `sock` pointer. This enables the verifier to allow the
sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
`sock` structs. As a comparison, BPF helpers enable this behavior with the
`ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
option available with the verifier logic that handles kfuncs where BTF
types are inferred. Furthermore, as `sock_common` only has a subset of
certain fields of `sock`, casting pointer to the latter type might not
always be safe. Hence, the BPF kfunc converts the argument to a full sock
before casting.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/core/filter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 17 ++++++++++-----
 net/ipv4/udp.c    |  7 ++++--
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1d6f165923bf..79cd91ba13d0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11621,3 +11621,58 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 
 	return func;
 }
+
+/* Disables missing prototype warnings */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
+ *
+ * The helper expects a non-NULL pointer to a full socket. It invokes
+ * the protocol specific socket destroy handlers.
+ *
+ * The helper can only be called from BPF contexts that have acquired the socket
+ * locks.
+ *
+ * Parameters:
+ * @sock: Pointer to socket to be destroyed
+ *
+ * Return:
+ * On error, may return EPROTONOSUPPORT, EINVAL.
+ * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
+ * 0 otherwise
+ */
+int bpf_sock_destroy(struct sock_common *sock)
+{
+	/* Validates the socket can be type casted to a full socket. */
+	struct sock *sk = sk_to_full_sk((struct sock *)sock);
+
+	if (!sk)
+		return -EINVAL;
+
+	/* The locking semantics that allow for synchronous execution of the
+	 * destroy handlers are only supported for TCP and UDP.
+	 */
+	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
+		return -EOPNOTSUPP;
+
+	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
+}
+
+__diag_pop()
+
+BTF_SET8_START(sock_destroy_kfunc_set)
+BTF_ID_FLAGS(func, bpf_sock_destroy)
+BTF_SET8_END(sock_destroy_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &sock_destroy_kfunc_set,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock_destroy_kfunc_set);
+}
+late_initcall(init_subsystem);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 33f559f491c8..8123c264d8ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
 		return 0;
 	}
 
-	/* Don't race with userspace socket closes such as tcp_close. */
-	lock_sock(sk);
+	/* BPF context ensures sock locking. */
+	if (!has_current_bpf_ctx())
+		/* Don't race with userspace socket closes such as tcp_close. */
+		lock_sock(sk);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -4688,7 +4690,9 @@ int tcp_abort(struct sock *sk, int err)
 
 	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
 	local_bh_disable();
-	bh_lock_sock(sk);
+	if (!has_current_bpf_ctx())
+		bh_lock_sock(sk);
+
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		sk->sk_err = err;
@@ -4700,10 +4704,13 @@ int tcp_abort(struct sock *sk, int err)
 		tcp_done(sk);
 	}
 
-	bh_unlock_sock(sk);
+	if (!has_current_bpf_ctx())
+		bh_unlock_sock(sk);
+
 	local_bh_enable();
 	tcp_write_queue_purge(sk);
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_abort);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2f3978de45f2..1bc9ad92c3d4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
-	lock_sock(sk);
+	/* BPF context ensures sock locking. */
+	if (!has_current_bpf_ctx())
+		lock_sock(sk);
 
 	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
 	 * with close()
@@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
 	__udp_disconnect(sk, 0);
 
 out:
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 
 	return 0;
 }
-- 
2.34.1

