Return-Path: <bpf+bounces-74529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124FC5E46B
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08D73A5D9D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AA32826E;
	Fri, 14 Nov 2025 16:28:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF35283CBF;
	Fri, 14 Nov 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137692; cv=none; b=u7OaXYkDZYhQMDOiSu+4V2WyUnrgf1Gvy818MRadHNaLZcLrHnqGoJ6T2+/92p0krkaDCUGUBDGUuzeNekT2QWqLPYpPAFMed9ZGosEckEcnKTCzBK2h60Zao3LsRLr9GA2BrylZK/m5dLl4q0yAs+PAPIXiIvmmIQsqPyhgcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137692; c=relaxed/simple;
	bh=QIK9ItLTIk6pAbhauY0sm3JqkjFNJ/8GidbIVaT4+kU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkmPihnNF00nHyrIkbEZ6RnHvfHjOFVvEH8ogNbZHyTAB5H+BojjTQmhL5XQV1E6kTi4SSBLHEk164qUCGTzZedNY2j072TR0L3ZBVdfh59Yg6tttnVcY89qW8anK/EPIvkcGzIYTK2uqSEk71lyHuS0UW37VhMRzh70wC5cepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8160012DA72;
	Fri, 14 Nov 2025 16:28:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 5F2B52002D;
	Fri, 14 Nov 2025 16:28:03 +0000 (UTC)
Date: Fri, 14 Nov 2025 11:28:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/7] bpf trampoline support "jmp" mode
Message-ID: <20251114112821.39da4d91@gandalf.local.home>
In-Reply-To: <117548898.nniJfEyVGO@7950hx>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
	<20251114083835.553c9480@gandalf.local.home>
	<117548898.nniJfEyVGO@7950hx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9f44huoa574et3k15s3wmm36yz7rhnz5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5F2B52002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+jFbLuHIU+RkS1gAzenJzlgDHwvz8NYxA=
X-HE-Tag: 1763137683-354947
X-HE-Meta: U2FsdGVkX1/DDua1XMkXhw0u/ANwjsYw00a0sFfg6t+38jP+gJZtEPRMjIzJ5PX6fcBb8VTlLlWqKrgQwhvLmD51WXExn90fhVJBBzlsAp4SiYKjjB8RHb8zQ4O05smIua7aP/n41DeTTlN0swrxTYgwyJ1hF/W7HM3W4TiQ/It3DIPGf2sUc7EEcie5KRLazKLBE9WoZ6vI1ioaCGOc8D485rlu9/jDtoMDAdsy2Sl5Z9AMUTmAuae2I8v3DtSTLy4mdnbUJWqiB4bV3o/7miLn9DL1RJM9TA6ILgfiK8TxEjYSTa3Z0dGMcN1PvEhB2AiltLjnzrqtdH58g5IvZS5HoQHSUCON

On Fri, 14 Nov 2025 21:58:34 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2025/11/14 21:38, Steven Rostedt wrote:
> > On Fri, 14 Nov 2025 17:24:43 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> >   
> > > Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
> > > Alexei in [1]. And the logic will become this:
> > >   call foo -> jmp trampoline -> call foo-body ->
> > >   return foo-body -> return foo  
> > 
> > This obviously only works when there's a single function used by that
> > trampoline. It also doesn't allow tracing of the return side (it's
> > basically just the function tracer for a single function).  
> 
> Hi, Steven. I think you misunderstand something? For the fentry/fexit,
> the whole process is:

Yeah, I got a bit confused by the notation above.

> 
> call foo -> jmp trampoline -> call all the fentry bpf progs ->
> call foo-body -> return foo-body -> call all the fexit bpf progs
> -> return foo.  
> 
> The "call foo-body" means "origin call", and it will store the
> return value of the traced function to the stack, therefore the
> fexit progs can get it.
> 
> So it can trace the return side with the "fexit". And it's almost the
> same as the origin logic of the bpf trampoline:

OK, so this is just the way it always works.

> 
> call foo -> call trampoline -> call all the fentry bpf progs ->
> call foo-body -> return foo-body -> call all the fexit bpf progs
> -> skip the rip -> return foo.  
> 
> What I did here is just replace the "call trampoline" to
> "jmp trampoline".
> 
> > 
> > Is there any mechanism to make sure that the trampoline being called is
> > only used by that one function? I haven't looked at the code yet, but
> > should there be a test that makes sure a trampoline isn't registered for
> > two or more different functions?  
> 
> As for now, the bpf trampoline is per-function. Every trampoline
> has a unique key, and we find the trampoline for the target function
> by that key. So it can't be used by two or more different functions.
> 
> If the trampoline need to get the ip of the origin call from the stack,
> such as BPF_TRAMP_F_SHARE_IPMODIFY case, we will fallback to the
> "call" mode, as we can't get the rip from the stack in the "jmp" mode.
> And I think this is what you mean "only work for a single function"?
> Yeah, we fallback on such case.


OK, I got lost in the notation. It doesn't need a "call" because each
trampoline is only for a single function. Hence it doesn't need to know the
return address.

-- Steve


