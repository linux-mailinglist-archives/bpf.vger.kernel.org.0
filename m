Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875064495A
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiLFQfJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiLFQeo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:34:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF02FC26
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 08:33:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so14698148wmb.2
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQp60hb7yAr1jHzB6ioL0jXdVQ+GjQGZb3FwuD97uXU=;
        b=WAqD3LxJ9zkHR7FrxNODiby9HnV+cpmk4fwe9WTryyq4SXFjM8kPvtTUi6RlCNHzS8
         nbWcb0/yjqtcf0rNpXQz1c0r4uS3n1UPeVWM+B9tT/0VAw2KVCi/FDuZpm72FDlf2rfA
         RSsJ6TsQc680kxNaNWM/0Nfp0xuLnNVPtqPzhZGu8h5eXxUM634WcxgLnDKKkOW1Yh07
         B6u9NOUR/fxY2ozaseM3TMZ2RiYxmj/5ZZPpFLUfeCKGTJKbsFGqh5ZWFk7FWHCFEEDl
         StKWWP2CVovVF6InGYAM2zoKs6x62zLZTy9wKsxPyklZkALWzpzCW8+1ym328ICNUtH3
         50tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQp60hb7yAr1jHzB6ioL0jXdVQ+GjQGZb3FwuD97uXU=;
        b=JLi/YcP8c5+S0wLQlINMmj2jWHsy+Nw4QEiZfh+mnBDvIxrKP4Jtr6pJEYBLKkbG0V
         /mxG89mWOSGl9Umh+dNwtyVQvEr+4fjE6+6B2lJP1BhpMvCOe43yoyBEZIQqCSH0I5bu
         AygauDCA1NzS2LoZsK4nGxuXC8aIiqWRB7q5MS7Wwf6SFg6p0B4E+Qzd7bvUhhBzb84a
         tOBdjn7I1lHGbJ7bVvJ0WwvxJmCixv/dKxKP4SCrM7sc9rXMaNhk7IPMKgmVrfiMlAfb
         1lAUI0O1uMasNPUaTejbn7q8WnyiO/lF20KFhEFgYfOYY68ruRJaP06m6yKFnU1WW8q+
         CyZg==
X-Gm-Message-State: ANoB5pnDPKCY5XEW5r/XkSGufF/Za3VbKGexS6uLs0zB51Qi2TXvMIA6
        zUcirVTxgkFiS4AlygMFXKyKW+uu+03rqw==
X-Google-Smtp-Source: AA0mqf5ag4L3XyXmH5kcZ+wbImZlQwW4Uo9a1xJ4xorFh1jnu5uvLGf3hpaEiUwwzw6WuPOhJfY9fA==
X-Received: by 2002:a05:600c:1e25:b0:3cf:9ac8:c4eb with SMTP id ay37-20020a05600c1e2500b003cf9ac8c4ebmr358249wmb.24.1670344404023;
        Tue, 06 Dec 2022 08:33:24 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:c544])
        by smtp.googlemail.com with ESMTPSA id e14-20020a05600c4e4e00b003b95ed78275sm21628353wmq.20.2022.12.06.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:33:23 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH] bpf: Add BPF_CGROUP_UNIX_CONNECT attach type
Date:   Tue,  6 Dec 2022 17:32:13 +0100
Message-Id: <20221206163213.2891348-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This hook allows intercepting connect() calls on unix sockets. After
running the hook, we recalculate the sockaddr length as it the hook
might have replaced the sun_path with a longer/shorter one. This is
safe because all kernelspace sockaddrs are stored in instances of
sockaddr_storage which is guaranteed to larger than sockaddr_un.

This hook can be used when users want to multiplex connect()
calls to a single unix socket to multiple different processes
behind the scenes by redirecting the connect() calls to process
specific sockets.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 Documentation/bpf/libbpf/program_types.rst    |  2 +
 include/linux/bpf-cgroup-defs.h               |  1 +
 include/linux/bpf-cgroup.h                    | 12 ++-
 include/uapi/linux/bpf.h                      | 10 ++-
 kernel/bpf/cgroup.c                           |  5 +-
 kernel/bpf/syscall.c                          |  3 +
 net/core/filter.c                             | 28 +++++++
 net/unix/af_unix.c                            | 37 +++++++++
 tools/bpf/bpftool/common.c                    |  1 +
 tools/include/uapi/linux/bpf.h                | 10 ++-
 tools/lib/bpf/libbpf.c                        |  2 +
 .../selftests/bpf/prog_tests/section_names.c  |  5 ++
 .../selftests/bpf/progs/connectun_prog.c      | 27 ++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 83 +++++++++++++++++--
 14 files changed, 206 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..7d0bcd883561 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,8 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connectun``             |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..85da6dc212fb 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -28,6 +28,7 @@ enum cgroup_bpf_attach_type {
 	CGROUP_INET6_BIND,
 	CGROUP_INET4_CONNECT,
 	CGROUP_INET6_CONNECT,
+	CGROUP_UNIX_CONNECT,
 	CGROUP_INET4_POST_BIND,
 	CGROUP_INET6_POST_BIND,
 	CGROUP_UDP4_SENDMSG,
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..3e3a450e0f17 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -48,6 +48,7 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_INET6_BIND);
 	CGROUP_ATYPE(CGROUP_INET4_CONNECT);
 	CGROUP_ATYPE(CGROUP_INET6_CONNECT);
+	CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
 	CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
 	CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
 	CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
@@ -273,7 +274,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
 	((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||		       \
-	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
+	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT) ||		       \
+	  cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) &&		       \
 	 (sk)->sk_prot->pre_connect)
 
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
@@ -282,12 +284,18 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)			       \
 	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET6_CONNECT)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr)		               \
+	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_UNIX_CONNECT)
+
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)		       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET4_CONNECT, NULL)
 
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)		       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET6_CONNECT, NULL)
 
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr)		       \
+	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UNIX_CONNECT, NULL)
+
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
 	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_SENDMSG, t_ctx)
 
@@ -491,6 +499,8 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr) ({ 0; })
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f89de51a45db..8acfaddca772 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1001,6 +1001,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_INET6_BIND,
 	BPF_CGROUP_INET4_CONNECT,
 	BPF_CGROUP_INET6_CONNECT,
+	BPF_CGROUP_UNIX_CONNECT,
 	BPF_CGROUP_INET4_POST_BIND,
 	BPF_CGROUP_INET6_POST_BIND,
 	BPF_CGROUP_UDP4_SENDMSG,
@@ -2575,8 +2576,8 @@ union bpf_attr {
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
@@ -2809,8 +2810,8 @@ union bpf_attr {
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
@@ -6353,6 +6354,7 @@ struct bpf_sock_addr {
 	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
+	char user_path[108];    /* Allows 1 byte read and write. */
 	__u32 user_port;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order
 				 */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bf2fdb33fb31..f1d20f69b260 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1454,7 +1454,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * @flags: Pointer to u32 which contains higher bits of BPF program
  *         return value (OR'ed together).
  *
- * socket is expected to be of type INET or INET6.
+ * socket is expected to be of type INET, INET6 or UNIX.
  *
  * This function will return %-EPERM if an attached program is found and
  * returned value != 1 during execution. In all other cases, 0 is returned.
@@ -1476,7 +1476,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
 	 */
-	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
+		sk->sk_family != AF_UNIX)
 		return 0;
 
 	if (!ctx.uaddr) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..bbfc918b7541 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2372,6 +2372,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
@@ -3420,6 +3421,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_INET6_BIND:
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 	case BPF_CGROUP_INET4_GETPEERNAME:
 	case BPF_CGROUP_INET6_GETPEERNAME:
 	case BPF_CGROUP_INET4_GETSOCKNAME:
@@ -3587,6 +3589,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_INET6_POST_BIND:
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 	case BPF_CGROUP_INET4_GETPEERNAME:
 	case BPF_CGROUP_INET6_GETPEERNAME:
 	case BPF_CGROUP_INET4_GETSOCKNAME:
diff --git a/net/core/filter.c b/net/core/filter.c
index 8607136b6e2c..5dccd74afd77 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -26,6 +26,7 @@
 #include <linux/socket.h>
 #include <linux/sock_diag.h>
 #include <linux/in.h>
+#include <linux/un.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/if_packet.h>
@@ -7665,6 +7666,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 			return &bpf_bind_proto;
 		default:
 			return NULL;
@@ -7695,6 +7697,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
@@ -7713,6 +7716,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_INET6_BIND:
 		case BPF_CGROUP_INET4_CONNECT:
 		case BPF_CGROUP_INET6_CONNECT:
+		case BPF_CGROUP_UNIX_CONNECT:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
 		case BPF_CGROUP_UDP4_SENDMSG:
@@ -8830,6 +8834,14 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		}
 		break;
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_UNIX_CONNECT:
+			break;
+		default:
+			return false;
+		}
+		break;
 	}
 
 	switch (off) {
@@ -8869,6 +8881,10 @@ static bool sock_addr_is_valid_access(int off, int size,
 				return false;
 		}
 		break;
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		if (size != sizeof(char))
+			return false;
+		break;
 	case offsetof(struct bpf_sock_addr, sk):
 		if (type != BPF_READ)
 			return false;
@@ -9931,6 +9947,18 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 			tmp_reg);
 		break;
 
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		/* In kernelspace, addresses are always stored in
+		 * sockaddr_storage so any access in the full range of
+		 * sockaddr_un.sun_path is safe.
+		 */
+		off = si->off;
+		off -= offsetof(struct bpf_sock_addr, user_path[0]);
+		SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD_SIZE_OFF(
+			struct bpf_sock_addr_kern, struct sockaddr_un, uaddr,
+			sun_path, BPF_SIZE(si->code), off, tmp_reg);
+		break;
+
 	case offsetof(struct bpf_sock_addr, user_port):
 		/* To get port we need to know sa_family first and then treat
 		 * sockaddr as either sockaddr_in or sockaddr_in6.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b3545fc68097..afd77908edba 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -115,6 +115,7 @@
 #include <linux/freezer.h>
 #include <linux/file.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf-cgroup.h>
 
 #include "scm.h"
 
@@ -920,11 +921,18 @@ static void unix_unhash(struct sock *sk)
 	 */
 }
 
+static int unix_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+			    int addr_len)
+{
+	return BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr);
+}
+
 struct proto unix_dgram_proto = {
 	.name			= "UNIX",
 	.owner			= THIS_MODULE,
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,
+	.pre_connect            = unix_pre_connect,
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= unix_dgram_bpf_update_proto,
 #endif
@@ -936,6 +944,7 @@ struct proto unix_stream_proto = {
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,
 	.unhash			= unix_unhash,
+	.pre_connect            = unix_pre_connect,
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= unix_stream_bpf_update_proto,
 #endif
@@ -1367,6 +1376,20 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 				goto out;
 		}
 
+		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
+			err = sk->sk_prot->pre_connect(sk, addr, alen);
+			if (err)
+				goto out;
+
+			alen = offsetof(struct sockaddr_un, sun_path) +
+				strnlen(sunaddr->sun_path,
+				sizeof(sunaddr->sun_path)) + 1;
+
+			err = unix_validate_addr(sunaddr, alen);
+			if (err)
+				goto out;
+		}
+
 restart:
 		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
 		if (IS_ERR(other)) {
@@ -1496,6 +1519,20 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (skb == NULL)
 		goto out;
 
+	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
+		err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+		if (err)
+			goto out;
+
+		addr_len = offsetof(struct sockaddr_un, sun_path) +
+			   strnlen(sunaddr->sun_path,
+				   sizeof(sunaddr->sun_path)) + 1;
+
+		err = unix_validate_addr(sunaddr, addr_len);
+		if (err)
+			goto out;
+	}
+
 restart:
 	/*  Find listening sock. */
 	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index c90b756945e3..3fd69d448225 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1067,6 +1067,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_CGROUP_INET6_BIND:		return "bind6";
 	case BPF_CGROUP_INET4_CONNECT:		return "connect4";
 	case BPF_CGROUP_INET6_CONNECT:		return "connect6";
+	case BPF_CGROUP_UNIX_CONNECT:		return "connectun";
 	case BPF_CGROUP_INET4_POST_BIND:	return "post_bind4";
 	case BPF_CGROUP_INET6_POST_BIND:	return "post_bind6";
 	case BPF_CGROUP_INET4_GETPEERNAME:	return "getpeername4";
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f89de51a45db..8acfaddca772 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1001,6 +1001,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_INET6_BIND,
 	BPF_CGROUP_INET4_CONNECT,
 	BPF_CGROUP_INET6_CONNECT,
+	BPF_CGROUP_UNIX_CONNECT,
 	BPF_CGROUP_INET4_POST_BIND,
 	BPF_CGROUP_INET6_POST_BIND,
 	BPF_CGROUP_UDP4_SENDMSG,
@@ -2575,8 +2576,8 @@ union bpf_attr {
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
@@ -2809,8 +2810,8 @@ union bpf_attr {
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
@@ -6353,6 +6354,7 @@ struct bpf_sock_addr {
 	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
+	char user_path[108];    /* Allows 1 byte read and write. */
 	__u32 user_port;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order
 				 */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2a82f49ce16f..ae00819b86f6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -82,6 +82,7 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET6_BIND]		= "cgroup_inet6_bind",
 	[BPF_CGROUP_INET4_CONNECT]	= "cgroup_inet4_connect",
 	[BPF_CGROUP_INET6_CONNECT]	= "cgroup_inet6_connect",
+	[BPF_CGROUP_UNIX_CONNECT]       = "cgroup_unix_connect",
 	[BPF_CGROUP_INET4_POST_BIND]	= "cgroup_inet4_post_bind",
 	[BPF_CGROUP_INET6_POST_BIND]	= "cgroup_inet6_post_bind",
 	[BPF_CGROUP_INET4_GETPEERNAME]	= "cgroup_inet4_getpeername",
@@ -8592,6 +8593,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/connectun",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE),
diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..1b5723106c71 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -123,6 +123,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT},
 		{0, BPF_CGROUP_INET6_CONNECT},
 	},
+	{
+		"cgroup/connectun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT},
+		{0, BPF_CGROUP_UNIX_CONNECT},
+	},
 	{
 		"cgroup/sendmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG},
diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
new file mode 100644
index 000000000000..91097bd8df3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Facebook
+
+#include <string.h>
+
+#include <linux/stddef.h>
+#include <linux/bpf.h>
+#include <linux/if.h>
+#include <errno.h>
+
+#include <bpf/bpf_helpers.h>
+
+#define DST_REWRITE_PATH	"/tmp/bpf_cgroup_unix_test_rewrite"
+
+SEC("cgroup/connectun")
+int connect_un_prog(struct bpf_sock_addr *ctx)
+{
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 0;
+
+	/* Rewrite destination. */
+	memcpy(ctx->user_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH));
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 2c89674fc62c..3e747b7b4f94 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -12,6 +12,7 @@
 #include <sys/types.h>
 #include <sys/select.h>
 #include <sys/socket.h>
+#include <sys/un.h>
 
 #include <linux/filter.h>
 
@@ -28,6 +29,7 @@
 #define CG_PATH	"/foo"
 #define CONNECT4_PROG_PATH	"./connect4_prog.bpf.o"
 #define CONNECT6_PROG_PATH	"./connect6_prog.bpf.o"
+#define CONNECTUN_PROG_PATH	"./connectun_prog.bpf.o"
 #define SENDMSG4_PROG_PATH	"./sendmsg4_prog.bpf.o"
 #define SENDMSG6_PROG_PATH	"./sendmsg6_prog.bpf.o"
 #define RECVMSG4_PROG_PATH	"./recvmsg4_prog.bpf.o"
@@ -51,6 +53,9 @@
 #define SERV6_PORT		6060
 #define SERV6_REWRITE_PORT	6666
 
+#define SERV_UNIX_PATH		"/tmp/bpf_cgroup_unix_test"
+#define SERV_UNIX_REWRITE_PATH	"/tmp/bpf_cgroup_unix_test_rewrite"
+
 #define INET_NTOP_BUF	40
 
 struct sock_addr_test;
@@ -90,6 +95,7 @@ static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
+static int connectun_prog_load(const struct sock_addr_test *test);
 static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int recvmsg_allow_prog_load(const struct sock_addr_test *test);
@@ -331,6 +337,34 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		"connectun: rewrite SOCK_STREAM path",
+		connectun_prog_load,
+		BPF_CGROUP_UNIX_CONNECT,
+		BPF_CGROUP_UNIX_CONNECT,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERV_UNIX_PATH,
+		0,
+		SERV_UNIX_REWRITE_PATH,
+		0,
+		NULL,
+		SUCCESS,
+	},
+	{
+		"connectun: rewrite SOCK_DGRAM path",
+		connectun_prog_load,
+		BPF_CGROUP_UNIX_CONNECT,
+		BPF_CGROUP_UNIX_CONNECT,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERV_UNIX_PATH,
+		0,
+		SERV_UNIX_REWRITE_PATH,
+		0,
+		NULL,
+		SUCCESS,
+	},
 
 	/* sendmsg */
 	{
@@ -603,13 +637,14 @@ static struct sock_addr_test tests[] = {
 	},
 };
 
-static int mk_sockaddr(int domain, const char *ip, unsigned short port,
+static int mk_sockaddr(int domain, const char *address, unsigned short port,
 		       struct sockaddr *addr, socklen_t addr_len)
 {
 	struct sockaddr_in6 *addr6;
 	struct sockaddr_in *addr4;
+	struct sockaddr_un *addrun;
 
-	if (domain != AF_INET && domain != AF_INET6) {
+	if (domain != AF_INET && domain != AF_INET6 && domain != AF_UNIX) {
 		log_err("Unsupported address family");
 		return -1;
 	}
@@ -622,8 +657,8 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 		addr4 = (struct sockaddr_in *)addr;
 		addr4->sin_family = domain;
 		addr4->sin_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1) {
-			log_err("Invalid IPv4: %s", ip);
+		if (inet_pton(domain, address, (void *)&addr4->sin_addr) != 1) {
+			log_err("Invalid IPv4: %s", address);
 			return -1;
 		}
 	} else if (domain == AF_INET6) {
@@ -632,10 +667,16 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 		addr6 = (struct sockaddr_in6 *)addr;
 		addr6->sin6_family = domain;
 		addr6->sin6_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1) {
-			log_err("Invalid IPv6: %s", ip);
+		if (inet_pton(domain, address, (void *)&addr6->sin6_addr) != 1) {
+			log_err("Invalid IPv6: %s", address);
 			return -1;
 		}
+	} else if (domain == AF_UNIX) {
+		if (addr_len < sizeof(struct sockaddr_un))
+			return -1;
+		addrun = (struct sockaddr_un *)addr;
+		addrun->sun_family = domain;
+		strcpy(addrun->sun_path, address);
 	}
 
 	return 0;
@@ -714,6 +755,11 @@ static int connect6_prog_load(const struct sock_addr_test *test)
 	return load_path(test, CONNECT6_PROG_PATH);
 }
 
+static int connectun_prog_load(const struct sock_addr_test *test)
+{
+	return load_path(test, CONNECTUN_PROG_PATH);
+}
+
 static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
 				   int32_t rc)
 {
@@ -890,6 +936,7 @@ static int cmp_addr(const struct sockaddr_storage *addr1,
 {
 	const struct sockaddr_in *four1, *four2;
 	const struct sockaddr_in6 *six1, *six2;
+	const struct sockaddr_un *un1, *un2;
 
 	if (addr1->ss_family != addr2->ss_family)
 		return -1;
@@ -905,6 +952,10 @@ static int cmp_addr(const struct sockaddr_storage *addr1,
 		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
 			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
 				 sizeof(struct in6_addr)));
+	} else if (addr1->ss_family == AF_UNIX) {
+		un1 = (const struct sockaddr_un *)addr1;
+		un2 = (const struct sockaddr_un *)addr2;
+		return memcmp(un1->sun_path, un2->sun_path, sizeof(un1->sun_path));
 	}
 
 	return -1;
@@ -949,6 +1000,13 @@ static int start_server(int type, const struct sockaddr_storage *addr,
 		goto out;
 	}
 
+	if (addr->ss_family == AF_UNIX) {
+		struct sockaddr_un *un = (struct sockaddr_un *) addr;
+
+		addr_len = strlen(un->sun_path) + sizeof(un->sun_family);
+		unlink(un->sun_path);
+	}
+
 	if (bind(fd, (const struct sockaddr *)addr, addr_len) == -1) {
 		log_err("Failed to bind server socket");
 		goto close_out;
@@ -977,7 +1035,7 @@ static int connect_to_server(int type, const struct sockaddr_storage *addr,
 
 	domain = addr->ss_family;
 
-	if (domain != AF_INET && domain != AF_INET6) {
+	if (domain != AF_INET && domain != AF_INET6 && domain != AF_UNIX) {
 		log_err("Unsupported address family");
 		goto err;
 	}
@@ -988,6 +1046,12 @@ static int connect_to_server(int type, const struct sockaddr_storage *addr,
 		goto err;
 	}
 
+	if (addr->ss_family == AF_UNIX) {
+		struct sockaddr_un *un = (struct sockaddr_un *) addr;
+
+		addr_len = strlen(un->sun_path) + sizeof(un->sun_family);
+	}
+
 	if (connect(fd, (const struct sockaddr *)addr, addr_len) == -1) {
 		log_err("Fail to connect to server");
 		goto err;
@@ -1225,10 +1289,10 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (cmp_peer_addr(clientfd, &expected_addr))
 		goto err;
 
-	if (cmp_local_ip(clientfd, &expected_src_addr))
+	if (test->domain != AF_UNIX && cmp_local_ip(clientfd, &expected_src_addr))
 		goto err;
 
-	if (test->type == SOCK_STREAM) {
+	if (test->domain != AF_UNIX && test->type == SOCK_STREAM) {
 		/* Test TCP Fast Open scenario */
 		clientfd = fastconnect_to_server(&requested_addr, addr_len);
 		if (clientfd == -1)
@@ -1346,6 +1410,7 @@ static int run_test_case(int cgfd, const struct sock_addr_test *test)
 		break;
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 		err = run_connect_test_case(test);
 		break;
 	case BPF_CGROUP_UDP4_SENDMSG:
-- 
2.38.1

