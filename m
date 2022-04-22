Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C1B50BAC2
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbiDVO43 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiDVO42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 10:56:28 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B45C36E;
        Fri, 22 Apr 2022 07:53:34 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id y32so14721905lfa.6;
        Fri, 22 Apr 2022 07:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0VILpALjxgooNpCUUQ9H0t12+7Y/aJA4JC/W0MMu4Y=;
        b=hfaIPphNi/HEJkZOFfyCKQ7juFzFwFKQQbNua2SvvUlAc6i3nGmptc7H4gB2trx0UY
         Gr0jyYnLFBT6/whfk/MtJj5CYM1TWB+7i6L4lkIJwsp4AZ8nMrXW8ohJdYxvhBaZW0Hf
         rceEKHqmOZkkNonEKZERdfo/h9yXMXpx0cXzOcJqHlX7jYotvyjocrrybTWRUIDWUYkc
         Gx5s5xxjdSCfa5/GJ41GxBPZS63/Xo4W+jkOhJCn8V/ewFAd17JfnW9CiNIBZwPlhLY+
         NjooU9LCIxSDybBZkv/ZISfEsdtkf2J27MGrN6AiyBbgudgsxEZ9+Bb+W6kFSr+SbVfx
         GH5A==
X-Gm-Message-State: AOAM532N+/oK5Ekvt2FzpZD0XS+aVtZb1koMXIcy/qir2Eu5vU0VbZey
        icCzVT29QSP691WzoEQIGcVPLMfET7M+c1dcMVVQz9rs
X-Google-Smtp-Source: ABdhPJwlc7cKv6KK0YFa2nUiR3fW//AKtK/4s6TjqOxcRhCaI2hrDN2p5K4jErdUwTi53d8YZ5x1f3P+jc4Rd35rk10=
X-Received: by 2002:ac2:4c4f:0:b0:44a:4357:c285 with SMTP id
 o15-20020ac24c4f000000b0044a4357c285mr3260154lfk.99.1650639212740; Fri, 22
 Apr 2022 07:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220422053401.208207-1-namhyung@kernel.org> <YmJ/VAt2yblZC9HN@krava>
In-Reply-To: <YmJ/VAt2yblZC9HN@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 22 Apr 2022 07:53:22 -0700
Message-ID: <CAM9d7cjGuTyOmKQsoA9kJPg-_VAuP+jWzwd=g8Z_WpMUZkypUQ@mail.gmail.com>
Subject: Re: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
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

Hi Jiri,

On Fri, Apr 22, 2022 at 3:11 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 10:33:57PM -0700, Namhyung Kim wrote:
>
> SNIP
>
> > The perf bench sched messaging created 400 processes to send/receive
> > messages through unix sockets.  It spent a large portion of cpu cycles
> > for audit filter and read/copy the messages while most of the
> > offcpu-time was in read and write calls.
> >
> > You can get the code from 'perf/offcpu-v1' branch in my tree at
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Enjoy! :)
>
>   CC      builtin-record.o
> builtin-record.c:52:10: fatal error: util/off_cpu.h: No such file or directory
>    52 | #include "util/off_cpu.h"
>
> forgot to add util/off_cpu.h ?

Oops, you're right.  Will resend soon.

Thanks,
Namhyung
