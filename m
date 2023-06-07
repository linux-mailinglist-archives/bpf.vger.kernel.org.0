Return-Path: <bpf+bounces-2013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C97269B8
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CCE2812D6
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1B3734B;
	Wed,  7 Jun 2023 19:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD796118
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 19:26:20 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B37801FDC;
	Wed,  7 Jun 2023 12:26:17 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0F3F20C1440;
	Wed,  7 Jun 2023 12:26:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0F3F20C1440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1686165977;
	bh=f1LMEbD3P/UcUgwpVy1pDfNCcNYjSOvLAPIcNYLpj5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuWFl3bcAqSiQg8bASdQ++6BkFmItki+WMWEN/gWWM3Lj9xRZdblFHi9vCYh8Za26
	 OYgy3uSMgh//J0tDf/XyrsjX/gOu4I8Bx7R8Tc5Ea66GJmkuFO2S3kDP8fv64h0Ndx
	 w7sSgpDxYSJf/sPo8NQThRGTTIeA/IHpRL0bi4XI=
Date: Wed, 7 Jun 2023 12:26:11 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Thaler <dthaler@microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230607192611.GA143@W11-BEAU-MD.localdomain>
References: <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
 <20230601152414.GA71@W11-BEAU-MD.localdomain>
 <20230601-legten-festplatten-fe053c6f16a4@brauner>
 <20230601162921.GA152@W11-BEAU-MD.localdomain>
 <20230606223752.65dd725c04b11346b45e0546@kernel.org>
 <20230606170549.GA71@W11-BEAU-MD.localdomain>
 <20230607230702.03c6d3a213d527a221bdc533@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607230702.03c6d3a213d527a221bdc533@kernel.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 07, 2023 at 11:07:02PM +0900, Masami Hiramatsu wrote:
> On Tue, 6 Jun 2023 10:05:49 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Tue, Jun 06, 2023 at 10:37:52PM +0900, Masami Hiramatsu wrote:
> > > Hi Beau,
> > > 
> > > On Thu, 1 Jun 2023 09:29:21 -0700
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > > > > These are stubs to integrate namespace support. I've been working on a
> > > > > > series that adds a tracing namespace support similiar to the IMA
> > > > > > namespace work [1]. That series is ending up taking more time than I
> > > > > 
> > > > > Look, this is all well and nice but you've integrated user events with
> > > > > tracefs. This is currently a single-instance global filesystem. So what
> > > > > you're effectively implying is that you're namespacing tracefs by
> > > > > hanging it off of struct user namespace making it mountable by
> > > > > unprivileged users. Or what's the plan?
> > > > > 
> > > > 
> > > > We don't have plans for unprivileged users currently. I think that is a
> > > > great goal and requires a proper tracing namespace, which we currently
> > > > don't have. I've done some thinking on this, but I would like to hear
> > > > your thoughts and others on how to do this properly. We do talk about
> > > > this in the tracefs meetings (those might be out of your time zone
> > > > unfortunately).
> > > > 
> > > > > That alone is massive work with _wild_ security implications. My
> > > > > appetite for exposing more stuff under user namespaces is very low given
> > > > > the amount of CVEs we've had over the years.
> > > > > 
> > > > 
> > > > Ok, I based that approach on the feedback given in LPC 2022 - Containers
> > > > and Checkpoint/Retore MC [1]. I believe you gave feedback to use user
> > > > namespaces to provide the encapsulation that was required :)
> > > 
> > > Even with the user namespace, I think we still need to provide separate
> > > "eventname-space" for each application, since it may depend on the context
> > > who and where it is launched. I think the easiest solution is (perhaps)
> > > providing a PID-based new groups for each instance (the PID-prefix or 
> > > suffix will be hidden from the application).
> > > I think it may not good to allow unprivileged user processes to detect
> > > the registered event name each other by default.
> > > 
> > 
> > Regarding PID, are you referring the PID namespace the application
> > resides within? Or the actual single PID of the process?
> 
> I meant the actual single PID of the process. That will be the safest
> way by default.
> 

How do you feel about instead of single PID using the effective user ID?

That way we wouldn't have so many events on the system, and the user is
controlling what runs and can share events.

I could see a way for admins to also override the user_event suffix on a
per-user basis to allow for broader event name scopes if required (IE:
Our k8s and production scenarios).

> > 
> > In production we monitor things in sets that encompass more than a
> > single application. A requirement we need is the ability to group
> > like-processes together for monitoring purposes.
> > 
> > We really need a way to know these set of events are for this group, the
> > easiest way to do that is by the system name provided on each event. If
> > this were to be single PID (and not the PID namespace), then we wouldn't
> > be able to achieve this requirement. Ideally an admin would be able to
> > setup the name in some way that means something to them in user-space.
> 
> Would you mean using the same events between several different processes?
> I think it needs more care about security concerns. More on this later.
> 
> If not, I think admin has a way to identify which processes are running in
> the same group outside of ftrace, and can set the filter correctly.
> 

Agree that's possible, but it's going to be a massive amount of events
for both tracefs and perf_event ring buffers to handle (we need a perf
FD per trace_event ID).

> > 
> > IE: user_events_critical as a system name, vs knowing (user_events_5
> > or user_events_6 or user_events_8) are "critical".
> 
> My thought is the latter. Then the process can not access to the
> other process's namespace each other.
> 
> > 
> > Another simple example is the same "application" but it gets exec'd more
> > than once. Each time it execs the system name would change if it was
> > really by the actual PID vs PID namespace. This would be very hard to
> > manage on a perf_event or eBPF level for us. It would also vastly
> > increase the number of trace_events that would get created on the
> > system.
> 
> Indeed. But fundamentally allowing user to create (register) the new 
> event means such DoS attack can happen. That's why we have a limitation
> of the max number of user_events. (BTW, I want to make this number
> controllable from sysctl or tracefs. Also, we need something against the
> event-id space contamination by this DoS attack.) 
> I also think it would be better to have some rate-limit about registering
> new events.
> 

Totally agree here.

> > 
> > > > 
> > > > > > anticipated.
> > > > > 
> > > > > Yet you were confident enough to leave the namespacing stubs for this
> > > > > functionality in the code. ;)
> > > > > 
> > > > > What is the overall goal here? Letting arbitrary unprivileged containers
> > > > > define their own custom user event type by mounting tracefs inside
> > > > > unprivileged containers? If so, what security story is going to
> > > > > guarantee that writing arbitrary tracepoints from random unprivileged
> > > > > containers is safe?
> > > > > 
> > > > 
> > > > Unprivileged containers is not a goal, however, having a per-pod
> > > > user_event system name, such as user_event_<pod_name>, would be ideal
> > > > for certain diagnostic scenarios, such as monitoring the entire pod.
> > > 
> > > That can be done in the user-space tools, not in the kernel.
> > > 
> > 
> > Right, during k8s pod creation we would create the group and name it
> > something that makes sense to the operator as an example. I'm sure there
> > are lots of scenarios user-space can do. However, they almost always
> > involve more than 1 application together in our scenarios.
> 
> Yeah, if it is always used with k8s in the backend servers, it maybe OK.
> But if it is used in more unreliable environment, we need to consider
> about malicious normal users.
> 
> > 
> > > > When you have a lot of containers, you also want to limit how many
> > > > tracepoints each container can create, even if they are given access to
> > > > the tracefs file. The per-group can limit how many events/tracepoints
> > > > that container can go create, since we currently only have 16-bit
> > > > identifiers for trace_event's we need to be cautious we don't run out.
> > > 
> > > I agree, we need to have a knob to limit it to avoid DoS attack.
> > > 
> > > > user_events in general has tracepoint validators to ensure the payloads
> > > > coming in are "safe" from what the kernel might do with them, such as
> > > > filtering out data.
> > > 
> > > [...]
> > > > > > changing the system name of user_events on a per-namespace basis.
> > > > > 
> > > > > What is the "system name" and how does it protect against namespaces
> > > > > messing with each other?
> > > > 
> > > > trace_events in the tracing facility require both a system name and an
> > > > event name. IE: sched/sched_waking, sched is the system name,
> > > > sched_waking is the event name. For user_events in the root group, the
> > > > system name is "user_events". When groups are introduced, the system
> > > > name can be "user_events_<GUID>" for example.
> > > 
> > > So my suggestion is using PID in root pid namespace instead of GUID
> > > by default.
> > > 
> > 
> > By default this would be fine as long as admins can change this to a larger
> > group before activation for our purposes. PID however, might be a bit
> > too granular of an identifier for our scenarios as I've explained above.
> > 
> > I think these logical steps make sense:
> > 1. Create "event namespace" (Default system name suffix, max count)
> > 2. Setup "event namespace" (Change system name suffix, max count)
> > 3. Attach "event namespace"
> > 
> > I'm not sure we know what to attach to in #3 yet, so far both a tracer
> > namespace and user namespace have been proposed. I think we need to
> > answer that. Right now everything is in the root "event namespace" and
> > is simply referred to by default as "user_events" as the system name
> > without a suffix, and with the boot configured max event count.
> 
> OK, so I think we are on the same page :)
> 
> I think the user namespace is not enough for protecting events on
> multi-user system without containers. So it has less flexibility.
> The new tracer namespace may be OK, we still need a helper user
> program like 'user_eventd' for managing access based on some policy.
> If we have a way to manage it with SELinux etc. it will be the best
> I think. (Perhaps using UNIX domain socket will give us such flexibility.)
> 

I'm adding Mathieu to CC since I think he had a few cases where a static
namespace wasn't enough and we might need hierarchy support.

If we don't need hierarchy support, I think it's a lot easier to do. I
like the idea of a per-user event namespace vs a per-PID event namespace
knowing what we have to do to monitor all of this via perf. Like I said
above, that will be a huge amount of events compared to a per-user or
namespace approach.

But I do like where this is headed and glad we are having this
conversation :)

Thanks,
-Beau

