Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0610C18EB5B
	for <lists+bpf@lfdr.de>; Sun, 22 Mar 2020 19:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVSH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Mar 2020 14:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVSH7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Mar 2020 14:07:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F61E2072E;
        Sun, 22 Mar 2020 18:07:57 +0000 (UTC)
Date:   Sun, 22 Mar 2020 14:07:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Message-ID: <20200322140756.7257b867@gandalf.local.home>
In-Reply-To: <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
        <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 21 Mar 2020 19:13:51 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 19 March 2020 23:22  
> ...
> > 
> > This patch series attempts to satisfy that request, by creating a
> > temporary buffer in each of the per cpu iterators to place the
> > read event into, such that it can be passed to users without worrying
> > about a writer to corrupt the event while it was being written out.
> > It also uses the fact that the ring buffer is broken up into pages,
> > where each page has its own timestamp that gets updated when a
> > writer crosses over to it. By copying it to the temp buffer, and
> > doing a "before and after" test of the time stamp with memory barriers,
> > can allow the events to be saved.  
> 
> Does this mean the you will no longer be able to look at a snapshot
> of the trace by running 'less trace' (and typically going to the end
> to get info for all cpus).

If there's a use case for this, it will be trivial to add an option to
bring back the old behavior. If you want that, I can do that, and even add
a config that makes it the default.

> 
> A lot of the time trace is being written far too fast for it to make
> any sense to try to read it continuously.
> 
> Also, if BPF start using ftrace, no one will be able to use it for
> 'normal debugging' on such systems.

I believe its used for debugging bpf, not for normal tracing. BPF only
uses this when it has their trace_printk() using it. Which gives that nasty
"THIS IS A DEBUG KERNEL" message ;-)   Thus, I don't think you need to
worry about bpf having this in production.

-- Steve
