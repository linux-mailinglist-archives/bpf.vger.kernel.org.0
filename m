Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF15A0485
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiHXXOf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 19:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHXXOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 19:14:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57258050D
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 16:14:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h21so13994497qta.3
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0T8rRMCDsA1j5qf5sbj+9e56n6YXfCGLxz6FeS+4egw=;
        b=IezYPxrJxJ92Yq4G0IsZVX3XwrGTHfYdPo9SqR5McWQxWKPvNh7tCNXAr2i+Xr5eRa
         maAvXMi4mgRC9UFyouKdfxFdx8Gx890qgUr+oSyc4Q+dm4cmcRCvjjIfY9Rw7QGkskvS
         Jymg109i5njjRy3v9iHc2kOY0whrE6mmtbzniUmyZraeDjOJc7bml7eFXrm21pXdiQRl
         6MhThB4UguShf7XDMpqJel42jBbvbDWlEv9lvPqHe7oy1fUb68OrNZB5OWHn1eOfbTpK
         sVlJWUrrfzuezk7vp58cqDHQypcvW49MVKsuep6BjhvFQWI5woGHZMA92TQLcw1lgnH2
         dybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0T8rRMCDsA1j5qf5sbj+9e56n6YXfCGLxz6FeS+4egw=;
        b=jyNyuitzz66NEQk1bKo1AgBW+dRRorzld0qtOSLb/pOJhjHCjWFrtV0rws0nSJbs2O
         XDdri9A7sdzEYvcS56uiLQL4frFyDQeqeGpo3QS5sf0b1Szc8eraR6qwkTEChkBJOmv7
         rKpkfXg+f5nSsGzdXUTduahtFdfpdzgwc++N859BjPJ0DP/XPA02O5o2y4eXYkFQ9POt
         htmUwkHTNny3tPMuGfw+lIiR6quu/cWzgG4lnUXuZFYfERsrXX81bLUYc5Pc9geVv+FV
         3mJ5Zjmc4JFWqoxJovzqwGEe1MgOahsgECMIGkfklNbUgO7OirHTkgvBeAeuAlVYvMvr
         MaYA==
X-Gm-Message-State: ACgBeo0EhM9srNPv+Xq1yCX2lZEHTBwuvq185XEwYRcN7+3VbcraX3Ml
        AAPSPT7mqRu6+qig7j2TnSetOfzEmuaZtAOfHwviZg==
X-Google-Smtp-Source: AA6agR5x+CI6oDBhE9QKyvvfLhdLE8g5b/Jw71IWH/EQrOnXEVNxQ2ZdXjjHqb5T2BhP4qrAJRIAvmIzibmt9qysMWI=
X-Received: by 2002:a05:622a:552:b0:342:f8c2:442 with SMTP id
 m18-20020a05622a055200b00342f8c20442mr1469373qtx.478.1661382866682; Wed, 24
 Aug 2022 16:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220824030031.1013441-1-haoluo@google.com> <20220824030031.1013441-6-haoluo@google.com>
 <CA+khW7go3_KNjju=auaX0A0Ff4-DcmGr9=+TW1tpuqxFv8uwag@mail.gmail.com> <CAP01T77oxbfQnHSX5irq0d=srArq=ZTf_VAMuw0QNhfcjJVdKQ@mail.gmail.com>
In-Reply-To: <CAP01T77oxbfQnHSX5irq0d=srArq=ZTf_VAMuw0QNhfcjJVdKQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 24 Aug 2022 16:14:16 -0700
Message-ID: <CA+khW7jg0GADzkATgz+PaBWQqRJcuKThOVDYkMOHasSiYMHUOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 5/5] selftests/bpf: add a selftest for cgroup
 hierarchical stats collection
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Wed, Aug 24, 2022 at 4:09 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 25 Aug 2022 at 01:07, Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 8:01 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > Add a selftest that tests the whole workflow for collecting,
> > > aggregating (flushing), and displaying cgroup hierarchical stats.
> > >
> > > TL;DR:
> > > - Userspace program creates a cgroup hierarchy and induces memcg reclaim
> > >   in parts of it.
> > > - Whenever reclaim happens, vmscan_start and vmscan_end update
> > >   per-cgroup percpu readings, and tell rstat which (cgroup, cpu) pairs
> > >   have updates.
> > > - When userspace tries to read the stats, vmscan_dump calls rstat to flush
> > >   the stats, and outputs the stats in text format to userspace (similar
> > >   to cgroupfs stats).
> > > - rstat calls vmscan_flush once for every (cgroup, cpu) pair that has
> > >   updates, vmscan_flush aggregates cpu readings and propagates updates
> > >   to parents.
> > > - Userspace program makes sure the stats are aggregated and read
> > >   correctly.
> > >
> > > Detailed explanation:
> > > - The test loads tracing bpf programs, vmscan_start and vmscan_end, to
> > >   measure the latency of cgroup reclaim. Per-cgroup readings are stored in
> > >   percpu maps for efficiency. When a cgroup reading is updated on a cpu,
> > >   cgroup_rstat_updated(cgroup, cpu) is called to add the cgroup to the
> > >   rstat updated tree on that cpu.
> > >
> > > - A cgroup_iter program, vmscan_dump, is loaded and pinned to a file, for
> > >   each cgroup. Reading this file invokes the program, which calls
> > >   cgroup_rstat_flush(cgroup) to ask rstat to propagate the updates for all
> > >   cpus and cgroups that have updates in this cgroup's subtree. Afterwards,
> > >   the stats are exposed to the user. vmscan_dump returns 1 to terminate
> > >   iteration early, so that we only expose stats for one cgroup per read.
> > >
> > > - An ftrace program, vmscan_flush, is also loaded and attached to
> > >   bpf_rstat_flush. When rstat flushing is ongoing, vmscan_flush is invoked
> > >   once for each (cgroup, cpu) pair that has updates. cgroups are popped
> > >   from the rstat tree in a bottom-up fashion, so calls will always be
> > >   made for cgroups that have updates before their parents. The program
> > >   aggregates percpu readings to a total per-cgroup reading, and also
> > >   propagates them to the parent cgroup. After rstat flushing is over, all
> > >   cgroups will have correct updated hierarchical readings (including all
> > >   cpus and all their descendants).
> > >
> > > - Finally, the test creates a cgroup hierarchy and induces memcg reclaim
> > >   in parts of it, and makes sure that the stats collection, aggregation,
> > >   and reading workflow works as expected.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> >
> > I saw this test failed on CI on s390x [0], because of using kfunc, and
> > on s390x, "JIT does not support calling kernel function". Is there
> > anything I can do about it
> >
>
> You can add it to the deny list, like this patch:
> https://lore.kernel.org/bpf/20220824163906.1186832-1-deso@posteo.net

Very cool! Thanks!
