Return-Path: <bpf+bounces-58369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B76AB91E3
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2657F1BC1147
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F528BABC;
	Thu, 15 May 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlYj4bdU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC2289823;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345340; cv=none; b=AW4YkLKKo0ElbRbPV2de0meZDNPdd6Ob6klDhC7urel2zw/C/nBgk6P+NlhqyATXt7FGdbY47bFtwHnxYSpxTN3RNt4sIiINzNAMT2K966AzbxrsRYCmIchtM8KkB7diSXbTG/HxSOMMHJtSj+IINxe29HDaG+s25UGujGLDQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345340; c=relaxed/simple;
	bh=y5iTm0qa00qIrnZejVeX3Ab8YTjp2BAj50nhyhXZ9E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nrhg/jocBVG1Uo5fjL/tiEUoejmtWSOObc71Z2xmhspwK7aEU1YI/F5ESjQwJM728mPVxGl0qi5yzQT7ofFqNGE2XHTlIjreuOwAs8dwTYDEDr8DWTwe+cUjysp47AFdKaOQHlAfS8c2h6OkirAIXacYi8n77QLFHUxRVk0Gn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlYj4bdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D882C4CEE7;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747345340;
	bh=y5iTm0qa00qIrnZejVeX3Ab8YTjp2BAj50nhyhXZ9E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlYj4bdUgtKWdopH5Pm0KQqKQLoi5ebsh9SGDJPFtGS/tq0yzDFb/xQRJ6XDphmK2
	 AbTtexUtTLD0iK1DTbQ9RISyVa2NU9xYPZI8c28vBG/aAYjxOWJML3zIHT8TxriRGf
	 1zqyN/7ef1sPBXRes3tezLn0+rvGzaWWm2zaIeavxcitwcufirPgsCLMKPAJQVh85U
	 tXMspr70v5LARinfIxDEK4GPz9uLenK3ElOcAaYSGaibfeTBJ2dlLRKKuCBGp1hZVC
	 eAbYZUt/JqjLCxexwFPYdZztazWyfYVUz1qDbv8PZKFbirA0NYfx/Y09rpz+cTo6q6
	 t17EaUkC9zyVQ==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] mm: vmalloc: Only zero-init on vrealloc shrink
Date: Thu, 15 May 2025 14:42:16 -0700
Message-Id: <20250515214217.619685-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515214020.work.519-kees@kernel.org>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=kees@kernel.org; h=from:subject; bh=y5iTm0qa00qIrnZejVeX3Ab8YTjp2BAj50nhyhXZ9E4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlq8TuaP1/5N3W32tZO4QqDVerPORc8t9S/psUZEv6ox JvlxmXmjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl8Pc3whzvzwoNPi1+wqptH 77Zgl6l9MXFPvd4kjhTdy219X3+zGjEy7GmpLt4vcJMrV+tMwK3ur+vnbeL8bHNpo8vuL1qfy78 bswEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The common case is to grow reallocations, and since init_on_alloc will
have already zeroed the whole allocation, we only need to zero when
shrinking the allocation.

Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing")
Tested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: <linux-mm@kvack.org>
---
 mm/vmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74bd00fd734d..00cf1b575c89 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4093,8 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	 * would be a good heuristic for when to shrink the vm_area?
 	 */
 	if (size <= old_size) {
-		/* Zero out "freed" memory. */
-		if (want_init_on_free())
+		/* Zero out "freed" memory, potentially for future realloc. */
+		if (want_init_on_free() || want_init_on_alloc(flags))
 			memset((void *)p + size, 0, old_size - size);
 		vm->requested_size = size;
 		kasan_poison_vmalloc(p + size, old_size - size);
@@ -4107,9 +4107,11 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	if (size <= alloced_size) {
 		kasan_unpoison_vmalloc(p + old_size, size - old_size,
 				       KASAN_VMALLOC_PROT_NORMAL);
-		/* Zero out "alloced" memory. */
-		if (want_init_on_alloc(flags))
-			memset((void *)p + old_size, 0, size - old_size);
+		/*
+		 * No need to zero memory here, as unused memory will have
+		 * already been zeroed at initial allocation time or during
+		 * realloc shrink time.
+		 */
 		vm->requested_size = size;
 		return (void *)p;
 	}
-- 
2.34.1


