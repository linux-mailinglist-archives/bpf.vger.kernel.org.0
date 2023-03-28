Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5B6CCA51
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjC1Sxa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC1Sx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 14:53:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53FA213B
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:53:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so53701700ede.8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680029606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Knz0ICKyVQWqTN98QRlsl94SOUBbAgJSfpknOWcWIz8=;
        b=eBFPS5upevzYowGb39P08hDPA5ByzP8CKwYQMFgOKj+6IYq2Vkfhm5oL5cVrbZhHzf
         eQHkB8C313lW8nsV9BpZNUZGGFqiswJwY5FMsPU6z/cd/O9XwAIDMFqeGPfx35miDyrF
         +bGkozLip971EeAk9h6UC0HOXtdfFwRiZJkEUoXuLJ3fBqgLl1/lbS6hfhsmfL9XRhH+
         KR9XbqwM57zERf5JS531f6qDu8XI49Nmmt2jHNhErVh4imKzomY5+lfULAhHKaJb3jM2
         Rye/OtfKqLqEEIMO08YuFZgxXxl9NZRbCLkFj6dKWKMGFVVM0dFa3ui8jA4/djrvfILk
         dA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Knz0ICKyVQWqTN98QRlsl94SOUBbAgJSfpknOWcWIz8=;
        b=oC3WHfWk1fzD2+hyY297RJuCdhJYL5xd360IUcnZ8RdoAZziLqVySMuhrZTtEn7itS
         2AsEjlId5P2eFNAKpZvJ9q2A0T8ma7Bew3iFrOIC1xf8uNOyBdXjckq5QA/W340W/4N9
         vgEWiqAsWF+jlwjLpPo18MlxY6i+c65lSyZRipVsqvm7Vc40xsRwNh0ceiAR2XREUxf8
         +dZnA5+6qSlU4yDau5PUyZ+qmIYSAgESr+UDqd+WCf2fa6oZjZYkhs8EkV9KN3SQBhul
         09JE91KU/Es0qe6rq4/9wuuUd20B7VdaQlscylHS5FWO9+4psEY3CqviII0OZxYELw4A
         5FoA==
X-Gm-Message-State: AAQBX9fVe6K6f1oIV/6VG1VH/hVbFAX6fZNxOVOCdkXN68zfMMdv6kQP
        ApiJys3e1coxyWahA+H9tF2IFNEtlYXBBlnzSjFGQw==
X-Google-Smtp-Source: AKy350Z3M7QR34ahCbawZrKpU+fclV+7eeIoXTqQ34bVv12otunyd4ooJvbGExuWfU2TzFjs2F14JyzAfPoOyuqb8SA=
X-Received: by 2002:a17:907:9870:b0:8b1:28f6:8ab3 with SMTP id
 ko16-20020a170907987000b008b128f68ab3mr8771567ejc.15.1680029606204; Tue, 28
 Mar 2023 11:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com> <20230328141523.txyhl7wt7wtvssea@google.com>
In-Reply-To: <20230328141523.txyhl7wt7wtvssea@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 11:52:50 -0700
Message-ID: <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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

On Tue, Mar 28, 2023 at 7:15=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Tue, Mar 28, 2023 at 06:16:34AM +0000, Yosry Ahmed wrote:
> [...]
> > @@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
> >   */
> >  static void flush_memcg_stats_dwork(struct work_struct *w);
> >  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dw=
ork);
> > -static DEFINE_SPINLOCK(stats_flush_lock);
> >  static DEFINE_PER_CPU(unsigned int, stats_updates);
> > +static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
> >  static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
> >  static u64 flush_next_time;
> >
> > @@ -636,15 +636,18 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > -     unsigned long flag;
> > -
> > -     if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > +     /*
> > +      * We always flush the entire tree, so concurrent flushers can ju=
st
> > +      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > +      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      */
> > +     if (atomic_xchg(&stats_flush_ongoing, 1))
>
> Have you profiled this? I wonder if we should replace the above with
>
>         if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_flush=
_ongoing, 1))

I profiled the entire series with perf and I haven't noticed a notable
difference between before and after the patch series -- but maybe some
specific access patterns cause a regression, not sure.

Does an atomic_cmpxchg() satisfy the same purpose? it's easier to read
/ more concise I guess.

Something like

    if (atomic_cmpxchg(&stats_flush_ongoing, 0, 1))

WDYT?




>
> to not always dirty the cacheline. This would not be an issue if there
> is no cacheline sharing but I suspect percpu stats_updates is sharing
> the cacheline with it and may cause false sharing with the parallel stat
> updaters (updaters only need to read the base percpu pointer).
>
> Other than that the patch looks good.
