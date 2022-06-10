Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9EC546F3F
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiFJVal (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344189AbiFJVak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 17:30:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD27170674
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 14:30:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v14so161536wra.5
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95Jw5s5U+9h+RH3k4GM+5YUCgDK6/y0zF6sj5xk3tV0=;
        b=I+ONCW4N40xi6OHman8kT5DVagz+dhj6LV2/JU1uBHo+0lmkQbKluqGvs343u50BiS
         OyvUQ4SPAlJtyZOqfiIWw4B7wLi1gaxgumSP6uftAkDU76vru5Oo+77mrE0i9qhYJ1Dj
         jQA0YKZTzSfZtqzfixdeJuPJ/r4nZCV6ViCmqpISYzWBLUSyhDBw77FX6rMZFxmlfcNN
         Lfrl98LpKkvIFHqxznHvSNq8sQyfhl7nVGOQoP75TBvCmjitZYk8Jq7e+KBEHa28eMky
         OUKnIRVFISHidByYyg5+mBN3C+AoCqeHKMyfjs6CuC5cZoGFs4SZYnlM1X0zRNJc6cx0
         bsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95Jw5s5U+9h+RH3k4GM+5YUCgDK6/y0zF6sj5xk3tV0=;
        b=JfL5+kbXXg/seMvjSdBpcfXOUA1NrFWGMaLTrXBzob1nI6XdyH6eViI5e64ujujpO6
         DFIA4JlelJ2Mpym3TsBXtMiVX+mWbDszRO8Y47x2WfqtAuWTHovOF9GCbfP7EVzJX0eZ
         p8f7tZWb+U044O8TEEq5n1I4H1QFz5iycSasjvEcFZDmS/qhUiwoN7X2KaZfRsWK1Tcl
         J5iSgv1dxMyX0ylvb68WweJWOKequJmMFoXxx9J/EyWT48y9bOvnjDXMcSz1kW2/xsfk
         kAz4zIqd9y562M+650vL/+uVDzvXdDKGRVBOA/fGL/Qg1/Z+i7LjnWJzhis2vjP27ILW
         9pFA==
X-Gm-Message-State: AOAM530f/889+BesGdxC0zpzc9Ua+nzewKWRv47ZIOGZe0PRF67tRB5A
        ZPOGFHdVh0pMSqiRdWw3keLY0ZpQJv6vtewlPBI1Ww==
X-Google-Smtp-Source: ABdhPJxzGybtZ6uQAuitoi6eQ4H1r7WjMlGRVlPssDwL2Qk1WogiF+6kTSmqyCidwoPtKlFgR+vNONC+zuhdPj2u5WM=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr45526846wrr.534.1654896636555; Fri, 10
 Jun 2022 14:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-7-yosryahmed@google.com> <202206110544.D5cTU0WQ-lkp@intel.com>
In-Reply-To: <202206110544.D5cTU0WQ-lkp@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 10 Jun 2022 14:30:00 -0700
Message-ID: <CAJD7tkZqCrqx0UFHVXv3VMNNk8YJrJGtVVy_tP3GDTryh375PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/8] cgroup: bpf: enable bpf programs to
 integrate with rstat
To:     kernel test robot <lkp@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>, kbuild-all@lists.01.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 10, 2022 at 2:23 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Yosry,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/bpf-rstat-cgroup-hierarchical-stats/20220611-034720
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220611/202206110544.D5cTU0WQ-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/83f297e2b47dc41b511f071b9eadf38339387b41
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yosry-Ahmed/bpf-rstat-cgroup-hierarchical-stats/20220611-034720
>         git checkout 83f297e2b47dc41b511f071b9eadf38339387b41
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/cgroup/rstat.c:161:22: warning: no previous prototype for 'bpf_rstat_flush' [-Wmissing-prototypes]
>      161 | __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>          |                      ^~~~~~~~~~~~~~~
> >> kernel/cgroup/rstat.c:509:10: error: 'const struct btf_kfunc_id_set' has no member named 'sleepable_set'; did you mean 'release_set'?
>      509 |         .sleepable_set  = &bpf_rstat_sleepable_kfunc_ids,
>          |          ^~~~~~~~~~~~~
>          |          release_set
>    kernel/cgroup/rstat.c:509:27: warning: excess elements in struct initializer
>      509 |         .sleepable_set  = &bpf_rstat_sleepable_kfunc_ids,
>          |                           ^
>    kernel/cgroup/rstat.c:509:27: note: (near initialization for 'bpf_rstat_kfunc_set')
>
>
> vim +509 kernel/cgroup/rstat.c
>
>    505
>    506  static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
>    507          .owner          = THIS_MODULE,
>    508          .check_set      = &bpf_rstat_check_kfunc_ids,
>  > 509          .sleepable_set  = &bpf_rstat_sleepable_kfunc_ids,
>    510  };
>    511
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

AFAICT these failures are because the patch series depends on a patch
in the mailing list [1] that is not in bpf-next, as explained by the
cover letter.

[1] https://lore.kernel.org/bpf/20220421140740.459558-5-benjamin.tissoires@redhat.com/
