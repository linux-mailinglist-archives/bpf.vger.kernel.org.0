Return-Path: <bpf+bounces-77605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C85CEC557
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD6A23007694
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDC29A9FE;
	Wed, 31 Dec 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU9WBzh7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A294239E7E
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201111; cv=none; b=dEX7JJy+2/sfGXuhA1UOu4bTagVfbw6dlKVf6QptBjU6zW1DAmHrUDB2M3cRITUUUsdXV3be6FLXeW4AthIAQDn9xs982q1CZQ/Uf3G7KUTgzZAMmSfVRVI6bYu0Ns5vB9lO+JY+6kxQWjjM5DX8BKzYzmf+QUefrnoBTyEvGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201111; c=relaxed/simple;
	bh=xjKfBwpKP0yxYLVzPoIDxIjJwmie2MTcGH6JdyLsjoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlV0EvJ9KGibtUgULm3gynXxLxc2TnxPMJWr/Py8SCFRzh/A1DYQs6cQbRgkubQPXk3a+ZPjMSw6u94fvEaUCZGK0BnE2XzyWzYbSJoO/2CcgNAuS9sKmL/JrQwq9k+mkMdSuIuvyHJXQSTwaa0eOPPeGyDg4gMWmwpCbtYiB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU9WBzh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90707C113D0;
	Wed, 31 Dec 2025 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201110;
	bh=xjKfBwpKP0yxYLVzPoIDxIjJwmie2MTcGH6JdyLsjoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oU9WBzh7Y9tO5n3a0Mw7E+CYhyFQWlIJ+bY4H8t3ROFHQJLY/bOJqXZBmu1WP3t4M
	 ZDFkwkRsB7hBkfCKZ4mH19YLgQ4DtjOyAsz9k4/6Weghq/8pzNFKTAFTvVYVZJH9CE
	 jAyn4f64GkAf8OqSOAugP0DffvOj0d0TIzz+bQkiFHuH4pQKGrzc2XMuBPkIKUMHNL
	 RXSZNkSc8mgWfAZBd72UN6yULyTNqyaCVBubQB9orP7hp3yPE4ZAv40idDQ7mBVjtI
	 Q7Q/LYe1FSc57yuCmNSw6+9ZIodGwPLIDuLcubv2tz3fUX+H/IyPK6samSChAvhzeQ
	 a42Vg6VXcpLhA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/9] selftests: bpf: Update failure message for rbtree_fail
Date: Wed, 31 Dec 2025 09:08:51 -0800
Message-ID: <20251231171118.1174007-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rbtree_api_use_unchecked_remove_retval() selftest passes a pointer
received from bpf_rbtree_remove() to bpf_rbtree_add() without checking
for NULL, this was earlier caught by __check_ptr_off_reg() in the
verifier. Now the verifier assumes every kfunc only takes trusted pointer
arguments, so it catches this NULL pointer earlier in the path and
provides a more accurate failure message.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 4acb6af2dfe3..70b7baf9304b 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=16 disallowed")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
 long rbtree_api_use_unchecked_remove_retval(void *ctx)
 {
 	struct bpf_rb_node *res;
-- 
2.47.3


