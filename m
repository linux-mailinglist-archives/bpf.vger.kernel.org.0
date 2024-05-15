Return-Path: <bpf+bounces-29800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DA8C6CE6
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 21:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB692844DC
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111B15B119;
	Wed, 15 May 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqcJeDG4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1715B0F9
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801793; cv=none; b=aLhbIJM72gchqDmJMepD0S0LvzTxwr5Xl/Ib9aC7jFSvxxut5L1WvyXEV65XZP6lRGt6008VhqJOeIm5H62Flyvqr6EfTIB3peVC/h10fOyyRpdqXcprxHQZQsuDhu0HeP7pr5S/ahaWIpfCB6t3ZRvc5eOMjPgF2uAIpVHavCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801793; c=relaxed/simple;
	bh=0lSt7QVBUAdOGQGjlbIPqXYDj232a+VWY9UlJ/ZrpNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggU3oCNLp44jFJ0Yw9dYeF4fROpflXv6yOUw5j3C0opgkr91XUhd9Qvcoc86pnZNei+diBznTixK6PQDUkPuUSJWJfyJuf0RFddPUMBvK3bgFmwfraMuvSnrDQhismDZX2SW+MgzLuseND3REggOHmf1mVy1pQcBNcJ43Wb2VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqcJeDG4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de74a2635e2so11860908276.3
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801791; x=1716406591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=nqcJeDG4VS51tGH0eNlWJoGayc4RrT+yo5IBujXLTc4nPTLlc2J4p0MMFR32Z7lSaz
         ppcz2KvOuj7LrhOsRg55PtbeID9JycUPJ3eBGVK/tNGq4VucWozqkxdSfOLbbpO17prQ
         sWuIwN/jjBE0ZVMEaXfgWjGSIq9S/BjpTOsyJ0pFRhip7B5v0uD4dEKyeFnTS0D5n18u
         ZOtkM/+FANKK4yv6kaJytaB+sGQZ0xeirNUOBMRqpsASkfeSJfn3MyxcKjiA2GpNJCoe
         VYBzMiX3v+wqmc/4Hv15pHNVBYWLdjNPr+sHBe+DMe/BXRA9qH02YVCEQXwRfaEcAhmy
         sgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801791; x=1716406591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=XfN59dZDNQ2Jroxcerl/w8FKW3pKp+eAou/YEQwFHTQDJ6gekMHGxaLHWxN/iReJ4D
         imrCPIt4bmaMvmljZNqFDUg1Wkx8od2RE1WW3eqLJ0ATiy6OYy6vjaqPx/W7JBpX5DMs
         GiQRJR1J6Os1FwTmnnVwKIe6Px7H6wiMKLaG3aPTURwF1EYTerW3gyIDNNxEDy/fWlq4
         FI0MoROi5uNy1Fobn9P8ui344rYd8QIwblet91fFrBbItRQ52QnPnCavjlEgp/ak8o1l
         +2Udu49Zaw5enjiedJ92VDha6/8Z9rEZd5KFQBnvG/l04Re7mwmudAbPp/o7NvgqXy4R
         iAdA==
X-Forwarded-Encrypted: i=1; AJvYcCXXg9eMhvhKviX28xz2QiJ+2QqFABBlpdHUkFBKFJ2Zu5ImZttgW+dDqm6bOn2m8rQcsk9kXw2I+IevgdwaijrxSBGY
X-Gm-Message-State: AOJu0Yykyh0jpUpo9A5o+pc9cmLenla/7eOsX5AiAeztgNPydM/0BxXC
	HxoWsjJtI5ujq1Qj+c5+bPzC8Iydixy2btCiDIzyGrSgwzQxyNzs6vfbKlE5mRss1X5K4gmfXtE
	H
X-Google-Smtp-Source: AGHT+IGytyoLkOH431aR7mF4/3pxrMXnoPzF9EPSCOORKbwwc0MQGbSUWr23nIhRDL3iPMPF3Uv+te+uzcs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:6902:2b83:b0:de5:2ce1:b62d with SMTP id
 3f1490d57ef6-dee4f4bfba9mr1543914276.10.1715801790944; Wed, 15 May 2024
 12:36:30 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:08 -0700
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-3-yabinc@google.com>
Subject: [PATCH v5 2/3] perf/core: Check sample_type in perf_sample_save_callchain
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
 include/linux/perf_event.h | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

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
index fefac1a57b56..bda066c33120 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1235,6 +1235,11 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


