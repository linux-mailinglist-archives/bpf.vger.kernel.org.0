Return-Path: <bpf+bounces-70940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E45BDBAF9
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB8950031D
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763630F92D;
	Tue, 14 Oct 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyu4wPuJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9030DEAB;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=XifE3i2Fp5/6X8AXucBkQx+KraohSqC7A1++HEX9Ov7PV0qBOhW/V0WY83Ba7rKoSwDzUUYQvCkJ2lrV0dKA4KeNQ/5tvnnjKs1CBFkPnlqt/UOIG/qKVT1wJfyMg3Lc1tYQHsGSDFJWmSap9Iywky5hEVq7GEFhoKYrDkcCsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYxcqt8eF/11zXnR3dlN1jiidXZfK9b/B6EWamO3j2HTInQLxjeEvlhJbVIN0Ps+V6Jeyv4NfSA6AOpPPxJeTS5QV8cy7G59maWF9URdHTpxVrubEnjFHyp/nKyeZSQunfg4NHLsbncEMrSTp++j0Ey02xN816sxs9CqprhkvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yyu4wPuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9892C2BCB2;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yyu4wPuJqUjvdi04tlrov6AQFIg7Q61udKlQaA0inwpIywRjQBd/HMkUQOVLff2GD
	 Yn9z8jwGPuk4tHAQt6wuQtlIS/6gC0YOFNU5cwoASMfhMH+jdkP9co4muP7I6WBMML
	 ZnLezFWyO+9Y0dzJbMNAPRMXc7fUik78q/8va5cshh9MGV1vydN2ORxAre6x5u+LCG
	 LMkz8DCAXsI3vYU92Z3zw8w7fOnZKaBxRgaUdHD59GCFQiORuBNygscJorxmnbX3UO
	 zQP4sSxDCVA3OEHKGMsqGrUMY2s493NXrpenFVJlgk79d20eq06+oC3fwpHISewVbr
	 OoeXEI1cpgMaA==
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
Subject: [PATCH v2 07/10] bpf: Convert cgroup sockaddr filters to use sockaddr_unspec consistently
Date: Tue, 14 Oct 2025 15:43:29 -0700
Message-Id: <20251014224334.2344521-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5097; i=kees@kernel.org; h=from:subject; bh=oDFsq+yPcHCa/fvTPPasjIVx6L9+9p2F6yJKxmOzzBw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgk9Vun9G/S+NPl0xatLF73Pr4r5ZWjwOWzLLNU5D lmbNFz+dJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkUz8jwzSG3eadLLMOnXUS WljLOaNa9N8RG/bTClEqr7u9/YUaKhgZ3qzNN9gtZ/eY6VC9XN0tPfvIWdPLP7heeKC5vvFaiuh XXgA=
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


