Return-Path: <bpf+bounces-56794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AEA9DCC9
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 20:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19194A1BF5
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8125DB1F;
	Sat, 26 Apr 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxAh0UnN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D51189B9D;
	Sat, 26 Apr 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745693483; cv=none; b=EhkH3uQKZ3a/ADaKYcslf6xwNiGor4Zg/GvDHdBW9Jiu41EMR3G2S1o/2PEXP26T6xe95vHPpjYP6LV1Cf58xnvI6PIn0iIpH6VfAsVGPpGy0qQx3KUqh2jZ7wfPADzad6lbAB/WmlTJJOD3Dx1YuEF8ldazWyiv3gf37z/PnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745693483; c=relaxed/simple;
	bh=Dv0b8I6fjHkXn4VX9Jd5ArqB4oJnp0uQFx77VzaE82w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIeq4lJFB1faGrERFulDRNjGGKj8RghV1iIFXLu8a/jbyCFAR/gnJWmlLymffIwBicr+3PxcW2PrGqIYzuDB5GB+LuyksHskt/qeh5z2okVLp2b7bPOoi7wkYluyI0ZD3pizFA66ziMeSIDqtoinXsQIpdldH9kEDy0JqZ24SdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxAh0UnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E6C4CEE8;
	Sat, 26 Apr 2025 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745693482;
	bh=Dv0b8I6fjHkXn4VX9Jd5ArqB4oJnp0uQFx77VzaE82w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxAh0UnNcv/tJObKhUcAwOl3nhozM2Cu//MOPVFG1osUL8EqAJayVU5kV33F/nprB
	 bTQRdaYd2aMRpViOHn7md3Dh/1sRoC3YcDn14AYKvEn6YGONarCt5roHQIUrLxiZ9l
	 SniLdxUhIr6qhFlRdKUYERirUzIhLzuBQ50ToUCx01+yei3FFdvmxthcpF6+QziAFH
	 GXxD72Z7EgvIucLnD09ydwPtForub2gH/sl1Bdm1+EdeQDPsQ8bXcn4ZZpwvGR6fO3
	 Nkuh7rY0G9lrJHiyGl5NixRrC3PXsgd0jy3P9xGa6XlKvHAZKg0kBxttWn5y0WsJG9
	 JMMhgkAM5Ej5A==
Date: Sat, 26 Apr 2025 20:51:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Kees Cook <kees@kernel.org>, bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: Introduce task_*() helpers for PF_ flags
Message-ID: <aA0rIx11qx1E4ISF@gmail.com>
References: <20250425204120.639530125@goodmis.org>
 <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
 <20250426084320.335d4cb2@batman.local.home>
 <aA0pDUDQViCA1hwi@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA0pDUDQViCA1hwi@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

>  - We might want to add set_task_*() helpers as well, to totally 
>    encapsulate PF_ uses. Maybe. I dislike how close it is to the 
>    existing set_tsk*() methods that manipulate TIF_ flags. The 
>    dichotomy between the TIF_ and PF_ space isn't really sensible these 
>    days I think on a conceptual level - although merging them is 
>    probably not practical due to possibly running out of easy 64-bit 
>    word width.

And yeah, the TIF_ space is per arch to a substantial degree, and is 
accessed from assembly code, plus is often operated on atomically, 
while the PF_ space is nicely generic and non-atomic - but still we 
could do better to express that these two per task flag spaces are 
rather similar in purpose, instead of this historic 'task/process' 
distinction that isn't actually true.

Thanks,

	Ingo

