Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3624F186C
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbiDDPby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbiDDPbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 11:31:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043325283
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 08:29:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g22so11579305edz.2
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLnfK3XrfsmyhySDGQg79zENDXApYTwL9MzrYgjDbcU=;
        b=cnbUFML6FbtLROz9lHMfLU9UpLFP7bHOedO07NW6HgI9jkYwgP/LNVLa813/0f0d70
         9jLbEZKxDkPQXrgOEbg35t4hqNMZ0n1tIvaWH5BC5tk7ROSKesIg7K+JfEJuaL+Ou6fg
         WCEGTsqXz+DjNolov6NfKoh552J3dAm1f/0Z6G0TNiVh1bn+Sw1JHBCL/480jh9LVQgM
         DJ3lUHYVENqorUZLAKeaGcz6fVg3kDQbKyu5pN/yscBenzbBxPD7ikrTOfNad3ArPR8H
         WCBxdVHwBuA0k4qH9jodshKBQD8VdzjGZM6AnxwNqT39OTW6DNkkSPT+uv/uQxNqOe8p
         s4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLnfK3XrfsmyhySDGQg79zENDXApYTwL9MzrYgjDbcU=;
        b=337iWrdseQYWqVoFb/qbASGGXqK1l5FSVx3RvZk/Vkw5XzUs2QRWJo8OjHqCo5VybJ
         L5tVymI49zmKbmkF5BbgEe9qgMushghv3/V/jw2cYAOZr7iQm8zudDwTyKmevT8kvJ45
         KIBJS2nkqQ/wlbKzqOJnxnbVjssN1ctD0x6AaedfJIK0fR5S/xBgi+/k1Du4r37fi3P9
         4eWtoGOfx6kHdKc+xuMsLE6eOJFKg1hKIH8hfA+0hpMMiNUvwN7sA85nUtpryLW6hej9
         RFcZJx6H8X++cTchTigCG3gaqBSxKfEiC9WgH6cM85Uo/vbtbMrkUeqr7DvKYjv1fYYR
         19hg==
X-Gm-Message-State: AOAM531SC6v8oQDSF2aDTT6j5vQdFRzwBeqHwRaW0ISgLzMzzSv9VzPq
        aR4XEH3vQDuLMfnTBID+Lmk=
X-Google-Smtp-Source: ABdhPJwKl0J1WWKgBRzwU3HxvBgxTJTfl7Uwiiq65pWy6wsek634Bl5watFtTpUmdXwxR/Gz074OmQ==
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr704380edy.332.1649086195055;
        Mon, 04 Apr 2022 08:29:55 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id tl22-20020a170907c31600b006e80112dac9sm379308ejc.123.2022.04.04.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:29:54 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:29:53 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Priorities for bpf progs attached to
 the same tracepoint
Message-ID: <20220404152953.6uu3sgqepo724yiu@ddolgov.remote.csb>
References: <20220403160718.13730-1-9erthalion6@gmail.com>
 <CAEf4BzZ7=AfL5fAU8aYT20RWY9tG5qU+Fgv-JC0GTLpGOGgAEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ7=AfL5fAU8aYT20RWY9tG5qU+Fgv-JC0GTLpGOGgAEg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, Apr 03, 2022 at 05:17:46PM -0700, Andrii Nakryiko wrote:
> On Sun, Apr 3, 2022 at 9:08 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > With growing number of various products and tools using BPF it could
> > easily happen that multiple BPF programs from different processes will
> > be attached to the same tracepoint. It seems that in such case there is
> > no way to specify a custom order in which those programs may want to be
> > executed -- it will depend on the order in which they were attached.
> >
> > Consider an example when the BPF program A is attached to tracepoint T,
> > the BFP program B needs to be attached to the T as well and start
> > before/end after the A (e.g. to monitor the whole process of A +
> > tracepoint in some way).  If the program A could not be changed and is
> > attached before B, the order specified above will not be possible.
> >
> > One way to address this in a limited, but less invasive way is to
> > utilize link options structure to pass the desired priority to
> > perf_event_set_bpf_prog, and add new bpf_prog into the bpf_prog_array
> > based on its value. This will allow to specify the priority value via
> > bpf_tracepoint_opts when attaching a new prog.
> >
> > Does this make sense? There maybe a better way to achieve this, I would
> > be glad to hear any feedback on it.
>
> Not really. What's the real use case where you need to define relative
> order of BPF programs on the same kprobe or tracepoint. Each of them
> is supposed to be independent of each other and not depend on any
> order of their execution. Further, given such tracing programs are
> read-only relative to the kernel (they can't change kernel behavior),
> the order is supposed to be irrelevant.

The immediate trigger for this idea was inconvenience we faced, trying
to instrument one bpf prog with another. I guess the best practice in
such case would be to attach to fentry/fexit of the target bpf prog, but
from what I understand in this case there is no way to get information
about tracepoint arguments the target prog has received. Stepping back a
bit, what would be the best way of handling this?
