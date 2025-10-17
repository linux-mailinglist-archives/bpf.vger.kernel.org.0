Return-Path: <bpf+bounces-71205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA7BE92A5
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70D950793B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E936CDF6;
	Fri, 17 Oct 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEqUUSYL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DC32D0FA
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710662; cv=none; b=hzBFH++j490AK/xYl3VVw/SpSIdnloV3rAIF7JQsPEZiPcezBtDz8w+0TJYelbQyJbXKVSxwC94hQdZJQkK3xAUWtQrLcvmUgLpPgKZz8cLftTviXCdRLmWIl8LWcjEXIOz1AAGO/5uPBQbe69WaCqQLmoIoq6oHUFYI2LsUVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710662; c=relaxed/simple;
	bh=HEl3IasLlyLddu9j1xPd8KfFtcwBY0vySDmstbcR3Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pfx7LhPYIT2mpoLsNc2WJQsikF+5qKPqH9mOK34Arr2k5POJQs37xWDiHenJbwG4prSmNjTUrxuME1ufLk7xt34Jl2aVdf/nMV6JwFxKiOODG3NkHv6xis+EmzWalB3SgvRGqNz6TxOUm0HvlJaWVPZ3vPPupCGHj6E+sDwBDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEqUUSYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2A1C4CEE7;
	Fri, 17 Oct 2025 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760710661;
	bh=HEl3IasLlyLddu9j1xPd8KfFtcwBY0vySDmstbcR3Vk=;
	h=From:To:Cc:Subject:Date:From;
	b=SEqUUSYLgBcKJcICVxvpBQOtw2nL4YG6NbRqH+H63+OKsAc3ov1m+W6xa4XNhtJOY
	 JiLhkGxekhPqOzTsHWbPLZJlovH2r5iQVRmbacentMrcYqKllppr3CEzbZ/+5rstqH
	 039+HBeJpjhnK7SQrmBenVNYMwqR7gepojfFbntKWRlaGiJeOIpz2LwKOEd0nq9IYy
	 I+8wVcm7H78pcQt7jF0izgR+3uKgLszbG3bJVmRaivrnoN+JcRt6cu3CtifKk3H7pr
	 795s3jQX5Idmy2FxrDvJQyHqIm8gndC+IrLUtA/PDmRzS2jbF3YsVLfSR25ipLzJYJ
	 4fRYaHNJavrtA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
Date: Fri, 17 Oct 2025 14:17:25 +0000
Message-ID: <20251017141727.51355-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __list_del fuction doesn't set the previous node's next pointer to
the next node of the node to be deleted. It just updates the local variable
and not the actual pointer in the previous node.

The test was passing up till now because the bpf code is doing bpf_free()
after list_del and therfore reading head->first from the userspace will
read all zeroes. But after arena_list_del() is finished, head->first should
point to NULL;

If you remove the bpf_free() call in arena_list_del(), the test will start
crashing because now the userpsace will read 0x100 (LIST_POISON1) in
head->first and segfault.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_list.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
index 85dbc3ea4da5..e16fa7d95fcf 100644
--- a/tools/testing/selftests/bpf/bpf_arena_list.h
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -64,14 +64,12 @@ static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
 
 static inline void __list_del(arena_list_node_t *n)
 {
-	arena_list_node_t *next = n->next, *tmp;
+	arena_list_node_t *next = n->next;
 	arena_list_node_t * __arena *pprev = n->pprev;
 
 	cast_user(next);
 	cast_kern(pprev);
-	tmp = *pprev;
-	cast_kern(tmp);
-	WRITE_ONCE(tmp, next);
+	WRITE_ONCE(*pprev, next);
 	if (next) {
 		cast_user(pprev);
 		cast_kern(next);
-- 
2.47.3


