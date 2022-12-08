Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAF6478D5
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 23:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLHWcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 17:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLHWcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 17:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291482F8E;
        Thu,  8 Dec 2022 14:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A39546208B;
        Thu,  8 Dec 2022 22:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1473C433EF;
        Thu,  8 Dec 2022 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670538739;
        bh=evwi1owXfAjUulYHfyWRVMiT7mWVW8ks0w7ZzmsuDjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ4OoGla/sYbqBJ5LjwvRpK6H9x+J/+LiiGO4xL0QKUy1PkUA142XNzUjMWYu7iWw
         kWW+SfQTPYvUGNjhikqNy1/6TyT8hdfzXLNTUsMHSksfkkIGxx6pn5Nlf+PBnrQMLQ
         xqzhLy4SteTsauY+fLuzmk5EjfLsVZD54XNq97t/aW+AVBZgpKrHk1ZKszsdOgmWHz
         XDbi40c2PedKThZOWeWs4paJVTaUmLy0ecunnsL5UK3fiEWiD/x3o2xf5Hp2yscu9W
         50PX6z/VTePd93LKJIvS179QXmlyZgLgf1LsSnbvKBjKOyGEX14q5d+YtayH1YQTTU
         O9935CLz/P12g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09D0840404; Thu,  8 Dec 2022 19:32:16 -0300 (-03)
Date:   Thu, 8 Dec 2022 19:32:16 -0300
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
Message-ID: <Y5Jl8MeW90DXy1wT@kernel.org>
References: <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5JfgyN59dSeKbUP@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> > > On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Can you try again? tmp.perf/core? That "tmp." part means its a force
> > > pushed branch, so I just force pushed with some arch specific fixes, now
> > > I'm down to (removing the successful builds and unrelated failures, now
> > > related to libbpf's F_DUPFD_CLOEXEC kaboom):
> 
> > Ok Arnaldo, Sure, I will check with updated branch
> 
> > >   5     7.38 fedora:34                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
> > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
> > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
> > >     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> > >          |                                    ^~~~~~~~~~~~~~~~~~~~~
> > >          |                                    TEP_FIELD_IS_FLAG
> 
> > I observed same issue as updated here: 
> > https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@linux.vnet.ibm.com/
> 
> > Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the system installed version.
> > whereas it is there in header file in tools/lib/traceevent
> 
> > # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> > # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> > 	TEP_FIELD_IS_RELATIVE	= 256,
> 
> Right, I had noticed that as well, so as a prep patch I'm adding the
> patch below, before Ian's. Please check and provide an
> Acked-by/Tested-by/Reviewed-by if possible.

I ended up with the one below, _after_ Ian's patch as I had some trouble grafting
it before and had already tested it this way multiple times, I'm pushing
this to tmp/perf.core.

- Arnaldo

commit a0ec3ef4590e7e82339b6f318e671a6b69fd94e8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Dec 8 19:28:58 2022 -0300

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
index 690fe97be1904399..24246df35ac30eeb 100644
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
 
@@ -159,6 +160,9 @@ $(OUTPUT)test-dwarf_getlocations.bin:
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libtraceevent-tep_field_is_relative.bin:
+	$(BUILD) -ltraceevent
+
 $(OUTPUT)test-libelf-gelf_getnote.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 680228e19c1aabdb..e29975664f06bd61 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1197,6 +1197,10 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
+    $(call feature_check,libtraceevent-tep_field_is_relative)
+    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
+      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+    endif
   else
     dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
   endif
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6909cd9f48d11644..c9802ab549d7782f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,8 +2729,10 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
+#endif
 			}
 
 			val = (uintptr_t)(sample->raw_data + offset);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 8031b586e81384e7..b842273458b862bd 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -322,8 +322,10 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 		if (flags & TEP_FIELD_IS_RELATIVE)
 			offset += fmtf->offset + fmtf->size;
+#endif
 	}
 
 	if (flags & TEP_FIELD_IS_ARRAY) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ca911856c4b1d3c8..77b2cf5a214ec1e4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2784,8 +2784,10 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
+#endif
 	}
 
 	return sample->raw_data + offset;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6fb84b7455b8392d..7320f7f777fe0e56 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -442,8 +442,10 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 			if (field->flags & TEP_FIELD_IS_RELATIVE)
 				offset += field->offset + field->size;
+#endif
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 0bacb49408f84adf..c097b7934fd4ebe9 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -393,8 +393,10 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
+#endif
 			} else
 				offset = field->offset;
 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fabba21919b8fa51..e930f5f1f36d2831 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -994,8 +994,10 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
+#endif
 			}
 			if (field->flags & TEP_FIELD_IS_STRING &&
 			    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c7a97b33e13477e1..0ecc2cb137920d2d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2568,9 +2568,10 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
+#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
-
+#endif
 		/* record max width for output */
 		if (size > hde->dynamic_len)
 			hde->dynamic_len = size;
