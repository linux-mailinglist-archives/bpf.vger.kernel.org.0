Return-Path: <bpf+bounces-46830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01A9F09F3
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 11:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245D718892A1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891301C07C1;
	Fri, 13 Dec 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYHJdmkA"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DD19993F;
	Fri, 13 Dec 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086747; cv=none; b=ZAYLel1knU9phNHKg4ypzk2TcsTx7trYGOB4oVc434/LQTNufvnjTcMnWqV8nVI6calFNtCzssx63yYAXm5cZGat/mS5jNIK9ByWTdTSPR7JrVfwyhWVwq2uennOecQu16El++86oYVweGLMkVzBLEBwm7Tdks+pkzlZfxZttPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086747; c=relaxed/simple;
	bh=2Puk8QLmhHJo6R5adVOfOdPeTfChTdejbhh3D1rY8GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAt6j8J2LAt7idzVF/hyyXXga+RblhMqsJqactqxXArGwjOgzMWrypozP8QOYFTEA4Y1bT68gFhBlqUWhSJKM4n8gAX7LZeRYCQisVaGL3rAd65H86Fx4C4+x2rd9DRMa0tfOAoaE2K+Ebw9gSc9w9UMoTbphJDApsZJ/p3VHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MYHJdmkA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ru8nXg4sWPeEVSKuwQrkoI/XLQLqxohL/6/cdzrsFX0=; b=MYHJdmkAGAmGdDYOmO2VaDmAco
	ZNOyCaY3MrGEAWEWT9mwThQbiTQ4iaH7IvSWXhc5u8mXYAk5QQvt0pAzFdicAjVb/rCafkn8KvW2h
	jtxRKh4dX2wDvftDbDUgIkrKPPIuVs2wJW7VkPWs0Us4Z6Z1eOJUwELudoKi2ChbMY2xbCAKbxHQM
	FB9k9iNOgejdka8oEg/UU3oznkATFt2MhEm6LBDsNyY1g1JRBUX/m9fJ2wFo4Djhq/5XGndsW6C/u
	O9/bKTfiSUZdy5bCWAsGYwZeVpIxwnBAHdRlawyM2+fmxg1RspiE5upY16aDGR1tnpJqz0YjwHl/G
	0mhDsGZQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3Av-0000000CHhL-2NNg;
	Fri, 13 Dec 2024 10:45:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C82BC30049D; Fri, 13 Dec 2024 11:45:36 +0100 (CET)
Date: Fri, 13 Dec 2024 11:45:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 07/13] uprobes/x86: Add support to emulate nop5
 instruction
Message-ID: <20241213104536.GZ35539@noisy.programming.kicks-ass.net>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-8-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211133403.208920-8-jolsa@kernel.org>

On Wed, Dec 11, 2024 at 02:33:56PM +0100, Jiri Olsa wrote:
> Adding support to emulate nop5 as the original uprobe instruction.
> 
> This speeds up uprobes on top of nop5 instructions:
> (results from benchs/run_bench_uprobes.sh)
> 
> current:
> 
>      uprobe-nop     :    3.252 ± 0.019M/s
>      uprobe-push    :    3.097 ± 0.002M/s
>      uprobe-ret     :    1.116 ± 0.001M/s
>  --> uprobe-nop5    :    1.115 ± 0.001M/s
>      uretprobe-nop  :    1.731 ± 0.016M/s
>      uretprobe-push :    1.673 ± 0.023M/s
>      uretprobe-ret  :    0.843 ± 0.009M/s
>  --> uretprobe-nop5 :    1.124 ± 0.001M/s
> 
> after the change:
> 
>      uprobe-nop     :    3.281 ± 0.003M/s
>      uprobe-push    :    3.085 ± 0.003M/s
>      uprobe-ret     :    1.130 ± 0.000M/s
>  --> uprobe-nop5    :    3.276 ± 0.007M/s
>      uretprobe-nop  :    1.716 ± 0.016M/s
>      uretprobe-push :    1.651 ± 0.017M/s
>      uretprobe-ret  :    0.846 ± 0.006M/s
>  --> uretprobe-nop5 :    3.279 ± 0.002M/s
> 
> Strangely I can see uretprobe-nop5 is now much faster compared to
> uretprobe-nop, while perf profiles for both are almost identical.
> I'm still checking on that.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 23e4f2821cff..cdea97f8cd39 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -909,6 +909,11 @@ static const struct uprobe_xol_ops push_xol_ops = {
>  	.emulate  = push_emulate_op,
>  };
>  
> +static int is_nop5_insn(uprobe_opcode_t *insn)
> +{
> +	return !memcmp(insn, x86_nops[5], 5);
> +}
> +
>  /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
>  static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  {
> @@ -928,6 +933,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  		break;
>  
>  	case 0x0f:
> +		if (is_nop5_insn((uprobe_opcode_t *) &auprobe->insn))
> +			goto setup;

This isn't right, this is not x86_64 specific code, and there's a bunch
of 32bit 5 byte nops that do not start with 0f.

Also, since you already have the insn decoded, I would suggest you
simply check OPCODE2(insn) == 0x1f /* NOPL */ and length == 5.

>  		if (insn->opcode.nbytes != 2)
>  			return -ENOSYS;
>  		/*
> -- 
> 2.47.0
> 

