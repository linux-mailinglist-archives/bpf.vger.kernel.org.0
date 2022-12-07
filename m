Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671C6646038
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLGR2n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiLGR2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 12:28:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE61E082;
        Wed,  7 Dec 2022 09:27:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E821961B59;
        Wed,  7 Dec 2022 17:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2254C433D6;
        Wed,  7 Dec 2022 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434056;
        bh=1UQAqc3NArsAj8c5soetT/92ifyotJrXWMqFGi3bGzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJsM5ONzZz/vnIJQeLTZLgAeCRKu+ZttKzwjATJ6opn7X9HS/TaEE6jmqfGlAv0q0
         ezaOFDVZ0Fjq9b4lLvUrL7z7gdOSCey12Or8gp+AQFB42ahNeHouFjThh+z/cVDNXT
         zerRJxJXLg3d/OYoQrBf6QdR3QP8A1fINwVVXSSQajWg/zfBpitLmGt1ayNRFZmY7G
         5ypM4Q6m5kuXNmPjaQjvPc+dUX5TsxWBXWS5UCWa4lWke5iod0ZAyBqdGbedw8HR+d
         W2+P7xWV3biiyn11tDWJ5XJJeO8y6l+mr+DbwqIdLOIxuk4oB00CmTF7W9DHS5y09m
         FTn0jo5Ic90oA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9060640404; Wed,  7 Dec 2022 14:27:33 -0300 (-03)
Date:   Wed, 7 Dec 2022 14:27:33 -0300
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
Message-ID: <Y5DNBZNC5rBBqlJW@kernel.org>
References: <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 07:08:28PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 06-Dec-2022, at 11:01 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>> Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>> Now to look at the BUILD_BPF_SKEL=1 kaboom:
> >>>>> 
> >>>>> [acme@quaco perf]$ alias m
> >>>>> alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> >>>>> [acme@quaco perf]$ m
> >>>>> make: Entering directory '/home/acme/git/perf/tools/perf'
> >>>>>  BUILD:   Doing 'make -j8' parallel build
> >>>>>  <SNIP>
> >>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> >>>>> /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> >>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
> >>> 
> >>> For that bpf_kwork.c see below. Now to see why the python binding is not
> >>> building, I guess is unrelated and you have some other outstanding
> >>> patch?
> >> 
> >> Its related:
> >> 
> >> [acme@quaco perf]$ perf test -v python
> >> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> >> 14: 'import perf' in python                                         :
> >> --- start ---
> >> test child forked, pid 1669872
> >> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> >> Traceback (most recent call last):
> >>  File "<stdin>", line 1, in <module>
> >> ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: tep_unload_plugins
> >> test child finished with -1
> >> ---- end ----
> >> 'import perf' in python: FAILED!
> >> [acme@quaco perf]$
> >> 
> >> Now checking why NO_LIBTRACEEVENT=1 fails with this...
> >> 
> >> [acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep tep_unload_plugins
> >> tools/perf/util/trace-event.c:	tep_unload_plugins(t->plugin_list, t->pevent);
> >> [acme@quaco perf]$
> >> 
> >> [acme@quaco perf]$ grep trace-event tools/perf/util/python-ext-sources
> >> util/trace-event.c
> >> [acme@quaco perf]$
> >> 
> >> Trying to fix...
> > 
> > I'm missing some detail, this isn't working, util/trace-event.c is still
> > being built and linked.
> 
> Hi,
> 
> Observed similar issue with “builtin-trace.c”
> 
> In system without libtraceevent-devel, I could still see builtin-trace trying to get
> compiled and hitting error. In my understanding, CONFIG_TRACE will be
> disabled when libtraceevent is not present and hence builtin-trace should be disabled
> which I am not seeing.
> 
> # rpm -qa|grep libtraceevent
> libtraceevent-1.2.1-1.el8.ppc64le
> 
> # grep -i traceevent FEATURE-DUMP 
> feature-libtraceevent=0
> 
> Snippet from make logs:
> 
> builtin-trace.c:266:50: error: dereferencing pointer to incomplete type 'struct tep_format_field'
>   return __tp_field__init_uint(field, format_field->size, format_field->offset, needs_swap);
>                                                   ^~
> builtin-trace.c: In function 'evsel__syscall_arg_fmt':
> builtin-trace.c:361:25: error: 'struct evsel' has no member named 'tp_format'
>    et->fmt = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
> 

Can you try again? tmp.perf/core? That "tmp." part means its a force
pushed branch, so I just force pushed with some arch specific fixes, now
I'm down to (removing the successful builds and unrelated failures, now
related to libbpf's F_DUPFD_CLOEXEC kaboom):

   5     7.38 fedora:34                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
          |                                    ^~~~~~~~~~~~~~~~~~~~~
          |                                    TEP_FIELD_IS_FLAG
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undeclared identifier is reported only once for each function it appears in
    error: command '/usr/bin/gcc' failed with exit code 1

  7     7.18 fedora:35                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
          |                                    ^~~~~~~~~~~~~~~~~~~~~
          |                                    TEP_FIELD_IS_FLAG
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undeclared identifier is reported only once for each function it appears in
    error: command '/usr/bin/gcc' failed with exit code 1

  14     8.49 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    tests/parse-events.c:1893:12: error: 'test__checkevent_tracepoint' undeclared here (not in a function); did you mean 'test__checkevent_breakpoint'?
       .check = test__checkevent_tracepoint,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                test__checkevent_breakpoint
    /git/perf-6.1.0-rc6/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2
  16     6.38 ubuntu:22.04                  : FAIL gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
          |                                    ^~~~~~~~~~~~~~~~~~~~~
          |                                    TEP_FIELD_IS_FLAG
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undeclared identifier is reported only once for each function it appears in
    error: command '/usr/bin/gcc' failed with exit code 1


 
> Thanks
> Athira
> 
> > 
> > The python binding should be usable without tracepoints, in fact its
> > first usage was just to have access to the perf metaevents, see 
> > tools/perf/python/twatch.py.
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f0e4daeef8120853..5bd67d54d036f281 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -348,6 +348,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> > python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
> > 
> > PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> > +ifneq ($(CONFIG_TRACEEVENT),y)
> > +  PYTHON_EXT_SRCS := $(call filter-out,$(PYTHON_EXT_SRCS),util/trace-event.c)
> > +endif
> > +
> > PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
> > 
> > SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 728fe2f51759eb0d..72088aec2857b316 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1330,6 +1330,9 @@ static struct {
> > static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
> > 				  PyObject *args, PyObject *kwargs)
> > {
> > +#ifndef HAVE_LIBTRACEEVENT
> > +	return NULL;
> > +#else
> > 	struct tep_event *tp_format;
> > 	static char *kwlist[] = { "sys", "name", NULL };
> > 	char *sys  = NULL;
> > @@ -1344,6 +1347,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
> > 		return _PyLong_FromLong(-1);
> > 
> > 	return _PyLong_FromLong(tp_format->id);
> > +#endif // HAVE_LIBTRACEEVENT
> > }
> > 
> > static PyMethodDef perf__methods[] = {

-- 

- Arnaldo
