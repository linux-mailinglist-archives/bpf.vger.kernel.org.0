Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8509C429967
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 00:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhJKWZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 18:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235551AbhJKWZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 18:25:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C7F60EDF;
        Mon, 11 Oct 2021 22:23:36 +0000 (UTC)
Date:   Mon, 11 Oct 2021 18:23:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: BTF testing for kprobe-events
Message-ID: <20211011182334.5030b2d8@gandalf.local.home>
In-Reply-To: <163240078318.34105.12819521680435948398.stgit@devnote2>
References: <163240078318.34105.12819521680435948398.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Sep 2021 21:39:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 

Hi Masami,

Sorry for the late reply, but Plumbers followed by OSS put me way behind,
and I just got to this email :-/

> Here I share my testing patch of the BTF for kprobe events.
> Currently this only allow user to specify '$$args' for
> tracing all arguments of the function. This is only
> avaialbe if
> - the probe point is on the function entry
> - the kernel is compiled with BTF (CONFIG_DEBUG_INFO_BTF)
> - the kernel is enables BPF (CONFIG_BPF_SYSCALL)
> 
> And Special thanks to Sven! Most of BTF handling part of
> this patch comes from his patch [1]
> 
> [1] https://stackframe.org/0001-ftrace-arg-hack.patch

Which is newer than this patch because he sent a v2, and that's a couple
patches down in my queue. I'll be looking at that one shortly as well.

> 
> What I thought while coding this were;
> - kernel/bpf/btf.c can be moved under lib/ so that
>   the other subsystems can reuse it, independent
>   from BPF. (Also, this should depends on CONFIG_DEBUG_INFO_BTF)

Makes sense.

> - some more utility functions can be exposed.
>   e.g. I copied btf_type_int() from btf.c

Agreed.

> - If there are more comments for the BTF APIs, it will
>   be more useful...
> - Overall, the BTF is easy to understand for who
>   already understand DWARF. Great work!

Great to hear.

> - I think I need 'ptr' and 'bool' types for fetcharg types.
> 
> Anyway, this is just for testing. I have to add some
> more cleanup, features and documentations, etc.

This is awesome, and something to look at for a generic ftrace args point
of view too.

One issue is how do we handle multiple register values? Like a u64 type on
32 bit?  As $arg1 is just a register that is in $arg1, for a u64 parameter
on 32 bit, that is usually handled with two registers.

Have thoughts on that?

I'll play with your patch today.

-- Steve
