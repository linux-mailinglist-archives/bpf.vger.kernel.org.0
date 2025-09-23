Return-Path: <bpf+bounces-69466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20DDB96E54
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A825E32130A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3E242917;
	Tue, 23 Sep 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXFVUQ2n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3C1D5ABF;
	Tue, 23 Sep 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646870; cv=none; b=It2YQH4CC8k0SElaIJ92orL4f3JFu4roC+VmDYbSDrkTtpxjdRZ3oHVtkLJ6lCM5vB1G84r7CoFANsQ7a4hkvQMeWOV/L+YN+1Y/xjmT/H8p5hQkUVJ/3kCJmNlO19OEOQ2qZcZTnzutAc/Hve1ALkoaM4xavA16jwq5dOWLBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646870; c=relaxed/simple;
	bh=lmrO4EM0uSIgPvRyMTakRDy6DZ3TQz0ccaeq5VlOVp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssdxl7wFyKRghR9w+79V6w1l8N2B6GZka2DowxWj/NAWjTkTy+KJYI8gswYV/LNlVBUPHsazwcXQpfppTi0kGyDmv3piR/EQnElpMghCO1dAYNpq3/TmQG4ZbxtHBi+XZFjE5YySx0kPp6NwnKkgcbXXaFprqxKde5k1B9FfOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXFVUQ2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73489C4CEF7;
	Tue, 23 Sep 2025 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758646869;
	bh=lmrO4EM0uSIgPvRyMTakRDy6DZ3TQz0ccaeq5VlOVp8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dXFVUQ2nvAULYrLl1erVJHzt+/3VPF5bm8tjFdQaHFtlXdyvjqNPjfjqjPbsD0xOx
	 Ra/ERhP0xu1FBw/uN1q2Dfe81Pcw3V507dCarYrFetUaPBJVfn4Sy06mmXxLwytW6O
	 Vs4dlUsCBD4V9m32ZQ4ammA2R1WCPug7md1czUx9TVS066f7ycS/LstSRpp3ehHgt6
	 MebbwiG5Lt7C0bXj8j0bl7PUHijlVwEg1vYzq/vNdj/KRWVQ6/c63FUmxr3pBwwqG8
	 2avkQZDJqZxQb1fBDBFSzDoshmpUfy/fBPgbv6vQxB11ronQCiIUVCLLEr241BGjVl
	 D5vyDoBJF4tzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D3C9ECE0857; Tue, 23 Sep 2025 10:01:06 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:01:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 20/34] checkpatch: Deprecate rcu_read_{,un}lock_trace()
Message-ID: <6777d949-e1f7-454d-8c10-247dcbf8c6fa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-20-paulmck@kernel.org>
 <a54094681531e526c7e055cc5f58d0f6d480c119.camel@perches.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54094681531e526c7e055cc5f58d0f6d480c119.camel@perches.com>

On Tue, Sep 23, 2025 at 08:47:13AM -0700, Joe Perches wrote:
> On Tue, 2025-09-23 at 07:20 -0700, Paul E. McKenney wrote:
> > Uses of rcu_read_lock_trace() and rcu_read_unlock_trace()
> > are better served by the new rcu_read_lock_tasks_trace() and
> > rcu_read_unlock_tasks_trace() APIs.  Therefore, mark the old APIs as
> > deprecated.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Joe Perches <joe@perches.com>

Thank you, and I will apply on my next rebase.

							Thanx, Paul

> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  scripts/checkpatch.pl | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index e722dd6fa8ef3d..3bb7d35a5cfcba 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -860,6 +860,8 @@ our %deprecated_apis = (
> >  	"kunmap"				=> "kunmap_local",
> >  	"kmap_atomic"				=> "kmap_local_page",
> >  	"kunmap_atomic"				=> "kunmap_local",
> > +	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
> > +	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
> >  );
> >  
> >  #Create a search pattern for all these strings to speed up a loop below

