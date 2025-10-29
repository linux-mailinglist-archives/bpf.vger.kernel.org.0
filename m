Return-Path: <bpf+bounces-72910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E36C1D7CF
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D2F3B58F0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C032A3D8;
	Wed, 29 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpCXtveQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179631B831;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774269; cv=none; b=A+G7BFMjT+aZU0Wmscgi92pM/uxxzCq2Vnc2xTsvbkwRaHnQK+GliV2htQNcOClgjr/bEfLw6fWWraE3z3oJIbNTSIdDGOrg5kvZJkFygzbF9tuGkILnraATkkMH/Ro+7KbSBQxdr+4DWboQZXtMy9+AwNvds6X1WgZuwnUgBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774269; c=relaxed/simple;
	bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4bFrn8w0OEVwSbBPGyfpVkGXrXndyO+Bbc0DHMpgqsHyKwCUDx+S0GDR1TGQLhQmoUcYC0Hat+0bamUzp3rxxh2Vl3RGWNXXdC4jFZj0HRvtcxIbEPt2mgmx+MNIjrIu1Ddzwo4IYmSuhbcBI33SXJ+VC+K8hnmpRCS6NUrDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpCXtveQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52CDC2BCB2;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpCXtveQL+0JaIHO3x2TdsW52wo2SsHJHJmCzRDD+K72a+eGZAj5OlH4vKaR31WFn
	 PoelS+NzHZoWR9fOGbOhf2eA1piBfzycHqTej1bQ+4fJcpTEiVPukehWsmE8Px9Uj0
	 dSVqGn0Xg8nzEVzj2qR5Vz2jcP7JM1mQCEzGLf3LAvDF7aQOkSfw7A/bLT8T+anpvi
	 WJlGqjjy8Ly7WHHeUG2I9kLoMEZpYYubrbFbCglynyX1WLajhci8SAa59aIbLwXgVe
	 EtGMDlk1gKAJB8VTUlPTMQzfxPFV9nE8DrpxRbIC6ZkNBClE+TqFrKMKkyZ1OuYNTy
	 SwHf5P6LhXEzg==
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
Subject: [net-next PATCH v4 6/7] bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unsized
Date: Wed, 29 Oct 2025 14:44:03 -0700
Message-Id: <20251029214428.2467496-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=kees@kernel.org; h=from:subject; bh=XWxk10N7Q4PMiZ1TaFVOoekMBwEmzzI71fU4+ab+vdE=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXYt3agqrBG18VnbByfXw/DB52Zrw/1uUnO9GrZf6x POeie18RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwER2yjH899dePu/cubfa/9b6 Xt32vaPrrei7mQsPrXj+JV5b85PnG05GhmmfbveGPPNZ5uMyP7ls9rxPBefmzvZYcnXOvIiZxq3 T1FgA
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


