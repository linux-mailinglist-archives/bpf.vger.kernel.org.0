Return-Path: <bpf+bounces-68781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B557EB84BCC
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1087A5185
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B093081DD;
	Thu, 18 Sep 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NpLQ5586"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADFD3081CD;
	Thu, 18 Sep 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200754; cv=none; b=T8j6xKxHe2QKTMx8hlTqwnhKkMeGsllkyaHsrzgxjdWaYzhPS5Lf61NH+VQ8U067dDyAq5yoHSnUP3uo+xPzBdNnaqTyqbVpI8aK5B2rNeaK7Reud1LmjUFQoaP3Fkyi+SiL/aITohNTovz7JD/rzP/b7EYG4ud1ap+WhA1j0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200754; c=relaxed/simple;
	bh=XoYGtPHukdd25GBUBWtfnmJWMGcLVLP9TqwVDZmOWf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyQcKnybnFbfQnVWJCGNcXnH66Y9pUwSPIvHVZcfV6XC+zgZZv9ImaENdKXUh/070WISzYP5fu+jDR+MxuCvIViMOi45k/9ep5keM0TOr2QYp5kA5o9NYqd+jzCfcIfUKb3Rcg705xFnu30Qj5LiGvy0ggWyJvv3w6zwtIp5if8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NpLQ5586; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2OUKW+7mtsPUgfqsMcetzwE/6SVcXcNuSgS0ac5rs4c=; b=NpLQ55866HVrCy1XxWWFmQmaaV
	FVnLaQJCteP1u8utacN0kRyKyLASkIoT1IMF62GdhVFV7jHWVwcehpxNSFhH8NJlLGbZY5nl9C/Kd
	/xnwr1rN7u3RNEjZNPXTlZB7D/QMxMSWukuxPGuyKd9d5ARqLSiGOXceRFCHbphrX7AXE8PiBRUjH
	AuxY+yppN40JlHpf57phP2MfdXJupB2i09mLtLVgA1wJOeR6ZOCNfdVgLYZQu0B2ggoirPk28RaAI
	Ei8Ef8Z1jIBbnJdtqjAuUdjVt3M9vPAFczZXTlEQVpIm+JopE9KzvC1ACSUmn1/3cQEJCHnQw47PH
	cEQOfWpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEKW-00000007bxb-2wZx;
	Thu, 18 Sep 2025 13:05:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E98D3003C4; Thu, 18 Sep 2025 15:05:43 +0200 (CEST)
Date: Thu, 18 Sep 2025 15:05:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kees@kernel.org, samitolvanen@google.com, rppt@kernel.org,
	luto@kernel.org, mhiramat@kernel.org, ast@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918120939.1706585-1-dongml2@chinatelecom.cn>

On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> kprobe_multi_link_exit_handler -> is_endbr.
> 
> It is not protected by the "bpf_prog_active", so it can't be traced by
> kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> make it notrace.

This is very much a riddle wrapped in an enigma. Notably
kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
cryptic next line sufficient to explain why its a problem.

I suspect the is_endbr() you did mean is the one in
arch_ftrace_get_symaddr(), but who knows.

Also, depending on compiler insanity, it is possible the thing
out-of-lines things like __is_endbr(), getting you yet another
__fentry__ site.

Please try again.

