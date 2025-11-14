Return-Path: <bpf+bounces-74531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86344C5E64F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 054713612EB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9F334C01;
	Fri, 14 Nov 2025 16:39:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145032D451;
	Fri, 14 Nov 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138355; cv=none; b=buEUeSsFsDpycXFTPi9nmRWUWuVwvQ2Ups4Lf2EQQawbracwB+QWMtkFTgYbEGBe6/kE8nP5lN1Q0wzkb2R7kg7canhFYEu5BfndHxaupZBkvx0VLdKlnLEpn39Q4RGvJL3CqBoUzwtkUMeMlTfm/N2AWpyUy2HmqoP5uX5FOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138355; c=relaxed/simple;
	bh=RwQ5mBu41FTdmMcHeQQ+BL2LOJuuxM/eMSPYCuTNbro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9tFwlvZAdOzLkBpycd9MfnMf/p2vJ1+vMNVEVq0Ml29gs9U0DL/juvG624jV+eR/NdV/ZbMZq2yBBQHzJ0Jzs+Pj3QZqrpWjwXdbzL/cOg4NeQ2PCbLYzKc0h/azxWe1Y19Fekm3aOxlVFF80giJBnOz0fC+PDvVcHXKJ4xQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B62054BB7A;
	Fri, 14 Nov 2025 16:39:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id C86BC2000E;
	Fri, 14 Nov 2025 16:39:06 +0000 (UTC)
Date: Fri, 14 Nov 2025 11:39:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 2/7] x86/ftrace: implement
 DYNAMIC_FTRACE_WITH_JMP
Message-ID: <20251114113924.723f6fde@gandalf.local.home>
In-Reply-To: <20251114092450.172024-3-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
	<20251114092450.172024-3-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gk8zf381pa1b9txskaj34u6h7wx7umx3
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C86BC2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/iIms73HQALe8U/aBD2Grsb4qbU8gNfcY=
X-HE-Tag: 1763138346-303519
X-HE-Meta: U2FsdGVkX19m7moKREZT9FFaq0yf9jFEsjW2WiULS003bXnsqnpbm+OWYyE6jZFyj6J7XmTXcZpBbU24ZtxQ7omUnDM7ivOJz84Nye1S76CdrHx2s0ikAvMmHYQQqWLVd2L38r141v7igke7loz8c/PM6WwAdwTD/+Tgfswwkt1VRlMet5bPzccu9iymq5LGQTUTCmc2sPkZlUdiVzrePpnwlwRJKo+pNlgEm9pXS4888k8+PMllOXuBjRJhAV5WqE95yvSet7CqxEX+RoVzQcDtB3+HB9xVjGb1pS2Zw8EtiwldJnas8SuldQ+uiqf7XxK8EgiNo1uKNkJ70+YxRAChcj1SHixo

On Fri, 14 Nov 2025 17:24:45 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
>  	ANNOTATE_NOENDBR
>  	RET
>  
> +1:
> +	testb	$1, %al
> +	jz	2f
> +	andq $0xfffffffffffffffe, %rax
> +	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> +	restore_mcount_regs
> +	/* Restore flags */
> +	popfq
> +	RET
> +
>  	/* Swap the flags with orig_rax */
> -1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
> +2:	movq MCOUNT_REG_SIZE(%rsp), %rdi
>  	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
>  	movq %rax, MCOUNT_REG_SIZE(%rsp)
>  

So in this case we have:

 original_caller:
 call foo -> foo:
             call fentry -> fentry:
                            [do ftrace callbacks ]
                            move tramp_addr to stack
                            RET -> tramp_addr
                                            tramp_addr:
                                            [..]
                                            call foo_body -> foo_body:
                                                             [..]
                                                             RET -> back to tramp_addr
                                            [..]
                                            RET -> back to original_caller

I guess that looks balanced.

-- Steve

                                                         

