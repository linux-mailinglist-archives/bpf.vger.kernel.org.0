Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A270606D10
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJUBgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUBga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:36:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD210DE7E;
        Thu, 20 Oct 2022 18:36:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot12so3761594ejb.1;
        Thu, 20 Oct 2022 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=riV2LKDCFyGjMOKFMcuq4CjIaZfhS9K0Zw+bRcaY9Ps=;
        b=Z/b1h0Ea2IOWf8ygXQlMOLriBrTuYzmtSPrEuu6v+TL+mM9RxVlN44VRR1wiRY3PXT
         Bt9WCuzw44D56rPl7WwjzQtG3JthD69N1HfVQgJndDhDK9LWPdxdhH6qhdD6oNuF0ZKf
         v7lpBBhqsSbaQIG2t8Ed2Ldgmb1KjyfOv1qo6+Az9Pqo4tYBB6GUy56zRt9Vdff6lbHi
         O7hgksyhy7pRlPOAXBco9KRMG56RXO4EUluwNAbNuQGKbinuvJGRxB8aWa+y6QOTK6PX
         mRGk1nhnjMWZuP98i8prLVwmLuAmnE315L2xgSwUYaYAneLqFfQxI7sQVG4AQFC3YBB6
         YC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riV2LKDCFyGjMOKFMcuq4CjIaZfhS9K0Zw+bRcaY9Ps=;
        b=UP1iBLhUekRpu8d1p/J2raPCmtYi34lCFpY63O2qRFdamXYwaXePnj25Ub/GLHU18t
         V8TPdbLdcG7A3I3f+eCe4aY3XUKtb0j9D92+nhVenlbH+BQGPTZc0InYUzkFv2ufDZmn
         jmq5HZFykaGDesVuM5FBlidvg+td8aDtU/3Hi8oBi3qBzsuJ9Na8FFWbxt7pic4FEay2
         lq3yEsVu5RK7mR4pJVsxJTRcfQLa29arvYQZuGuUa7KmYq4O2cPbULL+59216foz3+TT
         z4hslp2qb+IfdvnZz8ygaxf4t3Jevm9cN47zByyuKow5THa1zvUVEODEK0oEciQmhReI
         lIGw==
X-Gm-Message-State: ACrzQf1vo+UYj9bteerMB/ihGgeTcd5iRsM7K6ZuVDVrA7wqrAc4CgQ0
        6hMv4loFr/PwtvwzfKDKkNo/6M0nhyqstacLZ3aUALVF
X-Google-Smtp-Source: AMsMyM5ljJniXUYLRN9ji7bgw5RywfZYlVJvXYot0viEKNYOvBV5IcbY/KdfypX2Fe0N4EnnN6USoZp5ku2SCRZqSM4=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr12669803ejc.94.1666316187888; Thu, 20
 Oct 2022 18:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net> <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
In-Reply-To: <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Oct 2022 18:36:16 -0700
Message-ID: <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        X86 ML <x86@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Peter,

Another 2 days have passed and bpf side is still broken
due to the change that went during the merge window without
corresponding fix from the bpf side.
Looks like the patch is sitting in tip:perf/urgent.
Please send it to Linus asap.

We're not sending bpf fixes to avoid breaking bpf tree too.
We've worked around the issue in bpf CI for bpf-next tree only.
Developers still see failures when they run tests locally.

On Tue, Oct 18, 2022 at 9:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 7, 2022 at 8:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Oct 07, 2022 at 11:45:36AM +0200, Jiri Olsa wrote:
> > > On Fri, Oct 07, 2022 at 10:13:27AM +0200, Sumanth Korikkar wrote:
> > > > * Raw data is also filled by bpf_perf_event_output.
> > > > * Add sample_flags to indicate raw data.
> > > > * This eliminates the segfaults as shown below:
> > > >   Run ./samples/bpf/trace_output
> > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > >   Segmentation fault (core dumped)
> > > >
> > > > Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > Peter,
> > > I think this should go through your tree again?
> > > bpf-next/master does not have sample_flags merged yet
> >
> > Yep can do. I'll line it up in perf/urgent (Ingo just send out
> > perf/core).
>
> Peter,
>
> Could you please hurry up. 11 days have passed.
>
> This issue affects everyone the hard way now after merging
> all the trees: tip -> linus -> net-next -> bpf-next.
> The BPF CI is red right now with 5 tests failing because
> this fix is still missing.
> It's causing a headache to maintainers and developers.
