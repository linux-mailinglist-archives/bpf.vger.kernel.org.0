Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF35606C1
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiF2QxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiF2QxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:53:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DD1659C;
        Wed, 29 Jun 2022 09:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A11B8224C;
        Wed, 29 Jun 2022 16:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3302C34114;
        Wed, 29 Jun 2022 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656521596;
        bh=d0xxxonbR5ELLAqkeSrQsOwQMoaotUmqQ4jqNrrFQlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5Q4wp9z2OwwGc2/SKsGkRw30kH0xV+QEO3ojaQ34AW/RNQ6npenieKEUSChwmEnc
         SDyUQU6d+Olg5Mf/G+wKD4s8UG/wHbTg9kHZzPdNLdCdSmRSSerm7++bg+WxZXTBZy
         Hr+gutN3byKEGTq5b9vnWtiCpf+2u3bDkX3GVIGR4w8NW0QzxuARHZZnHJ92Sa0Z5w
         8D2Ffvcs+KT6lgXNLDoMOMXdWV7uXJQeurhDFyF40giMn6uzX8Q7D83g6zIYitIkeD
         wtDaLqqYwX3k3IYQ83h1BlAKj6l9YJ4gAEpg6t9xbABMTCIbWES9CEKQbq9DrR9FcV
         nyHznkxY1DcPg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 247084096F; Wed, 29 Jun 2022 13:53:14 -0300 (-03)
Date:   Wed, 29 Jun 2022 13:53:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] perf tools: Convert legacy map definition to BTF-defined
Message-ID: <YryDek+O6cMiKoXw@kernel.org>
References: <20220629112717.125927-1-jolsa@kernel.org>
 <CAP-5=fWm5uZYrxakCZuJtWgVFChNje2SpPgDXD+Xs=XnmB2dzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWm5uZYrxakCZuJtWgVFChNje2SpPgDXD+Xs=XnmB2dzA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 29, 2022 at 09:43:17AM -0700, Ian Rogers escreveu:
> On Wed, Jun 29, 2022 at 4:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > The libbpf is switching off support for legacy map definitions [1],
> > which will break the perf llvm tests.
> >
> > Moving the base source map definition to BTF-defined, so we need
> > to use -g compile option for to add debug/BTF info.
> >
> > [1] https://lore.kernel.org/bpf/20220627211527.2245459-1-andrii@kernel.org/
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/tests/bpf-script-example.c | 15 +++++++++------
> >  tools/perf/util/llvm-utils.c          |  2 +-
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> > index ab4b98b3165d..065a4ac5d8e5 100644
> > --- a/tools/perf/tests/bpf-script-example.c
> > +++ b/tools/perf/tests/bpf-script-example.c
> > @@ -24,13 +24,16 @@ struct bpf_map_def {
> >         unsigned int max_entries;
> >  };
> >
> > +#define __uint(name, val) int (*name)[val]
> > +#define __type(name, val) typeof(val) *name
> 
> This is probably worth a comment, reading it hurts :-) I expect that
> libbpf provides a definition that the rest of the world uses.
> 
> Fwiw, the pre bpf counters BPF in perf needs a good overhaul. Arnaldo
> mentioned switching perf trace's BPF to use BPF skeletons in another
> post. The tests we have on event filters are flaky. One fewer bpf.h in
> the world seems like a service to humanity (I'm looking at you
> tools/perf/include/bpf/bpf.h).

Yeah, bring perf trace to the modern world :-)

- Arnaldo
 
> Thanks,
> Ian
> 
> > +
> >  #define SEC(NAME) __attribute__((section(NAME), used))
> > -struct bpf_map_def SEC("maps") flip_table = {
> > -       .type = BPF_MAP_TYPE_ARRAY,
> > -       .key_size = sizeof(int),
> > -       .value_size = sizeof(int),
> > -       .max_entries = 1,
> > -};
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __type(key, int);
> > +       __type(value, int);
> > +} flip_table SEC(".maps");
> >
> >  SEC("func=do_epoll_wait")
> >  int bpf_func__SyS_epoll_pwait(void *ctx)
> > diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> > index 96c8ef60f4f8..2dc797007419 100644
> > --- a/tools/perf/util/llvm-utils.c
> > +++ b/tools/perf/util/llvm-utils.c
> > @@ -25,7 +25,7 @@
> >                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
> >                 "-Wno-unused-value -Wno-pointer-sign "          \
> >                 "-working-directory $WORKING_DIR "              \
> > -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> > +               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
> >
> >  struct llvm_param llvm_param = {
> >         .clang_path = "clang",
> > --
> > 2.35.3
> >

-- 

- Arnaldo
