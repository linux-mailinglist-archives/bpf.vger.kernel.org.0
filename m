Return-Path: <bpf+bounces-52777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8259A485C8
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028773AEBF7
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7AF1B4151;
	Thu, 27 Feb 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOKkPpZu"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E61A9B5B;
	Thu, 27 Feb 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675206; cv=none; b=VuGCVzSeRGi1rB+DjxOO0pldP2up2lBif0YKyk9MXLUuJ5jHadEfWZH7XRNxRwNWenetOcSW5Uh7M4QutMwAI7uRam8Ikc7Mp92EHQC0w56QnM6fitpHzUsn8fgqylmd5NUBC4ECngt73mBpznobFi24OXyu6Ia3NTgwm7TSFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675206; c=relaxed/simple;
	bh=ngUTo6dF9F0tDXaqjupgRaWwtDiAGw55L4O6aivUeE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2koa+k8fwEVFpPlCUxy3YIxuFe8McvWKIxPDvRgVFXsZ0HGpiX/FPOpj/RoW7l6yZrwEo1S0VKYA04WO0yNIKd+LLt5tzv7JlH9xbvwJ7l5K6peZvT+rIgLSIt4vJ6DoJ7ONT5qMEht5QJ4i9JyEu/NyLk8bgMgtPfRt8a72XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KOKkPpZu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2Ov/y1t7Dpez9RlDMwDLU2+3BKfoWfwxweNJ4MdRL9s=; b=KOKkPpZuy4OXVvkiO0Y5M/4QeT
	Ks24n3qwEAVTlfVNX9rIPgeZAVBnlpuRscpDSDp5Pj7ScbGAADOXp0BWLAVdsQEUX6O5vJteeLrYA
	jmmpodsZCsX4IuJBMihq4CGBHHX9s8eJ0IpP/cr2aDP5gTKY7I1tQPdD4cBILLtr5OyyJve1RNWST
	5Uw9/bKbqgRQHCmbxkDcc86/cMIXfboUu97s5MXDT4fdDrWsz4SfDfXEGsYxNsxlpuJyq4D87KP8v
	eLljZ6rbbsQLn94dCsPVtry5o5ejVT3fH7Q4HjXZtajayh+M0F0BvcUVmU01ol21kyaBB/EVusWGP
	LfllOMDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnh8B-00000003pRG-0nbx;
	Thu, 27 Feb 2025 16:53:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42319300472; Thu, 27 Feb 2025 17:53:02 +0100 (CET)
Date: Thu, 27 Feb 2025 17:53:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org, rppt@kernel.org,
	graf@amazon.com, dan.j.williams@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <20250227165302.GB5880@noisy.programming.kicks-ass.net>
References: <20250226121537.752241-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226121537.752241-1-dongml2@chinatelecom.cn>

On Wed, Feb 26, 2025 at 08:15:37PM +0800, Menglong Dong wrote:

> In x86, we need 5-bytes to prepend a "mov %eax xxx" insn, which can hold
> a 4-bytes index. So we have following logic:
> 
> 1. use the head 5-bytes if CFI_CLANG is not enabled
> 2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING is not enabled
> 3. compile the kernel with extra 5-bytes padding if
>    MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled.

3) would result in 16+5 bytes padding, what does that do for alignment?

Functions should be 16 byte aligned.

Also, did you make sure all the code in arch/x86/kernel/alternative.c
still works? Because adding extra padding in the CFI_CLANG case moves
where the CFI bytes are emitted and all the CFI rewriting code goes
sideways.


