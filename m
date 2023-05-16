Return-Path: <bpf+bounces-656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB0705305
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3566281652
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841E31107;
	Tue, 16 May 2023 16:03:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34834CF9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 16:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A397C433D2;
	Tue, 16 May 2023 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684252997;
	bh=helSsO57tH8dHbFRP7TCi/6hSqDAckI7M3dabJ0ZYsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRkEXd4R4P1ulUwx8C82RCmJWGwc8Ste6XlVCpWZvC9Qcc2gYmHA1k6dQ21Zf+Tiy
	 qT8FRgwCIYA2117hVruEKq1bbXpARuD7yg9dDIHvUkcjIprxWMEttCswGjfaODMqXc
	 AbXpR7xi/J1hAdmFn+Qh5gjJ9JxKLjCb3Cof3rc+4o65KBLnERtyx/NaKaoY9mPWbF
	 3mHNnv6y/Mb2J/lWb+cFvzU15NB9pXvxhSykI2u2DfhhpK+alFr4cBdVnQ9MCZ4kK7
	 BaZPMq90Cc6L+2Qm7TdMttAPm2F4w1UnWDoohkzsv7EmzaY3M2R0sCCQD8nVffAXI3
	 WooI/NSCY2bRw==
Date: Wed, 17 May 2023 01:03:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517010311.f46db3f78b11cf9d92193527@kernel.org>
In-Reply-To: <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
References: <20230516071830.8190-1-zegao@tencent.com>
	<20230516071830.8190-3-zegao@tencent.com>
	<20230516091820.GB2587705@hirez.programming.kicks-ass.net>
	<CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 16 May 2023 17:47:52 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Precisely, these that are called within kprobe_busy_{begin, end},
> which the previous patch does not resolve.

Note that kprobe_busy_{begin,end} don't need to use notrace version
because kprobe itself prohibits probing on preempt_count_{add,sub}.

Thank you,

> I will refine the commit message to make it clear.
> 
> FYI, details can checked out here:
>     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902edcf21028874a74fb868@kernel.org/
> 
> Regards,
> Ze
> 
> On Tue, May 16, 2023 at 5:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > Current implementation calls kprobe related functions before doing
> > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > is traceable.
> >
> > Which preempt_count*() are you referring to? The ones you just made
> > _notrace in the previous patch?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

