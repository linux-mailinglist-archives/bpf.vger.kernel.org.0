Return-Path: <bpf+bounces-6715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A876CF92
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C55281DEF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD9879F5;
	Wed,  2 Aug 2023 14:07:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AE7488
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DA2C433C9;
	Wed,  2 Aug 2023 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690985264;
	bh=bJNValHUjzspsGmERMVn8LUzA2cKwOnf4DUJY1j/1pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDfKnaHt6TLKDIdJzeXIdoYUzA1Y9aEHuYTtsjNqmDcueBDleqo9LzmIqenZP41As
	 ESe1I5Outu5972eAywedMd0nX/Ut3onQEahHL7SIXffjYjWwIp5MmeDoR4F7eirofW
	 o5y5H329SMBec4sTvZ77TD9PJ/kK39Gf6LJ+Kb1lsTc1euM65Pe8O7cphvu2D11mJp
	 txoXyXBMjZrianJSkzdmxfO+kOd44W6ATTTTDUUr5MWFbGdp+AJxjL2t0lnLqzathT
	 sKyPuu9hf+ED/nJiPlcoZ+F+uh8jDm+bxcrDogP/CtJfUav2ZEPmxieevybBNFtmWI
	 es49ti3hgnRgg==
Date: Wed, 2 Aug 2023 23:07:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Florent Revest <revest@chromium.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230802230738.2b22cef561feb5d498f22f49@kernel.org>
In-Reply-To: <CAADnVQLkVatr5BTScpuKaKAO+Cp=0KVxhqXwsjZoGhJPu3G4jA@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
	<20230801113240.4e625020@gandalf.local.home>
	<CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
	<20230801190920.7a1abfd5@gandalf.local.home>
	<20230802092146.9bda5e49528e6988ab97899c@kernel.org>
	<20230801204054.3884688e@rorschach.local.home>
	<20230801204407.7b284b00@rorschach.local.home>
	<CAADnVQLkVatr5BTScpuKaKAO+Cp=0KVxhqXwsjZoGhJPu3G4jA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Aug 2023 19:22:01 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 5:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 1 Aug 2023 20:40:54 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Maybe we can add a ftrace_partial_regs(fregs) that returns a
> > > partially filled pt_regs, and the caller that uses this obviously knows
> > > its partial (as it's in the name). But this doesn't quite help out arm64
> > > because unlike x86, struct ftrace_regs does not contain an address
> > > compatibility with pt_regs fields. It would need to do a copy.
> > >
> > >  ftrace_partial_regs(fregs, &regs) ?
> >
> > Well, both would be pointers so you wouldn't need the "&", but it was
> > to stress that it would be copying one to the other.
> >
> >   void ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs regs);
> 
> Copy works, but why did you pick a different layout?

I think it is for minimize the stack consumption. pt_regs on arm64 will
consume 42*u64 = 336 bytes, on the other hand ftrace_regs will use
14*unsigned long = 112 bytes. And most of the registers in pt_regs are not
accessed usually. (as you may know RISC processors usually have many
registers - and x86 will be if we use APX in kernel. So pt_regs is big.)

> Why not to use pt_regs ? if save of flags is slow, just skip that part
> and whatever else that is slow. You don't even need to zero out
> unsaved fields. Just ask the caller to zero out pt_regs before hand.
> Most users have per-cpu pt_regs that is being reused.
> So there will be one zero-out in the beginning and every partial
> save of regs will be fast.
> Then there won't be any need for copy-converter from ftrace_regs to pt_regs.
> Maybe too much churn at this point. copy is fine.

If there is no nested call, yeah, per-cpu pt_regs will work.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

