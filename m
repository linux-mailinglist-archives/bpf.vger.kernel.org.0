Return-Path: <bpf+bounces-11260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408D7B6587
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1153E282333
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316C1A722;
	Tue,  3 Oct 2023 09:30:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA12906;
	Tue,  3 Oct 2023 09:30:46 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB3CC;
	Tue,  3 Oct 2023 02:30:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9cd066db5so121337466b.0;
        Tue, 03 Oct 2023 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325440; x=1696930240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwE8u40xr2tZ8bP6He5hrJ7w+amwmr3fnH+PIjOBesU=;
        b=URYgm0M0S6noeZ/Dtt+D1xbGWtrYMyFAY3IQB/tzE/XhY2e+ZNBp7hXdfLkK2AXhE+
         gCv+7DyVb+9qrtfUIjLeYfkYgPirjvpXU45yrep2YjqezQoV544rV0k4OJX61BLQFSjz
         EFw9Hk5fGNKH2+zMrh2lVrvqVBNc4IY5gxWSHQiEFUAhRdScpFEW+oqKGv8t46IAVxST
         3xBnfzwvNUT2+88dfpD9PuDcSp/qHQJDe64zJJNEzn43LfhpAuXU2B7F9iZ7fCG29FCx
         ezOgsPwY6B6kvqo09Sk/J5WtUbXoSobhPMUar/5znatcCDQaNRgdWaPpOYUGJFTc1pnn
         uTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325440; x=1696930240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwE8u40xr2tZ8bP6He5hrJ7w+amwmr3fnH+PIjOBesU=;
        b=O5P1aYDnFc/y4btwMFAl1yTaO7YqHxRM5kKGQVsSpjaVdknvfgNvD7YVsdUy/Of/GG
         c5HnW91sWhtLge9iAgCfhUmtgujPZTq1yZ4najCR2/pNvwE6DM0JeoWc5Rvmftam08Gl
         dY77EUAiFW43+qyQmKhQYZv/Zur3O5k626qMg1A9j5P7vhthIzM1qZhObizLQkv9Yu4i
         CWPMaWd+KNrMxu/PyNaNfxsEFLMmUBA3xWX7FcMPzOdph+4lSL8QGVvmQ4DV2cQdeS4I
         +8NU9At00sXuUu4XFtGij0gbc6PHMe6OlByCoRq16D51LSE/H57YB7u0RK7n8r+jaiKv
         3E5A==
X-Gm-Message-State: AOJu0Yxbp24NotH4yys4GDhHfgs5A+YIhYrBVnycqnRQm0Dn4QJrGKhc
	EhUWCkgNtyYkiFW5nmfnYaeFHV/iZKvLCSom
X-Google-Smtp-Source: AGHT+IHzglsWYqS+dlKxljYoJCWeihS8rewc2+/NCNOEkCBxVl/K+vbofjhW7mU7F7z0gL7CHRldYg==
X-Received: by 2002:a17:906:518e:b0:9ae:5fe1:ef03 with SMTP id y14-20020a170906518e00b009ae5fe1ef03mr12965233ejk.67.1696325439865;
        Tue, 03 Oct 2023 02:30:39 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-15f4-3ba0-176b-cb00.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:15f4:3ba0:176b:cb00])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906594500b0098f33157e7dsm749851ejr.82.2023.10.03.02.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:30:39 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
Date: Tue,  3 Oct 2023 11:30:16 +0200
Message-ID: <20231003093025.475450-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As prep for adding unix socket support to the cgroup sockaddr hooks,
let's propagate the sockaddr length back to the caller after running
a bpf cgroup sockaddr hook program. While not important for AF_INET or
AF_INET6, the sockaddr length is important when working with AF_UNIX
sockaddrs as the size of the sockaddr cannot be determined just from the
address family or the sockaddr's contents.

__cgroup_bpf_run_filter_sock_addr() is modified to take the uaddrlen as
an input/output argument. After running the program, the modified sockaddr
length is stored in the uaddrlen pointer.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 include/linux/bpf-cgroup.h | 73 +++++++++++++++++++-------------------
 include/linux/filter.h     |  1 +
 kernel/bpf/cgroup.c        | 20 +++++++++--
 net/ipv4/af_inet.c         |  7 ++--
 net/ipv4/ping.c            |  2 +-
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/udp.c             |  9 +++--
 net/ipv6/af_inet6.c        |  9 ++---
 net/ipv6/ping.c            |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 net/ipv6/udp.c             |  6 ++--
 11 files changed, 78 insertions(+), 55 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8506690dbb9c..31561e789715 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags);
@@ -230,22 +231,22 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
 
-#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
+#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)		       \
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))					       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  NULL, NULL);	       \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+							  atype, NULL, NULL);  \
 	__ret;								       \
 })
 
-#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
+#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)	       \
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  t_ctx, NULL);	       \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+							  atype, t_ctx, NULL); \
 		release_sock(sk);					       \
 	}								       \
 	__ret;								       \
@@ -256,14 +257,14 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
  * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
  * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
  */
-#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, bind_flags)	       \
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, bind_flags) \
 ({									       \
 	u32 __flags = 0;						       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  NULL, &__flags);     \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+							  atype, NULL, &__flags); \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
 			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
@@ -276,29 +277,29 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
 	 (sk)->sk_prot->pre_connect)
 
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)			\
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT)
 
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET6_CONNECT)
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)			\
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
 
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET4_CONNECT, NULL)
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
 
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET6_CONNECT, NULL)
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
 
-#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_SENDMSG, t_ctx)
+#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
 
-#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_SENDMSG, t_ctx)
+#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
 
-#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr)			\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_RECVMSG, NULL)
+#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
 
-#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr)			\
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_RECVMSG, NULL)
+#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
 
 /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
  * fullsock and its parent fullsock cannot be traced by
@@ -477,24 +478,24 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 }
 
 #define cgroup_bpf_enabled(atype) (0)
-#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
-#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
+#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) ({ 0; })
+#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, flags) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 27406aee2d40..a3c74fbe848b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1335,6 +1335,7 @@ struct bpf_sock_addr_kern {
 	 */
 	u64 tmp_reg;
 	void *t_ctx;	/* Attach type specific context. */
+	u32 uaddrlen;
 };
 
 struct bpf_sock_ops_kern {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03b3d4492980..e6af22316909 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1450,6 +1450,9 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  *                                       provided by user sockaddr
  * @sk: sock struct that will use sockaddr
  * @uaddr: sockaddr struct provided by user
+ * @uaddrlen: Pointer to the size of the sockaddr struct provided by user. It is
+ *            read-only for AF_INET[6] uaddr but can be modified for AF_UNIX
+ *            uaddr.
  * @atype: The type of program to be executed
  * @t_ctx: Pointer to attach type specific context
  * @flags: Pointer to u32 which contains higher bits of BPF program
@@ -1462,6 +1465,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags)
@@ -1473,6 +1477,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	};
 	struct sockaddr_storage unspec;
 	struct cgroup *cgrp;
+	int ret;
 
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
@@ -1483,11 +1488,20 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	if (!ctx.uaddr) {
 		memset(&unspec, 0, sizeof(unspec));
 		ctx.uaddr = (struct sockaddr *)&unspec;
-	}
+		ctx.uaddrlen = 0;
+	} else if (uaddrlen)
+		ctx.uaddrlen = *uaddrlen;
+	else
+		return -EINVAL;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
-				     0, flags);
+	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
+				    0, flags);
+
+	if (!ret && uaddrlen)
+		*uaddrlen = ctx.uaddrlen;
+
+	return ret;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3d2e30e20473..7e27ad37b939 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -452,7 +452,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
 						 CGROUP_INET4_BIND, &flags);
 	if (err)
 		return err;
@@ -788,6 +788,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 	struct sock *sk		= sock->sk;
 	struct inet_sock *inet	= inet_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
+	int sin_addr_len = sizeof(*sin);
 
 	sin->sin_family = AF_INET;
 	lock_sock(sk);
@@ -800,7 +801,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -808,7 +809,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 			addr = inet->inet_saddr;
 		sin->sin_port = inet->inet_sport;
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
 				       CGROUP_INET4_GETSOCKNAME);
 	}
 	release_sock(sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 4dd809b7b188..2887177822c9 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -301,7 +301,7 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03..7c18dd3ce011 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -194,7 +194,7 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, &addr_len);
 }
 
 /* This will initiate an outgoing connection. */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c3ff984b6354..7b21a51dd25a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1143,7 +1143,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin, &ipc.addr);
+					    (struct sockaddr *)usin,
+					    &msg->msg_namelen,
+					    &ipc.addr);
 		if (err)
 			goto out_free;
 		if (usin) {
@@ -1865,7 +1867,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		*addr_len = sizeof(*sin);
 
 		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin);
+						      (struct sockaddr *)sin,
+						      addr_len);
 	}
 
 	if (udp_test_bit(GRO_ENABLED, sk))
@@ -1904,7 +1907,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index c6ad0d6e99b5..f5817f8150dd 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -454,7 +454,7 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
 						 CGROUP_INET6_BIND, &flags);
 	if (err)
 		return err;
@@ -520,6 +520,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer)
 {
 	struct sockaddr_in6 *sin = (struct sockaddr_in6 *)uaddr;
+	int sin_addr_len = sizeof(*sin);
 	struct sock *sk = sock->sk;
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -539,7 +540,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		sin->sin6_addr = sk->sk_v6_daddr;
 		if (inet6_test_bit(SNDFLOW, sk))
 			sin->sin6_flowinfo = np->flow_label;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
 				       CGROUP_INET6_GETPEERNAME);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -547,13 +548,13 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		else
 			sin->sin6_addr = sk->sk_v6_rcv_saddr;
 		sin->sin6_port = inet->inet_sport;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
 				       CGROUP_INET6_GETSOCKNAME);
 	}
 	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
 						 sk->sk_bound_dev_if);
 	release_sock(sk);
-	return sizeof(*sin);
+	return sin_addr_len;
 }
 EXPORT_SYMBOL(inet6_getname);
 
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index e8fb0d275cc2..d2098dd4ceae 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -56,7 +56,7 @@ static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
 static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 94afb8d0f2d0..3a1e76a2d33e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -135,7 +135,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }
 
 static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5e9312eefed0..622b10a549f7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -410,7 +410,8 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		*addr_len = sizeof(*sin6);
 
 		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin6);
+						      (struct sockaddr *)sin6,
+						      addr_len);
 	}
 
 	if (udp_test_bit(GRO_ENABLED, sk))
@@ -1157,7 +1158,7 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
 /**
@@ -1510,6 +1511,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
 					   (struct sockaddr *)sin6,
+					   &addr_len,
 					   &fl6->saddr);
 		if (err)
 			goto out_no_dst;
-- 
2.41.0


