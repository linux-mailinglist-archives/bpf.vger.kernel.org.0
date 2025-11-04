Return-Path: <bpf+bounces-73405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37642C2E978
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 01:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145A81899F04
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 00:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002112222C4;
	Tue,  4 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHdH/zPa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAD1DF75C;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215978; cv=none; b=jNMOYBBQTWE4WS4S4RrUlS+mo7gaFNwKDrpTIWnhje+6HrLkVMXd/aYZiQhBi2e5ywizE/wN0sdRUtXBFeNHmH4yNC318om4yB0uMEgMlu1oV46iuEoxfWDh4TAbOqXNNChZKZ4OHnx+Ho8p20wR15x9C1bGm4cSUop74uawRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215978; c=relaxed/simple;
	bh=zu1yRkxgkwO1m+WhW+shN6CHyxSTyeqzLG+j0Q9kIR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkHimUiogrcnUmL8ms2fu800zkxi9lps6N0Td0COh4OcWiu2Pg63okIrV1jWUdu7wWX4zKi8fwY51ciWnbJ8BhllEdlEYHOMNiA+bCYM0dSgxDwuMqZlBWu2S5kou17jq5JdLJ85OB/cyui/gxlHpKFloJyFznpqqPegfIf3zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHdH/zPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC55C2BCB5;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215978;
	bh=zu1yRkxgkwO1m+WhW+shN6CHyxSTyeqzLG+j0Q9kIR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHdH/zPahEZCN70C54X4ybFD3r7EyN12OYSaPAKfNuTvJwvP2EF45IR6A5/HZesZT
	 VeFSjXlKzQaf7n17DgKe/CA7+TddQbFchsWIvA02LiiHxzNzMwYsF/dDbqXjcqhZgy
	 +xl91DR6xksiC9Abl4P+48HoaAv8c2l/qqvwn6IjpukvW29ZcnIGgjWC6CgxJ6DnYx
	 s4c4ZEQ8bBz1NB/R142J3cOFn+5+9xO8JuKVEJJqeyyevXMzN0fr4psP++MD7ES79m
	 bZYSCNc+qrVcHPzkP1HU4CCFkjjtCglyoalmu1KZWeYy4BLe99kMLq5dtk31Q6W6Yg
	 7A04dccFMSIAw==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v5 6/8] bpf: Convert cgroup sockaddr filters to use sockaddr_unsized consistently
Date: Mon,  3 Nov 2025 16:26:14 -0800
Message-Id: <20251104002617.2752303-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=kees@kernel.org; h=from:subject; bh=zu1yRkxgkwO1m+WhW+shN6CHyxSTyeqzLG+j0Q9kIR4=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmcHurivZYLZ7uWfvNiS5onl747QWe1QoTXxLUixazXq u5cZ87uKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMic5YwMk2wvWf+ds/jH60Sj +tVpzz88KTew//fE016m2e6vVz/nZIbf7OxsX57zZ+gs8t2ry810y1C1QrH17sQVoasr2hrWeSc xAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update BPF cgroup sockaddr filtering infrastructure to use sockaddr_unsized
consistently throughout the call chain, removing redundant explicit casts
from callers.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/bpf-cgroup.h | 17 ++++++++++-------
 kernel/bpf/cgroup.c        |  4 ++--
 net/ipv4/af_inet.c         |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a7fb4f46974f..d1eb5c7729cb 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -120,7 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 			       enum cgroup_bpf_attach_type atype);
 
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
-				      struct sockaddr *uaddr,
+				      struct sockaddr_unsized *uaddr,
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
+				(struct sockaddr_unsized *)uaddr, uaddrlen,     \
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
+				(struct sockaddr_unsized *)uaddr, uaddrlen,     \
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
+				(struct sockaddr_unsized *)uaddr, uaddrlen,     \
+				atype, NULL, &__flags);			       \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
 			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 248f517d66d0..497aedc9afa1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1665,7 +1665,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
  * returned value != 1 during execution. In all other cases, 0 is returned.
  */
 int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
-				      struct sockaddr *uaddr,
+				      struct sockaddr_unsized *uaddr,
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
index d5ac089356eb..a31b94ce8968 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -834,7 +834,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin_port = inet->inet_dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
+		BPF_CGROUP_RUN_SA_PROG(sk, sin, &sin_addr_len,
 				       CGROUP_INET4_GETPEERNAME);
 	} else {
 		__be32 addr = inet->inet_rcv_saddr;
@@ -842,7 +842,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
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


