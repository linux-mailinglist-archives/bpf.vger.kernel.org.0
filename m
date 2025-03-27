Return-Path: <bpf+bounces-54835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD1A73FC7
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865AB17D8E9
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECE1D6DA3;
	Thu, 27 Mar 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IobFMYmC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B41624C2;
	Thu, 27 Mar 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109023; cv=none; b=BUzsbPonVCSfdM7HU3hucoY3AOI++MvHRpwK6CerwcKn8Ghs4z0YP1JbeBjCQRkKmp71y5iHYo23GvVzK+NQd7eq7jgefJ7dKfGVZas8oOuHfXZ/fMgnVTNtsieHUhWrr8lVK+/O5CPKAvRpcGFe1O9kgxppcLeQkmc8fwxLxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109023; c=relaxed/simple;
	bh=k965J4r67f9gDf6M03ogXhOMMMJERpqaXsXopGkUyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFnJt6KPjaILho5BkbSAeq8bAihkCKL5tdi+IzHydjgf+Iq9Rd1/0B9a1JOIjpCoPj1lcTa2zZ5ELaEA4Hn5HKRObfYpqK2NKDlK5SCLtLF08HI2bqIZu0gpC95pFNJXCPi3olTdFlx6P0bY2HqvFgrtusl0Tv4daWkZBMc2Udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IobFMYmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E2DC4CEDD;
	Thu, 27 Mar 2025 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743109023;
	bh=k965J4r67f9gDf6M03ogXhOMMMJERpqaXsXopGkUyrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IobFMYmCjS6A956MvZWr9OlF1ezNb0xk5tv0RvQp3a8buZqkAwy7PoL6jMs9ZYQFe
	 El7w1LBGuK7aG3IaVSRYH7QXt+shX4uil8KxhjfEgJJEPhtF5xzZAFcJLcjaSUcnCE
	 qqXumV7+9j5utajJqflF93JPEFLD5oxVPo9BJIS2GjBkQDlMal4f4wpobPFES1B5iM
	 ujUVmGMJa20BojdeiZO8WO2jWq91eIeaD2zMzvZNvsLdjUZJ2IRZb33YRMt0eMWXox
	 SvS/ZeDvuVuAvJGak4rV8ZAHO5+ADFYI3pYWj/3PyF9n5kEPBJJnDG4MgZN+ioSK+u
	 AdF7ElJfOAoIw==
Date: Thu, 27 Mar 2025 21:56:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-W7mRAkMfFyJ6sE@gmail.com>
References: <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
 <20250324113304.GB14944@noisy.programming.kicks-ass.net>
 <Z-JsJruueRgLQ8st@gmail.com>
 <20250325103047.GH36322@noisy.programming.kicks-ass.net>
 <Z-KS7H6666PZ3eKv@gmail.com>
 <20250325123119.GL36322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325123119.GL36322@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 25, 2025 at 12:26:36PM +0100, Ingo Molnar wrote:
> 
> > Yeah, so I do know what #BP is, but what the heck disambiguates the two 
> > meanings of _bp and why do we have the above jungle of an inconsistent 
> > namespace? :-)
> > 
> > Picking _int3 would neatly solve all of that.
> 
> Sure; the most obvious case where BP would make sense, the trap entry
> point, we already use int3 so yeah, make it int3 throughout.

Okay - I just sent out a series to do this. Found a few other things to 
fix/improve along the way:

	https://lore.kernel.org/r/20250327205355.378659-1-mingo@kernel.org

Thanks,

	Ingo

