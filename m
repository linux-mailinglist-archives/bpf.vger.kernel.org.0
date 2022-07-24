Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF557F4B2
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiGXKiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGXKiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 06:38:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70613E09;
        Sun, 24 Jul 2022 03:38:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b11so15566144eju.10;
        Sun, 24 Jul 2022 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=81oGHfHrB8lVkJ+g/NkBs7PcuO85NR++hBmreY15mW0=;
        b=HNzHYLFzUNIUu96TX16ua+bwzbCrvXIOBws5aBsFkpbOLhs78gTGuMis1qPeIWbkVW
         hy/poLueGjdxtTsfkT9QrjOhVBp0muY5FjUmaO/RSgwGYj2cys7RzBWlPdpNwkpeW/PV
         D9G9Y23pCS7r34/VL9OpC2YetCIXTg9Ytu1Cwfh3+ROYzdMx7DVZDnTBC6Tvap8AlCZU
         9PG2TQFVaaETssA+PKHGoraqubitvGNeSX6OU+sbmQsUCwDeMNEEa9g1ogdqJ9ghuX1O
         J0WTqVqaKTIteUmKMrOi6OWuvBEcKgd52DoqJHgTGrln4A0+1D588DZr1hLLua3q88PG
         Cg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81oGHfHrB8lVkJ+g/NkBs7PcuO85NR++hBmreY15mW0=;
        b=4fhnOfLQ7dge053tjCoklx1EgVMvrsiVPRIqof6OY1r7X7Pgaw/c7uQXlx/HLJReDG
         QvHkNW3Zzx350IHhDwksWBgrQUY7OWR45Wd+zQ1gf5uZ5hlGsq2Jhvzb6uAc4NPou7Mi
         ByujqxWquCZuQcGt+FYCOE6jOwy0xUQzXCrGbNCC8WwW6LR8bzcitmv0Y9fhEsii/cUc
         5iREa1AO6YhrorOkeqOrOPVGMYrkPyI1wtDujn6tNy2jAxQOm7INbzTkz8sGuIYI5hOm
         TQEtxfvGX5N3urh+JlbamnYoHnR0PrXMkTkNf8ohUwXFJncnMfI0n4yDS7Ob8nHoUco0
         0apQ==
X-Gm-Message-State: AJIora/lz8kp8nbFYllGg7i15ckYp4jsA2uRuGqbZxp8a0Js7v1utNSy
        hMI/rvuDl7LvlWizzTR2lgnaaMtZdjI=
X-Google-Smtp-Source: AGRyM1sRIuekT8/CJ1p3muFe2N56rnMeuPaMUH3VsN2lLc/+E9hYTdn1AF+ZxoTjkgX26GykJXas/A==
X-Received: by 2002:a17:906:2ed7:b0:72f:d080:411 with SMTP id s23-20020a1709062ed700b0072fd0800411mr1522299eji.203.1658659081960;
        Sun, 24 Jul 2022 03:38:01 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-027-106.094.222.pools.vodafone-ip.de. [94.222.27.106])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b006fe9f9d0938sm4094843eja.175.2022.07.24.03.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 03:38:01 -0700 (PDT)
Date:   Sun, 24 Jul 2022 12:36:51 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, mingo@redhat.com,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220724103651.qhtqgzhfx2ftrpcx@erthalion.local>
References: <20220714193403.13211-1-9erthalion6@gmail.com>
 <YtB1PK+NUF5RL9Er@worktop.programming.kicks-ass.net>
 <20220715095236.ywv37a556ktl5oif@ddolgov.remote.csb>
 <YtgMKDgNLnMIkHLI@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtgMKDgNLnMIkHLI@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, Jul 20, 2022 at 04:07:36PM +0200, Peter Zijlstra wrote:
> > > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > > Use highest 4 bit (bit 59-63) to allow specifying maxactive by log2.
> > >
> > > What's maxactive? This doesn't really tell me much.
> >
> > Maxactive allows specifying how many instances of the specified function
> > can be probed simultaneously, it would indeed make sense to mention this
> > in the commit message.
>
> But why would we need per-fd configurability? Isn't a global sysctrl
> good enough?

Do you mean there is an existing sysctl option for maxactive, or propose
to introduce one? A global option indeed could be fine for my use case I
guess, although there will be a bit of awkward asymmetry -- one can
specify maxactive via text-based API, but not via perf API.

> > > Why are the top 4 bits the best to use?
> >
> > This format exists mostly on proposal rights. Per previous discussions,
> > 4 bits seem to be enough to cover reasonable range of maxactive values.
> > Top bits seems like a natural place to me following perf_probe_config
> > enum, but I would love to hear if there are any alternative suggestions?
>
> I think the precedent you're referring to is UPROBE_REF_CTR, which is a
> full 32bit. That lives in the upper half of the word because bit0 is
> already taken and using the upper half makes the thing naturally
> aligned.
>
> If we only need 4 bits it's must simpler to simply stick it at the
> bottom or so.

Yes, you're right, I was referring to UPROBE_REF_CTR. Makes sense to me,
will change the location.
