Return-Path: <bpf+bounces-31201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF18D8587
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB99285179
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654B1304B7;
	Mon,  3 Jun 2024 14:53:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408512FF8E;
	Mon,  3 Jun 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426402; cv=none; b=NK8CoUYG2dTI798b5voazv9IPfhlQPP+1RFmKHPQMzAbWw5oZz2hhmSXPecR779InwrMav0aUIGNnffN8ccbV6Gkg0JUNxjwRSpHniNjMiDMVe4r0/rMukR9zEi0FtjjeNlrovBKu2ABHXu/u55M0LTjesh+AdbwYIYMZIUeD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426402; c=relaxed/simple;
	bh=ljBV8B2zDJ+lremQm3VgudoYU5q/ejgQbLgH5webZSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdcgVSrLSRVnRTH9OfabdgmQBR/D+Z8VBmic/Y7ypx5fnWHhvAWhSbPVExwMI5zEAQJ9fTymUe+EsnT3M8l97Z0l0pbWi3/RsYFwiMYGGnhWpkDcErL2unZJHww5blfsng+oraQR9zHpZqRMxJcT5qSOgAqw6gfzojheGwoDAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B98C2BD10;
	Mon,  3 Jun 2024 14:53:17 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:54:26 -0400
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
Message-ID: <20240603105426.48ed57c4@gandalf.local.home>
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

> > > if (ftrace_hash_empty(new_hash)) {
> > > 	free_ftrace_hash(new_hash);
> > > 	new_hash = EMPTY_HASH;
> > > 	break;
> > > }  
> 
> And we still need this (I think this should be done in intersect_hash(), we just
> need to count the number of entries.) 

Actually, ftrace_hash_empty() may be what I use instead of checking against
EMPTY_HASH. I forgot about that function when writing the code.

-- Steve

