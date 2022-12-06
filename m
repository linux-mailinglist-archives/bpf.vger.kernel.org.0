Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3F644E80
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 23:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLFWWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 17:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLFWWb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 17:22:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5243AEF
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 14:22:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so25517507wrv.10
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMe+dVd5NCnca0fxq7BMWY37ENtlTcvSDlcvk7XOY2w=;
        b=hGbu5/VGxRxg50qkMsOPo8bLyBgo+q91kTTCe8kaBvHJOxYbPX38GVcWeGoDGm/Ymq
         NJA40cb1ccJ8HLNgZAJCmkHWVhPE+9Cfny6puzkdvBxPaqp6iV/Bz/YkzIFEfUwhMm06
         Bqq6MSYtS7kUk7tDGPHtcSnRrRz/KPHnzlgGKLE+YntEA/S4Miw5YaiLe0I9f9wD34Fx
         nSpHgT9O98JO7WwHlBhu5jb5jPdsV6kGWtpIhZ/7H1Q1+HvtbrPykwbfK6KDePI6GH6W
         Uu2aRvejEnDDnr4N1c8ctTN4TgzHndhLy1owF7+qQxbKxjlcgrw2QEr75aFYZSASkU60
         /2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMe+dVd5NCnca0fxq7BMWY37ENtlTcvSDlcvk7XOY2w=;
        b=39mFDfLuWg4iPioKIzJCxiiTXwSWAK/Qxk1UHTLawcFNdS5ZbFuVmHKF9PMJyr4Lho
         SnOTD6GMlA8aFML5RdxsFklpfb2y2XaE/6VNVB/1pMaUm3q8XyPrz9o8IsDEj9a8Uzt8
         iQF1yYib8akAhSVFfYEvCl41DZWK3RpmhL3ougGFKdaC29Hhq+C/iGNMvUUlZmrdNFYB
         0Tq4RlVUyLNDAPSK+vP1FX5cuvOx9yEWgmJ53pifpfJ6AybE91MMk+6LrnYxv5b54xpx
         QMhR0DQVcmqaFZD/0Yx/Tt+4su8b3mU817odaIdV9nKgDFjn85r3e7eqQyA3af1dgpEC
         ALsw==
X-Gm-Message-State: ANoB5pkWqTqPEH1AGniyUDRYlqg5mTxHgZ1rr/jO1TWKkiHH3aAdf2Xs
        /g5nj1OeTn7AIHGHP6QLSzHinEV4ocZIR2VIkHEVTQ==
X-Google-Smtp-Source: AA0mqf5zMrWwGRzkbmuSCyGMTaNHBr6zYZY0ywn56qEJKuvFEFo7BFbRLefMegvZ+n3RUbvGi8uMC4uKP0fOqFAbMP0=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr43870568wrj.40.1670365347456; Tue, 06
 Dec 2022 14:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20221205225940.3079667-3-irogers@google.com> <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org> <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org> <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org> <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org> <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
In-Reply-To: <Y498YP2N3gvFSr/X@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Dec 2022 14:22:15 -0800
Message-ID: <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 9:31 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > >  Now to look at the BUILD_BPF_SKEL=1 kaboom:
> > > > >
> > > > >  [acme@quaco perf]$ alias m
> > > > > alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> > > > > [acme@quaco perf]$ m
> > > > > make: Entering directory '/home/acme/git/perf/tools/perf'
> > > > >   BUILD:   Doing 'make -j8' parallel build
> > > > >   <SNIP>
> > > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> > > > > /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> > > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
> > >
> > > For that bpf_kwork.c see below. Now to see why the python binding is not
> > > building, I guess is unrelated and you have some other outstanding
> > > patch?
> >
> > Its related:
> >
> > [acme@quaco perf]$ perf test -v python
> > Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> >  14: 'import perf' in python                                         :
> > --- start ---
> > test child forked, pid 1669872
> > python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> > Traceback (most recent call last):
> >   File "<stdin>", line 1, in <module>
> > ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: tep_unload_plugins
> > test child finished with -1
> > ---- end ----
> > 'import perf' in python: FAILED!
> > [acme@quaco perf]$
> >
> > Now checking why NO_LIBTRACEEVENT=1 fails with this...
> >
> > [acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep tep_unload_plugins
> > tools/perf/util/trace-event.c:        tep_unload_plugins(t->plugin_list, t->pevent);
> > [acme@quaco perf]$
> >
> > [acme@quaco perf]$ grep trace-event tools/perf/util/python-ext-sources
> > util/trace-event.c
> > [acme@quaco perf]$
> >
> > Trying to fix...
>
> I'm missing some detail, this isn't working, util/trace-event.c is still
> being built and linked.
>
> The python binding should be usable without tracepoints, in fact its
> first usage was just to have access to the perf metaevents, see
> tools/perf/python/twatch.py.

You're right. I'd assumed that if you were disabling libtraceevent
then you'd also disable python. To fix the issue above you can do:

--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -30,7 +30,6 @@ util/rblist.c
util/counts.c
util/print_binary.c
util/strlist.c
-util/trace-event.c
../lib/rbtree.c
util/string.c
util/symbol_fprintf.c

but this needs making conditional (possibly in setup.py) on whether
libtraceevent is present or not.

Thanks,
Ian

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f0e4daeef8120853..5bd67d54d036f281 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -348,6 +348,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>  python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>
>  PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> +ifneq ($(CONFIG_TRACEEVENT),y)
> +  PYTHON_EXT_SRCS := $(call filter-out,$(PYTHON_EXT_SRCS),util/trace-event.c)
> +endif
> +
>  PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
>
>  SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 728fe2f51759eb0d..72088aec2857b316 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1330,6 +1330,9 @@ static struct {
>  static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
>                                   PyObject *args, PyObject *kwargs)
>  {
> +#ifndef HAVE_LIBTRACEEVENT
> +       return NULL;
> +#else
>         struct tep_event *tp_format;
>         static char *kwlist[] = { "sys", "name", NULL };
>         char *sys  = NULL;
> @@ -1344,6 +1347,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
>                 return _PyLong_FromLong(-1);
>
>         return _PyLong_FromLong(tp_format->id);
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>  static PyMethodDef perf__methods[] = {
