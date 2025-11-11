Return-Path: <bpf+bounces-74238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E53C4F122
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D75A14F8E82
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A03730C4;
	Tue, 11 Nov 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CodlonYC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606653730CE
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878903; cv=none; b=WsrHRjXYYji8WYFBChonDFkFR5Iiy58AiMPASdBqOS+Qiw4U0c9xogVNM48sISSUTbuv5BveuAWnWN8jck9eJlYqNBzZGhOc9f2WBxEQvlH5zIKF2J+L5TLXr9dVhAMDwQngeTzHjLLYmfljbRNPdVKTR4Y/yo+HnsqcSZSi/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878903; c=relaxed/simple;
	bh=WWZkUk+V80uQv6WBauGKwRkVB4e3gjVwdb71GKXSCBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi7Cl4i7oDJJfgOZpjLnR59zKmVuAKofh4k3nf/P/68nPba1sE492GeR3t+hc273xjO8FGjJV+/WQ7spLuCC1cHk1ZX7+Sed9vbmyplR5cKdXNRC0xDNmdvrXXAFVADPGCJs0wdSHWFbmF7XweQcJ6s0MrGKjh/EOFKOHz5oqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CodlonYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75563C4AF0B;
	Tue, 11 Nov 2025 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878902;
	bh=WWZkUk+V80uQv6WBauGKwRkVB4e3gjVwdb71GKXSCBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CodlonYCiE+jZV4HURO10X4mr+i04bNzSzAy2QWaJ1Ov7cMfhOly1dtH3v4lEHRS8
	 lafxFErFYornI6bQcSu8p41tPKiGmYKbO/8HmL0KZj3z5f+iqKbQ1RRsnwWSu9OPDU
	 S9/vNpjsOQiMSmry0pdwDgWwsnyA1b7KJ7Xr6aAJWUzCwZfpTyufZIwvo2eDIagX44
	 Zy+Vyusrn6P8lpbv8J34S5UNJ10U3sBo+macQxRzOJ+UMCIZNBvWCcNgwrtvNl7aVu
	 83xAMwpQhreR9GEWmwGdNsgx8bFqVFuNcgqcoFM+JtBAgmcdGFdHKYdmxoOoDIgVsZ
	 5zRyTWs7A0qeA==
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
Subject: [PATCH bpf-next 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Tue, 11 Nov 2025 16:34:20 +0000
Message-ID: <20251111163424.16471-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111163424.16471-1-puranjay@kernel.org>
References: <20251111163424.16471-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make arena_alloc_pages() safe to be called from any context, replace
kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
locks.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index dd5100a2f93c..9d8a8eb447fe 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -506,8 +506,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			return 0;
 	}
 
-	/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
-	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
+	pages = kmalloc_nolock(page_cnt * sizeof(struct page *), __GFP_ZERO, -1);
 	if (!pages)
 		return 0;
 
@@ -546,12 +545,12 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			__free_page(pages[i]);
 		goto out;
 	}
-	kvfree(pages);
+	kfree_nolock(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 out_free_pages:
-	kvfree(pages);
+	kfree_nolock(pages);
 	return 0;
 }
 
-- 
2.47.3


