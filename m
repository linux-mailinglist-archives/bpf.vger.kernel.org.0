Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CDF1958FD
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0Oat (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 10:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgC0Oat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 10:30:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF5D206F2;
        Fri, 27 Mar 2020 14:30:47 +0000 (UTC)
Date:   Fri, 27 Mar 2020 10:30:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        "Shuah Khan" <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Message-ID: <20200327103046.08f06131@gandalf.local.home>
In-Reply-To: <60977a309b5d46979a9a9bbd46c10932@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
        <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
        <20200326214617.697634f3@oasis.local.home>
        <60977a309b5d46979a9a9bbd46c10932@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 27 Mar 2020 10:07:00 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > If needed, I can add a kernel command line option and a Kconfig that
> > makes this set to true by default.  
> 
> Maybe a different file 'trace_no_pause' ?

I rather not add another file, it adds more complexity, and confuses the
interface even more. I'll leave this as is.

> Along with the one that lets you read the raw trace and get EOF.

Can you explain this more? I think we talked about this before, but I don't
remember the details.

-- Steve
