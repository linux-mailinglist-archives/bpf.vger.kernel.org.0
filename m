Return-Path: <bpf+bounces-75600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38368C8B23C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 18:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00213B8FDC
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2A833CEBC;
	Wed, 26 Nov 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ924q+F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92A23D7CF;
	Wed, 26 Nov 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176956; cv=none; b=YfFms5Cy94CfMWW7JVmsmoa2aLMaaamG40PD90F2msOuujjGI07Y4ZKsH/a8yXKluCe40rpFoRN918Dk0oigHLXhwyfiOzTxt2ojSRpNuSAQKI8DP1k79GEKgIqQOHp/1y8QB2beOfuMCdE9sUvp1XjEkZwTPUajBFtaaPx0cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176956; c=relaxed/simple;
	bh=KFX3HrUItBLEZv0rg0muj3u2zKlko1wUFrN/cQiJ5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmTGhEmzi8lsSQdFyHnbeeO6g2wvwAmlcLzfLmpd2eqWZpPVnhik9oar+tCsqiqbZLxA596Jso/h9/3FYJOm267GxryNbyLhMV05EJCucEHwmEbZw/C1rKr7oP+NpDyfPkNgdMXAsE/gPxg3ViTLnCWTS3fZDtOSpS7hSGlDyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ924q+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626CBC4CEF7;
	Wed, 26 Nov 2025 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764176956;
	bh=KFX3HrUItBLEZv0rg0muj3u2zKlko1wUFrN/cQiJ5ac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fJ924q+F2SmXNbI6dYh+kEkmDp/JIBnVWc5nz7XkMC0Q6jcwhJTq5qYvdHGWvBZwX
	 B+gycpR4Xrnmb+sYVnTNdMtKxEbvmmKOb3bvx0vuLNQEt1SmDpY5vTWmvgUu3VK0bN
	 S0cZfKHBXZtX5LtwEeE9d0mhq3qQ8+lS6n+XN+xmuEh3Gj0hj/Qv6wiLe1a+kZ+7iS
	 tUFfSSX97/JsU6bAsv6LEbQGFLLgAxawt/h7OoELKaLtFKA9rnULExHS7RPGfLsa/t
	 04u/qI+jq3f+ZAiOtkSn+hhdfFEEFlRamZ5a7IvVrCaM/JUP/AHMSxdUHPjNfg6QAf
	 KTMNgahP4sTfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBE03CE0CF0; Wed, 26 Nov 2025 09:09:15 -0800 (PST)
Date: Wed, 26 Nov 2025 09:09:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 14/16] srcu: Create an SRCU-fast-updown API
Message-ID: <9a91159e-4411-443c-b0cc-e0cbc5426b11@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-14-paulmck@kernel.org>
 <aSW6sVkqWh2aGxlK@localhost.localdomain>
 <66ee4f2d-9885-446a-996f-801a1fe62a68@paulmck-laptop>
 <aScJdsi4QNPd-f_2@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aScJdsi4QNPd-f_2@localhost.localdomain>

On Wed, Nov 26, 2025 at 03:06:46PM +0100, Frederic Weisbecker wrote:
> Le Tue, Nov 25, 2025 at 07:54:33AM -0800, Paul E. McKenney a écrit :
> > On Tue, Nov 25, 2025 at 03:18:25PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Nov 05, 2025 at 12:32:14PM -0800, Paul E. McKenney a écrit :
> > > > This commit creates an SRCU-fast-updown API, including
> > > > DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> > > > __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> > > > srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> > > > __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> > > > 
> > > > These are initially identical to their SRCU-fast counterparts, but both
> > > > SRCU-fast and SRCU-fast-updown will be optimized in different directions
> > > > by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> > > > srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> > > > For its part, SRCU-fast-updown will not be NMI safe, which will enable
> > > > reasonably efficient implementations of srcu_down_read_fast() and
> > > > srcu_up_read_fast().
> > > 
> > > Doing a last round of reviews before sitting down on a pull request,
> > > I think the changelog in this one should mention what are the expected
> > > uses of SRCU-fast-updown, since the RCU-TASK-TRACE conversion bits aren't
> > > there for this merge window yet.
> > 
> > The RCU Tasks Trace conversion is helped by RCU-fast.  RCU-fast-updown
> > is needed for Andrii's uretprobes code in order to get rid of the
> > read-side memory barriers while still allowing entering the reader at
> > task level while exiting it in a timer handler.
> > 
> > Does any of that help?
> > 
> > Oh, and commit-by-commit testing passed this past evening, so still
> > looking good there!
> 
> Ok, here is the new proposed changelog accordingly:

Looks good to me, thank you!

Nit:  s/usecases/use cases/

							Thanx, Paul

> ----
> srcu: Create an SRCU-fast-updown API
> 
> This commit creates an SRCU-fast-updown API, including
> DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> 
> These are initially identical to their SRCU-fast counterparts, but both
> SRCU-fast and SRCU-fast-updown will be optimized in different directions
> by later commits. SRCU-fast will lack any sort of srcu_down_read() and
> srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> For its part, SRCU-fast-updown will not be NMI safe, which will enable
> reasonably efficient implementations of srcu_down_read_fast() and
> srcu_up_read_fast().
> 
> This API fork happens to meet two different future usecases.
> 
> * SRCU-fast will become the reimplementation basis for RCU-TASK-TRACE
>   for consolidation. Since RCU-TASK-TRACE must be NMI safe, SRCU-fast
>   must be as well.
> 
> * SRCU-fast-updown will be needed for uretprobes code in order to get
>   rid of the read-side memory barriers while still allowing entering the
>   reader at task level while exiting it in a timer handler.
> 
> This commit also adds rcutorture tests for the new APIs.  This
> (annoyingly) needs to be in the same commit for bisectability.  With this
> commit, the 0x8 value tests SRCU-fast-updown.  However, most SRCU-fast
> testing will be via the RCU Tasks Trace wrappers.
> 
> [ paulmck: Apply s/0x8/0x4/ missing change per Boqun Feng feedback. ]
> [ paulmck: Apply Akira Yokosawa feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

