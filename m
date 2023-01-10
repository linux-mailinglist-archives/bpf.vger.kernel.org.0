Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB749664203
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjAJNgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 08:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbjAJNgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A3B75;
        Tue, 10 Jan 2023 05:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3B361720;
        Tue, 10 Jan 2023 13:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A3DC433F0;
        Tue, 10 Jan 2023 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673357794;
        bh=gGfL/eJ/z0tpwho+taR5L5/UD30+cWLl7CbY0arl1Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aopCdEAhD6dlbwTmHV4D0e8brCqiAZWBBSV4MZ756V/rVpSD1JDG4BIOuYOBLsWUV
         jQ1FiExpeLcJxYy+oFSFnzdBrQQYVF+BV96LsK1eQ2NzmjL7Oi/7qp2reKpKav5b1C
         PFfgZQzI+uLjCE6qofHZLibKGK+RPxvTBv1EZbsn6hmNYEZXuoP2LiTJv4HsDd7sQw
         vlvCf+yoeL0+ahzhFgSe7IDzsWl4JjPOuoQKdGCIvc9ooWjO9Hl3tNVUYMUlNeqeVM
         4hgV8KHEOhQOmR1rkMyo3PbmCnOhKRUWdLoBpYG8Qu0RkzPxGLcczXfxg9FiEPY2yX
         FR9KzqQvpAlPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DAD4140468; Tue, 10 Jan 2023 10:36:31 -0300 (-03)
Date:   Tue, 10 Jan 2023 10:36:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v1 0/3] Assume libbpf 1.0 in build
Message-ID: <Y71p30zGtzUtrvt2@kernel.org>
References: <20230109203424.1157561-1-irogers@google.com>
 <Y71bcMYQ26eroc2W@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71bcMYQ26eroc2W@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 10, 2023 at 01:34:56PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 09, 2023 at 12:34:21PM -0800, Ian Rogers wrote:
> > libbpf 1.0 was a major change in API. Perf has partially supported
> > older libbpf's but an implementation may be:
> > ..
> >        pr_err("%s: not support, update libbpf\n", __func__);
> >        return -ENOTSUP;
> > ..
> > 
> > Rather than build a binary that would fail at runtime it is
> > preferrential just to build libbpf statically and link against
> > that. The static version is in the kernel tools tree and newer than
> > 1.0.
> > 
> > These patches change the libbpf test to only pass when at least
> > version 1.0 is installed, then remove the conditional build and
> > feature logic.
> > 
> > The issue is discussed here:
> > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> > 
> > Ian Rogers (3):
> >   tools build: Pass libbpf feature only if libbpf 1.0+
> >   perf build: Remove libbpf pre-1.0 feature tests
> >   perf bpf: Remove pre libbpf 1.0 conditional logic
> > 
> >  tools/build/feature/Makefile                  |  7 --
> >  .../feature/test-libbpf-bpf_map_create.c      |  8 ---
> >  .../test-libbpf-bpf_object__next_map.c        |  8 ---
> >  .../test-libbpf-bpf_object__next_program.c    |  8 ---
> >  .../build/feature/test-libbpf-bpf_prog_load.c |  9 ---
> >  .../test-libbpf-bpf_program__set_insns.c      |  8 ---
> >  .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ---
> >  .../build/feature/test-libbpf-btf__raw_data.c |  8 ---
> >  tools/build/feature/test-libbpf.c             |  4 ++
> >  tools/perf/Makefile.config                    | 37 +----------
> >  tools/perf/util/bpf-event.c                   | 66 -------------------
> >  tools/perf/util/bpf-loader.c                  | 18 -----
> >  tools/perf/util/bpf_counter.c                 | 18 -----
> >  13 files changed, 5 insertions(+), 202 deletions(-)
> 
> nice, I like that.. I was able to build perf on fedora
> with (dynamic) and without (static) libbpf 1.0 
> 
> I hope supporting allowing dynamic link just with libbpf 1.0
> won't mess up backport world too much.. cc-ing Michael

Yeah, would be nice to hear from Michael and other distro maintainers.

- Arnaldo
 
> other than that looks ok to me
> 
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> 
> also for the 2 dependency patches

ok!
