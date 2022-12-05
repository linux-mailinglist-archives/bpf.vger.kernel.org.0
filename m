Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5726428C5
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLEMuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 07:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLEMut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 07:50:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E217585;
        Mon,  5 Dec 2022 04:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55566103C;
        Mon,  5 Dec 2022 12:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E0AC433D6;
        Mon,  5 Dec 2022 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670244647;
        bh=qf/NfO2N/WqW2ZAtOS02wKfWAQc4h++cVVZ9fzqJa84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaeUSIDpPqwpdzLNKCPdj7nuICOGrt1+m6i5rReASNq/bfRSVAVCLQeZfTILJAoTv
         g20Wu+YlLIym5Uouextf0VdZNsfVYpcpneL1U0pToMEzRNnO0uKfjx3j0VKSZQkEAu
         F23F6NH+NhYuaJgoGqVdQ0+w3E2TlyRLh66M0CTJSPHt1RRyN0sNqPjwimgKLSAEnC
         b2otiNYxOxXiIr6MITQVppAKXoTEcqM0D8Wdofys85r90OoS+uuMR5o+8mNxsR3o/2
         tT01lZtswgLYsEFGiFWQLLlLnTyEGDHIbyPWH4VSDQadNSYjMbDg466Aybrm+eJFQ4
         4qvSbZI3W+8LQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFCFE40404; Mon,  5 Dec 2022 09:50:44 -0300 (-03)
Date:   Mon, 5 Dec 2022 09:50:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/5] Improvements to incremental builds
Message-ID: <Y43pJOmF1y3JWrX8@kernel.org>
References: <20221202045743.2639466-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Dec 01, 2022 at 08:57:38PM -0800, Ian Rogers escreveu:
> Switching to using install_headers caused incremental builds to always
> rebuild most targets. This was caused by the headers always being
> reinstalled and then getting new timestamps causing dependencies to be
> rebuilt. Follow the convention in libbpf where the install targets are
> separated and trigger when the target isn't present or is out-of-date.
> 
> Further, fix an issue in the perf build with libpython where
> python/perf.so was also regenerated as the target name was incorrect.
> 
> Ian Rogers (5):
>   tools lib api: Add dependency test to install_headers
>   tools lib perf: Add dependency test to install_headers
>   tools lib subcmd: Add dependency test to install_headers
>   tools lib symbol: Add dependency test to install_headers
>   perf build: Fix python/perf.so library's name

The last one isn't applying:

Applying: perf build: Fix python/perf.so library's name
error: patch failed: tools/perf/Makefile.perf:642
error: tools/perf/Makefile.perf: patch does not apply
Patch failed at 0005 perf build: Fix python/perf.so library's name
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$

I'll have the first 4 applied to make progress, later I'll check what
went wrong and to fix it.

- Arnaldo
