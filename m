Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289B45744FC
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiGNGQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 02:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiGNGQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 02:16:09 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE727CDD
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:16:08 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id m30so382332vkl.4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApEAtFZKw7vtTgl34dbe4a4f89XqU7dSoPUlyv5Fslk=;
        b=CNJb6LoaV77iVBZrOw2IbIS7nvxzEEsBfPPMrHDezQiGUIdXYc9mbbjfTW/VKmbCnb
         jjor7Krgh4QqKfBjW13VXMrQItbJ+CHc7T0Iytfifn2GTmNCsHF3csW8a4I549U3hTVY
         e9f3+r5bY9JxRx99t6bgEMEmczFZGI8df2pmMkj+bJsHZJs//Jdc0F+VttSSAzUpkOsG
         uewT1htMqrpCgCp42uIuhjTRkWvD1Zlbmqv9nHRFdXOmLvySAZP4ztfpb8mkQGmUGN3h
         Lj0W1zZGWsAWHM4EsExg0fbT8qH2g2OGcPdnWbZTd3E5Jcsxs8c1tGMKf2SpspZ28G0o
         xS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApEAtFZKw7vtTgl34dbe4a4f89XqU7dSoPUlyv5Fslk=;
        b=TOVKTy/upnV2YwfscHUjMUJJeYPKcygL/Jh2oVEn2FXQmbKLJ6rOAQX7PrROlJU8yM
         1PpQ1WQT4dbccE8LuJ4fy77MQNt9Teu4U8n0/lL/M7RLrNJEnxUtJLW9oyxuvdtQWFXS
         K4idAIns1BfyI75UBiXBCgeRXcvZtWTdVfCi8QUO75aqajGupsrzk9uKUiKEG/gqsjcw
         iOg/gM1ZgHoqtkTinI4mBCjJGurg7DtJPa/iVueucIJB4a/AImcMDP0RqJK1T9g83Z3o
         L8Vf4Vu9cfyx55GmdEMyW6OHSJdFAvKSVcjF+hghX7EXEMQAZMToGzalk8o202RHtobJ
         2LSA==
X-Gm-Message-State: AJIora+IMAQOxYr56HJSTmg1j/4OW8/7AQ0L36/EHqLQeXE2mLKEnx6+
        17X586ZXg61kx6vmg/a4xd2KJWtrwfVRspk/1kc=
X-Google-Smtp-Source: AGRyM1uTgYeeLjMSMaYITBIIxcEEHNXIlGdLvNBKEUO7NBCyJ+2CQVZLeTq809TH5t9MT8oa8l5+OIr0yi8pnQLS7f0=
X-Received: by 2002:a1f:2d4c:0:b0:374:3037:8082 with SMTP id
 t73-20020a1f2d4c000000b0037430378082mr2827432vkt.5.1657779367049; Wed, 13 Jul
 2022 23:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CALOAHbAyZBKRn3HpjeKsxpTP8aKnHxFiMD_kGJG22c0X8Cb9+w@mail.gmail.com> <Ys7xz8auWmD814tz@slm.duckdns.org>
In-Reply-To: <Ys7xz8auWmD814tz@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Jul 2022 14:15:30 +0800
Message-ID: <CALOAHbA40c5mjgD=0n4c-h5iUBvz--95-p=Zz8MRret5ihoH9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 12:24 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jul 13, 2022 at 10:24:05PM +0800, Yafang Shao wrote:
> > I have told you that it is not reasonable to refuse a containerized
> > process to pin bpf programs, but if you are not familiar with k8s, it
> > is not easy to explain clearly why it is a trouble for deployment.
> > But I can try to explain to you from a *systemd user's* perspective.
>
> The way systemd currently sets up cgroup hierarchy doesn't work for
> persistent per-service resource tracking. It needs to introduce an extra
> layer for that which woudl be a significant change for systemd too.
>
> > I assume the above hierarchy is what you expect.
> > But you know, in the k8s environment, everything is pod-based, that
> > means if we use the above hierarchy in the k8s environment, the k8s's
> > limiting, monitoring, debugging must be changed consequently.  That
> > means it may be a fullstack change in k8s, a great refactor.
> >
> > So below hierarchy is a reasonable solution,
> >                                           bpf-memcg
> >                                                 |
> >   bpf-foo pod                    bpf-foo-memcg     (limited)
> >        /          \                                /
> > (charge)     (not-charged)      (charged)
> > proc-foo                     bpf-foo
> >
> > And then keep the bpf-memgs persistent.
>
> It looks like you draw the diagram with variable width font and it's
> difficult to tell what you're trying to say.

Maybe below diagram is more clear to you ?
                                          bpf-memcg
                                                |
  bpf-foo pod                    bpf-foo-memcg     (limited)
       /          \                                /
(charge)     (not-charged)      (charged)
   |                         \                /
   |                          \              /
proc-foo                   bpf-foo

bpf-foo is loaded by process-foo, but it is not charge to the bpf-foo
pod, while it is remotely charge to bpf-foo-memcg.

>  That said, I don't think the
> argument you're making is a good one in general. The topic at hand is future
> architectural direction in handling shared resources, which was never well
> supported before. ie. We're not talking about breaking existing behaviors.
>
> We don't want to architect kernel features to suit the expectations of one
> particular application. It has to be longer term than that and it can't be
> an one way road. Sometimes the kernel adapts to existing applications
> because the expectations make sense. At other times, kernel takes a
> direction which may require some work from applications to use new
> capabilities because that makes more sense in the long term.
>

The shared resources or remote charge is not a new issue, see also
task->active_memcg. The case (map->memcg or map->objcg) we are
handling now is similar with task->active_memcg. If we want to make it
generic, I think we can start with task->active_memcg.

To make it generic, I have some superficial thinking on the cgroup side.
1) Can we extend the cgroup tree to cgroup graph ?
2) Can we extend the cgroup from process-based (cgroup.procs) to
resource-based (cgroup.resources) ?

Regarding question 1).
Originally the charge direction is vertical,  looks like a tree, as below,
      parent
         ^
          |
       cgroup

But after the task->active_memcg, there's a newly horizontal charge, as below,
      parent
         ^
          |
       cgroup  ---->  friend

They will have a same ancestor, so finally it looks like a graph,
              ancestor
              /             \
           ...               ...
           /                  \
       cgroup  ----  friend


Regarding question 2).
The lifecycle of a leaf cgroup is same with the processes inside it.
But after the remote charge been introduced, the lifecycle of a leaf
cgroup may be same with the process in other cgroups. That said, it is
not sufficient to be treated as process-based, because what it really
care about is the resources, so may be we should extend it to
resource-based.

> Let's keep the discussion more focused on technical merits.
>
> Thanks.
>
> --
> tejun



-- 
Regards
Yafang
