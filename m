Return-Path: <bpf+bounces-43977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711009BC214
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92705B2168B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105BF9E6;
	Tue,  5 Nov 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAUmDYxd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00F1FC3;
	Tue,  5 Nov 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767170; cv=none; b=QxiB/lTBjCTUgGF3Nyl8LuDlNBOep9YI505NmShucG0P+migFNe1IG1rtIvmcAjdsZqWDQXPe2rJ7h7jVmI/SfynlR7aiLeu0NT55JcMKc2cgW2F1DOaAqEPtMuXOPsDGa4LDvfypthxeLQLNZe/iH+X5NUNVmjkgmGaHtHyMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767170; c=relaxed/simple;
	bh=xfCaDzMNCkWjtvVW63wVhxSTIXKN+FNrDvQ4Cfad98E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Jiwdi5WAw6ZujBy4vxr0IIvq3baT4vIICzq7N+NCH0FHezLCd7k1WZFsW8k+YiwjqQ20ToFKwe5K4sToyTbpfyoER/7dPFx5Rw57CVT76Dm32Zno/+tIH3LZbzzVskVJKS+1dCRshQNgIiqZLswMZBm4A0fZOk/C+GY0QQme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAUmDYxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31CEC4CED1;
	Tue,  5 Nov 2024 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730767169;
	bh=xfCaDzMNCkWjtvVW63wVhxSTIXKN+FNrDvQ4Cfad98E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GAUmDYxd0aAvkPOgtywrDqq+i0iIiVdmO3HP0UqS/edVUwZ+E1jTWIS/MdiLi9d/P
	 VbZNLgyjVgZx+ePOeHkiW2TF9H2YAXkRDSshBJi4e3T17lBybisI9q+mYW8lsURaf7
	 WuStRV6MYM/+yCf35uzHwBLeiZpALXzl2cZwcxJ7VtnSX/D3/u6br0IsezX0gcBSkz
	 amTg6vwNHyKHpCt6trcKreUE4Y3nuuGwvRkhnl29/xVTVmV9dGD/7icLtOKdeCmAIl
	 UAP78UDhbLSwJwMW9LQSjdv8zmhLFqhM02DZLZVx5AHvkYzqVRdimlvhJwfjlZMCA6
	 g5PJsc2j4jYhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 71D04CE093C; Mon,  4 Nov 2024 16:39:29 -0800 (PST)
Date: Mon, 4 Nov 2024 16:39:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <53397727-66c2-4517-9f95-cae073e80744@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org>
 <ZylYbsU7uE7jX5Yd@pavilion.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZylYbsU7uE7jX5Yd@pavilion.home>

On Tue, Nov 05, 2024 at 12:27:42AM +0100, Frederic Weisbecker wrote:
> Le Tue, Oct 15, 2024 at 09:11:05AM -0700, Paul E. McKenney a écrit :
> > This patch adds srcu_read_lock_lite() and srcu_read_unlock_lite(), which
> > dispense with the read-side smp_mb() but also are restricted to code
> > regions that RCU is watching.  If a given srcu_struct structure uses
> > srcu_read_lock_lite() and srcu_read_unlock_lite(), it is not permitted
> > to use any other SRCU read-side marker, before, during, or after.
> > 
> > Another price of light-weight readers is heavier weight grace periods.
> > Such readers mean that SRCU grace periods on srcu_struct structures
> > used by light-weight readers will incur at least two calls to
> > synchronize_rcu().  In addition, normal SRCU grace periods for
> > light-weight-reader srcu_struct structures never auto-expedite.
> > Note that expedited SRCU grace periods for light-weight-reader
> > srcu_struct structures still invoke synchronize_rcu(), not
> > synchronize_srcu_expedited().  Something about wishing to keep
> > the IPIs down to a dull roar.
> > 
> > The srcu_read_lock_lite() and srcu_read_unlock_lite() functions may not
> > (repeat, *not*) be used from NMI handlers, but if this is needed, an
> > additional flavor of SRCU reader can be added by some future commit.
> > 
> > [ paulmck: Apply Alexei Starovoitov expediting feedback. ]
> > [ paulmck: Apply kernel test robot feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <bpf@vger.kernel.org>
> 
> This might be a dump question but I have to ask. Could this replace
> RCU-TASKS-TRACE?

From a purely functional viewpoint, yes, but even without that smp_mb(),
there are performance issues due to the index fetch, array accesses, and
return value.  Maybe with improved hardware over time this will change,
and if it does, yes, we definitely should remove RCU Tasks Trace in
favor of SRCU-lite.  We are not there yet.

However, it does mean that we don't need to create a new RCU variant
for uprobes, and that has to be worth something.  ;-)

							Thanx, Paul

