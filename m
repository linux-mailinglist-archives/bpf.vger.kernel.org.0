Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B341E4FE
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 01:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbhI3XaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 19:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351058AbhI3X3V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 19:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 898FE6120D;
        Thu, 30 Sep 2021 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633044457;
        bh=NaQlOCpc8Bl4Cum/O3q6BbPSX9YxsEL/GrpoA/O8GO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i87dzddPZ+qprD/UB5ZpEudYdE7BfOvrU2k1WPZ8s9fP51UHYgbWQk8IeyWc3wByl
         w4kJZsMcB1sCG8ZQVgCWKC/dy7r4QcGOkaNAC00VE5vl/ohgCInFiRM1OyKq6U3CDQ
         qGXy/DU3cAkFCD8bPS3XxN2+NF/Ijg/fuPLEtwYatt8tLKSVEo2RrXHnOZGMfWuHQh
         ZP6uJWKOk/h5dkenrU8bNhU90wbc4yq3+8MMx0PAQRD9Xxmx+ZasmCusO8eZSEdIB1
         VXdRSj6oMzFNiR8JUXjtCjqfuEMVQ9FglvcI+/rxNuoKu8oChI+SpkCHdkJpcvK+Ig
         4WUKgDDGCLKIA==
Date:   Fri, 1 Oct 2021 08:27:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-Id: <20211001082733.236bee605f506b2b62c055ef@kernel.org>
In-Reply-To: <87wnmx64mn.ffs@tglx>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
        <20210929112408.35b0ffe06b372533455d890d@kernel.org>
        <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
        <874ka17t8s.ffs@tglx>
        <20210930172206.1a34279b@oasis.local.home>
        <87wnmx64mn.ffs@tglx>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 01 Oct 2021 01:11:12 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Sep 30 2021 at 17:22, Steven Rostedt wrote:
> > On Thu, 30 Sep 2021 21:34:11 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> Masami, feel free to merge them over your tree. If not, let me know and
> >> I'll pick them up tomorrow morning.
> >
> > Masami usually goes through my tree. Want me to take it or do you want
> > to?
> 
> Now I'm really confused. Masami poke Ingo to merge stuff which goes
> usually through your tree !?!
> 
> But sure, feel free to pick it up. I have enough stuff on my plate
> already.

Let me explain how the patches are usually merged.

- kernel/kprobes.c related patches go through the tip tree.
- kernel/trace/* patches go through the tracing tree.

So traditionally(?) I think this series go through the tip tree,
but since the biggest user of kprobes is tracing and the kprobes fix
now involves tree-wide fixes as you can see in this series, I think
it is a good timing to move kprobes to tracing tree.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
