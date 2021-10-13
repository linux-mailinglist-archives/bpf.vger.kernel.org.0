Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71942C098
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhJMMyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 08:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhJMMyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Oct 2021 08:54:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FF3161056;
        Wed, 13 Oct 2021 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634129528;
        bh=B1we/1rhh47HXdi5xle8mIjVtZAvV3OZ7/uPp5PXin8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BUpuSC89Zq+F9IBO/x+eY5VmrHqfG6dte2movuS0Mo6WrzDQTu72j/cGp3hFSCSJV
         8AMnH4DXezNjSz3uSNP+HZxLu6UHR1o/FLXPaeNkRAmg953SMtipwtepUKP72uRr/w
         oQFMPhehDv71jAptcLFn3LoV6RmR1OISvmrMsNq4s9Mc/kKhODo9CpQVMKZwSbNbSI
         LmItxn78t3cLbWF6aT8W/nUqFgpAeTljWsmZ84cY9nzFDdWuDV/MDgIoJP3YL/Rq13
         A7ZC22Y9aXHTwFANRb+qDq/v5oRyjJLfuA5kxhKWZa2bmJcILuF1++Tsa1t8cb+MSM
         qqtCusI2zD3FA==
Date:   Wed, 13 Oct 2021 21:52:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: BTF testing for kprobe-events
Message-Id: <20211013215206.c7b49db96a939fc71eb988b3@kernel.org>
In-Reply-To: <20211011182334.5030b2d8@gandalf.local.home>
References: <163240078318.34105.12819521680435948398.stgit@devnote2>
        <20211011182334.5030b2d8@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Oct 2021 18:23:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 23 Sep 2021 21:39:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> 
> Hi Masami,
> 
> Sorry for the late reply, but Plumbers followed by OSS put me way behind,
> and I just got to this email :-/
> 
> > Here I share my testing patch of the BTF for kprobe events.
> > Currently this only allow user to specify '$$args' for
> > tracing all arguments of the function. This is only
> > avaialbe if
> > - the probe point is on the function entry
> > - the kernel is compiled with BTF (CONFIG_DEBUG_INFO_BTF)
> > - the kernel is enables BPF (CONFIG_BPF_SYSCALL)
> > 
> > And Special thanks to Sven! Most of BTF handling part of
> > this patch comes from his patch [1]
> > 
> > [1] https://stackframe.org/0001-ftrace-arg-hack.patch
> 
> Which is newer than this patch because he sent a v2, and that's a couple
> patches down in my queue. I'll be looking at that one shortly as well.

Did he send his BTF hack patch to you ?
I didn't notice that.


> > What I thought while coding this were;
> > - kernel/bpf/btf.c can be moved under lib/ so that
> >   the other subsystems can reuse it, independent
> >   from BPF. (Also, this should depends on CONFIG_DEBUG_INFO_BTF)
> 
> Makes sense.
> 
> > - some more utility functions can be exposed.
> >   e.g. I copied btf_type_int() from btf.c
> 
> Agreed.
> 
> > - If there are more comments for the BTF APIs, it will
> >   be more useful...
> > - Overall, the BTF is easy to understand for who
> >   already understand DWARF. Great work!
> 
> Great to hear.
> 
> > - I think I need 'ptr' and 'bool' types for fetcharg types.
> > 
> > Anyway, this is just for testing. I have to add some
> > more cleanup, features and documentations, etc.
> 
> This is awesome, and something to look at for a generic ftrace args point
> of view too.
> 
> One issue is how do we handle multiple register values? Like a u64 type on
> 32 bit?  As $arg1 is just a register that is in $arg1, for a u64 parameter
> on 32 bit, that is usually handled with two registers.
> 
> Have thoughts on that?

Oh, that's a good point! The probe event supports such case, since I expected
the user will use 2 arguments to record it. But indeed, using BTF means we need
such extension.
OK, let me consider how to extend fetchargs to support it.

Thank you!

> 
> I'll play with your patch today.
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
