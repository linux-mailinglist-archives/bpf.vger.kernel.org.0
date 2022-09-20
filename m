Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4525BEE65
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiITUWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiITUWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 16:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A452FD2;
        Tue, 20 Sep 2022 13:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F56AB82165;
        Tue, 20 Sep 2022 20:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9481C433D6;
        Tue, 20 Sep 2022 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663705370;
        bh=yQ224x/KrEEAdjWrdFZBkvXO6pVB/k1ucaZQMmGTboc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myWZxC1j9Gg/CtZg6QO7GjvCZhu8V3YqN85dIEye9PbrBZc/vLt+yD4l8XBFTFH9h
         oUiV2vWQy85UFtyvKpDRWOGPr5S4wWCg7PVqasQfhZ19OUT5LSzpTXm9V0s0lllYGL
         6zWqhbPi/AXJtbrNlNdPs++dLtt2rIjdzU0oVpY5Q/lcpmI7tABwEdTvv5ut5pXC5N
         RCFDzd3a575jHqCxtaXPFiWdpWBai3IISupogEVfK4z/T0VO4HkuD28lRBsBYuYqZO
         AjztXrbfIiWEAA5jLiudn0k38nEhDF0Ah7N4P6UTWOSHUH5bfO5vO3xd9fyz6XWWFY
         jIyVJh/Jf/BbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2376C40856; Tue, 20 Sep 2022 21:22:48 +0100 (IST)
Date:   Tue, 20 Sep 2022 21:22:48 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/4] perf lock contention: Improve call stack handling
 (v1)
Message-ID: <YyohGGdnX88YOXtR@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
 <Yxo32kpxsl9Mr7Mt@kernel.org>
 <CAM9d7cgOPUoGr96yc=M=bBTQG-jkW269Lc7-uEYTWGURiCAjyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgOPUoGr96yc=M=bBTQG-jkW269Lc7-uEYTWGURiCAjyQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Sep 08, 2022 at 04:44:15PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Thu, Sep 8, 2022 at 11:43 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Sep 07, 2022 at 11:37:50PM -0700, Namhyung Kim escreveu:
> > > Hello,
> > >
> > > I found that call stack from the lock tracepoint (using bpf_get_stackid)
> > > can be different on each configuration.  For example it's very different
> > > when I run it on a VM than on a real machine.
> > >
> > > The perf lock contention relies on the stack trace to get the lock
> > > caller names, this kind of difference can be annoying.  Ideally we could
> > > skip stack trace entries for internal BPF or lock functions and get the
> > > correct caller, but it's not the case as of today.  Currently it's hard
> > > coded to control the behavior of stack traces for the lock contention
> > > tracepoints.
> > >
> > > To handle those differences, add two new options to control the number of
> > > stack entries and how many it skips.  The default value worked well on
> > > my VM setup, but I had to use --stack-skip=5 on real machines.
> > >
> > > You can get it from 'perf/lock-stack-v1' branch in
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > This clashed with a patch you Acked earlier, so lets see if someone has
> > extra review comments and a v2 become needed for other reason, when you
> > can refresh it, ok?
> 
> Sounds good!

Have you resubmitted this? /me goes on the backlog...

- Arnaldo
