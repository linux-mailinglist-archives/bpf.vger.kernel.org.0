Return-Path: <bpf+bounces-57107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AACAA59F3
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511161C02EC4
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233B22F776;
	Thu,  1 May 2025 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O29dHl14"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70431EA7EB
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070050; cv=none; b=GTo2psYVgBieU4p8IvGpqK003eC/z6qW8euTPSJMK7miZRtT4PojeRnIDbqpcgmGFFBwimZ4U48HFqf7REZ/YSqKSojxA8LdrKOOTMXSZTFtBDUzVgACaZzTTjciANsoaAZEN2fmktMb79UACuldUF4vVmWcZp4kzsrRyhZX3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070050; c=relaxed/simple;
	bh=zCZx6kJ4njVl8fuHkY6QSAnSbCFf7GZjXnO7z4a/wXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GE9w6W8Op2OV7pbCPLKudys+TplP5J21pI0g0NJ+StEp8eZbdakACEcIwQE7vKi18jTrHVpd9VM36Jz0JZ/bTe51jnQVl/kS1eoBvifoXvc9OhViMIVzHcNdGmD0VYc76ODt9Geo8ZqfVmdzAMztSCVd0yYhKAGxRFCOv6MUOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O29dHl14; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so525329b3a.1
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070048; x=1746674848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOc+vclhNlDF14KtEorONrdalEi9xD/0S8qMCazju30=;
        b=O29dHl14Yn347CnSrJcwtg0srlKZ1QLFjHMvdiAFAd55ucdFcfb5biyaUFEVoYP8Ep
         eloDUDCJmTv7gKi+h/VaLayHBmSG3MAkpAfqM+9JYAr+oXSun2gHPa92MUXojTJNWJJh
         5/XQuo+RXF9Waq8aeMRPdJt4+z3xdY5HB9XSuoKT3Dee6fYalTiwFs7hbS/mDlp94gog
         vcf4hOPg3b5/W/TvCWzgsl75+s1WHEzG4zqdIrQV6EE0lLcZ+AmlZOfoLwh96Z6a0UlI
         meS0soo5qjKcLWmxFx/Flbq2SZ8rsH1dM/sBG+uChJOnE6lQ5CBD1RzNrj9CyXC2uZTy
         53/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070048; x=1746674848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOc+vclhNlDF14KtEorONrdalEi9xD/0S8qMCazju30=;
        b=YR1x4tCSN5P5g0U4Z2ydzgAA6vcNGAyXY8cXhB1sZ0OMVmvnepy9Z17MndYq8oJ/hR
         lH/e5DO0ZT8lPGLTHF+KsJjbfL7p1Gk4KeDq8JXCZJ+IAasjLu5P8DOdo7aKM7e5lvEm
         UceXYnRNXBjrAS0ZXtXL7MSOeiIeBK47sWtvnI//ujIzz934mTcl0mrtFXAeR/qQ4dY5
         ER6bj+9I606AOrd7bXgSqzQ7fLc0ygfgR8MSG9bzKTz9BJgq9IAHdqvXe8b0nlHFcVYi
         s7kcGijlkIWcuxQfk0YwzstlPaRvaz4ToYmnyp7gv+RsZizV2Ak6pmvY3vPDkxmRnK5s
         P/Iw==
X-Gm-Message-State: AOJu0Yx4FVHUrzbbozB0vTxkRoS9O0MRvvwfSDHxw6tKKsO5F1Zj4JVi
	30cFV7yI22bYYBu+sYuHJbfKpiVXYvvnYIJ4W2ZEM8HGEvXTxDBH77NA/g==
X-Gm-Gg: ASbGncs9VqkKVUX7DHYunphaHqU493zxxbWTJF9ua05s+6+J+LusnZ8TcTOkzKcX6NQ
	gmBwuz22u1w91Fh0aw5SPBe2K3R3pmmYTbYX90aXqiEu3EKTEIPenG19mrLe5OrlAj3dfDO6Mqh
	/88YpMKbQzQYU95PNfgS0Izu1ruiMQxDbKNfqTJGTT1X9J1NqpEJdvfzmBpJoLv4yJPhiDiSab7
	JLl7xEQ+8eSVG8taP4FMGQ6mS7PPhxWn0B+XMDDhOIfr7/PCswTNAi2NLLf/PtP2Huh2oUYmDCX
	BafO7zKUYTwSoVBYfk1aXoFebvzjbcdPi6gvEbc+D7G3sGB3RpLleXy/vsVRTJtliP7w
X-Google-Smtp-Source: AGHT+IHTN3qo3saS1RZLLWY8zAzkDgRqyHWDIOEMK2S5FQrvSwlqp3t6w9Sxc1Ff4Sn1sHInskAjSQ==
X-Received: by 2002:a05:6a00:148f:b0:736:55ec:ea8b with SMTP id d2e1a72fcca58-740492706eamr1617433b3a.24.1746070047689;
        Wed, 30 Apr 2025 20:27:27 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm2584797b3a.91.2025.04.30.20.27.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:27 -0700 (PDT)
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
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 1/6] mm: Rename try_alloc_pages() to alloc_pages_nolock()
Date: Wed, 30 Apr 2025 20:27:13 -0700
Message-Id: <20250501032718.65476-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
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
index 9794446bc8c6..d0ddba2a952b 100644
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
index e9322052df53..1d77a07b0659 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5080,7 +5080,7 @@ EXPORT_SYMBOL(__free_pages);
 
 /*
  * Can be called while holding raw_spin_lock or from IRQ and NMI for any
- * page type (not only those that came from try_alloc_pages)
+ * page type (not only those that came from alloc_pages_nolock)
  */
 void free_pages_nolock(struct page *page, unsigned int order)
 {
@@ -7378,20 +7378,21 @@ static bool __free_unaccepted(struct page *page)
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
@@ -7400,7 +7401,7 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 *
 	 * These two are the conditions for gfpflags_allow_spinning() being true.
 	 *
-	 * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
+	 * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a reason
 	 * to warn. Also warn would trigger printk() which is unsafe from
 	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
 	 * since the running context is unknown.
@@ -7410,7 +7411,7 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
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


