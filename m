Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC064497C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiLFQjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLFQih (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:38:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67629388;
        Tue,  6 Dec 2022 08:37:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8A94B81ABD;
        Tue,  6 Dec 2022 16:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D1FC433D6;
        Tue,  6 Dec 2022 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670344651;
        bh=43JDAbkBEGAA3/Cg7gkSlHzPqkEC6DnyOycMW5olQ64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVzsQ+2G4rwumKBqEXklvMN3y0EMK/DyeRN2EUWgJFcwcOzcXoGCHcK+odMDgSBBL
         z8v/aXrac1b1VAJVmFHyQ9fVMGpj2DaQPJ4iUsUiBHw0ZFBxORQJPMKS31pd5TUJET
         1amlbvB+JhWXADcqn16v6Jimvg99fbf5LWmZqbxuIKV6BhitbdKzBgZGkb+6i3qv5p
         JpfvdAvIzM5NY1qi7sB/gF1fT3tDUdPbPRp1WJilCA4MM7UmCJ4QlE6b7DBfwVuR3D
         zqIWPwL2rKNqSr/SYTdd5dU7SitmYbNrYBSPXSbbfwO0YhV6utS6NGJDh8xST8jzbV
         Hsc/NlD8YmIbg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A9C540404; Tue,  6 Dec 2022 13:37:27 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:37:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y49vx0v6Z7EiR8jr@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y49uKfzfCoZ1ok62@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 01:30:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 01:23:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 06, 2022 at 01:20:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > 
> > > util/scripting-engines/trace-event-perl.c:104:43: error: ‘struct tep_print_flag_sym’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> > >   104 | static void define_symbolic_values(struct tep_print_flag_sym *field,
> > >       |                                           ^~~~~~~~~~~~~~~~~~
> > > util/scripting-engines/trace-event-perl.c: In function ‘define_symbolic_values’:
> > 
> > This cured it, folding into your patch:
> > 
> > diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> > index 5b602b6d46854133..0bacb49408f84adf 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> > @@ -27,6 +27,7 @@
> >  #include <errno.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/time64.h>
> > +#include <traceevent/event-parse.h>
> >  
> >  #include <stdbool.h>
> >  /* perl needs the following define, right after including stdbool.h */
> 
> Building with NO_LIBTRACEEVENT=1 I get:
> 
>   CC      /tmp/build/perf/util/cap.o
> util/data-convert-bt.c: In function ‘get_tracepoint_field_type’:
> util/data-convert-bt.c:194:36: error: invalid use of undefined type ‘struct tep_format_field’
>   194 |         unsigned long flags = field->flags;
>       |                                    ^~
> util/data-convert-bt.c:196:21: error: ‘TEP_FIELD_IS_STRING’ undeclared (first use in this function)
>   196 |         if (flags & TEP_FIELD_IS_STRING)
>       |                     ^~~~~~~~~~~~~~~~~~~
> util/data-convert-bt.c:196:21: note: each undeclared identifier is reported only once for each function it appears in
> util/data-convert-bt.c:199:23: error: ‘TEP_FIELD_IS_SIGNED’ undeclared (first use in this function)
>   199 |         if (!(flags & TEP_FIELD_IS_SIGNED)) {
>       |                       ^~~~~~~~~~~~~~~~~~~
> util/data-convert-bt.c:201:29: error: ‘TEP_FIELD_IS_LONG’ undeclared (first use in this function)
>   201 |                 if (flags & TEP_FIELD_IS_LONG || flags & TEP_FIELD_IS_POINTER)
>       |                             ^~~~~~~~~~~~~~~~~
> 
> 
> working on it...

Below makes it progress a bit, now to look at the perl Context stuff.

diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index c22d82d2a73c4d96..b2a9a3b7f68d7f6f 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -78,12 +78,13 @@ static int cmd_data_convert(int argc, const char **argv)
 		return bt_convert__perf2json(input_name, to_json, &opts);
 
 	if (to_ctf) {
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
+#if defined(HAVE_LIBBABELTRACE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 		return bt_convert__perf2ctf(input_name, to_ctf, &opts);
 #else
 		pr_err("The libbabeltrace support is not compiled in. perf should be "
 		       "compiled with environment variables LIBBABELTRACE=1 and "
-		       "LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
+		       "LIBBABELTRACE_DIR=/path/to/libbabeltrace/.\n"
+		       "Check also if libbtraceevent devel files are available.\n");
 		return -1;
 #endif
 	}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c7993fb025cf180f..255bc751d19452f2 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -189,7 +189,10 @@ perf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 perf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
 perf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
-perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+ifeq ($(CONFIG_TRACEEVENT),y)
+  perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+endif
+
 perf-y += data-convert-json.o
 
 perf-y += scripting-engines/
