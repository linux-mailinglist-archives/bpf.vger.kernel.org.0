Return-Path: <bpf+bounces-5578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3575BD02
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 05:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E9A282047
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B6801;
	Fri, 21 Jul 2023 03:56:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738E7F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 03:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27ABC433C8;
	Fri, 21 Jul 2023 03:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689911788;
	bh=ptN+xqdqGtJBNVF0prBj0UHOwsUmf9X9j22+xdsbzYQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K+vv3lg+OI70LpRyVPsQimFB7WygaM6fbPNx7u0ZsLtuh9nycdZq5gMH63sRZGlTl
	 hkYulhs5rpMIB0+AYqAJIFtDlUcDicDkc1jTPzQrSqMOh4/r8X2WvWbwQ6dFK/mY7W
	 n82T6GI9M9W7SiNTb1TeBzAFgpgX0WzBA92WKxNMcf2gBo/blMBpuNxI9gPYt8N7K4
	 LsIzBUBcHCd7TDpq74nsNzYzpqsu91KMG0HxrVVbNrre+pm2Jrx5rw2QjDfDeSryzP
	 /aeOjj5edAIFQwID1PNFWwbQDR/9z0SlRi/2HAci4HcbVsyIy6JTyXKOC6lAd46prj
	 RzArTxCmtmxrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D767CE09F7; Thu, 20 Jul 2023 20:56:27 -0700 (PDT)
Date: Thu, 20 Jul 2023 20:56:27 -0700
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
Message-ID: <c0ca3071-231a-49b1-b153-38ff0328470d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <589412dd594b7efc618728fe68ad6c86f3c60878.camel@perches.com>
 <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>

On Thu, Jul 20, 2023 at 12:43:55PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 20, 2023 at 12:29:42AM -0700, Joe Perches wrote:
> > On Mon, 2023-07-17 at 16:34 -0700, Paul E. McKenney wrote:
> > > On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
> > > > On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> > > > > RCU Tasks Trace is quite specialized, having been created specifically
> > > > > for sleepable BPF programs.  Because it allows general blocking within
> > > > > readers, any new use of RCU Tasks Trace must take current use cases into
> > > > > account.  Therefore, update checkpatch.pl to complain about use of any of
> > > > > the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> > > > > 
> > > > > Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> > > > > Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> > > > > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> > > > > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > > Cc: <bpf@vger.kernel.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  scripts/checkpatch.pl | 18 ++++++++++++++++++
> > > > >  1 file changed, 18 insertions(+)
> > > > > 
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -7457,6 +7457,24 @@ sub process {
> > > > >  			}
> > > > >  		}
> > > > >  
> > > > > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > > > > +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> > > > > +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> > > > > +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> > > > > +			if ($realfile !~ m@^kernel/bpf@ &&
> > > > > +			    $realfile !~ m@^include/linux/bpf@ &&
> > > > > +			    $realfile !~ m@^net/bpf@ &&
> > > > > +			    $realfile !~ m@^kernel/rcu@ &&
> > > > > +			    $realfile !~ m@^include/linux/rcu@) {
> > > > 
> > > > Functions and paths like these tend to be accreted.
> > > > 
> > > > Please use a variable or 2 like:
> > > > 
> > > > our $rcu_trace_funcs = qr{(?x:
> > > > 	rcu_read_lock_trace |
> > > > 	rcu_read_lock_trace_held |
> > > > 	rcu_read_unlock_trace |
> > > > 	call_rcu_tasks_trace |
> > > > 	synchronize_rcu_tasks_trace |
> > > > 	rcu_barrier_tasks_trace |
> > > > 	rcu_request_urgent_qs_task
> > > > )};
> > > > our $rcu_trace_paths = qr{(?x:
> > > > 	kernel/bfp/ |
> > 		^^
> > 	kernel/bfp/ |
> > 
> > (umm, oops...)
> > I think my original suggestion works better when I don't typo the path.
> 
> Color me blind!  ;-)
> 
> That works much better, thank you!  I will update the patch on my
> next rebase.

As shown below.  Is this what you had in mind?

							Thanx, Paul

------------------------------------------------------------------------

commit 496aa3821b40459b107f4bbc14ca867daad21fb6
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jul 6 11:48:07 2023 -0700

    checkpatch: Complain about unexpected uses of RCU Tasks Trace
    
    RCU Tasks Trace is quite specialized, having been created specifically
    for sleepable BPF programs.  Because it allows general blocking within
    readers, any new use of RCU Tasks Trace must take current use cases into
    account.  Therefore, update checkpatch.pl to complain about use of any of
    the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
    
    [ paulmck: Apply Joe Perches feedback. ]
    
    Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
    Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
    Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
    Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: John Fastabend <john.fastabend@gmail.com>
    Cc: <bpf@vger.kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..a67e682e896c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7457,6 +7457,30 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_trace |
+			rcu_read_lock_trace_held |
+			rcu_read_unlock_trace |
+			call_rcu_tasks_trace |
+			synchronize_rcu_tasks_trace |
+			rcu_barrier_tasks_trace |
+			rcu_request_urgent_qs_task
+		)};
+		our $rcu_trace_paths = qr{(?x:
+			kernel/bpf/ |
+			include/linux/bpf |
+			net/bpf/ |
+			kernel/rcu/ |
+			include/linux/rcu
+		)};
+		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
+			if ($realfile !~ m@^$rcu_trace_paths@) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {

