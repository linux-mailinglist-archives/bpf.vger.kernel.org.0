Return-Path: <bpf+bounces-59563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC4ACCFA6
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA393A5DFC
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868624DCF9;
	Tue,  3 Jun 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKyaMqJe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4A200B99
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988848; cv=none; b=lAI4ApXRc7xI8Zl+UiebPZde8ElNCOvByPXadVs4ZNXt4I+qlEItlKrKb6ioKxxEEbLMXi/xPCGuXWkTGljZpY3fIprf9wR7tIXEPCoWzNHJ/WrgdVIYd6X4zG0zLBhSk1noPTegw7wdlOA2RqxENompkFXR6xDvm6gf+huY8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988848; c=relaxed/simple;
	bh=hduZuFIuqUufg3qRvz7EfqJxi8VCTStcJd48NQA7LAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=OyhC/TVrEPuRcuy0JaIKipdWGd8KFbfgvYAG/tG6/OHoxkilgAianPlMIShGppjhLTobYQ+pMf0SXO4zcXJ6r6QfNziUlDd05H0MTVHp6IPDqvMPaq+KzgSqsHvohpufXlViRgLy9dHrcAZxCmCaPnQBJeQrdoHgM0qGHY2d1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKyaMqJe; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d5723630a2so9906178fac.2
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748988845; x=1749593645; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HBvqis6Gd/BZXWR1PaU818LTftivU69Sy8CHjNdsMnI=;
        b=qKyaMqJeNgIcHz22wWe1EiUZr+tSQlS8BqQhH0AZjZJbcn/rWP8MQjeSVp4dTHGXhG
         11K7DZFGczHUHclij6+8mJWotgMegn9sj/i0x6xzXa5oKd6+qsFz2Fd6AG4nfZjGWW6G
         Kd8kl4rbcKxLk7QagBZqH+ONoEHZpr+4BMzK7Ga5zEjfhLugtAIcH5P9rU83GqqxnfLT
         RTDsRTodoRgS2+yTsTqumj4E/sq/O2j6I7JYstwL2jpkZ/DMLNEw8hb/Eqm+IjkVi+2E
         z2Gh1bg/tNvMB1ko84ecJSBDQsSp0/s+QKamzUUDRGcII/JQVq8jGVDwKYVqhDUeZZVf
         qnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988845; x=1749593645;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBvqis6Gd/BZXWR1PaU818LTftivU69Sy8CHjNdsMnI=;
        b=GHlDj448bRmgEmNKi78ZNWjAu2bLO7Seh4UrGJH3gOoB8cZDTN+Uhxc50RoHvrtQ48
         crfu35e2M7GL3mmowwmtoiuhlD/0FPRtchEtM7aEek7FmxrDUrcxlfw+G3hsmVOcZpYd
         RwyS5l4wXZ1I+0aWCYR5/QZuxU73jURimfeiQyawyL3X5nLao13xYS5w9Vt48Cqw/ZYS
         6ZrJlGhHbep5TDlRkxDVf7mL6huLxMxdQ2rQU/jUeTDfYViDXgVBkDl4y5rATjTyqJFN
         oFeW2ms4OLJnndsECFP7wrHMs9V7ibJTeeJ3E2cIi69vAii+sfwMa2AQAFbLwJXVULaU
         b7vw==
X-Forwarded-Encrypted: i=1; AJvYcCX+MsDjWDok9fr572Ng4dB3DKPxynMbB7khSLr7qkbd2asQYolL1KZw3rpSgIxJz8NjMUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8ICJunSMZl5FQHelToO3R8u2enyv34+dWxa6zhX+QC16o5Xr
	j7NNyq854oMwvY1qGEck4fF/46R44hwKgxccTcEa7RV17EfE+4wJ8hyAw7ywuDGkGhQ2X0Wn+R8
	sfMtpOgUoyQ==
X-Google-Smtp-Source: AGHT+IGQdxlydEspoa/IRPzLHst/hTjDxEHz14OBx3FOg3qc8iUmmhkOkFokPCY6u/UhkfkGLnOX2+IRxdXd
X-Received: from oabhp23.prod.google.com ([2002:a05:6870:9a97:b0:2e8:febf:9eae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:164c:b0:2d5:ba2d:80ed
 with SMTP id 586e51a60fabf-2e9bf40e7fbmr293777fac.25.1748988845743; Tue, 03
 Jun 2025 15:14:05 -0700 (PDT)
Date: Tue,  3 Jun 2025 15:13:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603221358.2562167-1-irogers@google.com>
Subject: [PATCH v1] tools/build: Remove some unused libbpf pre-1.0 feature
 test logic
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Ian Rogers <irogers@google.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Quentin Monnet <qmo@kernel.org>, James Clark <james.clark@linaro.org>, 
	Tomas Glozar <tglozar@redhat.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>, 
	Yang Jihong <yangjihong@bytedance.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 76a97cf2e169 ("perf build: Remove libbpf pre-1.0 feature
tests") removed the libbpf feature test logic used by perf in favor of
using LIBBPF_MAJOR_VERSION. Remove some build targets that should have
been removed as part of that clean up.

Fixes: 76a97cf2e169 ("perf build: Remove libbpf pre-1.0 feature tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature |  6 ------
 tools/build/feature/Makefile | 21 ---------------------
 2 files changed, 27 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1f44ca677ad3..05f6671a2d07 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -127,12 +127,6 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
-         libbpf-btf__load_from_kernel_by_id \
-         libbpf-bpf_prog_load           \
-         libbpf-bpf_object__next_program \
-         libbpf-bpf_object__next_map    \
-         libbpf-bpf_program__set_insns  \
-         libbpf-bpf_create_map		\
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b8b5fb183dd4..4aa166d3eab6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -339,27 +339,6 @@ $(OUTPUT)test-bpf.bin:
 $(OUTPUT)test-libbpf.bin:
 	$(BUILD) -lbpf
 
-$(OUTPUT)test-libbpf-btf__load_from_kernel_by_id.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-bpf_prog_load.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-bpf_map_create.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-bpf_object__next_program.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-bpf_object__next_map.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-bpf_program__set_insns.bin:
-	$(BUILD) -lbpf
-
-$(OUTPUT)test-libbpf-btf__raw_data.bin:
-	$(BUILD) -lbpf
-
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
-- 
2.49.0.1204.g71687c7c1d-goog


