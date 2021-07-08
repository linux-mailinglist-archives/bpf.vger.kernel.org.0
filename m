Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A63BF470
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhGHELm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 00:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhGHELk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Jul 2021 00:11:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95F2B61CDD;
        Thu,  8 Jul 2021 04:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625717339;
        bh=wqJqFD3qGrE1t3kNGHSepaX9WVAOjtC6nrIZ4/hXn+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IszRWoKx3c5MPWQjXv4QChm84oBo0emYG/YlvTVVTorXYrcVQTeEpbqtk0bW+z58T
         tNtRSmPWY8k7fVTQcsfvl6BMdoNYNY7izmyIqF4NaUTh4pNi6w1cQ160QALl/BhWv3
         s6sbl2ncB1OX3UI8Pww+kFF8mgGpk1GWkbpT673Fw6gCJYEOcc5oVtP+FS4wAEHjyy
         D++e+I/hH4kuKdUpEDEb5W/RNCRyQSiq6HzQQooNyErxRhOozAHQMeu039nb+Zo8B7
         5e3vXPUcB4gFUUTCF7bpKemWgFRl4yPIvkX7EEG0UwMuZKHOCdf5xv437f+As23/lz
         sNl5ZcQCmQbxQ==
Date:   Thu, 8 Jul 2021 13:08:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v8 02/13] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_symbol_descriptor()
Message-Id: <20210708130856.ccb7cfb4f92e5896d597906a@kernel.org>
In-Reply-To: <CAEf4BzY1D7NsrBwt3nLFRbaESb7b5pR9arLhrg8OmOAfxi+kaw@mail.gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399994018.506599.10332627573727646767.stgit@devnote2>
        <CAEf4BzY1D7NsrBwt3nLFRbaESb7b5pR9arLhrg8OmOAfxi+kaw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Jul 2021 11:28:10 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, Jun 18, 2021 at 12:05 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Replace arch_deref_entry_point() with dereference_symbol_descriptor()
> > because those are doing same thing.
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Andrii Nakryik <andrii@kernel.org>
> 
> Hi Masami,
> 
> If you are going to post v9 anyway, can you please fix up my name, it
> should be "Andrii Nakryiko", thanks!

Oops, sorry. OK, I'll fix it.

Thank you,

> 
> > ---
> >  Changes in v6:
> >   - Use dereference_symbol_descriptor() so that it can handle address in
> >     modules correctly.
> > ---
> >  arch/ia64/kernel/kprobes.c    |    5 -----
> >  arch/powerpc/kernel/kprobes.c |   11 -----------
> >  include/linux/kprobes.h       |    1 -
> >  kernel/kprobes.c              |    7 +------
> >  lib/error-inject.c            |    3 ++-
> >  5 files changed, 3 insertions(+), 24 deletions(-)
> >
> 
> [...]


-- 
Masami Hiramatsu <mhiramat@kernel.org>
