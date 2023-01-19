Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDEF674C51
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjATF3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjATF2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3556C12C;
        Thu, 19 Jan 2023 21:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC50B82314;
        Thu, 19 Jan 2023 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0136FC433EF;
        Thu, 19 Jan 2023 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145432;
        bh=4iyv9ZQaCHKEyaKr1myAy/HD5rxKaeF7tIvs7Vo9l5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yn+ibebTUCXrBtlNavVLGTmp1RaMMMoJowna/FiWXuMtMkj8PaX8N2PzBD8B9CK0f
         Rc5Bu7TN1e88zoRuGUGNXfD9UrcX9fMNW0iw4MtonoEZShhp4J57AUMvXjylhXy4ko
         P9MQM8OfRBnFbJpPTaHs3s5ZGGZND/uGNP+rQzsutl4/xW59yOuZfTNusX+PttL4LR
         qUxdrJZHDnGe2H1Z615rL22ewBSVVQBAWQwrjjnzvnygDf7qZ1zUV+BoyQPnf/tq/F
         HogZbHDvRSNRUMymsgLrSKvgJDjkquzT8prtjpcwA1jwzKACs7Mk+O5jkfXT6j9y+H
         6PTU8I72qZymQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20F6E405BE; Thu, 19 Jan 2023 13:23:47 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:23:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1] perf llvm: Fix inadvertent file creation
Message-ID: <Y8luk2xVZFQusPUd@kernel.org>
References: <20230105082609.344538-1-irogers@google.com>
 <CAP-5=fUCJEyrZ+bx6oMGmFm5wuF71uheM=7VD9ynjAD_TNZ78w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUCJEyrZ+bx6oMGmFm5wuF71uheM=7VD9ynjAD_TNZ78w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 19, 2023 at 07:57:19AM -0800, Ian Rogers escreveu:
> On Thu, Jan 5, 2023 at 12:26 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The LLVM template is first echo-ed into command_out and then
> > command_out executed. The echo surrounds the template with double
> > quotes, however, the template itself may contain quotes. This is
> > generally innocuous but in tools/perf/tests/bpf-script-test-prologue.c
> > we see:
> > ...
> > SEC("func=null_lseek file->f_mode offset orig")
> > ...
> > where the first double quote ends the double quote of the echo, then
> > the > redirects output into a file called f_mode.
> >
> > To avoid this inadvertent behavior substitute redirects and similar
> > characters to be ASCII control codes, then substitute the output in
> > the echo back again.
> >
> > Fixes: 5eab5a7ee032 ("perf llvm: Display eBPF compiling command in debug output")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Not really a BPF/LLVM fix, it is just doing some string
> manipulation to avoid shell interpretation in the context of making
> BPF/LLVM.

Thanks, applied.

- Arnaldo

