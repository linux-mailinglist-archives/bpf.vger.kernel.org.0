Return-Path: <bpf+bounces-40844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C298F3A4
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472C4283F9F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F481A705A;
	Thu,  3 Oct 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7kLvkgV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071F1A7047;
	Thu,  3 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971784; cv=none; b=Ptvj79UYer12mqHrBdEV5cHxz3HIo4eqrBJwfslQTySCKCxDAIRi5ZFxryMKFRADURKdtGcsxGsF0F6egxgFaRMpGmNe00vHKnH+nbsgltK77HKAv76kWnFQBRAPAFgXoHIp1L8RMnATnyjosbr4Jtn2BOsyhRA1sb/LPrqp1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971784; c=relaxed/simple;
	bh=BJn88hqVZO9j+5QLdZUtap9byc5ND5vBpFQ+cBCsvHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQEvMYd2CpRTlW3gZD5r3J+g/BBxO/pbAvw51T0Ien4DzUEjEBWfETy7NsHF/n7z7N5mOP6ERl7mMMlzOWZuN2DFhPc1elUAFotLFUybmYKHsIoUnIidXol/J6ERAEjPJIgyol5u3mB8Wb7ZW87BPeChHK07nThRZolOyPVTZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7kLvkgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E96C4CEC5;
	Thu,  3 Oct 2024 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727971783;
	bh=BJn88hqVZO9j+5QLdZUtap9byc5ND5vBpFQ+cBCsvHg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D7kLvkgVLCnkhdNkZGEvKxjrOe2Qx+YYyKShG6Wo54MevQY2JsOMKJr2g2OWHyTnn
	 d9kK2BBQmm04itb8wrN1RO5Yp2KMcL1dPR/DIOAzjnTRkSOMgJBNXdob+u9NkQZW5i
	 Jh0ZULjOuGDAoZsfeUEEQCibbsX3m13LDR69BJqq0Mi/HGvl5X0aQ3zaaiW1i0Njzt
	 Cei7S5gitalVbt4Jqvyg8VvOAndp1QwpcMdgwuTbWyftsuLuA4a5YRIaZH7HRje8RU
	 58t2ldFCPG/Zqifa8mPUizq/hkGIkVLiXnonPt2XiXNKbzaUgCJkLPWySeNA4vz64n
	 HLwn15Q2yN5gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2BE8BCE0D68; Thu,  3 Oct 2024 09:09:43 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:09:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <eb9623d0-81d1-4727-8aaa-ff6f11163b30@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
 <CAEf4BzZ5mJH5+4j56zSKkvuRLLfcQMEbkjM-T86onZdAWtsN+g@mail.gmail.com>
 <CAEf4BzYgiNmSb=ZKQ65tm6nJDi1UX2Gq26cdHSH1mPwXJYZj5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYgiNmSb=ZKQ65tm6nJDi1UX2Gq26cdHSH1mPwXJYZj5g@mail.gmail.com>

On Wed, Oct 02, 2024 at 12:59:55PM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 3, 2024 at 3:08 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Sep 3, 2024 at 9:32 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > This series provides light-weight readers for SRCU.  This lightness
> > > is selected by the caller by using the new srcu_read_lock_lite() and
> > > srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> > > srcu_read_unlock() flavors.  Although this passes significant rcutorture
> > > testing, this should still be considered to be experimental.
> > >
> > > There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> > > on a given srcu_struct structure, then no other flavor may be used on
> > > that srcu_struct structure, before, during, or after.  (2) The _lite()
> > > readers may only be invoked from regions of code where RCU is watching
> > > (as in those regions in which rcu_is_watching() returns true).  (3)
> > > There is no auto-expediting for srcu_struct structures that have
> > > been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> > > srcu_struct structures invoke synchronize_rcu() at least twice, thus
> > > having longer latencies than their non-_lite() counterparts.  (5) Even
> > > with synchronize_srcu_expedited(), the resulting SRCU grace period
> > > will invoke synchronize_rcu() at least twice, as opposed to invoking
> > > the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> > > srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> > > srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> > > from NMI handlers (that is what the _nmisafe() interface are for).
> > > Although one could imagine readers that were both _lite() and _nmisafe(),
> > > one might also imagine that the read-modify-write atomic operations that
> > > are needed by any NMI-safe SRCU read marker would make this unhelpful
> > > from a performance perspective.
> > >
> > > All that said, the patches in this series are as follows:
> > >
> > > 1.      Rename srcu_might_be_idle() to srcu_should_expedite().
> > >
> > > 2.      Introduce srcu_gp_is_expedited() helper function.
> > >
> > > 3.      Renaming in preparation for additional reader flavor.
> > >
> > > 4.      Bit manipulation changes for additional reader flavor.
> > >
> > > 5.      Standardize srcu_data pointers to "sdp" and similar.
> > >
> > > 6.      Convert srcu_data ->srcu_reader_flavor to bit field.
> > >
> > > 7.      Add srcu_read_lock_lite() and srcu_read_unlock_lite().
> > >
> > > 8.      rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits.
> > >
> > > 9.      rcutorture: Add reader_flavor parameter for SRCU readers.
> > >
> > > 10.     rcutorture: Add srcu_read_lock_lite() support to
> > >         rcutorture.reader_flavor.
> > >
> > > 11.     refscale: Add srcu_read_lock_lite() support using "srcu-lite".
> > >
> > >                                                 Thanx, Paul
> > >
> >
> > Thanks Paul for working on this!
> >
> > I applied your patches on top of all my uprobe changes (including the
> > RFC patches that remove locks, optimize VMA to inode resolution, etc,
> > etc; basically the fastest uprobe/uretprobe state I can get to). And
> > then tested a few changes:
> >
> >   - A) baseline (no SRCU-lite, RCU Tasks Trace for uprobe, normal SRCU
> > for uretprobes)
> >   - B) A + SRCU-lite for uretprobes (i.e., SRCU to SRCU-lite conversion)
> >   - C) B + RCU Tasks Trace converted to SRCU-lite
> >   - D) I also pessimized baseline by reverting RCU Tasks Trace, so
> > both uprobes and uretprobes are SRCU protected. This allowed me to see
> > a pure gain of SRCU-lite over SRCU for uprobes, taking RCU Tasks Trace
> > performance out of the equation.
> >
> > In uprobes I used basically two benchmarks. One, uprobe-nop, that
> > benchmarks entry uprobes (which are the fastest most optimized case,
> > using RCU Tasks Trace in A and SRCU in D), and another that benchmarks
> > return uprobes (uretprobes), called uretprobe-nop, which is normal
> > SRCU both in A) and D). The latter uretprobe-nop benchmark basically
> > combines entry and return probe overheads, because that's how
> > uretprobes work.
> >
> 
> Ok, so I created B' and C' cases, which are just like B and C from
> before, but each now uses inlined versions of SRCU-lite API. I also
> re-ran the latest BASELINE, which I'll call A', just to make sure all
> the results are compatible and based off of the same tip/perf/core
> branch state (uretprobe performance significantly improved for >64
> CPUs, I don't know exactly why, tbh). I'll augment benchmark results
> below inline for easier comparison.
> 
> > So, below are the most meaningful comparisons. First, SRCU vs
> > SRCU-lite for uretprobes:
> >
> > BASELINE (A)
> > ============
> > uretprobe-nop         ( 1 cpus):    1.941 ± 0.002M/s  (  1.941M/s/cpu)
> > uretprobe-nop         ( 2 cpus):    3.731 ± 0.001M/s  (  1.866M/s/cpu)
> > uretprobe-nop         ( 3 cpus):    5.492 ± 0.002M/s  (  1.831M/s/cpu)
> > uretprobe-nop         ( 4 cpus):    7.234 ± 0.003M/s  (  1.808M/s/cpu)
> > uretprobe-nop         ( 8 cpus):   13.448 ± 0.098M/s  (  1.681M/s/cpu)
> > uretprobe-nop         (16 cpus):   22.905 ± 0.009M/s  (  1.432M/s/cpu)
> > uretprobe-nop         (32 cpus):   44.760 ± 0.069M/s  (  1.399M/s/cpu)
> > uretprobe-nop         (40 cpus):   52.986 ± 0.104M/s  (  1.325M/s/cpu)
> > uretprobe-nop         (64 cpus):   43.650 ± 0.435M/s  (  0.682M/s/cpu)
> > uretprobe-nop         (80 cpus):   46.831 ± 0.938M/s  (  0.585M/s/cpu)
> >
> > SRCU-lite for uretprobe (B)
> > ===========================
> > uretprobe-nop         ( 1 cpus):    2.014 ± 0.014M/s  (  2.014M/s/cpu)
> > uretprobe-nop         ( 2 cpus):    3.820 ± 0.002M/s  (  1.910M/s/cpu)
> > uretprobe-nop         ( 3 cpus):    5.640 ± 0.003M/s  (  1.880M/s/cpu)
> > uretprobe-nop         ( 4 cpus):    7.410 ± 0.003M/s  (  1.852M/s/cpu)
> > uretprobe-nop         ( 8 cpus):   13.877 ± 0.009M/s  (  1.735M/s/cpu)
> > uretprobe-nop         (16 cpus):   23.372 ± 0.022M/s  (  1.461M/s/cpu)
> > uretprobe-nop         (32 cpus):   45.748 ± 0.048M/s  (  1.430M/s/cpu)
> > uretprobe-nop         (40 cpus):   54.327 ± 0.093M/s  (  1.358M/s/cpu)
> > uretprobe-nop         (64 cpus):   43.672 ± 0.371M/s  (  0.682M/s/cpu)
> > uretprobe-nop         (80 cpus):   47.470 ± 0.753M/s  (  0.593M/s/cpu)
> >
> 
> NEW BASELINE (A')
> =================
> uretprobe-nop         ( 1 cpus):    1.946 ± 0.001M/s  (  1.946M/s/cpu)
> uretprobe-nop         ( 2 cpus):    3.660 ± 0.002M/s  (  1.830M/s/cpu)
> uretprobe-nop         ( 3 cpus):    5.522 ± 0.002M/s  (  1.841M/s/cpu)
> uretprobe-nop         ( 4 cpus):    7.145 ± 0.001M/s  (  1.786M/s/cpu)
> uretprobe-nop         ( 8 cpus):   13.449 ± 0.004M/s  (  1.681M/s/cpu)
> uretprobe-nop         (16 cpus):   22.374 ± 0.008M/s  (  1.398M/s/cpu)
> uretprobe-nop         (32 cpus):   45.039 ± 0.011M/s  (  1.407M/s/cpu)
> uretprobe-nop         (40 cpus):   42.422 ± 0.073M/s  (  1.061M/s/cpu)
> uretprobe-nop         (64 cpus):   65.136 ± 0.084M/s  (  1.018M/s/cpu)
> uretprobe-nop         (80 cpus):   76.004 ± 0.066M/s  (  0.950M/s/cpu)
> 
> SRCU-lite for uretprobe (B')
> ============================
> uretprobe-nop         ( 1 cpus):    1.973 ± 0.001M/s  (  1.973M/s/cpu)
> uretprobe-nop         ( 2 cpus):    3.756 ± 0.002M/s  (  1.878M/s/cpu)
> uretprobe-nop         ( 3 cpus):    5.623 ± 0.003M/s  (  1.874M/s/cpu)
> uretprobe-nop         ( 4 cpus):    7.206 ± 0.029M/s  (  1.802M/s/cpu)
> uretprobe-nop         ( 8 cpus):   13.668 ± 0.004M/s  (  1.708M/s/cpu)
> uretprobe-nop         (16 cpus):   23.067 ± 0.016M/s  (  1.442M/s/cpu)
> uretprobe-nop         (32 cpus):   45.757 ± 0.030M/s  (  1.430M/s/cpu)
> uretprobe-nop         (40 cpus):   54.550 ± 0.035M/s  (  1.364M/s/cpu)
> uretprobe-nop         (64 cpus):   67.124 ± 0.057M/s  (  1.049M/s/cpu)
> uretprobe-nop         (80 cpus):   77.150 ± 0.158M/s  (  0.964M/s/cpu)
> 
> Inlining does help a bit, adding +200-300K/s in some cases.

Thank you for testing this!  It seems compelling enough for me to send
this into the next merge window along with the base support, then.

							Thanx, Paul

> > You can see that across the board (except for noisy 64 CPU case)
> > SRCU-lite is faster.
> >
> >
> > Now, comparing A) vs C) on uprobe-nop, so we can see RCU Tasks Trace
> > vs SRCU-lite for uprobes.
> >
> > BASELINE (A)
> > ============
> > uprobe-nop            ( 1 cpus):    3.574 ± 0.004M/s  (  3.574M/s/cpu)
> > uprobe-nop            ( 2 cpus):    6.735 ± 0.006M/s  (  3.368M/s/cpu)
> > uprobe-nop            ( 3 cpus):   10.102 ± 0.005M/s  (  3.367M/s/cpu)
> > uprobe-nop            ( 4 cpus):   13.087 ± 0.008M/s  (  3.272M/s/cpu)
> > uprobe-nop            ( 8 cpus):   24.622 ± 0.031M/s  (  3.078M/s/cpu)
> > uprobe-nop            (16 cpus):   41.752 ± 0.020M/s  (  2.610M/s/cpu)
> > uprobe-nop            (32 cpus):   84.973 ± 0.115M/s  (  2.655M/s/cpu)
> > uprobe-nop            (40 cpus):  102.229 ± 0.030M/s  (  2.556M/s/cpu)
> > uprobe-nop            (64 cpus):  125.537 ± 0.045M/s  (  1.962M/s/cpu)
> > uprobe-nop            (80 cpus):  143.091 ± 0.044M/s  (  1.789M/s/cpu)
> >
> > SRCU-lite for uprobes (C)
> > =========================
> > uprobe-nop            ( 1 cpus):    3.446 ± 0.010M/s  (  3.446M/s/cpu)
> > uprobe-nop            ( 2 cpus):    6.411 ± 0.003M/s  (  3.206M/s/cpu)
> > uprobe-nop            ( 3 cpus):    9.563 ± 0.039M/s  (  3.188M/s/cpu)
> > uprobe-nop            ( 4 cpus):   12.454 ± 0.016M/s  (  3.113M/s/cpu)
> > uprobe-nop            ( 8 cpus):   23.172 ± 0.013M/s  (  2.897M/s/cpu)
> > uprobe-nop            (16 cpus):   39.793 ± 0.005M/s  (  2.487M/s/cpu)
> > uprobe-nop            (32 cpus):   79.616 ± 0.207M/s  (  2.488M/s/cpu)
> > uprobe-nop            (40 cpus):   96.851 ± 0.128M/s  (  2.421M/s/cpu)
> > uprobe-nop            (64 cpus):  119.432 ± 0.146M/s  (  1.866M/s/cpu)
> > uprobe-nop            (80 cpus):  135.162 ± 0.207M/s  (  1.690M/s/cpu)
> >
> 
> NEW BASELINE (A')
> =================
> uprobe-nop            ( 1 cpus):    3.480 ± 0.036M/s  (  3.480M/s/cpu)
> uprobe-nop            ( 2 cpus):    6.652 ± 0.026M/s  (  3.326M/s/cpu)
> uprobe-nop            ( 3 cpus):   10.050 ± 0.011M/s  (  3.350M/s/cpu)
> uprobe-nop            ( 4 cpus):   13.079 ± 0.008M/s  (  3.270M/s/cpu)
> uprobe-nop            ( 8 cpus):   24.620 ± 0.004M/s  (  3.077M/s/cpu)
> uprobe-nop            (16 cpus):   41.566 ± 0.030M/s  (  2.598M/s/cpu)
> uprobe-nop            (32 cpus):   77.314 ± 1.620M/s  (  2.416M/s/cpu)
> uprobe-nop            (40 cpus):  102.667 ± 0.047M/s  (  2.567M/s/cpu)
> uprobe-nop            (64 cpus):  126.298 ± 0.026M/s  (  1.973M/s/cpu)
> uprobe-nop            (80 cpus):  146.682 ± 0.035M/s  (  1.834M/s/cpu)
> 
> SRCU-lite for uprobes w/ inlining (C')
> ======================================
> uprobe-nop            ( 1 cpus):    3.444 ± 0.014M/s  (  3.444M/s/cpu)
> uprobe-nop            ( 2 cpus):    6.400 ± 0.021M/s  (  3.200M/s/cpu)
> uprobe-nop            ( 3 cpus):    9.568 ± 0.025M/s  (  3.189M/s/cpu)
> uprobe-nop            ( 4 cpus):   12.473 ± 0.020M/s  (  3.118M/s/cpu)
> uprobe-nop            ( 8 cpus):   23.552 ± 0.007M/s  (  2.944M/s/cpu)
> uprobe-nop            (16 cpus):   39.844 ± 0.016M/s  (  2.490M/s/cpu)
> uprobe-nop            (32 cpus):   78.667 ± 0.201M/s  (  2.458M/s/cpu)
> uprobe-nop            (40 cpus):   97.477 ± 0.094M/s  (  2.437M/s/cpu)
> uprobe-nop            (64 cpus):  119.472 ± 0.120M/s  (  1.867M/s/cpu)
> uprobe-nop            (80 cpus):  139.825 ± 0.042M/s  (  1.748M/s/cpu)
> 
> >
> > Overall, RCU Tasks Trace beats SRCU-lite, which I think is expected,
> > so consider this just a confirmation. I'm not sure I'd like to switch
> > from RCU Tasks Trace to SRCU-lite for uprobes part, but at least we
> > have numbers to make that decision.
> >
> > Finally, to see SRCU vs SRCU-lite for entry uprobes improvements
> > (i.e., if we never had RCU Tasks Trace). I've included a bit more
> > extensive set of CPU counts for completeness.
> >
> > BASELINE w/ SRCU for uprobes (D)
> > ================================
> > uprobe-nop            ( 1 cpus):    3.413 ± 0.003M/s  (  3.413M/s/cpu)
> > uprobe-nop            ( 2 cpus):    6.305 ± 0.003M/s  (  3.153M/s/cpu)
> > uprobe-nop            ( 3 cpus):    9.442 ± 0.018M/s  (  3.147M/s/cpu)
> > uprobe-nop            ( 4 cpus):   12.253 ± 0.006M/s  (  3.063M/s/cpu)
> > uprobe-nop            ( 5 cpus):   15.316 ± 0.007M/s  (  3.063M/s/cpu)
> > uprobe-nop            ( 6 cpus):   18.287 ± 0.030M/s  (  3.048M/s/cpu)
> > uprobe-nop            ( 7 cpus):   21.378 ± 0.025M/s  (  3.054M/s/cpu)
> > uprobe-nop            ( 8 cpus):   23.044 ± 0.010M/s  (  2.881M/s/cpu)
> > uprobe-nop            (10 cpus):   28.778 ± 0.012M/s  (  2.878M/s/cpu)
> > uprobe-nop            (12 cpus):   31.300 ± 0.016M/s  (  2.608M/s/cpu)
> > uprobe-nop            (14 cpus):   36.580 ± 0.007M/s  (  2.613M/s/cpu)
> > uprobe-nop            (16 cpus):   38.848 ± 0.017M/s  (  2.428M/s/cpu)
> > uprobe-nop            (24 cpus):   60.298 ± 0.080M/s  (  2.512M/s/cpu)
> > uprobe-nop            (32 cpus):   77.137 ± 1.957M/s  (  2.411M/s/cpu)
> > uprobe-nop            (40 cpus):   89.205 ± 1.278M/s  (  2.230M/s/cpu)
> > uprobe-nop            (48 cpus):   99.207 ± 0.444M/s  (  2.067M/s/cpu)
> > uprobe-nop            (56 cpus):  102.399 ± 0.484M/s  (  1.829M/s/cpu)
> > uprobe-nop            (64 cpus):  115.390 ± 0.972M/s  (  1.803M/s/cpu)
> > uprobe-nop            (72 cpus):  127.476 ± 0.050M/s  (  1.770M/s/cpu)
> > uprobe-nop            (80 cpus):  137.304 ± 0.068M/s  (  1.716M/s/cpu)
> >
> > SRCU-lite for uprobes (C)
> > =========================
> > uprobe-nop            ( 1 cpus):    3.446 ± 0.010M/s  (  3.446M/s/cpu)
> > uprobe-nop            ( 2 cpus):    6.411 ± 0.003M/s  (  3.206M/s/cpu)
> > uprobe-nop            ( 3 cpus):    9.563 ± 0.039M/s  (  3.188M/s/cpu)
> > uprobe-nop            ( 4 cpus):   12.454 ± 0.016M/s  (  3.113M/s/cpu)
> > uprobe-nop            ( 5 cpus):   15.634 ± 0.008M/s  (  3.127M/s/cpu)
> > uprobe-nop            ( 6 cpus):   18.443 ± 0.018M/s  (  3.074M/s/cpu)
> > uprobe-nop            ( 7 cpus):   21.793 ± 0.057M/s  (  3.113M/s/cpu)
> > uprobe-nop            ( 8 cpus):   23.172 ± 0.013M/s  (  2.897M/s/cpu)
> > uprobe-nop            (10 cpus):   29.430 ± 0.021M/s  (  2.943M/s/cpu)
> > uprobe-nop            (12 cpus):   32.035 ± 0.008M/s  (  2.670M/s/cpu)
> > uprobe-nop            (14 cpus):   37.174 ± 0.046M/s  (  2.655M/s/cpu)
> > uprobe-nop            (16 cpus):   39.793 ± 0.005M/s  (  2.487M/s/cpu)
> > uprobe-nop            (24 cpus):   61.656 ± 0.187M/s  (  2.569M/s/cpu)
> > uprobe-nop            (32 cpus):   79.616 ± 0.207M/s  (  2.488M/s/cpu)
> > uprobe-nop            (40 cpus):   96.851 ± 0.128M/s  (  2.421M/s/cpu)
> > uprobe-nop            (48 cpus):  104.178 ± 0.033M/s  (  2.170M/s/cpu)
> > uprobe-nop            (56 cpus):  105.689 ± 0.703M/s  (  1.887M/s/cpu)
> > uprobe-nop            (64 cpus):  119.432 ± 0.146M/s  (  1.866M/s/cpu)
> > uprobe-nop            (72 cpus):  127.574 ± 0.033M/s  (  1.772M/s/cpu)
> > uprobe-nop            (80 cpus):  135.162 ± 0.207M/s  (  1.690M/s/cpu)
> >
> > So, say, at 32 threads, we get 79.6 vs 77.1, which is about 3%
> > throughput win. Which is not negligible!
> >
> > Note that as we get to 80 cores data is more noisy (hyperthreading,
> > background system noise, etc). But you can still see an improvement
> > across basically the entire range.
> >
> > Hopefully the above data is useful.
> >
> > > ------------------------------------------------------------------------
> > >
> > >  Documentation/admin-guide/kernel-parameters.txt   |    4
> > >  b/Documentation/admin-guide/kernel-parameters.txt |    8 +
> > >  b/include/linux/srcu.h                            |   21 +-
> > >  b/include/linux/srcutree.h                        |    2
> > >  b/kernel/rcu/rcutorture.c                         |   28 +--
> > >  b/kernel/rcu/refscale.c                           |   54 +++++--
> > >  b/kernel/rcu/srcutree.c                           |   16 +-
> > >  include/linux/srcu.h                              |   86 +++++++++--
> > >  include/linux/srcutree.h                          |    5
> > >  kernel/rcu/rcutorture.c                           |   37 +++-
> > >  kernel/rcu/srcutree.c                             |  168 +++++++++++++++-------
> > >  11 files changed, 308 insertions(+), 121 deletions(-)

