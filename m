Return-Path: <bpf+bounces-19858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EB832287
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293782874A5
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6B634;
	Fri, 19 Jan 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="g5vLseTw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936510F4
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623255; cv=none; b=HDRSme98QTyWDiHt1KowrA6Kc8uqwvyE4Ix26LocoVpOn9OPRvijwNYxXHJGxwB0D1TK6WfNwWpAYgN7Qoy+Hy3BYAIaI3Sf4zMKt8TbNvbRO29QwPGc5HomGXvEsx79DuYazQj6DjPbmt0YexDZU36msms6jAaINObTvHIXsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623255; c=relaxed/simple;
	bh=BvdPhHhuuf/fRX3SqKFdqqVaVqqf5FQjd8NlByquZYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rwr/uAmv6YncLqVM0SCkBndWAhYIP93pUbRBM/pfei2k/Vb1PdenwuDK7UhUCjAVzhmsGCTDrZsS4Ihn1AHyQWlTyL5jnjC+2F9O0bRYsc2dlSnbnIASR5wcLlvERailhZMlJxURV+VM+Y/rvRDqC0lOOKrVB+bdcGEY7pL03AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=g5vLseTw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso1395885ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623253; x=1706228053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goCRlABDp65iNRuy7Fdk99c/XuzP9RSm/x9LjyCmqK8=;
        b=g5vLseTwxcL1+e/Y4krZOtr6EtaiOwYUQSZuxbGwOUr8uMWz/nICL/yTIYe+NmfkvY
         x0lJAgXKVhLVmjFFCntcSbWlM7htz8Hf8jgvRizk46PvmwYOExB+gglUH16J+xor7cWK
         zMRZVkDvkuTiRFwLXPKaqy/+BDIhqynGoWKpZ3BWwurBeWF8yPMB/XyqcKd7IRFd7SfT
         ySZYS+yFFx8GtAVLI0/eTK3Q4KP1MeOChv/suiKL+1Y3mH1Q02gLPRbQvQKQVMcPYyZk
         lz+BPo9Z2og9ZGxLWEERNuffyOYNgJ8NabEbVnG8/VatSP7wWAvrdEoFpd/OlUVYjTPo
         fFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623253; x=1706228053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goCRlABDp65iNRuy7Fdk99c/XuzP9RSm/x9LjyCmqK8=;
        b=ONCgvMQ0nz2oqL7a9gSei1/C7jQq66g9wwEGKQkU2vXkvmUN82BEWej6Vicz0GhgGC
         JYILtyp2uhiaExb3Mw3xBRkJMNt4di5vVc4OFHh8O/nqHjcjB2NEILjibwrjVylrELII
         jcIhJHSwGvOg2AydPr6cWdKI7BNvdLEoIfsla47WnJIp9arOERL18x0F8Ej2qITcd1KL
         h1KBmsfqbBK2pJouE4gqAADsk3V2xo+b85/pyJ0Vv9MF+PNQljTOonpkGaXviprZzVD4
         P09G9JbI9c8a1AqEIylQhR88EB172Rq5VJHXjbXPrP4r8kRlUmpKtKeV2Zh+Q0PTPBGJ
         sveg==
X-Gm-Message-State: AOJu0YzRtkU8hVt4+Yr6GqjbsRpLG/67kHBjrdqHCOcWnGzDCewNm5ML
	3BlJyELnz8jVp3SXQ3QnMRp9AadnivRozgPoQ3FLwrpEUGZRaY6ZbTn7ePLGQQ==
X-Google-Smtp-Source: AGHT+IEoWDFJEWLLyfNOOcNAQO69wxXDeoE3NDFE/6nVWcyxeKdTpE9bWKe9TiAUfVBp/hdULye9zQ==
X-Received: by 2002:a17:902:dac6:b0:1d4:441e:7377 with SMTP id q6-20020a170902dac600b001d4441e7377mr1612768plx.40.1705623253562;
        Thu, 18 Jan 2024 16:14:13 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:13 -0800 (PST)
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
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/4] perf/bpf: Call bpf handler directly, not through overflow machinery
Date: Thu, 18 Jan 2024 16:13:48 -0800
Message-Id: <20240119001352.9396-2-khuey@kylehuey.com>
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

To ultimately allow bpf programs attached to perf events to completely
suppress all of the effects of a perf event overflow (rather than just the
sample output, as they do today), call bpf_overflow_handler() from
__perf_event_overflow() directly rather than modifying struct perf_event's
overflow_handler. Return the bpf program's return value from
bpf_overflow_handler() so that __perf_event_overflow() knows how to
proceed. Remove the now unnecessary orig_overflow_handler from struct
perf_event.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Song Liu <song@kernel.org>
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..c7f54fd74d89 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -810,7 +810,6 @@ struct perf_event {
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
 #ifdef CONFIG_BPF_SYSCALL
-	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 #endif
@@ -1357,10 +1356,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 #ifdef CONFIG_BPF_SYSCALL
 static inline bool uses_default_overflow_handler(struct perf_event *event)
 {
-	if (likely(is_default_overflow_handler(event)))
-		return true;
-
-	return __is_default_overflow_handler(event->orig_overflow_handler);
+	return is_default_overflow_handler(event);
 }
 #else
 #define uses_default_overflow_handler(event) \
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..24a718e7eb98 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9548,6 +9548,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs);
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9617,7 +9623,10 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+#ifdef CONFIG_BPF_SYSCALL
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+#endif
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -10427,9 +10436,9 @@ static void perf_event_free_filter(struct perf_event *event)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
@@ -10450,10 +10459,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -10489,8 +10496,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -10501,7 +10506,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
@@ -11975,13 +11979,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (overflow_handler == bpf_overflow_handler) {
+		if (parent_event->prog) {
 			struct bpf_prog *prog = parent_event->prog;
 
 			bpf_prog_inc(prog);
 			event->prog = prog;
-			event->orig_overflow_handler =
-				parent_event->orig_overflow_handler;
 		}
 #endif
 	}
-- 
2.34.1


