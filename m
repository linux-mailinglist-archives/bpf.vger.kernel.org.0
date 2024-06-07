Return-Path: <bpf+bounces-31615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D027900955
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFCEB22970
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD51993A9;
	Fri,  7 Jun 2024 15:39:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173C171BB;
	Fri,  7 Jun 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774749; cv=none; b=lMFVMVH/sEhW1Hjf0re0sFCrz9Z0aWRJJXifAzNRnw9lv+wDBTDU4M8igQdrjfV/jkKa1rsq4GvdadwgYdNZvTo4VUPDTvyAR6mY90ZgcF8bCC49U5WhS7YhK53qYnEAhfyC/AFm/sp4bYdXBgq/tBT7pK2Jz7Hmej2GdVf9wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774749; c=relaxed/simple;
	bh=9YBVZftsl8VdYDDyZb7AS5ArgPy58OPMzPr+bbA826A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5Y0+mj+1a/pnRX49KTw08GmBpv+8Dhsjk8XZfavUI/5SOTv++EKsHg0jVoIH857uJoYY2D2GvV3kMIpTEVMy7TnNue/5K3BZhWOgo8Fme5AVyT25fS9d2HgoWXKCS9R0O51GAY3oEnmtT9lCXwuHyZwfvlPPWr3VAObIRTU7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF982C2BBFC;
	Fri,  7 Jun 2024 15:39:07 +0000 (UTC)
Date: Fri, 7 Jun 2024 11:39:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, mcgrof@kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 jpoimboe@kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Message-ID: <20240607113922.17a62f86@rorschach.local.home>
In-Reply-To: <20240607150228.GR8774@noisy.programming.kicks-ass.net>
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
	<20240607150228.GR8774@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 17:02:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > There may be following resolutions:  
> 
> Oh gawd, sodding weak functions again.
> 
> I would suggest changing scipts/kallsyms.c to emit readily identifiable
> symbol names for all the weak junk, eg:
> 
>   __weak_junk_NNNNN
> 
> That instantly fixes the immediate problem and Steve's horrid hack can
> go away.

Right. And when I wrote that hack, I specifically said this should be
fixed in kallsyms, and preferably at build time, as that's when the
weak functions should all be resolved.

-- Steve


> 
> Additionally, I would add a boot up pass that would INT3 fill all such
> functions and remove/invalidate all
> static_call/static_jump/fentry/alternative entry that is inside of them.


