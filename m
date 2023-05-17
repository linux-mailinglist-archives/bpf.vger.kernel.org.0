Return-Path: <bpf+bounces-766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF977066FB
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB72810CC
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FA2C745;
	Wed, 17 May 2023 11:42:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C2211C
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E92BC433EF;
	Wed, 17 May 2023 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684323763;
	bh=gZs8PTPaOModQRmxiev/yHAiJdEHjNnngGNAI1ylIV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/3r14rFZqH/pXFAXD7yN1fUGpho601/AbF5SCUVKAY7mqrUjDZO7Rixiz4k6K5x0
	 5q09YQPLznIfUq4yn68RWcj3BGQQ3aKnDl3WYcNOGi/KnuoxI1obWx9g6baBPRC8hQ
	 DPJ1pg6mhBVu4bmIqVmp7NVDSQHYU9z1z/L1Pfx5fdDZo10PVer0ENUX2qSrWJey20
	 bTU0BrjRBfbX7dQrwZj50fYI9xjlXnWbSGbHvh+cTmdq+GyPhyKGVzyQf3AwVfmXEH
	 jBoY5OKrX9VIjyXOQUq5bBISYZopB+wmnIcTPubjjaUAbZk92IXmEWbTKZp2qjQ3Zl
	 Ft/OepS5JIE1Q==
Date: Wed, 17 May 2023 20:42:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ze Gao <zegao2021@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens
 <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
 <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 x86@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
 Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517204236.e0f579399e5a69505a4ec7ef@kernel.org>
In-Reply-To: <ZGSwzuM8oHgKaaga@krava>
References: <20230517034510.15639-1-zegao@tencent.com>
	<20230517034510.15639-3-zegao@tencent.com>
	<ZGSwzuM8oHgKaaga@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 12:47:42 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, May 17, 2023 at 11:45:07AM +0800, Ze Gao wrote:
> > Current implementation calls kprobe related functions before doing
> > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > is traceable in kprobe_busy_{begin, end}.
> > 
> > Things goes like this without this patch quoted from Steven:
> > "
> > fprobe_kprobe_handler() {
> >    kprobe_busy_begin() {
> >       preempt_disable() {
> >          preempt_count_add() {  <-- trace
> >             fprobe_kprobe_handler() {
> > 		[ wash, rinse, repeat, CRASH!!! ]
> > "
> > 
> > By refactoring the common part out of fprobe_kprobe_handler and
> > fprobe_handler and call ftrace recursion detection at the very beginning,
> > the whole fprobe_kprobe_handler is free from recursion.
> > 
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-zegao@tencent.com
> > ---
> >  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 44 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9abb3905bc8e..097c740799ba 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
> >  	char data[];
> >  };
> >  
> > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +static inline void __fprobe_handler(unsigned long ip, unsigned long
> > +		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
> >  {
> >  	struct fprobe_rethook_node *fpr;
> >  	struct rethook_node *rh = NULL;
> >  	struct fprobe *fp;
> >  	void *entry_data = NULL;
> > -	int bit, ret;
> > +	int ret;
> >  
> 
> this change uncovered bug for me introduced by [1]
> 
> the bpf's kprobe multi uses either fprobe's entry_handler or exit_handler,
> so the 'ret' value is undefined for return probe path and occasionally we
> won't setup rethook and miss the return probe

Oops, I missed to push my fix.

https://lore.kernel.org/all/168100731160.79534.374827110083836722.stgit@devnote2/

> 
> we can either squash this change into your patch or I can make separate
> patch for that.. but given that [1] is quite recent we could just silently
> fix that ;-)

Jiri, I think the above will fix the issue, right?

> 
> jirka
> 
> 
> [1] 39d954200bf6 fprobe: Skip exit_handler if entry_handler returns !0
> 
> ---
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9abb3905bc8e..293184227394 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -27,7 +27,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  	struct rethook_node *rh = NULL;
>  	struct fprobe *fp;
>  	void *entry_data = NULL;
> -	int bit, ret;
> +	int bit, ret = 0;
>  
>  	fp = container_of(ops, struct fprobe, ops);
>  	if (fprobe_disabled(fp))
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

