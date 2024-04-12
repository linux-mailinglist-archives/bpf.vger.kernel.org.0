Return-Path: <bpf+bounces-26602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0D8A2367
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FC01C2134C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67717BD4;
	Fri, 12 Apr 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="U1Flfrhd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2716426
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886656; cv=none; b=Tmfy34fi3VkMWq3lgWti9AEBgVxRipqCZqGAsPWO8XBhD0Ge2YUfrD5V1RLcotqDDgbzKtGquMBGu4yvaGPpIz+0xGYUaugyG9M0TxJRwVCfu1bStaDUDOP25eY1lOt6T0yk5s2YPljxku2UYwkeoeTJwuwCTjrDfolkRyaiYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886656; c=relaxed/simple;
	bh=j+JlZhELkbUyrxfK0CeiZLK3yBU6Q8rGCixqPhBA6EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWMXgoF0uw0QRlUX8vcPT8IRIfp4rnbDdP0JsafNg8DUIz2oBQ5h50sMTjRBlH+mvQFnRP/cSkGiJgYPEcSZWK1C1tM0j5D1GcTJvMmAbHX8dt7f9mYtcEL4Yom3e0BMr5fg3Otj2uNG6CSNsvXoADUbDVmwjrAyXsIdMG2VvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=U1Flfrhd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78d723c0dc5so30841785a.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886653; x=1713491453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEkPkaevs/85pKXIFzAxTV+0rXNtmtbXbn0hIUFujbg=;
        b=U1FlfrhdO9xd3qiKzuDF5u2WHSrUxvKxOWjhZBBNwr8YsurwdNBdKHxx/tiiDYwODe
         FklQ9x+0lbEybH3z8QFAsoKPOhc+cvO7EHOSzErbl7YbBGlZjGW3xKO0s7sxv2Vyl9Sj
         nZA7WUxCK4LKCVqGkOL9Kkh55LjRZch68BX8XLMSteGSC2FWHb+x7qvzQ2R3oKFtJOhs
         4zkoaZwXlvof4qMBNKBvqgn0OqWcUQJm2WeLURh8jAy1Hq8pxGZwWuly3tfXc4Bqk2U7
         +cbLOAMj+O4d/kcfs2rWk/peyd/zfgmNqRNHBupYKo1O99tLKS119oRb3ivEmcbJWq3Y
         m2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886653; x=1713491453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEkPkaevs/85pKXIFzAxTV+0rXNtmtbXbn0hIUFujbg=;
        b=dY9f6B4gO0FDY5ftjCeqcHNLIL0IRRBbHLiFoSJXId6/LIg7oOAtohDE1cJHbaIVNb
         fctTpPnFdBUUVFYejLWpz6yMthQj47a6jfyRwKGzD6fJPL+MkdoehxXf+SO3PnpqrhyJ
         6btdp7U6CXELxM+EnnR0j0NjCFBkbZ98i8r9EAQJiyxvq3rg733RNmqxo0owx6wTv2ET
         umR7G2XyjV4egFIsdN3UJX0fTEWWWkaMGh+N6RkdR8FId6cPGC3MRdsETeHyJrZOueWU
         BgE7HpgI4Ijgdi4DCjlQahnpJWb1VnUHIq0zKr/8AmtzgCgsrEft88+lAIWKSAYikNP1
         ka+w==
X-Forwarded-Encrypted: i=1; AJvYcCVWfQfYb0IulvCAhawj2JMcxBV7eiMtKp+lxyysuKYHT/QIcrXeNL00ItJ4kM7xAoelPdCEdlP55lcvZ4tDGBxQg1KZ
X-Gm-Message-State: AOJu0YwRCUS5aaXLEIU+QPmnaDiM/g1USc1bs8ptLqEtdsX7K8zlkG5Z
	UjBZp8LpL2BqWtPG6xZLRCP7ZeJbLvZHULGEzHCBbC+e4geTA4LDC7+sfhY0DA==
X-Google-Smtp-Source: AGHT+IEbFaxDuu1GXCiEZNx7U9M0URvr9l8ow3pyXrdyfGxSiceYpsCWsh1lyCxVKzYndLYworc6Jw==
X-Received: by 2002:a05:620a:1a93:b0:78d:5714:6698 with SMTP id bl19-20020a05620a1a9300b0078d57146698mr1675936qkb.4.1712886653450;
        Thu, 11 Apr 2024 18:50:53 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:53 -0700 (PDT)
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
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 4/7] perf/bpf: Call bpf handler directly, not through overflow machinery
Date: Thu, 11 Apr 2024 18:50:16 -0700
Message-Id: <20240412015019.7060-5-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
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

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 27 +++++++++++----------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 07cd4722dedb..65ad1294218f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,7 +809,6 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 
@@ -1355,10 +1354,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
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
index a7c2a739a27c..fd601d509cea 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9545,9 +9545,9 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
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
@@ -9568,10 +9568,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -9607,8 +9605,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -9619,15 +9615,15 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
 #else
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
+	return 1;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -9711,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -11978,13 +11975,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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


