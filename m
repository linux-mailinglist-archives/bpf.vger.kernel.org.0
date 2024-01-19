Return-Path: <bpf+bounces-19859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C40832289
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F371F2359D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B62579;
	Fri, 19 Jan 2024 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="k4RCG+1D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167A184E
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623258; cv=none; b=nrChSuWZztzdd9Cu8sB+aaLxzjH5N3dSs2WrVb3eRqM7vxjaoUEScozYIQxgDJtX3FK83OAhVV+JNpuwTgzniBJAnWhknx2kQ5lD3iNAafJsOzGrUHCfi/AxlvOesUB4/IRG0inDdLqPRaAAE52zFItL3uNczzsuohldeoaMFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623258; c=relaxed/simple;
	bh=aE2XSvO8OhL2bKh+kya+x2v8NA+iHW4PCGN/ajZfLTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XplUW4neBiVWWGlkQxN5enaaJ3LO7O8aYLwjY9pO7urnJbMuQX1O1rIua5l84EmJChYtog42f26M/Z/jNd+ZFRA+4l3FAuq+u/YUJK+TIc8ZBt8r58tynaKnOwu9ZNJEBVQEl9+CBv/w7K057JZM3jAYi3b/wXkGOvVkVmgf6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=k4RCG+1D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d711d7a940so1700685ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623256; x=1706228056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZcU1eaajijXdHtIWhayAvoytSB02YbTVp/d9IoCpKI=;
        b=k4RCG+1DXT7r+NHdYh2FBFIrU7lK/6+cDzG2SmFd1Vrb1s+N0L6ZesFliazSbah2nY
         A27FnLwf6VuPQDuWchzfkWJJgioV2vZaGMdU5TU8zzmtbW22I+JYpGgadFCOro6vWT5n
         WDMPPQJIJZBAUqLzVUZGbsaARHUvnVVg2Kd71iXIeu3t9APSxWWoBWdhdWf19JZXo46E
         u+RBT7nFnr93yRh3p4KD4RsxXRXLbDcYzdWMMQxtt57EpqkJgt1aZDVMpiiOkRtgG97q
         GQxteT02B6at5I1qxMiH9E52zHjv83QM4nHE8COxNDZ7C/gWE+m9cuicDD4/hLb9COD6
         4OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623256; x=1706228056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZcU1eaajijXdHtIWhayAvoytSB02YbTVp/d9IoCpKI=;
        b=OlbBwh2HUczdx+x1ILwGnfB/FxacL5ifQQ8hwfCZ4Qi6z2XEwqaMBxuKVRV7B9XDxB
         eHPqDnbR3TYkRGN8+sE2vo4R//QIlbciyLrJEaW5+7tiOZURYI6eOk8I6GDkBEIQoWFt
         blwu+AUCs1aGwUmAqiJse8Mj8w9U7dCxmHEgdwHOALzO3sbKlNQREkJicpp+dY2Y82CQ
         DyaK9E7kogVkNt2GGYOE+jXjzAaVB19WjiwLaTPFviZwsw0Hz6fCT9yuW2bI9mSLOQcr
         gew7oPv8WF/xLd3OLcHBeTjJzoRo/m4M7nTptdn6sC6h3D8v/iah6/wtSttIJxSBy9a0
         hK0g==
X-Gm-Message-State: AOJu0Yylu96mgKk30/d/KCzcx6F/VRFAsyuG4M9qSUpQZg0EfcFe+IyN
	LAoYxhQy31sVSEYcwmAOBiNnPTCfNR51lRzlDeGRjpA9SzYFbTkktU1BW4+QKQ==
X-Google-Smtp-Source: AGHT+IEmEX9cgoOoLlXa/PdbiT/2i5lxpr6nzytvpqJqWne6DoYaTAYruERi3LVO2S0pdvC6eXPZjA==
X-Received: by 2002:a17:902:d486:b0:1d7:1b54:8969 with SMTP id c6-20020a170902d48600b001d71b548969mr518993plg.11.1705623256601;
        Thu, 18 Jan 2024 16:14:16 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:16 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 2/4] perf/bpf: Remove unneeded uses_default_overflow_handler.
Date: Thu, 18 Jan 2024 16:13:49 -0800
Message-Id: <20240119001352.9396-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119001352.9396-1-khuey@kylehuey.com>
References: <20240119001352.9396-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct perf_event's orig_overflow_handler is gone, there's no need
for the functions and macros to support looking past overflow_handler to
orig_overflow_handler.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Song Liu <song@kernel.org>
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 16 ++--------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index dc0fb7a81371..054e9199f30d 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (uses_default_overflow_handler(bp)) {
+	if (is_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!uses_default_overflow_handler(wp))
+		if (!is_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (uses_default_overflow_handler(wp))
+		if (is_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (uses_default_overflow_handler(bp))
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 35225632d70a..db2a1861bb97 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (uses_default_overflow_handler(bp))
+		if (is_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = uses_default_overflow_handler(wp);
+	int step = is_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c7f54fd74d89..c8bd5bb6610c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1341,8 +1341,9 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
+is_default_overflow_handler(struct perf_event *event)
 {
+	perf_overflow_handler_t overflow_handler = event->overflow_handler;
 	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
 	if (unlikely(overflow_handler == perf_event_output_backward))
@@ -1350,19 +1351,6 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 	return false;
 }
 
-#define is_default_overflow_handler(event) \
-	__is_default_overflow_handler((event)->overflow_handler)
-
-#ifdef CONFIG_BPF_SYSCALL
-static inline bool uses_default_overflow_handler(struct perf_event *event)
-{
-	return is_default_overflow_handler(event);
-}
-#else
-#define uses_default_overflow_handler(event) \
-	is_default_overflow_handler(event)
-#endif
-
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
-- 
2.34.1


