Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5874B361B
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 16:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiBLPyJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 10:54:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiBLPyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 10:54:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43497212
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7722B80759
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 15:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEACC340E7;
        Sat, 12 Feb 2022 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644681236;
        bh=FHbBFbuP9gl/I6ZBenH3Q0NgjaX945Z3jjMY8IXU+t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXNOMC0ilkcFbno0FVPaVcWyM507D4ZO7ADVzneKP8i93olwmZrvFD7M8Mxy0FyqC
         +6ipzbOPBGEbp363BWr8JzLSnsjwkUF5SceG4Fp0kxbghhkjUUllOWdzBkLqobcq+a
         dx2S9ys0qaN2VroVlyMcn/ecxo0z95GqUH+XtIDVKpx5CQGcKPcgGxIrwhle4FfROl
         J1Isp5wYQo9e1cp98SQnmWdF6Y08GHdwOLcafh7t2eXb48FsXjzLO+ny2yoPF/e/P/
         FUi0kq3s0ZFZg3tO+38LdqS/eE8KNxLqZITa8UOFUr6cG5qNE8Qohfqb43kv7EGcRR
         UCFS99IbgCPWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E623400FE; Sat, 12 Feb 2022 12:53:53 -0300 (-03)
Date:   Sat, 12 Feb 2022 12:53:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Christy Lee <christylee@fb.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 0/2] perf: stop using deprecated bpf APIs
Message-ID: <YgfYEdsvP82XEOjx@kernel.org>
References: <20220212073054.1052880-1-andrii@kernel.org>
 <YgfToqR6xR5lq0HI@kernel.org>
 <YgfUEW5pa0eMN3/I@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgfUEW5pa0eMN3/I@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Feb 12, 2022 at 12:36:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Feb 12, 2022 at 12:34:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Feb 11, 2022 at 11:30:52PM -0800, Andrii Nakryiko escreveu:
> > > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> > > remove perf's usage of these deprecated functions. After this patch
> > > set, the only remaining libbpf deprecated APIs in perf would be
> > > bpf_program__set_prep() and bpf_program__nth_fd().
> > 
> > Not applying to perf/core, I'm checking...
> 
> Just some fuzz on the second patch:
> 
> ⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/util/bpf-loader.c
> Hunk #2 succeeded at 111 with fuzz 1 (offset -1 lines).
> Hunk #3 succeeded at 156 (offset -2 lines).
> Hunk #4 succeeded at 1563 (offset 8 lines).
> Hunk #5 succeeded at 1575 (offset 8 lines).
> Hunk #6 succeeded at 1628 (offset 8 lines).
> ⬢[acme@toolbox perf]$
> 
> Applying manually to test on the set of test build containers.

perf test clean, these also work:

# perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c  sleep 1
[root@quaco perf]# perf trace -e tools/perf/examples/bpf/5sec.c  sleep 5s
     0.000 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1994947936, rqtp: 5000000000)
[root@quaco perf]#

containers building:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.17.0-rc3.tar.xz
[perfbuilder@five ~]$ time dm
   1   164.81 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    90.60 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    55.88 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    58.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    65.65 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    69.85 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    66.83 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8: alpine:3.10

I don't expect problems with those, so probably later today I'll push it
to perf/core so that it will be on its way t 5.18.

- Arnaldo
>  
> > ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220212073054.1052880-1-andrii@kernel.org
> > Looking up https://lore.kernel.org/r/20220212073054.1052880-1-andrii%40kernel.org
> > Grabbing thread from lore.kernel.org/all/20220212073054.1052880-1-andrii%40kernel.org/t.mbox.gz
> > Checking for newer revisions on https://lore.kernel.org/all/
> > Analyzing 3 messages in the thread
> > Checking attestation on all messages, may take a moment...
> > ---
> >   [PATCH v5 1/2] perf: Stop using deprecated bpf_load_program() API
> >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     + Link: https://lore.kernel.org/r/20220212073054.1052880-2-andrii@kernel.org
> >     + Cc: kernel-team@fb.com
> >     + Cc: daniel@iogearbox.net
> >     + Cc: ast@kernel.org
> >     + Cc: bpf@vger.kernel.org
> >   [PATCH v5 2/2] perf: Stop using deprecated bpf_object__next() API
> >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     + Link: https://lore.kernel.org/r/20220212073054.1052880-3-andrii@kernel.org
> >     + Cc: kernel-team@fb.com
> >     + Cc: daniel@iogearbox.net
> >     + Cc: ast@kernel.org
> >     + Cc: bpf@vger.kernel.org
> > ---
> > Total patches: 2
> > ---
> > Cover: ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.cover
> >  Link: https://lore.kernel.org/r/20220212073054.1052880-1-andrii@kernel.org
> >  Base: not specified
> >        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.mbx
> > ⬢[acme@toolbox perf]$        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.mbx
> > Applying: perf: Stop using deprecated bpf_load_program() API
> > Applying: perf: Stop using deprecated bpf_object__next() API
> > error: patch failed: tools/perf/util/bpf-loader.c:68
> > error: tools/perf/util/bpf-loader.c: patch does not apply
> > Patch failed at 0002 perf: Stop using deprecated bpf_object__next() API
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > 
> > 
> > - Arnaldo
> >  
> > > v4 -> v5:
> > >   - add bpf_perf_object__add() and use it where appropriate (Jiri);
> > >   - use __maybe_unused in first patch;
> > > v3 -> v4:
> > >   - Fixed commit title
> > >   - Added weak definition for deprecated function
> > > v2 -> v3:
> > >   - Fixed commit message to use upstream perf
> > > v1 -> v2:
> > >   - Added missing commit message
> > >   - Added more details to commit message and added steps to reproduce
> > >     original test case.
> > > 
> > > Christy Lee (2):
> > >   perf: Stop using deprecated bpf_load_program() API
> > >   perf: Stop using deprecated bpf_object__next() API
> > > 
> > >  tools/perf/tests/bpf.c       | 14 ++----
> > >  tools/perf/util/bpf-event.c  | 13 +++++
> > >  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
> > >  3 files changed, 96 insertions(+), 29 deletions(-)
> > > 
> > > -- 
> > > 2.30.2
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
