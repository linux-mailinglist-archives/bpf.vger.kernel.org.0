Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AB6D094B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjC3PTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjC3PTq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C0D336
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so18386513plg.4
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Pe+L74dLf3bG/I8RXaN8we2k3/vEMVt3UylCiPqjW4=;
        b=U8pVj0XWQrsSC9D8YgFSegV6eZbJyX/cX3BUXPCId+kBJjnorgM35D7Wu8slxWQCfE
         0nFI0BkEpuAfBiN+rh4GecmWfOX5pdaG/SUfKXXoWUbXH236m3Up677NmCBmOa0fS5SS
         7XpWCmK6DdOQLqCHkDIAvVqUd5Rf9lwQYTn4Qlh2OYhrdnEvrvdMwhDVq3UGaBzCCfln
         kwyqc7B48E5sXCTAYKmfwcCpki5F7T2ax0cqAAH7MBmLJGL4k1i6NbaPtR1h4Mqhbo1n
         n4DdI1eq1GB0k3tgNhbCrH44LGo1A4gQEYrFhX9SMNUwFJJDuLnSzpFDkQ8kuSkl7jUY
         y/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Pe+L74dLf3bG/I8RXaN8we2k3/vEMVt3UylCiPqjW4=;
        b=5gUmY4rz67boro1Zo5yoQ0xBCEO1kiCG1+jTad5bDEzYpOSOoaIhoyDxCZVUeYQiLU
         lff9i4rzChUtiJr+ppqmwLMb7L32SgGbH7ZuBDl1nBQ35u1h2jTMeHss9EbcfvS1QYpE
         uGdfqa/aMLaUMs2ZOKFEuLpZKvf2uovGWidGiWgx32AOlmq6XCVzX8h6FTEy65EYRu6g
         HHYWnE78sSqthkU/1GbNeS1G6YWZMJgndkT4675pDTBKpmKDWBwLJFxG3mlxCFegkJYv
         0niCJfF+htWHmc2Zm4H4xnwuDPphN2j5iNIi3RH69XGsR5B0JOpxHTk+Ubl3DdSsh8Q6
         NzSA==
X-Gm-Message-State: AO0yUKWNy/KpJiq6xU9JA3derNKPkD+9iJ9sSRwCSEORYgLeakPFRB9z
        cuMyadd20s6PuUReMjaAvBM8yS8mr7VW1z7cuGg=
X-Google-Smtp-Source: AK7set/GWaPNzOkR3FYhQrAy7sstmaeQM3BUjIJ2aQkHiAzsVp6r6ZMFL8of7uU7sSmq0BZWs01mYg==
X-Received: by 2002:a05:6a20:7788:b0:d9:18ab:16be with SMTP id c8-20020a056a20778800b000d918ab16bemr19660085pzg.29.1680189503425;
        Thu, 30 Mar 2023 08:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:21 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v5 bpf-next 5/7] bpf: Add bpf_sock_destroy kfunc
Date:   Thu, 30 Mar 2023 15:17:56 +0000
Message-Id: <20230330151758.531170-6-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 net/core/filter.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c    | 10 ++++++---
 net/ipv4/udp.c    |  6 ++++--
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3370efad1dda..a70c7b9876fa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11724,3 +11724,57 @@ static int __init bpf_kfunc_init(void)
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
index 9af23d1c8d6b..576a2ad272a7 100644
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

