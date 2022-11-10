Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95262486C
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKJRfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJRfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 12:35:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7719C09;
        Thu, 10 Nov 2022 09:35:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE7C8B8225D;
        Thu, 10 Nov 2022 17:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D82C433C1;
        Thu, 10 Nov 2022 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668101744;
        bh=Y1XMNG3ILmebfWRjz2r1LuSVX/IBJ6YwFNQjqKXoROk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5qX9p06vXKaCOnie51zhMED6gflAlTgiHvpnx2wjfRq1szxxKAM2zzxzzAxH8i5Y
         E//EJZ50Hyhs3l7YWrE9dyq59RbE/UeUUcvozebwfcgAZT7CIhk8r6nwqt33vSsgh6
         qa7q6QHW+568C4FqfbQyiV/SoBoLVA5WdFz4VRPDUDKe4eoeql8FI7trq8+kZ318kN
         mnVsHOeHHHV2t5153Ay+jUDgrMoqzK4D3EnoEgg5zjSH5z3xftE6uO+vfg5Adpjjx0
         ILpuOqbTIuQB4lTNwe7tf81ghRBqsSOjQhF8nCJybFUqI/MAVCah/J72wW5Ny80/Kt
         xoQwjPMrg1VUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 384264034E; Thu, 10 Nov 2022 14:35:42 -0300 (-03)
Date:   Thu, 10 Nov 2022 14:35:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 08/14] tools lib perf: Add missing install headers
Message-ID: <Y202br0IHVj9SDJ+@kernel.org>
References: <20221109184914.1357295-1-irogers@google.com>
 <20221109184914.1357295-9-irogers@google.com>
 <CAM9d7cgpcVcUZo6ExLWis2Pu4V0FXdsNx+ZoKUWrOYqgqyZTiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgpcVcUZo6ExLWis2Pu4V0FXdsNx+ZoKUWrOYqgqyZTiQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 09, 2022 at 12:12:16PM -0800, Namhyung Kim escreveu:
> On Wed, Nov 9, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > Headers necessary for the perf build. Note, internal headers are also
> > installed as these are necessary for the build.
 
> Yeah, it's sad we are using those internal headers in perf.

The plan is for perf to eventually be a libperf tool, but what was done
so far was make available classes and methods that were asked for by
libperf users.

Completely untangling tools/perf/ from those internal bits will needs
lots more work, so doing it the way Ian is doing now seems ok.

- Arnaldo

> Ideally libperf provides callbacks to associate private data
> to each public data structure (e.g. evsel, evlist, etc).  And
> external users just use public APIs only.
> 
> But that would be a major change.
