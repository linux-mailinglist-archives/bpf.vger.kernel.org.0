Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176493C3641
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGJTEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 15:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhGJTEy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Jul 2021 15:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625943728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WY2G4cBLrLCEOZ7o93bnRE51RtVPXt+mCwJHsXQT/sk=;
        b=XXTZkcvHZkq1so90VDRAz0j+m4P+ZCdDIse+eHWthPDjt++jhDdeUMf3YkIGHpCQBNTQB0
        vSTFufMDopBvItrDeYaiEuHUYVj6+tWPQ3yr1ZMK2+yRK4HwrMv2QQC9kk2h0SBFlJjinU
        LUK5/BC64MjIko5pAPrQQ+p/rKlcdp0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-8B-id3m6PxCHXU6u6wePlg-1; Sat, 10 Jul 2021 15:02:07 -0400
X-MC-Unique: 8B-id3m6PxCHXU6u6wePlg-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37084b0000b02903b4fb87a336so9787695qki.23
        for <bpf@vger.kernel.org>; Sat, 10 Jul 2021 12:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WY2G4cBLrLCEOZ7o93bnRE51RtVPXt+mCwJHsXQT/sk=;
        b=AkTBw5PhOBAm+DwwRKySMbxJ33klU9at8Qe0DfAER/IFyzBLu7XJeTpoeTwf52ny8e
         Sx2CxZHjxStNsMFrLYmqLdIPy3EajmQZkVyzpxYTTaRr60nICJJqeUoXCzQHNgmFMfjy
         673hpjRudFqlN+ieaBQQuwoZ3EQYZR026lOxq+JHaXV6WSXnAFdLJ/pqLE3SulhHRrTX
         EIuTlBl2DJl/m3FA1LLqcKwlcUcdsUXTWU0nMzyIlapYoRwpH6137QaT5JmrfVqLKAMX
         zkGzeCFo7PVCCjm2C4/dQA9VquauA/vrF23KxuqfH7HzK/Aq7EWlshav8McyI+XpVI0I
         iFow==
X-Gm-Message-State: AOAM5302am6NQHprES1rHaFa8gXc1iPxwmQ0zoTEF7i8ljMlwaPs4UMy
        X2H78lcxrwRmUpfolN12gRDo0sVkuuiHLGT1OHW90k/F0s/VJC6gXQHo2Kek3wGGwNjXlflEAy5
        GuIyo3IuFIBke
X-Received: by 2002:a05:620a:109a:: with SMTP id g26mr9206583qkk.25.1625943726999;
        Sat, 10 Jul 2021 12:02:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztUJiZ/ZNUppr/6J4ZCg3hmaNYpwXWSc+GqtgxVLS57QtktubXhbB9VGMXm/96TlpSOgzoDw==
X-Received: by 2002:a05:620a:109a:: with SMTP id g26mr9206558qkk.25.1625943726757;
        Sat, 10 Jul 2021 12:02:06 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 5sm3597556qtb.22.2021.07.10.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:02:06 -0700 (PDT)
Date:   Sat, 10 Jul 2021 12:01:43 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 05/13] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-ID: <20210710190143.lrcsyal2ggubv43v@treble>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399996966.506599.810050095040575221.stgit@devnote2>
 <YOK8pzp8B2V+1EaU@gmail.com>
 <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
 <20210710104104.3a270168811ac38420093276@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210710104104.3a270168811ac38420093276@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 10, 2021 at 10:41:04AM +0900, Masami Hiramatsu wrote:
> Hi Ingo and Josh,
> 
> On Sat, 10 Jul 2021 00:31:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > > > +#undef UNWIND_HINT_FUNC
> > > > +#define UNWIND_HINT_FUNC
> > > > +#endif
> > > >  /*
> > > >   * When a retprobed function returns, this code saves registers and
> > > >   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> > > > @@ -1031,6 +1044,7 @@ asm(
> > > >  	/* We don't bother saving the ss register */
> > > >  #ifdef CONFIG_X86_64
> > > >  	"	pushq %rsp\n"
> > > > +	UNWIND_HINT_FUNC
> > > >  	"	pushfq\n"
> > > >  	SAVE_REGS_STRING
> > > >  	"	movq %rsp, %rdi\n"
> > > > @@ -1041,6 +1055,7 @@ asm(
> > > >  	"	popfq\n"
> > > >  #else
> > > >  	"	pushl %esp\n"
> > > > +	UNWIND_HINT_FUNC
> > > >  	"	pushfl\n"
> > > >  	SAVE_REGS_STRING
> > > >  	"	movl %esp, %eax\n"
> > > 
> > > Why not provide an appropriate annotation method in <asm/unwind_hints.h>, 
> > > so that other future code can use it too instead of reinventing the wheel?
> 
> I think I got what you meant. Let me summarize the issue.
> 
> In case of CONFIG_FRAME_POINTER=n, it is OK just adding UNWIND_HINT_FUNC.
> 
> In case of CONFIG_FRAME_POINTER=y, without STACK_FRAME_NON_STANDARD(),
> the objtool complains that a CALL instruction without the frame pointer.
> ---
>   arch/x86/kernel/kprobes/core.o: warning: objtool: __kretprobe_trampoline()+0x25: call without frame pointer save/setup
> ---
> 
> If we just add STACK_FRAME_NON_STANDARD() with UNWIND_HINT_FUNC macro,
> the objtool complains that non-standard function has unwind hint.
> ---
> arch/x86/kernel/kprobes/core.o: warning: objtool: __kretprobe_trampoline()+0x1: BUG: why am I validating an ignored function?

I'm thinking this latter warning indicates an objtool bug (as the BUG
warning claims).  If a function is ignored with
STACK_FRAME_NON_STANDARD() then objtool should probably also ignore its
hints.  Then we should be able to get rid of the #undef/#ifdef
UNWIND_HINT_FUNC silliness.

The other warning is correct and STACK_FRAME_NON_STANDARD() still needs
to be behind '#ifdef CONFIG_FRAME_POINTER' since the function is missing
a frame pointer.  So maybe we can make a STACK_FRAME_NON_STANDARD_FP()
or similar.

I'll post a few patches.

-- 
Josh

