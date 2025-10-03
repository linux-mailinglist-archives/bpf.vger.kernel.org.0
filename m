Return-Path: <bpf+bounces-70267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7FBB5BB9
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 03:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C21E4E35E2
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65D27B332;
	Fri,  3 Oct 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVBHv3gA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56E274B23
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454647; cv=none; b=Jr3+72cx7mEnpB4E9FMM9n0YyJhWGLVnvDQh/WxTvxd6usG/knUchWZVg44QAsmAa4yc4NBTTzuwkXSjAwIKUitviVO4w3lfMV3w7+/7/gFnOhacYoczYxWRGOGf7NyUkFo8U+g7HxbWIC5EA1V6wfiSdUG98u3HF5EI0fLNTUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454647; c=relaxed/simple;
	bh=kUOXFIeRSqDtSv2ZkPiFOO36c2y12fUPmamNdNMIsfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fBXH+BOLvv6PrRyvxHpd21ymP0/Ts3YJpKEm+sWNLTu3XzcTKuUwG1saUj9ZQCRS36CJSjonzI4DY4cidve7Gtz3NMOOVbJFKcO/A+Pbq0Z4UH3F0e/WwedXlI5C0+ou7QwYoF03VnJd39IUULEly7IzEhAWCg0gTJaQOk6LG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVBHv3gA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27ee41e062cso19623165ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454640; x=1760059440; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=UVBHv3gAg1rd9c5sckDrLg/yS2Z6lgfm9nmrQzvl30np4Yi4eQN9V5XnW38TDU0k/T
         O3wdrneRM3nIJaUtmlENcBH1vHMJsnQ8zwBCYBXgf/dwZkZjjjgXOcQ3TTZa2J0qYvtg
         ijav5ZNxEKCQr/JHzPbz92PFGRB9KOjIJkFpu1hipN6/sBaUjN52FZwTbQ/hexe6k8CP
         fsWTgrk2xHZMqOBf71oxCnD6SNrp4HUpM9++2b8JR4DVkQM2UsYfn29S0Xh4DWdruLr3
         2GKhF8P48m4Jpqw9IJSeLKog3ZflSCueLg6vXrXGaruoVdWjCweHFAAM2vJFB4zkKTO7
         lnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454640; x=1760059440;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=RlfdgHt8AcHvIltXctqu/OlbQHR96d9gGRnpagFqcU9Z8HpOw3zO36x6qI6tIHn9tC
         wcm8TrLsck4PMV1xapWEHHO0Gj4HpdajpzMpKH+Z2/FtEkOtdRsdHkrm7YnhnvK190IH
         scAVIz/KdS9EhWPgLHPMBivK7UbLVbVyGgrzJ9tUOsm8njDqmqrqVcFsRE/U5yDsg7aV
         IIpdzUR2YuCuIoFXXfaB1P1eQFstO/q8C4FTIpRX9/t8ey6adhvS0kblETT9Rue6sgnt
         dgib1TuDCa18Ua3LSlo4ZiKzrRo1qhyLks03PydMtigSnvVakxCKD1PJYGOjss5gL3Ym
         eToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB0QXG5IOis/VFVa/RuJ7y1cHC7ime/T2dj4OA3QSFEZMUfuxtgOLvbLS5W3/BlPAQb08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcS9eA5CyjmLkYizZJ4/7SVP5acwVc4A/4k/82fnzcUCi1H2X
	MK9MgjLaDxhVt6naqOf/3NEVniQswuvu6MmCn++YZiIBag6600sbhpmYJ+n5KqW1e8FWZ9UsT5P
	jdrdqJ1ymow==
X-Google-Smtp-Source: AGHT+IFY9UEJwnhtwJqOYlJ+khMMlSHN/ze27dGvQJuRPcqqkdwyu6/B38lIGuCrw1Ue1guMSz5HzG4uq6lR
X-Received: from plev16.prod.google.com ([2002:a17:903:31d0:b0:267:e964:bc69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2405:b0:264:a34c:c6d
 with SMTP id d9443c01a7336-28e9a6a90c6mr13499045ad.37.1759454640628; Thu, 02
 Oct 2025 18:24:00 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf bpf-event: Use libbpf version rather than feature check
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature check guarded the -DHAVE_LIBBPF_STRINGS_SUPPORT is
unnecessary as it is sufficient and easier to use the
LIBBPF_CURRENT_VERSION_GEQ macro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 7 -------
 tools/perf/builtin-check.c  | 1 +
 tools/perf/util/bpf-event.c | 2 --
 tools/perf/util/bpf-utils.h | 5 +++++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6cdb96576cb8..b0e15721c5a5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -596,13 +596,6 @@ ifndef NO_LIBELF
 	  LIBBPF_INCLUDE = $(LIBBPF_DIR)/..
         endif
       endif
-
-      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
-      $(call feature_check,libbpf-strings)
-      ifeq ($(feature-libbpf-strings), 1)
-        $(call detected,CONFIG_LIBBPF_STRINGS)
-        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
-      endif
     endif
   endif # NO_LIBBPF
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 7fd054760e47..8c0668911fb1 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "color.h"
+#include "util/bpf-utils.h"
 #include "util/debug.h"
 #include "util/header.h"
 #include <tools/config.h>
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 59f84aef91b4..2298cd396c42 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -288,9 +288,7 @@ static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
 		.sz = sizeof(struct btf_dump_type_data_opts),
 		.skip_names = 1,
 		.compact = 1,
-#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 		.emit_strings = 1,
-#endif
 	};
 	struct btf_dump *d;
 	size_t btf_size;
diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
index eafc43b8731f..a8bc1a232968 100644
--- a/tools/perf/util/bpf-utils.h
+++ b/tools/perf/util/bpf-utils.h
@@ -14,6 +14,11 @@
        (LIBBPF_MAJOR_VERSION > (major) ||                              \
         (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
 
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
+// libbpf 1.7+ support the btf_dump_type_data_opts.emit_strings option.
+#define HAVE_LIBBPF_STRINGS_SUPPORT 1
+#endif
+
 /*
  * Get bpf_prog_info in continuous memory
  *
-- 
2.51.0.618.g983fd99d29-goog


