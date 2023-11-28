Return-Path: <bpf+bounces-16042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60727FBA00
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D05282AC1
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6C524B6;
	Tue, 28 Nov 2023 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR7f6n2P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA44F8B0;
	Tue, 28 Nov 2023 12:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635FCC433C8;
	Tue, 28 Nov 2023 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174173;
	bh=DXX2yyZV07cfawdxMHdycC1Xx/lp1zrsIhlOIBHIVfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RR7f6n2PxMOFQyeu21keut9EcMLkqoasl9Ot7S6MYIuDmXdN7qJFnhMFTdg9149fh
	 ZDIVdt9H2VRkT/IG4BODcbsU4p6fZpPOBnPWHcgaciDqy8WPkhBb3nA4yjZ9NEeXVT
	 BNYi3bnu+jQmW+pfEMn/iEqxAmXUQnAOBC9nuRzGuazCVbAXDSFw6OWq6mdxYiBVXk
	 ekKVhu3U61kQtNIgMwHyXrTVZyi34aXbyirKMFFV5OgkLLVacqKt0Pl8sUHNi8NSVo
	 a7gUBUmY5uyb6Ufob/2svRwgGwXSRaSSIvXLrkNaWYYTM5YgPUyhOHOcqW2PvNcdSq
	 6N9PG+K4PW4tg==
Date: Tue, 28 Nov 2023 21:22:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 28/33] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20231128212246.db6a3dafdab190cc745c4364@kernel.org>
In-Reply-To: <ZWXGn3_5pN-0fniR@krava>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
	<170109352014.343914.17580314660854847955.stgit@devnote2>
	<ZWXGn3_5pN-0fniR@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 11:53:19 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Nov 27, 2023 at 10:58:40PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Rewrite fprobe implementation on function-graph tracer.
> > Major API changes are:
> >  -  'nr_maxactive' field is deprecated.
> >  -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
> >     !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
> >     CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
> >     on x86_64.
> >  -  Currently the entry size is limited in 15 * sizeof(long).
> >  -  If there is too many fprobe exit handler set on the same
> >     function, it will fail to probe.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Update for new reserve_data/retrieve_data API.
> >   - Fix internal push/pop on fgraph data logic so that it can
> >     correctly save/restore the returning fprobes.
> 
> hi,
> looks like this one conflicts with recent:
> 
>   4bbd93455659 kprobes: kretprobe scalability improvement

Thanks for reporting!

I also found some other patches conflicts with recent commits.
Let me rebase it on the recent branch.

Thank!

> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

