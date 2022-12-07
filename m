Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59131645CCA
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 15:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGOkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 09:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGOkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 09:40:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6412A975;
        Wed,  7 Dec 2022 06:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F904B81E5D;
        Wed,  7 Dec 2022 14:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B274C433D6;
        Wed,  7 Dec 2022 14:40:00 +0000 (UTC)
Date:   Wed, 7 Dec 2022 09:39:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20221207093958.09ae35c2@gandalf.local.home>
In-Reply-To: <Y5Cjylv9dJh796dw@kernel.org>
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
        <Y5Cjylv9dJh796dw@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Dec 2022 11:31:38 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> No distro I tested so far has a package for libtracevent in is default
> repositories:

Not sure what you mean by "default repository".

At least on Debian testing, I have libtraceevent-dev available.

-- Steve
