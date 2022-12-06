Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13C644A50
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 18:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiLFRbW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiLFRbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 12:31:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135B3AC27;
        Tue,  6 Dec 2022 09:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A8E9B81AD8;
        Tue,  6 Dec 2022 17:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C3CC433C1;
        Tue,  6 Dec 2022 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670347875;
        bh=snmpxPifJACWC+QlnTdjg0XeRS/zZ4UR/qij8TeB4YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Poczt2j/3epHE/Xoiro+zons391FS9abt0mgANlfEQo4DuIHj7ueEXSEhkDvCxf1f
         V47ccRG0ikIZDofC/ytGCjwkT83Q0FCJ+Sql44shKo3Mn/QDLtGKzjvYrvph5OtsqJ
         oPEx0b0cEhmrne8IviztOkfSaLlG0o3/LDj7kDRMbCpBAED9Gve/Hut2n0O5lHU3BZ
         HuCA8lz9lF6ZGDq2JpAP+w/3D4qVPCNizY08RCtRX4L93YBbrle9yIxZUAwRx58BnX
         PjD23fFNVCK+n+2LQjEoIKTfWg9Sbfu8tucIbhLT+aPoz4uo5nEm96bNCi7/ISOROb
         apqz+9ghtIa6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B3A940404; Tue,  6 Dec 2022 14:31:12 -0300 (-03)
Date:   Tue, 6 Dec 2022 14:31:12 -0300
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
Message-ID: <Y498YP2N3gvFSr/X@kernel.org>
References: <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y494TNa0ZyPH9YSD@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >  Now to look at the BUILD_BPF_SKEL=1 kaboom:
> > > > 
> > > >  [acme@quaco perf]$ alias m
> > > > alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> > > > [acme@quaco perf]$ m
> > > > make: Entering directory '/home/acme/git/perf/tools/perf'
> > > >   BUILD:   Doing 'make -j8' parallel build
> > > >   <SNIP>
> > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> > > > /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
> > 
> > For that bpf_kwork.c see below. Now to see why the python binding is not
> > building, I guess is unrelated and you have some other outstanding
> > patch?
> 
> Its related:
> 
> [acme@quaco perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>  14: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 1669872
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: tep_unload_plugins
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [acme@quaco perf]$
> 
> Now checking why NO_LIBTRACEEVENT=1 fails with this...
> 
> [acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep tep_unload_plugins
> tools/perf/util/trace-event.c:	tep_unload_plugins(t->plugin_list, t->pevent);
> [acme@quaco perf]$
> 
> [acme@quaco perf]$ grep trace-event tools/perf/util/python-ext-sources
> util/trace-event.c
> [acme@quaco perf]$
> 
> Trying to fix...

I'm missing some detail, this isn't working, util/trace-event.c is still
being built and linked.

The python binding should be usable without tracepoints, in fact its
first usage was just to have access to the perf metaevents, see 
tools/perf/python/twatch.py.

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f0e4daeef8120853..5bd67d54d036f281 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -348,6 +348,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
 PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
+ifneq ($(CONFIG_TRACEEVENT),y)
+  PYTHON_EXT_SRCS := $(call filter-out,$(PYTHON_EXT_SRCS),util/trace-event.c)
+endif
+
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 728fe2f51759eb0d..72088aec2857b316 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1330,6 +1330,9 @@ static struct {
 static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
+#ifndef HAVE_LIBTRACEEVENT
+	return NULL;
+#else
 	struct tep_event *tp_format;
 	static char *kwlist[] = { "sys", "name", NULL };
 	char *sys  = NULL;
@@ -1344,6 +1347,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 		return _PyLong_FromLong(-1);
 
 	return _PyLong_FromLong(tp_format->id);
+#endif // HAVE_LIBTRACEEVENT
 }
 
 static PyMethodDef perf__methods[] = {
