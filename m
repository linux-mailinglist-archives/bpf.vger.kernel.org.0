Return-Path: <bpf+bounces-9956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B679F162
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 20:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFCD1C20A5D
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7665D;
	Wed, 13 Sep 2023 18:50:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B2737F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 18:50:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB64170B
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so175471276.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694631000; x=1695235800; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=VC/aUfJSLUD322l8VLNpCyQBoOLkyS/EaUegtC7OA5mGf6zxDGSl/T+jsdBFcXH5UP
         8MueJJnfn/JizBtldwcYxCKzV2JGRQ3vR4q3cUP7TYTQ2YB9DTxLOEX29i8iwOdFc8Gt
         Z57uzqrcRP+Qey81gBp33dFPP2+N0xBZXL1Xe/SpsZp4mOxTEBuBT1OjCQ/26CWnZqp+
         CYg/wGPkzRobbYm9q8ayw6vEG+fA+lcn2T99xuOk08YP8YQBMcSYZfuV1vd9SKMgG1EX
         Ro9YEA+ym66bCKTL4eu80Jvro0rzpbCZByWqWYdyvcVKfrbr57DPCtQyU/ZQn2qebi2J
         RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631000; x=1695235800;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=YKvCmZ2xQwDPES9Wb2O34CgVN3bkzLU9YuyIDXQs9Fz4UjPTvpgCgvgtwn3Fi3kHUv
         s6NjuZiRZZNQHCPAzJmF8Zx/QSeCuuCTaT1+FFLOeVmtAk41SFcPdUGteRzKrlltz8i/
         A3XvANGT1q5KVUgBHaQjmtYhJRZGSr6tjv0kSo7iSN05ob/apGszqIHAvcDRpHUDKnIk
         8kNSoCJ7qLb/nZCBODDaSAiMxPJrcYcqjZ45LJnjaGF677/P9qxzNwQd20DmK+M1tiuT
         3u2EYsOZeDHVxcmYt7Lr1r3hkIYWf6yKovi9j1lZZvGzRlYGfpYM5k3siSsi2ZP8Uw1K
         qwBw==
X-Gm-Message-State: AOJu0Yy6FducFzYnm0TnxIY0Ge/DbrgB1W07k9s0yt3rDrt9s34G009R
	5NTSUy9eiN2kFj9fcit5gznv1VTXE/W0
X-Google-Smtp-Source: AGHT+IGsHx+kaHfl63g3U+7aSP4ap1F2ajOv98JBdUwuZaW3YgiloBSxM9+4YpOZlykSC2AeodbWFKOxMdI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f3b:42d0:4853:6022])
 (user=irogers job=sendgmr) by 2002:a25:6c03:0:b0:d80:2916:c3eb with SMTP id
 h3-20020a256c03000000b00d802916c3ebmr72569ybc.12.1694631000618; Wed, 13 Sep
 2023 11:50:00 -0700 (PDT)
Date: Wed, 13 Sep 2023 11:49:57 -0700
Message-Id: <20230913184957.230076-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf trace: Avoid compile error wrt redefining bool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make part of an existing TODO conditional to avoid the following build
error:
```
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:14: error: cannot combine with previous 'char' declaration specifier
   26 | typedef char bool;
      |              ^
include/stdbool.h:20:14: note: expanded from macro 'bool'
   20 | #define bool _Bool
      |              ^
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:1: error: typedef requires a name [-Werror,-Wmissing-declarations]
   26 | typedef char bool;
      | ^~~~~~~~~~~~~~~~~
2 errors generated.
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 90ce22f9c1a9..939ec769bf4a 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -23,7 +23,9 @@
 #define MAX_CPUS  4096
 
 // FIXME: These should come from system headers
+#ifndef bool
 typedef char bool;
+#endif
 typedef int pid_t;
 typedef long long int __s64;
 typedef __s64 time64_t;
-- 
2.42.0.283.g2d96d420d3-goog


