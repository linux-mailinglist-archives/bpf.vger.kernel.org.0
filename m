Return-Path: <bpf+bounces-71459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DABF3BE3
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B71C40321A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258F33711B;
	Mon, 20 Oct 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuuxRNQJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89398334C2A;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=JzYP4pSaGQjrKeiUmLrm1iZTy1FFbAF3NEHxMeYu0bD8NJAXmiJTtepKmPqQMythFtYAQTiub1hmUXEAoSAU261bHlWRN2mcf+i/2eE7HxFci6uJdNHlyYzFY/RwV15wUGHxsMpuZCNlMdEtlqHe1iRufxF8VEpY7XIMWhRz+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBmOlwhDXi4uNfw7OL1Li+08446IEwOCkxmY0SONGV5GFDk/arqfH1cKNysEADHCkYoaQpYA/CdpPBdAVnYtxhkNlgC2UZlL46gnll2+BQxKk5o5XiK9Z9vhSZBzsrwRAXQ/yQWBgPtmBOnx7qmm8WaMJ4sv6Waz9rs68LDAhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuuxRNQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18112C2BC87;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995600;
	bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuuxRNQJQRwhGoMPmtuh/d4oQEq52faLQQGh9LLOhHV8l56qz0TM0SlCDsc6r/1fR
	 pLy5pE12srwBrSFHxr/j9i48um19R0Q/7ZtyMaX4I9yODgvC71CpChXNCrpGc8pSbO
	 WasgLDqilDOj5CPgPWfN+w5Py4fD8A3jX1eIQxdXWkWYNsIHjp76cORo66MGDy2t+C
	 qzcs7IHLg8fr82LTUl3QOGR5C79LIxGGNSgmdXWfT+7lpnUXKuAevtJKSoS/55RpoO
	 XZiYYjeFHk1UoojzKwDQKH2B/xoU3FIJV6/nvNiWY4tbWONdYvBqzr31pTyulmpkeD
	 aODm9j7PajtsA==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 8/9] bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unspec
Date: Mon, 20 Oct 2025 14:26:37 -0700
Message-Id: <20251020212639.1223484-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=kees@kernel.org; h=from:subject; bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVvK+/9rqufO3Tt3/YlYO1q9NvwSuHxF+0+GbKXzC7 Pm8/isVHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOpnc7I0Hi+jEfk2In0R0dX Cc96mrDj3+u+73xsIlVHih81rSnlvsbI0JQ5XSfwyRauQzd31kupJxi7i94P4jcNFE1r3fW96E4 7GwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Change struct bpf_sock_addr_kern to use sockaddr_unspec for the "uaddr"
field instead of sockaddr. This improves type safety in the BPF cgroup
socket address filtering code.

The casting in __cgroup_bpf_run_filter_sock_addr() is updated to match the
new type, removing an unnecessary cast in the initialization and updating
the conditional assignment to use the appropriate sockaddr_unspec cast.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/filter.h | 2 +-
 kernel/bpf/cgroup.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..52594affe7ee 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1515,7 +1515,7 @@ static inline int bpf_tell_extensions(void)
 
 struct bpf_sock_addr_kern {
 	struct sock *sk;
-	struct sockaddr *uaddr;
+	struct sockaddr_unspec *uaddr;
 	/* Temporary "register" to make indirect stores to nested structures
 	 * defined above. We need three registers to make such a store, but
 	 * only two (src and dst) are available at convert_ctx_access time
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index af8b070e71ba..d045bc0ecc70 100644
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
+		ctx.uaddr = (struct sockaddr_unspec *)&storage;
 		ctx.uaddrlen = 0;
 	} else {
 		ctx.uaddrlen = *uaddrlen;
-- 
2.34.1


