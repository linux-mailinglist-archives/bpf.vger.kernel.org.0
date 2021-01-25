Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF613028D4
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 18:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbhAYR1i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 12:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbhAYR11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 12:27:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DAC06178B
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 09:26:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c13so5863028ybg.8
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KA3LlxQnwkmhXzMgKRGSu/049kauUQh/qhyWcFDQLsw=;
        b=V6nh5IMS76ftyZlGLqLDoewgIJEdMW2Zra90yrAmvwdaMEN936CBNskkm3q+EgQG5g
         PhQg0cpS8L6A0wNvabDZ9yMkqfJaP16M3nl5xg0FSF1c7o5E3sVA9ABDpGlocD0h7yk4
         maKaBdXFLL5JWyfVzsgcHLnHtN3Z3htoKbq93xgSbFhUoElQzVnc8i70KN6aE5pHygB/
         +Rq9u7ZUtq5ZBvvm+treoM0mDLvNoRtyrwQ1xg2/2cGckE1mtRpS73sDSUxoxqPKf/+N
         wfzQPSIxBh4Ga5IsluLNLat0faUytbWOnjRLWoE8+CqqbsNVRxGG3jfP4+bVzNJM8WnG
         +rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KA3LlxQnwkmhXzMgKRGSu/049kauUQh/qhyWcFDQLsw=;
        b=H12r9Cth3UqLQdarOT3BqNgRib7+o7BmX/AgBznyALqsE4AdOpXqC/o9tuTDUbrZ/u
         NxcbREq0o/CzFkLZLjeZfi2eP+8M3BVIxnkRhEUG/1NX3zu/ysEdWgpb84qo4j+TtM1L
         ORy2xP0se3EUKooyNp/oJpEvldw8++MeH5INKS/cKkZ14Oy6lX8CP+x4KiZbf4HlG0nZ
         5sujrzNWGv0dy/43bM0Jp4I9z5wFriLnRtBMiqSfwRsPvGFyzI8AVSCjt14qZUceS0qD
         Dn3ysuFUd7dBFBJDp6Hz2cwBz1JIb7wm7vnh7BOpJZ7euSe9Fb8nkOl2ZhaXRxKk/5mj
         DFkA==
X-Gm-Message-State: AOAM53265adTlA6JxK7uau8q3rxM61zwyVo6hmaRLRTkx7X0Cpplp5s1
        Gz3uIku54vnS6LrhcBwv6micemM=
X-Google-Smtp-Source: ABdhPJxz6sdwlX3nPSIQc7dEuiq9f6kR42g502zBcg5N6H9eXE16/Rwg7pVK+TdPJ53ARsEv5P/Q0QY=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:aba4:: with SMTP id v33mr2483446ybi.388.1611595603151;
 Mon, 25 Jan 2021 09:26:43 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:26:40 -0800
Message-Id: <20210125172641.3008234-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH bpf-next v2 1/2] bpf: allow rewriting to ports under ip_unprivileged_port_start
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At the moment, BPF_CGROUP_INET{4,6}_BIND hooks can rewrite user_port
to the privileged ones (< ip_unprivileged_port_start), but it will
be rejected later on in the __inet_bind or __inet6_bind.

Let's export 'port_changed' event from the BPF program and bypass
ip_unprivileged_port_start range check when we've seen that
the program explicitly overrode the port. This is accomplished
by generating instructions to set ctx->port_changed along with
updating ctx->user_port.

Cc: Andrey Ignatov <rdna@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup.h | 38 ++++++++++++++++++++++++---------
 include/linux/bpf.h        | 43 ++++++++++++++++++++++----------------
 include/net/inet_common.h  |  3 +++
 kernel/bpf/cgroup.c        |  8 +++++--
 kernel/bpf/verifier.c      |  5 +++++
 net/ipv4/af_inet.c         |  9 +++++---
 net/ipv6/af_inet6.c        |  6 ++++--
 7 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 0748fd87969e..6232745bae9b 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -125,7 +125,8 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
 				      enum bpf_attach_type type,
-				      void *t_ctx);
+				      void *t_ctx,
+				      u32 *flags);
 
 int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 				     struct bpf_sock_ops_kern *sock_ops,
@@ -231,30 +232,48 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 
 #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, type)				       \
 ({									       \
+	u32 __unused_flags;						       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(type))					       \
 		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
-							  NULL);	       \
+							  NULL,		       \
+							  &__unused_flags);    \
 	__ret;								       \
 })
 
 #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, type, t_ctx)		       \
 ({									       \
+	u32 __unused_flags;						       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(type))	{				       \
 		lock_sock(sk);						       \
 		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
-							  t_ctx);	       \
+							  t_ctx,	       \
+							  &__unused_flags);    \
 		release_sock(sk);					       \
 	}								       \
 	__ret;								       \
 })
 
-#define BPF_CGROUP_RUN_PROG_INET4_BIND_LOCK(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET4_BIND, NULL)
-
-#define BPF_CGROUP_RUN_PROG_INET6_BIND_LOCK(sk, uaddr)			       \
-	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, BPF_CGROUP_INET6_BIND, NULL)
+/* BPF_CGROUP_INET4_BIND and BPF_CGROUP_INET6_BIND can return extra flags
+ * via upper bits of return code. The only flag that is supported
+ * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
+ * should be bypassed.
+ */
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, type, flags)	       \
+({									       \
+	u32 __flags = 0;						       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled(type))	{				       \
+		lock_sock(sk);						       \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, type,     \
+							  NULL, &__flags);     \
+		release_sock(sk);					       \
+		if (__flags & 1)					       \
+			*flags |= BIND_NO_CAP_NET_BIND_SERVICE;		       \
+	}								       \
+	__ret;								       \
+})
 
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
 	((cgroup_bpf_enabled(BPF_CGROUP_INET4_CONNECT) ||		       \
@@ -453,8 +472,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET4_BIND_LOCK(sk, uaddr) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_INET6_BIND_LOCK(sk, uaddr) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, type, flags) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1aac2af12fed..08eee284d251 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1073,6 +1073,29 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array);
 
+#define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, flags)		\
+	({								\
+		struct bpf_prog_array_item *_item;			\
+		struct bpf_prog *_prog;					\
+		struct bpf_prog_array *_array;				\
+		u32 _ret = 1;						\
+		u32 ret;						\
+		migrate_disable();					\
+		rcu_read_lock();					\
+		_array = rcu_dereference(array);			\
+		_item = &_array->items[0];				\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			ret = func(_prog, ctx);				\
+			_ret &= (ret & 1);				\
+			*(flags) |= (ret >> 1);				\
+			_item++;					\
+		}							\
+		rcu_read_unlock();					\
+		migrate_enable();					\
+		_ret;							\
+	 })
+
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
 		struct bpf_prog_array_item *_item;	\
@@ -1120,25 +1143,9 @@ _out:							\
  */
 #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)		\
 	({						\
-		struct bpf_prog_array_item *_item;	\
-		struct bpf_prog *_prog;			\
-		struct bpf_prog_array *_array;		\
-		u32 ret;				\
-		u32 _ret = 1;				\
 		u32 _cn = 0;				\
-		migrate_disable();			\
-		rcu_read_lock();			\
-		_array = rcu_dereference(array);	\
-		_item = &_array->items[0];		\
-		while ((_prog = READ_ONCE(_item->prog))) {		\
-			bpf_cgroup_storage_set(_item->cgroup_storage);	\
-			ret = func(_prog, ctx);		\
-			_ret &= (ret & 1);		\
-			_cn |= (ret & 2);		\
-			_item++;			\
-		}					\
-		rcu_read_unlock();			\
-		migrate_enable();			\
+		u32 _ret;				\
+		_ret = BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, &_cn); \
 		if (_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index cb2818862919..9ba935c15869 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -41,6 +41,9 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
 #define BIND_WITH_LOCK			(1 << 1)
 /* Called from BPF program. */
 #define BIND_FROM_BPF			(1 << 2)
+/* Skip CAP_NET_BIND_SERVICE check. */
+#define BIND_NO_CAP_NET_BIND_SERVICE	(1 << 3)
+
 int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		u32 flags);
 int inet_getname(struct socket *sock, struct sockaddr *uaddr,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index da649f20d6b2..cdf3c7e611d9 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1055,6 +1055,8 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * @uaddr: sockaddr struct provided by user
  * @type: The type of program to be exectuted
  * @t_ctx: Pointer to attach type specific context
+ * @flags: Pointer to u32 which contains higher bits of BPF program
+ *         return value (OR'ed together).
  *
  * socket is expected to be of type INET or INET6.
  *
@@ -1064,7 +1066,8 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 				      struct sockaddr *uaddr,
 				      enum bpf_attach_type type,
-				      void *t_ctx)
+				      void *t_ctx,
+				      u32 *flags)
 {
 	struct bpf_sock_addr_kern ctx = {
 		.sk = sk,
@@ -1087,7 +1090,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	}
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
+	ret = BPF_PROG_RUN_ARRAY_FLAGS(cgrp->bpf.effective[type], &ctx,
+				       BPF_PROG_RUN, flags);
 
 	return ret == 1 ? 0 : -EPERM;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0eae51b31e4..ef7c3ca53214 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7986,6 +7986,11 @@ static int check_return_code(struct bpf_verifier_env *env)
 		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME)
 			range = tnum_range(1, 1);
+		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
+		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND) {
+			range = tnum_range(0, 3);
+			enforce_attach_type_range = tnum_range(0, 3);
+		}
 		break;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 6ba2930ff49b..aaa94bea19c3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -438,6 +438,7 @@ EXPORT_SYMBOL(inet_release);
 int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
+	u32 flags = BIND_WITH_LOCK;
 	int err;
 
 	/* If the socket has its own bind function then use it. (RAW) */
@@ -450,11 +451,12 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET4_BIND_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+						 BPF_CGROUP_INET4_BIND, &flags);
 	if (err)
 		return err;
 
-	return __inet_bind(sk, uaddr, addr_len, BIND_WITH_LOCK);
+	return __inet_bind(sk, uaddr, addr_len, flags);
 }
 EXPORT_SYMBOL(inet_bind);
 
@@ -499,7 +501,8 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
-	if (snum && inet_port_requires_bind_service(net, snum) &&
+	if (!(flags & BIND_NO_CAP_NET_BIND_SERVICE) &&
+	    snum && inet_port_requires_bind_service(net, snum) &&
 	    !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
 		goto out;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b9c654836b72..3e523c4f5226 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -439,6 +439,7 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
+	u32 flags = BIND_WITH_LOCK;
 	int err = 0;
 
 	/* If the socket has its own bind function then use it. */
@@ -451,11 +452,12 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	/* BPF prog is run before any checks are done so that if the prog
 	 * changes context in a wrong way it will be caught.
 	 */
-	err = BPF_CGROUP_RUN_PROG_INET6_BIND_LOCK(sk, uaddr);
+	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
+						 BPF_CGROUP_INET6_BIND, &flags);
 	if (err)
 		return err;
 
-	return __inet6_bind(sk, uaddr, addr_len, BIND_WITH_LOCK);
+	return __inet6_bind(sk, uaddr, addr_len, flags);
 }
 EXPORT_SYMBOL(inet6_bind);
 
-- 
2.30.0.280.ga3ce27912f-goog

