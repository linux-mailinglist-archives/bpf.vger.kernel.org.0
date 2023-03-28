Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D756CCD13
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC1WU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1WUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:20:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1B30D5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:19:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t10so55595500edd.12
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL4GcqYYIvPt1Pi6ck7hlX2oFSHc5TZT9/OZ5kAArQo=;
        b=ZC6EC0DFE1hHUTV2LBaIFnK+dTTA9H/SYOdOb0dhH00vk7KbwRxBEbTfOOdBRB86Rg
         jg44S7degscRQn7Sr3Wx0ShbNoWLNgtyWVzLTr9J/rMgQ0cWTowD4bfEmQX06+cuuYTr
         HuVqdAQMIhsByAw/q1S4YbnR52GCVi0abm/WefRvQ/pX3odeyr4l8J7PPCwpfNHEHsUn
         ZaK2Ex2ZdabfxXoUFAPPmjleoMH3gRvtZCtys7cEv9WMJSFpV2zbljOiJsAo5MHnFGbU
         ASJUQ6Kq8/VVtikM1hs1wkVX107ltZ305Vjzbe+0lVumZUAQFAFUKuOIpWqYW77w9swX
         l64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL4GcqYYIvPt1Pi6ck7hlX2oFSHc5TZT9/OZ5kAArQo=;
        b=FvG/vzSgLv+SSkunCAU9yGr4xBQfglSPkNlLz9Z2/DgpPz1RbwU7DHvrStL1JQMY31
         ygsQyIu6Jw5e2vrfIMRWqoWiPoTvK/SlIZLg/m3zvmBA6/K6k3m4Gvl71qs5/5JeeH4H
         q30++la/ilyN1LXKjSVJQTEuVpaUc2+AgK0iI2dK4DydeZJNgWzBLzmdFkxyE+voGbD8
         EZRuEFBHLavxUrCDesJ48pBT2t9htK1silLYOi6ex8b2nkcZ3JHRaobRHfRiZfb+bvIs
         gu71oDGxqC9cVuDtJKYpdw4VFeFYzIl8FwHsJY6dIs0Enwl1IgFyQRHLZRWj5OpYEo1M
         0Q8g==
X-Gm-Message-State: AAQBX9epSbVFILCZKppeTjRTUy0OvoYnNpciSMswDMR/DxsZjxFacAL5
        Y0Lmb8B5VwDKI0eTIMaorldMlMvqzYMamXydkSVrig==
X-Google-Smtp-Source: AKy350Z4C/jI32HkAY9H/dgh0JWOOLFeqOZ+tvXMBkyhDXhXLrRjYAYqvUg43BMDuFvB7c8TpMkVsY1yKzKOXPlCFEo=
X-Received: by 2002:a50:d6d6:0:b0:4fb:9735:f915 with SMTP id
 l22-20020a50d6d6000000b004fb9735f915mr8284499edj.8.1680041945249; Tue, 28 Mar
 2023 15:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-5-yosryahmed@google.com> <ZCMojk50vjiK6mBe@cmpxchg.org>
 <CAJD7tkYA=0rKSmtQzYQpZ2DuUoJq0bQcVqPgSpVEs0M4zAktnw@mail.gmail.com>
In-Reply-To: <CAJD7tkYA=0rKSmtQzYQpZ2DuUoJq0bQcVqPgSpVEs0M4zAktnw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 15:18:28 -0700
Message-ID: <CAJD7tkbH8WQ8K-pQZVwnz9ZaJ=iHBE-LDnzpD7Dzd1zf_xMx4g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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

On Tue, Mar 28, 2023 at 11:59=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 28, 2023 at 10:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Tue, Mar 28, 2023 at 06:16:33AM +0000, Yosry Ahmed wrote:
> > > rstat flushing is too expensive to perform in irq context.
> > > The previous patch removed the only context that may invoke an rstat
> > > flush from irq context, add a WARN_ON_ONCE() to detect future
> > > violations, or those that we are not aware of.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  kernel/cgroup/rstat.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > > index d3252b0416b6..c2571939139f 100644
> > > --- a/kernel/cgroup/rstat.c
> > > +++ b/kernel/cgroup/rstat.c
> > > @@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgro=
up *cgrp, bool may_sleep)
> > >  {
> > >       int cpu;
> > >
> > > +     /* rstat flushing is too expensive for irq context */
> > > +     WARN_ON_ONCE(!in_task());
> > >       lockdep_assert_held(&cgroup_rstat_lock);
> >
> > This seems a bit arbitrary. Why is an irq caller forbidden, but an
> > irq-disabled, non-preemptible section caller is allowed? The latency
> > impact on the system would be the same, right?
>
> Thanks for taking a look.
>
> So in the first patch series the initial purpose was to make sure
> cgroup_rstat_lock was never acquired in an irq context, so that we can
> stop disabling irqs while holding it. Tejun disagreed with this
> approach though.
>
> We currently have one caller that calls flushing with irqs disabled
> (mem_cgroup_usage()) -- so we cannot forbid such callers (yet), but I
> thought we can at least forbid callers from irq context now (or catch
> those that we are not aware of), and then maybe forbid irqs_disabled()
> contexts as well we can get rid of that callsite.
>
> WDYT?

I added more context in the commit log in the v2 respin [1]. Let me
know if you want me to change something else, rephrase the comment, or
drop the patch entirely.

[1]https://lore.kernel.org/linux-mm/20230328221644.803272-5-yosryahmed@goog=
le.com/
