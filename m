Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7383B64906F
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJTgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLJTgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879191704B
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h10so8304805wrx.3
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYFtlhevempsitNucpOW3HxnZYURsvx0aCs6Hg0ZXF4=;
        b=CIHlJUYFTqimKwta/7hnyzzblCKzMct7WLepqLefb6RooNA+hbCj+9yQ/0WYOcpO/v
         Z2wHC4xdjm/bGvc4aCtoLPLTGqrqQt7EM4xSK+p43MvDMJjSm44je1hdW5j3UbegJQE1
         HBsIsz06zqWYp90vW7ftWM3J+1FM3ZOOCiEDK8sW+7Jz8Wm6T/iW+m/feLdkHffdDS4w
         6TUiLzv/TRRDhDGb3S2Cz6O97byLCz5/G83DjDvQ2Lrii5TLBLDeAqnUGaiIb9gZ/676
         GAzMsj66p4t4t4ruLKS2+TvdG0mjbfL4EktnaaeDmpmjiAcNVx6yum/PnKnyGdfvdfGw
         sUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYFtlhevempsitNucpOW3HxnZYURsvx0aCs6Hg0ZXF4=;
        b=MWywuoT9mC4aHqnvd6Y/lvKUl4s5cBp+v/zEa8r6ZozkNQN1bHHzU6c/SZK2bzziD2
         h38gv/yjcxWN299ySUi3MS3KkGPoTcrKuFKkG1VkC3Cnwnrfnqb/Kis4pr99DI1ZtiSY
         ywI1FACdhA9TJxNPVJiLUPHkY23arMK2Ztr6E//V5UhHgPGbq+VMt+opCjvk3hrcICi+
         2ZqjBUijv0pYACm9P6tDsa9083vfWl1XU7x9CxA9nzCFDCV6qjgOXlLrNlwXbuxHHEIO
         QFemZthjZ0mBerDcsOJG8tS1n9Upe5L7NoqokS2SIp4j63KNg8HGWbN0apQNg4dt8rTC
         2UiA==
X-Gm-Message-State: ANoB5pnoFj7vfVnL1SDoug49AnC0RzQN4xAQaxcTFyhVxXT0z8djekAn
        cisFnwOrMrT4mTJomSNa3qZySVeaN29XeA==
X-Google-Smtp-Source: AA0mqf4ws2GVlc3/CKIcuxSUASev7SyOPXU35zKOa4le26Vz9/jObs+9gkpysWW7ewZMDnBuWR6x8Q==
X-Received: by 2002:a5d:58d2:0:b0:242:4697:d826 with SMTP id o18-20020a5d58d2000000b002424697d826mr6169389wrf.29.1670700995628;
        Sat, 10 Dec 2022 11:36:35 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:35 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/9] bpf: Implement cgroup sockaddr hooks for unix sockets
Date:   Sat, 10 Dec 2022 20:35:55 +0100
Message-Id: <20221210193559.371515-6-daan.j.demeyer@gmail.com>
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

These hooks allows intercepting bind(), connect(), getsockname(),
getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
socket hooks get write access to the address length because the
address length is not fixed when dealing with unix sockets and
needs to be modified when a unix socket address is modified by
the hook. Because abstract socket unix addresses start with a
NUL byte, we cannot recalculate the socket address in kernelspace
after running the hook by calculating the length of the unix socket
path using strlen().

This hook can be used when users want to multiplex syscall to a
single unix socket to multiple different processes behind the scenes
by redirecting the connect() and other syscalls to process specific
sockets.
---
 include/linux/bpf-cgroup-defs.h |  6 +++
 include/linux/bpf-cgroup.h      | 29 ++++++++++-
 include/uapi/linux/bpf.h        | 14 ++++--
 kernel/bpf/cgroup.c             | 11 ++++-
 kernel/bpf/syscall.c            | 18 +++++++
 kernel/bpf/verifier.c           |  7 ++-
 net/core/filter.c               | 45 +++++++++++++++--
 net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h  | 14 ++++--
 9 files changed, 204 insertions(+), 25 deletions(-)

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
index 3ab2f06ddc8a..4de3016f01e4 100644
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
@@ -273,9 +279,13 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 		__ret;                                                       \
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
 
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)		       \
@@ -284,24 +294,36 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)		       \
 	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)	               \
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
+
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
 
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)
+
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
 
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
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
@@ -487,16 +509,21 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
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
index 9e3c33f83bba..b73e4da458fd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -999,17 +999,21 @@ enum bpf_attach_type {
 	BPF_SK_MSG_VERDICT,
 	BPF_CGROUP_INET4_BIND,
 	BPF_CGROUP_INET6_BIND,
+	BPF_CGROUP_UNIX_BIND,
 	BPF_CGROUP_INET4_CONNECT,
 	BPF_CGROUP_INET6_CONNECT,
+	BPF_CGROUP_UNIX_CONNECT,
 	BPF_CGROUP_INET4_POST_BIND,
 	BPF_CGROUP_INET6_POST_BIND,
 	BPF_CGROUP_UDP4_SENDMSG,
 	BPF_CGROUP_UDP6_SENDMSG,
+	BPF_CGROUP_UNIX_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
 	BPF_CGROUP_UDP4_RECVMSG,
 	BPF_CGROUP_UDP6_RECVMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
 	BPF_TRACE_RAW_TP,
@@ -1020,8 +1024,10 @@ enum bpf_attach_type {
 	BPF_TRACE_ITER,
 	BPF_CGROUP_INET4_GETPEERNAME,
 	BPF_CGROUP_INET6_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETPEERNAME,
 	BPF_CGROUP_INET4_GETSOCKNAME,
 	BPF_CGROUP_INET6_GETSOCKNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_XDP_DEVMAP,
 	BPF_CGROUP_INET_SOCK_RELEASE,
 	BPF_XDP_CPUMAP,
@@ -2575,8 +2581,8 @@ union bpf_attr {
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
@@ -2809,8 +2815,8 @@ union bpf_attr {
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
index f97afed8a115..eeb349cef624 100644
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
  * returned value != 1 during execution. In all other cases, 0 is returned.
@@ -1479,7 +1479,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
 	 */
-	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
+		sk->sk_family != AF_UNIX)
 		return 0;
 
 	if (!ctx.uaddr) {
@@ -2493,10 +2494,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2508,10 +2512,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 35972afb6850..142b5ece735f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2370,16 +2370,22 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
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
@@ -3418,16 +3424,22 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
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
@@ -3583,18 +3595,24 @@ static int bpf_prog_query(const union bpf_attr *attr,
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
index 1d51bd9596da..c06a6e43676c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11991,14 +11991,19 @@ static int check_return_code(struct bpf_verifier_env *env)
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
index cc86b38fc764..0c8427305009 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7666,6 +7666,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 			return &bpf_bind_proto;
 		default:
 			return NULL;
@@ -7694,16 +7695,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7712,16 +7719,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -8784,8 +8797,8 @@ static bool sock_addr_is_valid_access(int off, int size,
 	if (off % size != 0)
 		return false;
 
-	/* Disallow access to IPv6 fields from IPv4 contex and vise
-	 * versa.
+	/* Disallow access to fields not belonging to the attach type's address
+	 * family.
 	 */
 	switch (off) {
 	case bpf_ctx_range(struct bpf_sock_addr, user_ip4):
@@ -8832,7 +8845,18 @@ static bool sock_addr_is_valid_access(int off, int size,
 		}
 		break;
 	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
-		return false;
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_UNIX_BIND:
+		case BPF_CGROUP_UNIX_CONNECT:
+		case BPF_CGROUP_UNIX_SENDMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
+			break;
+		default:
+			return false;
+		}
+		break;
 	}
 
 	switch (off) {
@@ -8884,8 +8908,19 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		break;
 	case bpf_ctx_range(struct bpf_sock_addr, user_addrlen):
-		if (type != BPF_READ)
-			return false;
+		if (type != BPF_READ) {
+			switch (prog->expected_attach_type) {
+			case BPF_CGROUP_UNIX_BIND:
+			case BPF_CGROUP_UNIX_CONNECT:
+			case BPF_CGROUP_UNIX_SENDMSG:
+			case BPF_CGROUP_UNIX_RECVMSG:
+			case BPF_CGROUP_UNIX_GETPEERNAME:
+			case BPF_CGROUP_UNIX_GETSOCKNAME:
+				break;
+			default:
+				return false;
+			}
+		}
 
 		if (size != sizeof(__u32))
 			return false;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b3545fc68097..8d250cb75636 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -115,6 +115,7 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf-cgroup.h>
 
 #include "scm.h"
 
@@ -1302,6 +1303,12 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	struct sock *sk = sock->sk;
 	int err;
 
+	if (cgroup_bpf_enabled(CGROUP_UNIX_BIND)) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, &addr_len);
+		if (err)
+			return err;
+	}
+
 	if (addr_len == offsetof(struct sockaddr_un, sun_path) &&
 	    sunaddr->sun_family == AF_UNIX)
 		return unix_autobind(sk);
@@ -1356,6 +1363,13 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		goto out;
 
 	if (addr->sa_family != AF_UNSPEC) {
+		if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
+			err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr,
+								    &alen);
+			if (err)
+				goto out;
+		}
+
 		err = unix_validate_addr(sunaddr, alen);
 		if (err)
 			goto out;
@@ -1464,6 +1478,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	int err;
 	int st;
 
+	if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
+		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr,
+							    &addr_len);
+		if (err)
+			goto out;
+	}
+
 	err = unix_validate_addr(sunaddr, addr_len);
 	if (err)
 		goto out;
@@ -1724,7 +1745,7 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	struct sock *sk = sock->sk;
 	struct unix_address *addr;
 	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, uaddr);
-	int err = 0;
+	int addr_len = 0, err = 0;
 
 	if (peer) {
 		sk = unix_peer_get(sk);
@@ -1741,14 +1762,35 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
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
+		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
+					     CGROUP_UNIX_GETPEERNAME);
+		if (err)
+			goto out;
+
+		err = unix_validate_addr(sunaddr, addr_len);
+		if (err)
+			goto out;
+	} else if (cgroup_bpf_enabled(CGROUP_UNIX_GETSOCKNAME)) {
+		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
+					     CGROUP_UNIX_GETSOCKNAME);
+		if (err)
+			goto out;
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
@@ -1910,6 +1952,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 
 	if (msg->msg_namelen) {
+		if (cgroup_bpf_enabled(CGROUP_UNIX_SENDMSG)) {
+			err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(
+				sk, msg->msg_name, &msg->msg_namelen, NULL);
+			if (err)
+				goto out;
+		}
+
 		err = unix_validate_addr(sunaddr, msg->msg_namelen);
 		if (err)
 			goto out;
@@ -2404,14 +2453,29 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
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
+			err = BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(
+				sk, msg->msg_name, &msg->msg_namelen);
+			if (err)
+				return err;
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
@@ -2466,8 +2530,11 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
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
@@ -2821,7 +2888,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
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
index 9e3c33f83bba..b73e4da458fd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -999,17 +999,21 @@ enum bpf_attach_type {
 	BPF_SK_MSG_VERDICT,
 	BPF_CGROUP_INET4_BIND,
 	BPF_CGROUP_INET6_BIND,
+	BPF_CGROUP_UNIX_BIND,
 	BPF_CGROUP_INET4_CONNECT,
 	BPF_CGROUP_INET6_CONNECT,
+	BPF_CGROUP_UNIX_CONNECT,
 	BPF_CGROUP_INET4_POST_BIND,
 	BPF_CGROUP_INET6_POST_BIND,
 	BPF_CGROUP_UDP4_SENDMSG,
 	BPF_CGROUP_UDP6_SENDMSG,
+	BPF_CGROUP_UNIX_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
 	BPF_CGROUP_UDP4_RECVMSG,
 	BPF_CGROUP_UDP6_RECVMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
 	BPF_TRACE_RAW_TP,
@@ -1020,8 +1024,10 @@ enum bpf_attach_type {
 	BPF_TRACE_ITER,
 	BPF_CGROUP_INET4_GETPEERNAME,
 	BPF_CGROUP_INET6_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETPEERNAME,
 	BPF_CGROUP_INET4_GETSOCKNAME,
 	BPF_CGROUP_INET6_GETSOCKNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_XDP_DEVMAP,
 	BPF_CGROUP_INET_SOCK_RELEASE,
 	BPF_XDP_CPUMAP,
@@ -2575,8 +2581,8 @@ union bpf_attr {
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
@@ -2809,8 +2815,8 @@ union bpf_attr {
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
2.38.1

