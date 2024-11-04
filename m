Return-Path: <bpf+bounces-43973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C19BC164
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA541C21E6E
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B641FDFA5;
	Mon,  4 Nov 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7qlqngr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD33C6BA;
	Mon,  4 Nov 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762865; cv=none; b=Z1Qp4x0P7nK1CJ7gMcR9lklc4rvPTF+sW3joHTegwBXHIgPV3RWuve6Ga3nKPRNt72xHBubaXwg4yJctlVPrJ0uqBA6dfc1OLUGbvxU6ZGbWqJ+2sQSGLIjHx56uFIJopwxriURLop1DMmZV8U9RCqbkuZUg5ioIY5CbUX3ddxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762865; c=relaxed/simple;
	bh=eJE0p80D+T3UvwAPfjYdm4dQfV/JHA4oN4J3eSvWb3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddKXS20tDuyvwhIDHxUPWveWe9bZv09n9klp8E/T8pfNAszjHBp/G61jII09F+d5CjqI7JIHy8nQZOR+Teg0DWu21TC1iOEoj8NKY77shoVmvXtjirUaaFGjxmJxYnAoDJmeYmV7jqFtoh90x/nt49kraZLpP1zWd0qNLDYbDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7qlqngr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B829BC4CED1;
	Mon,  4 Nov 2024 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730762865;
	bh=eJE0p80D+T3UvwAPfjYdm4dQfV/JHA4oN4J3eSvWb3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7qlqngrtdkOAwNOIsMxxe+dYaUBO2X5GMoy+pVhG+R3rnds/8XURvZShUEMjNu1N
	 6aBFNnuMzgEerGxRWNOdbnZ/osDjgsCsaYl4am8bVABUBxfHanMAlfDk99xqNFaXuH
	 EcsIH1tmxXmCVkGYcBjv2Dp1USX5M2Bnwxy9BbdGI38lfilA+uyTc5+3ugjPrYK9mi
	 K7VZLFnWEwFYtGPUZoZZhMJEGl8KnvOvistMuWyaACYyt/mTf5s42DAMyB9ZcrZjiS
	 NsnMmPMc+wfiZM9FLg76cMOzX92SvDpy+l6hmQPBAYPEeTR+etvH1vFyDPLG25QxiP
	 vNyBGZGudvFew==
Date: Tue, 5 Nov 2024 00:27:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <ZylYbsU7uE7jX5Yd@pavilion.home>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015161112.442758-8-paulmck@kernel.org>

Le Tue, Oct 15, 2024 at 09:11:05AM -0700, Paul E. McKenney a écrit :
> This patch adds srcu_read_lock_lite() and srcu_read_unlock_lite(), which
> dispense with the read-side smp_mb() but also are restricted to code
> regions that RCU is watching.  If a given srcu_struct structure uses
> srcu_read_lock_lite() and srcu_read_unlock_lite(), it is not permitted
> to use any other SRCU read-side marker, before, during, or after.
> 
> Another price of light-weight readers is heavier weight grace periods.
> Such readers mean that SRCU grace periods on srcu_struct structures
> used by light-weight readers will incur at least two calls to
> synchronize_rcu().  In addition, normal SRCU grace periods for
> light-weight-reader srcu_struct structures never auto-expedite.
> Note that expedited SRCU grace periods for light-weight-reader
> srcu_struct structures still invoke synchronize_rcu(), not
> synchronize_srcu_expedited().  Something about wishing to keep
> the IPIs down to a dull roar.
> 
> The srcu_read_lock_lite() and srcu_read_unlock_lite() functions may not
> (repeat, *not*) be used from NMI handlers, but if this is needed, an
> additional flavor of SRCU reader can be added by some future commit.
> 
> [ paulmck: Apply Alexei Starovoitov expediting feedback. ]
> [ paulmck: Apply kernel test robot feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>

This might be a dump question but I have to ask. Could this replace
RCU-TASKS-TRACE?

Thanks.

