Return-Path: <bpf+bounces-75481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E56C85D82
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1723B3151
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90131F75A6;
	Tue, 25 Nov 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpYFi2we"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AE33EC;
	Tue, 25 Nov 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086074; cv=none; b=pB4k8DHb6BosGvZnFoIQrqHfdHHh86Qopm7PkAae2ZnODIwmCei8qJickI8DgmJXSwWLvDBVyP1SAkFkOl2GZwlTK/FMLD3d+0kHs0s2y0O9dGuzgiP/LCFbRyhkdaeYEoObwdmluVpjz0SGSKWz5f4p6K6OUssXQ3kKqrPbd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086074; c=relaxed/simple;
	bh=/1h1VYbrYNzBYIqQdBlD6r0tXJeO6FafIYOEpA3+jck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJAwJraQ5zyAydQPIYFUjaY/Z65ZIU5hmjR0hi6WlcZDtowFXbcmNp0+iTT1hQFx4Eo4jRaJm2M8p+fQib59eu4SIO+usJfdyKBGmUauC3ToLfcuVduuY9wUdendobJFXRnEnPVP/toRFVh6pIH1mXGfcju0ttJfffyVBeG2mps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpYFi2we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAECC4CEF1;
	Tue, 25 Nov 2025 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764086073;
	bh=/1h1VYbrYNzBYIqQdBlD6r0tXJeO6FafIYOEpA3+jck=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tpYFi2we3t4CAmOY3dOSJYIe/gYcnk0MHPfVpJzyxhxb/mDsxyFWgkFqSsUZFxFOB
	 J+gLgVfm52fZzZBuk5Pkgbh9fEqeJgOONZHzAWpomrsla8bZ+mopjVrOCsUNsYlcur
	 HXAXNO0BK3ZVENGHIdxDz53TBNooJajtE+yb+JTX0dQpipxuuHd9bXpfh8LMgIxii5
	 uN3py8Sr/UEJKwgpMFcSTBAzaQj0ywD6RGc3MLX2i1ANgzJGpvgHkPpMM7NLs9KrKI
	 G0ogg6jZ88zsAdqIaNH2W4+dnoFeHH06wPUqhSlLotEd3wjx5EVwfSAYwe6aZ1QEys
	 qs8xEkYsgb3Rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4465ACE0B2E; Tue, 25 Nov 2025 07:54:33 -0800 (PST)
Date: Tue, 25 Nov 2025 07:54:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 14/16] srcu: Create an SRCU-fast-updown API
Message-ID: <66ee4f2d-9885-446a-996f-801a1fe62a68@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-14-paulmck@kernel.org>
 <aSW6sVkqWh2aGxlK@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSW6sVkqWh2aGxlK@localhost.localdomain>

On Tue, Nov 25, 2025 at 03:18:25PM +0100, Frederic Weisbecker wrote:
> Le Wed, Nov 05, 2025 at 12:32:14PM -0800, Paul E. McKenney a écrit :
> > This commit creates an SRCU-fast-updown API, including
> > DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> > __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> > srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> > __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> > 
> > These are initially identical to their SRCU-fast counterparts, but both
> > SRCU-fast and SRCU-fast-updown will be optimized in different directions
> > by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> > srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> > For its part, SRCU-fast-updown will not be NMI safe, which will enable
> > reasonably efficient implementations of srcu_down_read_fast() and
> > srcu_up_read_fast().
> 
> Doing a last round of reviews before sitting down on a pull request,
> I think the changelog in this one should mention what are the expected
> uses of SRCU-fast-updown, since the RCU-TASK-TRACE conversion bits aren't
> there for this merge window yet.

The RCU Tasks Trace conversion is helped by RCU-fast.  RCU-fast-updown
is needed for Andrii's uretprobes code in order to get rid of the
read-side memory barriers while still allowing entering the reader at
task level while exiting it in a timer handler.

Does any of that help?

Oh, and commit-by-commit testing passed this past evening, so still
looking good there!

							Thanx, Paul

