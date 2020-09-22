Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809FD273F8D
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIVKYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgIVKYs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 06:24:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB3C0613D1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 03:24:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so13660944ljo.5
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5wJkgiy/5FUVTvT1Ox6eVPIWc3NhBDnEL+aZwGUv7Y=;
        b=ZtgOaPqmXy1A+Gbcwyx2WDHIh7QWWMV6+7AyiGVfXG59CKMLwIW2QZN4PY2kq21Tza
         H/X+ct31ngIt+7wS3O7ROOUvcaUpup8Dbv+Ly1LggaWmUnBzAqLyYATz2WbmFpkmDrXm
         AMPTCfrdy03wZTWDdlin2/sp+zqfx0M6mqn28RqJ0HBH7rVGFbcCSyFQ++I3f+wfehPY
         52GRZKGV27KnUlbl9VCEdzjFVC8ApeVroVdRtAm9vN8YD9MQPMd1Vgii+dxp/L3CRb1K
         Z4w4OlZeGH4w6ZbCl6wnq9J76mbtLsbIyGD/DGC9SxxJFiYUYVf0zRrb09OdoNwYEM2e
         I+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5wJkgiy/5FUVTvT1Ox6eVPIWc3NhBDnEL+aZwGUv7Y=;
        b=B2u638Ssc18uKaNCNKqibPnPt7Zm0c9O37iBZJGnk1M07UGfrW/iZqSBWnuAFKH7N/
         Ua9qEcR/edSVmxDXHiiCJOO5Yl0eFRePmVQSUnZzAjTrXthoUl4n5nknKLfSKVXmKtaY
         N1bDbEYWa9XeC4+4gAyX8iMUgrmWJ7BwC16LLEvhony8uZwrWcZa/ar+CtKOQO275fz5
         Zm9DUZwB65AuGZ4PDMKJ6qwFvZ7jJ/qOSBQJEfoghvLkfIWaQbuJQigqWfGYeIasHNT/
         UnAaGUc9ayVtVsUA9yneuG9OESrTcIq9T3Bt0eVcNEGpfiYYLiQ5YMY1r9A+fb7IAndC
         veZw==
X-Gm-Message-State: AOAM530ib9cerwaZ3j5ztqQq+3YiwrZh8SGtGzEm5WokJNO2kHIMzyQ3
        KHmL0TOj/qXtPS+m5vKMJPFDx/9bdXh7+NEhYdC4bQ==
X-Google-Smtp-Source: ABdhPJxXgZA7Wz+QbkdSrznteFqsjG1l1yak8212eYOgy3YfDUn51qAkpOY4//6idh0NbD3pHLC0kbbYv+E8XlP7zWI=
X-Received: by 2002:a05:651c:1203:: with SMTP id i3mr1217853lja.382.1600770286046;
 Tue, 22 Sep 2020 03:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz> <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz> <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
 <20200922095136.GA9682@chrisdown.name>
In-Reply-To: <20200922095136.GA9682@chrisdown.name>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Tue, 22 Sep 2020 18:24:35 +0800
Message-ID: <CAKRVAePisoOg8QBz11gPqzEoUdwPiJ-9Z9MyFE2LHzR-r+PseQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memcontrol: Add the drop_cache
 interface for cgroup v2
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 22, 2020 at 5:51 PM Chris Down <chris@chrisdown.name> wrote:
>
> Chunxin Zang writes:
> >My usecase is that there are two types of services in one server. They
> >have difference
> >priorities. Type_A has the highest priority, we need to ensure it's
> >schedule latency=E3=80=81I/O
> >latency=E3=80=81memory enough. Type_B has the lowest priority, we expect=
 it
> >will not affect
> >Type_A when executed.
> >So Type_A could use memory without any limit. Type_B could use memory
> >only when the
> >memory is absolutely sufficient. But we cannot estimate how much
> >memory Type_B should
> >use. Because everything is dynamic. So we can't set Type_B's memory.high=
.
> >
> >So we want to release the memory of Type_B when global memory is
> >insufficient in order
> >to ensure the quality of service of Type_A . In the past, we used the
> >'force_empty' interface
> >of cgroup v1.
>
> This sounds like a perfect use case for memory.low on Type_A, and it's pr=
etty
> much exactly what we invented it for. What's the problem with that?

But we cannot estimate how much memory Type_A uses at least.
For example:
total memory: 100G
At the beginning, Type_A was in an idle state, and it only used 10G of memo=
ry.
The load is very low. We want to run Type_B to avoid wasting machine resour=
ces.
When Type_B runs for a while, it used 80G of memory.
At this time Type_A is busy, it needs more memory.

Usually we will reclaim the memory of B first for Type_A . If not
enough, we will
kill Type_B.
