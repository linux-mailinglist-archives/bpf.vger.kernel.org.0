Return-Path: <bpf+bounces-1954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA2724E5D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09AF1C20C03
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467222E46;
	Tue,  6 Jun 2023 20:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793B46BE
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 20:57:39 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3EBD1707;
	Tue,  6 Jun 2023 13:57:37 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id E580820BE492;
	Tue,  6 Jun 2023 13:57:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E580820BE492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1686085057;
	bh=0ETLWs8Ceu9GxJZiRavPxUta0//U9m1gAOQEZ5ERUwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8o1R6hOw20Q2OWIIrmyxakKURspNvlCCiRArHQP/p4Lbia0vbpaHE0XIODGn0J7a
	 qrJJbcbRtKDznCwU5ka91xEZMOmRPqe6/rIaCfxPTn9CT/zkyXE2iA6Ltz7AWuqx+a
	 MUkr3uiaEvsb+g67+0KFrI9OqGW8WzTVYC6H97fk=
Date: Tue, 6 Jun 2023 13:57:30 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.orgl,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230606205730.GA163@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230606225741.a9d8003a22451db96545b5a8@kernel.org>
 <CAEf4BzbhvBTQ2c1ENk2pVXdQ=SrXwTFXVjpopTANZsdn1EEeMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbhvBTQ2c1ENk2pVXdQ=SrXwTFXVjpopTANZsdn1EEeMA@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 06, 2023 at 09:57:14AM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 6, 2023 at 6:57 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > On Tue, 16 May 2023 17:36:28 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > BPF progs have three ways to access kernel tracepoints:
> > > 1. traditional tracepoint
> >
> > This is the trace_events, which is used by ftrace, right?
> >
> > > 2. raw tracepoint
> > > 3. raw tracepoint with BTF
> > >
> > > 1 was added first and now rarely used (only by old tools), since it's slow.
> > > 2 was added later to address performance concerns.
> > > 3 was added after BTF was introduced to provide accurate types.
> > >
> > > 3 is the only one that bpf community recommends and is the one that is used most often.
> > >
> > > As far as I know trace_events were never connected to bpf.
> > > Unless somebody sneaked the code in without us seeing it.
> >
> > With this design, I understand that you may not want to connect BPF
> > directly to user_events. It needs a different model.
> >
> > >
> > > I think you're trying to model user_events+bpf as 1.
> > > Which means that you'll be repeating the same mistakes.
> >
> > The user_events is completely different from the traceppoint and
> > must have no BTF with it.
> > Also, all information must be sent in the user-written data packet.
> > (No data structure, event if there is a structure, it must be fully
> > contained in the packet.)
> >
> > For the tracepoint, there is a function call with some values or
> > pointers of data structure. So it is meaningful to skip using the
> > traceevent (which converts all pointers to actual field values of
> > the data structure and store it to ftrace buffer) because most of
> > the values can be ignored in the BPF prog.
> >
> > However, for the user_events, the data is just passed from the
> > user as a data packet, and BPF prog can access to the data packet
> > (to avoid accessing malicious data, data validator can not be
> > skipped). So this seems like 1. but actually you can access to
> > the validated data on perf buffer. Maybe we can allow BPF to
> > hook the write syscall and access user-space data, but it may
> > not safe. I think this is the safest way to do that.
> 
> I'm trying to understand why we need a new kernel concept for all
> this. It looks like we are just creating a poor man's
> publisher/subscriber solution in the kernel, but mostly intend to use
> it from user-space? Why not just use Unix domain sockets for this,
> though? Use SOCK_SEQPACKET, put "event data" into a single packet
> that's guaranteed to not be broken up. Expose this to other processes
> through named pipes, if necessary.
> 
> Sorry if it's naive questions, but it's not clear what problem
> user_events are solving and why we need a new thing and can't use
> existing kernel primitives?
> 

There's a number of reasons why we did not do as you suggest.

The first reason is we want to only take the write() syscall cost when
events are wanting to be monitored. This is done at a per-trace_event
level and is not at a per-process level. user_events gives us the
ability to know cheaply when an event is or is not to be written. It
does this by setting/clearing a bit in each process when the trace_event
classes register function is invoked to attach/detach perf or ftrace.
By using a bit instead of bytes, we also have the ability to share
tracing out to the kernel as well as any local user tracer in the
future, this work was started by Mathieu Desnoyers via libside [1].

The second reason is we have found user based buffers to be unreliable
when either the user process is crashing or has a corruption bug. By
having the data buffers reside within the kernel, we prevent this from
happening. If the kernel panics, we can also pull events out of the
perf_event buffers via GDB to understand what our user processes were
doing before the time of the panic.

The third reason is we want to make use of all the features that perf,
ftrace, and eBPF have. We do not want to have to re-write all of those
features. The main things are being able to filter upon event payloads
and aggregate them together. We also selectively turn on and off stack
walking for some events (not all). Perf lets us selectively do this on a
per-event basis in addition to grabbing raw stack data to enable
unwinding via DWARF instructions. When we monitor events via
perf/ftrace, we can find each offset and type for the fields within the
event. We need to know these to properly decode events and analyze them.
Tracefs gives a us a single place to see all of these events and
efficiently decode them, including a stable event ID. We would have to
replicate all of that work in userspace in addition to the other
features we rely upon.

The fourth reason is related to the third, we have a lot of existing
diagnostics that rely upon and setup perf ring buffers. We want the user
and kernel diagnostics to land in the same buffers with the same
timestamps so we can see a full picture of what is going on.

Thanks,
-Beau

1. https://github.com/compudj/libside

> 
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

