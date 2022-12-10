Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4464906D
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLJTgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLJTgf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2F17070
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u12so8285324wrr.11
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+cgziiizzukldzfvHhhKU5n4vWX6w+fQ9+PnrQBORQ=;
        b=b8FxEZP9W3gkcYhN2slNCnZy5E/2RXLXoxn7sQ4uS9AoJu8q5KfRGUi8jRSdv9tHGS
         0qqJSgCjlE87x84GyXGG60vqws/qFAsFktX4icjT+x1y28gxnU/v+iedceUmnFzvEoNi
         SMyCwrZrVljoInZw+fVXlKxBitUHuSMGwutvcDNz4DnEaK3mj9Ct4NxAAZgTQC/AJzoT
         iGxkkzYvtQev62VI5yH5UmMoBR55F3baUNzx1T296srZE3knC5lklsy5YBWnxnvE8Peg
         yQK5Ya8pE1gDoPAmR9S2XmIJdFM6OMCFk9I3Aru91YcOc2GaCi485TllTW29Hr3+8hT3
         WvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+cgziiizzukldzfvHhhKU5n4vWX6w+fQ9+PnrQBORQ=;
        b=RJ+Y7HvLl8206GIDniHP1CmmF4kh+tz4hfB3NEWyOQBgM6T65l03P2/RXqpeSv/voS
         yZKOz3JEoq+Jeav44mxk32fSDuGzHqrvE1yO1m/R0MVr3Qpv7PSODi/hkXXrErbwxG/F
         TGefSiXUght5Gr1MLfh9LeMwO+ZjPlwrAE8EytpHUEWbWp+d1Y14ucE521WNRZ5PwK3r
         MQyRiZiH770cm2UoLhw8yL3YrVJ0JCba4lYEorj6yebAtKCAZtrMuozm+zZKFjtStk9G
         tjnhRXmvg0R78VMcp85gnZPBHpHDqgZGAqG1JSLtaVTQaWEciyyRMakJ4Y7UqCDyff/i
         Iezg==
X-Gm-Message-State: ANoB5plJmnJoCITwLBF+j3e+AXvGksdP8e/WRwDo3X68e1YEn+OwHN2R
        +SgNe8S1sxyI2HLVVvEowHKw/PB8/pr3eg==
X-Google-Smtp-Source: AA0mqf6DbWtPQJOSDiwoQKvUpzjD8GcRPivVYmU0JSsggiXMcWeG89JQAJZpDmmDhQOyvOPy1p6Kjg==
X-Received: by 2002:adf:edc6:0:b0:242:43d1:6d8a with SMTP id v6-20020adfedc6000000b0024243d16d8amr7845211wro.59.1670700991894;
        Sat, 10 Dec 2022 11:36:31 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:31 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/9] bpf: Allow read access to addr_len from cgroup sockaddr programs
Date:   Sat, 10 Dec 2022 20:35:52 +0100
Message-Id: <20221210193559.371515-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/linux/bpf-cgroup.h     | 124 +++++++++++++++++----------------
 include/linux/filter.h         |   1 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/cgroup.c            |   3 +
 net/core/filter.c              |  51 ++++++++++++++
 net/ipv4/af_inet.c             |   9 +--
 net/ipv4/ping.c                |   2 +-
 net/ipv4/tcp_ipv4.c            |   2 +-
 net/ipv4/udp.c                 |  11 +--
 net/ipv6/af_inet6.c            |   9 +--
 net/ipv6/ping.c                |   2 +-
 net/ipv6/tcp_ipv6.c            |   2 +-
 net/ipv6/udp.c                 |  12 ++--
 tools/include/uapi/linux/bpf.h |   1 +
 14 files changed, 146 insertions(+), 84 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..3ab2f06ddc8a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
+				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
 				      u32 *flags);
@@ -230,75 +231,76 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
 
-#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
-({									       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(atype))					       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  NULL, NULL);	       \
-	__ret;								       \
-})
-
-#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
-({									       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(atype))	{				       \
-		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  t_ctx, NULL);	       \
-		release_sock(sk);					       \
-	}								       \
-	__ret;								       \
-})
+#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)               \
+	({                                                               \
+		int __ret = 0;                                           \
+		if (cgroup_bpf_enabled(atype))                           \
+			__ret = __cgroup_bpf_run_filter_sock_addr(       \
+				sk, uaddr, uaddrlen, atype, NULL, NULL); \
+		__ret;                                                   \
+	})
+
+#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)    \
+	({                                                                \
+		int __ret = 0;                                            \
+		if (cgroup_bpf_enabled(atype)) {                          \
+			lock_sock(sk);                                    \
+			__ret = __cgroup_bpf_run_filter_sock_addr(        \
+				sk, uaddr, uaddrlen, atype, t_ctx, NULL); \
+			release_sock(sk);                                 \
+		}                                                         \
+		__ret;                                                    \
+	})
 
 /* BPF_CGROUP_INET4_BIND and BPF_CGROUP_INET6_BIND can return extra flags
  * via upper bits of return code. The only flag that is supported
  * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
  * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
  */
-#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, bind_flags)	       \
-({									       \
-	u32 __flags = 0;						       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(atype))	{				       \
-		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
-							  NULL, &__flags);     \
-		release_sock(sk);					       \
-		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
-			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
-	}								       \
-	__ret;								       \
-})
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype,       \
+					   bind_flags)                       \
+	({                                                                   \
+		u32 __flags = 0;                                             \
+		int __ret = 0;                                               \
+		if (cgroup_bpf_enabled(atype)) {                             \
+			lock_sock(sk);                                       \
+			__ret = __cgroup_bpf_run_filter_sock_addr(           \
+				sk, uaddr, uaddrlen, atype, NULL, &__flags); \
+			release_sock(sk);                                    \
+			if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)  \
+				*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE; \
+		}                                                            \
+		__ret;                                                       \
+	})
 
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
 	((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||		       \
 	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
 	 (sk)->sk_prot->pre_connect)
 
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)		       \
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT)
 
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET6_CONNECT)
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)		       \
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
 
-#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET4_CONNECT, NULL)
+#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
 
-#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET6_CONNECT, NULL)
+#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
 
-#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_SENDMSG, t_ctx)
+#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
 
-#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_SENDMSG, t_ctx)
+#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
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
@@ -477,24 +479,24 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
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
index bf701976056e..510cf4042f8b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1294,6 +1294,7 @@ struct bpf_sock_addr_kern {
 	 */
 	u64 tmp_reg;
 	void *t_ctx;	/* Attach type specific context. */
+	int *uaddrlen;
 };
 
 struct bpf_sock_ops_kern {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f89de51a45db..7cafcfdbb9b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6366,6 +6366,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
+	__u32 user_addrlen;	/* Allows 4 byte read and write. */
 };
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bf2fdb33fb31..f97afed8a115 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1449,6 +1449,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  *                                       provided by user sockaddr
  * @sk: sock struct that will use sockaddr
  * @uaddr: sockaddr struct provided by user
+ * @uaddrlen: Pointer to length of sockaddr struct provided by user
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
@@ -1468,6 +1470,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	struct bpf_sock_addr_kern ctx = {
 		.sk = sk,
 		.uaddr = uaddr,
+		.uaddrlen = uaddrlen,
 		.t_ctx = t_ctx,
 	};
 	struct sockaddr_storage unspec;
diff --git a/net/core/filter.c b/net/core/filter.c
index 8607136b6e2c..d0620927dbca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8876,6 +8876,13 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
+	case bpf_ctx_range(struct bpf_sock_addr, user_addrlen):
+		if (type != BPF_READ)
+			return false;
+
+		if (size != sizeof(__u32))
+			return false;
+		break;
 	default:
 		if (type == BPF_READ) {
 			if (size != size_default)
@@ -9909,6 +9916,7 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 {
 	int off, port_size = sizeof_field(struct sockaddr_in6, sin6_port);
 	struct bpf_insn *insn = insn_buf;
+	u32 read_size;
 
 	switch (si->off) {
 	case offsetof(struct bpf_sock_addr, user_family):
@@ -9986,6 +9994,49 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,
 				      offsetof(struct bpf_sock_addr_kern, sk));
 		break;
+
+	case offsetof(struct bpf_sock_addr, user_addrlen):
+		/* uaddrlen is a pointer so it should be accessed via indirect
+		 * loads and stores. Also for stores additional temporary
+		 * register is used since neither src_reg nor dst_reg can be
+		 * overridden.
+		 */
+		if (type == BPF_WRITE) {
+			int treg = BPF_REG_9;
+
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			*insn++ = BPF_STX_MEM(
+				BPF_DW, si->dst_reg, treg,
+				offsetof(struct bpf_sock_addr_kern, tmp_reg));
+			*insn++ = BPF_LDX_MEM(
+				BPF_FIELD_SIZEOF(struct bpf_sock_addr_kern,
+						 uaddrlen),
+				treg, si->dst_reg,
+				offsetof(struct bpf_sock_addr_kern, uaddrlen));
+			*insn++ = BPF_STX_MEM(
+				BPF_SIZEOF(u32), treg, si->src_reg,
+				bpf_ctx_narrow_access_offset(0, sizeof(u32),
+							     sizeof(int)));
+			*insn++ = BPF_LDX_MEM(
+				BPF_DW, treg, si->dst_reg,
+				offsetof(struct bpf_sock_addr_kern, tmp_reg));
+		} else {
+			*insn++ = BPF_LDX_MEM(
+				BPF_FIELD_SIZEOF(struct bpf_sock_addr_kern,
+						 uaddrlen),
+				si->dst_reg, si->src_reg,
+				offsetof(struct bpf_sock_addr_kern, uaddrlen));
+			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
+			*insn++ = BPF_LDX_MEM(
+				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
+				bpf_ctx_narrow_access_offset(0, read_size,
+							     sizeof(int)));
+		}
+		*target_size = sizeof(u32);
+		break;
 	}
 
 	return insn - insn_buf;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ab4a06be489b..3024837b57e7 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -448,7 +448,7 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
 						 CGROUP_INET4_BIND, &flags);
 	if (err)
 		return err;
@@ -775,6 +775,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 	struct sock *sk		= sock->sk;
 	struct inet_sock *inet	= inet_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
+	int addrlen = sizeof(*sin);
 
 	sin->sin_family = AF_INET;
 	lock_sock(sk);
@@ -787,7 +788,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &addrlen,
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -795,12 +796,12 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 			addr = inet->inet_saddr;
 		sin->sin_port = inet->inet_sport;
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &addrlen,
 				       CGROUP_INET4_GETSOCKNAME);
 	}
 	release_sock(sk);
 	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-	return sizeof(*sin);
+	return addrlen;
 }
 EXPORT_SYMBOL(inet_getname);
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index bb9854c2b7a1..9b82798e5542 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -306,7 +306,7 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1215fa4c1b9f..e4d1903239b9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -193,7 +193,7 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, &addr_len);
 }
 
 /* This will initiate an outgoing connection. */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9592fe3e444a..ff4b4513d0fb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1156,8 +1156,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
-		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin, &ipc.addr);
+		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(
+			sk, (struct sockaddr *)usin, &msg->msg_namelen,
+			&ipc.addr);
 		if (err)
 			goto out_free;
 		if (usin) {
@@ -1921,8 +1922,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
 		*addr_len = sizeof(*sin);
 
-		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin);
+		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(
+			sk, (struct sockaddr *)sin, addr_len);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1961,7 +1962,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index fee9163382c2..ac3671e48710 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -464,7 +464,7 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
 						 CGROUP_INET6_BIND, &flags);
 	if (err)
 		return err;
@@ -527,6 +527,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 	struct sock *sk = sock->sk;
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	int addrlen = sizeof(*sin);
 
 	sin->sin6_family = AF_INET6;
 	sin->sin6_flowinfo = 0;
@@ -543,7 +544,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		sin->sin6_addr = sk->sk_v6_daddr;
 		if (np->sndflow)
 			sin->sin6_flowinfo = np->flow_label;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &addrlen,
 				       CGROUP_INET6_GETPEERNAME);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -551,13 +552,13 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		else
 			sin->sin6_addr = sk->sk_v6_rcv_saddr;
 		sin->sin6_port = inet->inet_sport;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
+		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &addrlen,
 				       CGROUP_INET6_GETSOCKNAME);
 	}
 	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
 						 sk->sk_bound_dev_if);
 	release_sock(sk);
-	return sizeof(*sin);
+	return addrlen;
 }
 EXPORT_SYMBOL(inet6_getname);
 
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 808983bc2ec9..a46c1eec72e6 100644
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
index f52b6f271a24..22213641bb3c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -139,7 +139,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	sock_owned_by_me(sk);
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }
 
 static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9fb2f33ee3a7..2ac73446dcdc 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -428,8 +428,8 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 		*addr_len = sizeof(*sin6);
 
-		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin6);
+		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(
+			sk, (struct sockaddr *)sin6, addr_len);
 	}
 
 	if (udp_sk(sk)->gro_enabled)
@@ -1167,7 +1167,7 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
 
-	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
+	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
 /**
@@ -1516,9 +1516,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6->fl6_sport = inet->inet_sport;
 
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
-		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
-					   (struct sockaddr *)sin6,
-					   &fl6->saddr);
+		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(
+			sk, (struct sockaddr *)sin6, &msg->msg_namelen,
+			&fl6->saddr);
 		if (err)
 			goto out_no_dst;
 		if (sin6) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f89de51a45db..7cafcfdbb9b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6366,6 +6366,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
+	__u32 user_addrlen;	/* Allows 4 byte read and write. */
 };
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
-- 
2.38.1

