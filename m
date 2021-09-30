Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD541E496
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 01:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhI3XM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 19:12:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhI3XM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 19:12:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633043472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo+TYluRAlDqPIHiwUd1zfkElfADG2oaYeODsMOInaM=;
        b=H/LMn1DxDY26ScZTfsxs2K5eAyxF1TenwThY7/5G46bO1VSJsX0PYh38Pm15CSrcaXgOar
        LAXlVO1eeD8zhh9qRTxkMtvtMd1BxfF0xQYU/D8GybXIf/YpppONe4Z7YNyqeljQR1NLNV
        bj4/pS5LLdUt/ESS9kJ6DkGKQI6j3/Rr3k4nVrnianM1YHss6Ql3UVPZxf+QxrXnCXpGSy
        rpnomXDwmSHa+u+eWHWnwQ0ewIYiSw9X6nGjtSVTxm0SF3lC12NvfDzzM+iUHgWpc8Bllo
        YwWC2OiZAbCyhxvlk50WCx/xIkk6wAzSjRZiK5+yXamnCWqW8Ze+6I39Ll2ZGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633043472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo+TYluRAlDqPIHiwUd1zfkElfADG2oaYeODsMOInaM=;
        b=ZA/73UylhQajg5VN4tT7pXnPmch/+Qaqs6O+2X+npusBnIoX7089S85la+ijLmQ6FEhfSy
        85VK+NCbxGB8MICw==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH -tip v11 00/27] kprobes: Fix stacktrace with kretprobes
 on x86
In-Reply-To: <20210930172206.1a34279b@oasis.local.home>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
 <20210929112408.35b0ffe06b372533455d890d@kernel.org>
 <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
 <874ka17t8s.ffs@tglx> <20210930172206.1a34279b@oasis.local.home>
Date:   Fri, 01 Oct 2021 01:11:12 +0200
Message-ID: <87wnmx64mn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30 2021 at 17:22, Steven Rostedt wrote:
> On Thu, 30 Sep 2021 21:34:11 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Masami, feel free to merge them over your tree. If not, let me know and
>> I'll pick them up tomorrow morning.
>
> Masami usually goes through my tree. Want me to take it or do you want
> to?

Now I'm really confused. Masami poke Ingo to merge stuff which goes
usually through your tree !?!

But sure, feel free to pick it up. I have enough stuff on my plate
already.

Thanks,

        tglx
