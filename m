Return-Path: <bpf+bounces-71455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE4BF3BD5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C79480C1B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542F336EE2;
	Mon, 20 Oct 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brj7LxBr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A263346BC;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=XsQ2XeaU2l+MWxq8yhSxlWHdqrXVaSetqAL2BxeKli+Tv6kRti7IWfO+o6fRUcP1aim3+omRXckcyAmvvYWa9dhV4x5W0uAsnfoER/egK5F+YiXFgd68jGvG1Q4i4XsIMEif+0ywzsNv78LvN7QvNr5AMw0FNtr3kLDal3VNA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWReNVYQRbPb6fbz8QBYy2YV6rsv9QxKyNBXzz4ik9eWKzAAnS2J9rdoWJBb7CB8YwLQ0IXTL+jxj5YPWSFlB/nM3XKFyrYLAgCnHv1uk/JK6UOHqRtd+SxVN5Sf1GYB5sGGWn76QDDn+s/ZtjlQV8oenTzVpG+ArV/bD50lR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brj7LxBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06461C19424;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995600;
	bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brj7LxBrmRWpHKET2z5+SyswA62H0JXAWN2zExl/+vXYD4YkUv3nZK0JBdb46qvFs
	 96P5pDz8wvMGlAU1cSEfiI5fGaxEwxVu7OBoqNue33pPKUE6zsweFuWoh9frEk9II7
	 W3hoQdmEtT6D0KWgfq4k/R2kPWE+oVo6pTyTBpwxF04tvB7PRcCSjGDRlkiCQEf5zK
	 bHqIJVC5q9qP19RxGqSLwH8cXbS+SyKKfplMD/b1VnvDzW1/7Jf8gZkAR8dxyZYeYa
	 tP4vs340FmTqav1qKAF92rsVzI2WsMFMjiz/LHv65BwEnT+Cc+yGVpH1w0tihoJafJ
	 W2poMa47yn0cQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 7/9] bpf: Convert cgroup sockaddr filters to use sockaddr_unspec consistently
Date: Mon, 20 Oct 2025 14:26:36 -0700
Message-Id: <20251020212639.1223484-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5097; i=kees@kernel.org; h=from:subject; bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVvI+Vun9G/S+NPl0xatLF73Pr4r5ZWjwOWzLLNU5D lmbNFz+dJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzk5COGf/bN0mGixrnGwdPT pc/l7tA+8sxuhfZ/y91aPq7z2JVenGX4p8DF1xlrMZuBl3HK9tOfdev4H132rmfST8ux+D1DQcS VEQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update BPF cgroup sockaddr filtering infrastructure to use sockaddr_unspec
consistently throughout the call chain, removing redundant explicit casts
from callers.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 include/linux/bpf-cgroup.h | 17 ++++++++++-------
 kernel/bpf/cgroup.c        |  4 ++--
 net/ipv4/af_inet.c         |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a7fb4f46974f..f9db69cef833 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -120,7 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 			       enum cgroup_bpf_attach_type atype);
 
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
-				      struct sockaddr *uaddr,
+				      struct sockaddr_unspec *uaddr,
 				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
@@ -238,8 +238,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))					       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
-							  atype, NULL, NULL);  \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk,		       \
+				(struct sockaddr_unspec *)uaddr, uaddrlen,     \
+				atype, NULL, NULL);			       \
 	__ret;								       \
 })
 
@@ -248,8 +249,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
-							  atype, t_ctx, NULL); \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk,		       \
+				(struct sockaddr_unspec *)uaddr, uaddrlen,     \
+				atype, t_ctx, NULL);			       \
 		release_sock(sk);					       \
 	}								       \
 	__ret;								       \
@@ -266,8 +268,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
-							  atype, NULL, &__flags); \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk,		       \
+				(struct sockaddr_unspec *)uaddr, uaddrlen,     \
+				atype, NULL, &__flags);			       \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
 			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 248f517d66d0..af8b070e71ba 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1665,7 +1665,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * returned value != 1 during execution. In all other cases, 0 is returned.
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
-				      struct sockaddr *uaddr,
+				      struct sockaddr_unspec *uaddr,
 				      int *uaddrlen,
 				      enum cgroup_bpf_attach_type atype,
 				      void *t_ctx,
@@ -1673,7 +1673,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 {
 	struct bpf_sock_addr_kern ctx = {
 		.sk = sk,
-		.uaddr = uaddr,
+		.uaddr = (struct sockaddr *)uaddr,
 		.t_ctx = t_ctx,
 	};
 	struct sockaddr_storage unspec;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 74a71f3c9ada..07b164f8529d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -813,7 +813,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
+		BPF_CGROUP_RUN_SA_PROG(sk, sin, &sin_addr_len,
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -821,7 +821,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 			addr = inet->inet_saddr;
 		sin->sin_port = inet->inet_sport;
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
+		BPF_CGROUP_RUN_SA_PROG(sk, sin, &sin_addr_len,
 				       CGROUP_INET4_GETSOCKNAME);
 	}
 	release_sock(sk);
-- 
2.34.1


