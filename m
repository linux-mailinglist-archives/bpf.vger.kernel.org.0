Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B163346C0
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhCJSbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 13:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232790AbhCJSb0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 13:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615401085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPoRS9ORJYnVBCLNHbLzK3HURBgeQOuy6dE3PZ5/hXU=;
        b=W8j5BucwCFr8w5GqjqceTXv54pRPD64l2IwOgo+d8dkClxc4LZuR9u5JkeSt/SCulmY7Fb
        Jq2Vei08HYAmMWkxdM2CNTVBKk6GNk8JXV71XtAzdze60HxmXCvwNNfFILG01fQVVzrxyB
        rk6JKcJ00meMTeTGzEsbEuP6Z6afZz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-MAY54ix0P36TF9VY8dtaUw-1; Wed, 10 Mar 2021 13:31:21 -0500
X-MC-Unique: MAY54ix0P36TF9VY8dtaUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C50C557;
        Wed, 10 Mar 2021 18:31:19 +0000 (UTC)
Received: from treble (ovpn-118-249.rdu2.redhat.com [10.10.118.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2B762AF8;
        Wed, 10 Mar 2021 18:31:15 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:31:13 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210310183113.xxverwh4qplr7xxb@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
 <20210309011945.ky7v3pnbdpxhmxkh@treble>
 <20210310185734.332d9d52a26780ba02d09197@kernel.org>
 <20210310150845.7kctaox34yrfyjxt@treble>
 <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 12:55:09AM +0900, Masami Hiramatsu wrote:
> +#ifdef CONFIG_KRETPROBES
> +static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
> +{
> +	return kretprobe_find_ret_addr(
> +			(unsigned long)kretprobe_trampoline_addr(),
> +			state->task, &state->kr_iter);
> +}
> +
> +static bool is_kretprobe_trampoline_address(unsigned long ip)
> +{
> +	return ip == (unsigned long)kretprobe_trampoline_addr();
> +}
> +#else
> +static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
> +{
> +	return state->ip;
> +}
> +
> +static bool is_kretprobe_trampoline_address(unsigned long ip)
> +{
> +	return false;
> +}
> +#endif
> +

Can this code go in a kprobes file?  I'd rather not clutter ORC with it,
and maybe it would be useful for other arches or unwinders.

>  bool unwind_next_frame(struct unwind_state *state)
>  {
>  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> @@ -536,6 +561,18 @@ bool unwind_next_frame(struct unwind_state *state)
>  
>  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
>  						  state->ip, (void *)ip_p);
> +		/*
> +		 * There are special cases when the stack unwinder is called
> +		 * from the kretprobe handler or the interrupt handler which
> +		 * occurs in the kretprobe trampoline code. In those cases,
> +		 * %sp is shown on the stack instead of the return address.
> +		 * Or, when the unwinder find the return address is replaced
> +		 * by kretprobe_trampoline.
> +		 * In those cases, correct address can be found in kretprobe.
> +		 */
> +		if (state->ip == sp ||

Why is the 'state->ip == sp' needed?

> +		    is_kretprobe_trampoline_address(state->ip))
> +			state->ip = orc_kretprobe_correct_ip(state);

This is similar in concept to ftrace_graph_ret_addr(), right?  Would it
be possible to have a similar API?  Like

		state->ip = kretprobe_ret_addr(state->task, &state->kr_iter, state->ip);

and without the conditional.

>  
>  		state->sp = sp;
>  		state->regs = NULL;
> @@ -649,6 +686,12 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
>  		state->full_regs = true;
>  		state->signal = true;
>  
> +		/*
> +		 * When the unwinder called with regs from kretprobe handler,
> +		 * the regs->ip starts from kretprobe_trampoline address.
> +		 */
> +		if (is_kretprobe_trampoline_address(state->ip))
> +			state->ip = orc_kretprobe_correct_ip(state);

Shouldn't __kretprobe_trampoline_handler() just set regs->ip to
'correct_ret_addr' before passing the regs to the handler?  I'd think
that would be a less surprising value for regs->ip than
'&kretprobe_trampoline'.

And it would make the unwinder just work automatically when unwinding
from the handler using the regs.

It would also work when unwinding from the handler's stack, if we put an
UNWIND_HINT_REGS after saving the regs.

The only (rare) case it wouldn't work would be unwinding from an
interrupt before regs->ip gets set properly.  In which case we'd still
need the above call to orc_kretprobe_correct_ip() or so.

-- 
Josh

