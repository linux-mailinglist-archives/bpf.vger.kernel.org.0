Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE9644A0C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 18:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiLFROG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiLFRN6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 12:13:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847E326E6;
        Tue,  6 Dec 2022 09:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F317B81A2B;
        Tue,  6 Dec 2022 17:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123AC433D6;
        Tue,  6 Dec 2022 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670346832;
        bh=KsB0Ju8MsizvtzHecpR38rDWHUZH8j/0c7qfrFnwZVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOxKn2AwWxZIph/bjCBs7X3ZlXrqgMsdcfKnxqLvyHNUfpDP4ziGSd02CQpVrZmPU
         8mkEdJARpnjwVBevk+c2enHwx3varcA/Dk02E7jVT2XE9yITrZHOJgqB0jBfw/Xczq
         /8KmxieJf8itNPbgZFrmzvKTRz9OYiJK1NaeVASxQJtSHsWra4jxRbIh+8xBYWDGBQ
         VDqZtsURlkT5WfTCcW8LWxAUOWEWSGFOLS/d7vHrBSXKw0KP9jI2Mritb3Pm7frzw+
         k2CThCFE3Q4wfrlIs91in1h9jx4/U6bKa5IJFxy5/l861sAl1VJVwjXdANcKv54QRo
         jsSujauE7I46Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7553A40404; Tue,  6 Dec 2022 14:13:48 -0300 (-03)
Date:   Tue, 6 Dec 2022 14:13:48 -0300
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
Message-ID: <Y494TNa0ZyPH9YSD@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4921D+36UGdhK92@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >  Now to look at the BUILD_BPF_SKEL=1 kaboom:
> > > 
> > >  [acme@quaco perf]$ alias m
> > > alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> > > [acme@quaco perf]$ m
> > > make: Entering directory '/home/acme/git/perf/tools/perf'
> > >   BUILD:   Doing 'make -j8' parallel build
> > >   <SNIP>
> > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> > > /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
> 
> For that bpf_kwork.c see below. Now to see why the python binding is not
> building, I guess is unrelated and you have some other outstanding
> patch?

Its related:

[acme@quaco perf]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 14: 'import perf' in python                                         :
--- start ---
test child forked, pid 1669872
python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: tep_unload_plugins
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[acme@quaco perf]$

Now checking why NO_LIBTRACEEVENT=1 fails with this...

[acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep tep_unload_plugins
tools/perf/util/trace-event.c:	tep_unload_plugins(t->plugin_list, t->pevent);
[acme@quaco perf]$

[acme@quaco perf]$ grep trace-event tools/perf/util/python-ext-sources
util/trace-event.c
[acme@quaco perf]$

Trying to fix...
