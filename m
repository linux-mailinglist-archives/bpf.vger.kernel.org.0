Return-Path: <bpf+bounces-29515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8A8C2A64
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CA11F23A0D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018574CB2B;
	Fri, 10 May 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSaQXoHg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F847A62
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368489; cv=none; b=DeSvb5Pfo3+SYtnmq5VL+56jMk0dPlQpzaHwM25466IISa8V0GfC4m+ggf1nWIDkPUCA0dTyNrY58l8/vHEPC//XBgEq+8G781ABCEF616vVzej878Mw5rdq+M00D9g7xRv2ZMvlD1k0F6WbPDxuU9zCYku3DW0mPIfiy8gO3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368489; c=relaxed/simple;
	bh=xySRyI8fWJdGd1hvqSCkes+7dSi689oW4NVcWrWQsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ueRfkZNjEKwU9sRkgRfh1yXgbe9JmGGN1dLFx0U86ZPd2eE1xklnPHfXdRpOI4vpNcWJr8vH81WqFraU7eBf6za6iCarldQST1frYJqGDaP9RFYzYsZc+i/GS2q0n5RHm+yPHEITLAWmpAR49GVSvaexTKvPef9PZizD/vA3sWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSaQXoHg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4b79115so42932947b3.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368487; x=1715973287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=qSaQXoHgu4hfbDE/cIkZEw6Ew0LbYgFz9l7ztaGnCoT5/dLE35EIeKiLj5a8yLNN6+
         fBcboHCaDTkn0Pwms7ZPf2z6Sy1oc4t1tccnn0f+u+DbtEoM+yXIxYYCGyOlh00cFS5c
         5IC/3hUH7Dzm9dNPX57EDQJWjdwB2dY6zttQug9LitzPc9mINKmHxxfCad5j3Quwg+sZ
         4X/jliMWE99hWEPxZiXEl4L0TaEJRB7IafgD0+W7+/e8wZCFP8v5C0kvLS1DMP2j88Ly
         c9GaWsC3p5XRoRs62A1ang6NyqJhdQJWAGyBnsdj+Ftc1eXh5kQJlY+CUDfGrsCNFwMr
         7Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368487; x=1715973287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=By5C7xO9LTuhV9WUU7g1jXChpno5hr5/9d7uYmxxZkzzEAL1Ammzl6ytsKEj1w597q
         D90S/AIdQ08vXaZIeMFF/0Sd/My21zeeZUNjAm6T85rYrSdPylek+xWvZJCx5Jbq/jt0
         iVu4B484JDwTSTe4Pok3wAzL7NyFTZFyVJNj3fKOcz+iFc2knKACTnV0GkXIqdnB/R1i
         djogqiE1pzy+E9DPejtBfbFtpeFLiIUZg+UGMl/y9SVPEvmB6RbZysOa/UIoZq87b4Sx
         qoRhBgwV27w65koNG/0ogRHQ4FRgRZ6hccqwp2LXWGIetyn9RSjVgMLo8l68+6REY/hv
         Oi5A==
X-Forwarded-Encrypted: i=1; AJvYcCUxgP7QMDyKDTRsGe2qC9+vzdp+DUrWra1Uz7gMX6LbDGNEsYNzwflLf3OSmmWi+luxGAd3Kp8o04ar3t71Q52MyVfn
X-Gm-Message-State: AOJu0YzC0bft0NAAh6M6zsyHOJv/wRzYosfEKS4B9UyrgcbQgp7kIyre
	McFDladGxDuaoWQYqzm3rcZwWSHvd26o9rQP5lHuwGhIqBUcOGLiY8GMLRwZXptEez7pqva4qfZ
	x
X-Google-Smtp-Source: AGHT+IFbibY3ioQqzSPpipnTS4oiCEdHlz4wSzLfk21TQTFTF9AEOsn9D0hZruEjBe8PV6hrEYBa6K6kD8c=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:d3a5:c745:caa1:83ed])
 (user=yabinc job=sendgmr) by 2002:a05:690c:3512:b0:61b:e6a7:e697 with SMTP id
 00721157ae682-622b00380d6mr9399547b3.9.1715368486960; Fri, 10 May 2024
 12:14:46 -0700 (PDT)
Date: Fri, 10 May 2024 12:14:22 -0700
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510191423.2297538-3-yabinc@google.com>
Subject: [PATCH v4 2/3] perf/core: Check sample_type in perf_sample_save_callchain
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_callchain() to prevent
saving callchain data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/ibs.c  | 3 +--
 arch/x86/events/intel/ds.c | 6 ++----
 include/linux/perf_event.h | 3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c3a2f6f57770..f02939655b2a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1129,8 +1129,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(&data, event, iregs);
+	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfed8417..c2b5585aa6d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1655,8 +1655,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1823,8 +1822,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9fc55193ff99..8617815456b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1232,6 +1232,9 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.118.g7fe29c98d7-goog


