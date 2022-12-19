Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6365085F
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiLSIEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 03:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSIEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 03:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC02710
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 00:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A4DB80BAA
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AC3C433F2
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671437080;
        bh=KZZWDzAOBiMfRRR5VIK4F0cUJBgYlGleq9acKaug/+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mAs6dA2biPrgQXxkSJ5es6E+EsAP4vvuxaQ5MkDG/DaoX22Fp04Jq4NCb02487BlK
         6kzGTt1EyXqGbklH6y/tGZOgm8NG/4+YZNVLlzJGvksoD63CFEKM/e6RO4uSoJ67bX
         8FfhSAwm7e0U0w6L+N7bET+80ML14ubiU/Alw0aBfHoTKKPQCfiq3dRG2Z6xzdE7cC
         ext706CCJEB0f9ukiZf5svQ6KM2Z/7oXl69MP8xn/qfaaY9qhklf9d8HwFeCVinmdd
         avQ0/VyEaeQZ54eVwyFia0VsN0g+/umvQq15il5K4Tauz32xv42Sud+c7E9c8EV4rt
         zFMkw7obirnJQ==
Received: by mail-lj1-f169.google.com with SMTP id n1so8262646ljg.3
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 00:04:39 -0800 (PST)
X-Gm-Message-State: ANoB5pmUl0KZrkYQJaETrhdrWIrKmLTNW3+6bX8TQxItDHkwUMt5eXVy
        4ct8EssBRK4nmQExQvq/mDmGPB0sfB4g6C6oEB8=
X-Google-Smtp-Source: AA0mqf7LmNVtj4TE8stGcUE3kntx5HWSdP6sg7gD1g7u3p54rj7fdkoGw4bUemGXoe3rN3VcgKmLJAkjk8voeWAVhBM=
X-Received: by 2002:a2e:be8c:0:b0:26e:95bb:d7cc with SMTP id
 a12-20020a2ebe8c000000b0026e95bbd7ccmr29849869ljr.203.1671437077966; Mon, 19
 Dec 2022 00:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
 <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com> <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
 <425c20bd-9e7e-4fc7-9050-7d9e9bfce972@iogearbox.net> <CAMDZJNWwiScnqhvhBqDf_neiRimLGmZw-xN0UNLJE_q01K3vkQ@mail.gmail.com>
In-Reply-To: <CAMDZJNWwiScnqhvhBqDf_neiRimLGmZw-xN0UNLJE_q01K3vkQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 19 Dec 2022 00:04:24 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4ai+ojXTfgfUa+ZXyEfv8siW8Ya9+_oa+Urw=ga+rHKw@mail.gmail.com>
Message-ID: <CAPhsuW4ai+ojXTfgfUa+ZXyEfv8siW8Ya9+_oa+Urw=ga+rHKw@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 7:38 AM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
>
> On Sat, Dec 17, 2022 at 12:07 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 12/16/22 10:05 AM, Tonghao Zhang wrote:
> > > On Fri, Dec 16, 2022 at 1:40 PM Yonghong Song <yhs@meta.com> wrote:
> > >> On 12/14/22 8:32 PM, xiangxia.m.yue@gmail.com wrote:
> > >>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >>>
> > >>> Now user can enable sysctl kernel.bpf_stats_enabled to fetch
> > >>> run_time_ns and run_cnt. It's easy to calculate the average value.
> > >>>
> > >>> In some case, the max cost for bpf prog invoked, are more useful:
> > >>> is there a burst sysload or high cpu usage. This patch introduce
> > >>> a update stats helper.
> > >>
> > >> I am not 100% sure about how this single max value will be useful
> > >> in general. A particular max_run_time_ns, if much bigger than average,
> > >> could be an outlier due to preemption/softirq etc.
> > >> What you really need might be a trend over time of the run_time
> > >> to capture the burst. You could do this by taking snapshot of
> > > Hi
> > > If the bpf prog is invoked frequently,  the run_time_ns/run_cnt may
> > > not be increased too much while
> > > there is a maxcost in bpf prog. The max cost value means there is at
> > > least one high cost in bpf prog.
> > > we should take care of the most cost of bpf prog. especially, much
> > > more than run_time_ns/run_cnt.
> >
> > But then again, see Yonghong's comment with regards to outliers. I
> > think what you're probably rather asking for is something like tracking
> > p50/p90/p99 run_time_ns numbers over time to get a better picture. Not
> > sure how single max cost would help, really..
> What I am asking for is that is there a high cpu cost in bpf prog ? If
> the bpf prog run frequently,
> the run_time_ns/cnt is not what we want. because if we get bpf runtime
> stats frequently, there will
> be a high syscall cpu load. so we can't use syscall frequently. so why
> I need this max cost value, as
> yonghong say "if much bigger than average, could be an outlier due to
> preemption/softirq etc.". It is right.
> but I think there is another reason, the bpf prog may be too bad to
> cause the issue or bpf prog invoke a bpf helper which
> take a lot cpu. Anyway this can help us debug the bpf prog. and help
> us to know what max cost the prog take. If possible
> we can update the commit message and send v3.

kernel.bpf_stats_enabled is a relatively light weight monitoring interface.
One of the use cases is to enable it for a few seconds periodically, so
we can get an overview of all BPF programs in the system.

While max time cost might be useful in some debugging, I don't think
we should add it with kernel.bpf_stats_enabled. Otherwise, we can
argue p50/p90/p99 are also useful in some cases, and some other
metrics are useful in some other cases.  These metrics together will
make kernel.bpf_stats_enabled too expensive for the use case above.

Since the use case is for debugging, have you considered using
some other BPF programs to profile the target BPF program?
Please refer to "bpftool prog profile" or "perf stat -b " for
examples of similar solutions. We may need to revise the following
check in bpf_check_attach_target() to make this work for some
scenarios:

                if (tgt_prog->type == prog->type) {
                        /* Cannot fentry/fexit another fentry/fexit program.
                         * Cannot attach program extension to another extension.
                         * It's ok to attach fentry/fexit to extension program.
                         */
                        bpf_log(log, "Cannot recursively attach\n");
                        return -EINVAL;
                }

Thanks,
Song
