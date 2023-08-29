Return-Path: <bpf+bounces-8901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82178C23F
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723011C209E8
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC481548E;
	Tue, 29 Aug 2023 10:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929614F72
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:25 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BED1AA
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so5506550a12.2
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304355; x=1693909155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZkrxe/gBxUvqYxyo48cxs2eWnzPWNzcWzN/8k3Fma4=;
        b=ABId7kDhtU5LBhq+3AJsnXpBwDqvEo/q25vt1gGdBbX/3iq+uFCatKC1T2BDLlaInW
         3UBeKn/smLoXbI/Dat/BWhJxBKJ+pTOv4UinGWZn0I5+6pOuplJ+bBZA6Y3Uq5XEFhW8
         Sml/INEoaD5dfkKjlNDRxglRPxqaqX88jDe7TPrh2ZdP5mbJyy8kj31e65eeYsQFC3tF
         YT0H5RlycGGvtPast12porKMCKRRlaVfJ0ng2OQ2oGRq4921iNHRSPsxh3XU2EgxSFk8
         tXsdBOunv49j3fjfVLa0BJhusEPphnqbClU3e+sNbnFy1+xK6e+pe3bsas+CLsgA9q/R
         xGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304355; x=1693909155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZkrxe/gBxUvqYxyo48cxs2eWnzPWNzcWzN/8k3Fma4=;
        b=YR9hXiRmHUj/4yT630eDGRAXjZFXKYD+0RnhY86RKbR4PayD3Cm83Ti4U8CXAjVBaU
         gkQKtM8+hTmtQpaa3TLOOT+LtoRCxrQ9oSfngx4rLp7QAYooNPdIOqBopf7f9oC2PfiZ
         jFTNT1dJmkfTj4pSPuMxz+lui4GyR8PiVsFAiPwqQhDhTpTxwERoQj67QlQxnCoK60sk
         NI9cQ73VjVUe03Un/zLZR1QlkgwzRcbI1jqlO06sUH/xCxZJFYdwEnlitk6qo4xXSEs2
         H2b+I1kiXafCMpouqvRKg1z8UdewWljbbzETkX2doA62mqC5v1AdFMJxRhD/IL9z03xt
         +JOg==
X-Gm-Message-State: AOJu0YxYf40RgSMvSN2wZe/z0zzqVXth3wrrAIOCAC4ACOlFYQrUo9zj
	ye/6M7TS9m+YITsmU2idSic+2kOJvK0V5aj3IRM=
X-Google-Smtp-Source: AGHT+IHWE4PYb20AsrdqHPsrHfQOgLgA8fvM/kOWMedsZYeeFSwu2XuaZ5pcjUdRZTEsH2pzAJLe5Q==
X-Received: by 2002:aa7:c657:0:b0:523:3e90:68b0 with SMTP id z23-20020aa7c657000000b005233e9068b0mr19991094edr.21.1693304354661;
        Tue, 29 Aug 2023 03:19:14 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:14 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
Date: Tue, 29 Aug 2023 12:18:26 +0200
Message-ID: <20230829101838.851350-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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

As prep for adding unix socket support to the cgroup sockaddr hooks,
let's propagate the sockaddr length back to the caller after running
a bpf cgroup sockaddr hook program. While not important for AF_INET or
AF_INET6, the sockaddr length is important when working with AF_UNIX
sockaddrs as the size of the sockaddr cannot be determined just from the
address family or the sockaddr's contents.

__cgroup_bpf_run_filter_sock_addr() is modified to take the uaddrlen as
an input/output argument. After running the program, the modified sockaddr
length is stored in the uaddrlen pointer. If no uaddrlen pointer is
provided, we determine the uaddrlen based on the socket family. For the
existing AF_INET and AF_INET6 use cases, we don't pass in the address
length explicitly and just determine it based on the passed in socket
family.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 include/linux/bpf-cgroup.h | 73 +++++++++++++++++++-------------------
 include/linux/filter.h     |  1 +
 kernel/bpf/cgroup.c        | 20 +++++++++--
 net/ipv4/af_inet.c         |  6 ++--
 net/ipv4/ping.c            |  2 +-
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/udp.c             |  8 +++--
 net/ipv6/af_inet6.c        |  6 ++--
 net/ipv6/ping.c            |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 net/ipv6/udp.c             |  6 ++--
 11 files changed, 74 insertions(+), 54 deletions(-)

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
index 761af6b3cf2b..77db4263d68d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1285,6 +1285,7 @@ struct bpf_sock_addr_kern {
 	 */
 	u64 tmp_reg;
 	void *t_ctx;	/* Attach type specific context. */
+	u32 uaddrlen;
 };
 
 struct bpf_sock_ops_kern {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..bc3084bafd23 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1449,6 +1449,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  *                                       provided by user sockaddr
  * @sk: sock struct that will use sockaddr
  * @uaddr: sockaddr struct provided by user
+ * @uaddrlen: Pointer to the size of the sockaddr struct provided by user
  * @type: The type of program to be executed
  * @t_ctx: Pointer to attach type specific context
  * @flags: Pointer to u32 which contains higher bits of BPF program
@@ -1461,6 +1462,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags)
@@ -1472,6 +1474,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	};
 	struct sockaddr_storage unspec;
 	struct cgroup *cgrp;
+	int ret;
 
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
@@ -1482,11 +1485,22 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	if (!ctx.uaddr) {
 		memset(&unspec, 0, sizeof(unspec));
 		ctx.uaddr = (struct sockaddr *)&unspec;
-	}
+		ctx.uaddrlen = sizeof(unspec);
+	} else if (uaddrlen)
+		ctx.uaddrlen = *uaddrlen;
+	else if (sk->sk_family == AF_INET)
+		ctx.uaddrlen = sizeof(struct sockaddr_in);
+	else if (sk->sk_family == AF_INET6)
+		ctx.uaddrlen = sizeof(struct sockaddr_in6);
 
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
index e07ee60625d9..ac11d485e3ab 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -452,7 +452,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, NULL,
 						 CGROUP_INET4_BIND, &flags);
 	if (err)
 		return err;
@@ -800,7 +800,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, NULL,
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -808,7 +808,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 			addr = inet->inet_saddr;
 		sin->sin_port = inet->inet_sport;
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, NULL,
 				       CGROUP_INET4_GETSOCKNAME);
 	}
 	release_sock(sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 75e0aee35eb7..0951837d5138 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -301,7 +301,7 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, NULL);
 }
 
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2a662d5f3072..50f34226252a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -194,7 +194,7 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, NULL);
 }
 
 /* This will initiate an outgoing connection. */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0794a2c46a56..9ecde90d59b7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1143,7 +1143,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin, &ipc.addr);
+					    (struct sockaddr *)usin, NULL,
+					    &ipc.addr);
 		if (err)
 			goto out_free;
 		if (usin) {
@@ -1865,7 +1866,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		*addr_len = sizeof(*sin);
 
 		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin);
+						      (struct sockaddr *)sin,
+						      NULL);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1904,7 +1906,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, NULL);
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719..576986b2d9cf 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -453,7 +453,7 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, NULL,
 						 CGROUP_INET6_BIND, &flags);
 	if (err)
 		return err;
@@ -538,7 +538,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		sin->sin6_addr = sk->sk_v6_daddr;
 		if (np->sndflow)
 			sin->sin6_flowinfo = np->flow_label;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, NULL,
 				       CGROUP_INET6_GETPEERNAME);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -546,7 +546,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		else
 			sin->sin6_addr = sk->sk_v6_rcv_saddr;
 		sin->sin6_port = inet->inet_sport;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, NULL,
 				       CGROUP_INET6_GETSOCKNAME);
 	}
 	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 1b2772834972..7aec51c281d0 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -56,7 +56,7 @@ static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, NULL);
 }
 
 static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d..255b02d98404 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -135,7 +135,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, NULL);
 }
 
 static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ebc6ae47cfea..402be1dde063 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -410,7 +410,8 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		*addr_len = sizeof(*sin6);
 
 		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin6);
+						      (struct sockaddr *)sin6,
+						      NULL);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1155,7 +1156,7 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, NULL);
 }
 
 /**
@@ -1508,6 +1509,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
 					   (struct sockaddr *)sin6,
+					   NULL,
 					   &fl6->saddr);
 		if (err)
 			goto out_no_dst;
-- 
2.41.0


