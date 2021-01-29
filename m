Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3D308EFC
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhA2VG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhA2VGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 16:06:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFAC061574;
        Fri, 29 Jan 2021 13:05:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y10so1734758plk.7;
        Fri, 29 Jan 2021 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=svHdPZgLqtJE+8IVr/HG6v1HQu9hW/t0qmH9JopZHd8=;
        b=H4VU4KbsG3hrPzoJ5+2fg7DQvV7X6QigNR2NZqr15QyoBurVpacHXXslghTJzlRvop
         nyHJgDoZAX80hhx/npCIAq5e4mQgP7M/L2U6An8uQBp4Ao+TO53hCMdHII5Qi17qTydU
         yV2lzOUcqfh2sdcyvKb7FusiX5wQ2NW7UbjR9lUVo2xZVae6DvkiBvjgdeOFe5EEg+x1
         uY7BYQn4b9t/GVKBhbGIqnNKQ/PuMyUSRR3PVlWU+xTsCBN2rKkV8o4updwsIYFi5JKW
         Odv+y7OoXrc9wRU8sj6b8QR+dyltqLCYKrSEqE4Rbw+NfllkE5lGaPcMqbIfMmTY6fLe
         3mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svHdPZgLqtJE+8IVr/HG6v1HQu9hW/t0qmH9JopZHd8=;
        b=tq3QwEp+rWJefpT3Y9/9cu4wR9M/N0ZL+MGibSqsP03fNFIHr444jAufcG8+9NG59F
         wHj8VGJw7xEN5+AgPGx6r7wL3FY9ExrCiDyL37xHeY+eXRwKpo2QiP5xBAwndWPdAbox
         NzlK53KRS7ys6ACfonnYJjp++ilollYrxeZvXyzh7O/W/PSrj7QAZ065fbKyuKodb7Sr
         E2KF8KQF1jlAl20bw0mg2+eMwufUxfOZWC0/TW1UEBbGpG70tf8cL+aWJNKnjy+wgqiZ
         JL/4XODAhCanYpn6mPxaeqVzgGhvzYyTdQCZ9oVvj1KlSZ3jzhCqdFhSPJZcchCLKm0/
         lZKw==
X-Gm-Message-State: AOAM530kZiWk/4TxMboZaLiyz5jzhyxD9e1rzVZl8NdVCPQ/bczjhoc2
        sCMoHIDmvX9wR4NA5HG5ZgM=
X-Google-Smtp-Source: ABdhPJzk4t1e4hkmlrXIPj+RC30xgnCBYEKsYWP1q2wKp/wrOQM7DS3d/75SR3D4cskN+IJdRzLHyQ==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr6294534pjt.144.1611954336976;
        Fri, 29 Jan 2021 13:05:36 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6fa3])
        by smtp.gmail.com with ESMTPSA id c5sm9595550pfi.5.2021.01.29.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:05:35 -0800 (PST)
Date:   Fri, 29 Jan 2021 13:05:33 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210129210533.7s6udd3vobkgb27u@ast-mbp.dhcp.thefacebook.com>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
 <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
 <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home>
 <20210129162438.GC8912@worktop.programming.kicks-ass.net>
 <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
 <20210129175943.GH8912@worktop.programming.kicks-ass.net>
 <20210129140103.3ce971b7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129140103.3ce971b7@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 02:01:03PM -0500, Steven Rostedt wrote:
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
> I think the main difference is, if you attach a kprobe or ftrace function,
> you can theoretically analyze the location before you do the attachment.

Excatly.
When we're writing bpf helpers we need to carefully think about reentrance and NMI.
If the helper looks like:
int nokprobe notrace bpf_something(...)
{
  // access variables A and B
}

The implementation can rely on the fact that even if the helper is reentrant
the state of A and B will be consistent. Either both got touched or none.
Only NMI condition we have to worry about, because A could be modified 
without touching B.
If we write it as
int nokprobe bpf_something(...) { ... }
that would be another case.
Here we need to consider the case that bpf prog can be attached to it via fentry nop.
But no need to worry about instructions split in the middle because of kprobe via int3.
Since we have big "if (in_nmi()) goto unsupported;" check in the beginning we
only need to worry about combinations of kprobe at the start of the func,
kprobe anywhere inside the func via int3, and ftrace at the start.
Not having to think of NMI helps a ton.
My earlier this_cpu vs __this_cpu comment is an example of that.
If in_nmi is filtered early it's one implementation. If nmi has to be handled
it's completely different algorithm.
Now you've broke all this logic by making int3 to be marked as 'in_nmi' and
bpf in kprobe in the middle of the func are now broken.
Do people use that? Yeah they do.
We have to fix it.
What were your reasons to make int3 in_nmi?
I've read the commit log, but I don't see in it the actual motivation
for int3 other than "it looks like NMI to me. Let's make it so".
The commit logs talk about cpu exceptions. I agree that #DB and #MC do behave like NMI.
But #BP is not really. My understanding it's used by kprobes and text_poke_bp only.
If the motivation was to close some issue with text_poke_bp then, sure,
let's make handling of text_poke_bp to be treated as nmi.
But kprobe is not that.
I'm thinking either of the following solutions would be generic:
- introduce another state to preempt flags like "kernel exception"
- remove kprobe's int3 from in_nmi
As bpf specific alternative we can do:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6c0018abe68a..37cc549ad52e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -96,7 +96,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
        unsigned int ret;

-       if (in_nmi()) /* not supported yet */
+       if (in_nmi() && !kprobe_running()) /* not supported yet */
                return 1;

but imo it's less clean than the first two options.
