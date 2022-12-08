Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05168647893
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 23:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLHWG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 17:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiLHWGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 17:06:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC1E80A1E;
        Thu,  8 Dec 2022 14:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18896209A;
        Thu,  8 Dec 2022 22:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF04BC433D2;
        Thu,  8 Dec 2022 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670537095;
        bh=0NWar9VWAsNfrAByzGGMqW+t71CDC5S1WJPgpSCdztI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV8Qgl/t1KaENYj6yKz5r/jQZql1GpsY3F+r3qjw08TJCRd0hq0rTv7nbB3zWmqVV
         3VFHvG7obPt0N38c+VQeHs6LATr3HHyG5na31cuX5TskJ3sWxm8uy7xzpIyFjY7PY2
         YgYCmJIz///+GK98hwI7F389/lxKMY19dZYzvvlBN2VN9JPK4tXxVEmXSsAVahjTLx
         cKqbnm5x+NEJe40IJneAIVA01b6lHZE+fGYtI5mk3gP9zWdYt/xReXfS/QPO0ZcxIR
         dJ+OAI6Tqzur4ntYstJ5hgFky75xWTz/KxI3NPLBQ50yq3tAwguXBe9UJLrud5mQd9
         LWCKLl0m8b0lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 065DD40404; Thu,  8 Dec 2022 19:04:51 -0300 (-03)
Date:   Thu, 8 Dec 2022 19:04:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y5JfgyN59dSeKbUP@kernel.org>
References: <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> > On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Can you try again? tmp.perf/core? That "tmp." part means its a force
> > pushed branch, so I just force pushed with some arch specific fixes, now
> > I'm down to (removing the successful builds and unrelated failures, now
> > related to libbpf's F_DUPFD_CLOEXEC kaboom):

> Ok Arnaldo, Sure, I will check with updated branch

> >   5     7.38 fedora:34                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
> >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
> >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
> >     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> >          |                                    ^~~~~~~~~~~~~~~~~~~~~
> >          |                                    TEP_FIELD_IS_FLAG

> I observed same issue as updated here: 
> https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@linux.vnet.ibm.com/

> Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the system installed version.
> whereas it is there in header file in tools/lib/traceevent

> # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> 	TEP_FIELD_IS_RELATIVE	= 256,

Right, I had noticed that as well, so as a prep patch I'm adding the
patch below, before Ian's. Please check and provide an
Acked-by/Tested-by/Reviewed-by if possible.

- Arnaldo

commit d288f6c03038e8f14f0b53bd4ccc03f664c8c744
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Dec 8 18:26:05 2022 -0300

    perf tools: Add test to check if libtracevent has TEP_FIELD_IS_RELATIVE
    
    Some distros have older versions of libtraceevent where
    TEP_FIELD_IS_RELATIVE and its associated semantics are not present, so
    we need to test for its presence and cope when it isn't present when
    building with LIBTRACEEVENT_DYNAMIC=1.
    
    Reported-by: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>,
    Cc: Stephane Eranian <eranian@google.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 38f8851bd7cbdb0e..c6c9b7c7723d4290 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=                  \
         libzstd				\
         disassembler-four-args		\
         disassembler-init-styled	\
-        file-handle
+        file-handle			\
+        libtraceevent-tep_field_is_relative
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 690fe97be1904399..b568be802dc873ed 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -81,7 +81,8 @@ FILES=                                          \
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
          test-file-handle.bin			\
-         test-libpfm4.bin
+         test-libpfm4.bin			\
+         test-libtraceevent-tep_field_is_relative
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -92,7 +93,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap -ltraceevent
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -159,6 +160,9 @@ $(OUTPUT)test-dwarf_getlocations.bin:
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libtraceevent-tep_field_is_relative.bin:
+	$(BUILD) -ltraceevent
+
 $(OUTPUT)test-libelf-gelf_getnote.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libtraceevent-tep_field_is_relative.c b/tools/build/feature/test-libtraceevent-tep_field_is_relative.c
new file mode 100644
index 0000000000000000..b0664d727d1bf452
--- /dev/null
+++ b/tools/build/feature/test-libtraceevent-tep_field_is_relative.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <traceevent/event-parse.h>
+
+int main(void)
+{
+	return TEP_FIELD_IS_RELATIVE;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9cc3c48f32881c8b..3d0694bece5ed08b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1192,9 +1192,14 @@ ifdef LIBTRACEEVENT_DYNAMIC
     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
-  else
-    dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
+    $(call feature_check,libtraceevent-tep_field_is_relative)
+    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
+      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+    endif
   endif
+else
+  # Its the in-kernel tools/lib/traceevent/, so we _have_ TEP_FIELD_IS_RELATIVE
+  CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 endif
 
 ifdef LIBTRACEFS_DYNAMIC
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 543c379d2a57a05a..e38c3b4fc5a69160 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2726,8 +2726,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
-					offset += field->offset + field->size;
+				offset += traceevent__field_adjust_relative_offset(field);
 			}
 
 			val = (uintptr_t)(sample->raw_data + offset);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index c65cdaf6975eddeb..955b2a110c7f0b33 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -319,8 +319,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
-		if (flags & TEP_FIELD_IS_RELATIVE)
-			offset += fmtf->offset + fmtf->size;
+		offset += traceevent__field_adjust_relative_offset(fmtf);
 	}
 
 	if (flags & TEP_FIELD_IS_ARRAY) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0f617359a82f2891..45a4090c78337b4d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2776,8 +2776,7 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
-		if (field->flags & TEP_FIELD_IS_RELATIVE)
-			offset += field->offset + field->size;
+		offset += traceevent__field_adjust_relative_offset(field);
 	}
 
 	return sample->raw_data + offset;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b5941c74a0d64e10..e46d6de537b1c448 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -439,8 +439,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
-			if (field->flags & TEP_FIELD_IS_RELATIVE)
-				offset += field->offset + field->size;
+			offset += traceevent__field_adjust_relative_offset(field);
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 5b602b6d46854133..05814d0c99a43171 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -392,8 +392,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
-					offset += field->offset + field->size;
+				offset += traceevent__field_adjust_relative_offset(field);
 			} else
 				offset = field->offset;
 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d685a7399ee2e6c1..4bceba8dde6e05a0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -993,8 +993,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
-					offset += field->offset + field->size;
+				offset += traceevent__field_adjust_relative_offset(field);
 			}
 			if (field->flags & TEP_FIELD_IS_STRING &&
 			    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2e7330867e2efd42..dbabe83be43f6095 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -23,6 +23,7 @@
 #include "strlist.h"
 #include "strbuf.h"
 #include <traceevent/event-parse.h>
+#include "trace-event.h"
 #include "mem-events.h"
 #include "annotate.h"
 #include "event.h"
@@ -2543,9 +2544,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
-		if (field->flags & TEP_FIELD_IS_RELATIVE)
-			offset += field->offset + field->size;
-
+		offset += traceevent__field_adjust_relative_offset(field);
 		/* record max width for output */
 		if (size > hde->dynamic_len)
 			hde->dynamic_len = size;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 8f39f5bcb2c268fd..78246e6fb25a620b 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -2,6 +2,7 @@
 #ifndef _PERF_UTIL_TRACE_EVENT_H
 #define _PERF_UTIL_TRACE_EVENT_H
 
+#include <linux/compiler.h>
 #include <traceevent/event-parse.h>
 #include "parse-events.h"
 
@@ -129,4 +130,14 @@ int common_lock_depth(struct scripting_context *context);
 #define SAMPLE_FLAGS_BUF_SIZE 64
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
 
+
+static inline int traceevent__field_adjust_relative_offset(struct tep_format_field *field __maybe_unused)
+{
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+	if (field->flags & TEP_FIELD_IS_RELATIVE)
+		return field->offset + field->size;
+#endif
+	return 0;
+}
+
 #endif /* _PERF_UTIL_TRACE_EVENT_H */
