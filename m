Return-Path: <bpf+bounces-49519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4EA19807
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC5D18854D5
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411E21CA0A;
	Wed, 22 Jan 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixcgSuZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657A21C19B
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567837; cv=none; b=gw9tFFNBkW+/QQ/wirmohGLxehNIwifaQuPyXdJhAfkg9e6h+cT5lhKYb2uPPDUo7V0ULL1AJeewj5QJX2Ia634V7lrxotg14AGO7pt5Sx5Lx4UP9UyiKECE8TDw8TrN/uzD6YKJ0MkJGP9NTLKWLWiCxvJlpagnDOvcx72Mgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567837; c=relaxed/simple;
	bh=4B4IKrXwB6d79VtiniAUi5vxkZCze+eo35hJmKoyKak=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NCaPlOC8M0S41k9eMhL9MyUtvfYOivb+B2+SOA/2zag9UeHxPaBpkERU+7pxC/+mdmsJmld0i0tAcYytwEb9dGUZ9zMAU71/wzpdjyhvOg5KZxsZwPpR/EGM7HUnUTE+gLpkU1xxnkxTxYJUyKLqZi+FfyHK0LnbUZ3TvS4HhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixcgSuZ6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3988f71863so9342276.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567832; x=1738172632; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQKWTNhrg4X427IOJEDBp5FHgvIM1OUI23EIkKcjK+8=;
        b=ixcgSuZ6EP1/xlCoBrXlm5wdwX3DaubycKGvGtJrLzU84XCLBx3smpX9BWyzbU4WKX
         mVpUQJt4/R195vS9DB41GUjMP2XXAphUWg8y4IXn1S3Ud7CLvGv/qDJdizX+OrbBroQ2
         fNqKahAqcc3wZxDdc9O23PazOcwNv8DGSAQglTc37xsyclsHgOIgKVUMS0RLe9BWkH/p
         nHHjMhJusOmFJBJ1Bp0pYn5DIrA2MvaUnqJtQff3oz276B8G59KoxcwBpSfWSlvPOO9D
         P/3kRZgdhhAYclcAVZKjubbrbq6hdpzizZkkSomKng+t2NM3EuuazdATvoyxWh3ppaZT
         Op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567832; x=1738172632;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQKWTNhrg4X427IOJEDBp5FHgvIM1OUI23EIkKcjK+8=;
        b=GtlOOv3cgXiHc2WQY3DrG6hfQRjhX3aS2hlCbK/et/ANxMHcfrnq20Fa9+i8Yie6ga
         KtyzzFCprZBVW37/MWx1M8z/v4a8lX6yyl6MXrKgqTocRAytaWr7hhFppdt222JBsojV
         mO51p2AMbe1wWcxkjfM5hATccbMWJGX/j6JZuXpTUVfCyRPWGZOgqWrc3aCeF0CxK2Wp
         vDB7fgescBDUsRMDGO+f02T3AmF7TGM3a8gI+J6vy1d6oWxzi3+SXYbYyoRb5MQsJBt0
         nhMu040UDsDsGzHdTsKJLotdfkYEivKBsj4nlLIHVWiSNqiqQl894Ear/Sqn0D62A/US
         8i6A==
X-Forwarded-Encrypted: i=1; AJvYcCUOl5IXDW7Pgklk1apVIR6slWur7tRHEFgcRm1nNrVoHS38dUvN8w1MtVel/dOOWutdM7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasgUPzYp8ZVcr7frtRXN0Z6oEVV9zLIksOYo24YjIEM8Eb+Gm
	q0tw1phhM9mHOi1z7PSHoHGLHJCvXxCqct8gynTKwY2DmYO5I3zlIY2M7CNv1k5hfld2GGOKyfx
	oX4hyvw==
X-Google-Smtp-Source: AGHT+IFXKAEMcX9hHCxsSw20DWGrIUKBTxwWbzAKW+Zo6E2CO21S+XpkilHeCS4r0qw2MJhYtL1QfYMA3R5W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:a98:b0:6f6:ca28:83ef with SMTP id
 00721157ae682-6f6eb977d4bmr527547b3.6.1737567832579; Wed, 22 Jan 2025
 09:43:52 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:08 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 18/18] perf srcline: Fallback between addr2line implementations
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
index 4b757d157f13..43408d2de4a2 100644
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
index 000000000000..2f6445c183aa
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
+			pr_debug("Detected LLVM addr2line style\n");
+		} else if (ch == '0') {
+			style = GNU_BINUTILS;
+			cached = true;
+			lines = 3;
+			pr_debug("Detected binutils addr2line style\n");
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
+	pr_debug("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
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
+	pr_debug("%s %s: addr2line read line: %s", __func__, dso_name, line);
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
+	pr_debug("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
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
index 2d07c9257a1a..739bf073d86d 100644
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
index 797e78826508..a5d8e994d9ea 100644
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
-			pr_debug("Detected LLVM addr2line style\n");
-		} else if (ch == '0') {
-			style = GNU_BINUTILS;
-			cached = true;
-			lines = 3;
-			pr_debug("Detected binutils addr2line style\n");
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
-	pr_debug("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
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
-	pr_debug("%s %s: addr2line read line: %s", __func__, dso_name, line);
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
-	pr_debug("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
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
2.48.1.262.g85cc9f2d1e-goog


