Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED65673EC8
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 17:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjASQ26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASQ2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 11:28:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299304A1DF;
        Thu, 19 Jan 2023 08:28:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2DA461CBA;
        Thu, 19 Jan 2023 16:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E8C433F0;
        Thu, 19 Jan 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145720;
        bh=d0+CExtO2OcCawPxA7eHa5qZ0do7CwZUvPxeHDQOWy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8xhynKWA8UPLBqcFZeBzDg6e2/PkvCP1jlmk3DZdpoFCTJwC5kCWpYFDI8LPDEaO
         KxVWVM1OOfTgRhPJhJVufwcywblgJdnCD/o9Hp11VCnFWz9c2LyuG5Idz5wc/dAh4G
         m6I/jJeFbKlfmdyUeK0ii343XG8U8dJkyJFbRMrRITxunNi/fd3ZsC+hvMBU9oPqqW
         8/q7X9XX0yfLID7WCRq4CoVX3rp3zjJFNtvGcD6moikKMdl5Z7XewU8b+XMtisRZuL
         dolP/lvGwslC46nOHNbJPUCO/e3/3SkULKzMdFYo9D9TOKSOHICRVzlU4/hSy8OKV1
         jaAiXTX5f7xbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24CB6405BE; Thu, 19 Jan 2023 13:28:36 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:28:36 -0300
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
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/7] Add and use run_command_strbuf
Message-ID: <Y8lvtEwRBmUHnx7s@kernel.org>
References: <20230110222003.1591436-1-irogers@google.com>
 <CAP-5=fVQg4z-pd-ovjSPkxJ1p0fhQ4MuhWCqjN1ha52q44N6Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVQg4z-pd-ovjSPkxJ1p0fhQ4MuhWCqjN1ha52q44N6Rg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 19, 2023 at 08:05:36AM -0800, Ian Rogers escreveu:
> On Tue, Jan 10, 2023 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> >
> > It is commonly useful to run a command using "/bin/sh -c" (like popen)
> > and to place the output in a string. Move strbuf to libapi, add a new
> > run_command that places output in a strbuf, then use it in help and
> > llvm in perf. Some small strbuf efficiency improvements are
> > included. Whilst adding a new function should increase lines-of-code,
> > by sharing two similar usages in perf llvm and perf help, the overall
> > lines-of-code is moderately reduced.
> >
> > First "perf llvm: Fix inadvertent file creation" is cherry-picked
> > from:
> > https://lore.kernel.org/lkml/20230105082609.344538-1-irogers@google.com/
> > to avoid a merge conflict. The next patches deal with moving strbuf,
> > adding the run_command function with Makefile dependency from
> > libsubcmd to libapi, and improving the strbuf performance. The final
> > two patches add usage from the perf command.
> >
> > Ian Rogers (7):
> >   perf llvm: Fix inadvertent file creation
> >   tools lib: Move strbuf to libapi
> >   tools lib subcmd: Add run_command_strbuf
> >   tools lib api: Minor strbuf_read improvements
> >   tools lib api: Tweak strbuf allocation size computation
> >   perf help: Use run_command_strbuf
> >   perf llvm: Remove read_from_pipe
> 
> This isn't ready yet. Kernel test robot reported legitimate build
> breakages in other tools outside of perf, I'm looking to address those
> in separate patch series.
> https://lore.kernel.org/lkml/20230116215751.633675-1-irogers@google.com/

Thanks for the heads up, I recall seeing a build bot report.

It's great to have that build bot testing perf patches, thanks to
whoever put it in place!

- Arnaldo
