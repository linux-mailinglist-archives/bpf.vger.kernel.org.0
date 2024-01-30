Return-Path: <bpf+bounces-20780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92868842E94
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 22:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B501B24506
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D76762EC;
	Tue, 30 Jan 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn+bHRrj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3B79DD4
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649635; cv=none; b=Hd+snMEv6J1l5Y0oBk50FW2yrs8rAr6ExsbL1AGYdyApPmDCNFD6sJ2vDEopl4JBWK5vSDYZPmNSQt4F3mCwNoPRQrnZ2XUmzE9x+Rjl6nCi4icu9UpOS/n623aT2ZXA9gBhQPDm6z2u4Xdbieifv9B9kCBvbR5KcB37dJF0Wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649635; c=relaxed/simple;
	bh=iioc5PMk/kXub0TZKrs/g4vlZtCcVZW6CvkNqCkltQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPuDuH/yXGwWnX6qHZrlYFF8VpD+UQ0UkBdYkK0exRSV1SO/nOPKZ9HJ9E0s23e20zxlZ1duak1mQD2HGekTDuB7Afdybexu5R/lLnaCz/U2bZIzY8Rg2ZnSpmi/ppuNWJ3xvH6o3HFhBwj4KW7K7iHxr7t4z0yjJAbRT1UWa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn+bHRrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6900C433F1;
	Tue, 30 Jan 2024 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649635;
	bh=iioc5PMk/kXub0TZKrs/g4vlZtCcVZW6CvkNqCkltQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn+bHRrj4gA6SBNLA7D+2TQfR9Tf/nAty3Sss+2O7bLVlmdtA2W7ynSlMQH1uDN2E
	 lUaHs8OK0R5tndjI0maad14ovnA8p0WneIJWQP8QaOCv68GLA058W2h9Zb7wEMr/t2
	 XVGpCEeGVAV41XOovje/s8ANpYu6sbhTVNHphvQTE63T/Wq+/uv1id7VhMmc+JqYjn
	 rD1V0F33QxX1zsA6h7ugfT9vVBKVBXLb8JiGtiuQWkZxx2jY0P+o16G4+6wYeUIqnI
	 Bmi7SLqhGCDzpgBXxXBmMlPPWZ9KZKfe1nvJRFYlaxB91zFO1QlqBklatpPG+00BMa
	 Ok9Q0C408JImw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro
Date: Tue, 30 Jan 2024 13:20:23 -0800
Message-Id: <20240130212023.183765-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130212023.183765-1-andrii@kernel.org>
References: <20240130212023.183765-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use more ergonomic bpf_core_cast() macro instead of bpf_rdonly_cast() in
selftests code.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/connect_unix_prog.c    | 3 +--
 .../testing/selftests/bpf/progs/getpeername_unix_prog.c  | 3 +--
 .../testing/selftests/bpf/progs/getsockname_unix_prog.c  | 3 +--
 tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c    | 3 +--
 tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c    | 3 +--
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c       | 2 +-
 tools/testing/selftests/bpf/progs/sock_iter_batch.c      | 4 ++--
 tools/testing/selftests/bpf/progs/type_cast.c            | 9 ++++-----
 8 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/connect_unix_prog.c b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
index ca8aa2f116b3..2ef0e0c46d17 100644
--- a/tools/testing/selftests/bpf/progs/connect_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
@@ -28,8 +28,7 @@ int connect_unix_prog(struct bpf_sock_addr *ctx)
 	if (sa_kern->uaddrlen != unaddrlen)
 		return 0;
 
-	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
-						bpf_core_type_id_kernel(struct sockaddr_un));
+	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
 	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
 			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
index 9c078f34bbb2..5a76754f846b 100644
--- a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
@@ -27,8 +27,7 @@ int getpeername_unix_prog(struct bpf_sock_addr *ctx)
 	if (sa_kern->uaddrlen != unaddrlen)
 		return 1;
 
-	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
-						bpf_core_type_id_kernel(struct sockaddr_un));
+	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
 	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
 			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 1;
diff --git a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
index ac7145111497..7867113c696f 100644
--- a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
@@ -27,8 +27,7 @@ int getsockname_unix_prog(struct bpf_sock_addr *ctx)
 	if (sa_kern->uaddrlen != unaddrlen)
 		return 1;
 
-	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
-						bpf_core_type_id_kernel(struct sockaddr_un));
+	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
 	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
 			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 1;
diff --git a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
index 4dfbc8552558..1c7ab44bccfa 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
@@ -27,8 +27,7 @@ int recvmsg_unix_prog(struct bpf_sock_addr *ctx)
 	if (sa_kern->uaddrlen != unaddrlen)
 		return 1;
 
-	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
-						bpf_core_type_id_kernel(struct sockaddr_un));
+	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
 	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
 			sizeof(SERVUN_ADDRESS) - 1) != 0)
 		return 1;
diff --git a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
index 1f67e832666e..d8869b03dda9 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
@@ -28,8 +28,7 @@ int sendmsg_unix_prog(struct bpf_sock_addr *ctx)
 	if (sa_kern->uaddrlen != unaddrlen)
 		return 0;
 
-	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
-						bpf_core_type_id_kernel(struct sockaddr_un));
+	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
 	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
 			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 934c4e5ada5b..46d6eb2a3b17 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -27,7 +27,7 @@ int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
 	if (local_storage_ptr != local_storage)
 		return 0;
 
-	sk = bpf_rdonly_cast(sk_ptr, bpf_core_type_id_kernel(struct sock));
+	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index ffbbfe1fa1c1..96531b0d9d55 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -32,7 +32,7 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	if (!sk)
 		return 0;
 
-	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
+	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != AF_INET6 ||
 	    sk->sk_state != TCP_LISTEN ||
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
@@ -68,7 +68,7 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	if (!sk)
 		return 0;
 
-	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
+	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != AF_INET6 ||
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/type_cast.c b/tools/testing/selftests/bpf/progs/type_cast.c
index 98ab35893f51..9d808b8f4ab0 100644
--- a/tools/testing/selftests/bpf/progs/type_cast.c
+++ b/tools/testing/selftests/bpf/progs/type_cast.c
@@ -46,13 +46,12 @@ int md_skb(struct __sk_buff *skb)
 	/* Simulate the following kernel macro:
 	 *   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
 	 */
-	shared_info = bpf_rdonly_cast(kskb->head + kskb->end,
-		bpf_core_type_id_kernel(struct skb_shared_info));
+	shared_info = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
 	meta_len = shared_info->meta_len;
 	frag0_len = shared_info->frag_list->len;
 
 	/* kskb2 should be equal to kskb */
-	kskb2 = bpf_rdonly_cast(kskb, bpf_core_type_id_kernel(struct sk_buff));
+	kskb2 = bpf_core_cast(kskb, typeof(*kskb2));
 	kskb2_len = kskb2->len;
 	return 0;
 }
@@ -63,7 +62,7 @@ int BPF_PROG(untrusted_ptr, struct pt_regs *regs, long id)
 	struct task_struct *task, *task_dup;
 
 	task = bpf_get_current_task_btf();
-	task_dup = bpf_rdonly_cast(task, bpf_core_type_id_kernel(struct task_struct));
+	task_dup = bpf_core_cast(task, struct task_struct);
 	(void)bpf_task_storage_get(&enter_id, task_dup, 0, 0);
 	return 0;
 }
@@ -71,7 +70,7 @@ int BPF_PROG(untrusted_ptr, struct pt_regs *regs, long id)
 SEC("?tracepoint/syscalls/sys_enter_nanosleep")
 int kctx_u64(void *ctx)
 {
-	u64 *kctx = bpf_rdonly_cast(ctx, bpf_core_type_id_kernel(u64));
+	u64 *kctx = bpf_core_cast(ctx, u64);
 
 	(void)kctx;
 	return 0;
-- 
2.34.1


