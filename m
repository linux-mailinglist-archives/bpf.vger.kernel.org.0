Return-Path: <bpf+bounces-49269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3FA15EC5
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE453188610D
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F81D5AAC;
	Sat, 18 Jan 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtMbsZ0i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB239FD9;
	Sat, 18 Jan 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737232264; cv=none; b=embSyOge5vSR1GZFoTQlGm5mhUUPrg2obdtRIvu46lf2zfvZD2iZMdqeSOPVbTMQie+thrqlaP7Lo3CviuXGpVifwCiPsQ9CvZy3tnRz1DH3ec+pOt1O1tjCaMcIMdvuGkuKl7pY6eN1fgDFQtiD2aBnst4gAlwDJ0+ZBmmMvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737232264; c=relaxed/simple;
	bh=MZrHWiRV2/BnFWUZFWDxPeV3m7UYFq8iAi09JtGU2gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSb9ABxEZvg7Bnn3VMW3RiKaBx5QHjd9lWA9fM59YJF+iJtY7SNx4QQ8FJoQg5KhQL0ndq7qwyYO+mcTnLTebNZj8OYLQ3LWPE5xuIiM7w92SaNypUZdH05fYQaZJrNoRsjr6mI0zL+ByVKsnRfx50t6GbjChBJxKLhJmx9iE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtMbsZ0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB6C4CEE0;
	Sat, 18 Jan 2025 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737232263;
	bh=MZrHWiRV2/BnFWUZFWDxPeV3m7UYFq8iAi09JtGU2gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtMbsZ0iKiLg0PFkIYyPbMffVasUvZZ15IP+nViZvcpP+kHi/Qt6Xd+w+baRWEFTa
	 N6pm9Fugov5obHGeW+N2A5/FhlKzwxyInMrFc3mNoxukl3eMQt4Ryeb4xq1SDEmAyC
	 AoVlJFcdiYbOpV4eM1f01TGj4HFa1FPQfpwwnO8O+vKsQQe8IvEhoMvBFAPf7vLTD8
	 DbMOr53mM8v+Uemv24S0RfF2A14zrrsaJxnW/YnBmZL8oVGDSl0zoTuTnCIpciN7YZ
	 a/kHPKUFsT87/bsCxVK10Oe8sSnvc344mr1gdpSsFMwtFAt+F7krAfBpc9QQ0FSiuS
	 onFKvrFOa1l0g==
Date: Sat, 18 Jan 2025 12:31:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>, luto@amacapital.net,
	wad@chromium.org, oleg@redhat.com, ldv@strace.io,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250118203102.GL3557695@frogsfrogsfrogs>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501181212.4C515DA02@keescook>

On Sat, Jan 18, 2025 at 12:21:51PM -0800, Kees Cook wrote:
> On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> > Since uretprobe is a "kernel implementation detail" system call which is
> > not used by userspace application code directly, it is impractical and
> > there's very little point in forcing all userspace applications to
> > explicitly allow it in order to avoid crashing tracked processes.
> 
> How is this any different from sigreturn, rt_sigreturn, or
> restart_syscall? These are all handled explicitly by userspace filters
> already, and I don't see why uretprobe should be any different. Docker
> has had plenty of experience with fixing their seccomp filters for new
> syscalls. For example, many times already a given libc will suddenly
> start using a new syscall when it sees its available, etc.
> 
> Basically, this is a Docker issue, not a kernel issue. Seccomp is
> behaving correctly. I don't want to start making syscalls invisible
> without an extremely good reason. If _anything_ should be invisible, it
> is restart_syscall (which actually IS invisible under certain
> architectures).

I was wondering that too -- if ______'s security policy is to disallow
by default, then fix the security policy.  Don't blow a hole in seccomp
for all users.  Maybe someone *wants* to block uretprobe.  Maybe doing
so will be needed some day as a crude mitigation for a zeroday.

--D

> -Kees
> 
> -- 
> Kees Cook
> 

