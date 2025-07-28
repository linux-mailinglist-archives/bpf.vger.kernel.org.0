Return-Path: <bpf+bounces-64538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFAB13F99
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AD5188574B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A527465B;
	Mon, 28 Jul 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQTwXJa/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E725CC7A;
	Mon, 28 Jul 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718934; cv=none; b=EbjlaLvpo+8+Q63qbtmAPDBc/tqpb6wN37EbePqphWO3IzA0Z/IzhRLQXXMtkgjyIKLnPO8rsOGe80CVIoKrUW7F2IeOWMcRIN/Zf3YfTkYwEWyXK02vHGkRQyCfvuAio8FEjv1Z4rOIqvSZsxPStMiHXGIXbWJeAxVVOhcQplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718934; c=relaxed/simple;
	bh=HiesmTZ2yB5O4VLxOWHX+QKKFmse2BkqqRoFJlU9l+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEmdd0m5hW4bGAJ7HOsc/y7ZVHmmoACtni4GT9WJIsPWaSFtOXtb5irqniFfBQn84cjLK1VHYMpc65G2FoLu5n3ooA1y+1acVpb8z66dyxDgc72RdUm/JR8A9vMS+YLVr7fIKrCW0aLC3LPFeGCLbchCsK8N6LuAPRc160ecCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQTwXJa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFEC4CEE7;
	Mon, 28 Jul 2025 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718931;
	bh=HiesmTZ2yB5O4VLxOWHX+QKKFmse2BkqqRoFJlU9l+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQTwXJa/XAi9azm1KG0DTbvOhHZCE4iPjJcCj7YdthE9cecCSnl1yKHvHsB7W+PIp
	 aCtb5KlpYJeAusTstNezphBYJLWLMIOR+xrsrJkXTDwX4p665eAzEOlKhfPntTZdie
	 csQeuyGjDfFWgrz/CufDKWH+DETGP3DTrdRK4hdLxpcysE1085YOCEUpLsqgZcV4q8
	 MF3e0eHl8vEbBrb3T4RzLjRmLN+nfJrteF5LDbzKLiABmI5KM1TKZsGPwJ8VppwFuj
	 xNGqSm+fa2fNvSQm6gZ2kL5L28/l4DnGhdsN5SBJaLJXaaqtrfwbdvYX1Uk32tNR3F
	 wRU4rkXhnl/2A==
Date: Mon, 28 Jul 2025 12:08:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v15 01/10] unwind_user: Add user space unwinding API
 with frame pointer support
Message-ID: <20250728120847.0fd1c190@batman.local.home>
In-Reply-To: <5fb8ada0-d90c-4a58-a38d-97b3d0787554@linux.ibm.com>
References: <20250725185512.673587297@kernel.org>
	<20250725185739.233988371@kernel.org>
	<5fb8ada0-d90c-4a58-a38d-97b3d0787554@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 17:24:52 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> 
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>

Thanks.

> 
> > diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c  
> 
> > +static int unwind_user_next_fp(struct unwind_user_state *state)
> > +{
> > +	struct unwind_user_frame *frame = &fp_frame;  
> 
> Optional: Pointer to const?

Hmm, yeah, and we can easily make fp_frame a constant as it's only
updated by the arch macro and never modified.

> 
> > +	unsigned long cfa, fp, ra = 0;  
> 
> Nit: Is initialization of ra really required?  I don't see where ra
> would be getting used without being set beforehand.

That's probably leftover.

These are minor changes, I'll update.

Thanks for the review.

-- Steve

