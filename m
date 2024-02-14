Return-Path: <bpf+bounces-22012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12585508A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25E61C299AB
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0D85294;
	Wed, 14 Feb 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="e4wo/Fo6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F284FD7
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932446; cv=none; b=Rq7VjZehjDRBZWGneKlRUxy1194L3yIiep2dL8urzdn3CkJVDBuI8Q3UCQXJv3XrbZFRm394wGQ3lgSnzEoXZE3oDSApIEBu94TG76A82kMmbVETBG0dnfVZceLEJiIxPDxznXVH3Widv7P/jsDySkz9ko1Oau+yO6obyRuHn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932446; c=relaxed/simple;
	bh=BIEPrj8REzhp6IWPrzPDboiwJzkYVpJOVlkhzZJPWM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNFIqxQ6Jz6t+2A7UcOBn2M/BhxotHRrzZC3HpdZjD2sb61G+r4i+86IHyO0U1+4imS5zv3abAtJB0K7umGfJUAMsk1wHIRlAtEkcxEzlG+7bqvJtXeOEJ/LMblCkSvFw/UZwEi9I5GxRg28ZwUs4OHed/n986TWimFxBGl2Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=e4wo/Fo6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0cd3bed29so33419b3a.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932443; x=1708537243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43jjz2Dnzl3sNSNdkk4MoD6bg1Ygi5eixyO/ZKWqbHM=;
        b=e4wo/Fo6QxNFh0IxQmUgdwryTuJ3PRE+cjDmvgKCckTJko1GDzLC0ggpLsxUuAWkGo
         +shzdRzidYNoWnegUUkTiPzbLNqEaRiVBf/ctXCL1Ot3ACDFidwfDQ3lNXlFAvUwqAie
         vAYlv/xkIcRqJMppfD4U0TMXMee67KzDLKOCE0Z6l3CH4nh+VNEMsnCSZBnboCp2C8+O
         jnIS7LKV3LqOzV9i6AVwrLD1Z0bZh7N9RED2yvstcUgPv4d/tM2wVrEx+HXY0EnIg7f4
         Qed+b6usThKYFdcCoNwJFPwCN3yc8tvPMwyMVAejYTTPom2Z0rHAn+xUeIGQfVR+Jt17
         wFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932443; x=1708537243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43jjz2Dnzl3sNSNdkk4MoD6bg1Ygi5eixyO/ZKWqbHM=;
        b=sBWeHkBSNyxiXmVhPkkvVhV7WETSkjzeQDM7zK+ynrovcNQUAFTukdh6+frlvBK5Zv
         xTXq+Xej0tJ3Sqbi1W+O0aOxTby8DJDjkqpAUbYqpPSLuyNGv9d7AdbT+Nts8mVHgk2z
         Wh9+xqZuj0mMUKgIOZqa28T/rBtuXXBJ662Nc8wRSnqXD4L6vDi2V/J3fOCbrDx11q6o
         wk47r0d9El+smmJWdDSOrBhbfBHR34o+3LcXAw0jUHh8hszswHH3xAxjvldzxyhyS8Mk
         zaZ4htWhE760UYO1WP6H3hicrCmZTXnYEO01lq/NOZlmg49xGIJ4fWwXSkNUrbfv0+xW
         glqw==
X-Forwarded-Encrypted: i=1; AJvYcCUX4lnbrHOOF8Bp6i0EAcYgKz3hmoW0TEq2FszE2RLXFdDnRyxvqBlMJhBvsvoJzfP146jWK4UarWXgwfPIP36spZSF
X-Gm-Message-State: AOJu0Yxbld7d0n6wiAXXPLtmnPvbntPyhW70IHon5bGBdLzdjtYM+vMe
	BXb3o6k0TwQxVcOrHpWpwyL+9LivLfP7f/GbJx0nRy/9Y4DTimIq5OG53FnPTQ==
X-Google-Smtp-Source: AGHT+IF5+DWod+4MkXnnxd/jBnxFQ4s7hRAAlKX7Hz1YGpB18O9PTm/20taXOa1gaXwFTkPVrERdMg==
X-Received: by 2002:a05:6a21:87a9:b0:1a0:5a4c:c6b9 with SMTP id ph41-20020a056a2187a900b001a05a4cc6b9mr2530953pzb.18.1707932442821;
        Wed, 14 Feb 2024 09:40:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXL+icLSBdWtKqx1QTTEjwliXPcrhmUTelRLNN/lM/h4HVf001c7XmlOcS0JZ3n+ia7tV8uceVKDrPeGvV2MlRtYmbZiXIUThQpWhXqnx488RE0t45AL0X93bh3WSh3hhMSeFZ6S+o+oJjan1WHX9pa4ztWS7DxoXVisF1BS66W8+6UGPsuXHOglUNklczRaF7df6NCCbk/z+OJcZ/1VfN0v7eqYvhtFh0vi+eKb4cJ5pQ0WmqHzpxC1E8D6Xo46EC3uK9Sv9pZ3ooHNuoWkgnpYR7W27K3QaBEeEjTMx0S0a23oiB+fuOnqk+JrZHdBCT+UEhA9n8R16etvgchT13S26YPV3iL2ccAcLbO9Ci8lLAY7GqTNwpECVGWOBm8tmHVFeonZqEV6jZIdFAkZVEftWCKmovdm5R0wtaUvqFG3GEDtVH8857ETPM7b8amr28IqwBdvAlRK+8qn8tWC8Yt6bn+PA4C2AgTQAQSJIyP5QOQKsq7qySFDsXBx21DolQmf007yH33vN3rqVOz/MTRYGyx5BW2NorExJm1VxPuFJE=
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:40:42 -0800 (PST)
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
	Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RESEND PATCH v5 1/4] perf/bpf: Call bpf handler directly, not through overflow machinery
Date: Wed, 14 Feb 2024 09:39:32 -0800
Message-Id: <20240214173950.18570-2-khuey@kylehuey.com>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
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


