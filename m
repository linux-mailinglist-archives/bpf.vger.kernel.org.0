Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0D32C179
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391827AbhCCWts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242986AbhCCOhu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E13964EE1;
        Wed,  3 Mar 2021 14:26:07 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:26:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Message-ID: <20210303092604.59aea82c@gandalf.local.home>
In-Reply-To: <20210303134828.39922eb167524bc7206c7880@kernel.org>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
        <20210303134828.39922eb167524bc7206c7880@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 3 Mar 2021 13:48:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> 
> > 
> > I think (can't prove) this used to work:  

Would be good to find out if it did.

> 
> I'm not sure the bpftrace had correctly handled it or not.
> 
> > 
> >     # bpftrace -e 'kretprobe:__tcp_retransmit_skb { @[kstack()] = count() }'
> >     Attaching 1 probe...
> >     ^C
> > 
> >     @[
> >         kretprobe_trampoline+0
> >     ]: 1  
> 
> Would you know how the bpftrace stacktracer rewinds the stack entries?
> FYI, ftrace does it in trace_seq_print_sym()@kernel/trace/trace_output.c
> 

The difference between trace events and normal function tracing stack
traces is that it keeps its original return address. But kretprobes (and
function graph tracing, and some bpf trampolines too) modify the return
pointer, and that could possibly cause havoc with the stack trace.

-- Steve
