Return-Path: <bpf+bounces-47773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B39FFF98
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AF1605B9
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F11B85FA;
	Thu,  2 Jan 2025 19:46:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9431A2543;
	Thu,  2 Jan 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847165; cv=none; b=kF9tqkJwo0NoNDppE+3Mh0vxDAZtMP4/u5E+MEY5NFnhR/ELervFdXZWg4T9YNdcsN4Ts5jVRrn77/NeUqwfOtD4W5cRe30L7q2frHm6XVUXGk2tNvH8VSwcPun2wyofdcQMXU1iyPZWUTi7RiP/Z5xeCCp0Ux8BFrDVPbokhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847165; c=relaxed/simple;
	bh=XsN7IfShpCImBEr9aQ3Zbu3bubtDqzCllKm2ic1Qn8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6akTP7P6V02buJmGeuWxr/Gni43q2Bs7RwISaBEIrNrBQHnSnDu+jFnnh6E1Pm79nyYNb6OY0YOJXQPp2utT5y31LYlYvph6tRkl4KgDtfiL1mJygQksKziBr8pP2nPwMvEFowgt2JthFdHfPu6TyjMh6c01pTJHUYEuyRuX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F956C4CED0;
	Thu,  2 Jan 2025 19:46:02 +0000 (UTC)
Date: Thu, 2 Jan 2025 14:47:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250102144718.51689c71@gandalf.local.home>
In-Reply-To: <20250102144553.5b32b0f3@gandalf.local.home>
References: <20250102185845.928488650@goodmis.org>
	<CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
	<20250102144553.5b32b0f3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 14:45:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Why even do that? Why not just make the mcount_loc table be proper in
> > the first place.  
> 
> I was a bit nervous about changing the stop_mcount_loc value. I thought of
> doing that first, but then I noticed that the value is found by looking at
> the System.map file and not from the object itself. Changing it in the
> object will require some more elf parsing. Just zeroing out didn't require
> that.

I could still zero it out, but then change the start_mcount_loc to the
first valid function after the sort. As all the zeros will be at the start.

-- Steve

