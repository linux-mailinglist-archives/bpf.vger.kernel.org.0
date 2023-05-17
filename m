Return-Path: <bpf+bounces-809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3151707036
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3031C20F03
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A831EF7;
	Wed, 17 May 2023 17:57:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2110966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:57:48 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC1213B
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643aad3bc41so1147282b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346266; x=1686938266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHAE+MZD2cHQQT4RbXcuwbLoGF9QyMBpdo0iXgu354g=;
        b=MTH2GObeCAjr2qNLbhzkyFBBvSW8pBDfMF/S/2wl3YDNS7YRucWm3AEAd85tUQ99jz
         /3HjfzmYACG0Fwsv2xgHhemS3QK6LtfTisXGrnzdNPW3VyBRHBKGL7ikCiiFYbdgJrCJ
         soERkASDm+tfF4FO0euzCoZC+asSXda28ZcZdktAffxj0W3xho8Rg6dfc7jJOenL2ocr
         hI7hfR+KdTd6RTa7Kyvzv2bL6fYOr13HOlLqe8fFjrSRrAvON/qGgXMwEtufHl2JxqML
         egfpSdo0mqH8pB/Uug39FU0jm8yPbwviFDiFaUzuH8rkSsQ1o9u0GlPCFBw03aXCIHk2
         1EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346266; x=1686938266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHAE+MZD2cHQQT4RbXcuwbLoGF9QyMBpdo0iXgu354g=;
        b=lj8u7hs26+pcDLDlheWDrfcOLd5KqB1aevaI2pIKDBx0V3ciYxKnKEcyURbWMnXBzJ
         LMMNgw0ywgwi2Yj4coeZRfrJcRdUaj7/yOlKWzP7KMRgmUBETQaYSJVpZnpuoAuwO296
         6UK5awQoLyJuYEfI20rw5QRaU693gpIJYc6AitU7Rnq5F9lpF8y+WmFPL48wXzJpYZad
         Frmj/5E4K249jHuJd0s8U0n9BglA4J0EcvOY2HonhULLsBd5nNbIp6EZxBSTsadQQp0J
         bVIeKUj5nCwE5+DxnzQ4PjWeI7YkLEFrcX4zkzwgF9ChwsxIkQIgVR0wiqr8eWDpcV7c
         Ghjw==
X-Gm-Message-State: AC+VfDxVM1nzUJm06f8uxH+0OTGBI/gm5GGEd4x8dAL29hBkUcAPJH5R
	hViYuyHKb976mUJ0FTRqunr7Q+Fh9pRe9LjM49s=
X-Google-Smtp-Source: ACHHUZ4pdy5FM38xlrlXiFW0oQmiBMu+IX7tUVcTIl3Nl8DELJF8uHPJK7wdIr6LthfORjrQgutpeQ==
X-Received: by 2002:a05:6a00:1949:b0:64a:6cad:d840 with SMTP id s9-20020a056a00194900b0064a6cadd840mr599155pfk.25.1684346266659;
        Wed, 17 May 2023 10:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j23-20020aa783d7000000b0063b488f3305sm10738943pfn.155.2023.05.17.10.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:57:46 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v8 bpf-next 06/10] bpf: Add bpf_sock_destroy kfunc
Date: Wed, 17 May 2023 17:57:41 +0000
Message-Id: <20230517175741.528212-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The socket destroy kfunc is used to forcefully terminate sockets from
certain BPF contexts. We plan to use the capability in Cilium
load-balancing to terminate client sockets that continue to connect to
deleted backends.  The other use case is on-the-fly policy enforcement
where existing socket connections prevented by policies need to be
forcefully terminated.  The kfunc also allows terminating sockets that may
or may not be actively sending traffic.

The kfunc is currently exposed to BPF TCP and UDP iterators where users can
filter, and terminate selected sockets. Additionally, it can only be called
from these BPF contexts that ensure socket locking in order to allow
synchronous execution of protocol specific diag_destroy handlers. The
previous commit that batches UDP sockets during iteration facilitated a
synchronous invocation of the UDP destroy callback from BPF context by
skipping socket locks in `udp_abort`. TCP iterator already supported
batching of sockets being iterated.  Follow-up commits will ensure that the
kfunc can only be called from such programs with `BPF_TRACE_ITER` attach
type.

The kfunc takes `sock_common` type argument, even though it expects, and
casts them to a `sock` pointer. This enables the verifier to allow the
sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
`sock` structs. Furthermore, as `sock_common` only has a subset of
certain fields of `sock`, casting pointer to the latter type might not
always be safe for certain sockets like request sockets, but these have a
special handling in the diag_destroy handlers.

Additionally, the kfunc is defined with `KF_TRUSTED_ARGS` flag to avoid the
cases where a `PTR_TO_BTF_ID` sk is obtained by following another pointer.
eg. getting a sk pointer (may be even NULL) by following another sk
pointer. The pointer socket argument passed in TCP and UDP iterators is
tagged as `PTR_TRUSTED` in {tcp,udp}_reg_info.  The TRUSTED arg changes
are contributed by Martin KaFai Lau <martin.lau@kernel.org>.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/core/filter.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c      |  9 +++++---
 net/ipv4/tcp_ipv4.c |  2 +-
 net/ipv4/udp.c      |  8 ++++---
 4 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 727c5269867d..0be10f6556df 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11715,3 +11715,57 @@ static int __init bpf_kfunc_init(void)
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
+	/* The locking semantics that allow for synchronous execution of the
+	 * destroy handlers are only supported for TCP and UDP.
+	 * Supporting protocols will need to acquire sock lock in the BPF context
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
+BTF_SET8_START(bpf_sk_iter_check_kfunc_set)
+BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
+BTF_SET8_END(bpf_sk_iter_check_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_sk_iter_check_kfunc_set,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sk_iter_kfunc_set);
+}
+late_initcall(init_subsystem);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 288693981b00..fd41fdc09211 100644
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
@@ -4704,7 +4706,8 @@ int tcp_abort(struct sock *sk, int err)
 	bh_unlock_sock(sk);
 	local_bh_enable();
 	tcp_write_queue_purge(sk);
-	release_sock(sk);
+	if (!has_current_bpf_ctx())
+		release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_abort);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f2d370a9450f..af75ddcbee62 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3354,7 +3354,7 @@ static struct bpf_iter_reg tcp_reg_info = {
 	.ctx_arg_info_size	= 1,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__tcp, sk_common),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED},
 	},
 	.get_func_proto		= bpf_iter_tcp_get_func_proto,
 	.seq_info		= &tcp_seq_info,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8fe2fd6255cc..289fbbec633e 100644
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
@@ -3641,7 +3643,7 @@ static struct bpf_iter_reg udp_reg_info = {
 	.ctx_arg_info_size	= 1,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__udp, udp_sk),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 	.seq_info		= &udp_seq_info,
 };
-- 
2.34.1


