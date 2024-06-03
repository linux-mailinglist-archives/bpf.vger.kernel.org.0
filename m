Return-Path: <bpf+bounces-31215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22488D8795
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26541F22985
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C41369B8;
	Mon,  3 Jun 2024 17:04:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46170132134;
	Mon,  3 Jun 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434241; cv=none; b=hbh1K8s6KavBiswKfzXKRs/lMuINH4qLL8ZwIWgSMUnk7CB3cCamIdP8MsbxQVL4o6g0GXHK5NnhEShtz50TNvNeImNMD9n/a5/IHQWhaWENg7ibA3M38vyQkeeKJVYEVl5ldYPc6LPGv3PaO+z3GMJ16a7CfXk6Pcm3FMC/LU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434241; c=relaxed/simple;
	bh=G26QvN9xTTTYABXqFBCt3dCEqPCMNmgVPrxa6IIQpDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E26njBLYYq6NuGzDE2ymP1a0FyyQgcY6s9Q7SKXi83L9c00HPTqnYsTQVnP9m4SzA7Eenglr0GMBbwBqyOBrc33bxfamZIB23taFv6JEppqGGb9cafrm0R4qwIjjr6wcbrZLaiALI6Go4a66fUB+S0+ymczcXb4aJHrdQhQ8noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ADEC2BD10;
	Mon,  3 Jun 2024 17:03:57 +0000 (UTC)
Date: Mon, 3 Jun 2024 13:05:04 -0400
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
Subject: Re: [PATCH v2 10/27] ftrace: Add subops logic to allow one ops to
 manage many
Message-ID: <20240603130504.7c572649@gandalf.local.home>
In-Reply-To: <20240603114636.63b5abe2189cb732bec2474c@kernel.org>
References: <20240602033744.563858532@goodmis.org>
	<20240602033832.709653366@goodmis.org>
	<20240603103316.3af9dea3214a5d2bde721cd8@kernel.org>
	<20240602220613.3f9eac04@gandalf.local.home>
	<20240603114636.63b5abe2189cb732bec2474c@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 11:46:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > at the beginning of the loop.
> > > Also, at the end of the loop,
> > > 
> > > if (ftrace_hash_empty(new_hash)) {
> > > 	free_ftrace_hash(new_hash);
> > > 	new_hash = EMPTY_HASH;
> > > 	break;
> > > }  
> 
> And we still need this (I think this should be done in intersect_hash(), we just
> need to count the number of entries.) 

Ah, I see. if it ends with nothing intersecting it should be empty. I added:

	/* If nothing intersects, make it the empty set */
	if (ftrace_hash_empty(*hash)) {
		free_ftrace_hash(*hash);
		*hash = EMPTY_HASH;
	}

to the end of intersect_hash().

-- Steve

