Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4B64CF08
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiLNSAp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLNSAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 13:00:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D62118F;
        Wed, 14 Dec 2022 10:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DA761B7C;
        Wed, 14 Dec 2022 18:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108B1C433EF;
        Wed, 14 Dec 2022 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671040838;
        bh=ycP/twmY80DAFepI8zsjXHwKZ9qlK+h73kG8djRCuFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwVj7nUssyX3cxXiLDIru4jq6NwZ3wlGHnYRAuD38PmMT47Y5A0CQvyMOxR5JKZHa
         FnL1OA0EkbbF4TLhsC0mEt1CVazM+SJ8pjn8FAl4x8Fkbj3TY8UJCmfxndIAiWYfyb
         La902drK8WbLttJbg7KQUHQ9dCS5Z+xmmmu/MNsLKVhs+sda7RjGkzLQAZn47CJR1B
         fMXWfwRUGnRokdw/VBC6bKfOM2r4EzWoyVZCXvfsWBSu99md2pash3OpZAh+LRDbu6
         Xe064y9MDwuZq4XetOmIyFG5uVJM3taTXPNB6LXAtX7jFcZUTgTA1qgdRgGJs4OEtj
         NtZtPgpINq29Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 782AC40367; Wed, 14 Dec 2022 15:00:35 -0300 (-03)
Date:   Wed, 14 Dec 2022 15:00:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/5] build/libtraceevent resends
Message-ID: <Y5oPQ0Cf/9JGME3n@kernel.org>
References: <20221213232651.1269909-1-irogers@google.com>
 <Y5ncNQfPzq8qBP/f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5ncNQfPzq8qBP/f@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 14, 2022 at 11:22:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 13, 2022 at 03:26:46PM -0800, Ian Rogers escreveu:
> > All patches on the acme perf/core branch.
> > 
> > Resend incremental build fix python plugin:
> > https://lore.kernel.org/lkml/20221205225940.3079667-4-irogers@google.com/
> > 
> > Break apart and resend libtraceevent debug logging support:
> > https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
> > 
> > Switch "#if HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE" to "#if
> > MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION",
> > ensuring trace-event.h is included as discussed on the mailing list.
> > 
> > Resend removal of --group option:
> > https://lore.kernel.org/lkml/20220707195610.303254-1-irogers@google.com/
> 
> Thanks, applied.

Building on arm64:

/home/acme/git/perf/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
/home/acme/git/perf/tools/perf/util/evsel.c:2787:65: error: operator '<=' has no right operand
 2787 | #if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
      |                                                                 ^
error: command '/usr/bin/gcc' failed with exit code 1
cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory

make[2]: *** [Makefile.perf:651: /tmp/build/perf/python/perf.cpython-310-aarch64-linux-gnu.so] Error 1
make[2]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o

Trying to fix...
 
> - Arnaldo
> 
>  
> > Ian Rogers (5):
> >   perf build: Fix python/perf.so library's name
> >   perf trace-event: Add libtraceevent version tools to header
> >   libtraceevent: Increase libtraceevent logging when verbose
> >   perf trace-event: Use version check to avoid 1 define
> >   perf evlist: Remove group option.
> > 
> >  tools/perf/Documentation/perf-record.txt      |  4 ----
> >  tools/perf/Documentation/perf-top.txt         |  7 ++----
> >  tools/perf/Makefile.config                    |  8 +++----
> >  tools/perf/Makefile.perf                      |  2 +-
> >  tools/perf/builtin-record.c                   |  2 --
> >  tools/perf/builtin-stat.c                     |  6 -----
> >  tools/perf/builtin-top.c                      |  2 --
> >  tools/perf/builtin-trace.c                    |  2 +-
> >  tools/perf/tests/attr/README                  |  2 --
> >  tools/perf/tests/attr/test-record-group       | 22 -------------------
> >  tools/perf/tests/attr/test-stat-group         | 17 --------------
> >  tools/perf/util/data-convert-bt.c             |  3 ++-
> >  tools/perf/util/debug.c                       | 10 +++++++++
> >  tools/perf/util/evlist.c                      |  2 +-
> >  tools/perf/util/evlist.h                      |  2 --
> >  tools/perf/util/evsel.c                       |  2 +-
> >  tools/perf/util/python.c                      | 10 +--------
> >  tools/perf/util/record.c                      |  7 ------
> >  tools/perf/util/record.h                      |  1 -
> >  .../util/scripting-engines/trace-event-perl.c |  2 +-
> >  .../scripting-engines/trace-event-python.c    |  2 +-
> >  tools/perf/util/sort.c                        |  3 ++-
> >  tools/perf/util/trace-event.h                 | 13 +++++++++++
> >  23 files changed, 39 insertions(+), 92 deletions(-)
> >  delete mode 100644 tools/perf/tests/attr/test-record-group
> >  delete mode 100644 tools/perf/tests/attr/test-stat-group
> > 
> > -- 
> > 2.39.0.314.g84b9a713c41-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
