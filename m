Return-Path: <bpf+bounces-48793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE3A10AF9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CAE168BF0
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1672159209;
	Tue, 14 Jan 2025 15:36:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADF232422;
	Tue, 14 Jan 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868967; cv=none; b=JMGXP3J0MoN0DiU/VIsMUytwSNicF5Dg5Pp/iRLqzkbJxLZqEkr9sxzR6svBOozXCdH2Y5LBa74tK7+UJI6xYQ7sagO3cZlmz1EbcEFAjkMZZRWEGslXDRV9Ap0FmTVyA7QlfSwuKtWRX41eQE+B9PfMXD9sxwP2E/Fet00eTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868967; c=relaxed/simple;
	bh=5X9rPiPMcC8QnDxsT7VvRd66ywPT8nF3IeunOTErs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn/38N2G+BJGfvD6T1KxVH2leX8AoStE7FuOau+bDozA4rmfAfSAF5V5V4gZCHOSSkNaUhzijBj90cYX/bqTLmVEV+FipNN71+PYJvxMst1mZazOYtme6ahrPmOZaAlcVWREOlYp/DMnLs/nnV128Xx+oFt2UUt49rTcQe+MzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E158BC4CEDD;
	Tue, 14 Jan 2025 15:36:03 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:36:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Laight <David.Laight@aculab.com>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-ID: <20250114103604.7388352c@gandalf.local.home>
In-Reply-To: <Z4Z1MoJV0WW-vIHp@krava>
References: <20250114140237.3506624-1-jolsa@kernel.org>
	<20250114141723.GS5388@noisy.programming.kicks-ass.net>
	<Z4Z1MoJV0WW-vIHp@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 15:31:14 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> > IIRC this is the magic recipe blessed by both Intel and AMD, and
> > if we're going to be changing this I would want both vendors to sign off
> > on that.  
> 
> ok

Right. In fact Intel wouldn't sign off on this recipe for a few years. We
actually added to the kernel before they gave their full blessing. I got a
"wink, it should work" from them but they wouldn't officially say so ;-)

But a lot of it has to do with all the magic of the CPU. They have always
allowed writing the one byte int3. I figured, if I could write that one
byte int3 then run a sync on all CPUs where all CPUs see that change, then
nothing should ever care about the other 4 bytes after that int3 (a sync
was already done). Then change the 4 bytes and sync again.

I doubt the int3 plus the 4 byte change would work, as was mentioned if the
other 4 bytes were on another cache line, another CPU could read the first
set of bytes without the int3 and the second set of bytes with the update
and go boom!

This dance was to make sure everything sees everything properly. I gave a
talk about this at Kernel-Recipes in 2019:

  https://www.slideshare.net/slideshow/kernel-recipes-2019-ftrace-where-modifying-a-running-kernel-all-started/177509633#44

-- Steve
 

