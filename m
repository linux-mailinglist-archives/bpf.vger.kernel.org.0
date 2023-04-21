Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD66EAF21
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjDUQb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjDUQb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DEF1444B
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so3280917a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094682; x=1684686682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avj8itV+THmDhtv+qAhGmSpuILrhOmGyKUPrt+kFgvM=;
        b=eSmP7CQGAgF3spRPHvOiusJ/pbB/HjGM2biEfXmiHw06LgVoPxzEjKEnfAHuK/u4eU
         f3DeXbuEnZ5rpyUndEbl8AGOnb6QSWWzErdfmNFdaOw51FY0VkLml0aXE77GoyxhFJ5g
         HwoCmo6XcwTEHMQh90SxG+VaizEceZTmEFCDGE8668n+Ae3KLr2GAVPDVT+P+Q49wd6j
         B0aP+GsaF1jIewTK6klWzyOTuHl+sEpe7sCnzqZKTCxV6YJDpAMU9XA7sj3S1coUdGVr
         EKa8HxdDQI1EtJuE9fcAnNQmqWaGadXzQfHFkJTzveqlGr7uONHbVh5D0h3ykBgg5G7V
         gX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094682; x=1684686682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avj8itV+THmDhtv+qAhGmSpuILrhOmGyKUPrt+kFgvM=;
        b=X+UE0anQxUahMbDxM3DF6As8anEMTLr50L8VJMU3Jy2jF3g9wdB3gSrCtEkNUb4RXv
         csRs2q42JtfDCmc685fEgKHmmzA3iFCrED0cAGYS4k3VbT7LWVxfynt0rDBxQzh2pOlb
         JpEO6BVZrJUZAPyq3porFpvpdvOduZGvpbHj+qd0reXTczAq9PtdPfxhUgE6D7WzP9Qy
         djyV5Cicbm63zp2Bk8AJTdhprmSDHGaNtogIlLMkXEWrMlUwkSLQIbTqO90X4LmmoXsc
         HZKbxLjxYMKBm0/bzhtB4WydX1NaG21r5SXBYRHKr1BqeLLZSx6AFYyBKbp7X0S0icvj
         FuGQ==
X-Gm-Message-State: AAQBX9fEF5Ygc9gH9ms7zr2otXLfgWYT6eUCUM5VehCuQjIf+sG4jCSe
        zcpsGn58kgPZn+raD8T7rC0g0o2mRvUXHg==
X-Google-Smtp-Source: AKy350b+NTGCwsU4McyQRJJkz6WtWa+vWibrBi1h+jfflNhp75LnqRKe81MEvZrqOUYpthiS+qfhsQ==
X-Received: by 2002:a17:907:765a:b0:94f:6d10:ad9f with SMTP id kj26-20020a170907765a00b0094f6d10ad9fmr2937274ejc.42.1682094681739;
        Fri, 21 Apr 2023 09:31:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:21 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/10] bpf: Allow read access to addr_len from cgroup sockaddr programs
Date:   Fri, 21 Apr 2023 18:27:11 +0200
Message-Id: <20230421162718.440230-4-daan.j.demeyer@gmail.com>
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

As prep for adding unix socket support to the cgroup sockaddr hooks,
let's expose the sockaddr addrlen in bpf_sock_addr_kern. While not
important for AF_INET or AF_INET6, the sockaddr length is important
when working with AF_UNIX sockaddrs as the size of the sockaddr cannot
be determined just from the address family or the sockaddr's contents.

__cgroup_bpf_run_filter_sock_addr() is modified to return the addr_len
in preparation for adding unix socket support for which we'll need to
return the modified address length.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 include/linux/bpf-cgroup.h | 73 +++++++++++++++++++-------------------
 include/linux/filter.h     |  1 +
 kernel/bpf/cgroup.c        | 16 +++++++--
 net/ipv4/af_inet.c         |  8 ++---
 net/ipv4/ping.c            |  8 ++++-
 net/ipv4/tcp_ipv4.c        |  8 ++++-
 net/ipv4/udp.c             | 17 ++++++---
 net/ipv6/af_inet6.c        |  8 ++---
 net/ipv6/ping.c            |  8 ++++-
 net/ipv6/tcp_ipv6.c        |  8 ++++-
 net/ipv6/udp.c             | 14 ++++++--
 11 files changed, 111 insertions(+), 58 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..f3f5adf3881f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      u32 uaddrlen,
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
index bbce89937fde..89e891003c03 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1294,6 +1294,7 @@ struct bpf_sock_addr_kern {
 	 */
 	u64 tmp_reg;
 	void *t_ctx;	/* Attach type specific context. */
+	u32 uaddrlen;
 };
 
 struct bpf_sock_ops_kern {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 53edb8ad2471..c2191f0e138e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1449,6 +1449,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  *                                       provided by user sockaddr
  * @sk: sock struct that will use sockaddr
  * @uaddr: sockaddr struct provided by user
+ * @uaddrlen: Size of the sockaddr struct provided by user
  * @type: The type of program to be executed
  * @t_ctx: Pointer to attach type specific context
  * @flags: Pointer to u32 which contains higher bits of BPF program
@@ -1457,10 +1458,12 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * socket is expected to be of type INET or INET6.
  *
  * This function will return %-EPERM if an attached program is found and
- * returned value != 1 during execution. In all other cases, 0 is returned.
+ * returned value != 1 during execution. In all other cases, the new address
+ * length of the sockaddr is returned.
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      u32 uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags)
@@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 		.sk = sk,
 		.uaddr = uaddr,
 		.t_ctx = t_ctx,
+		.uaddrlen = uaddrlen,
 	};
 	struct sockaddr_storage unspec;
 	struct cgroup *cgrp;
+	int ret;
 
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
@@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	if (!ctx.uaddr) {
 		memset(&unspec, 0, sizeof(unspec));
 		ctx.uaddr = (struct sockaddr *)&unspec;
+		ctx.uaddrlen = sizeof(unspec);
 	}
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
-				     0, flags);
+	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
+				    0, flags);
+	if (ret)
+		return ret;
+
+	return (int) ctx.uaddrlen;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 940062e08f57..6b3e5d77d354 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -446,9 +446,9 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, addr_len,
 						 CGROUP_INET4_BIND, &flags);
-	if (err)
+	if (err < 0)
 		return err;
 
 	return __inet_bind(sk, uaddr, addr_len, flags);
@@ -785,7 +785,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, sizeof(*sin),
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -793,7 +793,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 			addr = inet->inet_saddr;
 		sin->sin_port = inet->inet_sport;
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, sizeof(*sin),
 				       CGROUP_INET4_GETSOCKNAME);
 	}
 	release_sock(sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 5178a3f3cb53..9192cf5cd3ef 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -304,6 +304,8 @@ EXPORT_SYMBOL_GPL(ping_close);
 static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			    int addr_len)
 {
+	int err;
+
 	/* This check is replicated from __ip4_datagram_connect() and
 	 * intended to prevent BPF program called below from accessing bytes
 	 * that are out of the bound specified by user in addr_len.
@@ -311,7 +313,11 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 39bda2b1066e..50fed4e1820d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -184,6 +184,8 @@ EXPORT_SYMBOL_GPL(tcp_twsk_unique);
 static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			      int addr_len)
 {
+	int err;
+
 	/* This check is replicated from tcp_v4_connect() and intended to
 	 * prevent BPF program called below from accessing bytes that are out
 	 * of the bound specified by user in addr_len.
@@ -193,7 +195,11 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 /* This will initiate an outgoing connection. */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index aa32afd871ee..8f4b64252b51 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1157,8 +1157,10 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin, &ipc.addr);
-		if (err)
+					    (struct sockaddr *)usin,
+					    msg->msg_namelen,
+					    &ipc.addr);
+		if (err < 0)
 			goto out_free;
 		if (usin) {
 			if (usin->sin_port == 0) {
@@ -1927,7 +1929,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		*addr_len = sizeof(*sin);
 
 		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin);
+						      (struct sockaddr *)sin,
+						      *addr_len);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1959,6 +1962,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 
 int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
+	int err;
+
 	/* This check is replicated from __ip4_datagram_connect() and
 	 * intended to prevent BPF program called below from accessing bytes
 	 * that are out of the bound specified by user in addr_len.
@@ -1966,7 +1971,11 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index e1b679a590c9..acba6a47ae44 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -455,9 +455,9 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, addr_len,
 						 CGROUP_INET6_BIND, &flags);
-	if (err)
+	if (err < 0)
 		return err;
 
 	return __inet6_bind(sk, uaddr, addr_len, flags);
@@ -534,7 +534,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		sin->sin6_addr = sk->sk_v6_daddr;
 		if (np->sndflow)
 			sin->sin6_flowinfo = np->flow_label;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, sizeof(*sin),
 				       CGROUP_INET6_GETPEERNAME);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -542,7 +542,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		else
 			sin->sin6_addr = sk->sk_v6_rcv_saddr;
 		sin->sin6_port = inet->inet_sport;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, sizeof(*sin),
 				       CGROUP_INET6_GETSOCKNAME);
 	}
 	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index c4835dbdfcff..d3630cad2c21 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -48,6 +48,8 @@ static int dummy_ipv6_chk_addr(struct net *net, const struct in6_addr *addr,
 static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			       int addr_len)
 {
+	int err;
+
 	/* This check is replicated from __ip6_datagram_connect() and
 	 * intended to prevent BPF program called below from accessing
 	 * bytes that are out of the bound specified by user in addr_len.
@@ -56,7 +58,11 @@ static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 244cf86c4cbb..a59db6b3e41f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -130,6 +130,8 @@ static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
 static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			      int addr_len)
 {
+	int err;
+
 	/* This check is replicated from tcp_v6_connect() and intended to
 	 * prevent BPF program called below from accessing bytes that are out
 	 * of the bound specified by user in addr_len.
@@ -139,7 +141,11 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b970..bc6c9a5586bf 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -429,7 +429,8 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		*addr_len = sizeof(*sin6);
 
 		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin6);
+						      (struct sockaddr *)sin6,
+						      *addr_len);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1154,6 +1155,8 @@ static void udp_v6_flush_pending_frames(struct sock *sk)
 static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			     int addr_len)
 {
+	int err;
+
 	if (addr_len < offsetofend(struct sockaddr, sa_family))
 		return -EINVAL;
 	/* The following checks are replicated from __ip6_datagram_connect()
@@ -1169,7 +1172,11 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, addr_len);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 /**
@@ -1522,8 +1529,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
 					   (struct sockaddr *)sin6,
+					   msg->msg_namelen,
 					   &fl6->saddr);
-		if (err)
+		if (err < 0)
 			goto out_no_dst;
 		if (sin6) {
 			if (ipv6_addr_v4mapped(&sin6->sin6_addr)) {
-- 
2.40.0

