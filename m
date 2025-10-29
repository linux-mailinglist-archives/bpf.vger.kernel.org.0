Return-Path: <bpf+bounces-72909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6CBC1D7CE
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DB4E35A2
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954132A3C5;
	Wed, 29 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUeIXh/o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C131B82C;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774269; cv=none; b=mjKBQ9jtFqGD/oLq2Na84Hi9b7wgIfVuZFqIYH7DNy03eiIv1aNLVSwfMxgYsml9NHSsaCKpxokLy4A6Ev2s5Z1+FYvPpqOZ/PVth8AvUxBRhYYq6OZuSqRCtUmdJQ3eplpGEp7FZhsRYozfEwUxBFJ6DdSqMUEsUtiUfBZLBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774269; c=relaxed/simple;
	bh=7hHzjtV3nElDc0Uq7kbfJhhINXHrIBvwebgH5T/3+R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4mgi4Etf8ITWj1qVH4WwfkeYFFVyP/BBamaV0C38WSF6b5Rq45IyTW3/BmVIWs/9xguV8LWXgw0JZmA8BFS1V+j95NUqPzzekBg4z2m9bVU+qYQ4UPR3WEDdwyE93SbHfgn0DuOCIIZn6oVJyyDzs9A542rLgiKu9arukO1VH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUeIXh/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F3C4AF11;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=7hHzjtV3nElDc0Uq7kbfJhhINXHrIBvwebgH5T/3+R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUeIXh/oMzwR5avVTWsWzBuQaMnPcqY6LYXO+FQ8Fh0tFf423Nir6BEFZs9uctQvj
	 wdk2tWn5BLWUu2O0yQo6+LcB7MjcFbRZqAgWlu1GSHrYDBBk4aAf1kq4eb9UFP5yeR
	 AjNSMfuEFcfRNDmOzkRVgyeDcP+/p8DNa75k2w7cTw9pEIztEZo4+e2lA1Z9w7RQvc
	 qja4XwZQgeQ6rnqAqwK6VNbAiEh9a1Kdsrsc0SHYMeueknLAN3H7gzkRYmL0gCrGBE
	 8uHCeELIvBGfsgEmlGDCFknP5acXIWf34Pk/ff7rqNV9MSkf+8AECI66Dvok7C7YVC
	 sTALBrmhPTMDw==
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
Subject: [net-next PATCH v4 5/7] bpf: Convert cgroup sockaddr filters to use sockaddr_unsized consistently
Date: Wed, 29 Oct 2025 14:44:02 -0700
Message-Id: <20251029214428.2467496-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=kees@kernel.org; h=from:subject; bh=7hHzjtV3nElDc0Uq7kbfJhhINXHrIBvwebgH5T/3+R8=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXYvalr8XP+xRxMmh8FKxJu1jaM3Bk/e7drtJvpqQe DeHN3J1RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwES0PjP8U1/zPEPhzQzJlMZ9 OR5nQowuMHE6Sib8lM2P9r50RCHGmZHhov890RL+njNNXWxn2itrDx1Ytsx9otkpLveoxoN72xa yAQA=
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
index 85aee1b18f89..efbdfd728515 100644
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


