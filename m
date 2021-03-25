Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A53348779
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 04:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhCYDZz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 23:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCYDZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 23:25:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 296B2619EE;
        Thu, 25 Mar 2021 03:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616642730;
        bh=G2jMw/CxVhfwI+lARDiDkf9hXk+3Sq4LeL7ZRcjEp2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eNcEUmR2so623VmkdCpmgRtK9S9J3v06vWus15G3OkV+vvnQM9LBDAmT3EZsmnhfz
         vVObW9w5GtqYAKWalpubKZ3M8OuQrUlHYAFJq1FQPo9lbVI8VGdajY4H3ve30v55CF
         +UwOiHkj4Ejoiy4AuEmwyP1JXevHrqJtPUf6HNHOsNisNr/tDxPeUIVbkucVzbHJzR
         iFEX3/hlGARhPw6sjXSlkUSJSCPdYCtaz6q4/68BBoAMuGUeOSZZDjIOl/Xdl2KUMC
         ZpGUdlC/rmlrbbjn/NKQAQRPF1efzen4VYc49FQsgudctSfeVRkMK2n6ix7voPk4xe
         H0jHfcSdNgHGQ==
Date:   Thu, 25 Mar 2021 12:25:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-Id: <20210325122524.91bca1233c0c254fdc0678fc@kernel.org>
In-Reply-To: <20210324202613.7cad6f4f@oasis.local.home>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639530062.895304.16962383429668412873.stgit@devnote2>
        <20210323223007.GG4746@worktop.programming.kicks-ass.net>
        <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
        <20210324160143.wd43zribpeop2czn@treble>
        <20210325084741.74bdb2b1d2ed00fe68840cea@kernel.org>
        <20210324202613.7cad6f4f@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Mar 2021 20:26:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 25 Mar 2021 08:47:41 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > I think the REGS and REGS_PARTIAL cases can also be affected by function
> > > graph tracing.  So should they use the generic unwind_recover_ret_addr()
> > > instead of unwind_recover_kretprobe()?  
> > 
> > Yes, but I'm not sure this parameter can be applied.
> > For example, it passed "state->sp - sizeof(unsigned long)" as where the
> > return address stored address. Is that same on ftrace graph too?
> 
> Stack traces on the return side of function graph tracer has never
> worked. It's on my todo list, because that's one of the requirements to
> get right if we every manage to combine kretprobe and function graph
> tracers together.

OK, then at this point let's just fix the kretprobe side.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
