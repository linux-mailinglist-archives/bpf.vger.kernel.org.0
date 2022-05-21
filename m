Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380B52F798
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 04:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354351AbiEUCe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 22:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiEUCe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 22:34:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E5163F79
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 19:34:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b9so2908998qtx.11
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPOY2d2iNuO65egkCFZw3rXLU46LbwzRq0Gho1bvrl4=;
        b=gYTL0x/S9SWMzL5yr5pHjL2Os0iUM04qyTCySwDHjdtl4ZDNWVsWyGNPYQTmwR+Wa5
         vVvdRd0+/BHBjj+ZE+kimSd/G5xlwM+XO/ecdcutR1uZwUMaxdUWmyB2RMOqH+6zgwko
         ggJRNM7RXDYfxEO2YdBlTCPs9OiAGlPOnrs9/BOwORDAc5THxIwoVjG1ZxrNO1Wqp1un
         Xae4Tn5esHxugHU4Md0EVA17aJQTl0MJwZ9IfrTBn0P1+CYouofVbq7Gs1KNJI9rt+Lq
         hDWArAengQ0djrKjfvMKg39LWXmqeEcUV8yYVD9rNhDOPtjQrbnxQlXYRbWwysYvePbD
         P4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPOY2d2iNuO65egkCFZw3rXLU46LbwzRq0Gho1bvrl4=;
        b=luXz7RMPScYXRdIfLNBPvTapg2lXiW/eufJAXwyV5KXV+t0lMUTM6wA9bfnQ1pLp0j
         XJa059ozPJLwrdr8QSF7+kG/3eFEnZ3qxAEy3Qi8oMo9T23do5Lf4Y9KyCh7kojxkgCA
         SXEBLjPA+9lxLpOS08QmQf9H50fQj9tjwB0hCqCAMHsicwvre1Ui8/44FWMMJ24C0bPE
         g0rDfR8j5E1iAw8PfxoA+vlN9HGsxiH0L5B7dPcvD9PFoZb+FprMTv34yI5f1105n3iy
         EbAyx5c39yThX3+LYUX1wU8RbkwdqVDPybnWxvzqYgGpK+eZiYjmzDyqpfcauNF9rU8Z
         oNfA==
X-Gm-Message-State: AOAM5313DIY0JcT9o6JCMg59F0sav+O9clvOfZas1Dx5Jer2ECE/Ptc8
        MRObxlhdBnfwEy6xHV+kaX1rPAvfAliFG7Zwfh541Q==
X-Google-Smtp-Source: ABdhPJwd+HVn4+3QpKDEw2AoM1qT+hYBOJBZ2hv6MdNy7IotYmml2BidH2U0zIMWITMViRtg63Jxg05O6pU/nFgGjzU=
X-Received: by 2002:ac8:5845:0:b0:2f9:1c6a:f65f with SMTP id
 h5-20020ac85845000000b002f91c6af65fmr5026503qth.168.1653100496556; Fri, 20
 May 2022 19:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220520012133.1217211-1-yosryahmed@google.com>
 <20220520012133.1217211-4-yosryahmed@google.com> <YodGI73xq8aIBrNM@slm.duckdns.org>
 <CAJD7tkbvMcMWESMcWi6TtdCKLr6keBNGgZTnqcHZvBrPa1qWPw@mail.gmail.com>
 <YodNLpxut+Zddnre@slm.duckdns.org> <73fd9853-5dab-8b59-24a0-74c0a6cae88e@fb.com>
 <YofFli6UCX4J5YnU@slm.duckdns.org> <CA+khW7gjWVKrwCgDD-4ZdCf5CMcA4-YL0bLm6aWM74+qNQ4c0A@mail.gmail.com>
 <CAJD7tkaJQjfSy+YARFRkqQ8m7OGJHO9v91mSk-cFeo9Z5UVJKg@mail.gmail.com>
 <20220520221919.jnqgv52k4ajlgzcl@MBP-98dd607d3435.dhcp.thefacebook.com>
 <Yogc0Kb5ZVDaQ0oU@slm.duckdns.org> <5b301151-0a65-df43-3a3a-6d57e10cfc2d@fb.com>
In-Reply-To: <5b301151-0a65-df43-3a3a-6d57e10cfc2d@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 20 May 2022 19:34:45 -0700
Message-ID: <CA+khW7gGrwTrDsfWp7wj=QaCg01FNj381a1QLs1ThsjAkW85eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
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
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 5:59 PM Yonghong Song <yhs@fb.com> wrote:
> On 5/20/22 3:57 PM, Tejun Heo wrote:
> > Hello,
> >
> > On Fri, May 20, 2022 at 03:19:19PM -0700, Alexei Starovoitov wrote:
> >> We have bpf_map iterator that walks all bpf maps.
> >> When map iterator is parametrized with map_fd the iterator walks
> >> all elements of that map.
> >> cgroup iterator should have similar semantics.
> >> When non-parameterized it will walk all cgroups and their descendent
> >> depth first way. I believe that's what Yonghong is proposing.
> >> When parametrized it will start from that particular cgroup and
> >> walk all descendant of that cgroup only.
> >> The bpf prog can stop the iteration right away with ret 1.
> >> Maybe we can add two parameters. One -> cgroup_fd to use and another ->
> >> the order of iteration css_for_each_descendant_pre vs _post.
> >> wdyt?
> >
> > Sounds perfectly reasonable to me.
>
> This works for me too. Thanks!
>

This sounds good to me. Thanks. Let's try to do it in the next iteration.
