Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021FD4B5A51
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 20:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiBNTCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 14:02:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiBNTCZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 14:02:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F81E0AC3;
        Mon, 14 Feb 2022 11:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22DB6100E;
        Mon, 14 Feb 2022 18:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89C5C340EB;
        Mon, 14 Feb 2022 18:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644865111;
        bh=VukAa+dZeTjvFUjn9roKAh250Gj/iOALvuK2MqtR2yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJreXoF9oRYe1h5H0mpwNLQjOWgriyAjB5CVerjXtooSDmps/Zi7FB3jTOIQd1gQA
         Ip1nWGzhvTBZnDvy2Z8YY/UJATwqzE6A0v/TqmUnsm+VzfDlllFVaeSAGGaIULTu0a
         1HbiO5sZ3zZ93L7HKDMKr+GYmz4H/bH0Pm+sZnCx6yGpY2gw+iXn6iGXh+sBXqtWp9
         p74tT7/v2hAmxrgHcCFqPCVPEfIrrTneMlQmTXswmBIDMOCyRMIcs9NS394bVxIZ3G
         kLbIKRa34uj7RpkeBU305qjPaksZjMm06S7VsGK5ir8EaG50o7Q1IZAVEnsjCB1hpf
         eZ28YYdUXsWPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4592D400FE; Mon, 14 Feb 2022 15:58:28 -0300 (-03)
Date:   Mon, 14 Feb 2022 15:58:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Christy Lee <christylee@fb.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 perf/core 0/2] perf: stop using deprecated bpf APIs
Message-ID: <YgqmVOhBzkb3EyYh@kernel.org>
References: <20220212155125.3406232-1-andrii@kernel.org>
 <Ygf56M45VuWfippn@krava>
 <CAEf4Bzav96MoZh08s7UZfnLQPTRbF+UvuWA75r0GPkYTRGdsYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzav96MoZh08s7UZfnLQPTRbF+UvuWA75r0GPkYTRGdsYg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Feb 12, 2022 at 05:47:25PM -0800, Andrii Nakryiko escreveu:
> On Sat, Feb 12, 2022 at 10:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Feb 12, 2022 at 07:51:23AM -0800, Andrii Nakryiko wrote:
> > > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> > > remove perf's usage of these deprecated functions. After this patch
> > > set, the only remaining libbpf deprecated APIs in perf would be
> > > bpf_program__set_prep() and bpf_program__nth_fd().
> > >
> > > v5 -> v6:
> > >   - rebase onto perf/core tree (Arnaldo);
> >
> > looks good, tests are passing for me
> 
> great, thanks for checking!

All tests passed, patches merged and pushed out to perf/core, thanks!

- Arnaldo
 
> >
> > jirka
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
> > >

-- 

- Arnaldo
