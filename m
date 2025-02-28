Return-Path: <bpf+bounces-52869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE38A49744
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D2A1887EC6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978425E444;
	Fri, 28 Feb 2025 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdTrZOol"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB25D906;
	Fri, 28 Feb 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738431; cv=none; b=mH5UgOJ4O+trir9OuATWYlwZv8lX0ULbBXxSjNhwWMsGwPEz/+pER6tiB+Xsqq59voBor7RT4JU8EYe7vFPZeXA7x3guBOlkhDhfOJ1d3LEx1zzUtjHB7f2j4lKK1sOogxk4t7RCux9wWZYzCBVRBUBSo511ItJrFYY082jUXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738431; c=relaxed/simple;
	bh=QipSQKBVejJCm0JiZYKYCgsJZy94yke3ITmWkzu5XgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8jvTXCZWfse/sYYCOOwmaAE5NtQuf6LJKx0DQROdmr/7zBlcZJqWrOcGXAUqvHo4w/I+5GjAHVYOxuryrp5zxMXUTM2SsFvHHte30K1V4cou0y5D+FFKj9pSW61Y9oPHlqmCsg8aGCyUE0kc0aXToJ+Yv3RIevn0c5Jc3Kkjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VdTrZOol; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xe0IQlbdAwSgMC56OTkYAj7JGAZY/mZJvfaM47F/w2M=; b=VdTrZOol5nq1P2coz1iVCItT+4
	pR5MzcGC09roqhfqK5PzlE73GIdGcf4qoGMTOP3BcKz8fZmLmTSBihVsi/57caVeQ9CJyoBiqrlCG
	yaV4YTC+DIfY2uFkIUoMDaGfU7WTzrODI6MDmZ2cRZcSDoKhrEdOy7vAEIEO6fUfQkWEDlPy1+MLs
	2GXohOAJXYEghJd3dvY0+Ak3DKWQIjye5P6/VqlsgR7OcwoMDXKmc9G+cAwxCFwL5eAF5VDwSNovE
	9w327FoUHIejJKRXyZ4wbx6YEu7WMEoGKYmCUbrL9Ca7IleNMkLZwEdcXbfhSHDWXujdo9AL97+eY
	omyUmVvA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnxZv-00000001h1r-1XUt;
	Fri, 28 Feb 2025 10:26:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 893D9300756; Fri, 28 Feb 2025 11:26:46 +0100 (CET)
Date: Fri, 28 Feb 2025 11:26:46 +0100
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
Message-ID: <20250228102646.GW11590@noisy.programming.kicks-ass.net>
References: <20250226121537.752241-1-dongml2@chinatelecom.cn>
 <20250227165302.GB5880@noisy.programming.kicks-ass.net>
 <CADxym3YCZ5dqXMFesNaAF_Z2EWWCj0bJyKQ+BnNw2c=g39CRFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3YCZ5dqXMFesNaAF_Z2EWWCj0bJyKQ+BnNw2c=g39CRFA@mail.gmail.com>

On Fri, Feb 28, 2025 at 05:53:07PM +0800, Menglong Dong wrote:

> I tested it a little by enabling CFI_CLANG and the extra 5-bytes
> padding. It works fine, as mostly CFI_CLANG use
> CONFIG_FUNCTION_PADDING_BYTES to find the tags. I'll
> do more testing on CFI_CLANG to make sure everything goes
> well.

I don't think you understand; please read:

arch/x86/kernel/alternative.c:__apply_fineibt() 

and all the code involved with patching FineIBT. I think you'll find it
very broken if you change anything here.

Can you post an actual function preamble from a kernel with
CONFIG_FINEIBT=y with your changes on?

Ex.

$ objdump -wdr build/kernel/futex/core.o

Disassembly of section .text:

0000000000000000 <__cfi_futex_hash>:
       0:       b9 93 0c f9 ad          mov    $0xadf90c93,%ecx

0000000000000005 <.Ltmp0>:
       5:       90                      nop
       6:       90                      nop
       7:       90                      nop
       8:       90                      nop
       9:       90                      nop
       a:       90                      nop
       b:       90                      nop
       c:       90                      nop
       d:       90                      nop
       e:       90                      nop
       f:       90                      nop

0000000000000010 <futex_hash>:
      10:       f3 0f 1e fa             endbr64
      14:       e8 00 00 00 00          call   19 <futex_hash+0x9>      15: R_X86_64_PLT32      __fentry__-0x4
      19:       8b 47 10                mov    0x10(%rdi),%eax


Any change to the layout here *WILL* break the FineIBT code.


If you want to test, make sure your build has FINEIBT=y and boot on an
Intel CPU that has CET-IBT (alderlake and later).

