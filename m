Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4F4F4D8D
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445323AbiDEXpt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572942AbiDERWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 13:22:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38914012
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 10:20:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso2550602pjb.0
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=093XqrLc3aDE9RURN7mfyfamRYRk+ypyCNdIjaQ8Zng=;
        b=c+bZkybxtTPC0a8NMb2K9SXaYTqs4UQKlFXD29C1WsTGFVfKM7qbZzOrU2IcwkRTd3
         gxqYgEJwEWILBMgivNKWMArY6qykcEDSitZGBbxsjMUiyXszzJE1nm9+gGLFGUrrWrfc
         jXiUvZEwTv8qponb3mhIrToSzQhdSn3ONrciT4p5mdVe3kBzv5HcC8BZSB3lSohTyl+T
         HjauPxmN3O6Qjw4n37bSoPtTELJZ6qfNEVOAGbZl6XYRhlKTieQhtV3Zz4z9UkonLnaT
         AASGUIWnK+olzU/lHcjheBR3kaXfQJAiYuyOgxZap/h4CdWH840Sf41t6cGf36oEjc5q
         OXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=093XqrLc3aDE9RURN7mfyfamRYRk+ypyCNdIjaQ8Zng=;
        b=5A0RYw27+A9jUsU1UYsEFwhv+KvXY2nlCoPa/jyxaV2nErziKXyA3sLjTrRS1sa3UU
         QnrOeKMYObTUvR7VcQtPy4ak47DiTOWQheItBl/mKpdTpiK9XbTXNWP2nWDFz89HtCKk
         9ESZl9MsmjS6Nh40djg/YWiaTfQTe2EnI2ZMxGrXtCqLt2pQcKHmbjMK9T/FtoCT/vX8
         KljFfaQ4aweFWv+NP2BjnzGfqEnSjfBKQasVfmmViYG/0I7nMZUsvFJrsGpMmwVW57VL
         vIY7LPFQQgzgh5Pv4d4HwpMRGRWmPfgOMwE6RC8g0ewmqI+YAufqAo+e5cg7nFUZEtGe
         NWIg==
X-Gm-Message-State: AOAM531QG0zldR85R3G2DbY9zYAwJ5ZCOlu/6lUugh+leerzRNBn3mxe
        y5HXYYjWkpOfZku04Jg+eiBqwUTpmVE=
X-Google-Smtp-Source: ABdhPJy00tr50fQax3vyuLC06ncb1GE7InDltZ3oOHW1creGIAP3s173agP9ABo3ln7kKdR64Wyk7w==
X-Received: by 2002:a17:902:d481:b0:154:7f0b:62fb with SMTP id c1-20020a170902d48100b001547f0b62fbmr4579887plg.41.1649179221035;
        Tue, 05 Apr 2022 10:20:21 -0700 (PDT)
Received: from MacBook-Pro.local ([2620:10d:c090:500::1:67aa])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001c75634df70sm2966194pjb.31.2022.04.05.10.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:20:20 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:20:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Priorities for bpf progs attached to
 the same tracepoint
Message-ID: <20220405172017.o3qi7v7edth2s7tr@MacBook-Pro.local>
References: <20220403160718.13730-1-9erthalion6@gmail.com>
 <CAEf4BzZ7=AfL5fAU8aYT20RWY9tG5qU+Fgv-JC0GTLpGOGgAEg@mail.gmail.com>
 <20220404152953.6uu3sgqepo724yiu@ddolgov.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404152953.6uu3sgqepo724yiu@ddolgov.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 04, 2022 at 05:29:53PM +0200, Dmitry Dolgov wrote:
> > On Sun, Apr 03, 2022 at 05:17:46PM -0700, Andrii Nakryiko wrote:
> > On Sun, Apr 3, 2022 at 9:08 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > >
> > > With growing number of various products and tools using BPF it could
> > > easily happen that multiple BPF programs from different processes will
> > > be attached to the same tracepoint. It seems that in such case there is
> > > no way to specify a custom order in which those programs may want to be
> > > executed -- it will depend on the order in which they were attached.
> > >
> > > Consider an example when the BPF program A is attached to tracepoint T,
> > > the BFP program B needs to be attached to the T as well and start
> > > before/end after the A (e.g. to monitor the whole process of A +
> > > tracepoint in some way).  If the program A could not be changed and is
> > > attached before B, the order specified above will not be possible.
> > >
> > > One way to address this in a limited, but less invasive way is to
> > > utilize link options structure to pass the desired priority to
> > > perf_event_set_bpf_prog, and add new bpf_prog into the bpf_prog_array
> > > based on its value. This will allow to specify the priority value via
> > > bpf_tracepoint_opts when attaching a new prog.
> > >
> > > Does this make sense? There maybe a better way to achieve this, I would
> > > be glad to hear any feedback on it.
> >
> > Not really. What's the real use case where you need to define relative
> > order of BPF programs on the same kprobe or tracepoint. Each of them
> > is supposed to be independent of each other and not depend on any
> > order of their execution. Further, given such tracing programs are
> > read-only relative to the kernel (they can't change kernel behavior),
> > the order is supposed to be irrelevant.
> 
> The immediate trigger for this idea was inconvenience we faced, trying
> to instrument one bpf prog with another. I guess the best practice in
> such case would be to attach to fentry/fexit of the target bpf prog, 

yes. that's a recommended way.

> but
> from what I understand in this case there is no way to get information
> about tracepoint arguments the target prog has received. 

Not quite. fentry/fexit have access to the arguments of instrumented bpf prog.
See fexit_bpf2bpf.c
In case of tracepoint the fentry prog will see the same 'ctx' pointer as
bpf prog attached to a tp.
