Return-Path: <bpf+bounces-60295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC21AD48F2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7D11899FF3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73ED2253B5;
	Wed, 11 Jun 2025 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4vzEaIt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03BEAC6
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610159; cv=none; b=GXjXJmKRqR0LXViob9sdplanrCLsIa+qHuGqYU0A82H5tfasb/Y3uAbpCO3/XZ4PORStbjPrXB4B6pIjeRiDE6uGCdVSas06he1++xZH7PjBCZI2UPzJTcGPKXWWaEr+DKD3UewwcdYXwyF+F3pC1stvQ38tYZzPKw/zzjVyuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610159; c=relaxed/simple;
	bh=pzZwJBxgFRuefzbF28IxJfQgjsgnPiRnf3S8igsvcek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTtqYzO4RoJ/q1JyMhtCj+E6pZz3Fl4NhQ7uqBmXBdmsN947sg7a4skNMVgkaL21cj40nPmjN4JcAlz58UuCvVMXADsp92SobBxFQJO91yTxeJzEUczdsb5hp+Aby0ey2bZ22E9bpyJl2Q0w5OuQp4ChefFT6BrfyFECrDx1I4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4vzEaIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0595C4CEED;
	Wed, 11 Jun 2025 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749610157;
	bh=pzZwJBxgFRuefzbF28IxJfQgjsgnPiRnf3S8igsvcek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4vzEaIty6IYgT/cI6WOpu0XygRuPcUNcylgXR/1qYPpz06M4XU56ACHE5vhmEMPZ
	 0VPYyAfrMDurmCf5eHZgMZJMqpzR4VZ1mQ76G+0I1MgLimD8OJ+6Kz3piboGduX/04
	 yfcoZyWvB6Gp0qVmDFfyIAx/tujPh3Y7pq1uPok5L1l5YZZ+3knYfCCIkvJhtRECXC
	 vdW/CyOMchBZddAdGwJiqZqBcnTWf3vWOTJeuyOfh8ooeSCOyh1IbTaDZs+nSRj7yI
	 nxtfnIXZkYRS+U74g+0lBuGcneFRBghz5x4L9Xayh2+nZPtKSpnocO1puPqHZl+pwj
	 XKecLU+wwRoDw==
Date: Tue, 10 Jun 2025 19:49:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: bpf-restrict-fs fails to load without
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS on arm64
Message-ID: <20250611024913.GA1554554@ax162>
References: <20250610232418.GA3544567@ax162>
 <CAADnVQ+jNQyC=RcoiwDXeHj9y6CGzr322scz_8uGwCDVx-Od4Q@mail.gmail.com>
 <20250611020522.GA3981304@ax162>
 <CAADnVQKTGgBGgqfVsDGxijuL1oVkBOhmgx+0XQ+VOL4wLoVKYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKTGgBGgqfVsDGxijuL1oVkBOhmgx+0XQ+VOL4wLoVKYw@mail.gmail.com>

On Tue, Jun 10, 2025 at 07:25:52PM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 10, 2025 at 7:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Tue, Jun 10, 2025 at 04:37:24PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Jun 10, 2025 at 4:24 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > I was able to figure out that enabling CONFIG_CFI_CLANG was the culprit
> > > > for the change in behavior but it does not appear to be the root cause,
> > > > as I can get the same error with GCC and the following diff (which
> > > > happens with CFI_CLANG because of the CALL_OPS dependency):
> > ...
> > > > -       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> > > > -               if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
> > > >         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > > >                 if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
> > > >                     (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> > > >
> > ...
> > > That's expected.
> > > See how kernel/bpf/trampoline.c is using DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> > >
> > > Theoretically we can make bpf trampoline work without it,
> > > but why bother? Just enable this config.
> >
> > As I note above, this is incompatible with CONFIG_CFI_CLANG, which is
> > more important for my particular area of testing and maintenance. Since
> > you note this is expected, I will just go back to ignoring the warning
> > in my kernel logs :) thank you for the quick response!
> 
> Somebody probably needs to fix CFI_CLANG on arm64 then.
> It's not clear to me why dynamic ftrace has to be disabled in such a case.

Commit baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
says:

  Currently, this approach is not compatible with CLANG_CFI, as the
  presence/absence of pre-function NOPs changes the offset of the
  pre-function type hash, and there's no existing mechanism to ensure a
  consistent offset for instrumented and uninstrumented functions. When
  CLANG_CFI is enabled, the existing scheme with a global ops->func
  pointer is used, and there should be no functional change. I am
  currently working with others to allow the two to work together in
  future (though this will liekly require updated compiler support).

Mark, did anything ever come to fruition from the "currently working
with others to allow the two to work together in the future"? If you
need more context, the top of the thread is
https://lore.kernel.org/20250610232418.GA3544567@ax162/.

> It's not disabled for CFI_CLANG on x86, right?

No, it is not but as far as I can tell, DYNAMIC_FTRACE_WITH_DIRECT_CALLS
on x86 does not appear to depend on DYNAMIC_FTRACE_WITH_CALL_OPS like it
does on arm64.

Cheers,
Nathan

