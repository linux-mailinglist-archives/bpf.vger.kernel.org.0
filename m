Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673DF19025A
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 00:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCWX6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 19:58:53 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55186 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCWX6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 19:58:53 -0400
Received: by mail-qk1-f202.google.com with SMTP id c1so13943063qkg.21
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 16:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tvqjU3a3xzDAgq/u90DSMdiDCYAQ1r1dFHALfZQSGDQ=;
        b=jLb05nSZs7LshM0YjgmDnKrYok4OfQ9Hw6Op/CGps/l8Xeh9I8DzH9EgZxrGnM3ccM
         pu8wr3g6m7EwMBZy8WWUic8Y87rnCYKQ4fq/HuFRyYOZmrfar5oYoASpuy6VG6815F8i
         Mtmhn/UuHTFQh1nDOaMaWZDnWk5ZRPneK3UcGkcZhUz5xU/C9+jpOae6A0C9rqdBIv2p
         FlVklt7xbr3DUHhrIBQ+tNS2TGjng70E45J7PWrOuqjioWYnTubHuTjvt7UsLYORzKm9
         7WMLWgityCaglcbeX+q07GL/FInAl3ronCKBNeLR+9i9ZcBzIZaDYEanKA1Hm2Fr56mA
         YSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tvqjU3a3xzDAgq/u90DSMdiDCYAQ1r1dFHALfZQSGDQ=;
        b=G0EICXTZbuI7iy7OFp8N5dv836xGmlY0PpxD5XYbDUXvuOX1ATGxJcN+H/mJCAEJvd
         U5Jm6FxaltdPkU3nB53WQQQV5K4puLX/AlWaqyd7SRzd9fh6SesHYdOUw0gmxyLSy336
         16DUUn74B2cA5zA9plu9d8/4xZiw7QbGWNJnCNLthPx4spp0vMr16z5m4hk7/wZXr73x
         If19JZrBTQRtiVrApP6oxbYIe1Jm1un2PrcMC89NHAMwFUs8GCQjvyHb+ckttADJsvCi
         XZ8QvLpdEEs6Fg9CtKWVpCPFj+upY4/kK1uENXS9z+Gnt5zh7mUHaOhXQV5KUOGhZDW9
         +lAg==
X-Gm-Message-State: ANhLgQ04eXMMcyZsQgOeX2HpJqO4zwnYL9MI9xG5uHYsohjqDJSlYCGP
        8o6zxCAR3PNlzNSDAkPrRl4zfUx+oUcz
X-Google-Smtp-Source: ADFU+vvxFY64kfq04qP6GQkQsSgZn2sZrFj8tZeh96y2UE5ijqq/HeQgLq/gMCGdzFv3aBAI+A6I1DqgawS3
X-Received: by 2002:a05:6214:60d:: with SMTP id z13mr23584174qvw.183.1585007930437;
 Mon, 23 Mar 2020 16:58:50 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:58:46 -0700
Message-Id: <20200323235846.104937-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v5] perf tools: add support for libpfm4
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch links perf with the libpfm4 library if it is available and
NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
event tables for all processors supported by perf_events. It is a helper
library that helps convert from a symbolic event name to the event
encoding required by the underlying kernel interface. This
library is open-source and available from: http://perfmon2.sf.net.

With this patch, it is possible to specify full hardware events
by name. Hardware filters are also supported. Events must be
specified via the --pfm-events and not -e option. Both options
are active at the same time and it is possible to mix and match:

$ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....

v5 is a rebase.
v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
   branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
   missed in v3.
v3 is against acme/perf/core and removes a diagnostic warning.
v2 of this patch makes the --pfm-events man page documentation
conditional on libpfm4 behing configured. It tidies some of the
documentation and adds the feature test missed in the v1 patch.

Author: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature             |   6 +-
 tools/build/feature/Makefile             |   7 +-
 tools/build/feature/test-libpfm4.c       |   8 +
 tools/perf/Documentation/Makefile        |   4 +-
 tools/perf/Documentation/perf-record.txt |  11 +
 tools/perf/Documentation/perf-stat.txt   |  10 +
 tools/perf/Documentation/perf-top.txt    |  11 +
 tools/perf/Makefile.config               |  12 ++
 tools/perf/Makefile.perf                 |   6 +-
 tools/perf/builtin-list.c                |  16 ++
 tools/perf/builtin-record.c              |  20 ++
 tools/perf/builtin-stat.c                |  21 ++
 tools/perf/builtin-top.c                 |  20 ++
 tools/perf/util/evsel.c                  |   2 +-
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/parse-events.c           | 246 +++++++++++++++++++++++
 tools/perf/util/parse-events.h           |   5 +
 tools/perf/util/pmu.c                    |  11 +
 tools/perf/util/pmu.h                    |   1 +
 19 files changed, 410 insertions(+), 8 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 574c2e0b9d20..08c6fe5aee2d 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -72,7 +72,8 @@ FEATURE_TESTS_BASIC :=                  \
         setns				\
         libaio				\
         libzstd				\
-        disassembler-four-args
+        disassembler-four-args		\
+        libpfm4
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -127,7 +128,8 @@ FEATURE_DISPLAY ?=              \
          bpf			\
          libaio			\
          libzstd		\
-         disassembler-four-args
+         disassembler-four-args	\
+         libpfm4
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ac0d8088565..573072d32545 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -67,7 +67,9 @@ FILES=                                          \
          test-llvm.bin				\
          test-llvm-version.bin			\
          test-libaio.bin			\
-         test-libzstd.bin
+         test-libzstd.bin			\
+         test-libpfm4.bin
+
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -321,6 +323,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
+$(OUTPUT)test-libpfm4.bin:
+	$(BUILD) -lpfm
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-libpfm4.c b/tools/build/feature/test-libpfm4.c
new file mode 100644
index 000000000000..7f24df86cf09
--- /dev/null
+++ b/tools/build/feature/test-libpfm4.c
@@ -0,0 +1,8 @@
+#include <sys/types.h>
+#include <perfmon/pfmlib.h>
+
+int main(void)
+{
+        pfm_initialize();
+        return 0;
+}
diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 31824d5269cc..6e54979c2124 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -48,7 +48,7 @@ man5dir=$(mandir)/man5
 man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
-ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
+ASCIIDOC_EXTRA += --unsafe -f asciidoc.conf
 ASCIIDOC_HTML = xhtml11
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
@@ -59,7 +59,7 @@ HTML_REF = origin/html
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
-ASCIIDOC_EXTRA = -a compat-mode
+ASCIIDOC_EXTRA += -a compat-mode
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
 ASCIIDOC_HTML = xhtml5
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 7f4db7592467..d0efca8d305e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -587,6 +587,17 @@ Make a copy of /proc/kcore and place it into a directory with the perf data file
 Limit the sample data max size, <size> is expected to be a number with
 appended unit character - B/K/M/G
 
+ifdef::HAVE_LIBPFM[]
+--pfm-events events::
+Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
+including support for event filters. For example '--pfm-events
+inst_retired:any_p:u:c=1:i'. More than one event can be passed to the
+option using the comma separator. Hardware events and generic hardware
+events cannot be mixed together. The latter must be used with the -e
+option. The -e option and this one can be mixed and matched.  Events
+can be grouped using the {} notation.
+endif::HAVE_LIBPFM[]
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4d56586b2fb9..536952ad592c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -71,6 +71,16 @@ report::
 --tid=<tid>::
         stat events on existing thread id (comma separated list)
 
+ifdef::HAVE_LIBPFM[]
+--pfm-events events::
+Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
+including support for event filters. For example '--pfm-events
+inst_retired:any_p:u:c=1:i'. More than one event can be passed to the
+option using the comma separator. Hardware events and generic hardware
+events cannot be mixed together. The latter must be used with the -e
+option. The -e option and this one can be mixed and matched.  Events
+can be grouped using the {} notation.
+endif::HAVE_LIBPFM[]
 
 -a::
 --all-cpus::
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 324b6b53c86b..ee81ba153dea 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -310,6 +310,17 @@ Default is to monitor all CPUS.
 	go straight to the histogram browser, just like 'perf top' with no events
 	explicitely specified does.
 
+ifdef::HAVE_LIBPFM[]
+--pfm-events events::
+Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
+including support for event filters. For example '--pfm-events
+inst_retired:any_p:u:c=1:i'. More than one event can be passed to the
+option using the comma separator. Hardware events and generic hardware
+events cannot be mixed together. The latter must be used with the -e
+option. The -e option and this one can be mixed and matched.  Events
+can be grouped using the {} notation.
+endif::HAVE_LIBPFM[]
+
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 80e55e796be9..571aa6b1af40 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -999,6 +999,18 @@ ifdef LIBCLANGLLVM
   endif
 endif
 
+ifndef NO_LIBPFM4
+  ifeq ($(feature-libpfm4), 1)
+    CFLAGS += -DHAVE_LIBPFM
+    EXTLIBS += -lpfm
+    ASCIIDOC_EXTRA = -aHAVE_LIBPFM=1
+    $(call detected,CONFIG_LIBPFM4)
+  else
+    msg := $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev);
+    NO_LIBPFM4 := 1
+  endif
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   perf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a02aca9b21f4..2ba05d7499bd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -118,6 +118,8 @@ include ../scripts/utilities.mak
 #
 # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
 #
+# Define NO_LIBPFM4 to disable libpfm4 extension.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -188,7 +190,7 @@ AWK     = awk
 # non-config cases
 config := 1
 
-NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help install-doc install-man install-html install-info install-pdf doc man html info pdf
+NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
@@ -832,7 +834,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 965ef017496f..5edeb428168a 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -18,6 +18,10 @@
 #include <subcmd/parse-options.h>
 #include <stdio.h>
 
+#ifdef HAVE_LIBPFM
+#include <perfmon/pfmlib.h>
+#endif
+
 static bool desc_flag = true;
 static bool details_flag;
 
@@ -56,6 +60,18 @@ int cmd_list(int argc, const char **argv)
 	if (!raw_dump && pager_in_use())
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
+#ifdef HAVE_LIBPFM
+	{
+		int ret;
+		ret = pfm_initialize();
+		if (ret != PFM_SUCCESS) {
+			fprintf(stderr,
+				"warning libpfm failed to initialize: %s\n",
+				pfm_strerror(ret));
+		}
+	}
+#endif
+
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
 				details_flag, deprecated);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..10b31f5f5fc1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -64,6 +64,10 @@
 #include <linux/zalloc.h>
 #include <linux/bitmap.h>
 
+#ifdef HAVE_LIBPFM
+#include <perfmon/pfmlib.h>
+#endif
+
 struct switch_output {
 	bool		 enabled;
 	bool		 signal;
@@ -2405,6 +2409,11 @@ static struct option __record_options[] = {
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
 		     "size", "Limit the maximum size of the output file", parse_output_max_size),
+#ifdef HAVE_LIBPFM
+	OPT_CALLBACK(0, "pfm-events", &record.evlist, "event",
+		"libpfm4 event selector. use 'perf list' to list available events",
+		parse_libpfm_events_option),
+#endif
 	OPT_END()
 };
 
@@ -2445,6 +2454,17 @@ int cmd_record(int argc, const char **argv)
 	if (rec->evlist == NULL)
 		return -ENOMEM;
 
+#ifdef HAVE_LIBPFM
+	{
+		int ret;
+		ret = pfm_initialize();
+		if (ret != PFM_SUCCESS) {
+			ui__warning("warning libpfm failed to initialize: %s\n",
+				pfm_strerror(ret));
+		}
+	}
+#endif
+
 	err = perf_config(perf_record_config, rec);
 	if (err)
 		return err;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec053dc1e35c..c47eaf238f0c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -89,6 +89,10 @@
 #include <linux/ctype.h>
 #include <perf/evlist.h>
 
+#ifdef HAVE_LIBPFM
+#include <perfmon/pfmlib.h>
+#endif
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
 
@@ -933,6 +937,11 @@ static struct option stat_options[] = {
 		    "Use with 'percore' event qualifier to show the event "
 		    "counts of one hardware thread by sum up total hardware "
 		    "threads of same physical core"),
+#ifdef HAVE_LIBPFM
+	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
+		"libpfm4 event selector. use 'perf list' to list available events",
+		parse_libpfm_events_option),
+#endif
 	OPT_END()
 };
 
@@ -1871,6 +1880,18 @@ int cmd_stat(int argc, const char **argv)
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 
+#ifdef HAVE_LIBPFM
+	{
+		int ret;
+		ret = pfm_initialize();
+		if (ret != PFM_SUCCESS) {
+			fprintf(stderr,
+				"warning libpfm failed to initialize: %s\n",
+				pfm_strerror(ret));
+		}
+	}
+#endif
+
 	setlocale(LC_ALL, "");
 
 	evsel_list = evlist__new();
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d2539b793f9d..db6da472499b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -84,6 +84,10 @@
 #include <linux/ctype.h>
 #include <perf/mmap.h>
 
+#ifdef HAVE_LIBPFM
+#include <perfmon/pfmlib.h>
+#endif
+
 static volatile int done;
 static volatile int resize;
 
@@ -1545,6 +1549,11 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+#ifdef HAVE_LIBPFM
+	OPT_CALLBACK(0, "pfm-events", &top.evlist, "event",
+		"libpfm4 event selector. use 'perf list' to list available events",
+		parse_libpfm_events_option),
+#endif
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
@@ -1558,6 +1567,17 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		return status;
 
+#ifdef HAVE_LIBPFM
+	{
+		int ret;
+		ret = pfm_initialize();
+		if (ret != PFM_SUCCESS) {
+			ui__warning("warning libpfm failed to initialize: %s\n",
+				pfm_strerror(ret));
+		}
+	}
+#endif
+
 	top.annotation_opts.min_pcnt = 5;
 	top.annotation_opts.context  = 4;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 15ccd193483f..337eb3812eca 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2433,7 +2433,7 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
-		    strchr(name, ':'))
+		    (strchr(name, ':') && !evsel->is_libpfm_event))
 			sep = "";
 
 		if (asprintf(&new_name, "%s%su", name, sep) < 0)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 33804740e2ca..c41d610f74d7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -76,6 +76,7 @@ struct evsel {
 	bool			ignore_missing_thread;
 	bool			forced_leader;
 	bool			use_uncore_alias;
+	bool			is_libpfm_event;
 	/* parse modifier helper */
 	int			exclude_GH;
 	int			sample_read;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 10107747b361..31ed184566c8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -37,6 +37,11 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 
+#ifdef HAVE_LIBPFM
+#include <perfmon/pfmlib_perf_event.h>
+static void print_libpfm_events(bool name_only);
+#endif
+
 #define MAX_NAME_LEN 100
 
 #ifdef PARSER_DEBUG
@@ -2794,6 +2799,10 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 	print_sdt_events(NULL, NULL, name_only);
 
 	metricgroup__print(true, true, NULL, name_only, details_flag);
+
+#ifdef HAVE_LIBPFM
+	print_libpfm_events(name_only);
+#endif
 }
 
 int parse_events__is_hardcoded_term(struct parse_events_term *term)
@@ -3042,3 +3051,240 @@ char *parse_events_formats_error_string(char *additional_terms)
 fail:
 	return NULL;
 }
+
+#ifdef HAVE_LIBPFM
+static int
+parse_libpfm_event(char *strp, struct perf_event_attr *attr)
+{
+	int ret;
+
+	ret = pfm_get_perf_event_encoding(strp, PFM_PLM0|PFM_PLM3,
+					attr, NULL, NULL);
+	return ret;
+}
+
+int parse_libpfm_events_option(const struct option *opt, const char *str,
+			int unset __maybe_unused)
+{
+	struct evlist *evlist = *(struct evlist **)opt->value;
+	struct perf_event_attr attr;
+	struct perf_pmu *pmu;
+	struct evsel *evsel, *grp_leader = NULL;
+	char *p, *q, *p_orig;
+	const char *sep;
+	int grp_evt = -1;
+	int ret;
+
+	p_orig = p = strdup(str);
+	if (!p)
+		return -1;
+	/*
+	 * force loading of the PMU list
+	 */
+	perf_pmu__scan(NULL);
+
+	for (q = p; strsep(&p, ",{}"); q = p) {
+		sep = p ? str + (p - p_orig - 1) : "";
+		if (*sep == '{') {
+			if (grp_evt > -1) {
+				fprintf(stderr, "nested event groups not supported\n");
+				goto error;
+			}
+			grp_evt++;
+		}
+
+		/* no event */
+		if (*q == '\0')
+			continue;
+
+		memset(&attr, 0, sizeof(attr));
+		event_attr_init(&attr);
+
+		ret = parse_libpfm_event(q, &attr);
+		if (ret != PFM_SUCCESS) {
+			fprintf(stderr, "failed to parse event %s : %s\n", str, pfm_strerror(ret));
+			goto error;
+		}
+
+		evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries);
+		if (evsel == NULL)
+			goto error;
+
+		evsel->name = strdup(q);
+		if (!evsel->name) {
+			evsel__delete(evsel);
+			goto error;
+		}
+		evsel->is_libpfm_event = true;
+
+		pmu = perf_pmu__find_by_type((unsigned)attr.type);
+		if (pmu)
+			evsel->core.own_cpus = perf_cpu_map__get(pmu->cpus);
+
+		evlist__add(evlist, evsel);
+
+		if (grp_evt == 0)
+			grp_leader = evsel;
+
+		if (grp_evt > -1) {
+			evsel->leader = grp_leader;
+			grp_leader->core.nr_members++;
+			grp_evt++;
+		}
+
+		if (*sep == '}') {
+			if (grp_evt < 0) {
+				fprintf(stderr, "cannot close a non-existing event group\n");
+				goto error;
+			}
+			evlist->nr_groups++;
+			grp_leader = NULL;
+			grp_evt = -1;
+		}
+	}
+	return 0;
+error:
+	free(p_orig);
+	return -1;
+}
+
+static const char *srcs[PFM_ATTR_CTRL_MAX]={
+	[PFM_ATTR_CTRL_UNKNOWN] = "???",
+	[PFM_ATTR_CTRL_PMU] = "PMU",
+	[PFM_ATTR_CTRL_PERF_EVENT] = "perf_event",
+};
+
+static void
+print_attr_flags(pfm_event_attr_info_t *info)
+{
+	int n = 0;
+
+	if (info->is_dfl) {
+		printf("[default] ");
+		n++;
+	}
+
+	if (info->is_precise) {
+		printf("[precise] ");
+		n++;
+	}
+
+	if (!n)
+		printf("- ");
+}
+
+static void
+print_libpfm_detailed_events(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
+{
+	pfm_event_attr_info_t ainfo;
+	const char *src;
+	int j, ret;
+
+	ainfo.size = sizeof(ainfo);
+
+	printf("\nName  : %s\n", info->name);
+	printf("PMU   : %s\n", pinfo->name);
+	printf("Desc  : %s\n", info->desc);
+	printf("Equiv : %s\n", info->equiv ? info->equiv : "None");
+	printf("Code  : 0x%"PRIx64"\n", info->code);
+
+	pfm_for_each_event_attr(j, info) {
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
+		if (ret != PFM_SUCCESS)
+			continue;
+
+		if (ainfo.ctrl >= PFM_ATTR_CTRL_MAX)
+			ainfo.ctrl = PFM_ATTR_CTRL_UNKNOWN;
+
+		src = srcs[ainfo.ctrl];
+		switch(ainfo.type) {
+		case PFM_ATTR_UMASK:
+			printf("Umask : 0x%02"PRIx64" : %s: [%s] : ", ainfo.code, src, ainfo.name);
+			print_attr_flags(&ainfo);
+			printf(": %s\n", ainfo.desc);
+			break;
+		case PFM_ATTR_MOD_BOOL:
+			printf("Modif : %s: [%s] : %s (boolean)\n", src, ainfo.name, ainfo.desc);
+			break;
+		case PFM_ATTR_MOD_INTEGER:
+			printf("Modif : %s: [%s] : %s (integer)\n", src, ainfo.name, ainfo.desc);
+			break;
+		case PFM_ATTR_NONE:
+		case PFM_ATTR_RAW_UMASK:
+		case PFM_ATTR_MAX:
+		default:
+			printf("Attr  : %s: [%s] : %s\n", src, ainfo.name, ainfo.desc);
+		}
+	}
+}
+
+/*
+ * list all pmu::event:umask, pmu::event
+ * printed events may not be all valid combinations of umask for an event
+ */
+static void
+print_libpfm_simplified_events(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
+{
+	pfm_event_attr_info_t ainfo;
+	int j, ret;
+	int um = 0;
+
+	ainfo.size = sizeof(ainfo);
+
+	pfm_for_each_event_attr(j, info) {
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
+		if (ret != PFM_SUCCESS)
+			continue;
+
+		if (ainfo.type != PFM_ATTR_UMASK)
+			continue;
+
+		printf("%s::%s:%s\n", pinfo->name, info->name, ainfo.name);
+		um++;
+	}
+	if (um == 0)
+		printf("%s::%s\n", pinfo->name, info->name);
+}
+
+static void
+print_libpfm_events(bool name_only)
+{
+	pfm_event_info_t info;
+	pfm_pmu_info_t pinfo;
+	pfm_event_attr_info_t ainfo;
+	int i, p, ret;
+
+	/* initialize to zero to indicate ABI version */
+	info.size  = sizeof(info);
+	pinfo.size = sizeof(pinfo);
+	ainfo.size = sizeof(ainfo);
+
+	putchar('\n');
+
+	pfm_for_all_pmus(p) {
+		ret = pfm_get_pmu_info(p, &pinfo);
+		if (ret != PFM_SUCCESS)
+			continue;
+
+		/* ony print events that are supported by host HW */
+		if (!pinfo.is_present)
+			continue;
+
+		/* handled by perf directly */
+		if (pinfo.pmu == PFM_PMU_PERF_EVENT)
+			continue;
+
+		for (i = pinfo.first_event; i != -1; i = pfm_get_event_next(i)) {
+
+			ret = pfm_get_event_info(i, PFM_OS_PERF_EVENT_EXT, &info);
+			if (ret != PFM_SUCCESS)
+				continue;
+
+			if (!name_only)
+				print_libpfm_detailed_events(&pinfo, &info);
+			else
+				print_libpfm_simplified_events(&pinfo, &info);
+		}
+	}
+}
+#endif
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 27596cbd0ba0..84d4799c9a31 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -37,6 +37,11 @@ int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
+#ifdef HAVE_LIBPFM
+extern int parse_libpfm_events_option(const struct option *opt, const char *str,
+				int unset);
+#endif
+
 #define EVENTS_HELP_MAX (128*1024)
 
 enum perf_pmu_event_symbol_type {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 616fbda7c3fc..11421f5dc9cb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -869,6 +869,17 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, list)
+		if (pmu->type == type)
+			return pmu;
+
+	return NULL;
+}
+
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 {
 	/*
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5fb3f16828df..de3b868d912c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -65,6 +65,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.25.1.696.g5e7596f4ac-goog

