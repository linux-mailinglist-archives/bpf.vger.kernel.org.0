Return-Path: <bpf+bounces-18352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DE819611
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C282E286EE1
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520284421;
	Wed, 20 Dec 2023 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdPqqC2m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86A79CC;
	Wed, 20 Dec 2023 01:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6587AC433C8;
	Wed, 20 Dec 2023 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703034054;
	bh=4syDIv0RLwOoNUlwaRQGOzsRhe4oIXvWdi4qYIv7kc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdPqqC2m65iV4CGkhx4G5oQ95lk6Am7JoKxR95gUf91AXAr38xSW/Ie3u6p57szTH
	 +xQ/05BAVUzvNCEfnxIVTtKrKvUNqjTtLVoznBNSNL7V0ouLSV3RyteV2OkF2C/aFk
	 AFp4E7cfVa1RSgP521RsfQUNr3QNvY9B74a+VJJvs2zJTdhc64rTr0z7Hu3Y8s9EoA
	 sK81M+Iy3Ue0P2B6DyRg93Z/yx3yGeCj5G7h4yMCwfJ0nAmIA+GRjCQPf8CcKLPwuZ
	 YGl0lNaIh3QT2wmVP04/E8jR7LoZRiRtKzpYvviV6/MBMGgHClSpSrOUcI890fk+Vo
	 iblBm9KsE5Dug==
Date: Wed, 20 Dec 2023 10:00:47 +0900
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
Subject: Re: [PATCH v5 28/34] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20231220100047.e33d862cb869423c2a3a82bf@kernel.org>
In-Reply-To: <ZYGrB7NsDEWk2liL@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290542972.220107.9135357273431693988.stgit@devnote2>
	<ZYGrB7NsDEWk2liL@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 15:39:03 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Dec 18, 2023 at 10:17:10PM +0900, Masami Hiramatsu (Google) wrote:
> 
> SNIP
> 
> > -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> > -				unsigned long ret_ip, struct pt_regs *regs)
> > +static int fprobe_entry(unsigned long func, unsigned long ret_ip,
> > +			struct ftrace_regs *fregs, struct fgraph_ops *gops)
> >  {
> > -	struct fprobe *fp = (struct fprobe *)data;
> > -	struct fprobe_rethook_node *fpr;
> > -	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
> > -	int bit;
> > +	struct fprobe_hlist_node *node, *first;
> > +	unsigned long *fgraph_data = NULL;
> > +	unsigned long header;
> > +	int reserved_words;
> > +	struct fprobe *fp;
> > +	int used, ret;
> >  
> > -	if (!fp || fprobe_disabled(fp))
> > -		return;
> > +	if (WARN_ON_ONCE(!fregs))
> > +		return 0;
> >  
> > -	fpr = container_of(rh, struct fprobe_rethook_node, node);
> > +	first = node = find_first_fprobe_node(func);
> > +	if (unlikely(!first))
> > +		return 0;
> > +
> > +	reserved_words = 0;
> > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > +		if (node->addr != func)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (!fp || !fp->exit_handler)
> > +			continue;
> > +		/*
> > +		 * Since fprobe can be enabled until the next loop, we ignore the
> > +		 * fprobe's disabled flag in this loop.
> > +		 */
> > +		reserved_words +=
> > +			DIV_ROUND_UP(fp->entry_data_size, sizeof(long)) + 1;
> > +	}
> > +	node = first;
> > +	if (reserved_words) {
> > +		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
> > +		if (unlikely(!fgraph_data)) {
> > +			hlist_for_each_entry_from_rcu(node, hlist) {
> > +				if (node->addr != func)
> > +					break;
> > +				fp = READ_ONCE(node->fp);
> > +				if (fp && !fprobe_disabled(fp))
> > +					fp->nmissed++;
> > +			}
> > +			return 0;
> > +		}
> > +	}
> 
> this looks expensive compared to what we do now.. IIUC due to the graph
> ops limitations (16 ctive ops), you have just single graph ops for fprobe
> and each fprobe registration stores ips into hash which you need to search
> in here to get registered callbacks..?

I think this is not so expensive. Most cases, it only hits 1 fprobe on the
hash. And if the fprobe is only used to hook the entry, reserved_words == 0.

> I wonder would it make sense to allow arbitrary number of active graph_ops
> with the price some callback might fail because there's no stack space so
> each fprobe instance would have its own graph_ops.. and we would get rid
> of the code above (and below) ?

Yeah, actually my first implementation is that. But I realized that doesn't
work, this requires intermediate object which has refcounter because the
"marker" on the shadow stack will be left after unregistering it. We need to
identify which is still available and which is not. And for that purpose,
we may need to introduce similar structure in the fgraph too.

The current multi-fgraph does;

 - if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n (called from dedicated mcount
   asm code), it has to loop on all fgraph_ops and check the hash, which is
   inefficient but it can easily push the return trace entry on the shadow
   stack.

 - if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y (called from ftrace asm code),
   it does not need to loop (that will be done by ftrace) but each handler
   does NOT know who pushed the return trace entry on the shadow stack.
   Thus it has to decode the shadow stack and check it needs to push return
   trace entry or not. And this is hard if the traced function is self-
   recursive call or tail call. To check the recursive call, I introduced
   a bitmap entry on the shadow stack. This bitmap size limits the max
   number of fgraph.

So, unlimit the number of fgraph, we may need to stack the number of fgraph
on the stack and each fgraph callback has to unwind the shadow stack to check
whether their own number is there instead of checking the bit in the bitmap.
That will be more trusted way but maybe slow.

Another option is introducing a pair of pre- and post-callbacks which is called
before and after calling the list/direct call of ftrace_ops. And pre-callback
will push the ret_stack on shadow stack and post-callback will commit or cancel it.
(but this one is hard to design... maybe becomes ugly interface.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

