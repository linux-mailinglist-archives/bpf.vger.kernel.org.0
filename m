Return-Path: <bpf+bounces-52661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E369EA466B6
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B329D4408B0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406821D59E;
	Wed, 26 Feb 2025 16:11:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22121CFF4;
	Wed, 26 Feb 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586278; cv=none; b=ajW0F5q6At6ON3axbPTretv4CXqCPlAhkbcgn1ELu+IttIbIIn0IkZMefJGSpxPanMGKNrWOq/bY+MX9YIHqozf1JwdMJB10WLvCWszU8neWYgzMCVaPvA7QBhQ3zCRv8ibWWyrh3dLNR1GZnTP8jMoeo7Ws8POoa3U7qI+wAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586278; c=relaxed/simple;
	bh=ROz9XuGNvnoBJA3+2RuGgf4Sy1IM+BhZiK6em0GKSIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZQUV06MeagB1QUVlhig3E3VnnCH5v1s8gg08/tFzCR2gEa1xL2GE2aWoTX8k+Ki4LEtCFujGsxPkLBGJtNwBHIgVb2mruuQFmbjTNafJoxhaUyleQuABMbzKh0c4uief0jZymGnVkkNLutvybYiDQ558WwrnKP1I5nayXT/+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40363C4CED6;
	Wed, 26 Feb 2025 16:11:16 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:11:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250226111156.3e9bb653@gandalf.local.home>
In-Reply-To: <20250226234852.5b6d2c34ef02d3e9a4b80d4e@kernel.org>
References: <20250225222601.423129938@goodmis.org>
	<20250225222653.724198940@goodmis.org>
	<20250226234852.5b6d2c34ef02d3e9a4b80d4e@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 23:48:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > -	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
> > -					  sizeof(*entry), trace_ctx);
> > +	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
> > +	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));  
> 
> Is `!!fregs` always 1 if fregs != NULL? (seems to depend on compiler)

Yes, C guarantees that ! is either 1 or zero. If you want to convert
something from non zero to 1, the C convention is "!!".

> 
> Others looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thanks!

-- Steve


