Return-Path: <bpf+bounces-691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A39705D85
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1254280FD2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B893317ED;
	Wed, 17 May 2023 02:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1D17D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81329C433EF;
	Wed, 17 May 2023 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684292078;
	bh=sFe/hVwr1RlqKJNFm/E/CQUy8RQP2QPCq5ps+biUM9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+5EQcDL1aJVnKUa9P7oA57b/J0fhJzeYfjHTKmU/TRp0LWprYJG7s3i3FWeWbRbR
	 X9bJ2KLuZB6L62KxGGDwk739uH0Oh9865Gapt7hV+NuajubaQCh6YPj9tbebJHDEDM
	 m4WRnqNvcl5a8uF/AJsgrjlgrsp316p+SBDagEbisG/VbjrjDb5BpoisrcGEw9u51G
	 c0DhunDC++nODeOS0aUyO8UbMBnjA5G21/4mLTf1ex2oAI9Chbs6Sa/GrxQfBk2sDt
	 jDGp9OjmVhTV+sjsYTUpARxL546bJitU/aBLs7h9L9thv4XQsaKVUXYpHn+8/AZZoU
	 ZMmYifuUoeDag==
Date: Wed, 17 May 2023 11:54:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens
 <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
 <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
 <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
In-Reply-To: <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
References: <20230516071830.8190-1-zegao@tencent.com>
	<20230516071830.8190-3-zegao@tencent.com>
	<20230516091820.GB2587705@hirez.programming.kicks-ass.net>
	<CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
	<20230517010311.f46db3f78b11cf9d92193527@kernel.org>
	<CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 17 May 2023 09:54:53 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Oops, I misunderstood your comments before.
> 
> Yes, it's not necessary to do this reordering as regards to kprobe.

Let me confirm, I meant that your current patch is correct. I just mentioned
that kprobe_busy_{begin,end} will continue use standard version because
kprobe itself handles that. Please update only the patch description and
add my ack.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If you add Steve's call graph for the explanation, it will help us to
understand what will be fixed.

Thank you,

> 
> Thanks for your review.
> 
> I'll rebase onto the latest tree and send v3 ASAP.
> 
> Regards,
> Ze
> 
> On Wed, May 17, 2023 at 12:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 16 May 2023 17:47:52 +0800
> > Ze Gao <zegao2021@gmail.com> wrote:
> >
> > > Precisely, these that are called within kprobe_busy_{begin, end},
> > > which the previous patch does not resolve.
> >
> > Note that kprobe_busy_{begin,end} don't need to use notrace version
> > because kprobe itself prohibits probing on preempt_count_{add,sub}.
> >
> > Thank you,
> >
> > > I will refine the commit message to make it clear.
> > >
> > > FYI, details can checked out here:
> > >     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902edcf21028874a74fb868@kernel.org/
> > >
> > > Regards,
> > > Ze
> > >
> > > On Tue, May 16, 2023 at 5:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > > > Current implementation calls kprobe related functions before doing
> > > > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > > > is traceable.
> > > >
> > > > Which preempt_count*() are you referring to? The ones you just made
> > > > _notrace in the previous patch?
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

