Return-Path: <bpf+bounces-56200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD72A92DCC
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4313F1B6662A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC4253F22;
	Thu, 17 Apr 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsvI37f8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FF25178E
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931310; cv=none; b=aGejZ2KAqspWZXz8VW55OXyjUTyjgbRoHiWUR6PlqfxFnWSfxs6V8gU1hznVhvXhXeApyyNZz8kWCMOQ426oWSO1wOchRDaZDBOS9atrwClIy2fFomHpFlCd//DtIyK6rN6j4suWWp+1N4aD6zZgaJ9KptMmoHMDN+t8EFN/Jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931310; c=relaxed/simple;
	bh=dVqTwm6Z5kJPYlgxaTtj66E44vbniBTbV8kGzDOLkSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kvBftINaZXBUK412YitsaZ5ujmugsRbjzEf5hqDUhZbtl2sW34ezIP19OFVJ5LqbWF7RLeNYnPAUkZjLMExW2wtvgLouQq9N5cI/v+KUD0sKSTGNBpi8/Z0iI9vhHGxNwsFKoifm+zGj4pYt5tJV8cFZ3tW5o54MiSo9Gp8hmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsvI37f8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225974c6272so9697465ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931308; x=1745536108; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RY1r15pwpCxEu/4KBHv5AIK/eUkuBGzABOfCshTThNM=;
        b=DsvI37f8sUTX7c704DqOwYYW4c6e8G5CTi3vUnaYskkunDwfiOLfLURtIc8WQepQgV
         DYqQ4ZiNOWUlhZ8H8uShfPBT6DWH4F3Wm1lNeQmZwteh0cSC9nbxdRjo1R7nfoq1XBGP
         uv5irtYlKc15In1F7V9gDkWADI7bwT+u4E1HbOZr23epyxdyoM6Bi0qDHV+8XU/XH/ZN
         4u6laLAg/yWvJq1JnDLieuGEEP1JQQNnUAMS22ss5WJyo2AakYP7TfZG5j2CQFJZC8QA
         MpI3qraKYr9fKqStkRf8ig9y7gynZM/n+vWX4sa2m33flgi5wByJkqvXmkZsfu8K8W5c
         pbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931308; x=1745536108;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY1r15pwpCxEu/4KBHv5AIK/eUkuBGzABOfCshTThNM=;
        b=wS/8C+xktkUtq46Uw8MmT020fcga+37SyYgxc0hd5wmqXkgDqcpMBowy8J7AUlTxFA
         k7QAPkuy6GKEgiIZuy2fgq2/yoGTLvtSdSWlYrQQBt1hEQn08/PINl/QHMBJSGZlkfnk
         5qa7s7R2TfaftDe46VsTt520hgutikBSgaGYKI5au5nCWeRBAe77XebZci3aGT5SX0cL
         1aPdMLA2VHjTbEAMabUvzh/gc9sZbjx5NqgXqcgX6Vq8vSbbKiCK6gFKX8lOuFpwT6Gj
         SYH1pos/zeOdOStGIktBM8wE8JAI01sNl08EhoSrkxwGYC98578W3E5CeY3wm4wXIvb8
         6Tvg==
X-Forwarded-Encrypted: i=1; AJvYcCUiE7O2OUfMhLJ0I4cbJeKagAH9t70jfugg1Bql1mdw5fPbx1EO3Tt3JPPd/ekOBLtOjZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpocdhBW8ltVyYo6aK+IFEw/6JjgTnM4i9gzWkaJS64uvimpZ5
	kqeyPBMNkOcyN8oFBdPnrtSOZUJV8YoRzJnZWMOak/QENTi2zbKXfD4okiPmA3JdmKeX0t7cAXR
	EaEqHMA==
X-Google-Smtp-Source: AGHT+IF1KynYQjk+qiDtYBRZqtrA+sXYk/Qlh4FVBuUH3NSYZdwIzrbF7KXRZDSOIoNHB1eQbEczvfeazT6E
X-Received: from plsa23.prod.google.com ([2002:a17:902:b597:b0:227:e456:d436])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78a:b0:220:cfb7:56eb
 with SMTP id d9443c01a7336-22c53f36a0fmr7932675ad.26.1744931307861; Thu, 17
 Apr 2025 16:08:27 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:37 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-17-irogers@google.com>
Subject: [PATCH v4 16/19] perf disasm: Remove disasm_bpf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
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

BPF disassembly was handled in here by libbfd. The LLVM and capstone
disassemblers now support BPF JIT disassembly. As libbfd support was
removed the functions here no longer did anything remove them and
associated error values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build        |  1 -
 tools/perf/util/annotate.h   |  1 -
 tools/perf/util/disasm.c     | 12 +++---------
 tools/perf/util/disasm_bpf.c | 29 -----------------------------
 tools/perf/util/disasm_bpf.h | 12 ------------
 5 files changed, 3 insertions(+), 52 deletions(-)
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 861e8ed4ac49..cc22cc8a5aac 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -14,7 +14,6 @@ perf-util-y += copyfile.o
 perf-util-y += ctype.o
 perf-util-y += db-export.o
 perf-util-y += disasm.o
-perf-util-y += disasm_bpf.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index bbb89b32f398..8b14a90a3a0c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -446,7 +446,6 @@ enum symbol_disassemble_errno {
 	__SYMBOL_ANNOTATE_ERRNO__START		= -10000,
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
-	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
 	SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 175d9d3b5c97..683eb6aa7b53 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -17,7 +17,6 @@
 #include "capstone.h"
 #include "debug.h"
 #include "disasm.h"
-#include "disasm_bpf.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1231,9 +1230,6 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 			  "  --vmlinux vmlinux\n", build_id_msg ?: "");
 	}
 		break;
-	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
-		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
-		break;
 	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP:
 		scnprintf(buf, buflen, "Problems with arch specific instruction name regular expressions.");
 		break;
@@ -1501,11 +1497,9 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return symbol__disassemble_bpf(sym, args);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
-		return symbol__disassemble_bpf_image(sym, args);
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return -1;
 
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
deleted file mode 100644
index a891a0b909a7..000000000000
--- a/tools/perf/util/disasm_bpf.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include "util/annotate.h"
-#include "util/disasm_bpf.h"
-#include "util/symbol.h"
-#include <linux/zalloc.h>
-#include <string.h>
-
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
-{
-	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
-}
-
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *dl;
-
-	args->offset = -1;
-	args->line = strdup("to be implemented");
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	dl = disasm_line__new(args);
-	if (dl)
-		annotation_line__add(&dl->al, &notes->src->source);
-
-	zfree(&args->line);
-	return 0;
-}
diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
deleted file mode 100644
index 2ecb19545388..000000000000
--- a/tools/perf/util/disasm_bpf.h
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#ifndef __PERF_DISASM_BPF_H
-#define __PERF_DISASM_BPF_H
-
-struct symbol;
-struct annotate_args;
-
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args);
-
-#endif /* __PERF_DISASM_BPF_H */
-- 
2.49.0.805.g082f7c87e0-goog


