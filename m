Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD3513EBE
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353054AbiD1W4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbiD1W4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 18:56:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F06F32EDB
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 15:53:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bg9so5121970pgb.9
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEhxn+r4Tyw/AYiro7RtH6+EpSxm2xMIisnR54D0ons=;
        b=YEpp9f9cH5/ItnOSoy6mGeHr8Lpd9iz8muap3LCWLhJ9el0Iz4qNda3V1YRLESbOsy
         gnmoH4uY9FeP5ATGSnhkpTuo+oo660iHYQU8sCJh2Wodf+M8bh7zv4tzp9yun5rdhXDB
         vhi7DqkNsuj0SkMfPz62G2esJxGXS+8OfLD3oCdKBV0saoy0URmIIsuF5vr6oQie1fin
         c7xo+yN3Av7C1+kgZLCbRY7UxPv9E8EOrKk7a+ZjjfdGd1BOkkTA7tuJlSR9bKnAxsn7
         pUevT25GQ3a5Zcf+IEAdv4dRL+mYCL4WQvYwG6+xAA8Z8zM/bi3UTMDmpjqC2tRHI7cr
         B9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEhxn+r4Tyw/AYiro7RtH6+EpSxm2xMIisnR54D0ons=;
        b=wnnYvU8o8J6gy0TX94J1AB0I6vBzMyYAku/jZHON2gKCxem9YZnTgB4IALhc6oc73X
         QJIAMXLVWhEfNEZruQb3Tjv+9mweancDqzbv1PLsowaP+cn3gIravausFrio2/NoGH/j
         toC5X1KypdfhUCaqf093of5Cq1ao1VTtiwt4G0l1mqHAms13Dlf+EUCh/DIJR0D+MzKX
         LBiAhmnvgVKxkeeAXl9wZCC7hO3frAG1qqDuYmLHD0NewdF/Mc2ulEvnnRcpEyDFC2vx
         4uL74R5fdC0EFEwYn7z0+1kQZmr3UGu/e8XES62wd1lOvqtXNM35nEAYtD66Yg9N1Q2f
         Eg+Q==
X-Gm-Message-State: AOAM533BzEdf3N2C3hZaZrNaaf8C53AZ9yi8jGvw1Dw7aFp0f1/6tgKb
        oUJMqHMY5q26r2+F8yQ+1ZijjScpzDrsmBFztdM=
X-Google-Smtp-Source: ABdhPJxNpx2a1UXo4M+Jfof7SAeGgwofJzOXQFNhS731lKjz8wwo+XZSY4YxLRybT+6usilf8oc0nrf8M7mODKcKotM=
X-Received: by 2002:a05:6a00:8c8:b0:4fe:ecb:9b8f with SMTP id
 s8-20020a056a0008c800b004fe0ecb9b8fmr37063623pfu.55.1651186387840; Thu, 28
 Apr 2022 15:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
 <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
 <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com> <CAADnVQ+9axVKfyx-cCJW1NsVTcEp8BEUoAsXYiegEOsG3jmEww@mail.gmail.com>
 <cfa1255715f0fb86d699d54300b36083a68d66a5.camel@fb.com>
In-Reply-To: <cfa1255715f0fb86d699d54300b36083a68d66a5.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Apr 2022 15:52:56 -0700
Message-ID: <CAADnVQJqjazuUDj5Ko8ctaT1Nc-fXKriWGvzMscOfDp=5MQvcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 2:35 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Thu, 2022-04-28 at 13:58 -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 28, 2022 at 12:15 PM Delyan Kratunov <delyank@fb.com> wrote:
> > >
> > > On Thu, 2022-04-28 at 11:19 -0700, Andrii Nakryiko wrote:
> > > > On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
> > > > >
> > > > > uprobes work by raising a trap, setting a task flag from within the
> > > > > interrupt handler, and processing the actual work for the uprobe on the
> > > > > way back to userspace. As a result, uprobe handlers already execute in a
> > > > > user context. The primary obstacle to sleepable bpf uprobe programs is
> > > > > therefore on the bpf side.
> > > > >
> > > > > Namely, the bpf_prog_array attached to the uprobe is protected by normal
> > > > > rcu and runs with disabled preemption. In order for uprobe bpf programs
> > > > > to become actually sleepable, we need it to be protected by the tasks_trace
> > > > > rcu flavor instead (and kfree() called after a corresponding grace period).
> > > > >
> > > > > One way to achieve this is by tracking an array-has-contained-sleepable-prog
> > > > > flag in bpf_prog_array and switching rcu flavors based on it. However, this
> > > > > is deemed somewhat unwieldly and the rcu flavor transition would be hard
> > > > > to reason about.
> > > > >
> > > > > Instead, based on Alexei's proposal, we change the free path for
> > > > > bpf_prog_array to chain a tasks_trace and normal grace periods
> > > > > one after the other. Users who iterate under tasks_trace read section would
> > > > > be safe, as would users who iterate under normal read sections (from
> > > > > non-sleepable locations). The downside is that we take the tasks_trace latency
> > > > > unconditionally but that's deemed acceptable under expected workloads.
> > > >
> > > > One example where this actually can become a problem is cgroup BPF
> > > > programs. There you can make single attachment to root cgroup, but it
> > > > will create one "effective" prog_array for each descendant (and will
> > > > keep destroying and creating them as child cgroups are created). So
> > > > there is this invisible multiplier which we can't really control.
> > > >
> > > > So paying the (however small, but) price of call_rcu_tasks_trace() in
> > > > bpf_prog_array_free() which is used for purely non-sleepable cases
> > > > seems unfortunate. But I think an alternative to tracking this "has
> > > > sleepable" bit on a per bpf_prog_array case is to have
> > > > bpf_prog_array_free_sleepable() implementation independent of
> > > > bpf_prog_array_free() itself and call that sleepable variant from
> > > > uprobe detach handler, limiting the impact to things that actually
> > > > might be running as sleepable and which most likely won't churn
> > > > through a huge amount of arrays. WDYT?
> > >
> > > Honestly, I don't like the idea of having two different APIs, where if you use the
> > > wrong one, the program would only fail in rare and undebuggable circumstances.
> > >
> > > If we need specialization (and I'm not convinced we do - what's the rate of cgroup
> > > creation that we can sustain?), we should track that in the bpf_prog_array itself. We
> > > can have the allocation path set a flag and branch on it in free() to determine the
> > > necessary grace periods.
> >
> > I think what Andrii is proposing is to leave bpf_prog_array_free() as-is
> > and introduce new bpf_prog_array_free_sleepable() (the way it is in
> > this patch) and call it from 2 places in kernel/trace/bpf_trace.c only.
> > This way cgroup won't be affected.
> >
> > The rcu_trace protection here applies to prog_array itself.
> > Normal progs are still rcu, sleepable progs are rcu_trace.
> > Regardless whether they're called via trampoline or this new prog_array.
>
> Right, I understand the proposal. My objection is that if tomorrow someone mistakenly
> keeps using bpf_prog_array_free when they actually need
> bpf_prog_array_free_sleepable, the resulting bug is really difficult to find and
> reason about. I can make it correct in this patch series but *keeping* things correct
> going forward will be harder when there's two free variants.

This kind of mistakes code reviews are supposed to catch.

> Instead, we can have a ARRAY_USE_TRACE_RCU flag which automatically chains the grace
> periods inside bpf_prog_array_free. That way we eliminate potential future confusion
> and instead of introducing subtle rcu bugs, at worst you can incur a performance
> penalty by using the flag where you don't need it. If we spend the time to one-way
> flip the flag only when you actually insert a sleepable program into the array, even
> that penalty is eliminated.

Are you suggesting to add such flag automatically when
sleepable bpf progs are added to prog_array?
That would not be correct.
Presence of sleepable progs has nothing to do with prog_array itself.
The bpf_prog_array_free[_sleepable]() frees that array.
Not the progs inside it.

If you mean adding this flag when prog_array is allocated
for uprobe attachment then I don't see how it helps code reviews.
Nothing automatic here. It's one place and single purpose flag.
Instead of dynamically checking it in free.
We can directly call the correct function.
