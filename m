Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B603C9AD2
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhGOIsL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOIsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 04:48:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEFC06175F;
        Thu, 15 Jul 2021 01:45:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id gh6so2452938qvb.3;
        Thu, 15 Jul 2021 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGtthBPDKh9JZVcjAhT7jQp0Mz38vxl7SuIjFvZmI7M=;
        b=XmwJpTnpFg82Sg8RoZYs+We1av5pGWVB0k0fB92abqpAFOsc5n+qiRIXLGGHLE3mUw
         IJWCVaH0qKTNYIkAgOD5VyyXLxWN58JaCx45zS5b/ZZRKyd9yH8QuarV5+UuUnhyRlgc
         NswcWxwb0eusBDw90mkWtIGzjUWLZ0TLwNA2E290Q6XCEpzw7FzFq7nvv9kchdMX060z
         rpl0t42a83tx3OHTFKDWZoeUmWsiib6V07Jwg+gmLIEBWkr5VxJD9ZQyyOigBj87miIL
         TobjIJ1ZA6fcezkLiTuccHrkvDIXhDO5EbmQ1bAmdvKf47H0qP9pU6dGhjYH30NrSwpg
         cK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGtthBPDKh9JZVcjAhT7jQp0Mz38vxl7SuIjFvZmI7M=;
        b=ZJKg7fJMv9srV7SNJiIz0Te0MWIfYkWWYDgymtY/TPtnzeA4bvT+Bt2w//CwTmOw7M
         jPvp/aLQ5WomrYQkVeTeB6K6noQ/xk034viX+KSxFWOvz9X8fnglmKvnIlQFtxK8rsMy
         s1skOb9oME8YnrPGrUYVbdXHThXOwf3OnlqcMn90VwYeL+q938UG98TavfGxM9jfgXTL
         tU1EMCBMiUWEOCcXssrb/kDahSNtw9U7hqsIPAlUsGe0J3MkfV3sItS3dMEOztTkVig5
         CVdkwMJCKnCZ3abj60PeSYtbXg6dxdG/xfs0jDvJjdSdcMiPMbdfSIFLGLE1h+90N/Gr
         aOnQ==
X-Gm-Message-State: AOAM5327r2faXxzx1j4eTQlQsDJhEICi5nXY+eHiFYqqY6ENEeEr3u5p
        pj5n2mo9VhcVXLbRI9pVAqn6qot5b23ugCua63I=
X-Google-Smtp-Source: ABdhPJwIrwhFdK0QYPqiBC0hUitVC7dYvLIbqLb8bjBSUxG6pRP4XXINjAXbq2jZHJN3BjraS14DVyBzfoYAB3b9mHs=
X-Received: by 2002:a0c:9ac7:: with SMTP id k7mr3060442qvf.49.1626338716448;
 Thu, 15 Jul 2021 01:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210713005645.8565-1-zhouzhouyi@gmail.com> <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1> <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com> <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 15 Jul 2021 16:45:04 +0800
Message-ID: <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
To:     paulmck@kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, apw@canonical.com,
        joe@perches.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 11:51 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jul 14, 2021 at 12:44:36PM +0800, Zhouyi Zhou wrote:
> > On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > > > >
> > > > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > >>
> > > > > >> Hi Paul,
> > > > > >>
> > > > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > > > >>
> > > > > >> Without memory fencing, the idle/userspace task inspection may not
> > > > > >> be so accurate.
> > > > > >>
> > > > > >> Thanks for your constant encouragement for my studying.
> > > > > >>
> > > > > >> Best Wishes
> > > > > >> Zhouyi
> > > > > >>
> > > > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > >
> > > > > > Good eyes, and those could cause real bugs, so thank you!
> > > > >
> > > > > Hi Paul,
> > > > >
> > > > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > > > catch those issues with testing before they reach mainline ?
> > > >
> > > > My guess:  Running on weakly ordered architectures.  ;-)
> > >
> > > And another guess:  A tool that identifies use of Kconfig options
> > > that are not defined in any Kconfig* file.
> > Based on Paul's second guess ;-),  I did a small research, and I think
> > the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
> > to identify use of Kconfig options that are not defined in any Kconfig* file.
> >
> > As I am a C/C++ programmer, I would be glad to take some time to learn
> > perl (checkpatch is implented in perl) first if no other volunteer is
> > about to do it ;-)
>
> I haven't heard anyone else volunteer.  ;-)
>
> Others might have opinions on where best to implement these checks,
> but I must confess that I have not given it much thought.
I recklessly cc the maintainers of checkpatch.pl without your
permission to see others' opion,
and I begin to study perl at the same time, after all, learning
something is always good ;-)
>
>                                                         Thanx, Paul
Best Wishes
Zhouyi
