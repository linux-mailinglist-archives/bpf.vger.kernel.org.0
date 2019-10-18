Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA65DC563
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634047AbfJRMtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 08:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634046AbfJRMtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 08:49:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 179BD18C8906;
        Fri, 18 Oct 2019 12:49:40 +0000 (UTC)
Received: from tagon (ovpn-122-245.rdu2.redhat.com [10.10.122.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31CC5100EA07;
        Fri, 18 Oct 2019 12:49:38 +0000 (UTC)
Date:   Fri, 18 Oct 2019 07:49:36 -0500
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018074936.36f15bd1@tagon>
In-Reply-To: <alpine.DEB.2.21.1910181031040.1869@nanos.tec.linutronix.de>
References: <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
        <20191017214917.18911f58@tagon>
        <20191017.215739.1133924746697268824.davem@davemloft.net>
        <alpine.DEB.2.21.1910181031040.1869@nanos.tec.linutronix.de>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 18 Oct 2019 12:49:40 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Oct 2019 10:38:06 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 17 Oct 2019, David Miller wrote:
> 
> > From: Clark Williams <williams@redhat.com>
> > Date: Thu, 17 Oct 2019 21:49:17 -0500
> >   
> > > BPF programs cannot loop and are limited to 4096 instructions.  
> > 
> > The limit was increased to 1 million not too long ago.  
> 
> Assuming a instruction/cycle ratio of 1.0 and a CPU frequency of 2GHz,
> that's 500us of preempt disabled time. Out of bounds by at least one order
> of magntiude for a lot of RT scenarios.
> 

So if I do my arithmetic right, 4096 instructions would be around 2us. In
many cases that would just be noise, but there are some customer cases on
the horizon where 2us would be a significant fraction of their max latency.

Hmmm. A quick grep through the Kconfigs didn't show me a BPF config that
was set to a large numeric value (e.g. 1000000). Is the instruction limit
hard coded into the verifier/VM logic and if so, could we lift it out and
set a smaller limit for PREEMPT_RT? Not a silver bullet, but might be a
start, since it sounds like BPF code presumes it has the cpu for the duration
of a program run. 

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
