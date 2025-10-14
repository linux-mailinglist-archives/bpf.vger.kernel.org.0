Return-Path: <bpf+bounces-70938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD4BDBAE4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 382BE35405F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292330F920;
	Tue, 14 Oct 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJEQUTDn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6230DEA2;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=CIg8qMBcPjc69xJ0esASDH+CkVKd0n3OYyCZY9RbHps+C3MqWtOXmKI4NKacwVXrFAtj+apNSXs0Cpl34/xYu9RWcriygS4HlvnGJ1NHZd+P4PN/IgiCBuunbHBlMiWno0GyavEYyV73TLVhoZEpYbMkOUXhJE1vU0gj4O3jCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVD6Ge7Y98EAYuL3Q1JWW2knsRJlmHBK7ELiXwbMDWdB9hWEOT5mELaZfHExZiwloAmPmnEZh7gVr+Ji6h1cY/9AJbkck/nh8XUMgij/UB2QE3jyYyTuS23vOsapLY4EVV+QPQq6k27kMuxsCJQha0/43mWVUS4kVI6QtDBF1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJEQUTDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB80FC2BCB3;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJEQUTDnZgxowq1s+De29UJzHVHU5GlppftqT+nx/nqwu0b1LokBII++3Yp0/TO/S
	 S9uMNH6jvvJQ8JO2jtxFe+npmvj3/JPRhrokAde4HimgHhDCDAIkAs3pr2wTGyEJ+m
	 WG9s1vRCZzGN+EdVlOqTplR04tK/m7BpysnUodE1QPsW7670/a3sBvqDon8sfeSW1y
	 AKApaS2zC2iQZVuOkvnWagh+wE9spV/Unua+h9J95rA0JfCdX3SKfcPB4ijPaLzFvF
	 XkVrNRcjKkfhAoNPETB2Y8jdwTlLjF/yIla8g/EkTXjqL5hvrkvLVgVvLuUvY3/Pvd
	 3u8RWwq1lmVBA==
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
Subject: [PATCH v2 08/10] bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unspec
Date: Tue, 14 Oct 2025 15:43:30 -0700
Message-Id: <20251014224334.2344521-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=kees@kernel.org; h=from:subject; bh=qvxb3tuA7mFuJoalcsIpG14To0zLxp4Z4edePlcyGXQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgm//9rqufO3Tt3/YlYO1q9NvwSuHxF+0+GbKXzC7 Pm8/isVHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPRVWX4KzF/7cS8jcucLsdf m56es9vq3LXNIm1qV+KzL9dmySycoMnIsCZx4UsO2aIvNscSApVmdYjfrTDueNt8ReXZhv3tKlr HOQE=
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


