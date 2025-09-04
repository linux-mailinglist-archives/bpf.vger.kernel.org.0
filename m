Return-Path: <bpf+bounces-67508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B504B448DF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EDE487F2E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F382D3731;
	Thu,  4 Sep 2025 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M75pr3by"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A992D29D1;
	Thu,  4 Sep 2025 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023119; cv=none; b=s/276ZktDlq/ihS9AVTuNr7k77bto9TFYn7HaSZZ5cHoG9dlvmVOk2oQbdHLHwYrmitHI7SeNVvwj3LN7JitqCQs8GZlbz0igM/X1ydGZmrtHosOR7cO0tSqClCA/jpWc0l4uR0b4II4xoadfoLiX2YIuWikFK+hqToSq07EDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023119; c=relaxed/simple;
	bh=XO8WZINynQgmZfSo94ZUS6S6SF7wC9xPOk3/UAzmkLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHD5X/n43uXdISiNNpspDLOUHvQ+ovyGm0e+VJXBpekvbyElSA6NLM3kGLv6dMkCr6ZWaTmRkD0bhyL+tziYOBssbHO1DiJgDevEqXqi0DAKqV31VbE4KZyRZgGrZJeSD9okUtM+FwhqQHn9hd+DShO/Yhaf1RrXObvtrrkC+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M75pr3by; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XO8WZINynQgmZfSo94ZUS6S6SF7wC9xPOk3/UAzmkLM=; b=M75pr3byL832PdpshCIPZ+R8Gt
	KJppvaAElDHXklMlWWs+FUpb5fgz8H+64NqO7FjxUsu0pjL0i5vsmqJpBEX1N1HREB9IUQ7Vje9EI
	NGVKkavc35qe6+GmU4O2kQ3aX3ZNuV63QSiIh4N984DBYJdufC5lMM/ATBxcYmiQg5l8FZQQ77cQG
	7FitSN14LNFMVcN1enk2gIrnp2AYl6qTITJdj/SRjYLOyC/ufw2pEEC0QxV9IA53zq4YLOMUVnMO9
	Hq+JLqgHZq6ZGYYD9cAXuo+U3fErgyGX+HW/1WZLlU9CRHplfgfyJFIGDtsTZBbihMloZIQwCupWT
	7rzDtP5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuHyN-00000004QEk-1Dye;
	Thu, 04 Sep 2025 21:58:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DA79300220; Thu, 04 Sep 2025 23:58:26 +0200 (CEST)
Date: Thu, 4 Sep 2025 23:58:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
Message-ID: <20250904215826.GP4068168@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
 <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
 <20250904215617.GR3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904215617.GR3245006@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 11:56:17PM +0200, Peter Zijlstra wrote:

> Ooh, that suggests we do something like so:

N/m, I need to go sleep, that doesn't work right for the 32bit nops that
use lea instead of nopl. I'll see if I can come up with something more
sensible.

