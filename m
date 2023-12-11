Return-Path: <bpf+bounces-17368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91980C080
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 05:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CF4280D2D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F81D543;
	Mon, 11 Dec 2023 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="TKGWwN1B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9377FD
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 20:55:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d05e4a94c3so35461205ad.1
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 20:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270558; x=1702875358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoADJIsaU4bvjYI7gdqH4FQT1qltoRFf88+tkPG8tZk=;
        b=TKGWwN1BMSfkcarzFN58mcceccPtTKo8f+lsaSmGESfSjcWXVzeVturjsETQBsbmFx
         KoFzR0qSE93M3dMBH8rwryOSXnsHsy/ktAVjRiH8ZWThdUmvvFdSo6m+o39XW1tLokql
         TZZCzt2UKeWBkgUg15enpKP+v+8vlN4oR/uaWp52O7LdaqWQJXf99XOf2xc90YSpbfX/
         aPRFQdKIKvUP+O25NwGvrJ6cywElGOKbvQQ81ttlMgK29w2zSm3KQ3o7B7Xo9Vlw2xSC
         9INEfPcO6VTPC4wEaYbnmjqIO922djMFHBBlTQ/kUX5QYXtleLSNqrGZzCy3toqswhN1
         an9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270558; x=1702875358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoADJIsaU4bvjYI7gdqH4FQT1qltoRFf88+tkPG8tZk=;
        b=eDwRzNflTngBQ3Rxyd0jtZRVo9BP28v0smu50u8CxHIyK8HqGjDksEqMivn7bZgouI
         XquRpXNN9wlqQPSSZR02LeEeVudeHCzoRw6qQHUQz9wjBuSNnQqiyVoav3F/J8us/6XD
         roPoINi3yuqBvTf+l8mnr+fVgZ8OzBqRRBPpv2fni+LWkWykUNoYLxCqw0kDYtcNUwXF
         NqAPK2BO61zvCQ5FgBmJuaT/wA1QP+wzUkU83RCg2QL1tTxiTSvldZdFVgQKnmRSCDcL
         CkDvVkicy+3Gs7S7DGIRUfeoGSsPvh0kJthSRSxV4/UazzBHYbtFQJoqJ6bfjfMqHYDm
         2pIA==
X-Gm-Message-State: AOJu0YyH53ANrSSkM/xBUOyYzNf383AHqvn2/l+Z/j3UM4sBYwBLa02C
	AHIqZtaHHf6Ejf9vJpGOQdwg+g==
X-Google-Smtp-Source: AGHT+IHW/xB8+qfj2EAC1FWaRV9BV7vEy4h+GdJx19JjFNP+gJ4a3gVBh6F+eeS7FTFAgLsaSJA/jg==
X-Received: by 2002:a17:902:bc84:b0:1d2:e976:bd21 with SMTP id bb4-20020a170902bc8400b001d2e976bd21mr3501188plb.94.1702270558222;
        Sun, 10 Dec 2023 20:55:58 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:57 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
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
Subject: [PATCH v3 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Sun, 10 Dec 2023 20:55:42 -0800
Message-Id: <20231211045543.31741-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211045543.31741-1-khuey@kylehuey.com>
References: <20231211045543.31741-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning zero from a bpf program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 54f6372d2634..d6093fe893c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9541,6 +9541,11 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+#endif
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9590,10 +9595,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-#ifdef CONFIG_BPF_SYSCALL
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-#endif
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
-- 
2.34.1


