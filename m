Return-Path: <bpf+bounces-47653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C109FCFE2
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 04:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38321882D2D
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD694595B;
	Fri, 27 Dec 2024 03:45:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CCF4F1;
	Fri, 27 Dec 2024 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735271125; cv=none; b=F4L8wYGmUhPvvlp2hbLsT3ZudcMK769vjAlihoDovjLwWV1wQEW8QKGuXeGyo3yl/5McLq++DNstbb5D7OIdSb4zwgYJ5HOaUIZRj1Dgpswk2tFiY62v++YghBVbUv3G1ccl7jKQB9uF0LhgWfaiKbRKcNMBp5Su7s5QMo8LR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735271125; c=relaxed/simple;
	bh=BHFNRIy84ix+cmpRswqeg1N+pU50oo8r026fuQsgnl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO/x142/lw89LS1qaaSZBjHiKSHt4yMa5nVqRAeW9Fnf6InQkoGQAy/2dZr+pSctqcjOGOWUziY0ILWeac97KmLWvsJDchmvZTlBlQCoL6GQCBqAyNFBV8GZB1gnnItLjxPVVa8QGdClz9/GjtzGmouDq9esTQbW6/22ngm1Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D65C4CED0;
	Fri, 27 Dec 2024 03:45:23 +0000 (UTC)
Date: Thu, 26 Dec 2024 22:45:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng
 Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in
 kallsyms
Message-ID: <20241226224521.2d159a02@batman.local.home>
In-Reply-To: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
References: <20241226164957.5cab9f2d@gandalf.local.home>
	<CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 19:35:18 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 26 Dec 2024 at 13:49, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But then, when the linker removes these functions because they were
> > overridden, the code does not disappear, leaving the pointers in the
> > __mcount_loc locations.  
> 
> Btw, does this actually happen when the compiler does the mcount thing for us?

Yes.

I believe the issue is that the mcount_loc is created during the
compile phase, and it just points to the call to fentry/mcount. The
linker phase doesn't remove the code, just the symbols that are
overridden. That means the pointer to the fentry/mcount calls still
point to the same locations, as the code is still there.

I even sent an email about this to the gcc folks, and Peter responded
basically explaining the above.

  https://lore.kernel.org/all/20241014210841.5a4764de@gandalf.local.home/

-- Steve

