Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9E347D35
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhCXQCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 12:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236871AbhCXQCA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 12:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616601719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRKrIR63kJGgZyOKIsEGqERgGzOKc7ulNOkxt+Ou4kg=;
        b=gQ8Zw5cSE+d9Z3gDiCcS7PAuIl3amPyqLhBFLdhpIsIALdxKReZGn4W/yyWQFqHqD8RHEa
        oYpnyOwSX+Jm9SiJonxEdZSN3HjOyWBPR6m2f0jpXHFNJwfLFfaV+/HkTdmudPidas/nbL
        O9EbkNbKagBR36dkD7qsY/VyKaEDDyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-o8yWUpcHNXGL2-WqdUH0zg-1; Wed, 24 Mar 2021 12:01:54 -0400
X-MC-Unique: o8yWUpcHNXGL2-WqdUH0zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A90855B383;
        Wed, 24 Mar 2021 16:01:50 +0000 (UTC)
Received: from treble (ovpn-120-53.rdu2.redhat.com [10.10.120.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4313B866D5;
        Wed, 24 Mar 2021 16:01:46 +0000 (UTC)
Date:   Wed, 24 Mar 2021 11:01:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <20210324160143.wd43zribpeop2czn@treble>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
 <161639530062.895304.16962383429668412873.stgit@devnote2>
 <20210323223007.GG4746@worktop.programming.kicks-ass.net>
 <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 10:40:58AM +0900, Masami Hiramatsu wrote:
> On Tue, 23 Mar 2021 23:30:07 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Mar 22, 2021 at 03:41:40PM +0900, Masami Hiramatsu wrote:
> > >  	".global kretprobe_trampoline\n"
> > >  	".type kretprobe_trampoline, @function\n"
> > >  	"kretprobe_trampoline:\n"
> > >  #ifdef CONFIG_X86_64
> > 
> > So what happens if we get an NMI here? That is, after the RET but before
> > the push? Then our IP points into the trampoline but we've not done that
> > push yet.
> 
> Not only NMI, but also interrupts can happen. There is no cli/sti here.
> 
> Anyway, thanks for pointing!
> I think in UNWIND_HINT_TYPE_REGS and UNWIND_HINT_TYPE_REGS_PARTIAL cases
> ORC unwinder also has to check the state->ip and if it is kretprobe_trampoline,
> it should be recovered.
> What about this?

I think the REGS and REGS_PARTIAL cases can also be affected by function
graph tracing.  So should they use the generic unwind_recover_ret_addr()
instead of unwind_recover_kretprobe()?

-- 
Josh

