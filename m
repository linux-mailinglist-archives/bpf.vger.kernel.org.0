Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E56DCD48
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJWMN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDJWMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 18:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C2AE51;
        Mon, 10 Apr 2023 15:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E309761D7E;
        Mon, 10 Apr 2023 22:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18506C433D2;
        Mon, 10 Apr 2023 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681164728;
        bh=/TPxAtqlCZXdR7Jc9aAW9VHcy3i/AR+zzMOBcwWYNdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/u0EhT2v0AX2+0HJys8DAeRDMMBjMen1IgPCEf1B7FHY3ilnjoOYhVBrHwwzutwU
         CsX513lT6QfBwSNWHC94MVNfElceEQzQ3E65CntSzm00xeBLulBA8Xd9I+0fNHvrEy
         rW5E9exio9pZMgKdvfFrGRO+8ZNwWxZYD25eoHj+msY1bUTt4BUYz1B4ahqjX53N45
         SXd6OA4zuOKlZGtJCyLWLUTGFPHYXDB2OgvnaOLxQ6YtjCGSmUmnVVzDqeuU94nB1s
         RMFu14ZwJ9daSEjegWZvkQfonR1KC1gtUS+GcPkoaSN+P6NB7mOr/eqWqCy2v1yCKa
         MPVFWSrJTlF4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABFCD40009; Mon, 10 Apr 2023 19:12:03 -0300 (-03)
Date:   Mon, 10 Apr 2023 19:12:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf bpf filter: Support pre-5.16 kernels
Message-ID: <ZDSJs1M06Wo2U6kp@kernel.org>
References: <20230408055208.1283832-1-irogers@google.com>
 <20230408055208.1283832-2-irogers@google.com>
 <CAM9d7cgfkx6VEazYpJEFZ=OTvJL+875_kHShSET4qyN_t9ixkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgfkx6VEazYpJEFZ=OTvJL+875_kHShSET4qyN_t9ixkQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Apr 10, 2023 at 08:34:34AM -0700, Namhyung Kim escreveu:
> On Fri, Apr 7, 2023 at 10:52 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The mem_hops bits were added in 5.16 with no prior equivalent.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Both applied, thanks,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 28 ++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > index 57e3c67d6d37..cffe493af1ed 100644
> > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > @@ -24,6 +24,24 @@ struct perf_sample_data___new {
> >         __u64 sample_flags;
> >  } __attribute__((preserve_access_index));
> >
> > +/* new kernel perf_mem_data_src definition */
> > +union perf_mem_data_src__new {
> > +       __u64 val;
> > +       struct {
> > +               __u64   mem_op:5,       /* type of opcode */
> > +                       mem_lvl:14,     /* memory hierarchy level */
> > +                       mem_snoop:5,    /* snoop mode */
> > +                       mem_lock:2,     /* lock instr */
> > +                       mem_dtlb:7,     /* tlb access */
> > +                       mem_lvl_num:4,  /* memory hierarchy level number */
> > +                       mem_remote:1,   /* remote */
> > +                       mem_snoopx:2,   /* snoop mode, ext */
> > +                       mem_blk:3,      /* access blocked */
> > +                       mem_hops:3,     /* hop level */
> > +                       mem_rsvd:18;
> > +       };
> > +};
> > +
> >  /* helper function to return the given perf sample data */
> >  static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
> >                                     struct perf_bpf_filter_entry *entry)
> > @@ -89,8 +107,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
> >                         return kctx->data->data_src.mem_dtlb;
> >                 if (entry->part == 7)
> >                         return kctx->data->data_src.mem_blk;
> > -               if (entry->part == 8)
> > -                       return kctx->data->data_src.mem_hops;
> > +               if (entry->part == 8) {
> > +                       union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
> > +
> > +                       if (bpf_core_field_exists(data->mem_hops))
> > +                               return data->mem_hops;
> > +
> > +                       return 0;
> > +               }
> >                 /* return the whole word */
> >                 return kctx->data->data_src.val;
> >         default:
> > --
> > 2.40.0.577.gac1e443424-goog
> >

-- 

- Arnaldo
