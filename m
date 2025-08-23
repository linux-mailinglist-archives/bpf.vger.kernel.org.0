Return-Path: <bpf+bounces-66349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B85B325F7
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87171891A2D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD3223DCF;
	Sat, 23 Aug 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVmjL3uf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D6202C5D
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909191; cv=none; b=IgRdtif+9BJ4RfRUciWLqu4qZLtL8xNfRgEeCf/GeZi2K/BZPWbQLL9ZcemxLuCVFZ1C9CRjn21kosWr3V319Hreeo5aRvulg38sckHWOABnBomXkThQgEZ/KhUBdYIQZ+j1adeoppc+Q95hCZOSkAg1HIltfyv3kTJFjKw0Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909191; c=relaxed/simple;
	bh=N9FVQG2jdtjKbU6RfwAzPigN17gwxhTk9xIT/I4NJQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Vbdfia8UM9Fx93DMeOBSBEoNBZMPTfLIM27n4BZ79BYGukGM3ZBQdfaElpqBuF3zIEYdq6BwJtMy2WBlXY0l5lCT1SAW+KmorYKB65HTv0kRbn43lfSa/dG4HIcIEChJHouj/RWPnQRliiYe3Sy15qPHBN+M87IjQi5YJxtBR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVmjL3uf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4704f9dfc0so3253760a12.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909188; x=1756513988; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3OSZsM2Nacp3NpZahXV1woI9G60ioGrb/JA3Hl3Ovc=;
        b=DVmjL3uf87UXgwxZnLo+mgndHvKQVhatuKCCd79mEHQAJd97rHHqgt1qe4IUJO6A1A
         JXxg5AiNa6ujY5ES35QH3y7l93ww0BienZtNxdyKL7CDPBxtyuQmszbEZTjr1H65aV48
         rHqsEDLazlOORTbkJ+W/WNiNmx7SHmy6ZjqRrqg32EkQX9RSanmSmpoDrq0wuufMl+iu
         nFLYlROQMiaxHxKkU5V6TjgNg2va0O4WYz4/qYyrQ1xMlBJQ7/VkGquyrhBR+OmYk0Kf
         Yu8STXLL/xGrwJmwaRoHWmwIXLxn8vtPYBci5tezhlmFskY9CnaB4RE0cYXm7k+azkxY
         gR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909188; x=1756513988;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3OSZsM2Nacp3NpZahXV1woI9G60ioGrb/JA3Hl3Ovc=;
        b=CG8gRgvAN45ulUYHuiNK1vnIVfCw3EwPFPiH+vjBl42iNzg4/8EzwgJsaSh3+bFJ9P
         NGiqDQQGdjsV3lYxrgZN0pDy7Er5BqktFmJaSIg6ztDke6tJPitB6BgWOsTXG1p/tDy8
         BQMt+ngWK5Zm4aa3jcNgpgj2yNhMRwVP8gbWbVqfwrAu+rP7vypqseuYNyx6/EJFqsHo
         sGdVkpsLaRllJSPsSbK+uMgT3jF1DRiyOc4a/kwoCef1Bi051lftzV+/xkpzRl6QCyYL
         HqGqXVun51b0mUtc0lEaRSIxDdrbf71Winf3cRtnaNUW6a/IJRQiZ+rmy+yJIx3Po9z8
         W3uw==
X-Forwarded-Encrypted: i=1; AJvYcCUte31AyXWcUhKoG2m/S8Ps1K8rAT9u6GlXRVHVCD2taZ8bH3+JW4iFtTn7pgJoW6u+ZUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vEwm2O358GdU8xwS4U4jLZk1H/9y4H+yHZUwIg345YOF/PfI
	OwV8kVXU86jbXAKZVKbAE/BViwI9vyzKBLtTSQOtbN1rYM6muKAWuXerg358iQRXAuQEmJJtjXK
	S28g8hXDMaw==
X-Google-Smtp-Source: AGHT+IH5Zq8rZsyJBAWSclQq3FAqPvNcO8krBkBcPndbf+7RsZbPyhJJO6PVdWlZJA/JMmgcc1R15tbed5Q4
X-Received: from plcr17.prod.google.com ([2002:a17:903:151:b0:240:285a:2adc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4e:b0:246:5d07:8430
 with SMTP id d9443c01a7336-2465d07875fmr23719585ad.9.1755909187908; Fri, 22
 Aug 2025 17:33:07 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:14 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-19-irogers@google.com>
Subject: [PATCH v5 18/19] perf srcline: Fallback between addr2line implementations
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

Factor the addr2line function implementation into separate source
files (addr2line.[ch]) and rename the addr2line function
cmd__addr2line. In srcline replace the ifdef-ed addr2line
implementations with one that first tries the llvm__addr2line
implementation and on failure uses cmd__addr2line.

If HAVE_LIBLLVM_SUPPORT is enabled the llvm__addr2line will execute
against the libLLVM.so it is linked against.

If HAVE_LIBLLVM_DYNAMIC is enabled then libperf-llvm.so (that links
against libLLVM.so) will be dlopened. If the dlopen succeeds then the
behavior should match HAVE_LIBLLVM_SUPPORT. On failure cmd__addr2line
is used. The dlopen is only tried once.

If HAVE_LIBLLVM_DYNAMIC isn't enabled then llvm__addr2line immediately
fails and cmd__addr2line is used.

Clean up the dso__free_a2l logic, which is only needed in the non-LLVM
version and moved to addr2line.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |   1 +
 tools/perf/util/addr2line.c | 439 ++++++++++++++++++++++++++++++++
 tools/perf/util/addr2line.h |  20 ++
 tools/perf/util/config.c    |   2 +-
 tools/perf/util/llvm.c      |   5 -
 tools/perf/util/llvm.h      |   3 -
 tools/perf/util/srcline.c   | 482 ++----------------------------------
 tools/perf/util/srcline.h   |   1 -
 8 files changed, 484 insertions(+), 469 deletions(-)
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3e912aadcbfd..cb16c2ee007a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -2,6 +2,7 @@ include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 
 perf-util-y += arm64-frame-pointer-unwind-support.o
+perf-util-y += addr2line.o
 perf-util-y += addr_location.o
 perf-util-y += annotate.o
 perf-util-y += block-info.o
diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
new file mode 100644
index 000000000000..f2d94a3272d7
--- /dev/null
+++ b/tools/perf/util/addr2line.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "addr2line.h"
+#include "debug.h"
+#include "dso.h"
+#include "string2.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "symbol_conf.h"
+
+#include <api/io.h>
+#include <linux/zalloc.h>
+#include <subcmd/run-command.h>
+
+#include <inttypes.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define MAX_INLINE_NEST 1024
+
+/* If addr2line doesn't return data for 1 second then timeout. */
+int addr2line_timeout_ms = 1 * 1000;
+
+static int filename_split(char *filename, unsigned int *line_nr)
+{
+	char *sep;
+
+	sep = strchr(filename, '\n');
+	if (sep)
+		*sep = '\0';
+
+	if (!strcmp(filename, "??:0"))
+		return 0;
+
+	sep = strchr(filename, ':');
+	if (sep) {
+		*sep++ = '\0';
+		*line_nr = strtoul(sep, NULL, 0);
+		return 1;
+	}
+	pr_debug("addr2line missing ':' in filename split\n");
+	return 0;
+}
+
+static void addr2line_subprocess_cleanup(struct child_process *a2l)
+{
+	if (a2l->pid != -1) {
+		kill(a2l->pid, SIGKILL);
+		finish_command(a2l); /* ignore result, we don't care */
+		a2l->pid = -1;
+		close(a2l->in);
+		close(a2l->out);
+	}
+
+	free(a2l);
+}
+
+static struct child_process *addr2line_subprocess_init(const char *addr2line_path,
+							const char *binary_path)
+{
+	const char *argv[] = {
+		addr2line_path ?: "addr2line",
+		"-e", binary_path,
+		"-a", "-i", "-f", NULL
+	};
+	struct child_process *a2l = zalloc(sizeof(*a2l));
+	int start_command_status = 0;
+
+	if (a2l == NULL) {
+		pr_err("Failed to allocate memory for addr2line");
+		return NULL;
+	}
+
+	a2l->pid = -1;
+	a2l->in = -1;
+	a2l->out = -1;
+	a2l->no_stderr = 1;
+
+	a2l->argv = argv;
+	start_command_status = start_command(a2l);
+	a2l->argv = NULL; /* it's not used after start_command; avoid dangling pointers */
+
+	if (start_command_status != 0) {
+		pr_warning("could not start addr2line (%s) for %s: start_command return code %d\n",
+			addr2line_path, binary_path, start_command_status);
+		addr2line_subprocess_cleanup(a2l);
+		return NULL;
+	}
+
+	return a2l;
+}
+
+enum a2l_style {
+	BROKEN,
+	GNU_BINUTILS,
+	LLVM,
+};
+
+static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
+{
+	static bool cached;
+	static enum a2l_style style;
+
+	if (!cached) {
+		char buf[128];
+		struct io io;
+		int ch;
+		int lines;
+
+		if (write(a2l->in, ",\n", 2) != 2)
+			return BROKEN;
+
+		io__init(&io, a2l->out, buf, sizeof(buf));
+		ch = io__get_char(&io);
+		if (ch == ',') {
+			style = LLVM;
+			cached = true;
+			lines = 1;
+			pr_debug3("Detected LLVM addr2line style\n");
+		} else if (ch == '0') {
+			style = GNU_BINUTILS;
+			cached = true;
+			lines = 3;
+			pr_debug3("Detected binutils addr2line style\n");
+		} else {
+			if (!symbol_conf.disable_add2line_warn) {
+				char *output = NULL;
+				size_t output_len;
+
+				io__getline(&io, &output, &output_len);
+				pr_warning("%s %s: addr2line configuration failed\n",
+					   __func__, dso_name);
+				pr_warning("\t%c%s", ch, output);
+			}
+			pr_debug("Unknown/broken addr2line style\n");
+			return BROKEN;
+		}
+		while (lines) {
+			ch = io__get_char(&io);
+			if (ch <= 0)
+				break;
+			if (ch == '\n')
+				lines--;
+		}
+		/* Ignore SIGPIPE in the event addr2line exits. */
+		signal(SIGPIPE, SIG_IGN);
+	}
+	return style;
+}
+
+static int read_addr2line_record(struct io *io,
+				 enum a2l_style style,
+				 const char *dso_name,
+				 u64 addr,
+				 bool first,
+				 char **function,
+				 char **filename,
+				 unsigned int *line_nr)
+{
+	/*
+	 * Returns:
+	 * -1 ==> error
+	 * 0 ==> sentinel (or other ill-formed) record read
+	 * 1 ==> a genuine record read
+	 */
+	char *line = NULL;
+	size_t line_len = 0;
+	unsigned int dummy_line_nr = 0;
+	int ret = -1;
+
+	if (function != NULL)
+		zfree(function);
+
+	if (filename != NULL)
+		zfree(filename);
+
+	if (line_nr != NULL)
+		*line_nr = 0;
+
+	/*
+	 * Read the first line. Without an error this will be:
+	 * - for the first line an address like 0x1234,
+	 * - the binutils sentinel 0x0000000000000000,
+	 * - the llvm-addr2line the sentinel ',' character,
+	 * - the function name line for an inlined function.
+	 */
+	if (io__getline(io, &line, &line_len) < 0 || !line_len)
+		goto error;
+
+	pr_debug3("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
+	if (style == LLVM && line_len == 2 && line[0] == ',') {
+		/* Found the llvm-addr2line sentinel character. */
+		zfree(&line);
+		return 0;
+	} else if (style == GNU_BINUTILS && (!first || addr != 0)) {
+		int zero_count = 0, non_zero_count = 0;
+		/*
+		 * Check for binutils sentinel ignoring it for the case the
+		 * requested address is 0.
+		 */
+
+		/* A given address should always start 0x. */
+		if (line_len >= 2 || line[0] != '0' || line[1] != 'x') {
+			for (size_t i = 2; i < line_len; i++) {
+				if (line[i] == '0')
+					zero_count++;
+				else if (line[i] != '\n')
+					non_zero_count++;
+			}
+			if (!non_zero_count) {
+				int ch;
+
+				if (first && !zero_count) {
+					/* Line was erroneous just '0x'. */
+					goto error;
+				}
+				/*
+				 * Line was 0x0..0, the sentinel for binutils. Remove
+				 * the function and filename lines.
+				 */
+				zfree(&line);
+				do {
+					ch = io__get_char(io);
+				} while (ch > 0 && ch != '\n');
+				do {
+					ch = io__get_char(io);
+				} while (ch > 0 && ch != '\n');
+				return 0;
+			}
+		}
+	}
+	/* Read the second function name line (if inline data then this is the first line). */
+	if (first && (io__getline(io, &line, &line_len) < 0 || !line_len))
+		goto error;
+
+	pr_debug3("%s %s: addr2line read line: %s", __func__, dso_name, line);
+	if (function != NULL)
+		*function = strdup(strim(line));
+
+	zfree(&line);
+	line_len = 0;
+
+	/* Read the third filename and line number line. */
+	if (io__getline(io, &line, &line_len) < 0 || !line_len)
+		goto error;
+
+	pr_debug3("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
+	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
+	    style == GNU_BINUTILS) {
+		ret = 0;
+		goto error;
+	}
+
+	if (filename != NULL)
+		*filename = strdup(line);
+
+	zfree(&line);
+	line_len = 0;
+
+	return 1;
+
+error:
+	free(line);
+	if (function != NULL)
+		zfree(function);
+	if (filename != NULL)
+		zfree(filename);
+	return ret;
+}
+
+static int inline_list__append_record(struct dso *dso,
+				      struct inline_node *node,
+				      struct symbol *sym,
+				      const char *function,
+				      const char *filename,
+				      unsigned int line_nr)
+{
+	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
+
+	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
+}
+
+int cmd__addr2line(const char *dso_name, u64 addr,
+		   char **file, unsigned int *line_nr,
+		   struct dso *dso,
+		   bool unwind_inlines,
+		   struct inline_node *node,
+		   struct symbol *sym __maybe_unused)
+{
+	struct child_process *a2l = dso__a2l(dso);
+	char *record_function = NULL;
+	char *record_filename = NULL;
+	unsigned int record_line_nr = 0;
+	int record_status = -1;
+	int ret = 0;
+	size_t inline_count = 0;
+	int len;
+	char buf[128];
+	ssize_t written;
+	struct io io = { .eof = false };
+	enum a2l_style a2l_style;
+
+	if (!a2l) {
+		if (!filename__has_section(dso_name, ".debug_line"))
+			goto out;
+
+		dso__set_a2l(dso,
+			     addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name));
+		a2l = dso__a2l(dso);
+	}
+
+	if (a2l == NULL) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
+		goto out;
+	}
+	a2l_style = addr2line_configure(a2l, dso_name);
+	if (a2l_style == BROKEN)
+		goto out;
+
+	/*
+	 * Send our request and then *deliberately* send something that can't be
+	 * interpreted as a valid address to ask addr2line about (namely,
+	 * ","). This causes addr2line to first write out the answer to our
+	 * request, in an unbounded/unknown number of records, and then to write
+	 * out the lines "0x0...0", "??" and "??:0", for GNU binutils, or ","
+	 * for llvm-addr2line, so that we can detect when it has finished giving
+	 * us anything useful.
+	 */
+	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
+	written = len > 0 ? write(a2l->in, buf, len) : -1;
+	if (written != len) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: could not send request\n", __func__, dso_name);
+		goto out;
+	}
+	io__init(&io, a2l->out, buf, sizeof(buf));
+	io.timeout_ms = addr2line_timeout_ms;
+	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
+				      &record_function, &record_filename, &record_line_nr)) {
+	case -1:
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
+		goto out;
+	case 0:
+		/*
+		 * The first record was invalid, so return failure, but first
+		 * read another record, since we sent a sentinel ',' for the
+		 * sake of detected the last inlined function. Treat this as the
+		 * first of a record as the ',' generates a new start with GNU
+		 * binutils, also force a non-zero address as we're no longer
+		 * reading that record.
+		 */
+		switch (read_addr2line_record(&io, a2l_style, dso_name,
+					      /*addr=*/1, /*first=*/true,
+					      NULL, NULL, NULL)) {
+		case -1:
+			if (!symbol_conf.disable_add2line_warn)
+				pr_warning("%s %s: could not read sentinel record\n",
+					   __func__, dso_name);
+			break;
+		case 0:
+			/* The sentinel as expected. */
+			break;
+		default:
+			if (!symbol_conf.disable_add2line_warn)
+				pr_warning("%s %s: unexpected record instead of sentinel",
+					   __func__, dso_name);
+			break;
+		}
+		goto out;
+	default:
+		/* First record as expected. */
+		break;
+	}
+
+	if (file) {
+		*file = strdup(record_filename);
+		ret = 1;
+	}
+	if (line_nr)
+		*line_nr = record_line_nr;
+
+	if (unwind_inlines) {
+		if (node && inline_list__append_record(dso, node, sym,
+						       record_function,
+						       record_filename,
+						       record_line_nr)) {
+			ret = 0;
+			goto out;
+		}
+	}
+
+	/*
+	 * We have to read the records even if we don't care about the inline
+	 * info. This isn't the first record and force the address to non-zero
+	 * as we're reading records beyond the first.
+	 */
+	while ((record_status = read_addr2line_record(&io,
+						      a2l_style,
+						      dso_name,
+						      /*addr=*/1,
+						      /*first=*/false,
+						      &record_function,
+						      &record_filename,
+						      &record_line_nr)) == 1) {
+		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
+			if (inline_list__append_record(dso, node, sym,
+						       record_function,
+						       record_filename,
+						       record_line_nr)) {
+				ret = 0;
+				goto out;
+			}
+			ret = 1; /* found at least one inline frame */
+		}
+	}
+
+out:
+	free(record_function);
+	free(record_filename);
+	if (io.eof) {
+		dso__set_a2l(dso, NULL);
+		addr2line_subprocess_cleanup(a2l);
+	}
+	return ret;
+}
+
+void dso__free_a2l(struct dso *dso)
+{
+	struct child_process *a2l = dso__a2l(dso);
+
+	if (!a2l)
+		return;
+
+	addr2line_subprocess_cleanup(a2l);
+
+	dso__set_a2l(dso, NULL);
+}
diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
new file mode 100644
index 000000000000..d35a47ba8dab
--- /dev/null
+++ b/tools/perf/util/addr2line.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ADDR2LINE_H
+#define __PERF_ADDR2LINE_H
+
+#include <linux/types.h>
+
+struct dso;
+struct inline_node;
+struct symbol;
+
+extern int addr2line_timeout_ms;
+
+int cmd__addr2line(const char *dso_name, u64 addr,
+		   char **file, unsigned int *line_nr,
+		   struct dso *dso,
+		   bool unwind_inlines,
+		   struct inline_node *node,
+		   struct symbol *sym);
+
+#endif /* __PERF_ADDR2LINE_H */
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index ae72b66b6ded..6f914620c6ff 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -19,7 +19,7 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
-#include "util/srcline.h"  /* addr2line_timeout_ms */
+#include "util/addr2line.h"  /* addr2line_timeout_ms */
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 1607364ee736..cacb510c6814 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -303,11 +303,6 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 	return num_frames;
 }
 
-void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
-{
-	/* Nothing to free. */
-}
-
 /*
  * Whenever LLVM wants to resolve an address into a symbol, it calls this
  * callback. We don't ever actually _return_ anything (in particular, because
diff --git a/tools/perf/util/llvm.h b/tools/perf/util/llvm.h
index 8aa19bb6b068..57f6bafb24bb 100644
--- a/tools/perf/util/llvm.h
+++ b/tools/perf/util/llvm.h
@@ -15,9 +15,6 @@ int llvm__addr2line(const char *dso_name, u64 addr,
 		bool unwind_inlines, struct inline_node *node,
 		struct symbol *sym);
 
-
-void dso__free_a2l_llvm(struct dso *dso);
-
 int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 			     struct annotate_args *args);
 
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 4110e2560c8a..a5d8e994d9ea 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -1,30 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <inttypes.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/types.h>
-
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-
-#include <api/io.h>
-
-#include "util/dso.h"
-#include "util/debug.h"
-#include "util/callchain.h"
-#include "util/symbol_conf.h"
-#include "llvm.h"
 #include "srcline.h"
-#include "string2.h"
+#include "addr2line.h"
+#include "dso.h"
+#include "callchain.h"
+#include "llvm.h"
 #include "symbol.h"
-#include "subcmd/run-command.h"
 
-/* If addr2line doesn't return data for 1 second then timeout. */
-int addr2line_timeout_ms = 1 * 1000;
+#include <inttypes.h>
+#include <string.h>
+
 bool srcline_full_filename;
 
 char *srcline__unknown = (char *)"??:0";
@@ -129,445 +113,22 @@ struct symbol *new_inline_sym(struct dso *dso,
 	return inline_sym;
 }
 
-#define MAX_INLINE_NEST 1024
-
-#ifdef HAVE_LIBLLVM_SUPPORT
-#include "llvm.h"
-
 static int addr2line(const char *dso_name, u64 addr,
-		     char **file, unsigned int *line, struct dso *dso,
-		      bool unwind_inlines, struct inline_node *node,
-		      struct symbol *sym)
-{
-	return llvm__addr2line(dso_name, addr, file, line, dso, unwind_inlines, node, sym);
-}
-
-void dso__free_a2l(struct dso *dso)
-{
-	dso__free_a2l_llvm(dso);
-}
-
-#else /* HAVE_LIBLLVM_SUPPORT */
-
-static int filename_split(char *filename, unsigned int *line_nr)
-{
-	char *sep;
-
-	sep = strchr(filename, '\n');
-	if (sep)
-		*sep = '\0';
-
-	if (!strcmp(filename, "??:0"))
-		return 0;
-
-	sep = strchr(filename, ':');
-	if (sep) {
-		*sep++ = '\0';
-		*line_nr = strtoul(sep, NULL, 0);
-		return 1;
-	}
-	pr_debug("addr2line missing ':' in filename split\n");
-	return 0;
-}
-
-static void addr2line_subprocess_cleanup(struct child_process *a2l)
+		   char **file, unsigned int *line_nr,
+		   struct dso *dso,
+		   bool unwind_inlines,
+		   struct inline_node *node,
+		   struct symbol *sym)
 {
-	if (a2l->pid != -1) {
-		kill(a2l->pid, SIGKILL);
-		finish_command(a2l); /* ignore result, we don't care */
-		a2l->pid = -1;
-		close(a2l->in);
-		close(a2l->out);
-	}
+	int ret;
 
-	free(a2l);
-}
+	ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
+	if (ret > 0)
+		return ret;
 
-static struct child_process *addr2line_subprocess_init(const char *addr2line_path,
-							const char *binary_path)
-{
-	const char *argv[] = {
-		addr2line_path ?: "addr2line",
-		"-e", binary_path,
-		"-a", "-i", "-f", NULL
-	};
-	struct child_process *a2l = zalloc(sizeof(*a2l));
-	int start_command_status = 0;
-
-	if (a2l == NULL) {
-		pr_err("Failed to allocate memory for addr2line");
-		return NULL;
-	}
-
-	a2l->pid = -1;
-	a2l->in = -1;
-	a2l->out = -1;
-	a2l->no_stderr = 1;
-
-	a2l->argv = argv;
-	start_command_status = start_command(a2l);
-	a2l->argv = NULL; /* it's not used after start_command; avoid dangling pointers */
-
-	if (start_command_status != 0) {
-		pr_warning("could not start addr2line (%s) for %s: start_command return code %d\n",
-			addr2line_path, binary_path, start_command_status);
-		addr2line_subprocess_cleanup(a2l);
-		return NULL;
-	}
-
-	return a2l;
-}
-
-enum a2l_style {
-	BROKEN,
-	GNU_BINUTILS,
-	LLVM,
-};
-
-static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
-{
-	static bool cached;
-	static enum a2l_style style;
-
-	if (!cached) {
-		char buf[128];
-		struct io io;
-		int ch;
-		int lines;
-
-		if (write(a2l->in, ",\n", 2) != 2)
-			return BROKEN;
-
-		io__init(&io, a2l->out, buf, sizeof(buf));
-		ch = io__get_char(&io);
-		if (ch == ',') {
-			style = LLVM;
-			cached = true;
-			lines = 1;
-			pr_debug3("Detected LLVM addr2line style\n");
-		} else if (ch == '0') {
-			style = GNU_BINUTILS;
-			cached = true;
-			lines = 3;
-			pr_debug3("Detected binutils addr2line style\n");
-		} else {
-			if (!symbol_conf.disable_add2line_warn) {
-				char *output = NULL;
-				size_t output_len;
-
-				io__getline(&io, &output, &output_len);
-				pr_warning("%s %s: addr2line configuration failed\n",
-					   __func__, dso_name);
-				pr_warning("\t%c%s", ch, output);
-			}
-			pr_debug("Unknown/broken addr2line style\n");
-			return BROKEN;
-		}
-		while (lines) {
-			ch = io__get_char(&io);
-			if (ch <= 0)
-				break;
-			if (ch == '\n')
-				lines--;
-		}
-		/* Ignore SIGPIPE in the event addr2line exits. */
-		signal(SIGPIPE, SIG_IGN);
-	}
-	return style;
+	return cmd__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
 }
 
-static int read_addr2line_record(struct io *io,
-				 enum a2l_style style,
-				 const char *dso_name,
-				 u64 addr,
-				 bool first,
-				 char **function,
-				 char **filename,
-				 unsigned int *line_nr)
-{
-	/*
-	 * Returns:
-	 * -1 ==> error
-	 * 0 ==> sentinel (or other ill-formed) record read
-	 * 1 ==> a genuine record read
-	 */
-	char *line = NULL;
-	size_t line_len = 0;
-	unsigned int dummy_line_nr = 0;
-	int ret = -1;
-
-	if (function != NULL)
-		zfree(function);
-
-	if (filename != NULL)
-		zfree(filename);
-
-	if (line_nr != NULL)
-		*line_nr = 0;
-
-	/*
-	 * Read the first line. Without an error this will be:
-	 * - for the first line an address like 0x1234,
-	 * - the binutils sentinel 0x0000000000000000,
-	 * - the llvm-addr2line the sentinel ',' character,
-	 * - the function name line for an inlined function.
-	 */
-	if (io__getline(io, &line, &line_len) < 0 || !line_len)
-		goto error;
-
-	pr_debug3("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
-	if (style == LLVM && line_len == 2 && line[0] == ',') {
-		/* Found the llvm-addr2line sentinel character. */
-		zfree(&line);
-		return 0;
-	} else if (style == GNU_BINUTILS && (!first || addr != 0)) {
-		int zero_count = 0, non_zero_count = 0;
-		/*
-		 * Check for binutils sentinel ignoring it for the case the
-		 * requested address is 0.
-		 */
-
-		/* A given address should always start 0x. */
-		if (line_len >= 2 || line[0] != '0' || line[1] != 'x') {
-			for (size_t i = 2; i < line_len; i++) {
-				if (line[i] == '0')
-					zero_count++;
-				else if (line[i] != '\n')
-					non_zero_count++;
-			}
-			if (!non_zero_count) {
-				int ch;
-
-				if (first && !zero_count) {
-					/* Line was erroneous just '0x'. */
-					goto error;
-				}
-				/*
-				 * Line was 0x0..0, the sentinel for binutils. Remove
-				 * the function and filename lines.
-				 */
-				zfree(&line);
-				do {
-					ch = io__get_char(io);
-				} while (ch > 0 && ch != '\n');
-				do {
-					ch = io__get_char(io);
-				} while (ch > 0 && ch != '\n');
-				return 0;
-			}
-		}
-	}
-	/* Read the second function name line (if inline data then this is the first line). */
-	if (first && (io__getline(io, &line, &line_len) < 0 || !line_len))
-		goto error;
-
-	pr_debug3("%s %s: addr2line read line: %s", __func__, dso_name, line);
-	if (function != NULL)
-		*function = strdup(strim(line));
-
-	zfree(&line);
-	line_len = 0;
-
-	/* Read the third filename and line number line. */
-	if (io__getline(io, &line, &line_len) < 0 || !line_len)
-		goto error;
-
-	pr_debug3("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
-	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
-	    style == GNU_BINUTILS) {
-		ret = 0;
-		goto error;
-	}
-
-	if (filename != NULL)
-		*filename = strdup(line);
-
-	zfree(&line);
-	line_len = 0;
-
-	return 1;
-
-error:
-	free(line);
-	if (function != NULL)
-		zfree(function);
-	if (filename != NULL)
-		zfree(filename);
-	return ret;
-}
-
-static int inline_list__append_record(struct dso *dso,
-				      struct inline_node *node,
-				      struct symbol *sym,
-				      const char *function,
-				      const char *filename,
-				      unsigned int line_nr)
-{
-	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
-
-	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
-}
-
-static int addr2line(const char *dso_name, u64 addr,
-		     char **file, unsigned int *line_nr,
-		     struct dso *dso,
-		     bool unwind_inlines,
-		     struct inline_node *node,
-		     struct symbol *sym __maybe_unused)
-{
-	struct child_process *a2l = dso__a2l(dso);
-	char *record_function = NULL;
-	char *record_filename = NULL;
-	unsigned int record_line_nr = 0;
-	int record_status = -1;
-	int ret = 0;
-	size_t inline_count = 0;
-	int len;
-	char buf[128];
-	ssize_t written;
-	struct io io = { .eof = false };
-	enum a2l_style a2l_style;
-
-	if (!a2l) {
-		if (!filename__has_section(dso_name, ".debug_line"))
-			goto out;
-
-		dso__set_a2l(dso,
-			     addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name));
-		a2l = dso__a2l(dso);
-	}
-
-	if (a2l == NULL) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
-		goto out;
-	}
-	a2l_style = addr2line_configure(a2l, dso_name);
-	if (a2l_style == BROKEN)
-		goto out;
-
-	/*
-	 * Send our request and then *deliberately* send something that can't be
-	 * interpreted as a valid address to ask addr2line about (namely,
-	 * ","). This causes addr2line to first write out the answer to our
-	 * request, in an unbounded/unknown number of records, and then to write
-	 * out the lines "0x0...0", "??" and "??:0", for GNU binutils, or ","
-	 * for llvm-addr2line, so that we can detect when it has finished giving
-	 * us anything useful.
-	 */
-	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
-	written = len > 0 ? write(a2l->in, buf, len) : -1;
-	if (written != len) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("%s %s: could not send request\n", __func__, dso_name);
-		goto out;
-	}
-	io__init(&io, a2l->out, buf, sizeof(buf));
-	io.timeout_ms = addr2line_timeout_ms;
-	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
-				      &record_function, &record_filename, &record_line_nr)) {
-	case -1:
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
-		goto out;
-	case 0:
-		/*
-		 * The first record was invalid, so return failure, but first
-		 * read another record, since we sent a sentinel ',' for the
-		 * sake of detected the last inlined function. Treat this as the
-		 * first of a record as the ',' generates a new start with GNU
-		 * binutils, also force a non-zero address as we're no longer
-		 * reading that record.
-		 */
-		switch (read_addr2line_record(&io, a2l_style, dso_name,
-					      /*addr=*/1, /*first=*/true,
-					      NULL, NULL, NULL)) {
-		case -1:
-			if (!symbol_conf.disable_add2line_warn)
-				pr_warning("%s %s: could not read sentinel record\n",
-					   __func__, dso_name);
-			break;
-		case 0:
-			/* The sentinel as expected. */
-			break;
-		default:
-			if (!symbol_conf.disable_add2line_warn)
-				pr_warning("%s %s: unexpected record instead of sentinel",
-					   __func__, dso_name);
-			break;
-		}
-		goto out;
-	default:
-		/* First record as expected. */
-		break;
-	}
-
-	if (file) {
-		*file = strdup(record_filename);
-		ret = 1;
-	}
-	if (line_nr)
-		*line_nr = record_line_nr;
-
-	if (unwind_inlines) {
-		if (node && inline_list__append_record(dso, node, sym,
-						       record_function,
-						       record_filename,
-						       record_line_nr)) {
-			ret = 0;
-			goto out;
-		}
-	}
-
-	/*
-	 * We have to read the records even if we don't care about the inline
-	 * info. This isn't the first record and force the address to non-zero
-	 * as we're reading records beyond the first.
-	 */
-	while ((record_status = read_addr2line_record(&io,
-						      a2l_style,
-						      dso_name,
-						      /*addr=*/1,
-						      /*first=*/false,
-						      &record_function,
-						      &record_filename,
-						      &record_line_nr)) == 1) {
-		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
-			if (inline_list__append_record(dso, node, sym,
-						       record_function,
-						       record_filename,
-						       record_line_nr)) {
-				ret = 0;
-				goto out;
-			}
-			ret = 1; /* found at least one inline frame */
-		}
-	}
-
-out:
-	free(record_function);
-	free(record_filename);
-	if (io.eof) {
-		dso__set_a2l(dso, NULL);
-		addr2line_subprocess_cleanup(a2l);
-	}
-	return ret;
-}
-
-void dso__free_a2l(struct dso *dso)
-{
-	struct child_process *a2l = dso__a2l(dso);
-
-	if (!a2l)
-		return;
-
-	addr2line_subprocess_cleanup(a2l);
-
-	dso__set_a2l(dso, NULL);
-}
-
-#endif /* HAVE_LIBLLVM_SUPPORT */
-
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 					struct dso *dso, struct symbol *sym)
 {
@@ -582,7 +143,9 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
+	addr2line(dso_name, addr, /*file=*/NULL, /*line_nr=*/NULL, dso,
+		  /*unwind_inlines=*/true, node, sym);
+
 	return node;
 }
 
@@ -609,7 +172,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, &line, dso,
-		       unwind_inlines, NULL, sym))
+		       unwind_inlines, /*node=*/NULL, sym))
 		goto out_err;
 
 	srcline = srcline_from_fileline(file, line);
@@ -655,7 +218,8 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	if (dso_name == NULL)
 		goto out_err;
 
-	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL))
+	if (!addr2line(dso_name, addr, &file, line, dso, /*unwind_inlines=*/true,
+			/*node=*/NULL, /*sym=*/NULL))
 		goto out_err;
 
 	dso__set_a2l_fails(dso, 0);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 80c20169e250..ce03b90dea1d 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -9,7 +9,6 @@
 struct dso;
 struct symbol;
 
-extern int addr2line_timeout_ms;
 extern bool srcline_full_filename;
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, u64 ip);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


