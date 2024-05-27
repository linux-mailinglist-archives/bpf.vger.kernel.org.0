Return-Path: <bpf+bounces-30622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276858CF701
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF07A2817A8
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6B1854;
	Mon, 27 May 2024 00:31:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1836C;
	Mon, 27 May 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769903; cv=none; b=auYYkghO9RLqqmx4ZETg9fjPB7v+94XeYzJ0REEgU/NbD0pS89O4+cqAYsIefbMI14XIbl5X9mpEgPc2fyeJGSon6R74MuGyzOsYhVIDTHMXRW8XguapuU29x7elhqPqotiflHgF8IT1bpjZis7SCZBeR54Li8nXqN6NPqVnTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769903; c=relaxed/simple;
	bh=kLapuMVDeL2Hs6Z/9dIbBEZtedR5ElbHgfpMcfi8spE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2bXD1seZ5uKHxPYmpjRP5lQusuj57YKPN7a/PXaINxtyXC8ZafLE/L0dQvWh1h6J96IWDNLKDNtzpXksMwTm3lpsyNrralRJ3/RwNDmVHS5BUGH39m2woPW2crAHJPMVJ31qHv+5nW5JrquzuKYS/YrBOk5iKdKl9aX03Q/al0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8695BC2BD10;
	Mon, 27 May 2024 00:31:40 +0000 (UTC)
Date: Sun, 26 May 2024 20:32:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 19/20] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
Message-ID: <20240526203232.59557382@gandalf.local.home>
In-Reply-To: <20240527090434.37e309d0280d6d8f116edc85@kernel.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023744.231570357@goodmis.org>
	<20240527090434.37e309d0280d6d8f116edc85@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 09:04:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  	bitmap = get_bitmap_bits(current, offset);
> > -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> > +
> > +	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
> >  		struct fgraph_ops *gops = fgraph_array[i];
> >  
> > -		if (!(bitmap & BIT(i)))
> > -			continue;
> >  		if (gops == &fgraph_stub)  
> 
> Ah, nit: maybe this is unlikely()?

Ah probably. I'll update it.

Thanks,

-- Steve


