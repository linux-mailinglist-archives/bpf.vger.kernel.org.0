Return-Path: <bpf+bounces-74518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0777C5D76B
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2C064E9938
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98131C595;
	Fri, 14 Nov 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bmmnRfk8"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75831B82E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128753; cv=none; b=GSm9h1AlI2LVpfLlkFwE4eLMB15ZLi4gR2y7vvia1AvcAQ/PnvLP79l+WlONUPqQcevIkexVoR0URKsW6D/1y7aSTFLiYxbrGDjC+fHzXLy0/1a0Z+zruPuIv0boChPbPrUJnfbJlDNCtxWzUw6UeLmHCi4qQMWfFutHryzwlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128753; c=relaxed/simple;
	bh=+2xXoxcrj33LVtF+hB/b2Rh2JNRUywbpIspebsMHDz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIAi+BsyBJEdO5O/IW3wFk/2lOH2DuGvy5RDUtL/zXGR6h6ya5VQA7NvFzOJ3r0ALyo/zbVJByhhmXBT5s2zr19HEZfSryulXVoulpaJdyR5WTY2ysilnRvwX0WwHI2CScbwQkq9oWKwZShKU+VF4RU27OMROQjKTFKVTn8Tq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bmmnRfk8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763128739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toKX1URGmb2SbH2LNgIDppLk/rcSMomN2gf7jmelaI4=;
	b=bmmnRfk8NTffIOKE8mprer3zreew1THAFTUqHfBYnrK+3C/yNLhJrreDQJZLqVcrr0CBeu
	a8+pxSyyRFMqtqPP63xNbi1chfBnR0n+hV3LcQJI8Fe7EP3s3tzUS+vtRfx/u2pL6tLsZN
	6TcPb4V992uFsaqQ5z11L170K8RJM/U=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/7] bpf trampoline support "jmp" mode
Date: Fri, 14 Nov 2025 21:58:34 +0800
Message-ID: <117548898.nniJfEyVGO@7950hx>
In-Reply-To: <20251114083835.553c9480@gandalf.local.home>
References:
 <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114083835.553c9480@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/14 21:38, Steven Rostedt wrote:
> On Fri, 14 Nov 2025 17:24:43 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
> > Alexei in [1]. And the logic will become this:
> >   call foo -> jmp trampoline -> call foo-body ->
> >   return foo-body -> return foo
> 
> This obviously only works when there's a single function used by that
> trampoline. It also doesn't allow tracing of the return side (it's
> basically just the function tracer for a single function).

Hi, Steven. I think you misunderstand something? For the fentry/fexit,
the whole process is:

call foo -> jmp trampoline -> call all the fentry bpf progs ->
call foo-body -> return foo-body -> call all the fexit bpf progs
-> return foo.

The "call foo-body" means "origin call", and it will store the
return value of the traced function to the stack, therefore the
fexit progs can get it.

So it can trace the return side with the "fexit". And it's almost the
same as the origin logic of the bpf trampoline:

call foo -> call trampoline -> call all the fentry bpf progs ->
call foo-body -> return foo-body -> call all the fexit bpf progs
-> skip the rip -> return foo.

What I did here is just replace the "call trampoline" to
"jmp trampoline".

> 
> Is there any mechanism to make sure that the trampoline being called is
> only used by that one function? I haven't looked at the code yet, but
> should there be a test that makes sure a trampoline isn't registered for
> two or more different functions?

As for now, the bpf trampoline is per-function. Every trampoline
has a unique key, and we find the trampoline for the target function
by that key. So it can't be used by two or more different functions.

If the trampoline need to get the ip of the origin call from the stack,
such as BPF_TRAMP_F_SHARE_IPMODIFY case, we will fallback to the
"call" mode, as we can't get the rip from the stack in the "jmp" mode.
And I think this is what you mean "only work for a single function"?
Yeah, we fallback on such case.

Thanks!
Menglong Dong

> 
> -- Steve
> 
> 





