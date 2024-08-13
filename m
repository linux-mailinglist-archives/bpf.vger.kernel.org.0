Return-Path: <bpf+bounces-37001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9C94FCC1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2461F234BE
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1513B787;
	Tue, 13 Aug 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLNzorZQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0913B285;
	Tue, 13 Aug 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523420; cv=none; b=EMXrtkZv6pkM3dcbWLgtrHmCR2YvE9h+NOm5oExd4Q9rGTKCpzhg2jdsDmrqvbk+Kh+Lq+XxxOhje1/jGWbvkMoCdC1VkM2/e74OCBMWZA3WOueVVhg2n+ILIhEjrwmW6VdtyTri5zGiKgCtTq2971v2rqBScgKF0+PMsWng3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523420; c=relaxed/simple;
	bh=nyRerODhqExBNZEMJor5oVWA71mTXcVPCXwFpQK87yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLsnJltfjA/EwpkPkN8f1yaqXLkEbAFlqNDCD8FzZf8hXptldbCq8Y75f5uWOmt+c8JDy3s2tyaxsEyvYrwkxpIn+Txd48e210JekRLXsToAyXAxYt6zEJDS8C0FVCBQ8S/ald+2RKhTyNmcpGcZ844vUySfXL2mW4IYZC48SXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLNzorZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948B7C4AF0E;
	Tue, 13 Aug 2024 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523419;
	bh=nyRerODhqExBNZEMJor5oVWA71mTXcVPCXwFpQK87yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLNzorZQYwSeMaJO6ZfyOpi4voFgsxSZV0d5e7Qzj9EhA2qXZsvMRIgP+QZ/Gbskg
	 ZBYVI1/3pxnqaxOfifIwgjRD5pPearLl6dOuYiGPxlC+9PlkxIphaHQocP/Mnfwhpw
	 tvmC4tmqfNkwkFV14pqqAgBQiGt01yos3TpcaulRwZSoDwEUfEaQ/cSiBz5/qy+5fK
	 jZo+8Q20NaEfVavXBJXBxFISIiOLjKvxVhOvy5axbn1VwexZJRmQCCwY7Q+1uueSCG
	 K1U03rS2xYpmx0Ru+K8EnjzMNEnQMxpbsPnSM2W7a4OcCt27SFGei8XqAfYRzgMDJT
	 Wuariw/Hk3ntQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC v3 12/13] mm: add SLAB_TYPESAFE_BY_RCU to files_cache
Date: Mon, 12 Aug 2024 21:29:16 -0700
Message-ID: <20240813042917.506057-13-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RCU protection for file struct's backing memory by adding
SLAB_TYPESAFE_BY_RCU flag to files_cachep. This will allow to locklessly
access struct file's fields under RCU lock protection without having to
take much more expensive and contended locks.

This is going to be used for lockless uprobe look up in the next patch.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 76ebafb956a6..91ecc32a491c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3157,8 +3157,8 @@ void __init proc_caches_init(void)
 			NULL);
 	files_cachep = kmem_cache_create("files_cache",
 			sizeof(struct files_struct), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-			NULL);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT, NULL);
 	fs_cachep = kmem_cache_create("fs_cache",
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-- 
2.43.5


