Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA72513CF5
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbiD1VCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiD1VCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:02:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E52C0E6A
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 13:58:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q12so4912576pgj.13
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcDw49WosdCFt/j5dL2rvi5/hXbeyY8x6D3im0pkIIQ=;
        b=n1uDg9TZiZZv8f6J1e8JhhDisT73VU7KnfYnlaMiW7WDlhJyUlgdMZUVcQ9OHzbKNj
         QeJCXLWBavccyICwdlkHo5s4iTXT2gJHJq8iiMIIwELt20l/gMlxURGE+7kIOo+VAMzk
         2rteuy8mjuSOPxKjES3TD6xgn8NLF4mq4xxK/Anz50SfVnq7fuxu0/dn5cYRF+BHKG58
         raH3KCPAItm2aYoNcBbvMK5x/bOlGZvRZxMkN50n8uZqEWzm7kuYacf6xWJ1TMCE2gZL
         /opqTbf5SEl2MPCsUK0pnbx6WMkmIcM46w4K2NHM7mlhsJmVTBez9J8IeIwLKg2w9bA/
         7WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcDw49WosdCFt/j5dL2rvi5/hXbeyY8x6D3im0pkIIQ=;
        b=drznCTm805El0bJ9JVXBiw3Qq06/SW7KD2hqsEX9tivi3QseEFgxo1RNUTq+4W2eAt
         Ckqi+FYNTm2+o+P56sIvf3MmVu6o5txF3NEqjBtO0coGVLl4gakUOGBvTyB8KHk7psLt
         yMjRqD9w+yCRIm3OGFAgcfMXhGIYH7aWhWAYE9xu4R9Sg7U1fPvYf9kpqsh/IT63eKAr
         SW6ITzpqt/fH9Uohbsz8xQh0QCcbDW09i4Fvj5ypQTwRVMtJ2tsmD6EN6hp1LeUbp7eU
         kpx3SJf7Utw3jPtAKYPGzpt4a5VqVwbazvthKLH4scvskwjMTs57ncyZlDAraOG22TlG
         VMRg==
X-Gm-Message-State: AOAM532kV0Po8SKD0gKlKZLYtmbTxQwHjflWpLBU9VxgoKBD7Pah0tNr
        PkttkClZ7fuAKFGz9pVAwQiuUVvVd2VSg98K25c=
X-Google-Smtp-Source: ABdhPJylXrV9ad0ZlShzzTJC98MB9AlWoaZ0if4UcouY6yp2WIkzN5i5vtm/ZtabY21eV8WyL23mIyhg6aPDcr4K3TI=
X-Received: by 2002:a05:6a00:24c9:b0:50d:9302:c921 with SMTP id
 d9-20020a056a0024c900b0050d9302c921mr6102413pfv.57.1651179528501; Thu, 28 Apr
 2022 13:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
 <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com> <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com>
In-Reply-To: <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Apr 2022 13:58:37 -0700
Message-ID: <CAADnVQ+9axVKfyx-cCJW1NsVTcEp8BEUoAsXYiegEOsG3jmEww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
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

On Thu, Apr 28, 2022 at 12:15 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Thu, 2022-04-28 at 11:19 -0700, Andrii Nakryiko wrote:
> > On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
> > >
> > > uprobes work by raising a trap, setting a task flag from within the
> > > interrupt handler, and processing the actual work for the uprobe on the
> > > way back to userspace. As a result, uprobe handlers already execute in a
> > > user context. The primary obstacle to sleepable bpf uprobe programs is
> > > therefore on the bpf side.
> > >
> > > Namely, the bpf_prog_array attached to the uprobe is protected by normal
> > > rcu and runs with disabled preemption. In order for uprobe bpf programs
> > > to become actually sleepable, we need it to be protected by the tasks_trace
> > > rcu flavor instead (and kfree() called after a corresponding grace period).
> > >
> > > One way to achieve this is by tracking an array-has-contained-sleepable-prog
> > > flag in bpf_prog_array and switching rcu flavors based on it. However, this
> > > is deemed somewhat unwieldly and the rcu flavor transition would be hard
> > > to reason about.
> > >
> > > Instead, based on Alexei's proposal, we change the free path for
> > > bpf_prog_array to chain a tasks_trace and normal grace periods
> > > one after the other. Users who iterate under tasks_trace read section would
> > > be safe, as would users who iterate under normal read sections (from
> > > non-sleepable locations). The downside is that we take the tasks_trace latency
> > > unconditionally but that's deemed acceptable under expected workloads.
> >
> > One example where this actually can become a problem is cgroup BPF
> > programs. There you can make single attachment to root cgroup, but it
> > will create one "effective" prog_array for each descendant (and will
> > keep destroying and creating them as child cgroups are created). So
> > there is this invisible multiplier which we can't really control.
> >
> > So paying the (however small, but) price of call_rcu_tasks_trace() in
> > bpf_prog_array_free() which is used for purely non-sleepable cases
> > seems unfortunate. But I think an alternative to tracking this "has
> > sleepable" bit on a per bpf_prog_array case is to have
> > bpf_prog_array_free_sleepable() implementation independent of
> > bpf_prog_array_free() itself and call that sleepable variant from
> > uprobe detach handler, limiting the impact to things that actually
> > might be running as sleepable and which most likely won't churn
> > through a huge amount of arrays. WDYT?
>
> Honestly, I don't like the idea of having two different APIs, where if you use the
> wrong one, the program would only fail in rare and undebuggable circumstances.
>
> If we need specialization (and I'm not convinced we do - what's the rate of cgroup
> creation that we can sustain?), we should track that in the bpf_prog_array itself. We
> can have the allocation path set a flag and branch on it in free() to determine the
> necessary grace periods.

I think what Andrii is proposing is to leave bpf_prog_array_free() as-is
and introduce new bpf_prog_array_free_sleepable() (the way it is in
this patch) and call it from 2 places in kernel/trace/bpf_trace.c only.
This way cgroup won't be affected.

The rcu_trace protection here applies to prog_array itself.
Normal progs are still rcu, sleepable progs are rcu_trace.
Regardless whether they're called via trampoline or this new prog_array.
