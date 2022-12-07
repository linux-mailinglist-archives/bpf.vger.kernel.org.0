Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC5646047
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 18:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGRbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLGRbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 12:31:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4ACF58C;
        Wed,  7 Dec 2022 09:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678F961B7D;
        Wed,  7 Dec 2022 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983C7C433C1;
        Wed,  7 Dec 2022 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434297;
        bh=Z3f9pgi5krrUdxiim8b1Ifbjs27OR0IsaivttKNGsGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beuOdUTFfVYMixU2vCatb6QuAzCt7xLhIQS4Pa9+A33apabaymX54yAhnq28JX4SS
         hHkmLN1mHKj0cCmtF8+Xi4JCBCvchGyCe+i4mSu4DIz/2nGJMFLmeSYCLjM9qmcCyd
         7jfweqr5UuIbBEiUdRIBWR21NH+yLeSLXn4oFG/XBI5XFHHfMZl1K5KaG1Zh9dLSaT
         Yr888Xk8sT1cxVnAzvuT9If+ZoNbM0RArXm1qDumBvHSxlNOX9I0j7HTfZcBp2vUrl
         mKh7MJRzs6ukfi6qsc+Wg/8aQI7pexwcbo4NGTsyS5O9wgOT3LO72Z4LXHK7u50H7f
         522VU84tuwPog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AAE040404; Wed,  7 Dec 2022 14:31:35 -0300 (-03)
Date:   Wed, 7 Dec 2022 14:31:35 -0300
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
Message-ID: <Y5DN90m5D0HVOPK8@kernel.org>
References: <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5DNBZNC5rBBqlJW@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 02:27:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 07, 2022 at 07:08:28PM +0530, Athira Rajeev escreveu:
> > > On 06-Dec-2022, at 11:01 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Can you try again? tmp.perf/core? That "tmp." part means its a force
> pushed branch, so I just force pushed with some arch specific fixes, now
> I'm down to (removing the successful builds and unrelated failures, now
> related to libbpf's F_DUPFD_CLOEXEC kaboom):
> 
>   14     8.49 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
>     tests/parse-events.c:1893:12: error: 'test__checkevent_tracepoint' undeclared here (not in a function); did you mean 'test__checkevent_breakpoint'?
>        .check = test__checkevent_tracepoint,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>                 test__checkevent_breakpoint
>     /git/perf-6.1.0-rc6/tools/build/Makefile.build:139: recipe for target 'tests' failed
>     make[3]: *** [tests] Error 2

This should fix the above:


⬢[acme@toolbox perf]$ vim tools/perf/tests/parse-events.c
⬢[acme@toolbox perf]$ git diff
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index dcbfb93287e80e78..bebb677682deff98 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1887,7 +1887,7 @@ static const struct evlist_test test__events[] = {
                .check = test__checkevent_breakpoint_len_rw_modifier,
                /* 4 */
        },
-#if defined(__s390x__)
+#if defined(__s390x__) and defined(HAVE_LIBTRACEEVENT)
        {
                .name  = "kvm-s390:kvm_s390_create_vm",
                .check = test__checkevent_tracepoint,
⬢[acme@toolbox perf]$
