Return-Path: <bpf+bounces-5657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61075D790
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 00:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B891C2186E
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C71BE6D;
	Fri, 21 Jul 2023 22:34:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B696DDC2
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E34C433C8;
	Fri, 21 Jul 2023 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689978867;
	bh=amtm4eN/GW9Th2XfpHJtyiophvhqrM44V8MCh9awRZw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q4puTUEDW0RsT7X4yMNkOgD5jCqxug/5WCqqBZkcYD4MyCC+psfmnstCWtJRZAOrh
	 AaaMArDzMSa+UROyuJulApvn2XVqjXW4H3Ytp4ATj2TzVnA4tcjGPmOpoxkXrkzDMJ
	 FHwO67Og0C4quuC1IpK2cRPlIhqR5hT6IKpvnOnvsmqke/YbWz9GxqDyl/WSS8n6yZ
	 9p7qx03L0Lh8r1UF1aMDYaFiDxW3vQmu85OPMawYMXnQIGZQCedFuRaxzq1ewdVeKm
	 9fENDTtsJ35Law+2qcs/+Je9Iieve+cq0TumAp8lf/sCNGjaz4S2X9Bw3r4TakQAUG
	 5SiAEsH+pnWyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4025ECE09E0; Fri, 21 Jul 2023 15:34:27 -0700 (PDT)
Date: Fri, 21 Jul 2023 15:34:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <3ef4021c-fceb-4b49-866b-400c505f2545@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <589412dd594b7efc618728fe68ad6c86f3c60878.camel@perches.com>
 <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>
 <c0ca3071-231a-49b1-b153-38ff0328470d@paulmck-laptop>
 <be08b429164e18b70f8341eab3deb075fc8b63b4.camel@perches.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be08b429164e18b70f8341eab3deb075fc8b63b4.camel@perches.com>

On Thu, Jul 20, 2023 at 09:38:51PM -0700, Joe Perches wrote:
> On Thu, 2023-07-20 at 20:56 -0700, Paul E. McKenney wrote:
> 
> > 
> > > That works much better, thank you!  I will update the patch on my
> > > next rebase.
> > 
> > As shown below.  Is this what you had in mind?
> []
> > commit 496aa3821b40459b107f4bbc14ca867daad21fb6
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Jul 6 11:48:07 2023 -0700
> > 
> >     checkpatch: Complain about unexpected uses of RCU Tasks Trace
> >     
> >     RCU Tasks Trace is quite specialized, having been created specifically
> >     for sleepable BPF programs.  Because it allows general blocking within
> >     readers, any new use of RCU Tasks Trace must take current use cases into
> >     account.  Therefore, update checkpatch.pl to complain about use of any of
> >     the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7457,6 +7457,30 @@ sub process {
> >  			}
> >  		}
> >  
> > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > +		our $rcu_trace_funcs = qr{(?x:
> > +			rcu_read_lock_trace |
> > +			rcu_read_lock_trace_held |
> > +			rcu_read_unlock_trace |
> > +			call_rcu_tasks_trace |
> > +			synchronize_rcu_tasks_trace |
> > +			rcu_barrier_tasks_trace |
> > +			rcu_request_urgent_qs_task
> > +		)};
> > +		our $rcu_trace_paths = qr{(?x:
> > +			kernel/bpf/ |
> > +			include/linux/bpf |
> > +			net/bpf/ |
> > +			kernel/rcu/ |
> > +			include/linux/rcu
> > +		)};
> > +		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> > +			if ($realfile !~ m@^$rcu_trace_paths@) {
> > +				WARN("RCU_TASKS_TRACE",
> > +				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 
> Exactly yes.
> 
> (though I still suggest a capture group to show the function like below)
> 
> 		if ($line =~ /\b($rcu_trace_funcs)\s*\(/ &&
> 		    $realfile !~ m{^$rcu_trace_paths}) {
> 			WARN("RCU_TASKS_TRACE",
> 			     "use of RCU task trace '$1' is incorrect outside BPF or core RCU code\n" . $herecurr);
> 		}

That does seem to work!

I will fold this change in on my next rebase.

							Thanx, Paul

