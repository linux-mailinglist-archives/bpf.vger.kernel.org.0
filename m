Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF9336966
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 02:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCKBGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 20:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhCKBG3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 20:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615424788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NlNmI4tedf0ptWCOX9AN1BL2Q8MJrpCOVljUQI3bIm0=;
        b=FBAqsUFnhoPyDgW9Iz37vFNt1s2KWwlFOrZ66dbta4etyTKeBqMtN7sljSpYlrRi3UCXnE
        UZIavlSNEm/rYYCWBd2skpYjSjbJZWv9UVqBSWTgz03B7rZ0ZB12UKZXTO4apcCeT9rj7X
        dX+vosPpisncOFB1rUfhoEHToPU8Ysw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-OsMim5OTMCSQb5c4x9uz8A-1; Wed, 10 Mar 2021 20:06:24 -0500
X-MC-Unique: OsMim5OTMCSQb5c4x9uz8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142091005D45;
        Thu, 11 Mar 2021 01:06:22 +0000 (UTC)
Received: from treble (ovpn-118-249.rdu2.redhat.com [10.10.118.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD45E1981B;
        Thu, 11 Mar 2021 01:06:18 +0000 (UTC)
Date:   Wed, 10 Mar 2021 19:06:15 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210311010615.7pemfngxx7cy42fe@treble>
References: <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
 <20210309011945.ky7v3pnbdpxhmxkh@treble>
 <20210310185734.332d9d52a26780ba02d09197@kernel.org>
 <20210310150845.7kctaox34yrfyjxt@treble>
 <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
 <20210310183113.xxverwh4qplr7xxb@treble>
 <20210311092018.2d0e54d2c891850e549d16fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210311092018.2d0e54d2c891850e549d16fe@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 09:20:18AM +0900, Masami Hiramatsu wrote:
> > >  bool unwind_next_frame(struct unwind_state *state)
> > >  {
> > >  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> > > @@ -536,6 +561,18 @@ bool unwind_next_frame(struct unwind_state *state)
> > >  
> > >  		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
> > >  						  state->ip, (void *)ip_p);
> > > +		/*
> > > +		 * There are special cases when the stack unwinder is called
> > > +		 * from the kretprobe handler or the interrupt handler which
> > > +		 * occurs in the kretprobe trampoline code. In those cases,
> > > +		 * %sp is shown on the stack instead of the return address.
> > > +		 * Or, when the unwinder find the return address is replaced
> > > +		 * by kretprobe_trampoline.
> > > +		 * In those cases, correct address can be found in kretprobe.
> > > +		 */
> > > +		if (state->ip == sp ||
> > 
> > Why is the 'state->ip == sp' needed?
> 
> As I commented above, until kretprobe_trampoline writes back the real
> address to the stack, sp value is there (which has been pushed by the
> 'pushq %rsp' at the entry of kretprobe_trampoline.)
> 
>         ".type kretprobe_trampoline, @function\n"
>         "kretprobe_trampoline:\n"
>         /* We don't bother saving the ss register */
>         "       pushq %rsp\n"				// THIS
>         "       pushfq\n"
> 
> Thus, from inside the kretprobe handler, like ftrace, you'll see
> the sp value instead of the real return address.

I see.  If you change is_kretprobe_trampoline_address() to include the
entire function, like:

static bool is_kretprobe_trampoline_address(unsigned long ip)
{
	return (void *)ip >= kretprobe_trampoline &&
	       (void *)ip < kretprobe_trampoline_end;
}

then the unwinder won't ever read the bogus %rsp value into state->ip,
and the 'state->ip == sp' check can be removed.

> > And it would make the unwinder just work automatically when unwinding
> > from the handler using the regs.
> > 
> > It would also work when unwinding from the handler's stack, if we put an
> > UNWIND_HINT_REGS after saving the regs.
> 
> At that moment, the real return address is not identified. So we can not
> put it.

True, at the time the regs are originally saved, the real return address
isn't available.  But by the time the user handler is called, the return
address *is* available.  So if the real return address were placed in
regs->ip before calling the handler, the unwinder could find it there,
when called from the handler.

Then we wouldn't need the call to orc_kretprobe_correct_ip() in
__unwind_start().

But maybe it's not possible due to the regs->ip expectations of legacy
handlers?

-- 
Josh

