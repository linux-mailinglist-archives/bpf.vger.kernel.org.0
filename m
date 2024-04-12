Return-Path: <bpf+bounces-26604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6FB8A236D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D298D1C21BD3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5661B977;
	Fri, 12 Apr 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="CCl9p0GX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B4DDC3
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886659; cv=none; b=GNpOFDQ+lZc/+LAbAkDJUFEvO2IRP8qTcp9lzpN6WQQFrJPIK/r96lZOb5gmPoMYzmBk8thQlZV9VsQITfcfbqsJjP/t7mthXhAIZvYmCXfG7uF2bzwJgrrvKNkkOKbtsshsEb80OQEn22iIPM/C65gGQep7XbiktbDiS2qj9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886659; c=relaxed/simple;
	bh=AdlygNz0RFZef1mcIWoB8it1jPVZwP5sUo9GIGfOMoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmf9q9oqIB0XmYnVnbRlH0pElKfbnwk8nW2BHNmZJsfos5L7mJkiLikM9pKyohVl2kIL+a+5Hg4+SLxID9Wbr3EG79Cvz3QpnXomTvOZ2O17G9/JRPGJlS2fo8eqNI4O5JZduyJDp7s0KpOzmolIunEXrbcvdxTaxO5wPJgt3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=CCl9p0GX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6181b9dc647so4605357b3.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886657; x=1713491457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W3XOu1JzCFnI8d0V7+Yp4cwFPdA5VsCmQsQwSODsxU=;
        b=CCl9p0GXVhmMlklK1/QoFpwlvhnnwH9VJ6mihBgzv9ai+0wV+zdgyYF5DDcwfVvZ0A
         NpAeMCJ5pzQDBeMCHLV+0RSIyNcdBBLSlWajhj8zmISfuWrCP/6eJbLx0NlvF4o+Vu/5
         QJvaBVvfdXhfmvj2FBV7mONS8Pr0sxnKTRr1zdEpruDXSTIGTG+FS9BRCePljkO1+shF
         JxeBCMBF+8/FBc5e9LoLcpFnwUanMDBr7bFwUvABXtPlt9gt/LzxWUbpy5dhr+GjWMcc
         KLp0vUJeh4MtKQWg8Yhfa7JeaUt4OmhD+gmfZW6AJsmST2OSMn6sIct5UVZEu+MuGXLl
         9hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886657; x=1713491457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W3XOu1JzCFnI8d0V7+Yp4cwFPdA5VsCmQsQwSODsxU=;
        b=umRwob/bmRuwy7gRmJSe7wI22YoqNLJGH80m/If3M89VmxYL+M0O7mRF/g4WXjuFcO
         /HTR0Pe5v3oDm/aAyH3BOsa/urCjiIm0aRsNPthdoYvazvnnSTGPwcf/js8yy2eDpjaS
         r16prrdDoKGsi7KdA90UwhvN0YJ9Se7HZblazDxZ6Udwr6zj5ljPQb0zXSpfrQTx+TpL
         UPSKl7iyB9xwdxRsipnigFfgRX52SJbYPLMAimkpisaW+dq2cxP00QHroUZo+Z+kIGjy
         aR7wOWGReUjQQkYZShRWjhmDW8qVEOzmO/8jMOkaqUr32MjsT1FqbyE2T8x9ZseSwYE/
         TwGA==
X-Forwarded-Encrypted: i=1; AJvYcCVdTBd2QO0JMke5+x/D5aPrBcpiB/a+KCHmqRApRIhs137b/eQ6MULKK9QhNnxZHnEz5hzHLbiXgvNg0ZE7c1bAIBUb
X-Gm-Message-State: AOJu0YwVBjF+NgDJN8CnP50HZyTuJ/6Lrau/ysAKMgMDHu1LJwAXf43F
	77QwfFT51yLB7XY+lt9L9aR1WA4hH0BWn4g+xRjKTJGQX1yCG9rM5VIcyMt4Kw==
X-Google-Smtp-Source: AGHT+IHjXR7BfIecARc6VI1pATfh8TR/3Pi2gT4lAF8cWX7oY3B82GGlWqZk5F7vE4hcCX37K6VYow==
X-Received: by 2002:a81:af54:0:b0:611:5ff6:2608 with SMTP id x20-20020a81af54000000b006115ff62608mr1280098ywj.28.1712886656935;
        Thu, 11 Apr 2024 18:50:56 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:56 -0700 (PDT)
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
Subject: [PATCH v6 6/7] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Thu, 11 Apr 2024 18:50:18 -0700
Message-Id: <20240412015019.7060-7-khuey@kylehuey.com>
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

Returning zero from a bpf program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd601d509cea..cd88d1e89eb8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9658,6 +9658,9 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9707,8 +9710,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
-- 
2.34.1


