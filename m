Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34888586FB0
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiHARnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiHARnt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:43:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA71E3C0;
        Mon,  1 Aug 2022 10:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE9E6B81218;
        Mon,  1 Aug 2022 17:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523FDC433D7;
        Mon,  1 Aug 2022 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659375825;
        bh=XK73bpq3+GRlmBqos12wmiiu3rmkoao9rDtgB+eisxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyywypwmQg0NmNXNuxwQ3ACbnlcsDPUfQSBydLTAlu6LLl6vEEFasZfHpoSAFWoqI
         mleInjwycMJQzU9zAhWWSOsucd3jKgHnjWjOlUR72MLuJG8Z1m0aM5rgBdU/+e+2Up
         lcn396kGvZ5ifR966Gk3CbGWvC5H3ubBDpN1AelzfbwBPFOCp6cJY4uUT4kiklTSg/
         CKxZBhsxxwo6k/5Sv+iRlz015xw5rChMqacZAgzwQXXy7GEz0Vfss78Ly5SgRRReJV
         zmVcANFTnNx8Fse21DpNajPsPLsC4jGbHyh7WF88rfyNdbk2oo/pZDOrLIxk6MkSpB
         LYjZru6tlArKA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7381F40736; Mon,  1 Aug 2022 14:43:41 -0300 (-03)
Date:   Mon, 1 Aug 2022 14:43:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv2] perf tools: Convert legacy map definition to
 BTF-defined
Message-ID: <YugQzbIODcIBOAqp@kernel.org>
References: <20220704152721.352046-1-jolsa@kernel.org>
 <CAEf4Bzb+dK9kBsYZ_j=st9LMgFid6GzivQnbNOJ+nyg7zbD8UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb+dK9kBsYZ_j=st9LMgFid6GzivQnbNOJ+nyg7zbD8UQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jul 05, 2022 at 10:08:16PM -0700, Andrii Nakryiko escreveu:
> On Mon, Jul 4, 2022 at 8:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The libbpf is switching off support for legacy map definitions [1],
> > which will break the perf llvm tests.
> >
> > Moving the base source map definition to BTF-defined, so we need
> > to use -g compile option for to add debug/BTF info.
> >
> > [1] https://lore.kernel.org/bpf/20220627211527.2245459-1-andrii@kernel.org/
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> LGTM. Thanks for taking care of this!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, applied.

- Arnaldo

 
> >  tools/perf/tests/bpf-script-example.c | 35 ++++++++++++++++++---------
> >  tools/perf/util/llvm-utils.c          |  2 +-
> >  2 files changed, 24 insertions(+), 13 deletions(-)
> >
> 
> [...]

-- 

- Arnaldo
