Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7E30939B
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 10:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhA3Jnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 04:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhA3DJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 22:09:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298AC061794;
        Fri, 29 Jan 2021 19:08:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id md11so6761507pjb.0;
        Fri, 29 Jan 2021 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fxxmy0+c2BO16EPS4+AnuzVSZ0E7CPss9SONuFG9YHI=;
        b=PEGwURYigrOxtk6A4BMnJcnVgyrOUdWGAsh7VPX3Te6XTPF3Fv8Ujuh3Is2A/i6bxl
         Dh96clPK2Qsu3As+pokjdjH+CqDxLUNtORvzUEzSaXQLI7cQcU9UlugfdHEZ31zX2fWl
         3oXK+GaB/SXdsdkZWViVT3auEdgzXejg+3Vmpw/ERdAxjR+/wNg3SMJE0HQ7i0oAzEQv
         0H20zJnkVoJ5GxJ1y7c1vhxQxA7ELWn/xv0qAWR3RV6fFD2pNkMK9xtwhZKzAtn+Lwqv
         jqDk8V8x+Kc663xwpwhQuR0INWZPBovJdT/ZcOqHwT7F4iQEsteTEB1meazJyQC3kGd0
         BBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxxmy0+c2BO16EPS4+AnuzVSZ0E7CPss9SONuFG9YHI=;
        b=NFH1ZoKFQNk+3u6rmIlFYocdBqdiorOHIPqzK6H/bHTbV/cZsXzrl4JCAq4su+oMF+
         UWx8OprY8+8RjWUq5ayX2tjs9eGWTttptI1hgEw17M8V0icEE2+hwqMqmlwFRU70Z2VO
         KOc6GGxIZA8QpeZrElXpC25/KhzPquNCULswd0vnMpdHcziynYiAdgwUzMUZWu9wUWIz
         MnOcidp4JrBRBthtwz/DFwnqO1WgmWnPr3aprNpICSoZAHyfxl9Fg9vb1ly23X/2srPR
         hFdcNnR4U6sPMC3CZ12CmZgDQQOTdZClQiuBvKE3fZYYiazMfnq9ZJPGXr+ywaqXkC2B
         2vzQ==
X-Gm-Message-State: AOAM533+tAa+nflD7Mg6t8d0f7lDweBGuMr1iICl6/59+3BvrRAG4Ziv
        ow9JHm5msO4SkLPBv/2OLVQ=
X-Google-Smtp-Source: ABdhPJw5pwwaClMLSiLgtaKds7hTF0U0HeHTIDUdkl2XiaqjnKvp6+VyLRjVD2pwpMwvShpDqKxIXg==
X-Received: by 2002:a17:90a:4494:: with SMTP id t20mr7280543pjg.155.1611976123785;
        Fri, 29 Jan 2021 19:08:43 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a3a0])
        by smtp.gmail.com with ESMTPSA id u31sm10527671pgl.9.2021.01.29.19.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 19:08:42 -0800 (PST)
Date:   Fri, 29 Jan 2021 19:08:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210130030840.hodq2ixpkdoue5jd@ast-mbp.dhcp.thefacebook.com>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
 <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
 <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home>
 <20210129162438.GC8912@worktop.programming.kicks-ass.net>
 <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
 <20210129175943.GH8912@worktop.programming.kicks-ass.net>
 <20210130110249.61fdad8f0cfe51a121c72302@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130110249.61fdad8f0cfe51a121c72302@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 30, 2021 at 11:02:49AM +0900, Masami Hiramatsu wrote:
> On Fri, 29 Jan 2021 18:59:43 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:
> > > Same things apply to bpf side. We can statically prove safety for
> > > ftrace and kprobe attaching whereas to deal with NMI situation we
> > > have to use run-time checks for recursion prevention, etc.
> > 
> > I have no idea what you're saying. You can attach to functions that are
> > called with random locks held, you can create kprobes in some very
> > sensitive places.
> > 
> > What can you staticlly prove about that?
> 
> For the bpf and the kprobe tracer, if a probe hits in the NMI context,
> it can call the handler with another handler processing events.
> 
> kprobes is carefully avoiding the deadlock by checking recursion
> with per-cpu variable. But if the handler is shared with the other events
> like tracepoints, it needs to its own recursion cheker too.
> 
> So, Alexei, maybe you need something like this instead of in_nmi() check.
> 
> DEFINE_PER_CPU(bool, under_running_bpf);
> 
> common_handler()
> {
> 	if (__this_cpu_read(under_running_bpf))
> 		return;
> 	__this_cpu_write(under_running_bpf, true);
> 	/* execute bpf prog */
> 	__this_cpu_write(under_running_bpf, false);	
> }
> 
> Does this work for you?

This exactly check is already in trace_call_bpf.
Right after if (in_nmi()).
See bpf_prog_active. It serves different purpose though.
Simply removing if (in_nmi()) from trace_call_bpf is a bit scary.
I need to analyze all code paths first.
