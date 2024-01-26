Return-Path: <bpf+bounces-20402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9876283DD5F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5415428216D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995961CF94;
	Fri, 26 Jan 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOrmoKKP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BD1D526;
	Fri, 26 Jan 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282661; cv=none; b=fuQCAqedJZAoJ8rdaDIKjiKrs651ilD/MZPUyMv9G2cM9w8MC6Ama7Pjg4yM6+AtpATwMDavCxJEMRANAQOstcpTvQGIXsQfyaarUdlD6u7WScJ9c5YIiPF47c8uYjSn/GUPBhFjA7lqY3MO26v1ObmCfAR6VSiAKIVS+l1hJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282661; c=relaxed/simple;
	bh=bgOxmLLVYSKMNC9czTxSMRA8wJQdkCUFghdAMXJg18U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EUGIyUQjSRMsYoHF6AsY2vYNsyUopPoZrenq00OJtT1ZXcZJcf9/VyfFLwm4INvc04pG6JGo+rmZ+A/Yn74WrRgGeIFVZdc3VC1+oB3y/basYIAKCgEzK/oj5hxQ4JyF0CSKx6FZql0zPp2/yn63+9yzIKDAZ6PhQPNc5VulqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOrmoKKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A36C433C7;
	Fri, 26 Jan 2024 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282660;
	bh=bgOxmLLVYSKMNC9czTxSMRA8wJQdkCUFghdAMXJg18U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOrmoKKPHgHwqifQmN5xAl63YrrtrfhDpY3l3HmG5+V2gz9iqF2sng9TY4+w07UF0
	 aPrZxn4W67F5MLikBia+9nmbJQ55880qxg7hnp07lYN5Sg8NMCFd6azVnBYpBeYDU3
	 wAwc90yVhWeDZ5s2Y+/712MFSLf6qSfFsOkaEB+/50ztHgl6q+ci7OQ93BMa/O0WSH
	 /9JFWLRLNyokDN80MjA2nPC5lIMyNAPR/EVriEgDaGqq2mhp5TajJzePAN2qyVEGus
	 5j12xQLpgqcxB8wxV/Y6J6Sh4Sd9JAu3VPO1Kca1/1vltz3vP27bbdkN5yW0XxPSvX
	 a+NkEuLuQoXFQ==
Date: Sat, 27 Jan 2024 00:24:14 +0900
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
Subject: Re: [PATCH v6 32/36] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20240127002414.660f2e477d210bc54ca4df89@kernel.org>
In-Reply-To: <ZbJ6NxkjWEP5adru@krava>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
	<170505462606.459169.1375700979988728260.stgit@devnote2>
	<ZbJ6NxkjWEP5adru@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:11:51 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Jan 12, 2024 at 07:17:06PM +0900, Masami Hiramatsu (Google) wrote:
> 
> SNIP
> 
> >   * Register @fp to ftrace for enabling the probe on the address given by @addrs.
> > @@ -298,23 +547,27 @@ EXPORT_SYMBOL_GPL(register_fprobe);
> >   */
> >  int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
> >  {
> > -	int ret;
> > -
> > -	if (!fp || !addrs || num <= 0)
> > -		return -EINVAL;
> > -
> > -	fprobe_init(fp);
> > +	struct fprobe_hlist *hlist_array;
> > +	int ret, i;
> >  
> > -	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
> > +	ret = fprobe_init(fp, addrs, num);
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = fprobe_init_rethook(fp, num);
> > -	if (!ret)
> > -		ret = register_ftrace_function(&fp->ops);
> > +	mutex_lock(&fprobe_mutex);
> > +
> > +	hlist_array = fp->hlist_array;
> > +	ret = fprobe_graph_add_ips(addrs, num);
> 
> so fprobe_graph_add_ips registers the ftrace_ops and actually starts
> the tracing.. and in the code below we prepare fprobe data that is
> checked in the ftrace_ops callback.. should we do this this earlier
> before calling fprobe_graph_add_ips/register_ftrace_graph?

Good catch! but I think this is safe because fprobe_entry() checks
the fprobe_ip_table[] (insert_fprobe_node updates it) at first.
Thus until the hash table is updated, fprobe_entry() handler will
return soon.

----
static int fprobe_entry(unsigned long func, unsigned long ret_ip,
                        struct ftrace_regs *fregs, struct fgraph_ops *gops)
{
        struct fprobe_hlist_node *node, *first;
        unsigned long *fgraph_data = NULL;
        unsigned long header;
        int reserved_words;
        struct fprobe *fp;
        int used, ret;

        if (WARN_ON_ONCE(!fregs))
                return 0;

        first = node = find_first_fprobe_node(func);
        if (unlikely(!first))
                return 0;
----

The fprobe_table (add_fprobe_hash updates it) is used for return handler,
that will be used by fprobe_return().

So I think it should be safe too. Or I might missed something?

Thank you,


> 
> jirka
> 
> > +	if (!ret) {
> > +		add_fprobe_hash(fp);
> > +		for (i = 0; i < hlist_array->size; i++)
> > +			insert_fprobe_node(&hlist_array->array[i]);
> > +	}
> > +	mutex_unlock(&fprobe_mutex);
> >  
> >  	if (ret)
> >  		fprobe_fail_cleanup(fp);
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(register_fprobe_ips);
> > @@ -352,14 +605,13 @@ EXPORT_SYMBOL_GPL(register_fprobe_syms);
> 
> SNIP


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

