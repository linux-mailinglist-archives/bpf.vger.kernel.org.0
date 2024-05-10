Return-Path: <bpf+bounces-29339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C68C1A37
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88DB1C231E9
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02212B71;
	Fri, 10 May 2024 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GtDOigs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C5101DB
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299525; cv=none; b=ry6prbM59a3/nblrNGoz05E4waV9XbO90Ay/TIEi3UVgpU7XMcDp83W1TvWue1d+22dk7aign+hGmCKRzci5eYMrueASQr9Gn+jHA+9ZiYJ7CBgdY3J1ArSueNC61NW7b7OvyGSpG/c0/Wdi2o/Ntg51CrKFBSZLEuUWShHOUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299525; c=relaxed/simple;
	bh=cGpULC1B1HXkvRfCSn3TdeH+Xj5EwEpr4DGLnTg+pCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGeg8i5G+TbkNBFDOPnZ9DhVM2XiZWB99ZZNa18zRUMsIQdE41aSrbRqJE/cQvO4g2DIi4LudMbrFBVsxcdVR3gGDLSCauXxIlDr+heC0f3XOEEz+zcK3iLH0sHCXWw1PN5Y5rZRauDhp8RKIb4Q5vns7H4JBx12uEzsvhZooBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GtDOigs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso18555267b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299523; x=1715904323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=1GtDOigsg5jSoXkWIBd0iOs/bvORgsA0dp9i8Pw9v6bPM3zeqJH0w94Q+/XodM3CT7
         q4SX4sjCybMXUdaTjgNlRUFYBfpyDFNxHgKjaMpNFpU6UcWIj0Pm1wFbfeYtZA7cJpMH
         jVuuTT6ZR5oSNuiDtBa98fqHK7zS2XPtiGlE70CPViVECq+MXsUrzx9aoFSD8ZW27y/z
         EM4dSqKAyBbHM3wgnnMp3s13c5nRD0y3bBkzLaVm31jAfA4DDndWfP0rs08CNbAreTuh
         EHL2HYRErZJB0+ZSLmJeBGAXXnwuZEyZAL97yB3hQoNG5Dsm9HEtUtcMxCIAUh6ZN7P3
         7W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299523; x=1715904323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=EBkMMDYmIbtyeulykgchMWFLo2uBg8M0Q+moNdCNFgm9lP0h+hRV4ZqRjIc6b18b2W
         3QjJ91TjdxuoPqpmdSZo6SWDPXdixhv4YZk48QPrIP3COFVD/SgAbyFOhbKqEnBxw5hh
         F5TB9GRb2F14XjNo4iGPCID9l/G344ihzcDsZCT9q2Pz9R9a0PuTT+SGv0TaFCzAfz1+
         1chzUV/XCNlVyliuSL+uZE+nQ1aZiQWV0uUS3vxDdRVWOVzorOb7KmL3cPTd7qULDS0i
         Pos7tqHKPR0WAjPXdN/i0QjHZdyiL4aAjgLWlYKaQZb0GsyZq6s34xmVuQ95PlFn9PQa
         xB0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6CUcA0ZvIGCgRnN0BhBC9LpHwK77dA4gAXd8wCz/07bYtEplC5RK1iep+lJl2KkXHDYnZNn7V7gFN6lW0xa+QCpac
X-Gm-Message-State: AOJu0Yxj1tFTMCTisutFKbNW586EZc46o1qErobZMWrWdgEKAEjz/1yw
	SiyR87PakzevXpaLNhK3XaJRjPqcaTmBnyFHX7bRQj0QlYTH3+x/C7pmVH2+ulVyT2h7PmkJnWj
	j
X-Google-Smtp-Source: AGHT+IEzy2h7K/VLaBZePrcCIRcOhw+P3u9Sa/loYEqzI4OLeWzMuuO/Li8UARzyxANE6fra/VW9xs+tfLs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6904:b0:611:6f24:62b1 with SMTP id
 00721157ae682-622af7a98aamr3561297b3.1.1715299522736; Thu, 09 May 2024
 17:05:22 -0700 (PDT)
Date: Thu,  9 May 2024 17:05:02 -0700
In-Reply-To: <20240510000502.1257463-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000502.1257463-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-4-yabinc@google.com>
Subject: [PATCH v3 3/3] perf: core: Check sample_type in perf_sample_save_brstack
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_brstack() to prevent
saving branch stack data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/core.c | 3 +--
 arch/x86/events/core.c     | 3 +--
 arch/x86/events/intel/ds.c | 3 +--
 include/linux/perf_event.h | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b47919..fb9bf3aa1b42 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..ff5577315938 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c2b5585aa6d1..f25236ffa28f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8617815456b0..8cff96782446 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1276,6 +1276,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
-- 
2.45.0.118.g7fe29c98d7-goog


