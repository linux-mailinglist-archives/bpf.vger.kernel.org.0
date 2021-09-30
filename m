Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1D41E248
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 21:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhI3Tf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 15:35:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhI3Tf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 15:35:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633030452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZfbBNzbHkVIuhKwqguJTGfq6DIYa0jFVn7ger7Nk3o=;
        b=UgvdBcoZxu6zM9MhSomMAxnWcA6voy0PN6zz1Y2Yp9NQK6kYzrOOxWXgTbiKBj3Mzy8moS
        PnmZEFKkdU6vHtrQRhUxCsjLrphUcV95EZgl5cGLxpJiEBVeQ5Y5vEUUsSi+sKGGVPruIU
        v1Xc/+xthGkZyFvXUCgxWpMlDbpFCSPOBA06W7QpSF5HpSnsXxf/LV8sbY6Ft0A5RNk5vu
        jfUrpNrADXubRjx3TxHsIuENg4etf/a1MdYjbTPMJPO92HbcP04+kn9h4GsEI3/0aP6zq5
        zkykvqzhLiujFutRqDsIr1xjR91n9tyEJFFcjfLKd1xYXEU4FggPLemZleg8QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633030452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZfbBNzbHkVIuhKwqguJTGfq6DIYa0jFVn7ger7Nk3o=;
        b=v/q2/MEs8/p0mkkofLr+c2XttjUlmVrbxnbSWYCNNciv+d5QhXJgbKJuunhKUv/gAx+xSG
        OOTN/I8QxoOYjMCw==
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
In-Reply-To: <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
 <20210929112408.35b0ffe06b372533455d890d@kernel.org>
 <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
Date:   Thu, 30 Sep 2021 21:34:11 +0200
Message-ID: <874ka17t8s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30 2021 at 11:17, Alexei Starovoitov wrote:

> On Tue, Sep 28, 2021 at 7:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Hi Ingo,
>>
>> Can you merge this series to -tip tree since if I understand correctly,
>> all kprobes patches still should be merged via -tip tree.
>> If you don't think so anymore, I would like to handle the kprobe related
>> patches on my tree. Since many kprobes fixes/cleanups have not been
>> merged these months, it seems unhealthy now.
>>
>> Thank you,
>
> Linus,
>
> please suggest how to move these patches forward.
> We've been waiting for this fix for months now.

Sorry, I've not paying attention to those as they are usually handled by
Ingo who seems to be lost in space.

Masami, feel free to merge them over your tree. If not, let me know and
I'll pick them up tomorrow morning.

Thanks,

        tglx
