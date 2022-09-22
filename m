Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336805E6D41
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIVUmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIVUmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:31 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5602BE1D;
        Thu, 22 Sep 2022 13:42:20 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-127d10b4f19so15583111fac.9;
        Thu, 22 Sep 2022 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3dECk8qtLuWOyUzSXxGEhLHUboxYbqxiQ3lBB2QNciU=;
        b=trPFM58jt7nk+lUxGVr7+cCJLiS/MmJWqYqY87jmU5JyHqVHtDqvXJr4FScxJHYF0a
         T3R1D5Pft/1OBWcgw4NfNda0je89y8x7FfB4kYYQnW3p9qKeVewjzBZdcxMARThBakDQ
         WcIg3UBptohvN8SuE5FfyhahsMQQc1IwoWCn5BfRjyoNLkRqhT6I+u9YTjAHggk8uFGF
         irJ5mnyoa7KQmBY4svs1n+ukwvZ6L3ePq0zZ/YjDeKphNdudI1V6ab/PTdW6o7z9c3xk
         NNj0ST/mVInOVOz1n4qoWfx+7oYBNoKTP6BBjvMzoUSD5jiGn+oL4imXv1c48IkyGW90
         Mi/g==
X-Gm-Message-State: ACrzQf09AkzHoqKgFujOXhJd56ncKWe/IXRXm9JriLrmbgYwhKfUjXPI
        PAuq4nuczWhOgUY++KVm9tik+vAr91bSlTIz6swJzqja
X-Google-Smtp-Source: AMsMyM7xxk2v/QGRxCHHCPHU3JWEv8s/ChjQVVxQmYHc2P96YaSqPmCpG1TUOoMJSMKNckPI2SyiiUJRToO6mTHLeg4=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr3070076oai.209.1663879339628; Thu, 22
 Sep 2022 13:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922044023.718774-1-namhyung@kernel.org> <CA+khW7gQPqoBSi5bSQXFdnkVyjMpu4A=vzFXRLvWDjZww0brEA@mail.gmail.com>
In-Reply-To: <CA+khW7gQPqoBSi5bSQXFdnkVyjMpu4A=vzFXRLvWDjZww0brEA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Sep 2022 13:42:08 -0700
Message-ID: <CAM9d7cjpZVeh4D27PWNv4Z=PEH+2TajNte-GkvWJiAuXz5AhBQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Get a perf cgroup more portably in BPF
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

On Thu, Sep 22, 2022 at 12:36 PM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Sep 21, 2022 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_cgrp_id can be different on other configurations.
> > To be more portable as CO-RE, it needs to get the cgroup subsys id
> > using the bpf_core_enum_value() helper.
> >
>
> I remember using bpf_core_enum_value requires a compiler built-in. So
> the build will fail on old compiler such as clang-11. See [1]. Maybe
> we should surround it with #if
> __has_builtin(__builtin_preserve_enum_value) to be sure.
>
> [1]  https://www.spinics.net/lists/bpf/msg30859.html

Thanks for pointing this out.  As this is a kind of optimization
I think we can fallback to using the existing value if not available.
Will send v3.

Thanks,
Namhyung
