Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AC5226B1
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiEJWKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiEJWKt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:10:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8C4B856
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:10:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg25so149355wmb.4
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7uOUCqMoDgltJ1uxZ5LMikYT8wvvkHVCGV6bc1awcY=;
        b=Gd7NslwHhpbIbxp10MPezPhTaEU5GdrwG8KeXZN8DL72uNDigerprtOo0TkFtwaOd3
         mWkOyJ08FDW34jRv/tAS7FAW30ZQyBqaiFyE93uZTlsyiBezkqXtI5KUb3f23DdQ6MZS
         X0EhZuRxspsI8kngmi34mQjgoANio3kHInTXm5gn+4m8xQsuyxwUmP++TfEBV2SBbJzz
         oH7ilbDk5KBGr/29XTHbFFeRyVSm7/Af1v1Slrac5Sz6rLUqt3S8UAhSVajhfyhTdQTT
         fACT+w973yomcwW3HIcFPP5L7MXi0Qt/JDzndbbI8CiD81VlxTsmiGtyMS9qmqQmOLYb
         uAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7uOUCqMoDgltJ1uxZ5LMikYT8wvvkHVCGV6bc1awcY=;
        b=uYFGYSugp2QBo5s9dz+3bxUuz8CQA3yBCFTUMtKHFjYZzBEovuEAl1eEeG1MAEM5m6
         NwzC+XZ6IF4mNi72Pgwo6xv2QUkV45ooBLPy2/D1nfkeH0x+yB1g/BAhdzMKhPlP0H/g
         t4eH0dgUKTB0uk6NIl4ARbUkKTbOfEfCvIeHR3Jpdk/SkY1qElmIUQEgOI7oBBj/oGne
         //VRl7E9OhfjNcDw2yI//Ut1r7D6cvSMVOxDw3Yj/TXgVUpPcBocwyA1jDrfHw5oo+nj
         2M3hMdJ+91rvrJteXnINM8JICHVcVpFQBVG2WLlXR123hPUudxkR4cMRaK3u4eqA0j4l
         qzLA==
X-Gm-Message-State: AOAM531OE2/28dp/1S1EJTVNvP1wSpMEvQob1b/hYyImldwSuK3R2uUs
        2OytdG1r8aY4HrUHSqkDmtu7jpygY8Q86QtgpKe5Cw==
X-Google-Smtp-Source: ABdhPJzc5js95IRYFhLwrUoxIOFFkbtCpzBmxCCkGcg+jWEPrv5zwAV5Dm0/WNo2UZ/SvLnHHl9FBXsSkgRx6auNZs8=
X-Received: by 2002:a05:600c:1908:b0:394:867d:66c4 with SMTP id
 j8-20020a05600c190800b00394867d66c4mr1893863wmq.152.1652220646220; Tue, 10
 May 2022 15:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
 <20220510001807.4132027-2-yosryahmed@google.com> <Ynqyh+K1tMyNCTUW@slm.duckdns.org>
 <CAJD7tkZVXJY3s2k8M4pcq+eJVD+aX=iMDiDKtdE=j0_q+UWQzA@mail.gmail.com>
 <YnrEDfZs1kuB1gu5@slm.duckdns.org> <CAJD7tkahC1e-_K0xJMu-xXwd8WNVzYDRgJFua9=JhNRq7b+G8A@mail.gmail.com>
 <YnrSrKFTBn3IyUfa@slm.duckdns.org> <CAJD7tkbeZPH9UJXtGeopPnTSVPYN-GzzM51SE_QNuLmiaVNpeA@mail.gmail.com>
 <YnrijQK6l77qAo+z@slm.duckdns.org>
In-Reply-To: <YnrijQK6l77qAo+z@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 May 2022 15:10:09 -0700
Message-ID: <CAJD7tkZPLStC2h5PhZpDhp+vSBM3oExROpOO33_SdB+bpUMo_Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/9] bpf: introduce CGROUP_SUBSYS_RSTAT
 program type
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 3:09 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 10, 2022 at 02:55:32PM -0700, Yosry Ahmed wrote:
> > That's great to hear. I am all in for making the userspace interface
> > simpler. I will rework this patch series so that the BPF programs just
> > attach to "rstat" and send a V1.
> > Any other concerns you have that you think I should address in V1?
>
> Not that I can think of right now but my bpf side insight is really limited,
> so it might be worthwhile to wait for some bpf folks to chime in?
>

Sounds good. Will wait for feedback on the BPF side of things before I
send a V1.

> Thanks.
>
> --
> tejun
