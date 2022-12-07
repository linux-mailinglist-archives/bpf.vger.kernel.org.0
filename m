Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B01645C5C
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 15:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLGOWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLGOWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 09:22:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960E75E9F1;
        Wed,  7 Dec 2022 06:21:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E917617A9;
        Wed,  7 Dec 2022 14:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0B2C43470;
        Wed,  7 Dec 2022 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670422886;
        bh=Vq+1zbnALAVR/bXbiL4kGEpeHaDup7n5+bWnDGI/Z/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQIgC9mEDoliWZoPRKeGCGk9NjFirB5OLWbV34iYAEeBg6hlA+dnWdT/wrRbAMFjs
         IH2o9om063+5xJNLlgTChMqjUjiIiRw3k1eIxhGNqE1VQEi4alBmAn2mMzCgIuSx8/
         Ck/ULY3vQR3rzY+Xjd/ZrNL7wBM/BoxXeSWuYXQuzZ3cHs+IYZVEMD7PJ40LR02r4I
         KJUsHKqeQje/d278d14XoMmKHcyo9Ak0LxZnqQgffWJ4O7CMje7CSksjRpOb+HE5M3
         QusnLPHQ3O5rKmU1r/LlDwNqsNGizc7b/A17Ba852BlrlVIB9Q2CW62ASMJs5DkriQ
         fPrmWr8NUY+eg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF83640404; Wed,  7 Dec 2022 11:21:18 -0300 (-03)
Date:   Wed, 7 Dec 2022 11:21:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: [ALMOST ready] Re: [PATCH 2/3] perf build: Use libtraceevent from
 the system
Message-ID: <Y5ChXjt0uv/yDNwV@kernel.org>
References: <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 02:22:15PM -0800, Ian Rogers escreveu:
> On Tue, Dec 6, 2022 at 9:31 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > I'm missing some detail, this isn't working, util/trace-event.c is still
> > being built and linked.

> > The python binding should be usable without tracepoints, in fact its
> > first usage was just to have access to the perf metaevents, see
> > tools/perf/python/twatch.py.

> You're right. I'd assumed that if you were disabling libtraceevent
> then you'd also disable python. To fix the issue above you can do:

> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -30,7 +30,6 @@ util/rblist.c
> util/counts.c
> util/print_binary.c
> util/strlist.c
> -util/trace-event.c
> ../lib/rbtree.c
> util/string.c
> util/symbol_fprintf.c

> but this needs making conditional (possibly in setup.py) on whether
> libtraceevent is present or not.

Ok, I fixed this by removing the util/trace-event.c file at setup.py
time, and removing it from the list of dependencies for python.so build,
etc.

With what I have at tmp.perf/core I'm being able to build with
combinations of:

- Having or not libtraceevent-devel installed

- Using NO_LIBTRACEEVENT=1

- The default build

All mixed up, but I wasn't so judicious so far, we need to add an entry
with NO_LIBTRACEVENT=1 to tools/perf/tests/, etc.

One thing I'm doing now is testing with the container builds, and I'm
afraid we have to delay deleting the in-kernel old copy of
tools/lib/traceevent till distros that don't ship libtraceevent as a
separate package are EOLed.

We need in those cases to fallback to tools/lib/traceevent/, with a
warning probably.

I'm now updating my container build recipes to install
libtraceevent-devel, when available, which isn't the case, for instance,
for almalinux:8, the first I tried updating.

Please take a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core

The HEAD for that branch has the list of changes I made to get this
going.

Also I have the feeling the warning about libtraceevent not being
available should be made more proeminent and detailed in what gets
removed if this new, important dependency isn't met...

I agree removing libtraceevent and adding yet another dependency to
building perf is important since the libtraceevent maintainers took the
decision of having it moved away from the kernel sources, but since this
has been a no-brainer for so long, the fallout of this decision may be
noticeable.

At least by now we have clear markings of where libtraceevent is used.

Thanks,

- Arnaldo
