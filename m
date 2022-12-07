Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F5645CBF
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGOhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 09:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLGOhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 09:37:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F43E10;
        Wed,  7 Dec 2022 06:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D903161A22;
        Wed,  7 Dec 2022 14:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B35EC433B5;
        Wed,  7 Dec 2022 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423859;
        bh=RAlHgKqZZZm+DQ/f0MYPxHfZBwykr3Y8qGJYKBulNe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scD0kHl4xIu2Mcvt+TzLJwIu92z2/MqOzwITkuEcX8llvbN9MnUT52rHxjyl6GeYt
         /CMX/KemMCGEo0nG5nHa1ot80nAO6Ll/i7UZz9RpeEwuvCU7zJJ38Qah7zKAV12Rgw
         eh6H8qsZYkgW9X7i5Ch9vrdu28s7znO4z1eybD3sImrclphu0UsE/QCL1EI1Las0Ge
         PW6DMOcwPP61/Stgtz7xMMlOevquIMYcGphlYw2AcgysNy+qANbitcoEax1CusUoFU
         eu2KVkEO6tSrWYp1dc0oZSYULnJrOeLNnb6PGg5jdADsbSSv9hc60N7FUS2e+A1uYT
         97LT0GwbWfMNg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67BE140404; Wed,  7 Dec 2022 11:37:36 -0300 (-03)
Date:   Wed, 7 Dec 2022 11:37:36 -0300
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
Subject: Re: [ALMOST ready] Re: [PATCH 2/3] perf build: Use libtraceevent
 from the system
Message-ID: <Y5ClMLqub898mtVs@kernel.org>
References: <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
 <Y5ChXjt0uv/yDNwV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ChXjt0uv/yDNwV@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 11:21:18AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 02:22:15PM -0800, Ian Rogers escreveu:
> > On Tue, Dec 6, 2022 at 9:31 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > I'm missing some detail, this isn't working, util/trace-event.c is still
> > > being built and linked.
> 
> > > The python binding should be usable without tracepoints, in fact its
> > > first usage was just to have access to the perf metaevents, see
> > > tools/perf/python/twatch.py.
> 
> > You're right. I'd assumed that if you were disabling libtraceevent
> > then you'd also disable python. To fix the issue above you can do:
> 
> > --- a/tools/perf/util/python-ext-sources
> > +++ b/tools/perf/util/python-ext-sources
> > @@ -30,7 +30,6 @@ util/rblist.c
> > util/counts.c
> > util/print_binary.c
> > util/strlist.c
> > -util/trace-event.c
> > ../lib/rbtree.c
> > util/string.c
> > util/symbol_fprintf.c
> 
> > but this needs making conditional (possibly in setup.py) on whether
> > libtraceevent is present or not.
> 
> Ok, I fixed this by removing the util/trace-event.c file at setup.py
> time, and removing it from the list of dependencies for python.so build,
> etc.
> 
> With what I have at tmp.perf/core I'm being able to build with
> combinations of:
> 
> - Having or not libtraceevent-devel installed
> 
> - Using NO_LIBTRACEEVENT=1
> 
> - The default build

cross building reveals some more:

  22    11.70 debian:experimental-x-arm64   : FAIL gcc version 12.2.0 (Debian 12.2.0-9)
    arch/arm64/util/kvm-stat.c: In function 'event_get_key':
    arch/arm64/util/kvm-stat.c:30:20: error: implicit declaration of function 'evsel__intval'; did you mean 'evsel__env'? [-Werror=implicit-function-declaration]
       30 |         key->key = evsel__intval(evsel, sample, kvm_exit_reason);
          |                    ^~~~~~~~~~~~~
          |                    evsel__env
    cc1: all warnings being treated as errors
    make[5]: *** [/git/perf-6.1.0-rc6/tools/build/Makefile.build:139: util] Error 2
    make[4]: *** [/git/perf-6.1.0-rc6/tools/build/Makefile.build:139: arm64] Error 2
    make[3]: *** [/git/perf-6.1.0-rc6/tools/build/Makefile.build:139: arch] Error 2

	I'll conditionalise tha one as well...

- Arnaldo
