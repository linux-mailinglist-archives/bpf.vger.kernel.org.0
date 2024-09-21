Return-Path: <bpf+bounces-40158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5D697DCC8
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFADCB219EF
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1745155398;
	Sat, 21 Sep 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3FHvzc5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432D2032A
	for <bpf@vger.kernel.org>; Sat, 21 Sep 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726912838; cv=none; b=oMV2zDyQ+7pv6AoEKWLRtU6529oMknLQP+ewfMi39qltkBA0C++jh41o5jzjlx+fogdfVljv2osGdfaPjCLpfF9bpe6G7FsmFQgwK1nIeklhf9MUG77VyRZxVerkRlTUluCW7/7XXBtDJsb6rTNGzeXLBm5CUX7WJ2mYXLXgkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726912838; c=relaxed/simple;
	bh=q2wHv4FCoFIAzTSDcslj2kIS0GpvdJWpKnhS1C31XY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hfsBfqEu1+6EnFGkmnj3AbZxz/wlva8B3cTrjmgIx8vIfKoTDLoBapmcR1QNE8nPXN/lASvg1gjyVgKhg9ro2X2Nyo+xbtX4uvEW3UXtGGk2iAlx9yUGV4EXkzFLN1gvbtmIa7HxcNLURDPS3SxDMneGlW/0Owb3mPRtzpzKlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3FHvzc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFE5C4CEC2;
	Sat, 21 Sep 2024 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726912837;
	bh=q2wHv4FCoFIAzTSDcslj2kIS0GpvdJWpKnhS1C31XY0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=r3FHvzc5c07DFRo8cuvX+pB68wWsBpNoAX+JC+iQV0E+qnphZpGriFS7dCWqDqeae
	 wWFTVhmvFqnjuW7gydGGfKLPGIsTKT+zrgfTvQdT12Kn5vVL0rdzZ8R9BYMWWCUaSd
	 AhoN/GVmfsgnI67bI3wvMW89G0gO3hdWT7fYtacsL373mZbZYzzudVZrTN5oAN3ERk
	 dHutRBfUYe2qdTIOyaDB4NnJ45FNiPywjiC6zxOlA6afijoopRQ90YIOdftgpZ0Pm1
	 lfP/wmDNIpU+AiAOeJQ6Jgi8zoLGiqKWRxU2vQa+JhdxHOAa9pAUizJAs4FTTyM0ch
	 NIuiHHqO3FV2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 37044CE0DFD; Sat, 21 Sep 2024 03:00:35 -0700 (PDT)
Date: Sat, 21 Sep 2024 03:00:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: ast@kernel.org, will@kernel.org, puranjay12@gmail.com
Cc: bpf@vger.kernel.org
Subject: Summary of discussions on BPF load-acquire instruction ordering
Message-ID: <75d1352e-c05e-4fdf-96bf-b1c3daaf41f0@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an attempted summary of the discussions on the memory-ordering
properties of the upcoming BPF load-acquire instruction.  Please reply
to the group calling out any errors, omissions, or other commentary.

TL;DR:  I am sticking with my position that the BPF load-acquire
instruction should have the weaker RCpc semantics (like ldapr, not ldar).
That said, it is entirely reasonable for ARM64 JITs to use the stronger
RCsc ldar instruction to implement the BPF load-acquire instruction.

Background and details:

o	The BPF load-acquire instruction might have RCsc ordering (like
	the ARM64 ldar instruction) or RCpc ordering (like the ARM64
	ldapr instruction).  One key difference between ldar and ldapr
	is that the ldar is ordered against prior stlr instruction,
	but ldapr is not.

	Note well that there is only the one ARM64 store-release
	instruction, stlr.  This instruction pairs equally well with
	ldar and ldapr.

o	The stronger semantics for the ldar instruction were added on
	the advice of Herb Sutter of Microsoft.  The weaker semantics
	for ldapr were added on the advice of other Microsoft employees
	who actuallly write performance-critical concurrent code,
	but for mid-range CPUs that do some reordering but not so much
	speculation.  (High-end CPUs that do serious reordering and also
	serious speculation don't usually care much about the difference
	in ordering semantics, outside of benchmarks specially crafted
	to demonstrate the difference.)

	(Perhaps of historical interest, this mirrors the advice for
	C's and C++'s non-SC atomics.  Herb passionately advocated
	for atomics to be only SC, but an even more passionate group
	elsewhere within Microsoft reached out privately to register
	support for non-SC atomics in the strongest terms possible.
	So C and C++ had non-SC atomics from the get-go.)

o	The compilers do not guarantee RCsc, only RCpc.  Attempts to
	provide stronger (and thus perhaps more expensive) RCsc
	semantics for the BPF load-acquire instruction can therefore
	be defeated by perfectly legal and reasonable compiler
	memory-reference-reordering optimizations.

o	The ARM64 ldar instruction was available first.  This means that
	any ARM64 JIT that emits ldapr for BPF load-acquire instructions
	must be prepared to emit ldar on older ARM64 hardware that does
	not support ldapr.

o	If BPF is to JIT efficiently to PowerPC, BPF's load-acquire
	instruction must be implementable as ld;lwsync.  This has similar
	RCpc memory-ordering semantics as ARM64's ldapr instruction.
	In contrast, an RCsc load-acquire instruction (like ARM64 ldar)
	would require sync;ld;lwsync.  The difference is that the sync
	instruction has global scope (its action covers the full system),
	while lwsync can be handled within the confines of the CPU's
	local store buffer.  The sync instruction is thus considerably
	more expensive than is the lwsync instruction.

o	The fact that the Linux kernel runs reliably on PowerPC when using
	"ld;lwsync" for smp_load_acquire() provides evidence that ARM64
	could safely use ldapr for smp_load_acquire() in common code.
	However:

	o	The fact that older hardware does not support ldapr
		and the fact that distros strongly prefer a single
		Linux-kernel image per architecture means that use
		of ldapr for smp_load_acquire() would likely require
		yet more boot-time binary rewriting, and might restrict
		migration of guest OSes from one ARM64 hardware system
		to another.

	o	There might well be uses of smp_load_acquire() in ARM64
		architecture-specific code that need to emit the stronger
		ldar instruction.

	o	There are way more ARM64 systems than PowerPC systems.
		It is entirely possible that PowerPC is just getting lucky
		with its use of "ld;lwsync".  However, this applies to BPF
		programs just as surely as it does to core Linux-kernel
		code.  Risk of failures due to use of the weaker RCpc
		instruction sequence is lower on PowerPC than on ARM64.

o	All this leads me to stick with my position called out in TL;DR
	above, namely that the BPF load-acquire instruction should have
	the weaker RCpc semantics (like ldapr, not ldar).  That said,
	it is entirely reasonable for ARM64 JITs to use the stronger RCsc
	ldar instruction to implement the BPF load-acquire instruction.

Thoughts?

						Thanx, Paul

