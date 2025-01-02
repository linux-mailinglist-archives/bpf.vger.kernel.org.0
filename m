Return-Path: <bpf+bounces-47779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C399FFFDE
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17821883B96
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E21B85D7;
	Thu,  2 Jan 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK8kgQxx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637F8F58;
	Thu,  2 Jan 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848769; cv=none; b=sKfTbodAEPJgW8d89+ol/cHe4GjJMDKNDpu6uEAqT4ifFCgI0iz5fLxV8m3R9n5o3Y4LhAi9xczmYWAUZhBGd1YCL2B4bDidgtxAIrrANxZ99rCqnRJ45a58R4gUHyXjK70WhYa71TZYcuPduJOVPeYSV1wOLCPASWMKGU9I1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848769; c=relaxed/simple;
	bh=PLSDniRM82tmCmRg85NU+TFh6CVI2zI4E4JV+gUrEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDKhgjrCpKluIF+KzI8ChB+ZYsznpT+cnOqbz5NPb6RdW00UkbClMaVrr38sbekBmBbRJpRIqDL/6YIQx3fr5mps+L+Hb2a7CGCqSRZvxpsWlGpMmPfO61nDWpGTOxIjj7RqYsyMVv6DJlzt4mxP2kq+2c2aLOtyrGIyGNbLu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK8kgQxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C28C4CED0;
	Thu,  2 Jan 2025 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735848769;
	bh=PLSDniRM82tmCmRg85NU+TFh6CVI2zI4E4JV+gUrEM0=;
	h=From:To:Cc:Subject:Date:From;
	b=bK8kgQxx3YPfnFUiQhc91bTkFtkGDgCaLx/1LVN63njXQ2Uzxy3xRpnlrZEH8DU0+
	 b/Vtj1kJ6B+2pEftJsaxYrDnmW9YyHoD9cDy54opzdvLvRSabXy8zwqMYQjSx9y521
	 oT+qi1YhnCZ9leaB6JrckNRmYvosDnwj5D3SBYVcIF8Tb+Jehg43iPtOFmZ7J7CYt9
	 lwMDgjcZdkuWjHzCwURWFEYYNRdN7qovVQcqlkd0Kh1odz0P4AzzIpjE7thkGNy99E
	 WwsMydxDZrpPR2/JO1fGQowNICB0uJiftUDYX5xomnLjjFZyIbbOHmp4fO5Ufwk9Em
	 4Gb33FhSbDSkw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Fix unaligned access for augmented args
Date: Thu,  2 Jan 2025 12:12:47 -0800
Message-ID: <20250102201248.790841-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some version of compilers reported unaligned accesses in perf trace when
undefined-behavior sanitizer is on.  I found that it uses raw data in the
sample directly and assuming it's properly aligned.

Unlike other sample fields, the raw data is not 8-byte aligned because
there's a size field (u32) before the actual data.  So I added a static
buffer in syscall__augmented_args() and return it instead.  This is not
ideal but should work well as perf trace is single-threaded.

A better approach would be aligning the raw data by adding a 4-byte data
before the augmented args but I'm afraid it'd break the backward
compatibility.

Closes: https://lore.kernel.org/r/Z2STgyD1p456Qqhg@google.com
Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e70e634fbfaf33f5..3f06411514c5b58a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2582,7 +2582,6 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 
 static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
 {
-	void *augmented_args = NULL;
 	/*
 	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
 	 * and there we get all 6 syscall args plus the tracepoint common fields
@@ -2600,10 +2599,24 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	int args_size = raw_augmented_args_size ?: sc->args_size;
 
 	*augmented_args_size = sample->raw_size - args_size;
-	if (*augmented_args_size > 0)
-		augmented_args = sample->raw_data + args_size;
+	if (*augmented_args_size > 0) {
+		static uintptr_t argbuf[1024]; /* assuming single-threaded */
+
+		if ((size_t)(*augmented_args_size) > sizeof(argbuf))
+			return NULL;
+
+		/*
+		 * The perf ring-buffer is 8-byte aligned but sample->raw_data
+		 * is not because it's preceded by u32 size.  Later, beautifier
+		 * will use the augmented args with stricter alignments like in
+		 * some struct.  To make sure it's aligned, let's copy the args
+		 * into a static buffer as it's single-threaded for now.
+		 */
+		memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
 
-	return augmented_args;
+		return argbuf;
+	}
+	return NULL;
 }
 
 static void syscall__exit(struct syscall *sc)
-- 
2.47.1.613.gc27f4b7a9f-goog


