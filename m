Return-Path: <bpf+bounces-34721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025999303B4
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 06:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B651B20CB4
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C218B04;
	Sat, 13 Jul 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="KktqahKy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9214F70
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720846011; cv=none; b=lVDDZINK08uZ58j/Ur6CHLsUvH7ljhLO1qDSJPA98PM5Ai+aSwDms/QDOcSFkP4vps81c9KTcy8LBD4Cy4XYl7RaAup7cJS+VuQzLGYIzxanCjVc5HCfotXoE6g0CocpO06UiQjd9jl01Si+Z53PhXzVGK9o8G62KY7V5r8sMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720846011; c=relaxed/simple;
	bh=yUxMoYz4CCDjOmOdnVZWwLqFwaeOCI07PUXn35dv/H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tomaOASIUZi0V5KreBj6NQXweyI29bI4lMIdewOKqP26ubxgy0BDwmzqkNJ97L67SsfQYauu3ayM8Ad9W1lPEr8+jWXejb0qOR3czNaQpwiAYveeGLC3FRx5cXIro98T7/teKyEODsnTYKk2lY79lFe68xq0TxMkl+QPQPpHjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=KktqahKy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b04cb28acso2198343b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720846009; x=1721450809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ngGA87gIu2gLDykLQmgpZcotEbcUqXtVAAfGqFOqSg=;
        b=KktqahKykDOhA8ys/nhVmRxeZsWTLVnwtlMlc1VRXgSE/OWILKYlPRdGoGuBDxZr2M
         Nuuk8v2JzNt9xXxCenlsKMk0OwQOwaBD1M4JPB0OxnzTQ2JhgKbbpwEA3UsW4vKvrbqV
         XOkTlo3imNaKk5eaZKFT+351TmzDHYDO9/esRg/5/EV9UfKiRjnnK7wIHF1CrgSa1Kht
         556sHC53o5UJ4s6ydVHef+8cVZNLrqf7C5fvUPchwBmrK1+FXFZYgh9Q0AIkuEtjnZrj
         JG8hS7F0aDg7JmPH8Y2XdMfmx+Px2e2qokv66q5sOb8XtW/mUzFHNSCA9RDt+BaZ5kop
         QeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720846009; x=1721450809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ngGA87gIu2gLDykLQmgpZcotEbcUqXtVAAfGqFOqSg=;
        b=j9J3Pm07ozbxhzx2RpGIsmlrAC5HOy6rAjIDqqY9PtEfJ5RiwJdkRUWMSr4RZdcj1v
         1a5hSKgR5W8JBaileGZfNo4KWDXOLqJIjhjw8uEhraEcvM7BbQLEfOWrMSnFRks279kL
         /dcG5ocD5ml6pe15txyDuBpbASfEGNlM4HTE7NE3I2jABJFaHlnF3LacitbhpAmdm0Ka
         KmMVcEv5IUlkw0dNhH1j0/IgioylI9IOEYG+rHVFNXK5ottweO3+g/Y6WUYZsaoGtpHi
         CsNhZKsfahIHkpjXSZYWLFh71qG0Y6znUmnMHScnULF+zYH3dQsw7Je/p/JVa+ep72cc
         Fpqw==
X-Forwarded-Encrypted: i=1; AJvYcCUJgNeDPrxjF4SOSnXet1a/JHxm/TfQCjHJBa//4jYysEhqaY6vtQ7DoZqRLINyeLe1xfgSrl6J1x0UOpTQ+PgJd5ef
X-Gm-Message-State: AOJu0YwW4FjMiJX5kH4ikkCbk/Ps78xqxZEKLxx+cS+wtDuMEc1TwRF9
	/TGbVN81u0CB4gEIPJ1c6jKGaZXJondOuB8Ua7x6t8Ke12WD/VQ/n9BQwQMQrQ==
X-Google-Smtp-Source: AGHT+IG1InLizyBK8JWHNbJkRYA6Uea0HmsPCa6bhoVt3VeiBs0iiTknfl+THoAD5GvgweS3VdZrJw==
X-Received: by 2002:a05:6a00:4b51:b0:706:3d61:4b21 with SMTP id d2e1a72fcca58-70b6cae4c6amr6823942b3a.3.1720846008948;
        Fri, 12 Jul 2024 21:46:48 -0700 (PDT)
Received: from zhadum.home.kylehuey.com (c-71-202-124-49.hsd1.ca.comcast.net. [71.202.124.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7c5f3sm383461b3a.107.2024.07.12.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 21:46:48 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: robert@ocallahan.org,
	Joe Damato <jdamato@fastly.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
Date: Fri, 12 Jul 2024 21:46:45 -0700
Message-Id: <20240713044645.10840-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regressing commit is new in 6.10. It assumed that anytime event->prog
is set bpf_overflow_handler() should be invoked to execute the attached bpf
program. This assumption is false for tracing events, and as a result the
regressing commit broke bpftrace by invoking the bpf handler with garbage
inputs on overflow.

Prior to the regression the overflow handlers formed a chain (of length 0,
1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
(the tracing case) did not. Both set event->prog. The chain of overflow
handlers was replaced by a single overflow handler slot and a fixed call to
bpf_overflow_handler() when appropriate. This modifies the condition there
to include !perf_event_is_tracing(), restoring the previous behavior and
fixing bpftrace.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reported-by: Joe Damato <jdamato@fastly.com>
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
Tested-by: Kyle Huey <khuey@kylehuey.com> # bpf overflow handlers
---
 kernel/events/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..f0d7119585dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9666,6 +9666,8 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
  * Generic event overflow handling, sampling.
  */
 
+static bool perf_event_is_tracing(struct perf_event *event);
+
 static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
@@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog &&
+	    !perf_event_is_tracing(event) &&
+	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
@@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *event)
 
 #else
 
+static inline bool perf_event_is_tracing(struct perf_event *event)
+{
+	return false;
+}
+
 static inline void perf_tp_register(void)
 {
 }
-- 
2.34.1


