Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51A601CA5
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 00:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJQWwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 18:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJQWwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 18:52:33 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A07FE57;
        Mon, 17 Oct 2022 15:52:27 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so6670427otb.8;
        Mon, 17 Oct 2022 15:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRJoqnnHfPYF70HwaPKC83vtJLiHPm0ZMTpeh7dtiHY=;
        b=XhTFu3oVARRuPGU3bEU3XH2PPjlxBJEyej5fMcVku+L8wjNDt7mip/OxdmpUFIjSzf
         uZDfE6rF/3S58RynzygbncDus3ZMwDB/ewIFRiD/Tqlq8sDroIQIZnfAvoUzQsyi4gHx
         w60v1kSEmIRK0IOy9Y4ybvFW9HD83ws0fB8CNuoEjEQGT7E3CHUi8wFYWRsASvqvPbwL
         BOqMR+wshCDPNgRlft1xlT0Rg71DSToEcF3zTxVWGIKjUS78DrzDSYOjxkb8ylwemw2u
         tpm82U9BYRxc8FKaNonDV4TtQ2B4v3xirLbEJ/oDgbunRNqIUw4NESDhCw9O/wkRRL5R
         svkA==
X-Gm-Message-State: ACrzQf0Gdnf6fb6tkwQC/+3WFWAmJtmEB9lUoW3qDe5r9/vS71hpnvkk
        1jIhjpfoKhrJXfzRrJCOniqLYm9PXf+dw8El2T4=
X-Google-Smtp-Source: AMsMyM6ZQ75kDRg2wESIMT38btq05r8LYemY/H2JuhcfwIZ+VbFsATdCZJeG0neEU+fTK6+5bOrOSFB0uMc4yqWag0o=
X-Received: by 2002:a9d:6848:0:b0:661:a608:cbc3 with SMTP id
 c8-20020a9d6848000000b00661a608cbc3mr12787oto.206.1666047146432; Mon, 17 Oct
 2022 15:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221007081327.1047552-1-sumanthk@linux.ibm.com> <20221017192744.1403-1-sj@kernel.org>
In-Reply-To: <20221017192744.1403-1-sj@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 17 Oct 2022 15:52:15 -0700
Message-ID: <CAM9d7cj1cvg6JUp33qxew59qz1_4hEu8noa-E3oO9DXFHabGaw@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     SeongJae Park <sj@kernel.org>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>, olsajiri@gmail.com,
        bpf@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        iii@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, peterz@infradead.org,
        svens@linux.ibm.com, tip-bot2@linutronix.de, tmricht@linux.ibm.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi SeongJae,

On Mon, Oct 17, 2022 at 12:27 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hello,
>
>
> The commit that this patch is fixing[1] also causes yet another segfault for
> 'perf-script' of tracepoint records.  For example:
>
>     $ sudo timeout 3 perf record -e exceptions:page_fault_user
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.228 MB perf.data (74 samples) ]
>     $ sudo perf script
>     Segmentation fault
>
> Reverting this patch and the original bug commit[1] fixes the issue.  I haven't
> deep dive yet because I'm not familiar with this area.  Anybody has any idea
> about this?
>
> [1] 838d9bb62d13 ("perf: Use sample_flags for raw_data")

Sorry for the trouble.  I think you also need to apply the below:

https://lore.kernel.org/r/20221012143857.48198-1-james.clark@arm.com

Thanks,
Namhyung

>
> On Fri, 7 Oct 2022 10:13:27 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:
>
> > * Raw data is also filled by bpf_perf_event_output.
> > * Add sample_flags to indicate raw data.
> > * This eliminates the segfaults as shown below:
> >   Run ./samples/bpf/trace_output
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   Segmentation fault (core dumped)
> >
> > Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >  kernel/trace/bpf_trace.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 49fb9ec8366d..1ed08967fb97 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
> >
> >       perf_sample_data_init(sd, 0, 0);
> >       sd->raw = &raw;
> > +     sd->sample_flags |= PERF_SAMPLE_RAW;
> >
> >       err = __bpf_perf_event_output(regs, map, flags, sd);
> >
> > @@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
> >       perf_fetch_caller_regs(regs);
> >       perf_sample_data_init(sd, 0, 0);
> >       sd->raw = &raw;
> > +     sd->sample_flags |= PERF_SAMPLE_RAW;
> >
> >       ret = __bpf_perf_event_output(regs, map, flags, sd);
> >  out:
> > --
> > 2.36.1
