Return-Path: <bpf+bounces-64425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33145B12831
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E530EAE27D9
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BA155C97;
	Sat, 26 Jul 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMy1RK62"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2415139579
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490429; cv=none; b=sV2lB5ZVcXbb79cottil5aEoMLZSKJqDaMx56ZvxglDx0d6yaS1m2BL+75w3vK+jJrEwVS68DCJx6M5uSexdghC/aXuy7SaCly7aGmUt1uzZVJApFw0Qe6WWPMpfyto3Ay/L97UvIPLx054qKCnI4xPXS7g8Bx05ImXBa7bTqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490429; c=relaxed/simple;
	bh=n8D/edGFZL/hgNbZYwUtmezqHxp9oRlZEQVwjzRgobQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjVPjLlKJ6p4yvtJE63uxK3A/SFUGkEZA12WAqr1/VTohDP4XRAjqtxN7AQO2ImJcMbDDnmDJATO/LolhF1OZiXthOUvzS58S3iBgoYkiSnO73ApvqW0dF4KnD+r7FBK7M4+dPQyiSEwy8Ly0dTSsHCSGgY77BM78o1S/OT2920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMy1RK62; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7492da755a1so2363719b3a.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490427; x=1754095227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=DMy1RK62tQPnRAgekk7WhgdtAX1l/XVigu2kmRxQCUGSpm6RU2e7WRRjsruS/swRy7
         l++hEVQ1NhI2AuMJBoeahRo/tQsLXHcjjSbs3tahT6myVe5gkxfabWdYLIMiY2QyZIbx
         HHlmA2oYBRafDPaOH6i6B6S+oKTJPnt9obQxrJOGOP/roqOZManW5E5mZyuzYa08TN96
         0QDJl5raj8JbglyqAWlb3RxzB4IIRBOCH+X6/CTUmwMRUWT8+mOQUOclFXDkpF4jHomU
         m7+z34z/SsEwFciZ/Czo4Wu1KVteVaNk/5Q6JDIzk9tPpKOZn3TzAkUDLXM1Vu271/ur
         QTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490427; x=1754095227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=owzb37xmlKybITXf+Vy4ICcbkh2PsA4GiM9dd7q1mtNNzgoLz+phk9o2e17wrTWzj2
         V728d4EqVrDraXpiTeA6MP4RbXbNBuhXr+dtHpcX2PUUoGEGryhx1JR8ajPdX03YcDVH
         StMu4mzsW/1nLGCTPANHVkm5lMfUjrG9BcrDZvyFoocpp9xgKw+dGXTAp+vFRWmBgR7o
         6fsH4U3JOz3/HY/hBX0Iu67yiGGeVeovC8yPjoXy/dgZG8JrU+5c8coTVxpMF40nUFmm
         z035PjKn+BuGtYYwCbaDRonIqXHS4Id1ZRcWupasdrJF53/zyq5Wi9zyPFLZ2rrSeaDe
         Pvug==
X-Forwarded-Encrypted: i=1; AJvYcCW0H56g/bgehL3tML0126/31tsCYAGHVjfc4czCEBR8W6ImJckA/KOwxk/jNE+C3AoAhZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3Zb2cyGw4EFfROlqB7QJ1BW3rsqjg5cX1RF6/zIRjRu1FJHw
	OR0jFnaQrnDPUBUn71IiOC0ODJnXKuD1tUJZ9Bv9qXlgP5hNLuHj1jUTYNIzG5PCD1v1sfvaWCX
	3eBi0vosulVPgsD4DDE8e1w==
X-Google-Smtp-Source: AGHT+IGSoo8WdGl+OGvbRnbs0+/8TM4wBhGm55waZ4GSl0VDmPb7RoWgx3X4IQSiC2YjsJugCZwIw0DRLCTKodF2
X-Received: from pfau2.prod.google.com ([2002:a05:6a00:aa82:b0:748:34d:6d4f])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1953:b0:748:2cbb:be45 with SMTP id d2e1a72fcca58-7633583028dmr5161224b3a.15.1753490427032;
 Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:40:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250726004023.3466563-1-blakejones@google.com>
Subject: [PATCH] Fix comment ordering.
From: Blake Jones <blakejones@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
BPF metadata collection") overlooked a behavior of "perf test list",
causing it to print "SPDX-License-Identifier: GPL-2.0" as a description for
that test. This reorders the comments to fix that issue.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
index bc9aef161664..69e3c2055134 100755
--- a/tools/perf/tests/shell/test_bpf_metadata.sh
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# BPF metadata collection test
 #
-# BPF metadata collection test.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
-- 
2.50.1.470.g6ba607880d-goog


