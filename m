Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6475B3F35
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIITES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiIITEP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:04:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B273FE7FB3
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:04:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b35so3978472edf.0
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1egLh/3uqcXtJsZ/pZ+M08SsLNpIEA1LY7qIB5ZasSU=;
        b=GYHYbUBpTmj2UFiW5B2W2yNX+nbU1g77LzYHXe98NqbKaTdZzpOFMxtjP7LVNU96pR
         Nbipdd5cNVywYxgTCEoF4IHWMoPqV8RS4eE8hh1VN1m301IoguIygfAaOWGLm4w6qtV6
         mIuAsPaTAO/ygwtXGkZYco8gIBbTTtsvyau6l7S4ni15kdMxwsVdKn1CV7z4kthbcmiN
         eY2quGDTVNpOegRXvQNmdJxPzRTFIeX2lt1TSzuSM6cZRjpgwsWx6A6k8PEM/iM0HVPF
         6ii/4fsYgEQsFwE5GhsGklnWBr4Hl88MVxlpR4O7Jvh1JXSsKgKL8/Xff+BbIaGn8naJ
         22KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1egLh/3uqcXtJsZ/pZ+M08SsLNpIEA1LY7qIB5ZasSU=;
        b=G53IHNChVYZWvUzItIeL6bTpQlE+/rHpF8jY57Fi0ot6OZA9eh4QxIUbwlecCq3ZFl
         tOI5rsGMxFKk42uWB3MhiejhXj3IDRI0mr6TPmeON5CzHFp8Cc8GeYmONpqh3eQQOpBy
         e0ok/zdXTvvrpDbHhy2LlS5PNQ9Zqq+OP3X2sI1xYDkid/LU0lKSTHRaG++op5XTEb06
         iXoBKcV4wJ0HAmLifvOKgDgMAFLg5BlYfJXt7aX+Oiv3JLGvhv79sHAiXE9A3svnxZlo
         DbL6IXgP0FxTXM5bHhbCkp7EUA+ff3P8fw6+SGz30iJKfMQM18TkAcNobYQZxNUoeiy5
         1BTQ==
X-Gm-Message-State: ACgBeo2VLTcf9TThQtOFWGLANnsCKR6+qEVk+UyPVoFM0SeMXt7/Rxb1
        5CsUg7NpOLS/8ospMmKWprs9e4Ds8xAOWypCkSM=
X-Google-Smtp-Source: AA6agR5Xc4pIZ/xwITbnFghQFiT5dgeUvylypzkbvoENZSk0WtCMy3sC4S8q8gqRPSAE6cUdYwPOs3Qp+2GlSH8nlcQ=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr12387385eda.311.1662750252239; Fri, 09
 Sep 2022 12:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-4-andrii@kernel.org>
 <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 12:04:00 -0700
Message-ID: <CAEf4Bza798NiJX3fXuZWY9a=X8F0jQPqayeoHPg5Q=rAQcRhpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     KP Singh <kpsingh@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 4:53 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Sat, Aug 27, 2022 at 1:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add a small tool, veristat, that allows mass-verification of
> > a set of *libbpf-compatible* BPF ELF object files. For each such object
> > file, veristat will attempt to verify each BPF program *individually*.
> > Regardless of success or failure, it parses BPF verifier stats and
> > outputs them in human-readable table format. In the future we can also
> > add CSV and JSON output for more scriptable post-processing, if necessary.
> >
> > veristat allows to specify a set of stats that should be output and
> > ordering between multiple objects and files (e.g., so that one can
> > easily order by total instructions processed, instead of default file
> > name, prog name, verdict, total instructions order).
> >
> > This tool should be useful for validating various BPF verifier changes
> > or even validating different kernel versions for regressions.
>
> Cool stuff!
>
> I think this would be useful for cases beyond these (i.e. for users to get
> stats about the verifier in general) and it's worth thinking if this should
> be built into bpftool?

I think it's a bit premature to put this into bpftool (IMO, I don't
like kitchen sink approach to libraries and tools), let's see how this
is used in practice first.

But yes, my plan was to expose more internal stats from verifier
through using attached BPF program. I even have BPF skeleton wired
locally, but right now just for test grab duration (which we already
get throuhg verifier log, so it's useless right now). But with BPF
program we can fetch internal BPF verifier state during verification.

I also plan to add a bit more customizability as to which subsets of
programs to run, similar to how test_progs allow to filter tests and
subtests, but here we'll have objects and progs. So anyway, this is a
very first version that I got time to clean up a bit and post. I plan
at least few more,  so let's hold off on putting this into bpftool (at
least yet).

>
> >
> > Here's an example for some of the heaviest selftests/bpf BPF object
> > files:
> >
> >   $ sudo ./veristat -s insns,file,prog {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
> >   File                                  Program                               Verdict  Duration, us  Total insns  Total states  Peak states
> >   ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------
> >   loop3.linked3.o                       while_true                            failure        350990      1000001          9663         9663
>
> [...]
>
> > --
> > 2.30.2
> >
