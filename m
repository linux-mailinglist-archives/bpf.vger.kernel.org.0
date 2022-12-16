Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2464E875
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLPJGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 04:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLPJGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 04:06:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FB2619
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 01:06:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y16so1847534wrm.2
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olHn5MCxfBfzgmAFZn2et4YhVN00CNsU34GxGc8yCFA=;
        b=iEw48oA6mxDmBBUhVKjQT+YvHZ81k1hXDzHIwxkuJIMXQ5fadAESZLop34zsOgxl7M
         Vw/eO6xJfI+IHXSrU3Miz7A3p0gKDGtqfwxYin/rKef3cf+C0XD8QCmdEYvRDCUZomSo
         Iuv9VsQ09pzuSUKxQSZFK/32t9aES1Wd23yOO8R7u+yHbTQyIasqSPuVonnCLPLAifpP
         Wgq1Y+abhuqfO33nUJcMKAtvWgWOKy10ssOkwXTqyGnkHykfqm7TO8GlNd06THAgq8yY
         2bpl2VYPu6lEZGFzqBZCHlvAH2qrJtf/k2D1/xXle4W6ZyYyb0mYqyyxdviA1Eqs/HD/
         V2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olHn5MCxfBfzgmAFZn2et4YhVN00CNsU34GxGc8yCFA=;
        b=ijo119iF4UuHjI7pbK/a+PULW16VwvTQp0hnHG18lWJEIZes/REOgcRKBcxJaRLGpZ
         RdWZevihnj2JbuzPvyYmcOu5mDLQ2bftZU7CfC3TxjHgCsJal4Y2XNBdsVZK5/vhlBQh
         scFWYNwkErldjFHavVz3ugqynyhBtucZSsqYKM/4fBMWPO7pn0Br7dcA6YQNJK8s9ppy
         S3MA+x1HfW2ZAes4RoY9PB1JercGcG6iUtnGcRqZAkB1dUFzuGyQAmFFMjCcXfyV2y1V
         jyM/Sz6LniF7dO1Zqx40XdSU28EMORIlzJHMHXY7QLh8sMCIP35flibYr0hhQYbll65L
         /6xg==
X-Gm-Message-State: ANoB5pnbj4gxSuxnJcLxsu7fQMWxqd8qnhBTZspmkazHlOzXU/SnAMFn
        IWPG1Gxt07OhlJvpR1+q4ZCtOnM1LfOd0sM4TEA=
X-Google-Smtp-Source: AA0mqf5DZDZ4aOQn6uUZwA/OdDRoYgXxgRs4DT2w+x9EUzvIv5P7MKtxEJPzFkXedwRwW1WqrgzEe3ycQFf6cNJofVA=
X-Received: by 2002:adf:e68a:0:b0:242:1926:7838 with SMTP id
 r10-20020adfe68a000000b0024219267838mr29560408wrm.200.1671181590451; Fri, 16
 Dec 2022 01:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com> <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com>
In-Reply-To: <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Fri, 16 Dec 2022 17:05:54 +0800
Message-ID: <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
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

On Fri, Dec 16, 2022 at 1:40 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/14/22 8:32 PM, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Now user can enable sysctl kernel.bpf_stats_enabled to fetch
> > run_time_ns and run_cnt. It's easy to calculate the average value.
> >
> > In some case, the max cost for bpf prog invoked, are more useful:
> > is there a burst sysload or high cpu usage. This patch introduce
> > a update stats helper.
>
> I am not 100% sure about how this single max value will be useful
> in general. A particular max_run_time_ns, if much bigger than average,
> could be an outlier due to preemption/softirq etc.
> What you really need might be a trend over time of the run_time
> to capture the burst. You could do this by taking snapshot of
Hi
If the bpf prog is invoked frequently,  the run_time_ns/run_cnt may
not be increased too much while
there is a maxcost in bpf prog. The max cost value means there is at
least one high cost in bpf prog.
we should take care of the most cost of bpf prog. especially, much
more than run_time_ns/run_cnt.

> run_time_ns/run_cnt periodically and plot the trend of average
> run_time_ns which might correlate with other system activity.
> Maybe I missed some use cases for max_run_time_ns...
>
> >
> > $ bpftool --json --pretty p s
> >     ...
> >     "run_max_cost_ns": 313367
> >
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Hou Tao <houtao1@huawei.com>
> > ---
> > v2: fix build warning
> > ---
> >   include/linux/filter.h   | 29 ++++++++++++++++++++++-------
> >   include/uapi/linux/bpf.h |  1 +
> >   kernel/bpf/syscall.c     | 10 +++++++++-
> >   kernel/bpf/trampoline.c  | 10 +---------
> >   4 files changed, 33 insertions(+), 17 deletions(-)
> >
> [...]



-- 
Best regards, Tonghao
