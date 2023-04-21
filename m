Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278D6EAF25
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjDUQba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjDUQba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5813F89
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94eff00bcdaso313559166b.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sla2xczs23esDZEG15Lv7nBusGLAuw/Jt8Jt6OQEXI=;
        b=MGl5lBQBMjiKmnGerILzG3v7Dui7n8+fuqm4u/nK9zoaY0BJfQCiu1XXKouTLQl7i7
         lUvYFrBu34RI52ERmBkTViHke/Rjh0VJ0SdBP7FzMsyzglg/ydeWAk5kAzobRvy0Is0O
         fjOC48mZMCqMT2CCOegD/G72FasD3rJHRYmAkPzaedRJI6N5MEshsCgsXTpyQNTJ1/8t
         t8VaUGqai14HQ0cASlkmiIQmXox3YpjYdDgLvKml6KygyC5wGWczoQNGub8/3baNAP+H
         LcF7YpsDWynqtjCbsf29XjwZJw+VgScHlcB5RUXBnI9lhWT3mZlkWe5jVE9suMzNhj2a
         T6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sla2xczs23esDZEG15Lv7nBusGLAuw/Jt8Jt6OQEXI=;
        b=EureGCzNjgt2vyY7yznLO3iGW5By2JatDUHC0gldMs0GKvOGoJWTSI5tXW/x+HgRT7
         AIPJ2LV4pqrvv2nWeIw69FiNYcwsfUUO3LHetNrnUzeW8EFTQ2+VZckqZUBMyQwttiC9
         DUDIQe8g8VyQrkMrepGcTx7wz0RGyt4OyCl+YGqIbjGHyxK54bc0j+dOhohnFLXf4QTC
         hWr7RRWyzHgyF2NC1cimlMNs4oNjwKHXht8sic1FCUd1IcJz2uDE+S0yoxWBheGASiBm
         SS+6YyEYu/tkHs15Fsb5yiAE5kRU9JlPN5z3tTxpKf6qBVz35OHPn8njSb5OpJZjKnLd
         L4+Q==
X-Gm-Message-State: AAQBX9fKei7TzWxzvkKfwYslzmD8k27Um5sAQ8GhbOAxou2tMiMzxdNu
        IsRlAMEFBbA3vdFZ98Jt8r6LXpbM2NJ8jg==
X-Google-Smtp-Source: AKy350bQ+wLenOQSL4k7/pBtkthZF4ye0Zt6yl+v3l4ie2DkSwP6xJr1QcOFxCNfIQf5NOg0JUfQLg==
X-Received: by 2002:a17:906:1814:b0:957:1292:6726 with SMTP id v20-20020a170906181400b0095712926726mr3349064eje.55.1682094684555;
        Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/10] bpf: Implement cgroup sockaddr hooks for unix sockets
Date:   Fri, 21 Apr 2023 18:27:14 +0200
Message-Id: <20230421162718.440230-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These hooks allows intercepting bind(), connect(), getsockname(),
getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
socket hooks get write access to the address length because the
address length is not fixed when dealing with unix sockets and
needs to be modified when a unix socket address is modified by
the hook. Because abstract socket unix addresses start with a
NUL byte, we cannot recalculate the socket address in kernelspace
after running the hook by calculating the length of the unix socket
path using strlen().

Write support is added for uaddrlen to allow the unix socket hooks
to modify the sockaddr length from the bpf program.

This hook can be used when users want to multiplex syscall to a
single unix socket to multiple different processes behind the scenes
by redirecting the connect() and other syscalls to process specific
sockets.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 include/linux/bpf-cgroup-defs.h |   6 ++
 include/linux/bpf-cgroup.h      |  29 ++++++++-
 include/uapi/linux/bpf.h        |  14 +++--
 kernel/bpf/cgroup.c             |  11 +++-
 kernel/bpf/syscall.c            |  18 ++++++
 kernel/bpf/verifier.c           |   7 ++-
 net/core/filter.c               |  17 +++++-
 net/unix/af_unix.c              | 102 +++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h  |  14 +++--
 9 files changed, 196 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..8196ccb81915 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -26,21 +26,27 @@ enum cgroup_bpf_attach_type {
 	CGROUP_DEVICE,
 	CGROUP_INET4_BIND,
 	CGROUP_INET6_BIND,
+	CGROUP_UNIX_BIND,
 	CGROUP_INET4_CONNECT,
 	CGROUP_INET6_CONNECT,
+	CGROUP_UNIX_CONNECT,
 	CGROUP_INET4_POST_BIND,
 	CGROUP_INET6_POST_BIND,
 	CGROUP_UDP4_SENDMSG,
 	CGROUP_UDP6_SENDMSG,
+	CGROUP_UNIX_SENDMSG,
 	CGROUP_SYSCTL,
 	CGROUP_UDP4_RECVMSG,
 	CGROUP_UDP6_RECVMSG,
+	CGROUP_UNIX_RECVMSG,
 	CGROUP_GETSOCKOPT,
 	CGROUP_SETSOCKOPT,
 	CGROUP_INET4_GETPEERNAME,
 	CGROUP_INET6_GETPEERNAME,
+	CGROUP_UNIX_GETPEERNAME,
 	CGROUP_INET4_GETSOCKNAME,
 	CGROUP_INET6_GETSOCKNAME,
+	CGROUP_UNIX_GETSOCKNAME,
 	CGROUP_INET_SOCK_RELEASE,
 	CGROUP_LSM_START,
 	CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index f3f5adf3881f..91138371f476 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -46,21 +46,27 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_DEVICE);
 	CGROUP_ATYPE(CGROUP_INET4_BIND);
 	CGROUP_ATYPE(CGROUP_INET6_BIND);
+	CGROUP_ATYPE(CGROUP_UNIX_BIND);
 	CGROUP_ATYPE(CGROUP_INET4_CONNECT);
 	CGROUP_ATYPE(CGROUP_INET6_CONNECT);
+	CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
 	CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
 	CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
 	CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
 	CGROUP_ATYPE(CGROUP_UDP6_SENDMSG);
+	CGROUP_ATYPE(CGROUP_UNIX_SENDMSG);
 	CGROUP_ATYPE(CGROUP_SYSCTL);
 	CGROUP_ATYPE(CGROUP_UDP4_RECVMSG);
 	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
+	CGROUP_ATYPE(CGROUP_UNIX_RECVMSG);
 	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
 	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
 	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
+	CGROUP_ATYPE(CGROUP_UNIX_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
+	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
 	default:
 		return CGROUP_BPF_ATTACH_TYPE_INVALID;
@@ -272,9 +278,13 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
+#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen)			\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_BIND, NULL)
+
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
 	((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||		       \
-	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
+	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT) ||		       \
+	  cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) &&		       \
 	 (sk)->sk_prot->pre_connect)
 
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)			\
@@ -283,24 +293,36 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)			\
 	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)			\
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
+
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
 
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)
+
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
 
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_SENDMSG, t_ctx)
+
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
 
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_RECVMSG, NULL)
+
 /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
  * fullsock and its parent fullsock cannot be traced by
  * sk_to_full_sk().
@@ -486,16 +508,21 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4b20a7269bee..58ed37ac0436 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1034,6 +1034,12 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
+	BPF_CGROUP_UNIX_BIND,
+	BPF_CGROUP_UNIX_CONNECT,
+	BPF_CGROUP_UNIX_SENDMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
+	BPF_CGROUP_UNIX_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2611,8 +2617,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **setsockopt()**.
  * 		It supports the following *level*\ s:
@@ -2850,8 +2856,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the same set of *optname*\ s that is supported by
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index c2191f0e138e..2cf01cbaf489 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1455,7 +1455,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * @flags: Pointer to u32 which contains higher bits of BPF program
  *         return value (OR'ed together).
  *
- * socket is expected to be of type INET or INET6.
+ * socket is expected to be of type INET, INET6 or UNIX.
  *
  * This function will return %-EPERM if an attached program is found and
  * returned value != 1 during execution. In all other cases, the new address
@@ -1481,7 +1481,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
 	 */
-	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
+		sk->sk_family != AF_UNIX)
 		return 0;
 
 	if (!ctx.uaddr) {
@@ -2511,10 +2512,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return NULL;
 		default:
 			return &bpf_get_retval_proto;
@@ -2526,10 +2530,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return NULL;
 		default:
 			return &bpf_set_retval_proto;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bcf1a1920ddd..170ec8ad38d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2390,16 +2390,22 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		switch (expected_attach_type) {
 		case BPF_CGROUP_INET4_BIND:
 		case BPF_CGROUP_INET6_BIND:
+		case BPF_CGROUP_UNIX_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
 		case BPF_CGROUP_UDP4_SENDMSG:
 		case BPF_CGROUP_UDP6_SENDMSG:
+		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
 			return 0;
 		default:
 			return -EINVAL;
@@ -3453,16 +3459,22 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_CGROUP_SOCK;
 	case BPF_CGROUP_INET4_BIND:
 	case BPF_CGROUP_INET6_BIND:
+	case BPF_CGROUP_UNIX_BIND:
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 	case BPF_CGROUP_INET4_GETPEERNAME:
 	case BPF_CGROUP_INET6_GETPEERNAME:
+	case BPF_CGROUP_UNIX_GETPEERNAME:
 	case BPF_CGROUP_INET4_GETSOCKNAME:
 	case BPF_CGROUP_INET6_GETSOCKNAME:
+	case BPF_CGROUP_UNIX_GETSOCKNAME:
 	case BPF_CGROUP_UDP4_SENDMSG:
 	case BPF_CGROUP_UDP6_SENDMSG:
+	case BPF_CGROUP_UNIX_SENDMSG:
 	case BPF_CGROUP_UDP4_RECVMSG:
 	case BPF_CGROUP_UDP6_RECVMSG:
+	case BPF_CGROUP_UNIX_RECVMSG:
 		return BPF_PROG_TYPE_CGROUP_SOCK_ADDR;
 	case BPF_CGROUP_SOCK_OPS:
 		return BPF_PROG_TYPE_SOCK_OPS;
@@ -3618,18 +3630,24 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_BIND:
 	case BPF_CGROUP_INET6_BIND:
+	case BPF_CGROUP_UNIX_BIND:
 	case BPF_CGROUP_INET4_POST_BIND:
 	case BPF_CGROUP_INET6_POST_BIND:
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 	case BPF_CGROUP_INET4_GETPEERNAME:
 	case BPF_CGROUP_INET6_GETPEERNAME:
+	case BPF_CGROUP_UNIX_GETPEERNAME:
 	case BPF_CGROUP_INET4_GETSOCKNAME:
 	case BPF_CGROUP_INET6_GETSOCKNAME:
+	case BPF_CGROUP_UNIX_GETSOCKNAME:
 	case BPF_CGROUP_UDP4_SENDMSG:
 	case BPF_CGROUP_UDP6_SENDMSG:
+	case BPF_CGROUP_UNIX_SENDMSG:
 	case BPF_CGROUP_UDP4_RECVMSG:
 	case BPF_CGROUP_UDP6_RECVMSG:
+	case BPF_CGROUP_UNIX_RECVMSG:
 	case BPF_CGROUP_SOCK_OPS:
 	case BPF_CGROUP_DEVICE:
 	case BPF_CGROUP_SYSCTL:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e05355facdc..3645a693c54e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13756,14 +13756,19 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
 		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG ||
+		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_RECVMSG ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETPEERNAME ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETPEERNAME ||
+		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETPEERNAME ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME)
+		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
+		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
 			range = tnum_range(1, 1);
 		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
 			range = tnum_range(0, 3);
+		if (env->prog->expected_attach_type == BPF_CGROUP_UNIX_BIND)
+			range = tnum_range(0, 1);
 		break;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 1c656e2d7b58..2f90fb3a9a64 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7747,6 +7747,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 			return &bpf_bind_proto;
 		default:
 			return NULL;
@@ -7775,16 +7776,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_BIND:
 		case BPF_CGROUP_INET6_BIND:
+		case BPF_CGROUP_UNIX_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
 		case BPF_CGROUP_UDP6_SENDMSG:
+		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_setsockopt_proto;
 		default:
 			return NULL;
@@ -7793,16 +7800,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_BIND:
 		case BPF_CGROUP_INET6_BIND:
+		case BPF_CGROUP_UNIX_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
 		case BPF_CGROUP_UDP6_SENDMSG:
+		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_getsockopt_proto;
 		default:
 			return NULL;
@@ -8850,8 +8863,8 @@ static bool sock_addr_is_valid_access(int off, int size,
 	if (off % size != 0)
 		return false;
 
-	/* Disallow access to IPv6 fields from IPv4 contex and vise
-	 * versa.
+	/* Disallow access to fields not belonging to the attach type's address
+	 * family.
 	 */
 	switch (off) {
 	case bpf_ctx_range(struct bpf_sock_addr, user_ip4):
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fb31e8a4409e..5109596e5437 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -116,6 +116,7 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf-cgroup.h>
 
 #include "scm.h"
 
@@ -1303,6 +1304,14 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	struct sock *sk = sock->sk;
 	int err;
 
+	if (cgroup_bpf_enabled(CGROUP_UNIX_BIND)) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, addr_len);
+		if (err < 0)
+			return err;
+
+		addr_len = err;
+	}
+
 	if (addr_len == offsetof(struct sockaddr_un, sun_path) &&
 	    sunaddr->sun_family == AF_UNIX)
 		return unix_autobind(sk);
@@ -1357,6 +1366,15 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		goto out;
 
 	if (addr->sa_family != AF_UNSPEC) {
+		if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
+			err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr,
+								    alen);
+			if (err < 0)
+				goto out;
+
+			alen = err;
+		}
+
 		err = unix_validate_addr(sunaddr, alen);
 		if (err)
 			goto out;
@@ -1465,6 +1483,15 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	int err;
 	int st;
 
+	if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr,
+							    addr_len);
+		if (err < 0)
+			goto out;
+
+		addr_len = err;
+	}
+
 	err = unix_validate_addr(sunaddr, addr_len);
 	if (err)
 		goto out;
@@ -1725,7 +1752,7 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	struct sock *sk = sock->sk;
 	struct unix_address *addr;
 	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, uaddr);
-	int err = 0;
+	int addr_len = 0, err = 0;
 
 	if (peer) {
 		sk = unix_peer_get(sk);
@@ -1742,14 +1769,39 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	if (!addr) {
 		sunaddr->sun_family = AF_UNIX;
 		sunaddr->sun_path[0] = 0;
-		err = offsetof(struct sockaddr_un, sun_path);
+		addr_len = offsetof(struct sockaddr_un, sun_path);
 	} else {
-		err = addr->len;
+		addr_len = addr->len;
 		memcpy(sunaddr, addr->name, addr->len);
 	}
+
+	if (peer && cgroup_bpf_enabled(CGROUP_UNIX_GETPEERNAME)) {
+		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, addr_len,
+					     CGROUP_UNIX_GETPEERNAME);
+		if (err < 0)
+			goto out;
+
+		addr_len = err;
+
+		err = unix_validate_addr(sunaddr, addr_len);
+		if (err)
+			goto out;
+	} else if (cgroup_bpf_enabled(CGROUP_UNIX_GETSOCKNAME)) {
+		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, addr_len,
+					     CGROUP_UNIX_GETSOCKNAME);
+		if (err < 0)
+			goto out;
+
+		addr_len = err;
+
+		err = unix_validate_addr(sunaddr, addr_len);
+		if (err)
+			goto out;
+	}
+
 	sock_put(sk);
 out:
-	return err;
+	return err ?: addr_len;
 }
 
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
@@ -1911,6 +1963,17 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 
 	if (msg->msg_namelen) {
+		if (cgroup_bpf_enabled(CGROUP_UNIX_SENDMSG)) {
+			err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
+								    msg->msg_name,
+								    msg->msg_namelen,
+								    NULL);
+			if (err < 0)
+				goto out;
+
+			msg->msg_namelen = err;
+		}
+
 		err = unix_validate_addr(sunaddr, msg->msg_namelen);
 		if (err)
 			goto out;
@@ -2418,14 +2481,32 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
 	return unix_dgram_recvmsg(sock, msg, size, flags);
 }
 
-static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
+static int unix_recvmsg_copy_addr(struct msghdr *msg, struct sock *sk)
 {
 	struct unix_address *addr = smp_load_acquire(&unix_sk(sk)->addr);
+	int err;
 
 	if (addr) {
 		msg->msg_namelen = addr->len;
 		memcpy(msg->msg_name, addr->name, addr->len);
+
+		if (cgroup_bpf_enabled(CGROUP_UNIX_RECVMSG)) {
+			err = BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
+								    msg->msg_name,
+								    msg->msg_namelen);
+			if (err < 0)
+				return err;
+
+			msg->msg_namelen = err;
+
+			err = unix_validate_addr(msg->msg_name,
+						 msg->msg_namelen);
+			if (err)
+				return err;
+		}
 	}
+
+	return 0;
 }
 
 int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
@@ -2480,8 +2561,11 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 						EPOLLOUT | EPOLLWRNORM |
 						EPOLLWRBAND);
 
-	if (msg->msg_name)
-		unix_copy_addr(msg, skb->sk);
+	if (msg->msg_name) {
+		err = unix_recvmsg_copy_addr(msg, skb->sk);
+		if (err)
+			goto out_free;
+	}
 
 	if (size > skb->len - skip)
 		size = skb->len - skip;
@@ -2835,7 +2919,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		if (state->msg && state->msg->msg_name) {
 			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
 					 state->msg->msg_name);
-			unix_copy_addr(state->msg, skb->sk);
+			err = unix_recvmsg_copy_addr(state->msg, skb->sk);
+			if (err)
+				break;
 			sunaddr = NULL;
 		}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4b20a7269bee..58ed37ac0436 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1034,6 +1034,12 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
+	BPF_CGROUP_UNIX_BIND,
+	BPF_CGROUP_UNIX_CONNECT,
+	BPF_CGROUP_UNIX_SENDMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
+	BPF_CGROUP_UNIX_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2611,8 +2617,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **setsockopt()**.
  * 		It supports the following *level*\ s:
@@ -2850,8 +2856,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the same set of *optname*\ s that is supported by
-- 
2.40.0

