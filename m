Return-Path: <bpf+bounces-77429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DACCDD0A4
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E078A3001C0C
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203D33F8CE;
	Wed, 24 Dec 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt4gGOc2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7F33F361
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604351; cv=none; b=rYbO1RmqBOw167YRaIPJ6NZcohcNPcG9PbNvqPu9AcDPt8d5ZWghZ3M0D5sGFjYteY8olSkOBGhW0/UcTUkyI8Pdgw5slZOaX+UEo1sizk1EL+tn3fqhO+Cy/p86UTkj4EsqApMPfG4kY8djw2+jKMrytukrWFOD6L3k16CbvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604351; c=relaxed/simple;
	bh=xjKfBwpKP0yxYLVzPoIDxIjJwmie2MTcGH6JdyLsjoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9S62OQwGOQSmEHy0yZMtJt9I6nZDSVrCHQkjsFRcIDLjfrBvK5TWQDYbCdPIAM+0rr4c1YP205czFqY7U94wBv1XnQLm6OcNSFY4DENvlxRkPnin9MFKwIxec0ecIPJtNUZNtIkV+vuF+qrvVRLuveGTakEEgJMhKFRs/Lcbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt4gGOc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B0C4CEF7;
	Wed, 24 Dec 2025 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604349;
	bh=xjKfBwpKP0yxYLVzPoIDxIjJwmie2MTcGH6JdyLsjoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bt4gGOc292GjNL0S4jg6jY8Q5D9Bk8x0af2otQcMkeshXQAucLLOuF1XhqWLpmEo4
	 geUbPnYiEB8nMQcXlHusgAOQnioT3eHJE899NR/exLRjQtxBLqkuNIQdzHRj6RB8qk
	 DrTw0lC97dRYXPMOETUtmPCtu/FdhgUXiZGX8+aiOZeDeD2o2fbtt4qDT50VoASSFy
	 a6j3JqMu6WUK+KzpECv4KAggxfHxgpuzB1b8nke8A/lHsGkSrVkpTCuBU/4xeNDU/g
	 6thQTCLqYe1eOGPdQr9gWOlJDVG3qiGHaMcezKXBKcdZr8n6zs7uPFyBJcYW29tmVz
	 zflJCA/IDDkVA==
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
Subject: [PATCH bpf-next 5/7] selftests: bpf: Update failure message for rbtree_fail
Date: Wed, 24 Dec 2025 11:24:34 -0800
Message-ID: <20251224192448.3176531-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
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


