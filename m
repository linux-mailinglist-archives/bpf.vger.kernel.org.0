Return-Path: <bpf+bounces-683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E6705C00
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B5E281396
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F817C9;
	Wed, 17 May 2023 00:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918A15BD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 00:36:35 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7AA0;
	Tue, 16 May 2023 17:36:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64ab2a37812so9433660b3a.1;
        Tue, 16 May 2023 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684283793; x=1686875793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DbCsaFJ5HUSzzFyR5Jk1wsTg1s6htZ4DmsI1aHXbMI=;
        b=Lrd+IavJS9vN15bmIXyKVB3032WzAT7mFNY+aHYu3e2zOx285gCswOK/gmfN4G2NlS
         uua+zzTyAhMrT+To2fL5N1WKFhaeK3vnpgmW7Sui+lkc/PLukW14NGYYZZl7QzHGFIzv
         sFqj66zBPQl0TYjZ26Hy8Q1jj5+7/cJv1Yzh06OYcxk1zwN9lrlUVX5YVdIj0QDoGIga
         1fstdmck+aJxR4lHFUdPsgvJp1Bdb+Kf7EIoKHy4nc0LpTGYXLmkFz2ia9TksUDAfjBk
         MZj1TKCNY8IDTbGCM4cG+Xfdvt0wbkByRpPQrpSo4lkqAE2Vrt4/GKXUN1/eqG/Cv1qg
         Wxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684283793; x=1686875793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DbCsaFJ5HUSzzFyR5Jk1wsTg1s6htZ4DmsI1aHXbMI=;
        b=hB9tVtnxr77Fa6MQuUMU7G1zbjbuYRY4BKtbsPxU5Ude4frDFeBf7g825Z/ocxPset
         TD/xI0m361qEzDDn8dfeVuQ5aIhXqdZMLc8qMkEY34gn09hszeXVC2ltdkAquiiCQ4fa
         aXZM5jx2k3bAautoP8yOsodQpiPUkyFtiTOO1BPQTHxb71FTbDm/0PWxyOF27EhTdgLg
         kdBy06eFot73vhUPzqR9yowvSgiG3c0bZG/0awVPnarcbCFMy+nMXVWCXFx7ReyMSqnX
         oCnuQZeM16lb/+/pyBMML4SpzW9exguMhFT5WwDEELkBukiXc8naplJXhE1YqRFIWImZ
         oYkQ==
X-Gm-Message-State: AC+VfDwmcKRkASMQRLagFnExUpjDIt1O5JX3MYB5ITqr1zqD/VW/VF6C
	8wyhul82Aj2BQrDErBIGBPs=
X-Google-Smtp-Source: ACHHUZ5/pSzZzkLWe+D83JSbJoxL623SLba4R/b7Sdn9TJ+vdV4vMu+pYSTcxCfW4oCsm6tDzsxbwQ==
X-Received: by 2002:a17:902:c106:b0:1a9:a032:3844 with SMTP id 6-20020a170902c10600b001a9a0323844mr556581pli.16.1684283792472;
        Tue, 16 May 2023 17:36:32 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:1b12])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001a1a8e98e93sm16136464plh.287.2023.05.16.17.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 17:36:31 -0700 (PDT)
Date: Tue, 16 May 2023 17:36:28 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515192407.GA85@W11-BEAU-MD.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 12:24:07PM -0700, Beau Belgrave wrote:
> > > 
> > > 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> > > 				    &page, NULL, NULL);
> > 
> > ... which will call pin_user_pages_remote() in RCU CS.
> > This looks buggy, since pin_user_pages_remote() may schedule.
> > 
> 
> If it's possible to schedule, I can change this to cache the probe
> callbacks under RCU then drop it. However, when would
> pin_user_pages_remote() schedule with FOLL_NOFAULT? 

Are you saying that passing FOLL_NOFAULT makes it work in atomic context?
Is this documented anywhere?

> I couldn't pick up
> where it might schedule?

I think I see plenty of rw_semaphore access in the guts of GUP.

Have you tested user events with CONFIG_DEBUG_ATOMIC_SLEEP?

> 
> I don't see uprobes using ptrace_may_access() either, it replaces a page
> under the same situation. I modelled a lot of this based on what both
> futex and uprobes do for this.
> 
> If I missed something, I'm happy to add it. My understanding is that
> tracefs is acting as the security boundary here.

security boundary? but..

> Yes, it's easy to make mistakes when using the ABI directly. We have a
> library [1] to help with this, 

quoting [1]

> [1] https://github.com/microsoft/LinuxTracepoints

"
The user that will generate events must have x access to the tracing directory, e.g. chmod a+x /sys/kernel/tracing
The user that will generate events must have rw access to the tracing/user_events_data file, e.g. chmod a+rw /sys/kernel/tracing/user_events_data
"
So any unpriv user can create and operate user events.
Including seeing and enabling other user's user_events with 'ls/echo/cat' in tracefs.

Looks like user events were designed with intention to be unprivileged.
When I looked at kernel/trace/trace_events_user.c I assumed root.
I doubt other people reviewed it from security perspective.

Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.

For example, I think the following is possible:
fd = open("/sys/kernel/tracing/user_events_data")
ioclt(fd, DIAG_IOCSDEL)
  user_events_ioctl_del
     delete_user_event(info->group, name);

'info' is different for every FD, but info->group is the same for all users/processes/fds,
because only one global init_group is created.
So one user can unregister other user event by knowing 'name'.
A security hole, no?

> and libside [2] will also help here.

> [2] https://github.com/compudj/libside

That's an interesting project. It doesn't do any user_events access afaict,
but the concept is nice.
Looks like libside will work without user events just fine.
It's a pure user to user tracing framework similar to lttng.
Why microsoft cannot use just libside without user_events?

> > The design of user events looks fragile to me. One user process can write
> > into user_event of another process by supplying wrong 'write_index' and the
> > kernel won't catch it if data formats are compatible.
> >
> 
> The write_index is a per-process, per-fd index, you cannot do what you state
> unless a process shares it's internal FD and goes out of it's way to
> achieve that.

See it now.
struct user_event_file_info is indeed per-file/per-FD.
write_index is isolated enough.

> > s/perf_trace_buf_submit/perf_trace_run_bpf_submit/
> > 
> > may look trivial, but there is a lot to unpack here.
> > 
> > How bpf prog was attached to user event?
> > What is the life time of bpf prog?
> > What happens when user process crashes?
> > What happens when user event is unregistered ?
> > What is bpf prog context? Like, what helpers are allowed to be called?
> > Does libbpf need updating?
> > etc etc
> > 
> > No selftests were provided with this patch, so impossible to answer.
> > 
> 
> I thought it being a GPL export symbol that this kind of stuff would be
> documented somewhere if there are requirements to use the method. As it

EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
does not mean that any arbitrary code in the kernel or GPL-ed module
is free to call it whichever way they like.
It's an export symbol only because modules expose tracepoints.
It's an implementation detail of DECLARE_EVENT_CLASS macro and
can change at any time including removal of export symbol.

> stands in the patch, the data that is sent to BPF is from the buffer
> returned from perf_trace_buf_alloc() after it has been copied from the
> user process.
> 
> If the process crashes, that shouldn't affect the actual data. The
> tracepoint remains even upon a crash. If you try to unregister the
> tracepoint while BPF is attached, it is prevented, as the tracepoints
> are ref-counted and cannot be unregistered if anything is using it
> (user processes, ftrace, perf/bpf).
> 
> We have been using libbpf to attach and monitor user_events with this
> patch and haven't hit issues for what we plan to use it for (decode
> the payload, aggregate, and track what's happening per-TID/PID). The
> data we care about is already in kernel memory via the perf trace
> buffer.

What bpf prog type do you use? How does libbpf attach it?
You have to provide a patch for selftest/bpf/ for us to meaningfully review it.

> 
> > In general we don't want bpf to be called in various parts of the kernel
> > just because bpf was used in similar parts elsewhere.
> > bpf needs to provide real value for a particular kernel subsystem.
> > 
> 
> For sure. I've had a lot of requests within Microsoft to wire up BPF to
> user_events which prompted this patch. I've been in a few conversations
> where we start talking about perf_event buffers and teams stop and ask
> why it cannot go to BPF directly.

So you need perf_event buffers or ftrace ring buffer (aka trace_pipe) ?
Which one do you want to use ?

> Yeah, keep consistent was more about using the GPL export symbol, which
> the kernel tracepoints currently utilize. I wanted to avoid any special
> casing BPF needed to add for user_events, and I also expect users would
> like one way to write a BPF program for tracepoints/trace_events even
> if they are from user processes vs kernel.

BPF progs have three ways to access kernel tracepoints:
1. traditional tracepoint
2. raw tracepoint
3. raw tracepoint with BTF

1 was added first and now rarely used (only by old tools), since it's slow.
2 was added later to address performance concerns.
3 was added after BTF was introduced to provide accurate types.

3 is the only one that bpf community recommends and is the one that is used most often.

As far as I know trace_events were never connected to bpf.
Unless somebody sneaked the code in without us seeing it.

I think you're trying to model user_events+bpf as 1.
Which means that you'll be repeating the same mistakes.

> 
> > Beau,
> > please provide a detailed explanation of your use case and how bpf helps.
> > 
> 
> There are teams that have existing BPF programs that want to also pull
> in data from user processes in addition to the data they already collect
> from the kernel.
> 
> We are also seeing a trend of teams wanting to drop buffering approaches
> and move into non-buffered analysis of problems. An example is as soon
> as a fault happens in a user-process, they would like the ability to see
> what that thread has done, what the kernel did a bit before the error
> (or other processes that have swapped in, etc).

Sounds like bpf prog would need to access user memory.
What we've learned the hard way that you cannot do it cleanly from the kernel
tracepoint/trace_event/perf_event (and user_event in your case).
The only clean way to do it is from uprobe where it's user context and it is
sleepable and fault-able. That's why we've added 'sleepable bpf uprobes'.

Just going with perf_trace_run_bpf_submit() you'll only have 'best effort' access
to user data. Not recommended.

> We also have needs to aggregate operation duration live, and as soon as
> they deviate, trigger corrective actions. BPF is ideal for us to use for
> aggregating data cheaply, comparing that to other kernel and user
> processes, and then making a decision quickly on how to mitigate or flag
> it. We are working with OpenTelemetry teams to make this work via
> certain exporters in various languages (C#/C++/Rust).

Using bpf for in-kernel aggregation makes sense, of course.
But if you have to instrument your user processes why cannot you do
libside/lttng style aggregation and instrumentation?
You don't need the kernel to be in the path.
User to user can do it faster than going into the kernel.

> > Also please explain why uprobe/USDT and bpf don't achieve your goals.
> > Various user space applications have USDTs in them.
> > This is an existing mechanism that was proven to be useful to many projects
> > including glibc, python, mysql.
> > 
> > Comparing to user_events the USDTs work fine in unprivileged applications
> > and have zero overhead when not turned on. USDT is a single 'nop' instruction
> > while user events need if(enabled & bit) check plus iov prep and write.
> > 
> > When enabled the write() is probably faster than USDT trap, but all the extra
> > overhead in tracepoint and user_event_validate() probably makes it the same speed.
> > So why not USDT ?
> 
> User_events is being used in several production environments. These
> environments are heavily locked down for security and have several
> policies that prevent any modifications to executable pages (SELinux,
> IPE, etc). There are also other scenarios, such as runtime integrity
> checked processes, where the running code pages are periodically
> compared to known hashes that can be affected by patching as well.

"IPE" means microsoft's our-of-tree LSM ?
https://microsoft.github.io/ipe/ 

Quoting above:
"IPE cannot verify the integrity of anonymous executable memory,
such as the trampolines created by gcc closures and libffi, or JIT'd code"

I think C# does code modifications, so I don't believe your environment
means 'no code mods ever'.

afaik uprobe doesn't affect integrity. uprobe's nop->int3 rewrite doesn't trip IMA.

> We also have to support languages, like C# and Java, which don't have a
> stable location to apply a nop/int 3 patch, even when environments
> allow patching.

That's a fair point.

There were "dynamic USDT" and "Java Statically Defined Tracing probes (JSDT)"
in the past, but I don't know whether anyone ported them to Linux.

> We've used branch + syscall approaches in Windows for a long time and
> have found them to work well in these locked down environments as well
> as for JIT'd languages like C#.

Ok. Looks like we've got to the main reason for user_events.
Re-phrasing above statement. User_events-like facility existed in Windows
and we've decided to implement the same in Linux to have common framework
to monitor applications in both OSes.
Are you planning to extend bpf-for-windows to attach to window's equivalent
of user_events ?
If so, we can allow bpf progs to be attached to user_events in Linux.
Please send a proper patch with [PATCH bpf-next] subject targeting bpf-next
with selftest and clear explanation of the true reason.

Also think hard whether repeating our prior tracepoint+bpf mistakes is
really want you want to do with user_events+bpf.

