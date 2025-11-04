Return-Path: <bpf+bounces-73404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CFC2E98D
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 01:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1877B4F6721
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5C2222B6;
	Tue,  4 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw9n/siD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C1E0DD8;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215978; cv=none; b=JdSB8gCTxRcnVT4tg+2lk8wZkal1+utovyjvtB3yTbfWIr8SPyOO49iktBwBBaYugm0UuInpLVVHXPg+RKGaUj5mUfkxxO9062G91UEj9SJqGXi0E+OjqpqOmJnUhta23QJWzuWE19HfButXJw7juo+je0Ne1RL1nznJ/Rct3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215978; c=relaxed/simple;
	bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGe7mkODbih8POKdEvr3N1wwmXue+fSlS9nxanMEdx7BEscLLF0lDx+Slyu2bhEMVBE0vIr78fzrvImUvm1OM94YR+FW5fcK1UgKpJWM+vDG1aCTPIvbx0lagewGfxXy5Av4Y4FVBZqQtPHGFvVLyGNki80HCgejies2nUDXdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw9n/siD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74909C2BCB3;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215978;
	bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uw9n/siDAHaIB+zV3R6YUl0jij/+ZUNkmF6kPFycBrtOd+ZjIoBdfF6TGW9B05PRn
	 d+V8jD4T753YI1U9KaKHTJ+QWs7REpoog3JUkEMH6Lv5h72v7kcyre+qxZ74GYt3TK
	 M6qSOLZ7CPcZCjiC8BzZd0/me0OI6dbJTy4U9KuswUKEyCDt//PxCNwfT+EGufGmNu
	 2ZXj6QulCXP6UxylBPfutvUWfUamGF0tSOl4sn28Yy8og6VlevjU7Yj67gZt6qe00g
	 q9Ek2KOozPqA2PLvvzvI1yo+p8B5g4D3wIilpSCWijPI2qN0k2RTVHvfgcnyOgc0nE
	 5/l4r9pZqWisw==
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
Subject: [PATCH net-next v5 7/8] bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unsized
Date: Mon,  3 Nov 2025 16:26:15 -0800
Message-Id: <20251104002617.2752303-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=kees@kernel.org; h=from:subject; bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmcHuo7NYVVgjY+K7vg5Hp4fpi8bE34/y1Kznej1kt94 nnPxHa+o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJbpzEynNpX8mXtKu+Xz21+ pFvPmv1GMPy3fPMCeYnG01lLTYW9JzH8j/M9odi6LHvJs6dvLszX/uQyh0vy3/7EM0u3vVl65m7 SQwYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Change struct bpf_sock_addr_kern to use sockaddr_unsized for the "uaddr"
field instead of sockaddr. This improves type safety in the BPF cgroup
socket address filtering code.

The casting in __cgroup_bpf_run_filter_sock_addr() is updated to match the
new type, removing an unnecessary cast in the initialization and updating
the conditional assignment to use the appropriate sockaddr_unsized cast.

Additionally rename the "unspec" variable to "storage" to better align
with its usage.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/filter.h | 2 +-
 kernel/bpf/cgroup.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..e116de7edc58 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1515,7 +1515,7 @@ static inline int bpf_tell_extensions(void)
 
 struct bpf_sock_addr_kern {
 	struct sock *sk;
-	struct sockaddr *uaddr;
+	struct sockaddr_unsized *uaddr;
 	/* Temporary "register" to make indirect stores to nested structures
 	 * defined above. We need three registers to make such a store, but
 	 * only two (src and dst) are available at convert_ctx_access time
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 497aedc9afa1..69988af44b37 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1673,10 +1673,10 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 {
 	struct bpf_sock_addr_kern ctx = {
 		.sk = sk,
-		.uaddr = (struct sockaddr *)uaddr,
+		.uaddr = uaddr,
 		.t_ctx = t_ctx,
 	};
-	struct sockaddr_storage unspec;
+	struct sockaddr_storage storage;
 	struct cgroup *cgrp;
 	int ret;
 
@@ -1688,8 +1688,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 		return 0;
 
 	if (!ctx.uaddr) {
-		memset(&unspec, 0, sizeof(unspec));
-		ctx.uaddr = (struct sockaddr *)&unspec;
+		memset(&storage, 0, sizeof(storage));
+		ctx.uaddr = (struct sockaddr_unsized *)&storage;
 		ctx.uaddrlen = 0;
 	} else {
 		ctx.uaddrlen = *uaddrlen;
-- 
2.34.1


