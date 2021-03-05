Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A832E6E0
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEK6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 05:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEK6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 05:58:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 060A065017;
        Fri,  5 Mar 2021 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614941894;
        bh=tpGGos/+4wGJlmCH7+jmCnuleW/o3VbCDIjs2xkrdBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWzBFywBn6pibvyb63ukNW329oDFwIF51VDg3ZLjDiBrE+71K0AYTNEYf5cv0N93V
         6B6j+eXZj/kVLnu2EWLqMbP+wZcymdRcZhII+VPZfshVMuE8bQib7qKvMIyqTDtUON
         HjalYOsUZO2jc1ReVZHMAbk/s72yyhIDnPHDVfbPy4CU5JbNkj0SAGZ2zBk3z8ECTK
         S47bpW2pMm6kJ79/2TGUz5yjO7naoMtXvstmK660DJw/eHWdIB7wWCva3YWbeeyJdz
         uHA8/O6t0HQTbimx4/76Lwe4q3iH5P3ASXzk9RLt0aKjlaQNaQ73y9Fv4W5uPZIePQ
         9j0GNqlZNkw2g==
Date:   Fri, 5 Mar 2021 19:58:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, rostedt@goodmis.org,
        jpoimboe@redhat.com, kuba@kernel.org, ast@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Message-Id: <20210305195809.a9784ecf0b321c14fd18d247@kernel.org>
In-Reply-To: <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
References: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
        <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Mar 2021 18:28:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Daniel,
> 
> On Thu,  4 Mar 2021 16:07:52 -0800
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> 
> > Getting a stack trace from inside a kretprobe used to work with frame
> > pointer stack walks. After the default unwinder was switched to ORC,
> > stack traces broke because ORC did not know how to skip the
> > `kretprobe_trampoline` "frame".
> > 
> > Frame based stack walks used to work with kretprobes because
> > `kretprobe_trampoline` does not set up a new call frame. Thus, the frame
> > pointer based unwinder could walk directly to the kretprobe'd caller.
> > 
> > For example, this stack is walked incorrectly with ORC + kretprobe:
> > 
> >     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
> >     Attaching 1 probe...
> >     ^C
> > 
> >     @[
> >         kretprobe_trampoline+0
> >     ]: 1
> > 
> > After this patch, the stack is walked correctly:
> > 
> >     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
> >     Attaching 1 probe...
> >     ^C
> > 
> >     @[
> >         kretprobe_trampoline+0
> >         __x64_sys_nanosleep+150
> >         do_syscall_64+51
> >         entry_SYSCALL_64_after_hwframe+68
> >     ]: 12
> > 
> > Fixes: fc72ae40e303 ("x86/unwind: Make CONFIG_UNWINDER_ORC=y the default in kconfig for 64-bit")
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> OK, basically good, but this is messy, and doing much more than fixing issue.

BTW, is this a regression? or CONFIG_UNWINDER_ORC has this issue before?
It seems that the above commit just changed the default unwinder. This means
OCR stack unwinder has this bug before that commit. If you choose the 
CONFIG_UNWINDER_FRAME_POINTER, it might work again.

If so, it is not a regression. this need to be fixed, but ORC has this issue
from the original code.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
