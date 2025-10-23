Return-Path: <bpf+bounces-71970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D1C03761
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 202FA4EB397
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5126B2AD;
	Thu, 23 Oct 2025 20:54:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DD1B4F09;
	Thu, 23 Oct 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252896; cv=none; b=Z8dMjXDsESzwgR5dmxMiAIa6xRn2JjPGCnQxmlHbFb+9NZuMbZQTgINa/UUWC7EEdHyiXOoyqupkSYSGxcU309yaejiThGQiNnjhWM/Dwn+c1kSUkET8Bpybj9lf9P1w2Y9DBgpb1dynA4IvACwzd66BfN6OtzJZ0L5+a6ySwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252896; c=relaxed/simple;
	bh=DMEixaf3rj9woCMmMxcBPBt9tGKvn7f5eUpKXutyxdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhoXmenSaVkzr6olB46pYs8cFfewXXSs2IByG9aJvN4eYyj78PB8eAWBmEo1G8CKQLPf7fkiojN4nVylqM7Tf1Irm5ZE1nUUYh0AJR8BmENWQaowXpOOUhtfsK9g84Kn1mbj5ddPhujt4cfROTZrFhnNm1TaCSPNHre633PIhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C2EF31A0C79;
	Thu, 23 Oct 2025 20:54:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 71D8820015;
	Thu, 23 Oct 2025 20:54:43 +0000 (UTC)
Date: Thu, 23 Oct 2025 16:55:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org,
 bpf@vger.kernel.org, jpoimboe@kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <20251023165505.2f325e44@gandalf.local.home>
In-Reply-To: <aPqTIDSHOSTiwYA6@krava>
References: <20251015121138.4190d046@gandalf.local.home>
	<20251022090429.136755-1-yangfeng59949@163.com>
	<aPjO0yLCxPbUJP9r@krava>
	<20251022102819.7675ee7a@gandalf.local.home>
	<aPlBcKq7S-bD3B56@krava>
	<20251022171711.5c18f043@gandalf.local.home>
	<aPqTIDSHOSTiwYA6@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hxdrsbgow999kmgy5sz5ygmnfqdcie1c
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 71D8820015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19k57hAUA/xdA6ev4IUI2JRlw4hOJMFpbE=
X-HE-Tag: 1761252883-565492
X-HE-Meta: U2FsdGVkX1/+KJQ+5IKWnxdTiqA6QoBlSv5CGKiCgLYY17EmbgVz62G/pQDBaknXxgD8z0d7gGVTXnkn6jM6I55ZKB8lHJOdVl7C2QgDNlOIqKweRTQuebiyQE1YjMAXM59rZyijAmKrnDJRFXJrz5AWGNbbrD/Oj4bvnUCJ7BrdoKWlmWbvl/fu8J5qvIBFaoAh2FDJS7YTjo7eWBVB8fvar2zaORJg7W9mL8gRKrzvhOiXgUHQtfZDN/wWhNs9/TX5EL4wxakSE887/XYT7c54Xmt7iPvdQnbIrCou8U1HEy9ZWlHbW2pEbM1+2vmGwlHfUjwLZzUdioNivnqj3k2BWhTpNNzC

On Thu, 23 Oct 2025 22:42:08 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > > > > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> > > > >  	movq %rax, RAX(%rsp)
> > > > >  	movq %rdx, RDX(%rsp)
> > > > >  	movq %rbp, RBP(%rsp)
> > > > > +	movq %rsp, RSP(%rsp)
> > > > > +	movq $0, EFLAGS(%rsp)
> > > > > +	movq $__KERNEL_CS, CS(%rsp)    
> > > > 
> > > > Is this simulating some kind of interrupt?    
> > > 
> > > there are several checks in pt_regs on these fields 
> > > 
> > > - in get_perf_callchain we check user_mode(regs) so CS has to be set
> > > - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set  
> > 
> > So this is a different issue. I rather have this added in
> > kprobe_multi_link_prog_run as its the only user of it. Or have the  
> 
> there's also fprobe tracer that probably needs it as well
> 
> > ftrace_regs conversion update it. This isn't something that should be done
> > at every call and slow everyone else down.  
> 
> I think it's ok, but not sure where to get rsp value at that point,
> perhaps we could just use the pt_regs address

Oh, rsp is fine to add, as that's one of the items expected for
ftrace_regs. It's the flags and CS that isn't needed.

-- Steve

