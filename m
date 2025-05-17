Return-Path: <bpf+bounces-58438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD82ABA75D
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 02:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1780A05D6C
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5879F2;
	Sat, 17 May 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWraBjdz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3F136A
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747442092; cv=none; b=a9gd8iMh+H4l3HgSHS5unp2Y981h/k0qujQttQEHXKGghdiKxcBPmuKud8typolizTm/evpg9Xo0QGboZ2cG6CfvUoSerHorSmhbDN13pm1GVvbPZnbInuHhIJbiD0GmDqthXjYSpMqz6KkSg4o8AJkBsRx+kmdaer1JQtGQpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747442092; c=relaxed/simple;
	bh=XfrPeXFDR1DwejRaSCXn6btP6sV6LlgAt7B9XNEnphA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j25zRGPVUfM76iwA8x4ncffYwhRITzc4Vl3jSLtxNx2xBJ7XBw4SsAEd9PU8cwyRi4lgAodNNK2FPSpVNOoOziZGxyHLkavxViVaCC1Ybiq9/rsdx7dxZNtmyIXFfGJ/xxG22Eb/KvFFsJ2RyjMfO8wqfS1MT4TrP1QojRjA6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWraBjdz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30e93626065so735289a91.1
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747442089; x=1748046889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEuL141r+KLQPrI49mzWLWU+dMs/PLbr0ek531UWhMw=;
        b=MWraBjdzeQZYZdNkGr6KbFD75r00MLiPqfZxFUuO761uYv2F4x5M7t/u+v29ki2qdQ
         tPgVCe3nfNHzRAkGAvwnRf3eY7wQshRlriu5uzq6hikcsO1UsJXzkFrYwBf3iKzVvMR3
         lB7wLMYQJ2B+k7xqB6MnsG5wJf2iJmoBbkqTnnhenOQ9vK0MYfpP3vJqRY64c+k3T+Sg
         g8ItsKf/Vn+CInYIahyvfhMUU1Wa+8yZEARFGlDwVawER1Pvn9ysN0jUrLf4UnWTcVTd
         0fWJvUizSwWQu/ThCXrqfgEM+EZSMsdEBcllrXnqiTR9pylpiqjAWoTSM1JztTptUmpJ
         tp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747442089; x=1748046889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEuL141r+KLQPrI49mzWLWU+dMs/PLbr0ek531UWhMw=;
        b=tMuj7NjzrW0YZ6yxLaObSvEwRjBZziayKogvMCC/WYaTW1N/1ouXfcG8yfMrcs7oMK
         SpyUFDIX/bsmnaIa/10xTftkFf2VBcNg8pvORkYp5vgUwGnzouWYlAJxoXmkwI0vFVtI
         0kOVlwL5EyUV4Jzm28vh7P1J6UeLqUl6ASlUR/8WkaXLReQhFZrfArf6CAGtvt87v2KZ
         DuCWmAtRXBmFXZOKBXaYRhNW8cSW8qINFD6TkS3owwq58eML/yM6/0VTpiDxglgrJdc6
         3B20mIaBx3E82coaGqZdmXzVvn4NxutbMzsGYL5zIOEeExLsLZn8a0iX8TAsh3CpokKY
         7jtQ==
X-Gm-Message-State: AOJu0YyhiDjTHiensOjP1O8NkM03yDRWWin8q4QT2Xle4qdryQXqD1HH
	RAfPMD/06+POMEE11lGYbXw8bU8i+LUZNnqpB+wqbluw313yPsGBYw3VcDw4LQ==
X-Gm-Gg: ASbGncsBPpM2+KoN3gqDaNRo/m4dJ6vaxc7ToJu5GGjJLlsVPc/wJnHRYhWS4MXGWOk
	Xe2Su4F/5uIhfmHXqc6jxvh1PntVq0qjqaaejZW70ZsO+5cAdMGB1aaUFd/PkJIknOtuNbIMh9W
	zfbG0uKNZmQzfmCc3hYAFVvwC0HqyVtFuCjsixAlrYYCth6cGiIk3nH5GnY0CzA38Uk0Nj13P7D
	NXIBSKGEfiZhJm8sQoyDDAqaW9cUBXKtUwM6V2Cj3yzdurpbcmGc6TLG4HEYhbqr9jGNLgqgpF6
	N9Bq9l+llQgRi///AyKgVlstgS74bv/9Bx5xs+P7BfSM7HXO8/sviR0QOaiuJwPX6New7ahiiLJ
	uZhNf9jARyp4z+dC1
X-Google-Smtp-Source: AGHT+IHtU3IgZJBR4QvukTm0FLmBdfCVI2UYgxNxuo+Ke3jUz+0qknmYzYr/C+ajvbPGdARHrx1Gbg==
X-Received: by 2002:a17:90b:1f90:b0:30c:52c5:3dc5 with SMTP id 98e67ed59e1d1-30e83216dc2mr5517347a91.26.1747442089215;
        Fri, 16 May 2025 17:34:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e83378582sm1943688a91.3.2025.05.16.17.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 May 2025 17:34:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH] mm: Rename try_alloc_pages() to alloc_pages_nolock()
Date: Fri, 16 May 2025 17:34:46 -0700
Message-Id: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The "try_" prefix is confusing, since it made people believe
that try_alloc_pages() is analogous to spin_trylock() and
NULL return means EAGAIN. This is not the case. If it returns
NULL there is no reason to call it again. It will most likely
return NULL again. Hence rename it to alloc_pages_nolock()
to make it symmetrical to free_pages_nolock() and document that
NULL means ENOMEM.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h  |  8 ++++----
 kernel/bpf/syscall.c |  2 +-
 mm/page_alloc.c      | 15 ++++++++-------
 mm/page_owner.c      |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c9fa6309c903..be160e8d8bcb 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -45,13 +45,13 @@ static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
 	 * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
 	 * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
 	 * All GFP_* flags including GFP_NOWAIT use one or both flags.
-	 * try_alloc_pages() is the only API that doesn't specify either flag.
+	 * alloc_pages_nolock() is the only API that doesn't specify either flag.
 	 *
 	 * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
 	 * those are guaranteed to never block on a sleeping lock.
 	 * Here we are enforcing that the allocation doesn't ever spin
 	 * on any locks (i.e. only trylocks). There is no high level
-	 * GFP_$FOO flag for this use in try_alloc_pages() as the
+	 * GFP_$FOO flag for this use in alloc_pages_nolock() as the
 	 * regular page allocator doesn't fully support this
 	 * allocation mode.
 	 */
@@ -354,8 +354,8 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
-struct page *try_alloc_pages_noprof(int nid, unsigned int order);
-#define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
+struct page *alloc_pages_nolock_noprof(int nid, unsigned int order);
+#define alloc_pages_nolock(...)			alloc_hooks(alloc_pages_nolock_noprof(__VA_ARGS__))
 
 extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
 #define __get_free_pages(...)			alloc_hooks(get_free_pages_noprof(__VA_ARGS__))
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64c3393e8270..9cdb4f22640f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -578,7 +578,7 @@ static bool can_alloc_pages(void)
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
-		return try_alloc_pages(nid, 0);
+		return alloc_pages_nolock(nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c77592b22256..b89c64a4245b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5078,7 +5078,7 @@ EXPORT_SYMBOL(__free_pages);
 
 /*
  * Can be called while holding raw_spin_lock or from IRQ and NMI for any
- * page type (not only those that came from try_alloc_pages)
+ * page type (not only those that came from alloc_pages_nolock)
  */
 void free_pages_nolock(struct page *page, unsigned int order)
 {
@@ -7335,20 +7335,21 @@ static bool __free_unaccepted(struct page *page)
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
 /**
- * try_alloc_pages - opportunistic reentrant allocation from any context
+ * alloc_pages_nolock - opportunistic reentrant allocation from any context
  * @nid: node to allocate from
  * @order: allocation order size
  *
  * Allocates pages of a given order from the given node. This is safe to
  * call from any context (from atomic, NMI, and also reentrant
- * allocator -> tracepoint -> try_alloc_pages_noprof).
+ * allocator -> tracepoint -> alloc_pages_nolock_noprof).
  * Allocation is best effort and to be expected to fail easily so nobody should
  * rely on the success. Failures are not reported via warn_alloc().
  * See always fail conditions below.
  *
- * Return: allocated page or NULL on failure.
+ * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
+ * It means ENOMEM. There is no reason to call it again and expect !NULL.
  */
-struct page *try_alloc_pages_noprof(int nid, unsigned int order)
+struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 {
 	/*
 	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
@@ -7357,7 +7358,7 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 *
 	 * These two are the conditions for gfpflags_allow_spinning() being true.
 	 *
-	 * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
+	 * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a reason
 	 * to warn. Also warn would trigger printk() which is unsafe from
 	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
 	 * since the running context is unknown.
@@ -7367,7 +7368,7 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * BPF use cases.
 	 *
 	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
-	 * specify it here to highlight that try_alloc_pages()
+	 * specify it here to highlight that alloc_pages_nolock()
 	 * doesn't want to deplete reserves.
 	 */
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
diff --git a/mm/page_owner.c b/mm/page_owner.c
index cc4a6916eec6..9928c9ac8c31 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -302,7 +302,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	/*
 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
 	 * to prevent issues in stack_depot_save().
-	 * This is similar to try_alloc_pages() gfp flags, but only used
+	 * This is similar to alloc_pages_nolock() gfp flags, but only used
 	 * to signal stack_depot to avoid spin_locks.
 	 */
 	handle = save_stack(__GFP_NOWARN);
-- 
2.47.1


