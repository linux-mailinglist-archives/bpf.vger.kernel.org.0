Return-Path: <bpf+bounces-5353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D1759D42
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14441C210B6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE081BB38;
	Wed, 19 Jul 2023 18:27:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE32C138
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 18:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBDEC433C8;
	Wed, 19 Jul 2023 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689791273;
	bh=abnVgmoykOrPBnFbts3x0YYarmtT6yCNCnDn9/9ZvQM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iMpmumbM2AgUGjTSrP0pLzS5YwuVEFC7WmOPLk2Um7JpzC8pqn6yHsIX/V2PEkMJE
	 JHl7Y/mKrivqULXRMemYhDVZNrHrAnrFH5rqYSETChScbbur6bkUf5QxocDHKTL6SD
	 vtiN5bFSOGAgPs5l951xs/qFe0q6OGweOXy5rIikXX2nsDrR508JqlZ0NShIP1ja1m
	 g+Og93DmD6YKsiW9/e6epsXV9UPFGoMEhWV2vYpCogzAV9C4bTs6meFN3LYg2YgX0s
	 zSS9bw+iIpZXK6L8o1DWi4IUqzfHjQPE8/eZmD46VI5A4xt5OiEb+EuA9CnCyZsGMd
	 WLPbEK7fdYQYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B04DCE092F; Wed, 19 Jul 2023 11:27:52 -0700 (PDT)
Date: Wed, 19 Jul 2023 11:27:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joe Perches <joe@perches.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <351d0261-210a-44a3-ade6-59289f407db2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>

On Wed, Jul 19, 2023 at 07:51:58AM -0400, Joel Fernandes wrote:
> 
> 
> On 7/17/23 19:34, Paul E. McKenney wrote:
> > On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
> > > On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> > > > RCU Tasks Trace is quite specialized, having been created specifically
> > > > for sleepable BPF programs.  Because it allows general blocking within
> > > > readers, any new use of RCU Tasks Trace must take current use cases into
> > > > account.  Therefore, update checkpatch.pl to complain about use of any of
> > > > the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> > > > 
> > > > Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> > > > Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> > > > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> > > > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > Cc: <bpf@vger.kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >   scripts/checkpatch.pl | 18 ++++++++++++++++++
> > > >   1 file changed, 18 insertions(+)
> > > > 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -7457,6 +7457,24 @@ sub process {
> > > >   			}
> > > >   		}
> > > > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > > > +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> > > > +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> > > > +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> > > > +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> > > > +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> > > > +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> > > > +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> > > > +			if ($realfile !~ m@^kernel/bpf@ &&
> > > > +			    $realfile !~ m@^include/linux/bpf@ &&
> > > > +			    $realfile !~ m@^net/bpf@ &&
> > > > +			    $realfile !~ m@^kernel/rcu@ &&
> > > > +			    $realfile !~ m@^include/linux/rcu@) {
> > > 
> > > Functions and paths like these tend to be accreted.
> > > 
> > > Please use a variable or 2 like:
> > > 
> > > our $rcu_trace_funcs = qr{(?x:
> > > 	rcu_read_lock_trace |
> > > 	rcu_read_lock_trace_held |
> > > 	rcu_read_unlock_trace |
> > > 	call_rcu_tasks_trace |
> > > 	synchronize_rcu_tasks_trace |
> > > 	rcu_barrier_tasks_trace |
> > > 	rcu_request_urgent_qs_task
> > > )};
> > > our $rcu_trace_paths = qr{(?x:
> > > 	kernel/bfp/ |
> > > 	include/linux/bpf |
> > > 	net/bpf/ |
> > > 	kernel/rcu/ |
> > > 	include/linux/rcu
> > > )};
> > 
> > Like this?
> > 
> > # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > 		our $rcu_trace_funcs = qr{(?x:
> > 			rcu_read_lock_trace |
> > 			rcu_read_lock_trace_held |
> > 			rcu_read_unlock_trace |
> > 			call_rcu_tasks_trace |
> > 			synchronize_rcu_tasks_trace |
> > 			rcu_barrier_tasks_trace |
> > 			rcu_request_urgent_qs_task
> > 		)};
> > 		our $rcu_trace_paths = qr{(?x:
> > 			kernel/bfp/ |
> > 			include/linux/bpf |
> > 			net/bpf/ |
> > 			kernel/rcu/ |
> > 			include/linux/rcu
> > 		)};
> > 		if ($line =~ /$rcu_trace_funcs/) {
> > 			if ($realfile !~ m@^$rcu_trace_paths@) {
> > 				WARN("RCU_TASKS_TRACE",
> > 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> > 			}
> > 		}
> > 
> > No, that is definitely wrong.  It has lost track of the list of pathnames,
> > thus complaining about uses of those functions in files where their use
> > is permitted.
> > 
> > But this seems to work:
> > 
> > # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > 		our $rcu_trace_funcs = qr{(?x:
> > 			rcu_read_lock_trace |
> > 			rcu_read_lock_trace_held |
> > 			rcu_read_unlock_trace |
> > 			call_rcu_tasks_trace |
> > 			synchronize_rcu_tasks_trace |
> > 			rcu_barrier_tasks_trace |
> > 			rcu_request_urgent_qs_task
> > 		)};
> > 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> > 			if ($realfile !~ m@^kernel/bpf@ &&
> > 			    $realfile !~ m@^include/linux/bpf@ &&
> > 			    $realfile !~ m@^net/bpf@ &&
> > 			    $realfile !~ m@^kernel/rcu@ &&
> > 			    $realfile !~ m@^include/linux/rcu@) {
> > 				WARN("RCU_TASKS_TRACE",
> > 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> > 			}
> > 		}
> > 
> > Maybe the "^" needs to be distributed into $rcu_trace_paths?
> > 
> > # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > 		our $rcu_trace_funcs = qr{(?x:
> > 			rcu_read_lock_trace |
> > 			rcu_read_lock_trace_held |
> > 			rcu_read_unlock_trace |
> > 			call_rcu_tasks_trace |
> > 			synchronize_rcu_tasks_trace |
> > 			rcu_barrier_tasks_trace |
> > 			rcu_request_urgent_qs_task
> > 		)};
> > 		our $rcu_trace_paths = qr{(?x:
> > 			^kernel/bfp/ |
> > 			^include/linux/bpf |
> > 			^net/bpf/ |
> > 			^kernel/rcu/ |
> > 			^include/linux/rcu
> > 		)};
> > 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> > 			if ($realfile !~ m@$rcu_trace_paths@) {
> > 				WARN("RCU_TASKS_TRACE",
> > 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> > 			}
> > 		}
> > 
> > But no joy here, either.  Which is no surprise, given that perl is
> > happy to distribute the "\b" and the "\s*\(" across the elements of
> > $rcu_trace_funcs.  I tried a number of other variations, including
> > inverting the "if" condition "(!(... =~ ...))", inverting the "if"
> > condition via an empty "then" clause, replacing the "m@" with "/",
> > replacing the "|" in the "qr{}" with "&", and a few others.
> > 
> > Again, listing the pathnames explicitly in the second "if" condition
> > works just fine.
> > 
> 
> Not a perl expert but I wonder if the following are any options at all:
> 
> 1. Instead of having a complex list of strings in a regex variable, it might
> be easier to hold the strings as a perl array, and then iterate over that
> array checking each element of the array on every iteration, against the
> line.
> 
> 2. Roll the "\b" and/or "^" in into the regex variable itself than trying
> make them play with the variable later.
> 
> 3. Use parentheses around the variable? Not sure if that will work but I
> wonder if it has something to do with operator precedence.
> 
> 4. Instead of a list of paths, maybe it is better to look for "rcu" or "bpf"
> in the regex itself? That way new paths don't require script updates (at the
> expense though of false-positives (highly unlikely, IMHO)).

Given perl's tendency to have corner cases in its corner cases, I
am guessing that the "^" character combined with the "/" character is
causing trouble here.  Especially given that I don't see any use of such
a pattern anywhere in checkpatch.pl except directly in a "~" expression,
and there are a lot of those.

So I will keep it as is unless I hear otherwise from Joe Perches.

							Thanx, Paul

