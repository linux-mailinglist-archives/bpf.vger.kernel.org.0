Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13626341F
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgIIROl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:14:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730233AbgIIP3b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 11:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599665359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKRnalg2poH5SKe24cXt6xfvhbyMJHnXY+iW3AplBHU=;
        b=a0DrxPYIyMe6hipmW4Jx9Jl/ZBHdNV3LO11SL0pH7B4UacRC8GTTjxK9Jq5wwCUTFo+GLs
        +pEmdotWhCzJ+FBu4XbDA5y6+7GBbyXUy+x25TFMNmL7hnTGpoDRnpJ3JeuuQjbir0fngQ
        S+6IElwoqoUgax8HpvISJnOX1iCp/So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-oDeaobKyMgqSuIKovxUQjQ-1; Wed, 09 Sep 2020 11:10:56 -0400
X-MC-Unique: oDeaobKyMgqSuIKovxUQjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 805371009441;
        Wed,  9 Sep 2020 15:10:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1DB3E838BE;
        Wed,  9 Sep 2020 15:10:53 +0000 (UTC)
Date:   Wed, 9 Sep 2020 17:10:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909151053.GF1498025@krava>
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909113858.GF29330@paulmck-ThinkPad-P72>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> > But with the following hack:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 7dd523a7e32d..c417b817ec5d 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -217,7 +217,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
> >          * programs finish executing.
> >          * Wait for these two grace periods together.
> >          */
> > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > +//     synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > 
> > I see:
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real    0m1.588s
> > user    0m0.131s
> > sys    0m1.342s
> > 
> > It takes an extra minute to do 40 sync rcu_tasks_trace calls.
> > It means that every sync takes more than a second.
> > That feels excessive.
> > 
> > Doing:
> > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > +       synchronize_rcu();
> > is also fast:
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real    0m2.089s
> > user    0m0.139s
> > sys    0m1.282s
> > 
> > sync rcu_tasks() is fast too:
> > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > +       synchronize_rcu_tasks();
> > time ./test_progs -t trampoline_count
> > #101 trampoline_count:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > real    0m2.209s
> > user    0m0.117s
> > sys    0m1.344s
> > 
> > so it's really something going on with sync rcu_tasks_trace.
> > Could you please take a look?
> 
> I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.

hi,
I noticed the slowdown as well, and adding CONFIG_TASKS_TRACE_RCU_READ_MB=y
speeds it up for me

thanks,
jirka

> 
> Otherwise (or alternatively), could you please try booting with
> rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> second on a HZ=1000 system, which on a busy system could easily result
> in the grace-period delays that you are seeing.  The value of this
> kernel boot parameter does interact with the tasklist-scan backoffs,
> so its effect will not likely be linear.
> 
> Do either of those approaches help?
> 
> 							Thanx, Paul
> 

