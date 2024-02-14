Return-Path: <bpf+bounces-22013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E0785508B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A9328BFE9
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375D8565A;
	Wed, 14 Feb 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="IoqOV6s8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188B84FD9
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932447; cv=none; b=W+1lunm1fAibVWUti8DDtHPfgI9JpLjBMxeMo+2JT6sQMgLrZ4m6qTCYlkcO3N1gwhfjevV1wN8JEFmEyEATyTxMSdM5klqfaqTBORRGfLh7okaHyBmTm6rJacLNNfIEwhG6bPdQAxoLza2/Q8NDYJWllgU1hxt/gClgXEngMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932447; c=relaxed/simple;
	bh=zUABpjG2ub173w63GMgMTw18XVCHIXF84Q0edlKhxyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctndwgLJp57AGn9wf5faiI47SmSUM1AAVj92uoWoWrUjeKzlIm+EXgOycBhGhLYyDiwLcMeEMilGqWjGp8X35cMJRqMjtr0hkAu37sOPzNzeS3WkD66Uld/+BuXoJFSZp2eTkc9Y2N3VPvo1ELfGmCINsvmj7JlM/WB1aXpYnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=IoqOV6s8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso873495b3a.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932445; x=1708537245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ElBvlPVPDuFmuEeY/T4KuG3RaPIc1GsemQ8p6vqiM4=;
        b=IoqOV6s8Wx059NZmgJ9rmO7ZmLPt71UVBcT0WDfE7hDZ+0pKYLawhwp+c3i2Hsd+lh
         SKl0qaVvsppcXqJ3kvIDRFrt3a/BjswkNyWZmas+ACVehWrGNw3KA4wvGXN6omMoz/LN
         AH6DBp9pbZw9vbWMS0OgoEmF5Vz29UTdPwF4JIQMERu+mpTcneTZ3ffZimJMuEvjKmwb
         S03uoj7ovWVn0atkhg5DfTwYPG88Borp/pCsqGv49udH2dEhhl++lMLoxizRgur0PT8W
         FJat12JhuKe1wn++KDLETk3uKGMrz77t397fxZZcRtH73R9JXG7AYWtRQoOhLw76Adno
         NWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932445; x=1708537245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ElBvlPVPDuFmuEeY/T4KuG3RaPIc1GsemQ8p6vqiM4=;
        b=cs8koPoxOdrcEFMLQhwyzc2lGU6n9vF7ydLfSsW6woZ2TuIPdYOTLWmNivV8G26hY5
         RUL+oHbepRrsQywrT9oB25hugdLxLDedDLD08H1QSwpddudYz3irHCMG2+CacNxhNWbZ
         zAzcXNY7SMoeh7/cVmMK8vubFKmQrPiVTMyHTV/yjmrMFd0BsYq04k8QJcRiuOiDyVfv
         yTjk8kuHmxtmmcWSj8tjGKyCgojbGdRnRrlz6pcvbAmtwdLHjuC1sRMm9AoPgoG5975b
         nJzvVtytUgnd78TTE2dUngjKJnfSNso1tE6rJTUGIXaWh66RgTR8UxlBrpRKvPmt/qdg
         nPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw/RHa/xbsX/Sm4ja8fbrIZ5gEIPR9/cToRhf/F44iDk26zkw+9QDRRz/xGJTJzVV37vDSQqE5It/VMj5ewjbrTu2D
X-Gm-Message-State: AOJu0YwxoKqxz4gbZ/AkoXNX5vtGFQihRb31+vWUuQKSJGQtKEQlbzgd
	c4bm8Zsenz14niZp3rnjy9+l7OYhgFHiUpVQUVLuKXwbQMOsBhpY6DAjPliMSA==
X-Google-Smtp-Source: AGHT+IFKJ2enC+iYjRYfjK0hAaVcw9L2SW4JceOswt+yl/hAiyoNanaf3Sr8OAjgf/m33sn8UysiTQ==
X-Received: by 2002:a05:6a20:d818:b0:19e:b614:685c with SMTP id iv24-20020a056a20d81800b0019eb614685cmr4223312pzb.22.1707932444999;
        Wed, 14 Feb 2024 09:40:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBfzyE+xp/BPlirU8BbCNUyN9ay2yh+NMWrAWy4c76qJ1yppJZxe8xiOfc5BMTzaFpkXe3UVkwzuP7xcq8xBBkCBKiNiPp+12RTFq2CYHcu3qAvyC58hc4HuneYLJtyQnigIefY/GIMhc2iwaZk92xQSnhH94zzOGcvwSBsk8u9gIIQlOLDuURAj3u/lA8/45midZ5HMNzKnK0ywKeuuVVOJSslwMwHExU8lt7ybeAip41HXTRwZpYNugEaRiwKrZuAeCW9tdbOzDoGrkbJsgkkpUr/eHW4gyYN/FuussuWMaQFDwnAfhd3hc0TxkspyBnHxAmx0hfxuvMX8LDah+MopPTInvr6p+Z2xQQ0mGNmXEuTagrhCRvxp9QDo8FytDEsDjJUQl+fqldStC140ECBeOZSvpzlnKi9YLnTYZUfcP+5/Oh+wsQnProma40Rw7BHKV+fGL/zq3+ENEAvMKjLTwiN8xFxwztlkOTf53sOyiWszjhURi1aTa58u/6LPOpmGn91/8kLxYDfFV3YEtP346j5Gbck0lF192IeZ+zRKinjW5RQ5yOmPT0F7ohb9ckM4/rR8FJ3Q33v/dciL9JDZwZhLgSDsxHREHi/Bgj4f+EVwmLP3QOFsg5PWEfaeKBcWayXi3q8pqdtX1YML3asSjMw9Ml6ll5f+1kesxySZjAdHSZoF2w
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:40:44 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Will Deacon <will@kernel.org>,
	Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RESEND PATCH v5 2/4] perf/bpf: Remove unneeded uses_default_overflow_handler.
Date: Wed, 14 Feb 2024 09:39:33 -0800
Message-Id: <20240214173950.18570-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
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


