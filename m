Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547D6C8AF6
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 05:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCYEqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCYEqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 00:46:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF117CD7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:46:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p15so4613653ybl.9
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679719577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aev6aZrFaneoIiT/5tO9n5SSh+Wv4Vl/zFxv2Nlcyh0=;
        b=jN2jTtgXG0MrqNXQHFKmsc791+de108Oh0Rhy1JgtjGoPG4Hj5J7eUVxCplL/0D7fL
         w8DGJQ33Zi5JSMExvCHrjTVMdaBX7d9GQzf3sh4ZraMPUlu6+NC5KSEf8XeOa5xRIjhJ
         hYE3O49f9xjjCx0uDYS77v95m03lU8he8bktQo8exbPFh8JntTp7XxH7+pxNleBSTUpV
         rzuW18l8MU2WF/D+z+glfnWAPNxInVBOC3pY0fpfODA8RkDXbBdPIw6M6eLRlxzcDyJj
         br31rqbMmHpBn3kWbKf4bjMoluldCcJAWs3ys6pKgCwDrUJSLBvdwk8wZJz5STfGKyxt
         opdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679719577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aev6aZrFaneoIiT/5tO9n5SSh+Wv4Vl/zFxv2Nlcyh0=;
        b=1FuriQ9RwBlghZETs+c4hwBlQXS0RlqHFxDBr1LRMLDUzlF8ktbnyJVFWvrg2Cu4oC
         lVLNiVmR2BVQAfZClhZOdm5F8D7R3rWmWljiURzK7lhLlUgAFSFnqKyOHUL9T2jcG1lw
         NmMpYcmiK1p0zKfiCFHRgxbAl8rAy30L3c5+8kp1Jg/eHM5Yg5pDnIpRsSXK8PJ3+5Hl
         4k2utZafo83pqv/vMiJwDVXiJ1+gloIFyBjqGcp9tpfA6wojEu7wO7dSIU+fA6MPQpTa
         7sDts7oZFzUwNzOSzlz7qaz2NklxQpQxIKxBOhd+bvR56/u5oh7rK1NgS9PdVtK1m7bS
         u91Q==
X-Gm-Message-State: AAQBX9er9atV6tjb9XV4jrTvE57xBo1t4Yfakj+kXIX/6Byg/4BPy9j0
        KA7wcGIv6l051bH1vwv/eP7BeqsqPyjGZdSQB6EvxA==
X-Google-Smtp-Source: AKy350Yt0pCFGWtHoQ3DVNQUt0XzkNrgeeZ+uhqRK5ArUARnbotr/g1RQRnJk3yXETMnUhHFOHup0KR6oRPuSva8c3M=
X-Received: by 2002:a05:6902:a93:b0:b78:5f10:672a with SMTP id
 cd19-20020a0569020a9300b00b785f10672amr1584792ybb.12.1679719577172; Fri, 24
 Mar 2023 21:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com> <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 Mar 2023 21:46:05 -0700
Message-ID: <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 9:37=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Mar 24, 2023 at 9:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > [...]
> > > Any ideas here are welcome!
> > >
> >
> > Let's move forward. It seems like we are not going to reach an
> > agreement on making cgroup_rstat_lock a non-irq lock. However there is
> > agreement on the memcg code of not flushing in irq context and the
> > cleanup Johannes has requested. Let's proceed with those for now. We
> > can come back to cgroup_rstat_lock later if we still see issues in
> > production.
>
> Even if we do not flush from irq context, we still flush from atomic
> contexts that will currently hold the lock with irqs disabled
> throughout the entire flush sequence. A primary purpose of this reason
> is to avoid that.
>
> We can either:
> (a) Proceed with the following approach of making cgroup_rstat_lock a
> non-irq lock.
> (b) Proceed with Tejun's suggestion of always releasing and
> reacquiring the lock at CPU boundaries, even for atomic flushes (if
> the spinlock needs a break ofc).
> (c) Something else.

(d) keep the status quo regarding cgroup_rstat_lock
(e) decouple the discussion of cgroup_rstat_lock from the agreed
improvements. Send the patches for the agreed ones and continue
discussing cgroup_rstat_lock.
