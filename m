Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74BB5BFF8E
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 16:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIUOJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIUOJy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 10:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5292CCB6;
        Wed, 21 Sep 2022 07:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D9D4B82FDE;
        Wed, 21 Sep 2022 14:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EC9C433C1;
        Wed, 21 Sep 2022 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663769390;
        bh=X/z6xFRCtDfzCw4XsC02yZzvtnmjSGeoaUehrJdvJDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXAMfy3aJhj8IMibz/QL6dwdBxPyh5wDwQMcYw/IW39uvIZplNZkLXd2iGvTqaQ+w
         3Uo84M8rILlrK9UJm9jpaos9SHL2TfkXMMq7jE11eQj8mZwcqQ0nEKT0DHRZqr790T
         UDcO+EDBnDkxzNWPRDBSpnpbo0YzPUei5DqetDiEpSc+8nkXa3PIwCbzCW7KTyoti6
         1Zzo7gyFH70qTBx578O929cbAANgTofP/wBkOk4iht2UzLYoMyS00ouY8o652WETvq
         U8K3Je/OMGKOwhaiRLaRTjVIO8EnFpW7K1etuPII+Xg2dNuKAlnig1ZE4ZJbMw+TjQ
         oxyog3lOZiuaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BD1940856; Wed, 21 Sep 2022 15:09:47 +0100 (IST)
Date:   Wed, 21 Sep 2022 15:09:47 +0100
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
Message-ID: <YysbKwpO9XLfHM90@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
 <Yxo32kpxsl9Mr7Mt@kernel.org>
 <CAM9d7cgOPUoGr96yc=M=bBTQG-jkW269Lc7-uEYTWGURiCAjyQ@mail.gmail.com>
 <YyohGGdnX88YOXtR@kernel.org>
 <CAM9d7ch7owDKkn9a89qkZ-KpSf02+OVJd01_76xMadA+vv3owQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch7owDKkn9a89qkZ-KpSf02+OVJd01_76xMadA+vv3owQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Sep 20, 2022 at 02:04:47PM -0700, Namhyung Kim escreveu:
> On Tue, Sep 20, 2022 at 1:22 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Sep 08, 2022 at 04:44:15PM -0700, Namhyung Kim escreveu:
> > > Hi Arnaldo,
> > >
> > > On Thu, Sep 8, 2022 at 11:43 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Wed, Sep 07, 2022 at 11:37:50PM -0700, Namhyung Kim escreveu:
> > > > > Hello,
> > > > >
> > > > > I found that call stack from the lock tracepoint (using bpf_get_stackid)
> > > > > can be different on each configuration.  For example it's very different
> > > > > when I run it on a VM than on a real machine.
> > > > >
> > > > > The perf lock contention relies on the stack trace to get the lock
> > > > > caller names, this kind of difference can be annoying.  Ideally we could
> > > > > skip stack trace entries for internal BPF or lock functions and get the
> > > > > correct caller, but it's not the case as of today.  Currently it's hard
> > > > > coded to control the behavior of stack traces for the lock contention
> > > > > tracepoints.
> > > > >
> > > > > To handle those differences, add two new options to control the number of
> > > > > stack entries and how many it skips.  The default value worked well on
> > > > > my VM setup, but I had to use --stack-skip=5 on real machines.
> > > > >
> > > > > You can get it from 'perf/lock-stack-v1' branch in
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > > >
> > > > This clashed with a patch you Acked earlier, so lets see if someone has
> > > > extra review comments and a v2 become needed for other reason, when you
> > > > can refresh it, ok?
> > >
> > > Sounds good!
> >
> > Have you resubmitted this? /me goes on the backlog...
> 
> Yep :)
> 
> https://lore.kernel.org/r/20220912055314.744552-1-namhyung@kernel.org

It applies now, testing :-)

- Arnaldo
