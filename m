Return-Path: <bpf+bounces-70268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1451BB5BBF
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 03:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4C94C061A
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227E27E056;
	Fri,  3 Oct 2025 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdygujaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C6274B5D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454649; cv=none; b=ItgorcppAxGWKSEdY4DSNkQGMNu/2g9D519/hHGBNkthI9f595wDOYBDb6nOqiTHay/lPunJHQzJz440Xg+qmtzdKwRYDSj4RA0HXsMt3n/e81VQ2eVssPdJ/7K8AJGlAO0Bq/bC2iKPGLxSFT21ZruVOUbHIUPzmA8N+8bKe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454649; c=relaxed/simple;
	bh=5YQj5whNsy944Tq1nsPgEs2SC3r0ANA3hsB9j366qHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IDzO5oBW3ay+Biet5jjlZk+sifi4A1upbEw+MSsD0LezVbSNHXsMKu+Rr4WNKDSbKkZEBisNdJNpx4sM7sV1h3DBMrM0jyg13J25gUd6lkvDvU9VWpYJ26AnOiiOX5c7JtnONM5AjPQMbPIZcIHBrpPQmPas9w2wXxo7/ybJ8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdygujaT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso2404494a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454643; x=1760059443; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=RdygujaTfvghY5aIrVszsg0i07xaYCGZ4tm89wKO89C4R9j9a54A7fJumfv++d/y6G
         2ghPPmp922lzXOcVBmxbOeu6LzoviFthD/Whysjv/CKa9oGHHesWpbtNvZkhqZLsTifA
         pGvT5QnynywUsl63+MM7n8oqeugrwzS8Wma5HtKGd/2Fw/LmwW9h2uLxvj7kQZwDx88k
         K2G26JCbuPbVu6sHQOH7gPf02ZwPU2mUUH/CPkvSN24lhwN9ttjlz/m7ENjwaWEE8i8K
         g8c0A2bSaaK20ugkeLfDJ4SXoxy5YHKaDCuBdsLnKcnHve/fDwpnRk3UamqP8fvCuzuf
         lr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454643; x=1760059443;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=tOqvR++/HmODsXqyX8IjsRj9VfiFna7irekd9tjI25XnYP03uDWqLa3i3uolGuJKpa
         Z+qTHfjnXdDG5u73c1Y4EFpVKhur1UsgPEAn1p/IjDVNVjD275ps6AlSGoTm6CvrJHGh
         HhpOOJ+dQ5cpxVOZkYaC0Vj9DWo/SqlzlfY75d2TfxYAriwDuRC0NEbvWbl1jcVCsYGd
         O0BD31ce55XWb7ncKNmfcM9QWqDqp9YW/DvTqmaD+bQuQAhhboV9H9ZxEJg1s1iLFhFG
         Y7gPb+awiqcFxS/RZ45W7KG3TFD8oCMSNZ1GiDBt7z2Mf4fx/elbj5YRqFi1ChvXcVe4
         EoMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOK39ZUvL23x+fzI+itA0MquhjV7N6Fdp6aWSxTAi+Psx4S6MwDWdy2TEbEjxPbu1eyL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjse9HASkfjnyrLkI9OQMwQDyzGm6/VycmvO/M26NNUA4I7NS7
	985VJJyfRI36krUD1w0VCX/yybmeY+PizFPkCdensPm1siwjn2jO2VZv11wmm+iQGPmLyLWohAQ
	q79d0m6mDkQ==
X-Google-Smtp-Source: AGHT+IHfyZpoMDCQT8hkrc//s6nFD45TPZ427CL0dAfY14RayEbEgz2tiGZWsZyPld8miWOzUhmcMlj6XJBu
X-Received: from pjsk12.prod.google.com ([2002:a17:90a:62cc:b0:330:49f5:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:32e:32f8:bf9f
 with SMTP id 98e67ed59e1d1-339c27d2ec8mr1417437a91.30.1759454642812; Thu, 02
 Oct 2025 18:24:02 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:49 -0700
In-Reply-To: <20251003012349.2396685-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003012349.2396685-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-2-irogers@google.com>
Subject: [PATCH v1 2/2] tools build: Remove libbpf-strings feature test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature test is unnecessary as the LIBBPF_CURRENT_VERSION_GEQ(1,7)
macro can be used instead. The only use was in perf and this is now
removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              |  1 -
 tools/build/feature/Makefile              |  4 ----
 tools/build/feature/test-libbpf-strings.c | 10 ----------
 3 files changed, 15 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-strings.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9399f591bd69..f9477df18841 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -124,7 +124,6 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
-         libbpf-strings                 \
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d13d2a1f44fe..fd304dc2aafd 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -57,7 +57,6 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
-         test-libbpf-strings.bin                \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -332,9 +331,6 @@ $(OUTPUT)test-bpf.bin:
 $(OUTPUT)test-libbpf.bin:
 	$(BUILD) -lbpf
 
-$(OUTPUT)test-libbpf-strings.bin:
-	$(BUILD)
-
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
deleted file mode 100644
index 83e6c45f5c85..000000000000
--- a/tools/build/feature/test-libbpf-strings.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/btf.h>
-
-int main(void)
-{
-	struct btf_dump_type_data_opts opts;
-
-	opts.emit_strings = 0;
-	return opts.emit_strings;
-}
-- 
2.51.0.618.g983fd99d29-goog


