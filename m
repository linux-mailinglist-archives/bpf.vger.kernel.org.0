Return-Path: <bpf+bounces-67652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F87B466D7
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F25E588B26
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8D2D0622;
	Fri,  5 Sep 2025 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIsJ2pg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D002C2358
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112472; cv=none; b=HRmo5IjJR/79SRCGYcS6ptG7r+l4s0muSlV2QeZ2spW0G7VFioClw7OAQV9se47xd1Tjd9LNpNc536OPV2r8lHfyJNz4o53Y6FPz2kiaz5TxSy+g6HEThSUFcNjvCvI/qypnO3t3EMnSiovG6G0nfvI87VkF8NlytlKHGsb+Ig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112472; c=relaxed/simple;
	bh=cJ0dgRo05JoXAMPiKybo3s0yFyHck1EwFMAk/cpm/hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SJl1lY4aU92B8r3faIlzvIlGBPqhmqGT3nGfgvF9/jBnncTpDKE4wehyp5Mz6Wp4fG7v83eYAWdzB+vuaB8G3aTCBPX30F9uZA2C+ye0YTqKnXn0l7m2skkfo4IFMQEa2HBq+XMv19gA7jYcVdeaEVhTof0a18oyAbmIb/E6vzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIsJ2pg6; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7ff94e5c251so612023685a.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112468; x=1757717268; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMiw5U3OQ6PrUsvlxadY05QRKsIAx93lnTtZCiYI8Uo=;
        b=MIsJ2pg6JJe1nh3NJqWQSSoj6o/5yOm/zG66JaB+XXZQ4uixdNlIoab9iOINs1fUWv
         WzB7Pubc5FedN4W/sJPddDZPS7Bmlm6upmUbv3EHANgtBxaHDnvRLsjplahw7OHZTja5
         7gUkIh/nkxjlD4ZLI8yUykqmVcovt6nQDDT88Sm8I/g5g+EDauN8erHBnWRhLM03183R
         Il8eZ9k2uDiVF5kyazovdpdyjX6mCIP6SrY3qx72qeQXXxS1mP7qVGpXAU18MeX/r13H
         wc/ySui1gs0EFcsK+W08dxNAC/A0Lq4DN9dMjqmMSbgvgzyjNjRWd0OEeR7WQcO4oTNn
         BmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112468; x=1757717268;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMiw5U3OQ6PrUsvlxadY05QRKsIAx93lnTtZCiYI8Uo=;
        b=HIXYvMiMlUsu3L68K8gE5dmMGbtMRVVmiEAAPVcMplPBl0ANRmvjxKMECuncul5uV2
         q+guOr9N5CufIf96/EslkYOojCbTSJjMrxLPvBzJCACnE+JlXRMzKvi67slFbMJK9HwI
         T97KqDUE0OV9DxoaG0hNcghP40MvYihKvEKawBicwtS1euUnT8DQ7W89Pp6tfEqHAQ4O
         Zo9gEMgPGYiU7EWCDZQeGWnpmMHyNKZob5An4Huap5PZ71Kb4wQU+jTXaF7rN/6RrnKg
         Kbp5JgoV7RxTE1rsudl7rLoJHzzzj231a1X9cZLXeedFWPW3njoPvzo6/UlcwdDI//Eh
         StIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0YL3VzZ0t0biIdo8Rcgkd5zyAJrmP/q0RjQwlx3zozb0XuK8UD5JtmPvUqcuIqu6bPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUexTml5Yf5LEERXMrhHKAb7/e6w+mrTO1OltEhk1pPWieugk
	d/fShlkM3mF/4tKfmw8TTiWb+hh4ZQy87FwI2vWCqIOg1C8FGJgmQ1nSvlSVhPK3TkMuVIIoKRa
	1ciBoh6lITw==
X-Google-Smtp-Source: AGHT+IEoOH+/XcQY7s9j1P3mdt6GzT/7Yog4LSGgOnKM9MWFnRb3X3yfDUzMib9Oyi8KbevVLqYWVtmHA9qo
X-Received: from qknqj10.prod.google.com ([2002:a05:620a:880a:b0:80e:1b0d:226b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:460c:b0:810:7a53:c62b
 with SMTP id af79cd13be357-813c39a21aemr33468185a.34.1757112468002; Fri, 05
 Sep 2025 15:47:48 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:47:07 -0700
In-Reply-To: <20250905224708.2469021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905224708.2469021-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905224708.2469021-4-irogers@google.com>
Subject: [PATCH v1 3/4] tools include: Replace tools linux/gfp_types.h with
 kernel version
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yuyang Huang <yuyanghuang@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Petr Machata <petrm@nvidia.com>, 
	Maurice Lambert <mauricelambert434@gmail.com>, Jonas Gottlieb <jonas.gottlieb@stackit.cloud>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously the header gfp_types.h in tools points to the gfp_types.h
in include/linux. This is a problem for tools like perf, since the
tools header is supposed to be independent of the kernel
headers. Therefore this patch copies the kernel header to the tools
header and adds a header check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/gfp_types.h | 393 +++++++++++++++++++++++++++++++-
 tools/perf/check-headers.sh     |   1 +
 2 files changed, 393 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
index 5f9f1ed190a0..65db9349f905 100644
--- a/tools/include/linux/gfp_types.h
+++ b/tools/include/linux/gfp_types.h
@@ -1 +1,392 @@
-#include "../../../include/linux/gfp_types.h"
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GFP_TYPES_H
+#define __LINUX_GFP_TYPES_H
+
+#include <linux/bits.h>
+
+/* The typedef is in types.h but we want the documentation here */
+#if 0
+/**
+ * typedef gfp_t - Memory allocation flags.
+ *
+ * GFP flags are commonly used throughout Linux to indicate how memory
+ * should be allocated.  The GFP acronym stands for get_free_pages(),
+ * the underlying memory allocation function.  Not every GFP flag is
+ * supported by every function which may allocate memory.  Most users
+ * will want to use a plain ``GFP_KERNEL``.
+ */
+typedef unsigned int __bitwise gfp_t;
+#endif
+
+/*
+ * In case of changes, please don't forget to update
+ * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
+ */
+
+enum {
+	___GFP_DMA_BIT,
+	___GFP_HIGHMEM_BIT,
+	___GFP_DMA32_BIT,
+	___GFP_MOVABLE_BIT,
+	___GFP_RECLAIMABLE_BIT,
+	___GFP_HIGH_BIT,
+	___GFP_IO_BIT,
+	___GFP_FS_BIT,
+	___GFP_ZERO_BIT,
+	___GFP_UNUSED_BIT,	/* 0x200u unused */
+	___GFP_DIRECT_RECLAIM_BIT,
+	___GFP_KSWAPD_RECLAIM_BIT,
+	___GFP_WRITE_BIT,
+	___GFP_NOWARN_BIT,
+	___GFP_RETRY_MAYFAIL_BIT,
+	___GFP_NOFAIL_BIT,
+	___GFP_NORETRY_BIT,
+	___GFP_MEMALLOC_BIT,
+	___GFP_COMP_BIT,
+	___GFP_NOMEMALLOC_BIT,
+	___GFP_HARDWALL_BIT,
+	___GFP_THISNODE_BIT,
+	___GFP_ACCOUNT_BIT,
+	___GFP_ZEROTAGS_BIT,
+#ifdef CONFIG_KASAN_HW_TAGS
+	___GFP_SKIP_ZERO_BIT,
+	___GFP_SKIP_KASAN_BIT,
+#endif
+#ifdef CONFIG_LOCKDEP
+	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
+#endif
+	___GFP_LAST_BIT
+};
+
+/* Plain integer GFP bitmasks. Do not use this directly. */
+#define ___GFP_DMA		BIT(___GFP_DMA_BIT)
+#define ___GFP_HIGHMEM		BIT(___GFP_HIGHMEM_BIT)
+#define ___GFP_DMA32		BIT(___GFP_DMA32_BIT)
+#define ___GFP_MOVABLE		BIT(___GFP_MOVABLE_BIT)
+#define ___GFP_RECLAIMABLE	BIT(___GFP_RECLAIMABLE_BIT)
+#define ___GFP_HIGH		BIT(___GFP_HIGH_BIT)
+#define ___GFP_IO		BIT(___GFP_IO_BIT)
+#define ___GFP_FS		BIT(___GFP_FS_BIT)
+#define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
+/* 0x200u unused */
+#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
+#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
+#define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
+#define ___GFP_NOWARN		BIT(___GFP_NOWARN_BIT)
+#define ___GFP_RETRY_MAYFAIL	BIT(___GFP_RETRY_MAYFAIL_BIT)
+#define ___GFP_NOFAIL		BIT(___GFP_NOFAIL_BIT)
+#define ___GFP_NORETRY		BIT(___GFP_NORETRY_BIT)
+#define ___GFP_MEMALLOC		BIT(___GFP_MEMALLOC_BIT)
+#define ___GFP_COMP		BIT(___GFP_COMP_BIT)
+#define ___GFP_NOMEMALLOC	BIT(___GFP_NOMEMALLOC_BIT)
+#define ___GFP_HARDWALL		BIT(___GFP_HARDWALL_BIT)
+#define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
+#define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
+#define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
+#ifdef CONFIG_KASAN_HW_TAGS
+#define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
+#define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
+#else
+#define ___GFP_SKIP_ZERO	0
+#define ___GFP_SKIP_KASAN	0
+#endif
+#ifdef CONFIG_LOCKDEP
+#define ___GFP_NOLOCKDEP	BIT(___GFP_NOLOCKDEP_BIT)
+#else
+#define ___GFP_NOLOCKDEP	0
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
+
+/*
+ * Physical address zone modifiers (see linux/mmzone.h - low four bits)
+ *
+ * Do not put any conditional on these. If necessary modify the definitions
+ * without the underscores and use them consistently. The definitions here may
+ * be used in bit comparisons.
+ */
+#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
+#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
+#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
+#define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
+
+/**
+ * DOC: Page mobility and placement hints
+ *
+ * Page mobility and placement hints
+ * ---------------------------------
+ *
+ * These flags provide hints about how mobile the page is. Pages with similar
+ * mobility are placed within the same pageblocks to minimise problems due
+ * to external fragmentation.
+ *
+ * %__GFP_MOVABLE (also a zone modifier) indicates that the page can be
+ * moved by page migration during memory compaction or can be reclaimed.
+ *
+ * %__GFP_RECLAIMABLE is used for slab allocations that specify
+ * SLAB_RECLAIM_ACCOUNT and whose pages can be freed via shrinkers.
+ *
+ * %__GFP_WRITE indicates the caller intends to dirty the page. Where possible,
+ * these pages will be spread between local zones to avoid all the dirty
+ * pages being in one zone (fair zone allocation policy).
+ *
+ * %__GFP_HARDWALL enforces the cpuset memory allocation policy.
+ *
+ * %__GFP_THISNODE forces the allocation to be satisfied from the requested
+ * node with no fallbacks or placement policy enforcements.
+ *
+ * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
+ */
+#define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
+#define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
+#define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
+#define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
+#define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
+
+/**
+ * DOC: Watermark modifiers
+ *
+ * Watermark modifiers -- controls access to emergency reserves
+ * ------------------------------------------------------------
+ *
+ * %__GFP_HIGH indicates that the caller is high-priority and that granting
+ * the request is necessary before the system can make forward progress.
+ * For example creating an IO context to clean pages and requests
+ * from atomic context.
+ *
+ * %__GFP_MEMALLOC allows access to all memory. This should only be used when
+ * the caller guarantees the allocation will allow more memory to be freed
+ * very shortly e.g. process exiting or swapping. Users either should
+ * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the
+ * consumption of the reserve based on the amount of freed memory.
+ * Usage of a pre-allocated pool (e.g. mempool) should be always considered
+ * before using this flag.
+ *
+ * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
+ * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
+ */
+#define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
+#define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
+#define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
+
+/**
+ * DOC: Reclaim modifiers
+ *
+ * Reclaim modifiers
+ * -----------------
+ * Please note that all the following flags are only applicable to sleepable
+ * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
+ *
+ * %__GFP_IO can start physical IO.
+ *
+ * %__GFP_FS can call down to the low-level FS. Clearing the flag avoids the
+ * allocator recursing into the filesystem which might already be holding
+ * locks.
+ *
+ * %__GFP_DIRECT_RECLAIM indicates that the caller may enter direct reclaim.
+ * This flag can be cleared to avoid unnecessary delays when a fallback
+ * option is available.
+ *
+ * %__GFP_KSWAPD_RECLAIM indicates that the caller wants to wake kswapd when
+ * the low watermark is reached and have it reclaim pages until the high
+ * watermark is reached. A caller may wish to clear this flag when fallback
+ * options are available and the reclaim is likely to disrupt the system. The
+ * canonical example is THP allocation where a fallback is cheap but
+ * reclaim/compaction may cause indirect stalls.
+ *
+ * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
+ *
+ * The default allocator behavior depends on the request size. We have a concept
+ * of so-called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
+ * !costly allocations are too essential to fail so they are implicitly
+ * non-failing by default (with some exceptions like OOM victims might fail so
+ * the caller still has to check for failures) while costly requests try to be
+ * not disruptive and back off even without invoking the OOM killer.
+ * The following three modifiers might be used to override some of these
+ * implicit rules. Please note that all of them must be used along with
+ * %__GFP_DIRECT_RECLAIM flag.
+ *
+ * %__GFP_NORETRY: The VM implementation will try only very lightweight
+ * memory direct reclaim to get some memory under memory pressure (thus
+ * it can sleep). It will avoid disruptive actions like OOM killer. The
+ * caller must handle the failure which is quite likely to happen under
+ * heavy memory pressure. The flag is suitable when failure can easily be
+ * handled at small cost, such as reduced throughput.
+ *
+ * %__GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
+ * procedures that have previously failed if there is some indication
+ * that progress has been made elsewhere.  It can wait for other
+ * tasks to attempt high-level approaches to freeing memory such as
+ * compaction (which removes fragmentation) and page-out.
+ * There is still a definite limit to the number of retries, but it is
+ * a larger limit than with %__GFP_NORETRY.
+ * Allocations with this flag may fail, but only when there is
+ * genuinely little unused memory. While these allocations do not
+ * directly trigger the OOM killer, their failure indicates that
+ * the system is likely to need to use the OOM killer soon.  The
+ * caller must handle failure, but can reasonably do so by failing
+ * a higher-level request, or completing it only in a much less
+ * efficient manner.
+ * If the allocation does fail, and the caller is in a position to
+ * free some non-essential memory, doing so could benefit the system
+ * as a whole.
+ *
+ * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
+ * cannot handle allocation failures. The allocation could block
+ * indefinitely but will never return with failure. Testing for
+ * failure is pointless.
+ * It _must_ be blockable and used together with __GFP_DIRECT_RECLAIM.
+ * It should _never_ be used in non-sleepable contexts.
+ * New users should be evaluated carefully (and the flag should be
+ * used only when there is no reasonable failure policy) but it is
+ * definitely preferable to use the flag rather than opencode endless
+ * loop around allocator.
+ * Allocating pages from the buddy with __GFP_NOFAIL and order > 1 is
+ * not supported. Please consider using kvmalloc() instead.
+ */
+#define __GFP_IO	((__force gfp_t)___GFP_IO)
+#define __GFP_FS	((__force gfp_t)___GFP_FS)
+#define __GFP_DIRECT_RECLAIM	((__force gfp_t)___GFP_DIRECT_RECLAIM) /* Caller can reclaim */
+#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
+#define __GFP_RECLAIM ((__force gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))
+#define __GFP_RETRY_MAYFAIL	((__force gfp_t)___GFP_RETRY_MAYFAIL)
+#define __GFP_NOFAIL	((__force gfp_t)___GFP_NOFAIL)
+#define __GFP_NORETRY	((__force gfp_t)___GFP_NORETRY)
+
+/**
+ * DOC: Action modifiers
+ *
+ * Action modifiers
+ * ----------------
+ *
+ * %__GFP_NOWARN suppresses allocation failure reports.
+ *
+ * %__GFP_COMP address compound page metadata.
+ *
+ * %__GFP_ZERO returns a zeroed page on success.
+ *
+ * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
+ * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
+ * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
+ * memory tags at the same time as zeroing memory has minimal additional
+ * performance impact.
+ *
+ * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
+ * Used for userspace and vmalloc pages; the latter are unpoisoned by
+ * kasan_unpoison_vmalloc instead. For userspace pages, results in
+ * poisoning being skipped as well, see should_skip_kasan_poison for
+ * details. Only effective in HW_TAGS mode.
+ */
+#define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
+#define __GFP_COMP	((__force gfp_t)___GFP_COMP)
+#define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
+#define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
+#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
+#define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
+
+/* Disable lockdep for GFP context tracking */
+#define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
+
+/* Room for N __GFP_FOO bits */
+#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
+#define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+/**
+ * DOC: Useful GFP flag combinations
+ *
+ * Useful GFP flag combinations
+ * ----------------------------
+ *
+ * Useful GFP flag combinations that are commonly used. It is recommended
+ * that subsystems start with one of these combinations and then set/clear
+ * %__GFP_FOO flags as necessary.
+ *
+ * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
+ * watermark is applied to allow access to "atomic reserves".
+ * The current implementation doesn't support NMI and few other strict
+ * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
+ *
+ * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
+ * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
+ *
+ * %GFP_KERNEL_ACCOUNT is the same as GFP_KERNEL, except the allocation is
+ * accounted to kmemcg.
+ *
+ * %GFP_NOWAIT is for kernel allocations that should not stall for direct
+ * reclaim, start physical IO or use any filesystem callback.  It is very
+ * likely to fail to allocate memory, even for very small allocations.
+ *
+ * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
+ * that do not require the starting of any physical IO.
+ * Please try to avoid using this flag directly and instead use
+ * memalloc_noio_{save,restore} to mark the whole scope which cannot
+ * perform any IO with a short explanation why. All allocation requests
+ * will inherit GFP_NOIO implicitly.
+ *
+ * %GFP_NOFS will use direct reclaim but will not use any filesystem interfaces.
+ * Please try to avoid using this flag directly and instead use
+ * memalloc_nofs_{save,restore} to mark the whole scope which cannot/shouldn't
+ * recurse into the FS layer with a short explanation why. All allocation
+ * requests will inherit GFP_NOFS implicitly.
+ *
+ * %GFP_USER is for userspace allocations that also need to be directly
+ * accessibly by the kernel or hardware. It is typically used by hardware
+ * for buffers that are mapped to userspace (e.g. graphics) that hardware
+ * still must DMA to. cpuset limits are enforced for these allocations.
+ *
+ * %GFP_DMA exists for historical reasons and should be avoided where possible.
+ * The flags indicates that the caller requires that the lowest zone be
+ * used (%ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
+ * it would require careful auditing as some users really require it and
+ * others use the flag to avoid lowmem reserves in %ZONE_DMA and treat the
+ * lowest zone as a type of emergency reserve.
+ *
+ * %GFP_DMA32 is similar to %GFP_DMA except that the caller requires a 32-bit
+ * address. Note that kmalloc(..., GFP_DMA32) does not return DMA32 memory
+ * because the DMA32 kmalloc cache array is not implemented.
+ * (Reason: there is no such user in kernel).
+ *
+ * %GFP_HIGHUSER is for userspace allocations that may be mapped to userspace,
+ * do not need to be directly accessible by the kernel but that cannot
+ * move once in use. An example may be a hardware allocation that maps
+ * data directly into userspace but has no addressing limitations.
+ *
+ * %GFP_HIGHUSER_MOVABLE is for userspace allocations that the kernel does not
+ * need direct access to but can use kmap() when access is required. They
+ * are expected to be movable via page reclaim or page migration. Typically,
+ * pages on the LRU would also be allocated with %GFP_HIGHUSER_MOVABLE.
+ *
+ * %GFP_TRANSHUGE and %GFP_TRANSHUGE_LIGHT are used for THP allocations. They
+ * are compound allocations that will generally fail quickly if memory is not
+ * available and will not wake kswapd/kcompactd on failure. The _LIGHT
+ * version does not attempt reclaim/compaction at all and is by default used
+ * in page fault path, while the non-light is used by khugepaged.
+ */
+#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
+#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
+#define GFP_NOIO	(__GFP_RECLAIM)
+#define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
+#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_DMA		__GFP_DMA
+#define GFP_DMA32	__GFP_DMA32
+#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
+#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
+#define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
+			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
+#define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
+
+#endif /* __LINUX_GFP_TYPES_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index be519c433ce4..7b515e605125 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -23,6 +23,7 @@ declare -a FILES=(
   "include/linux/const.h"
   "include/vdso/const.h"
   "include/vdso/unaligned.h"
+  "include/linux/gfp_types.h"
   "include/linux/hash.h"
   "include/linux/list-sort.h"
   "include/uapi/linux/hw_breakpoint.h"
-- 
2.51.0.355.g5224444f11-goog


