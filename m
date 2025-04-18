Return-Path: <bpf+bounces-56263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A59A93FFD
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221C41B66F7C
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48825486B;
	Fri, 18 Apr 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OicXXmds"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDE25484E
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016443; cv=none; b=kmltvNt/WigH2ZVQEvX05gVomFYH67P/MYdIRTKUNAbtOhYS63c+YXm1ejtWsUUfKgcnxOc50DrmYuddQqPSRgapxGwhki5+lWOtROloLp0sw64JGDNtO6D8eCZeigO3V52pGpeqoFgA2zucju2ZrbuR7p1wEAMyZZ4IM+fdCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016443; c=relaxed/simple;
	bh=CuNEOL40Y2GqHx4FswXb7VriAJlwIBnumV/8NdjK9hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKWi4zwFy9LXOxbqWVQcL5kinr3/ymzv1jigat4uzLlrvzuMTaUjpOYDIiVZQHgkXqNSylXlzRdGAxty4YC22MyXIUva61gsloqP/Op/6zBGi3AYZPbaEKzhQFLvwWoxKeGYb5o6+Z857r6I/syI4pHY/bpapAd8DDaVaWgeU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OicXXmds; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5xTbmm3lU0hsicQ+mtYw0M8HKq+iogNgwvIHDGq7w8=;
	b=OicXXmdsPgI742mGCSlQ+83AyAPHl2QrfQzYqbuHJp7KKjb3HRnhw3DE4Om9agpCCl+Fpy
	2evy3DxIK4c/l1oq7kRZq+f/SmhpnOcOJNCgExrQc92h3B5nCm2LS2PPaQIJcjSZQYFrOL
	HyW6UwTw5w7CVY+EqILs8M/RUQ1jD/A=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 04/12] selftests/bpf: Adjust failure message in the rbtree_fail test
Date: Fri, 18 Apr 2025 15:46:42 -0700
Message-ID: <20250418224652.105998-5-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Some of the failure messages in the rbtree_fail test. The message
is now "bpf_rbtree_remove can only take non-owning bpf_rb_node pointer".

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/rbtree_fail.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index dbd5eee8e25e..528122320471 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -69,7 +69,7 @@ long rbtree_api_nolock_first(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
 long rbtree_api_remove_unadded_node(void *ctx)
 {
 	struct node_data *n, *m;
@@ -178,7 +178,7 @@ long rbtree_api_use_unchecked_remove_retval(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
 long rbtree_api_add_release_unlock_escape(void *ctx)
 {
 	struct node_data *n;
@@ -202,7 +202,7 @@ long rbtree_api_add_release_unlock_escape(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
 long rbtree_api_first_release_unlock_escape(void *ctx)
 {
 	struct bpf_rb_node *res;
-- 
2.47.1


