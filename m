Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC63DC536
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633903AbfJRMnq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 18 Oct 2019 08:43:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633871AbfJRMnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 08:43:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iLRbV-00072Z-6y; Fri, 18 Oct 2019 14:43:37 +0200
Date:   Fri, 18 Oct 2019 14:43:37 +0200
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        David Miller <davem@davemloft.net>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018124337.eycbrt25jmxfmar6@linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home>
 <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <20191017214917.18911f58@tagon>
 <alpine.DEB.2.21.1910181038130.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.DEB.2.21.1910181038130.1869@nanos.tec.linutronix.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-10-18 10:46:01 [+0200], Thomas Gleixner wrote:
> Clark,
> 
> On Thu, 17 Oct 2019, Clark Williams wrote:
> > On Thu, 17 Oct 2019 23:54:07 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >   #2) BPF does allocations in atomic contexts, which is a dubious decision
> > >       even for non RT. That's related to #1
> > 
> > I guess my question here is, are the allocations done on behalf of an about-to-run
> > BPF program, or as a result of executing BPF code?  Is it something we might be able
> > to satisfy from a pre-allocated pool rather than kmalloc()? Ok, I need to go dive
> > into BPF a bit deeper.
> 
> Sebastion?

The data structures use raw_spinlock_t as protection. This is where the
atomic context is from.
lpm_trie with trie_update_elem() allocates a new element while holding
the lock. I tried to make it a spinlock_t which wouldn't have the
problem but then
   https://lore.kernel.org/bpf/4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net/

pointed out that it has been made raw_spinlock_t due to kprobe on -RT.
Commit ac00881f92210 ("bpf: convert hashtab lock to raw lock") was
"okay" back then (according to Steven Rostedt) but it got wrong with the
memory allocation which came in later.

In order to tackle one thing at a time, I would say that kprobe isn't
our biggest concern…
 
> 	tglx

Sebastian
