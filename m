Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E0664BD8
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjAJTBr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 14:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAJTBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 14:01:16 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4456413DC4;
        Tue, 10 Jan 2023 11:01:11 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id p66so6614888iof.1;
        Tue, 10 Jan 2023 11:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+Xte7Ngl7YlLvj1z8sYEtuoSriWT+xO/RCHtzuknfc=;
        b=m4Ta5LKJxQYFO3oDsKG4p+AUJhHXFADi2qW2nfp6SamL44NiGL0xtTjyfeZV516Ar7
         +PeYl1EMCvB+dlC03R27D1vBNfn4NYP4MJWWVMR6rPEbCpNMnoljCp0lvGl7Q6DqIMnR
         fwyKwAuSvWpuwJJOe8A34avbyqeo+30dfovslXewRBPc2e7yco9lOAVa9SCZjCNAmAsg
         sP7G2inBRAmuDnyvI9e1gmtyWUYlUWxs3oK4O6lgvv11ouYxCGDLK31fPytIL+ELKemA
         Mw303oeuG0iG3Uuz/MLr9U4tLKwZXNjqQH05B9o3TP6josySOGxxzhHtunrpGRJen3Io
         KZ/w==
X-Gm-Message-State: AFqh2kr4jgTypv0hAJd+G31Z0hnMXPC+dIxm3Ss/WpVkH2OtVZBnV9Rh
        1I0fvMmcLjFrOvoQ6tzrEztD7Q5P/3ToTXwfJUI=
X-Google-Smtp-Source: AMrXdXsrmSHXOsOSwjFFyEiBIpXUCp22xh80oaStljiyA0tuq5VCWRNrhlch7ZkOokhasWRsdzUMCA2poz7sKArHmt0=
X-Received: by 2002:a6b:7f08:0:b0:6e2:ec05:87c8 with SMTP id
 l8-20020a6b7f08000000b006e2ec0587c8mr5648418ioq.144.1673377270497; Tue, 10
 Jan 2023 11:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20221229204101.1099430-1-namhyung@kernel.org> <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net> <Y7x3RUd67smv3EFQ@google.com>
 <Y71D1FCzoGihMUv+@hirez.programming.kicks-ass.net> <Y71HvO5NV0OP6YYq@gmail.com>
In-Reply-To: <Y71HvO5NV0OP6YYq@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Jan 2023 11:00:59 -0800
Message-ID: <CAM9d7cha+ixj-XrisbDzBiPBJW7RPDxLGEuUT+J4mb8rig6cww@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in perf_prepare_sample()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo,

On Tue, Jan 10, 2023 at 3:10 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Mon, Jan 09, 2023 at 12:21:25PM -0800, Namhyung Kim wrote:
> >
> > > Looks good.  But I'm confused by the tip-bot2 messages saying it's
> > > merged.  Do you want me to work on it as a follow up?
> >
> > Ingo and me talked past one another, I agreed with 1/3 and he applied
> > the whole series. Just talked to him again and he's just zapped these
> > last two patches.
>
> Yeah - perf/core is now:
>
>    7bdb1767bf01 ("perf/core: Change the layout of perf_sample_data")
>
> which can be used for further work. Sorry about the confusion ...

No problem, thanks for your work!

Thanks,
Namhyung
