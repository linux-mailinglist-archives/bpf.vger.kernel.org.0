Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249E06F6197
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjECWyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjECWyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A21244B7
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so10093555ad.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154444; x=1685746444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTgKptWHJObnX/MfocLy8Ls0Zk4vGnGa6alxIVryx/k=;
        b=KWYTrYyX8I+7W3DUJiJ22aZuiTM+VS6LGyVSBYbwS+/GcQ9+Z9pAvrcNj192Bqw4Nm
         57V/AJkmi//ejePadPZe/CQA+3j5oKoKek+T1GWx5pcsI7l8Uc7QBH0gA4k1k0RBs5uE
         FldI3A7kljEp9zQk2GMuIXLRmBpaiMUF+MWgZlDZc9cWi+yr+7iVl9uWmdoRPtzzMfWs
         b2NGc1TE7+dqOBPub+eIaat8gO2l+63rdD+S0+YoQLuSDWZfDFM0tBnyJ2PMddObW+5h
         6P0uuOY9w4BAqIqVwUGxi8FwyUpdKVJqV2eXTo3opD+79ejp4GDdnwMBQe+hr1KGvt8J
         f6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154444; x=1685746444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTgKptWHJObnX/MfocLy8Ls0Zk4vGnGa6alxIVryx/k=;
        b=UZDzCBNdMp0cFz4DeGfqQJdXbZ1oICVguMOzujEYiEcj7b04+W13i1n0XHcacRTcOI
         rY5rYWWDHdvvnBADa8Z1HKdtxUQXtWcWtSDnFudWrLO2IQ2gpzSSaRgqgGq2b2klaUDy
         MsVoVqFfc9NBGWgm6YIwjPWHmjvjkZeXYJS2CxSjI/l2bkpmOfwhIJNTgiGpreopxnoD
         trneaLMr6WkaK4mzBsQeG+24NxUrElaioaEq8Oh2oQhuaFHLYiSe/MA+0G11pvap9q6R
         WVL90Mz4u4XDbUx3kOADEmkYTjnavxX8f+kv0Sul7ifeDUbmVsnIW2PNLh275vm9nT2C
         Fscw==
X-Gm-Message-State: AC+VfDzrRbiJDTiAy9+cp4K2MdiEXvOeI8MDZyB5pnZrLTd1b4TxlL4l
        vWSnps3WR2u4HsYBwr+oUcg+jq0uchO/700clm8=
X-Google-Smtp-Source: ACHHUZ4dkVnFbUYBuslTsOWG1NCPuukk2M4sJTul2JjcEp63V6k2vehi4mscm3qUi/rmOlht6GjuEg==
X-Received: by 2002:a17:903:110f:b0:1a9:91a1:57bd with SMTP id n15-20020a170903110f00b001a991a157bdmr1903728plh.34.1683154443985;
        Wed, 03 May 2023 15:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:03 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com
Subject: [PATCH v7 bpf-next 06/10] bpf: Add bpf_sock_destroy kfunc
Date:   Wed,  3 May 2023 22:53:47 +0000
Message-Id: <20230503225351.3700208-7-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
filter, and terminate selected sockets. Additionally, the helper can only
be called from these BPF contexts that ensure socket locking in order to
allow synchronous execution of destroy helpers that also acquire socket
locks. The previous commit that batches UDP sockets during iteration
facilitated a synchronous invocation of the destroy helper from BPF context
by skipping taking socket locks in the destroy handler. TCP iterators
already supported batching.
Follow-up commits will ensure that the kfunc can only be called from
programs with `BPF_TRACE_ITER` attach type.

The helper takes `sock_common` type argument, even though it expects, and
casts them to a `sock` pointer. This enables the verifier to allow the
sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
`sock` structs. As a comparison, BPF helpers enable this behavior with the
`ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
option available with the verifier logic that handles kfuncs where BTF
types are inferred. Furthermore, as `sock_common` only has a subset of
certain fields of `sock`, casting pointer to the latter type might not
always be safe for certain sockets like request sockets, but these have
a special handling in the diag_destroy handlers.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/core/filter.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 10 ++++++---
 net/ipv4/udp.c    |  6 +++--
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 727c5269867d..97d70b7959a1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11715,3 +11715,60 @@ static int __init bpf_kfunc_init(void)
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 }
 late_initcall(bpf_kfunc_init);
+
+/* Disables missing prototype warnings */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
+ *
+ * The function expects a non-NULL pointer to a socket, and invokes the
+ * protocol specific socket destroy handlers.
+ *
+ * The helper can only be called from BPF contexts that have acquired the socket
+ * locks.
+ *
+ * Parameters:
+ * @sock: Pointer to socket to be destroyed
+ *
+ * Return:
+ * On error, may return EPROTONOSUPPORT, EINVAL.
+ * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
+ * 0 otherwise
+ */
+__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
+{
+	struct sock *sk = (struct sock *)sock;
+
+	if (!sk)
+		return -EINVAL;
+
+	/* The locking semantics that allow for synchronous execution of the
+	 * destroy handlers are only supported for TCP and UDP.
+	 * Supporting protocols will need to acquire lock_sock in the BPF context
+	 * prior to invoking this kfunc.
+	 */
+	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
+					   sk->sk_protocol != IPPROTO_UDP))
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
index 288693981b00..2259b4facc2f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4679,8 +4679,10 @@ int tcp_abort(struct sock *sk, int err)
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
@@ -4702,9 +4704,11 @@ int tcp_abort(struct sock *sk, int err)
 	}
 
 	bh_unlock_sock(sk);
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
index 150551acab9d..5f48cdf82a45 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
-	lock_sock(sk);
+	if (!has_current_bpf_ctx())
+		lock_sock(sk);
 
 	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
 	 * with close()
@@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
 	__udp_disconnect(sk, 0);
 
 out:
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 
 	return 0;
 }
-- 
2.34.1

