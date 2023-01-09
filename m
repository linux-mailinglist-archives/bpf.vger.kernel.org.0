Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D786662E68
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 19:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjAISNz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbjAISMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 13:12:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3C46C2AD;
        Mon,  9 Jan 2023 10:10:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g10so6910890wmo.1;
        Mon, 09 Jan 2023 10:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxF7YZATLTe/2r499mkb81egJwUmg6YnWv+pLAmdBuA=;
        b=LT3s1Qf2GSHOcHJwai64rE0RUGcxmEl0qUzuN64ss6he+dXmzR16OlfMW1f48dbLZM
         9UJmGIL+zDWsaK2S7xqpdBc9gPfZwwoAx9RvxLALELCwoqRdiHT2htTdlsBYZQOHvn91
         eneErjOQB8+pVtyvh59eLFohV7RCzEifjhXXQQljUxnxDFcO43xbeUkKX35s2LCYz6KA
         qzv9hhvyTitbIfuloR6L+0yyJZVRgy4YHH0Wm7Lg3AjLVk8LK9pfdMOLguxb8xn9EgKz
         Viil9chK1vxnLqofdWMfU19lzkKjPKpyUGTn6Kq3EA8hdzX86UVuiXW0CUC5gQKapxps
         81yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxF7YZATLTe/2r499mkb81egJwUmg6YnWv+pLAmdBuA=;
        b=7KS1Sbu499PY9qj6zfx+k0a1mZJWbQPG3rVZIA2p3WovYhep3sgIpnkVyhU6f1FG0Q
         Z9zhaHAqVwMA944vw6qjkleqGqD7+AuzfuPkO8OF+n/AN9yyZaA5ZrIGIziY3WF+IU+r
         98Ajs/Kb8jDvnMl8TZeknCLlv4pUxnQzOysE/GTQ5Q+v8LkbfEppr4rLwO75ILn4hNxV
         vbGiAqN9seABB15bSgvUrjpdbEuWkVyA2sU8Tisad9FNdWcBOTLBEj+RcPfdu9nhn8nw
         xpiueAhQ9BfnU8bJaueWRQ8/6zET4zpw+gjRjvJr9tWg9w+Xto5jL3lh37KhGzUmF5nP
         NALQ==
X-Gm-Message-State: AFqh2kqUhciTZm9SKfUX9lWo47L5QDahlVKLwMlvG746e/p4XWf3qxJI
        01bSNy+emyFF8QSsbPEVHEw=
X-Google-Smtp-Source: AMrXdXvIa9uPVCNa4Yqd6q/Nhcp8uRByIR6D2fjorwhZmm9jaX0gUFKtGdAbhZckmpsO9tiHLb1WYQ==
X-Received: by 2002:a1c:4c12:0:b0:3c6:e63e:89a6 with SMTP id z18-20020a1c4c12000000b003c6e63e89a6mr47019889wmf.2.1673287821142;
        Mon, 09 Jan 2023 10:10:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm17821338wmo.34.2023.01.09.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:10:20 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 9 Jan 2023 19:10:18 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y7xYimp0h4YT72/N@krava>
References: <20230106151320.619514-1-irogers@google.com>
 <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wuz6EOggZ8Wysb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 12:12:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> > So trying to get build-test working on my Debian derived distro is a
> > PITA with broken feature detection for options I don't normally use.
> 
> Its really difficult to have perf building with so many dependent
> libraries, mowing out some should be in order.
> 
> > I'll try to fix this.
> 
> Thanks.
>  
> > In any case I think I've spotted what is really happening here and it
> > isn't a failure but a feature :-D The build is specifying
> 
> I get it.
> 
> > LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> > /usr/include. I think the build is trying to do this on a system with
> > an old libbpf and hence getting the failures above. Previously, even
> > though we wanted the dynamic headers we still had a -I, this time for
> > the install_headers version. Now you really are using the system
> > version and it is broken. This means a few things:
> > - the libbpf feature test should fail if code like above is going to fail,
> 
> Agreed.
> 
> > - we may want to contemplate supporting older libbpfs (I'd rather not),
> 
> I'd rather require everybody to be up to the latest trends, but I really
> don't think that is a reasonable expectation.
> 
> > - does build-test have a way to skip known issues like this?
> 
> Unsure, Jiri?

I don't think so it just triggers the build, it's up to the features check
to disable the feature if the library is not compatible with perf code

could we add that specific libbpf call to the libbpf feature check?

jirka

> 
> But yeah, previous experiences with Andrii were that we can do not too
> costly feature checks, not using .c programs that would fail if some
> required feature wasn't present but instead would just do some grep on a
> header and if some "smell" wasn't scent, just fail the cap query.
> 
> - Arnaldo
