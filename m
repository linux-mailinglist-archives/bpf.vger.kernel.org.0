Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19863DC58F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfJRM6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 08:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731166AbfJRM6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 08:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDC6989F2B4;
        Fri, 18 Oct 2019 12:58:03 +0000 (UTC)
Received: from tagon (ovpn-122-245.rdu2.redhat.com [10.10.122.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083AA5D70E;
        Fri, 18 Oct 2019 12:58:01 +0000 (UTC)
Date:   Fri, 18 Oct 2019 07:58:00 -0500
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018075800.238f4f9c@tagon>
In-Reply-To: <alpine.DEB.2.21.1910181038130.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
        <20191017145358.GA26267@pc-63.home>
        <20191017154021.ndza4la3hntk4d4o@linutronix.de>
        <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
        <20191017214917.18911f58@tagon>
        <alpine.DEB.2.21.1910181038130.1869@nanos.tec.linutronix.de>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 18 Oct 2019 12:58:03 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Oct 2019 10:46:01 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > >   #3) BPF uses the up_read_non_owner() hackery which was only invented to
> > >       deal with already existing horrors and not meant to be proliferated.
> > > 
> > >       Yes, I know it's a existing facility ....  
> > 
> > I'm sure I'll regret asking this, but why is up_read_non_owner() a horror? I mean,
> > I get the fundamental wrongness of having someone that's not the owner of a semaphore
> > performing an 'up' on it, but is there an RT-specific reason that it's bad? Is it
> > totally a blocker for using BPF with RT or is it something we should fix over time?  
> 
> RT has strict locker == unlocker semantics simply because the owner
> (locker) is subject to priority inheritance and a non-owner unlock cannot
> undo PI on behalf of the locker sanely. Also exposing the locker to PI if
> the locker is not involved in unlocking is obviously a pointless exercise
> and potentially a source of unbound priority inversion.

Ok, I forgot about the PI consequences. Thanks teacher :)

> 
> > I do think that we (RT) are going to have to co-exist with BPF, if only due to the
> > increased use of XDP. I also think that other sub-systems will start to
> > employ BPF for production purposes (as opposed to debug/analysis which is
> > how we generally look at tracing, packet sniffing, etc.). I think we *have* to
> > figure out how to co-exist.  
> 
> I'm not saying that RT does not want BPF, quite the contrary, but for the
> initial merge BPF is not a hard requirement, so disabling it was the
> straight forward path.
> 
> I'm all ears to get pointers how to solve that right now.
>  

Yeah, put it down to lack of sleep. After waking up and rereading, I first realized
that we're not immediately affected since RHEL8 doesn't use BPF. But we're going to 
have to deal with it next year, since we'll be looking at a 5.6+ kernel which will 
have PREEMPT_RT and the latest BPF bells and whistles. So might as well start the 
conversations now. 

Arnaldo and I have been having lots of conversations regarding BPF, so we'll extend
that and dig in on the preemption issue for now. We also need to understand the 
memory allocation behavior so we can hopefully move it out of atomic regions. I'm not
sure how we should address the up_read_non_owner() issue at the moment.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
