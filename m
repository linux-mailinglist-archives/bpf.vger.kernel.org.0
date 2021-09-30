Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69F41E521
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350724AbhI3X4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 19:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350480AbhI3X4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 19:56:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F9B26023E;
        Thu, 30 Sep 2021 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633046074;
        bh=73KhGeYtZ75e81uz1AB6/UCkcwIpW+bZ6GQVr7mgLp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1WNzD+A7gF24s2UflTHCQltbzDo63Y6FIFAnjd74NWiLgpGNnVOToYITZmhzHcTz
         /tB0vymvSikHITXC7mG+njO7i46RiGyZFPr9VFY49bvYnq84o4osahnfR+va1wsMvJ
         YTg9Kj9odwhfGB4lTodtZEPjjO3VZFxi73ABNwfj10PYseth6/8KtcpvDsKmgj1ilU
         /qz+6JmfKFU2A5M9hE0DiWjlSQkS7C2lTxJTKgPlaBBrOsFav2+OkK5/dWP78OVJcd
         pWXTQyYx8mWwRQKZLPKOroUFCEnINUKtNfPKDnmIhEr70UPac2nVDT3jyKnLBuKY0O
         coezJsFjI9YIg==
Date:   Fri, 1 Oct 2021 08:54:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20211001085429.eb031708a65f2f738479e93f@kernel.org>
In-Reply-To: <874ka17t8s.ffs@tglx>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
        <20210929112408.35b0ffe06b372533455d890d@kernel.org>
        <CAADnVQ+0v601toAz7wWPy2gxNtiJNZy6UpLmw_Dg+0G8ByJS6A@mail.gmail.com>
        <874ka17t8s.ffs@tglx>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 30 Sep 2021 21:34:11 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Sep 30 2021 at 11:17, Alexei Starovoitov wrote:
> 
> > On Tue, Sep 28, 2021 at 7:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>
> >> Hi Ingo,
> >>
> >> Can you merge this series to -tip tree since if I understand correctly,
> >> all kprobes patches still should be merged via -tip tree.
> >> If you don't think so anymore, I would like to handle the kprobe related
> >> patches on my tree. Since many kprobes fixes/cleanups have not been
> >> merged these months, it seems unhealthy now.
> >>
> >> Thank you,
> >
> > Linus,
> >
> > please suggest how to move these patches forward.
> > We've been waiting for this fix for months now.
> 
> Sorry, I've not paying attention to those as they are usually handled by
> Ingo who seems to be lost in space.
> 
> Masami, feel free to merge them over your tree. If not, let me know and
> I'll pick them up tomorrow morning.

Thank you Thomas for your proposal. As I send in the other mail,
if Steve can pick this as a part of tracing, I think that will be
better.

Thanks again,

> 
> Thanks,
> 
>         tglx


-- 
Masami Hiramatsu <mhiramat@kernel.org>
