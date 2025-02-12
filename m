Return-Path: <bpf+bounces-51204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF2A31D36
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 05:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965A7165DDF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2691E5707;
	Wed, 12 Feb 2025 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPIDA6ro"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E3271835;
	Wed, 12 Feb 2025 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333114; cv=none; b=MXVpASojqTRrP6WcSvSOW2NKpz4MVd+Ut6TS1kNko4hxEVg4H2ItT67o63wqpfpwiV0Xj/jlNrrv5+JAMNWXrKftja6RUVMVYNEtiPL1f1AJehZNGsjccwcEZuqam85TbX7MD0L7unyg6Mkbxifn4Pjwjt6zUseeIz9fCnhAK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333114; c=relaxed/simple;
	bh=ybIygu13oOH3MI8QbIfsK7m4pRQxcHlQE2MUTFs9fjQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m4ekgV5a1wuf7R7sz3Ssy50LIvyx2/gWOxwyEAAEuqInziP3zN2rkr76+4yFH4KmKnYiq5oTVC3NQYNFD1ZajckTWuABJrBX466SGnfZsrskMtHvVhVtOUUDZeS9dOglhnHX6MNdNSXCepiocDG8j/qy3KZH191Fxi9w8WaZMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPIDA6ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3850C4CEDF;
	Wed, 12 Feb 2025 04:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739333113;
	bh=ybIygu13oOH3MI8QbIfsK7m4pRQxcHlQE2MUTFs9fjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EPIDA6roMboDSVK9Hu+DMva2D4DI1vs1cARp6GDK4B2UlsWiJOvf6Cmrd/HY1pxcM
	 XChqNqjTc1JLVAsyOyv6wrJja4l6ggvaFtGZxp900mpKsLQJBGMvH10kSEf8TMYzUI
	 b7Hqhamm9WhTNgyMFNff6AflhioI1v3WAj0L0cGKrb/Qqn/29w0t+2u8gKv68lVdhv
	 90ST5Aoxlkp8Y1K1aDxeiI0xd8WkpgB0qVrg48B13y3qVRUY3ExcYPVBJU9waGugCy
	 LaiXh9hSos/9iZlc8XxztDvszX94Nc/lcPZQ6Oei/ql1wGUjIgYh36Dukq8nbv7kSM
	 mwc4KLZHdWDCQ==
Date: Wed, 12 Feb 2025 13:05:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Kees
 Cook <kees@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, stable
 <stable@vger.kernel.org>, Jann Horn <jannh@google.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Linux API
 <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>, bpf
 <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Deepak Gupta
 <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall
 trampoline check
Message-Id: <20250212130509.ce1987095c6b17b26d3ee40a@kernel.org>
In-Reply-To: <20250211165940.GB9174@redhat.com>
References: <20250211111559.2984778-1-jolsa@kernel.org>
	<CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
	<CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
	<20250211165940.GB9174@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 17:59:41 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 02/11, Alexei Starovoitov wrote:
> >
> > > > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
> >
> > If you respin anyway maybe use ~0UL instead?
> > In the above and in
> > uprobe_get_trampoline_vaddr(),
> > since
> >
> > unsigned long trampoline_vaddr = -1;
> 
> ... or -1ul in both cases.
> 
> I agree, UPROBE_NO_TRAMPOLINE_VADDR has a single user, looks
> a bit strange...

I think both this function and uprobe_get_trampoline_vaddr()
should use the same macro as a token.
(and ~0UL is a bit more comfortable for me too :) )

----
unsigned long uprobe_get_trampoline_vaddr(void)
{
	struct xol_area *area;
	unsigned long trampoline_vaddr = -1;
----

Thank you,

> 
> Oleg.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

