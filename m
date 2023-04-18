Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619476E682A
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjDRPcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjDRPcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9ADB
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a682eee3baso12157605ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831923; x=1684423923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q03tK4+7QCiPvv4pq1TZX4Aa8oEnCF+IJuLgtUqci9Q=;
        b=OLy9YjxWZ2q03SgsHUG2rziltYz97pPP6wE+4Mor9cwaP3yQydLVEbVNRNecCGppXi
         FoT3XhUN4YjQrdgd6FH9SHsPtHvO3aNwuDEsP4VkH8DKdhpzt4y86JOCy6q5e4LC2Zfi
         Ax0u990oz61Q8sgBqxRXjOWQQT2pU9DCmdi5DtJrathsGBz9BaQeT1c982HiX6YR2fmc
         mie0/mOcXBtm8Rg29bu5oPcocn7RQuhmgDCzZYKRd4q+sI9d91oCpCAdXZtXHvrs6j58
         dUvEXtHItZi9Ap0Cp48vRhVcxLra3zz7q1XoKFp3K5esRhNBW8sk/XiORQbgOnkowOWr
         cliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831923; x=1684423923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q03tK4+7QCiPvv4pq1TZX4Aa8oEnCF+IJuLgtUqci9Q=;
        b=Ffl7FqFCf9m5EVaNFwqzTN92HXfV9WeNr/sBfQOJOIvEL2CQMkqfTE/FVNsM90m07h
         DObRRcJLU3qNwRp1d+ETNjAGhFg2neGmu7b6LId+4j076+wf/VGzJRbeJavNGAklULkZ
         RssX0a1U9Qvm0y8IrYlNJPD+R3iN6U55VPT3oUozSIGwotbItI3t22TheM1Xl0D/874w
         DY6I7JHoD9vgIUFDkHpTJu0sAho7V9Z5Cp3jHhHejm1WpI7UBNv+LC/R/eOaFn7gXxBw
         yFeDyLJI+NcUzuZIB8yKgaNf4V/0wo6qbPz43S3x4oXvJfilTn9i4UtpaqCo3e3XjwdQ
         yaMA==
X-Gm-Message-State: AAQBX9flWPpy34AKEgMj3Wuge6krZMhdwOqZ6MaEotD5NCUVKePw625f
        t4sNxMxS//2T0LhBxp3/YFJnnPB2GpGOmji/9so=
X-Google-Smtp-Source: AKy350YdJCaxFHTRgpeSL4nOssszfJSh7lHbeGFFHTpoU4GKENZh/o/DC9ri2kyyunyRCoao6hJqCQ==
X-Received: by 2002:a17:902:f811:b0:1a6:46f2:4365 with SMTP id ix17-20020a170902f81100b001a646f24365mr2142192plb.30.1681831922920;
        Tue, 18 Apr 2023 08:32:02 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:32:02 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH 5/7] bpf: Add bpf_sock_destroy kfunc
Date:   Tue, 18 Apr 2023 15:31:46 +0000
Message-Id: <20230418153148.2231644-6-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
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
always be safe for certain sockets like request sockets, but these have
a special handling in the diag_destroy handlers.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/core/filter.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 10 ++++++---
 net/ipv4/udp.c    |  6 +++--
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 727c5269867d..7d1c1da77aa4 100644
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
+ * The helper expects a non-NULL pointer to a socket. It invokes the
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
+ * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
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
index f1c001641e53..a358a71839ef 100644
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

