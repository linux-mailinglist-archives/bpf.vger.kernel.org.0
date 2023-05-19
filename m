Return-Path: <bpf+bounces-982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237D70A2F5
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF21281C92
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73C12B76;
	Fri, 19 May 2023 22:52:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BE6FB7
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:15 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709CE45
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so1509186b3a.3
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536729; x=1687128729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MAjJaj0AEQuy2Iw4acPCDh/FYXHLowAZlKCeeqICxM=;
        b=DUi83XiLKZzEU7THDOQ9STE1Yk9ZteWHhvJne3Q4kRcSxGLzgTetT6qGYkGJ3miH9Y
         YeA1vgsNuO357fmQkub6Nmmz1GlAccB8h7NtiNqtoJVjJSmv+1uwQM/qQiZSTScUhEDG
         jHpupT8fNGtMYo9/20GhcBlXqhg8H2AlOSzXikFducs/4/t2LL0+qlhmOJA+nu5lzZsQ
         7/vM5EWpND61yMHUQPQYpxPaEUkHXFC4tznv7plRYLKnILcjSIXAEDLiEPt/FkkngBOG
         QKmu+YBrrbXzoUp1TfujsCmoH5ISRdQPUynrS1J2ELA/nXb/u9VqEabaWiIqkEHZsRwW
         /gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536729; x=1687128729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MAjJaj0AEQuy2Iw4acPCDh/FYXHLowAZlKCeeqICxM=;
        b=d1HJ4imiXjq43fWLzsigChN+ZK46PJmTzARKWubTnvsJp31nOD/9Q12OWdTTrGVumK
         09RQyqN+b7Gx9jAtfz0boIfN+1guqyN1ZwnAxNt7GayZK9sZRFYNWm1UbxnZTsvjG86t
         1uimj/CLO487ELs+T1dfbB21a3xcaoFEtYDRkgEr1d/mMcB0AM/O50Ykm0VpxHxczV6T
         4KXePsszC8JoFbADn0Fr6+p2tG0ey5mhsC7apg1/bfp7Co5V2koUUdtPH23vyzempH+9
         AgKEEZZZafeu/r6QEasCR/8a/BhATayRosORk+Zet/dhJY/Cz9mXe8qOACdhM47pUhla
         /ZZw==
X-Gm-Message-State: AC+VfDw4DPnAZQm93RlkqhuLVL8s7UDzJZuEBZiYuf7eIy8ySQUIN7vM
	nAMCiUUds7N9+JV8rNYG7qrjIr5kCI9fe2E2iqk=
X-Google-Smtp-Source: ACHHUZ6hRGgUdcSob52Aa4EatSOgeMZi/txYb9cnC2nOSh9niYXPzqWGpD3/+k6T0Sj5g4qb31YD7A==
X-Received: by 2002:a05:6a20:258e:b0:101:5037:7542 with SMTP id k14-20020a056a20258e00b0010150377542mr4290820pzd.10.1684536729093;
        Fri, 19 May 2023 15:52:09 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:08 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v9 bpf-next 7/9] bpf: Add bpf_sock_destroy kfunc
Date: Fri, 19 May 2023 22:51:55 +0000
Message-Id: <20230519225157.760788-8-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
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

The kfunc can currently be called only from BPF TCP and UDP iterators
where users can filter, and terminate selected sockets. More
specifically, it can only be called from  BPF contexts that ensure
socket locking in order to allow synchronous execution of protocol
specific `diag_destroy` handlers. The previous commit that batches UDP
sockets during iteration facilitated a synchronous invocation of the UDP
destroy callback from BPF context by skipping socket locks in
`udp_abort`. TCP iterator already supported batching of sockets being
iterated. To that end, `tracing_iter_filter` callback filter is added so
that verifier can restrict the kfunc to programs with `BPF_TRACE_ITER`
attach type, and reject other programs.

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
 net/core/filter.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c      |  9 ++++---
 net/ipv4/tcp_ipv4.c |  2 +-
 net/ipv4/udp.c      |  8 +++---
 4 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 727c5269867d..efeac5d8f19c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11715,3 +11715,66 @@ static int __init bpf_kfunc_init(void)
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
+static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&bpf_sk_iter_check_kfunc_set, kfunc_id) &&
+	    prog->expected_attach_type != BPF_TRACE_ITER)
+		return -EACCES;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_sk_iter_check_kfunc_set,
+	.filter = tracing_iter_filter,
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


