Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1A263580
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIISF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 14:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgIISE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01864C061786
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 11:04:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so1574225pgb.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tG9agVj0GMRVKH1QLoL/lKaoBXW6B6XLK0Iu5QYQprk=;
        b=aJA4if0O1IlOC9dudFG+Q8j1MjEmDn+jq0+mZNXBK02FtB/rMzLumjcHYQl/zMVNzi
         DUQKOhRqehjpULtlize+xh6K3GPl3r+AFEl66lipPSiLzmGVem7vaoFIP+aeJSl/5aMA
         bywNoh1wOAL/7fhNZh3Hz1TUOeSMKVPudFqe5dZy79OexNRfuLSD17sBR6BZPm3IV746
         kpWbV5cD8e/hMHKvcyTulnmtq3Ok2yFc88I8ynoYRa/he6n3QhI1cFmq5e+wDbePLpe2
         JZXakAkf9fpKiLD69aurRSoi8adKKzqZQzM3pZjF83fJycJXkAnQd0rRNn+tt/AHjiXb
         lFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tG9agVj0GMRVKH1QLoL/lKaoBXW6B6XLK0Iu5QYQprk=;
        b=TJvzKroYLc3DOhzUErFqxMhUJfUxFoHJQKp64L68IB2mUnzbCm+PYUzB9qMas5m8iE
         Ufb1URzZWmwWUj2KuGl6Zrxe6dLnnzty3kssIk3LFeeFY5go2ua0mR73KWJhU60FEOXE
         yp/cCI4MAyEAdx7nZ5Jr5h05thl1DGCntvD+gEHkqe3oJl2aK8VA8p/4NFdHdbyGgBo3
         p2IamKoICqw9ZJwXlAspYDau3HpXkL0ru0VB9AHBgbPl53Vz/DwQCzGV9shBEvxrrtWf
         4eqywun6weWFAAyvPe16+H+SnSjdH+sKuXs190Nk9fMQ/LrMoLgHMsOOUIu/+hv8waKf
         0CKA==
X-Gm-Message-State: AOAM533X0JcelpA9g38q1JY7WZfYEDFYyKn7COmv3mAsdUDhjVZavsTA
        lZX4AcDdwiMPO1Am20Z2KLti05vHw7U=
X-Google-Smtp-Source: ABdhPJzqYauEiDjo8ESVZzi1W5NQLfB8vNY7CPbqMKkzpakK+orCm0oj20IY2CwVPbvFrGrAeihkgw==
X-Received: by 2002:a17:902:aa06:b029:cf:85a7:8374 with SMTP id be6-20020a170902aa06b02900cf85a78374mr2047271plb.3.1599674661468;
        Wed, 09 Sep 2020 11:04:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8178])
        by smtp.gmail.com with ESMTPSA id 31sm2820121pgs.59.2020.09.09.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:04:20 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:04:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909173512.GI29330@paulmck-ThinkPad-P72>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 10:35:12AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 10:12:28AM -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 09, 2020 at 04:38:58AM -0700, Paul E. McKenney wrote:
> > > On Tue, Sep 08, 2020 at 07:34:20PM -0700, Alexei Starovoitov wrote:
> > > > Hi Paul,
> > > > 
> > > > Looks like sync rcu_tasks_trace got slower or we simply didn't notice
> > > > it earlier.
> > > > 
> > > > In selftests/bpf try:
> > > > time ./test_progs -t trampoline_count
> > > > #101 trampoline_count:OK
> > > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > > 
> > > > real    1m17.082s
> > > > user    0m0.145s
> > > > sys    0m1.369s
> > > > 
> > > > so it's really something going on with sync rcu_tasks_trace.
> > > > Could you please take a look?
> > > 
> > > I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> > > If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> > 
> > I've added
> > CONFIG_RCU_EXPERT=y
> > CONFIG_TASKS_TRACE_RCU_READ_MB=y
> > 
> > and it helped:
> > 
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real	0m8.924s
> > user	0m0.138s
> > sys	0m1.408s
> > 
> > But this is still bad. It's 4 times slower vs rcu_tasks
> > and isn't really usable for bpf, since it adds memory barriers exactly
> > where we need them removed.
> > 
> > In the default configuration rcu_tasks_trace is 40! times slower than rcu_tasks.
> > This huge difference in sync times concerns me a lot.
> > If bpf has to use memory barriers in rcu_read_lock_trace
> > and still be 4 times slower than rcu_tasks in the best case
> > then there is no much point in rcu_tasks_trace.
> > Converting everything to srcu would be better, but I really hope
> > you can find a solution to this tasks_trace issue.
> > 
> > > Otherwise (or alternatively), could you please try booting with
> > > rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> > > second on a HZ=1000 system, which on a busy system could easily result
> > > in the grace-period delays that you are seeing.  The value of this
> > > kernel boot parameter does interact with the tasklist-scan backoffs,
> > > so its effect will not likely be linear.
> > 
> > The tests were run on freshly booted VM with 4 cpus. The VM is idle.
> > The host is idle too.
> > 
> > Adding rcupdate.rcu_task_ipi_delay=50 boot param sort-of helped:
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real	0m25.890s
> > user	0m0.124s
> > sys	0m1.507s
> > It is still awful.
> > 
> > >From "perf report" there is little time spend in the kernel. The kernel is
> > waiting on something. I thought in theory the rcu_tasks_trace should have been
> > faster on update side vs rcu_tasks ? Could it be a bug somewhere and some
> > missing wakeup? It doesn't feel that it works as intended. Whatever it is
> > please try to reproduce it to remove me as a middle man.
> 
> On it.
> 
> To be fair, I was designing for a nominal one-second grace period,
> which was also the rough goal for rcu_tasks.
> 
> When do you need this by?
> 
> Left to myself, I will aim for the merge window after the upcoming one,
> and then backport to the prior -stable versions having RCU tasks trace.

That would be too late.
We would have to disable sleepable bpf progs or convert them to srcu.
bcc/bpftrace have a limit of 1000 probes for regexes to make sure
these tools don't add too many kprobes to the kernel at once.
Right now fentry/fexit/freplace are using trampoline which does
synchronize_rcu_tasks(). My measurements show that it's roughly
equal to synchronize_rcu() on idle box and perfectly capable to
be a replacement for kprobe based attaching.
It's not uncommon to attach a hundred kprobes or fentry probes at
a start time. So bpf trampoline has to be able to do 1000 in a second.
And it was the case before sleepable got added to the trampoline.
Now it's doing:
synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
and it's causing this massive slowdown which makes bpf trampoline
pretty much unusable and everything that builds on top suffers.
I can add a counter of sleepable progs to trampoline and do
either sync rcu_tasks or sync_mult(tasks, tasks_trace),
but we've discussed exactly that idea few months back and concluded that
rcu_tasks is likely to be heavier than rcu_tasks_trace, so I didn't
bother with the counter. I can still add it, but slow rcu_tasks_trace
means that sleepable progs are not usable due to slow startup time,
so have to do something with sleepable anyway.
So "when do you need this by?" the answer is asap.
I'm considering such changes to be a bugfix, not a feture.
