Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F88C2633F2
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgIIRMi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgIIRMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5746C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so2712782pfn.9
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJUOWJrJVHDkwbKXwdvZQvdcTIg61Bz3FG9lBGw4doA=;
        b=kH1jMFzxuGh0lt1yO4hjriN6xOMezVf2awIqu+IoXyJdfJBfpMNJsh1Sbem/8JlftG
         ygk/crTrMn440tDs/pzvSrm8jjFdnYBwmQQptmEZ7TzoDRe7wU6V76Wp88T1Zlu+M97w
         8nQ6aCAWzLp+dS4NID2eCDe9Foow4VqaPehL6lNhHbCxyh1CpbeaX2ofeHpSnZl2SHiN
         iwYYytqYumqtHnUxXcHuEdsnLwNFoYPx7aDrdcFTwTiprict55Q0lmn7jwPdFETRa7Pj
         OAbu7jMhFZfCExa2+X70ehmi7CcKdJSUzeJObKqA1E+9Ei3P3vreWeewsAhX80WdrL86
         8zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJUOWJrJVHDkwbKXwdvZQvdcTIg61Bz3FG9lBGw4doA=;
        b=YHSUkgoZPu9hrgrX/eNGM+b+hJLc/rHmZxT5ZPfU/e1aIrxx6VY3IxvrjTs/k+W2D0
         cS96/Z5BPn/G5riwNZIVARNgtsTA0xFawbSrEYb6qxWQiGZuXlimv7t7hm9aL6xSIATC
         J8Aq6rodxMH+2P5iHZximxVVAfOFpQadxZ97i1Hsj9NJCMsj+MWSY1l2wNbPK7hY2TjG
         NF/qx//crI2anfnm7oUIaUP2KVpq6aTEpj7ZEXodiDy4ySQLYmUpFNyk70TshGS6m5dg
         9HQj9EqAWDaz6eTEEf4/HcA0byOOp+3roH2y1kkc0y9joN0T/VKwFi8NmrckMd6yytcn
         krTQ==
X-Gm-Message-State: AOAM533++sigOdV2Zg5pF1fwHsTpYpWRhIaVIjQ4JukU9l+jH863CwAl
        X7Ibbw3zhmYL1+Zdl1nmKk0=
X-Google-Smtp-Source: ABdhPJyFjpKbt5h9LAcYqLNKeH07gYw3RrMeTJE2D0SDijaOX4kOcmhWg1gbnpfHr1WF7KSigkcVNQ==
X-Received: by 2002:a62:3047:0:b029:13e:d13d:a088 with SMTP id w68-20020a6230470000b029013ed13da088mr1679874pfw.31.1599671552112;
        Wed, 09 Sep 2020 10:12:32 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8178])
        by smtp.gmail.com with ESMTPSA id v69sm2819715pgd.61.2020.09.09.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:31 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:12:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909113858.GF29330@paulmck-ThinkPad-P72>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 04:38:58AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 08, 2020 at 07:34:20PM -0700, Alexei Starovoitov wrote:
> > Hi Paul,
> > 
> > Looks like sync rcu_tasks_trace got slower or we simply didn't notice
> > it earlier.
> > 
> > In selftests/bpf try:
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real    1m17.082s
> > user    0m0.145s
> > sys    0m1.369s
> > 
> > so it's really something going on with sync rcu_tasks_trace.
> > Could you please take a look?
> 
> I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.

I've added
CONFIG_RCU_EXPERT=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y

and it helped:

time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real	0m8.924s
user	0m0.138s
sys	0m1.408s

But this is still bad. It's 4 times slower vs rcu_tasks
and isn't really usable for bpf, since it adds memory barriers exactly
where we need them removed.

In the default configuration rcu_tasks_trace is 40! times slower than rcu_tasks.
This huge difference in sync times concerns me a lot.
If bpf has to use memory barriers in rcu_read_lock_trace
and still be 4 times slower than rcu_tasks in the best case
then there is no much point in rcu_tasks_trace.
Converting everything to srcu would be better, but I really hope
you can find a solution to this tasks_trace issue.

> Otherwise (or alternatively), could you please try booting with
> rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> second on a HZ=1000 system, which on a busy system could easily result
> in the grace-period delays that you are seeing.  The value of this
> kernel boot parameter does interact with the tasklist-scan backoffs,
> so its effect will not likely be linear.

The tests were run on freshly booted VM with 4 cpus. The VM is idle.
The host is idle too.

Adding rcupdate.rcu_task_ipi_delay=50 boot param sort-of helped:
time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real	0m25.890s
user	0m0.124s
sys	0m1.507s
It is still awful.

From "perf report" there is little time spend in the kernel. The kernel is
waiting on something. I thought in theory the rcu_tasks_trace should have been
faster on update side vs rcu_tasks ? Could it be a bug somewhere and some
missing wakeup? It doesn't feel that it works as intended. Whatever it is
please try to reproduce it to remove me as a middle man.
