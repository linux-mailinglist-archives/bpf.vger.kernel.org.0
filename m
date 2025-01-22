Return-Path: <bpf+bounces-49452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F902A18BFC
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0693ACA58
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75CE1C232B;
	Wed, 22 Jan 2025 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANiKYH4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C791BBBD0
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527130; cv=none; b=jbztvYW03nM9vSbz/uFfKoUg9b5b3rgjS5erwjSTrf+B0EJiYNCnUF9t1fBQZnYwDXeY2Og24ZBk/Dyn+/iilGLlbjCZVK5X4NoY1PlD3W9isyjMftqRRyypSggzye8jZ0qGy9QK6vAidUNKMcyYtF+XV0IM0IUQ5LUv3202E7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527130; c=relaxed/simple;
	bh=Lzob+NuJy06upC4gEoA3ss329xpU9HN0aFks4gS31oA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nsa0ej8MmBhFkgkHD0oUDSy0ErwL+o/WJ2OawVDnb2mrIvivuifuP1/IhQ58hlVWcO+GZTO8p91zaRAzyyaasZ2fY+ME0gUimniCOT0Io4DFaZj2e/KxbO7TxPqp81UV0WKdjQytrgSmCyPiNFciEqMSXNBf2St7cSH5OghMrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANiKYH4z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a1bc0c875so14135569276.2
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527128; x=1738131928; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/etQtMYVd4NbKTRYWQL1OC8HOEVmkVBi2gOIQvu8y4k=;
        b=ANiKYH4ztvhhrEYCm6bUvWLFDnu25QEwpZjA1wJhoeHTw7GNA6kpy4S1P+WXT2dCBh
         ENtefrel0vuqlbk+uquRzDWuqnn00JIiaAE2LZNTPPW/0O8zRCLUh6O9mcGg0t/jXNx8
         eTyuSQcSMXfqpIOwk9KI9VO1LtQRiZvBaW1iemEX3PtyWWl1BuxbEcMZ/+gpmPwUQTUG
         BEP3TbvnFoT+0W8TmOvOh2UVpRjyzu5o4jQ3jKo1r8GxA75xBx47Fs4+0ohfCvB/8WvT
         SphYD4L3196ffGlTtZ6R/kXPpKPWdcLpTM+xR0VITgQ8ez2nUAdH9+FbKPbnMUmo9+5J
         ExTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527128; x=1738131928;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/etQtMYVd4NbKTRYWQL1OC8HOEVmkVBi2gOIQvu8y4k=;
        b=FHSWmxtgjOIE+Oy+x18tRhkjBzl0ecy1r+9Fg29PSqjk96H8QPk4TUnaF4xSE3HLVw
         F9ndEhfdMuJw42+t4ztXeqDzeZlqJHz0fun/6zTR6mOjJlFm+ZDTaJmVcrAaMKtnA5Zr
         6q9ayP7lj4PRS1b4KmF6CxOmU3qSPCOXMCXitvRmpb0pzP73IbPq4WKSPOE8ZW2f3jyL
         gzb9RRBqtAXHgVKady/Myy36olBsRCKJJaix3Xq/mL+jEwW2ljK/liu/2SSo6ICAy4Au
         6IA7kTOSgGiyGeGAvdyjE3tW6JA2CU8k6G9he0cSnoyVWLtXdGXXk3Hj7CioM/WrSZAN
         w+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWUKtqjMkWBnW131ha2S9/tV48Sq2r3cozDI12YtQ/S/rH+7ewsqjrH5AUeu4DTmaKde3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2os8ZDgU8Sfec4wJV7yIoEiF1ilv91IUiXSS0wePTb3eHdwzo
	1BnUQk+WaIhQp8/skY5AHO7AYm57mkArp8HTuA0sI/1rfwHFVZ5vGr1SobN64N4dVLJpt640JE4
	dR5LQzA==
X-Google-Smtp-Source: AGHT+IH6D33Da/yJv7XvymX6q4uMCft9Y3ZBUbwM3+o4/Q+cURxwz6r2bb7aP9Xyo1liFmfBDPf1zpaiIvA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:33c4:0:b0:e58:228:d611 with SMTP id
 3f1490d57ef6-e580228d824mr11847276.8.1737527127476; Tue, 21 Jan 2025 22:25:27
 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:27 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 12/17] perf dso: Clean up read_symbol error handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure errno is set and return to caller for error handling. Unusually
for perf the value isn't negated as expected by
symbol__strerror_disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c |  3 ++-
 tools/perf/util/dso.c      | 14 ++++++++++++--
 tools/perf/util/llvm.c     |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index f103988184c8..032548828925 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -12,6 +12,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
@@ -463,7 +464,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a90799bed230..247e59605f26 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1697,6 +1697,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		pr_debug("No BPF image disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -1715,6 +1716,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		assert(len <= info_linear->info.jited_prog_len);
 #else
 		pr_debug("No BPF program disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 #endif
 	} else {
@@ -1725,26 +1727,34 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			.ip = start,
 		};
 		u8 *code_buf = NULL;
+		int saved_errno;
 
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		fd = open(symfs_filename, O_RDONLY);
+		saved_errno = errno;
 		nsinfo__mountns_exit(&nsc);
-		if (fd < 0)
+		if (fd < 0) {
+			errno = saved_errno;
 			return NULL;
+		}
 
-		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) <= 0) {
 			close(fd);
+			errno = ENOENT;
 			return NULL;
 		}
 		buf = code_buf = malloc(len);
 		if (buf == NULL) {
 			close(fd);
+			errno = ENOMEM;
 			return NULL;
 		}
 		count = pread(fd, code_buf, len, data.offset);
+		saved_errno = errno;
 		close(fd);
 		if ((u64)count != len) {
 			free(code_buf);
+			errno = saved_errno;
 			return NULL;
 		}
 		*out_buf = code_buf;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a28f130c8951..1607364ee736 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -9,6 +9,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <unistd.h>
@@ -365,7 +366,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-- 
2.48.0.rc2.279.g1de40edade-goog


