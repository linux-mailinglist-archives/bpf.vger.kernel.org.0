Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE34308C0F
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhA2SAi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 13:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhA2SAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 13:00:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0FC061573;
        Fri, 29 Jan 2021 09:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PdDq2cdufJEB2VDwv/X3w5XT/JWi/Zx1Ja9u2w6DFT8=; b=Zq2r76xBQPM2w4sz8F1Ic9JdIr
        K4xDJquC8I8HblnYYrFJxCVsxWYhQYBKY5xyfjJu3C9bJTgiDowyAe/hALM4vu0T5AFbGtyvibPnT
        V1WjUa2Pn21M8EVbtcefCM7kHNZYCEj164cD3ga0tfq0TMjqoKdQndG4iTUgFH4IqKPjWE8wLmpex
        JgcQMLE9gpZ+C6ZfT+8z34TIzyz5aW1dPbMC5pXHzpC3CtuQNHrT6ikxivsdjdKChEke8lLPu8Owv
        zwllq5bNlNS4cH+LjL5DbAvow9XUi3pBeVmHHVx1QMJMxMzNwf7+H6JVhgFBSPlsPWXNoey77/f5h
        1MlSYgkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5Y3b-00A7Kv-MQ; Fri, 29 Jan 2021 17:59:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51EA4981210; Fri, 29 Jan 2021 18:59:43 +0100 (CET)
Date:   Fri, 29 Jan 2021 18:59:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210129175943.GH8912@worktop.programming.kicks-ass.net>
References: <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
 <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
 <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home>
 <20210129162438.GC8912@worktop.programming.kicks-ass.net>
 <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:
> Same things apply to bpf side. We can statically prove safety for
> ftrace and kprobe attaching whereas to deal with NMI situation we
> have to use run-time checks for recursion prevention, etc.

I have no idea what you're saying. You can attach to functions that are
called with random locks held, you can create kprobes in some very
sensitive places.

What can you staticlly prove about that?

