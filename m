Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6333CC690
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGQWGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhGQWGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 18:06:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A4C061762;
        Sat, 17 Jul 2021 15:03:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nd37so21041239ejc.3;
        Sat, 17 Jul 2021 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWdaGFPzrQtxwDMoSrykP9DB3UY/nGQkXWNBfMY4IEw=;
        b=JAA1cgbQ81iA7FqwA27Ls0FDhBGKSFgIHMIPnhstTzhyDO0nRgbG5GwtAfFLymfgJ8
         k7PcyANNT5qRv7nz/MwnMatiwlVBmhHkx3ZBm93x4/QnKKrfJAyH/Vzo66dntgiYiRfF
         wskDs0IQvzxv/BFcqPD7mIAK1StJkcVWuiIUKQ0ZlePCntQlGYs1iREiBz890zt0dS5M
         xQo2kJ3pLpHxU+WjcxWZ3/hSAWlMdx8iHv8OhcaBzQw0C2p1UXGNRK5V8R2/Wam/AS3b
         q/gytkrXBv1MLrajKTCbZKmB2q5dlGWgqlBRe3bAxptPG5bnE6fjqj2zMGzedbTQOLyb
         /RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWdaGFPzrQtxwDMoSrykP9DB3UY/nGQkXWNBfMY4IEw=;
        b=ZIUHObc4unVMPYCj++Cj3Q531fvTcgnGVrS9DMRKwpe/P1sXIb2a01Y8IkyXVLMxiA
         +sXOHBF+jiL4DJeKHjU65xtwTrsyu28VyrcidoUtHbFXmXyiCty6zoTtvdCr04N/Qp5G
         AqFYE7fEXmIRZoMkODQnO0YeAlLIGQYqEnsv/Gfmjj3U8pt6B00C0CZ6+KUUqkWMMjD/
         W5xyzPPHuVvNrEi4sssVU9fzehilYm0wxpWZuXuBylPlT8kFE1XZjqLi6y+4sfEYHJb8
         VK2sSthpEs6TPQ93ktQIrkv7rnME8Q346J2PXbpI0TWswQ+kMgWfhGUjZMwBggODSKbC
         gxnQ==
X-Gm-Message-State: AOAM530ZlRcOsNG5yQkeas8fhXXDMIRV/EHNbTWis2Rq1H3Jc+YfJkwc
        jUUU8mKKZccwDC/QtcsNdAQTDgcnpAaVulwAaQw=
X-Google-Smtp-Source: ABdhPJx/bVG/+f5cDTG05pqgwjT03uO1ugT+RxTJWMohEj0lWYMRyNe7JoX+RDdelc3oMjl53YYOLyE9X6VklhSWw4c=
X-Received: by 2002:a17:907:7203:: with SMTP id dr3mr19141903ejc.52.1626559426168;
 Sat, 17 Jul 2021 15:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210713005645.8565-1-zhouzhouyi@gmail.com> <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1> <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
 <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1> <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
 <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 18 Jul 2021 06:03:34 +0800
Message-ID: <CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com>
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
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Paul
During the research, I found a already existing tool to detect
undefined Kconfig macro:
scripts/checkkconfigsymbols.py. It is marvellous!

By invoking ./scripts/checkkconfigsymbols.py > /tmp/log, I found
following possibly undefined Kconfig macros
which may need our attention:

PREEMPT_LOCK
Referencing files: include/linux/lockdep_types.h

PREEMT_DYNAMIC
Referencing files: kernel/entry/common.c

TREE_PREEMPT_RCU
Referencing files: arch/sh/configs/sdk7786_defconfig

RCU_CPU_STALL_INFO
Referencing files: arch/xtensa/configs/nommu_kc705_defconfig

RCU_NOCB_CPU_ALL
Referencing files:
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst

RCU_TORTURE_TESTS
Referencing files: kernel/rcu/rcutorture.c

and finally the macro which drive me to do this research

TASKS_RCU_TRACE
Referencing files: include/linux/rcupdate.h, kernel/rcu/tree_plugin.h

On Fri, Jul 16, 2021 at 2:09 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jul 15, 2021 at 04:45:04PM +0800, Zhouyi Zhou wrote:
> > On Thu, Jul 15, 2021 at 11:51 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Jul 14, 2021 at 12:44:36PM +0800, Zhouyi Zhou wrote:
> > > > On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > > > > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > > > > > >
> > > > > > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > > >>
> > > > > > > >> Hi Paul,
> > > > > > > >>
> > > > > > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > > > > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > > > > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > > > > > >>
> > > > > > > >> Without memory fencing, the idle/userspace task inspection may not
> > > > > > > >> be so accurate.
> > > > > > > >>
> > > > > > > >> Thanks for your constant encouragement for my studying.
> > > > > > > >>
> > > > > > > >> Best Wishes
> > > > > > > >> Zhouyi
> > > > > > > >>
> > > > > > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > > >
> > > > > > > > Good eyes, and those could cause real bugs, so thank you!
> > > > > > >
> > > > > > > Hi Paul,
> > > > > > >
> > > > > > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > > > > > catch those issues with testing before they reach mainline ?
> > > > > >
> > > > > > My guess:  Running on weakly ordered architectures.  ;-)
> > > > >
> > > > > And another guess:  A tool that identifies use of Kconfig options
> > > > > that are not defined in any Kconfig* file.
> > > > Based on Paul's second guess ;-),  I did a small research, and I think
> > > > the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
> > > > to identify use of Kconfig options that are not defined in any Kconfig* file.
> > > >
> > > > As I am a C/C++ programmer, I would be glad to take some time to learn
> > > > perl (checkpatch is implented in perl) first if no other volunteer is
> > > > about to do it ;-)
> > >
> > > I haven't heard anyone else volunteer.  ;-)
> > >
> > > Others might have opinions on where best to implement these checks,
> > > but I must confess that I have not given it much thought.
> > I recklessly cc the maintainers of checkpatch.pl without your
> > permission to see others' opion,
> > and I begin to study perl at the same time, after all, learning
> > something is always good ;-)
>
> Works for me!
>
>                                                         Thanx, Paul
Best Wishes
Zhouyi
