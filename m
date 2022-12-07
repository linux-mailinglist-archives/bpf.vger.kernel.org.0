Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC098645F5B
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLGQ4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGQ4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AF6177A;
        Wed,  7 Dec 2022 08:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 078AEB81F80;
        Wed,  7 Dec 2022 16:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8DBC433C1;
        Wed,  7 Dec 2022 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670432168;
        bh=CXFA7xU5rXYsWcYNq38AVI/vKJwTiyUrhcJLpBypxuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxD3yn5XULK3bROFLmPw72L9p8mTSa4zlCrOxg0dhDU3IwAW9QhYbUcdTDwVa1r6e
         IE2n0+nCyk+9SOjCrAGHlRoLoEhYzzFM0kQ3hx6rKqgBnvNJ4GgfKlOF3IkkVWdC4k
         E8br52KvsLEfw54Ktpf8OlY5CX4yDgcitaa6Q7DQ6iAlEbWrF69a4eE5fd8lecpsB/
         svaR4mNc42avYO9BkeLdO5492htz7K3jtJhieYPR7wSFCuYAYN8IyRuVrQBtZsVZaM
         ScIPegUF1cGQK3GycT+c5PfJqMaiuubr+MVqRKZkqKqLVMIzK3DJdcCeqGitawQMkQ
         e8AeEcQATZYjw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1867840404; Wed,  7 Dec 2022 13:56:06 -0300 (-03)
Date:   Wed, 7 Dec 2022 13:56:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Y5DFpn4R6p+vnBRz@kernel.org>
References: <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
 <Y5ChXjt0uv/yDNwV@kernel.org>
 <Y5Cjylv9dJh796dw@kernel.org>
 <20221207093958.09ae35c2@gandalf.local.home>
 <Y5C5AZ1YfthY0tx2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5C5AZ1YfthY0tx2@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 01:02:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 07, 2022 at 09:39:58AM -0500, Steven Rostedt escreveu:
> > On Wed, 7 Dec 2022 11:31:38 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > > No distro I tested so far has a package for libtracevent in is default
> > > repositories:

> > Not sure what you mean by "default repository".

> > At least on Debian testing, I have libtraceevent-dev available.

> Right, I'm talking about non-bleeding edge, distros that are still
> supported. I'm still checking, fedora is ok all the way back to 33, wrt
> having libtraceevent available.

And in some places libtraceevent is available, but then:

  73     6.88 ubuntu:22.04                  : FAIL gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
          |                                    ^~~~~~~~~~~~~~~~~~~~~
          |                                    TEP_FIELD_IS_FLAG

Still need to look how to cover these.

- Arnaldo
