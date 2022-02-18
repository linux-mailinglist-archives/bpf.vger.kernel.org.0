Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699BD4BB4D5
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiBRJCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 04:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiBRJCS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 04:02:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF529546AE;
        Fri, 18 Feb 2022 01:02:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v12so13393331wrv.2;
        Fri, 18 Feb 2022 01:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zt/INQArzFP2YspYBVAWXDYYTQUHjLodpxi7D41llRw=;
        b=ksmSLR/lTnudWA58lc+ENSY99WBfEIJ9m4SWkf1/iGjZZY6xnpmH6KF71FJIZQ3tkA
         oP0gbzPmxBK7JTlyEJr33FYiAXANcxtJd10i9dL17Ze4uFSKLzWohJZlIu0yDbe/nZBU
         3EC4u8JSjVSmxG7LftBTCBrvckukNdqzD5t13pVOV3J//eGRl0eBk+z5upYYmhIJjSwP
         iRVIaT0Bj5rVvP57puhsBgmdMUOMSDF1GB/y55HZhRyRGRLybeic3uuahp5X1dqMzPgj
         C5UO4hUBk1YoE1R1+BC0KRXqNp0Ae7/biaLUmOObX9szSauvKWcZ3Pi4xacae7dMHWKT
         RkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zt/INQArzFP2YspYBVAWXDYYTQUHjLodpxi7D41llRw=;
        b=CJKi6WpSZ8RK1EI0rvYs6NXJPreJr/rXaJtoykc2NV2eCiVNZEpcQ8kgMgGVFGhpuj
         uReGnc/ZegBfygIie8c4dDxaE8rvCA60oD5jAK2OOSxAvmwMD2C6svuTJrfMHtuGkQP0
         bdzylm5eYBplgCwmQ3jjwAy3M+5uu9ZaW52TECYZHWhSeq5fBDlai9/IavVN2df9ZHIe
         GcGvIi4N++MR2OFcc7hE2S0RAs/JFnpHeM8FmIcudXeDhPJxGS6FptnrWDFIq9OLaJZt
         HsgbvfMcwGnPYXTWQBAKn5H/0vi0JB02HzvCn0beOuK4SGMLXWHLimHUsHcvb8g6OEBX
         is8w==
X-Gm-Message-State: AOAM531NwEbL6filCA1BZjYUsnXpwDgcgzKs0ei8Nw/MBduPwchsK9bw
        jewt4EHZWVqJzWJwIBuh4z2xcWw89ySF1g==
X-Google-Smtp-Source: ABdhPJwkyUQ5mu+CrJtI9sHBM7jNa9N5pnN9USLm7H+Q2cbcFnP9N3h2/J5TST6pDpQb15qSzark1A==
X-Received: by 2002:a5d:6c68:0:b0:1e8:9827:b978 with SMTP id r8-20020a5d6c68000000b001e89827b978mr4909654wrz.633.1645174920533;
        Fri, 18 Feb 2022 01:02:00 -0800 (PST)
Received: from krava ([2a00:102a:5012:d617:c924:e6ed:1707:a063])
        by smtp.gmail.com with ESMTPSA id s7sm11525680wro.104.2022.02.18.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:02:00 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:01:56 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv2 0/3] perf/bpf: Replace deprecated code
Message-ID: <Yg9ghL33UYyh3es4@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <CAEf4BzY+_3vjtN3dJjU4deVR131=Dz-9adYQ+mntVqgAOfh4RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY+_3vjtN3dJjU4deVR131=Dz-9adYQ+mntVqgAOfh4RA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 01:55:13PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > the original patchset [1] removed the whole perf functionality
> > with the hope nobody's using that. But it turned out there's
> > actually bpf script using prologue functionality, so there
> > might be users of this.
> >
> > This patchset gets rid of and adds workaround (and keeps the
> > current functionality) for following deprecated libbpf
> > functions/struct:
> >
> >   bpf_program__set_priv
> >   bpf_program__priv
> >   bpf_map__set_priv
> >   bpf_map__priv
> >   bpf_program__set_prep
> >   bpf_program__nth_fd
> >   struct bpf_prog_prep_result
> >
> > Basically it implements workarounds suggested by Andrii in [2].
> >
> > I tested with script from examples/bpf that are working for me:
> >
> >   examples/bpf/hello.c
> >   examples/bpf/5sec.c
> >
> > The rest seem to fail for various reasons even without this
> > change..  they seem unmaintained for some time now, but I might
> > have wrong setup.
> >
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/depre
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
> > [2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
> > ---
> > Jiri Olsa (3):
> >       perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
> >       perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
> >       perf tools: Rework prologue generation code
> >
> 
> It's great that you are deprecating these, thanks a lot for that! I
> suggest to also doing libbpf_set_strict_mode(LIBBPF_STRICT_ALL) to

will check

> check that libbpf 1.0 won't break anything. For example, you'll need
> to use a custom SEC() handler to handle those quirky sections that
> perf allows. This patch set has landed in bpf-next, so you should be
> good to go.

ah ok it already got merged.. I'll add it in new version

thanks,
jirka

> 
> 
> >  tools/perf/util/bpf-loader.c | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 230 insertions(+), 37 deletions(-)
