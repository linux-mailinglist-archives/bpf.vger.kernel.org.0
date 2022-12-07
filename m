Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A416646079
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGRnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGRnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 12:43:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BEF226;
        Wed,  7 Dec 2022 09:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D5261B59;
        Wed,  7 Dec 2022 17:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A115C433D6;
        Wed,  7 Dec 2022 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434983;
        bh=goeB/rRth2x4b9Asjebd0IlWBnTeqRBWnHgyNNDbMOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLXE2PusPNeYTsQ53oYgGC1EHAPJiaigWQr8ek8DQSDk+asI29g827Xzmow+7SIg3
         c4UTnCl5eQYAxKbvrBBPU1ddnUuixrJilSqpqekcgIfevV+IGGiolcYQgW0sHHbGmt
         6E4H4/twrLbwo9FsVU6KoHJNdedKY7BUjTAHH0Ul2D8qhf2af4J0j+hO9T46ot0tmo
         OM4l7zs5rF40mVNvPJrk80ryTrnkaTAUbj8QBpl9F6bXWPI/ofA4cDdZpfnHFZX6Kn
         oZma7XYQoSxalyVzNcqh7bUqUqRcjve7gCUtEfVF+uLrw9Waw7xyaop9VH0gyHiiX0
         hX6zr/R9oLoTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89B8340404; Wed,  7 Dec 2022 14:43:01 -0300 (-03)
Date:   Wed, 7 Dec 2022 14:43:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y5DQpZmkNsT9vdwg@kernel.org>
References: <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <Y5DN90m5D0HVOPK8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5DN90m5D0HVOPK8@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 02:31:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 07, 2022 at 02:27:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 07, 2022 at 07:08:28PM +0530, Athira Rajeev escreveu:
> > > > On 06-Dec-2022, at 11:01 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Can you try again? tmp.perf/core? That "tmp." part means its a force
> > pushed branch, so I just force pushed with some arch specific fixes, now
> > I'm down to (removing the successful builds and unrelated failures, now
> > related to libbpf's F_DUPFD_CLOEXEC kaboom):
> > 
> >   14     8.49 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >     tests/parse-events.c:1893:12: error: 'test__checkevent_tracepoint' undeclared here (not in a function); did you mean 'test__checkevent_breakpoint'?
> >        .check = test__checkevent_tracepoint,
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                 test__checkevent_breakpoint
> >     /git/perf-6.1.0-rc6/tools/build/Makefile.build:139: recipe for target 'tests' failed
> >     make[3]: *** [tests] Error 2
> 
> This should fix the above:
> 
> 
> ⬢[acme@toolbox perf]$ vim tools/perf/tests/parse-events.c
> ⬢[acme@toolbox perf]$ git diff
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index dcbfb93287e80e78..bebb677682deff98 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1887,7 +1887,7 @@ static const struct evlist_test test__events[] = {
>                 .check = test__checkevent_breakpoint_len_rw_modifier,
>                 /* 4 */
>         },
> -#if defined(__s390x__)
> +#if defined(__s390x__) and defined(HAVE_LIBTRACEEVENT)

s/and/&&/g

>         {
>                 .name  = "kvm-s390:kvm_s390_create_vm",
>                 .check = test__checkevent_tracepoint,
> ⬢[acme@toolbox perf]$

-- 

- Arnaldo
