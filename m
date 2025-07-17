Return-Path: <bpf+bounces-63576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75CFB0868B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773D04E72B2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2D21D3F3;
	Thu, 17 Jul 2025 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6dfZrAV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4721D5B0;
	Thu, 17 Jul 2025 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737091; cv=none; b=LHj2Re8nOrpasU2hBp7SVhbsXNplORHpVy+XrQ1G6tRcI/gGl1CgEls/dCq/ys/3hjOWxIkoBxQ2vv1P0T5hIpnjDe4rD5c8OHM2sn7y9A0yf4C6DD6qXdvz0QWwwtO8hzFsMDj+U5DFCCQyRLr72hfaQ72/HwtOJ1lqKxpzhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737091; c=relaxed/simple;
	bh=929KbXUPXACh93kQSzm9b1rwUVdY2PY9ZRX82BKdOQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvin4VNmM1S3IrgqLmv8q1rrLpCFql4l/6tKL7n40S0TN0MAm0480p7UiL+j16w/w3+upNjbowgKi5wVkhaFc4C7Da7TyQ65p1573Kw2oRsemRnWUEJZEk/lVb6pEy4wnhiP2w+7d8YJvcIjnhjwr2gftObpjOjwkVEFDRuV/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6dfZrAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87CFC4CEE3;
	Thu, 17 Jul 2025 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752737090;
	bh=929KbXUPXACh93kQSzm9b1rwUVdY2PY9ZRX82BKdOQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6dfZrAVm08fIw62akYC5vJYeA14Ihb4Jz0enr7mbPn8ZW5B6C7maKQsJZEBAuzIt
	 kgfSltatVsv90x5uui0a/9wPAKxyxBgbhpEQBTAiyR1CbxUB/INBoe2K+oUc3/ZpSe
	 oDaDXhWX1Yc/Uv9wsai7/w50F1t7RhlKP7lx8LzzKiOHG1xWMqmObOeQKLe4hHNuEh
	 SksxYLXQdl2jti9/Y1kOeVtLGy9GBZEDoL79BbJRUJ4booy1eyABOgBS1nWwaueiEp
	 DT2jEshBz62IytD2p2zGAjyrWSapGR7zixa+36KMxFEwfI9wucr8eqxgxYMBaafDFT
	 3XeHuWTKXqZGA==
Date: Thu, 17 Jul 2025 00:24:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP
 in other registers
Message-ID: <nunn2n7geqbz7pra6x5wlpqxlqfkrolae22lqerk4klk4wfofy@wx5hquzmi527>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-9-jremus@linux.ibm.com>
 <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
 <20250716235751.119a1273@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716235751.119a1273@gandalf.local.home>

On Wed, Jul 16, 2025 at 11:57:51PM -0400, Steven Rostedt wrote:
> On Wed, 16 Jul 2025 19:01:06 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > > +		if (unwind_user_get_reg(&ra, frame->ra.regnum))
> > > +			goto done;
> > > +		break;
> > > +	default:
> > > +		WARN_ON_ONCE(1);
> > > +		goto done;  
> > 
> > The default case will never happen, can we make it a BUG()?
> 
> Is this really serious enough to crash the system? WARN_ON_ONCE() *is* for
> things that will never happen.
> 
> The only time I ever use BUG() is if it's too dangerous to continue (like a
> function graph trampoline that gets corrupted and has no place to return
> to). In general, usage of BUG() should be avoided.

This is an unreachable code path, but __builtin_unreachable() is crap
due to undefined behavior.  IMO, BUG() for unreachable paths is cleaner
than WARN_ON_ONCE(), but it doesn't matter much either way I suppose.

-- 
Josh

