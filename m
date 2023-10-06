Return-Path: <bpf+bounces-11524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530377BB292
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669728219D
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CDF9D3;
	Fri,  6 Oct 2023 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjeEEtrs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABE79F4;
	Fri,  6 Oct 2023 07:45:56 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5208E4;
	Fri,  6 Oct 2023 00:45:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c16bc71e4cso21694251fa.0;
        Fri, 06 Oct 2023 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696578351; x=1697183151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LdLM5SbHUC7yusZAsXHg6DPYXM27FYCy2WSzVJS68k=;
        b=mjeEEtrsjBEwIlkgvP1285yfnNpSU/eWsXuyC5+P84OXlyi+3WBhoRnME2xGVV4ZLa
         uhvWr9koIUfMQubolaHTaS9n6Rf3a2fHOgtU7QDofySdLGshJKiHfop05ge6Mh7dt9dE
         2xakYqyNX+SyNwC+/lbR+bwRoc16BVo+3v3lczX0uvwfnHtmcTv/pa+Gs91QqDZp4AbV
         LqFh3g78CEIlov/1eX3LsxMluMQx2XX1H7B4uzYfK1Q8bHb0dM9RqEVjEvqicLVMjP/m
         GGIcg1PnTywYPsbYXKvQ+T4y6gFSruoDwwQES/5TfLxHttzTXCoEjsqtmmT9PPpgX/LZ
         kH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578351; x=1697183151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LdLM5SbHUC7yusZAsXHg6DPYXM27FYCy2WSzVJS68k=;
        b=AhQURj1qxx/7ZfossMZUmmikfBtlHh/k0OHzPFWF35Y7v3GvQ5yOHTlUqkA+U1WDQN
         YtZOrVlrQZJmE+u3LOzf5tTJ8BObw6zwySZBLRGj3KfPnOhE2le1bnGQDL53WRTkPiqz
         CNewD20QnyxmMmVYqpeKABV/RblCXOOD7QpG0YmkofEGa+e/7CE+jwwO+F/Th/R0R1i8
         HFv4ET3hcAJPbTpFZLdtBBKvosmvlzXudRRux5CgdGMv0WrwQK07bSebbx6jCbutiwSB
         Y8rR52XMsh2ndKxJsDz1Yn0o5ZlG3YCYVqciYXjXWX/128xNwFMRIKwK3F4E61Cz2py+
         x78Q==
X-Gm-Message-State: AOJu0YwGbs3uXfqOKvaYx0lGAqJepxjLPZPxrRmnKpq0PggAkDE7v7Fg
	/wUM5b6mrsNHUrMJLRzhWAZiZM2z0EYw7S9/
X-Google-Smtp-Source: AGHT+IGFOZW8SN7md5sB7epswgWgbL0J/9ttkqbLi7nazB7m+xJOkKqJA8MqZeMgL+tl+r7ACZDIIA==
X-Received: by 2002:a2e:9090:0:b0:2c1:7473:f3e0 with SMTP id l16-20020a2e9090000000b002c17473f3e0mr7182320ljg.43.1696578351115;
        Fri, 06 Oct 2023 00:45:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm3126888wmi.27.2023.10.06.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:45:50 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v9 4/9] bpf: Implement cgroup sockaddr hooks for unix sockets
Date: Fri,  6 Oct 2023 09:44:58 +0200
Message-ID: <20231006074530.892825-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
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
 kernel/bpf/cgroup.c             | 11 ++++++++--
 kernel/bpf/syscall.c            | 15 ++++++++++++++
 kernel/bpf/verifier.c           |  5 ++++-
 net/core/filter.c               | 14 +++++++++++--
 net/unix/af_unix.c              | 36 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h  | 13 ++++++++----
 9 files changed, 115 insertions(+), 14 deletions(-)

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
index e6af22316909..19509dbaac65 100644
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
@@ -2534,10 +2535,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2549,10 +2553,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index bd1c42b28483..4c56b557fcca 100644
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
index 3e8a04a13668..804266af2cfa 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -116,6 +116,7 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf-cgroup.h>
 
 #include "scm.h"
 
@@ -1377,6 +1378,10 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		goto out;
 
 	if (addr->sa_family != AF_UNSPEC) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr, &alen);
+		if (err)
+			goto out;
+
 		err = unix_validate_addr(sunaddr, alen);
 		if (err)
 			goto out;
@@ -1486,6 +1491,10 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	int err;
 	int st;
 
+	err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, &addr_len);
+	if (err)
+		goto out;
+
 	err = unix_validate_addr(sunaddr, addr_len);
 	if (err)
 		goto out;
@@ -1771,6 +1780,14 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 		err = addr->len;
 		memcpy(sunaddr, addr->name, addr->len);
 	}
+
+	if (peer)
+		BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+				       CGROUP_UNIX_GETPEERNAME);
+	else
+		BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+				       CGROUP_UNIX_GETSOCKNAME);
+
 	sock_put(sk);
 out:
 	return err;
@@ -1919,6 +1936,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 
 	if (msg->msg_namelen) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
+							    msg->msg_name,
+							    &msg->msg_namelen,
+							    NULL);
+		if (err)
+			goto out;
+
 		err = unix_validate_addr(sunaddr, msg->msg_namelen);
 		if (err)
 			goto out;
@@ -2390,9 +2414,14 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
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
@@ -2744,6 +2773,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
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


