Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC04337422
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 14:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhCKNhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 08:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233306AbhCKNhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 08:37:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA1E64E58;
        Thu, 11 Mar 2021 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615469845;
        bh=n0CFyaD+OPEnqD/eiqpQYp9OdOmi8VlVmPbOFU5UIh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQbLqQdUM9hVmJbchP/akM68qtvEgP48QZM01Bq4Si11WpcOUr/brLUKAu99Unxc/
         UjEYyKvLalAYYlFWDoovy2dvAIGoePgiaNsYXmUjACm+97FvxK7NNqkxluq0Ray5Vg
         LK5xXLr4t0Ovzw2t+4jNjYJZD5t/CEJ8tNf9XesdeYt1UaC+CL5fBSIWv2geUH8Opz
         R316ArcRJqnDqUuwJE2S85Gm/d8nF5M//XJoNKxrooPYx5adq8SikvRNATiz9d7hWd
         Bngzd3mUr/vn1wgnbebuLxVAP/7/0qMRG4xLSMhh6s8r/7q9eMh6OSXv6M5/4QXX18
         wLUUYxe1xjxdQ==
Date:   Thu, 11 Mar 2021 22:37:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 3/5] kprobes: treewide: Remove trampoline_address
 from kretprobe_trampoline_handler()
Message-Id: <20210311223720.dcdf5bdd65831028b8775dd7@kernel.org>
In-Reply-To: <20210311004225.77e844ff8170108bfb75b470@kernel.org>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <161495876994.346821.11468535974887762132.stgit@devnote2>
        <alpine.LSU.2.21.2103101258070.18547@pobox.suse.cz>
        <20210311004225.77e844ff8170108bfb75b470@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Miroslav,

On Thu, 11 Mar 2021 00:42:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > + */
> > > +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> > > +{
> > > +	return dereference_function_descriptor(kretprobe_trampoline);
> > > +}
> > > +
> > 
> > Would it make sense to use this in s390 and powerpc reliable unwinders?
> > 
> > Both
> > 
> > arch/s390/kernel/stacktrace.c:arch_stack_walk_reliable()
> > arch/powerpc/kernel/stacktrace.c:__save_stack_trace_tsk_reliable()
> > 
> > have
> > 
> > 	if (state.ip == (unsigned long)kretprobe_trampoline)
> > 		return -EINVAL;
> > 
> > which you wanted to hide previously if I am not mistaken.
> 
> I think, if "ip" means "instruction pointer", it should point
> the real instruction address, which is dereferenced from function
> descriptor. So using kretprobe_trampoline_addr() is good.

Ah, sorry I misunderstood the question. 

Yes, the per-arch stacktrace implementation must be fixed afterwards.
It is reliable or not depends on the actual unwinder implementation,
for example, on x86, frame-pointer based unwinder can unwind kretprobe,
but ORC based one doesn't (and discussing with Josh how to solve it)

Anyway since it strongly depends on the architecture, I would like to
leave those for each architecture stacktrace maitainer in this series.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
