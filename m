Return-Path: <bpf+bounces-70499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1723BC150F
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08474F4DE3
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F542DC337;
	Tue,  7 Oct 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpObx7u3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732415FDA7;
	Tue,  7 Oct 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839045; cv=none; b=r6gLI7VzNn1xBAc6MRMbT+NEQ4aIimTlDh2kD+cyKGRmDuBOGByRE0k1t5FeDaDHA23ZVZoNL6hXUvfOvtk+IUuT9nDDPMOMod31905x8/AHjhLclyBjuXGCMnnHg1pitbj9U8JX62/gktbn4c89/m27WsqSSVoCpGDHF6B2Dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839045; c=relaxed/simple;
	bh=BrpAoYMeD5Co96bx3dc6k3rgXLjKV5uVtdex9D1FymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVXIL3bZXLsIs0OpDm9BMasbEOkGJnO8nP5byfPeFCYSUhwX8Zz+FOz7iUlLRZyVszUwhiYve9ZUmpwMNjP/yxmuXlPp2Z0lrwQbHYBetY8JOvBFah4g5hETVsm51YFoymxYA2cKlqZr1/l2tJjzz2AYuwnuR6qjVLtxEG27/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpObx7u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99589C4CEF1;
	Tue,  7 Oct 2025 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759839044;
	bh=BrpAoYMeD5Co96bx3dc6k3rgXLjKV5uVtdex9D1FymQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpObx7u3RJmIFdah+BZNEJDGvKd6Mgdz7sjvUdXVS3MheYpcfCiY95ShU439ui/ca
	 /XZm8TibbTSpuyH7vaRvUwqGCBmjrdehzyJAfEWKUWvObI4fNOkFPJVLlg9rRRU5uL
	 lJWLE2WD7JXwUMrN4P7/j7tcMV8CMdfdhM+f7qFxlkzXMVzF5SlcB1xaEteahQRftW
	 c52FmEBbFxXrglCpSFELv3O4xGyRyBSxrxUVkfAiQ1cjLK19KOnhCa9z+ytYrEGG27
	 /lczvcE2deLgm9STbB+EBiVSvSMFeeRNWpcJ/dv0kBUS7P6FwTLZl8VEEFnm9cRQZJ
	 4/TJ5SjG8Njug==
Date: Tue, 7 Oct 2025 14:10:41 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 02/21] rcu: Re-implement RCU Tasks Trace in terms of
 SRCU-fast
Message-ID: <aOUDQeLtfeoBEPng@localhost.localdomain>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-2-paulmck@kernel.org>
 <aN6eQuTbdwAAhxIj@localhost.localdomain>
 <d24f3987-48de-43e3-a841-2a116ac6d5c7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d24f3987-48de-43e3-a841-2a116ac6d5c7@paulmck-laptop>

Le Sat, Oct 04, 2025 at 02:47:08AM -0700, Paul E. McKenney a écrit :
> On Thu, Oct 02, 2025 at 05:46:10PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Oct 01, 2025 at 07:48:13AM -0700, Paul E. McKenney a écrit :
> > > This commit saves more than 500 lines of RCU code by re-implementing
> > > RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> > > more code that does not cause problems by its presence, but that is no
> > > longer required.
> > > 
> > > This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> > > be removed on common-case architectures in a later commit.
> > 
> > The changelog doesn't mention what this is ordering :-)
> 
> "The ordering that dare not be named"?  ;-)
> 
> How about like this for that second paragraph?
> 
> 	This variant places smp_mb() in rcu_read_{,un}lock_trace(),
> 	which will be removed on common-case architectures in a
> 	later commit.  In the meantime, it serves to enforce ordering
> 	between the underlying srcu_read_{,un}lock_fast() markers and
> 	the intervening critical section, even on architectures that
> 	permit attaching tracepoints on regions of code not watched
> 	by RCU.  Such architectures defeat SRCU-fast's use of implicit
> 	single-instruction, interrupts-disabled, and atomic-operation
> 	RCU read-side critical sections, which have no effect when RCU is
> 	not watching.  The aforementioned later commit will insert these
> 	smp_mb() calls only on architectures that have not used noinstr to
> 	prevent attaching tracepoints to code where RCU is not watching.

Oh I see now. So basically this forces the SRCU-slow behaviour by
restoring the full barriers that are within SRCU-slow's srcu_read_[un]lock()
(can we add a word about that?) for those architectures due to unwatched
RCU sections that can escape the vigilance of the synchronize_rcu() on
the write side.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

