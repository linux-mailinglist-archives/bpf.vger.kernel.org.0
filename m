Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6116090A6
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 03:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJWBQp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Oct 2022 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWBQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Oct 2022 21:16:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D551DFAD;
        Sat, 22 Oct 2022 18:16:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r14so19194910edc.7;
        Sat, 22 Oct 2022 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTUZ9ZfhQbY7Sl8R6nldBu8JmbFhh7EdT+zCO2E+5ps=;
        b=bdSs8MvSxoUmwaOBI4QxUSfvezkQc71r4WZp6UV/ufhwfqzuKmfDjF18HEe9DZ4u4e
         9+4wt8LSaJbtDHyIlLHGJxWO2j4r8HMf8O5fglTTdsWsHNYvLTv84z7WehCjbc4OTjlF
         DBZ8WSBc3AYVpEx3G0YfSylDOC3sMqPj46wzlA+dS0j30wxqpUbkTPsaszVsqr5yy1ph
         BwW+H7gKOMhxM+TLzKyYAr0TBmXEsKTAGVretmRHu18/f0ZAIlv5P1JFT8+H/8DHB6OV
         Aipm2fK0VofY7GtiwF1Ffb+NCKd1kvyrTyZDIn1sjqPt7StKuKdnYKFknuK8b88EP/sF
         QnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTUZ9ZfhQbY7Sl8R6nldBu8JmbFhh7EdT+zCO2E+5ps=;
        b=UoQjId5Br/xUzENQp3+YysambMHCLpGMtZWbrXMx7xDPnO9ShAIglAJry4gqovZJr+
         T80ybJKuoIdbioFT5saPSrFnFAtmuXahfZA5Mz8kA34EGXyECOP4gm7MRScf8L71IOWb
         OY2N351Z7bOFtcJbM475JGe91+akzmdwNOPtF9aFCTK3Fwd+cFT94kRJox8bc63JzDnP
         Rir+HEQhiGsAJfJ6GNcM23AZSB56RcU3gK5cKGW2dJfpOdVXPsAWng3TVjLtVMH83+wZ
         yBlG94aOR8mN8GiL162ChpM9EaxQZcKhS8WcNl3Gpu8kZH4fbldMnDjX8VbQqax9w8ci
         YsBA==
X-Gm-Message-State: ACrzQf3lhd56DonkgDs5NlHLg7s6GSGN6PcWnROHJ7xlvjb0RzAFohjr
        8TiRPgy9C5WBEg9FHxUMvipwuZuYyRzfFi/wRgU=
X-Google-Smtp-Source: AMsMyM7W9mwyxrQBNyBxmxqcWF5O05K7nSV5ti/ZFgJfecgA/RE3ZudX5sg7pwkHJR8gvWHZmhCaqdFGvJO8UT40tRU=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr24624897edb.333.1666487801784; Sat, 22
 Oct 2022 18:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
 <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com> <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
In-Reply-To: <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 22 Oct 2022 18:16:30 -0700
Message-ID: <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com>
Subject: bpf+perf is still broken. Was: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
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

Another 2 days have passed and the fix is still not in the Linus's tree.

Peter,
whatever your excuse is for not sending tip:perf/urgent
this is not acceptable.

Linus,

please apply this fix directly:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/urgent&id=21da7472a040420f2dc624ffec70291a72c5d6a6

or suggest the course of action.

It sucked to have such a breakage in rc1 and we don't want rc2
to stay broken.

Thanks

On Thu, Oct 20, 2022 at 6:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Peter,
>
> Another 2 days have passed and bpf side is still broken
> due to the change that went during the merge window without
> corresponding fix from the bpf side.
> Looks like the patch is sitting in tip:perf/urgent.
> Please send it to Linus asap.
>
> We're not sending bpf fixes to avoid breaking bpf tree too.
> We've worked around the issue in bpf CI for bpf-next tree only.
> Developers still see failures when they run tests locally.
>
> On Tue, Oct 18, 2022 at 9:57 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 7, 2022 at 8:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Oct 07, 2022 at 11:45:36AM +0200, Jiri Olsa wrote:
> > > > On Fri, Oct 07, 2022 at 10:13:27AM +0200, Sumanth Korikkar wrote:
> > > > > * Raw data is also filled by bpf_perf_event_output.
> > > > > * Add sample_flags to indicate raw data.
> > > > > * This eliminates the segfaults as shown below:
> > > > >   Run ./samples/bpf/trace_output
> > > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > > >   BUG pid 9 cookie 1001000000004 sized 4
> > > > >   Segmentation fault (core dumped)
> > > > >
> > > > > Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > > >
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > >
> > > > Peter,
> > > > I think this should go through your tree again?
> > > > bpf-next/master does not have sample_flags merged yet
> > >
> > > Yep can do. I'll line it up in perf/urgent (Ingo just send out
> > > perf/core).
> >
> > Peter,
> >
> > Could you please hurry up. 11 days have passed.
> >
> > This issue affects everyone the hard way now after merging
> > all the trees: tip -> linus -> net-next -> bpf-next.
> > The BPF CI is red right now with 5 tests failing because
> > this fix is still missing.
> > It's causing a headache to maintainers and developers.
