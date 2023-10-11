Return-Path: <bpf+bounces-11956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75537C5D0B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FB31C21065
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98F3A268;
	Wed, 11 Oct 2023 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge/+qnOL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DB3FB36;
	Wed, 11 Oct 2023 18:51:34 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167894;
	Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so158883f8f.1;
        Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050289; x=1697655089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mItP2rX9MC+7mb/qB6qihcZv6Z9Q/ntv6J3zqXuAe/M=;
        b=ge/+qnOLYNrZnXJykFQRwKsdcp++CMuj4i6U3WYcP3xYF5kWYfe3iNL1yelk0f3nKQ
         QwcNKlk+okjA9mJ1Xnse2MBxF4w3b7mAyl4kM0CUjxQ6GrahfaXbA/Vn2f+q1ZBXfsW4
         ePeX3WFFxqRt6MREi2v1xMSu822FXKJxIeusDpSaKBnjIbDAOMqmNvpu9y38DivjLacJ
         mIAxmUvCH8dLmXtfFSlzwsqu3f0G7aMbVQYJ2iHl6/rDUbBTVpTr9pPLHkEbiC6G/9mo
         xls7mD84C37/4vomdrHodmP9i6SupPbcosnrA/bVZm+ZDp4iFlQIeBENzuVj/h8znFmt
         81Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050289; x=1697655089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mItP2rX9MC+7mb/qB6qihcZv6Z9Q/ntv6J3zqXuAe/M=;
        b=DFtEOYjGRp/qsi3pyccsbOOzjlWvGYzlEHJY9PsEBFfbH94Whd0qzPZEUHUwbWSs3z
         0yQ6v9KdDibcflY2DP6m1okcCHK3AflJC4uJNHULoOXZfRcLWy4J5mylFG4T47SJMeTO
         SqSEg29/h0inDYuz/NBfpNXpcb4ATXoRuU9Yi0J/o71GY6Nsp2iOoycEsVEViLd/3kwC
         Y9v6GhjzGwvL4k6dOiBOzfF2YtdgVhbrk7EXUkhqsz05JmbDSd+OBYUotVF6atgxGszy
         k4VVstk47DjdZYapFUB/r7xC1as5n3u3ECymOqiRDR9i8+IGrKUvgqZTNs+gQEOzGP27
         OyAg==
X-Gm-Message-State: AOJu0Yzte4jz4tQ2Vw1TSZY99Mou6Po9BIPuM3xBuZtJ2n3FJzBygEMx
	XERSigZAXsNmkxRC1Y8SC3LdU1ZxCknZ96Ei
X-Google-Smtp-Source: AGHT+IF6q3iPKbMaS2S7PjvIa8FWdy1YvRWu38dF6x8MBAcvrDdg//kDGa2T6jyIwGMXW++uAHU2aw==
X-Received: by 2002:a5d:5b1b:0:b0:329:6e92:8d73 with SMTP id bx27-20020a5d5b1b000000b003296e928d73mr15586081wrb.67.1697050288848;
        Wed, 11 Oct 2023 11:51:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:28 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v11 4/9] bpf: Implement cgroup sockaddr hooks for unix sockets
Date: Wed, 11 Oct 2023 20:51:06 +0200
Message-ID: <20231011185113.140426-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These hooks allows intercepting connect(), getsockname(),
getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
socket hooks get write access to the address length because the
address length is not fixed when dealing with unix sockets and
needs to be modified when a unix socket address is modified by
the hook. Because abstract socket unix addresses start with a
NUL byte, we cannot recalculate the socket address in kernelspace
after running the hook by calculating the length of the unix socket
path using strlen().

These hooks can be used when users want to multiplex syscall to a
single unix socket to multiple different processes behind the scenes
by redirecting the connect() and other syscalls to process specific
sockets.

We do not implement support for intercepting bind() because when
using bind() with unix sockets with a pathname address, this creates
an inode in the filesystem which must be cleaned up. If we rewrite
the address, the user might try to clean up the wrong file, leaking
the socket in the filesystem where it is never cleaned up. Until we
figure out a solution for this (and a use case for intercepting bind()),
we opt to not allow rewriting the sockaddr in bind() calls.

We also implement recvmsg() support for connected streams so that
after a connect() that is modified by a sockaddr hook, any corresponding
recmvsg() on the connected socket can also be modified to make the
connected program think it is connected to the "intended" remote.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 include/linux/bpf-cgroup-defs.h |  5 +++++
 include/linux/bpf-cgroup.h      | 17 ++++++++++++++++
 include/uapi/linux/bpf.h        | 13 ++++++++----
 kernel/bpf/cgroup.c             | 11 +++++++++--
 kernel/bpf/syscall.c            | 15 ++++++++++++++
 kernel/bpf/verifier.c           |  5 ++++-
 net/core/filter.c               | 14 +++++++++++--
 net/unix/af_unix.c              | 35 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h  | 13 ++++++++----
 9 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..0985221d5478 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -28,19 +28,24 @@ enum cgroup_bpf_attach_type {
 	CGROUP_INET6_BIND,
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
index 31561e789715..98b8cea904fe 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -48,19 +48,24 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_INET6_BIND);
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
@@ -289,18 +294,27 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
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
@@ -492,10 +506,13 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
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
index 70bfa997e896..f5549f1077ba 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1047,6 +1047,11 @@ enum bpf_attach_type {
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
 	BPF_TRACE_UPROBE_MULTI,
+	BPF_CGROUP_UNIX_CONNECT,
+	BPF_CGROUP_UNIX_SENDMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
+	BPF_CGROUP_UNIX_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2704,8 +2709,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ *		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ *		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **setsockopt()**.
  * 		It supports the following *level*\ s:
@@ -2943,8 +2948,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ *		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ *		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the same set of *optname*\ s that is supported by
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8bee1d9a1154..127d0cc6cdb1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1458,7 +1458,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * @flags: Pointer to u32 which contains higher bits of BPF program
  *         return value (OR'ed together).
  *
- * socket is expected to be of type INET or INET6.
+ * socket is expected to be of type INET, INET6 or UNIX.
  *
  * This function will return %-EPERM if an attached program is found and
  * returned value != 1 during execution. In all other cases, 0 is returned.
@@ -1482,7 +1482,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
 	 */
-	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
+	    sk->sk_family != AF_UNIX)
 		return 0;
 
 	if (!ctx.uaddr) {
@@ -2532,10 +2533,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2547,10 +2551,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 6b5280f14a53..8677837f3deb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2446,14 +2446,19 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		case BPF_CGROUP_INET6_BIND:
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
@@ -3678,14 +3683,19 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_INET6_BIND:
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
@@ -3942,14 +3952,19 @@ static int bpf_prog_query(const union bpf_attr *attr,
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
index eed7350e15f4..e777f50401b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14797,10 +14797,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno)
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
diff --git a/net/core/filter.c b/net/core/filter.c
index cc2b9318f003..a173108d8c3c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7859,14 +7859,19 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
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
@@ -7877,14 +7882,19 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
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
@@ -8932,8 +8942,8 @@ static bool sock_addr_is_valid_access(int off, int size,
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
index 3e8a04a13668..e10d07c76044 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -116,6 +116,7 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf-cgroup.h>
 
 #include "scm.h"
 
@@ -1381,6 +1382,10 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			goto out;
 
+		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr, &alen);
+		if (err)
+			goto out;
+
 		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
 		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
 		    !unix_sk(sk)->addr) {
@@ -1490,6 +1495,10 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (err)
 		goto out;
 
+	err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, &addr_len);
+	if (err)
+		goto out;
+
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
 	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
 		err = unix_autobind(sk);
@@ -1770,6 +1779,13 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	} else {
 		err = addr->len;
 		memcpy(sunaddr, addr->name, addr->len);
+
+		if (peer)
+			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+					       CGROUP_UNIX_GETPEERNAME);
+		else
+			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+					       CGROUP_UNIX_GETSOCKNAME);
 	}
 	sock_put(sk);
 out:
@@ -1922,6 +1938,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = unix_validate_addr(sunaddr, msg->msg_namelen);
 		if (err)
 			goto out;
+
+		err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
+							    msg->msg_name,
+							    &msg->msg_namelen,
+							    NULL);
+		if (err)
+			goto out;
 	} else {
 		sunaddr = NULL;
 		err = -ENOTCONN;
@@ -2390,9 +2413,14 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 						EPOLLOUT | EPOLLWRNORM |
 						EPOLLWRBAND);
 
-	if (msg->msg_name)
+	if (msg->msg_name) {
 		unix_copy_addr(msg, skb->sk);
 
+		BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
+						      msg->msg_name,
+						      &msg->msg_namelen);
+	}
+
 	if (size > skb->len - skip)
 		size = skb->len - skip;
 	else if (size < skb->len - skip)
@@ -2744,6 +2772,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
 					 state->msg->msg_name);
 			unix_copy_addr(state->msg, skb->sk);
+
+			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
+							      state->msg->msg_name,
+							      &state->msg->msg_namelen);
+
 			sunaddr = NULL;
 		}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70bfa997e896..f5549f1077ba 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1047,6 +1047,11 @@ enum bpf_attach_type {
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
 	BPF_TRACE_UPROBE_MULTI,
+	BPF_CGROUP_UNIX_CONNECT,
+	BPF_CGROUP_UNIX_SENDMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
+	BPF_CGROUP_UNIX_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2704,8 +2709,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ *		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ *		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **setsockopt()**.
  * 		It supports the following *level*\ s:
@@ -2943,8 +2948,8 @@ union bpf_attr {
  * 		*bpf_socket* should be one of the following:
  *
  * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
- * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
- * 		  and **BPF_CGROUP_INET6_CONNECT**.
+ *		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
+ *		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the same set of *optname*\ s that is supported by
-- 
2.41.0


