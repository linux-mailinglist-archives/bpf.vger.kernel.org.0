Return-Path: <bpf+bounces-1591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA971A36C
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83C3281811
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A613D3B5;
	Thu,  1 Jun 2023 15:57:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF63BA2F
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 15:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730CBC4339C;
	Thu,  1 Jun 2023 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685635048;
	bh=9OaGz13+l/QA7z5cUOU0i8QKJYWZwhghRWXY61VApNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrobPMMy+p/lPPl1dOLW42/3j+hyiMevHbh4W5grijSs2Pza7pX6Pdjj4nbskGGfq
	 Z7FBLZnteFZjvRZeaPG5HE+13t+h7AzaHR5A9hrhDRRqxhTB56OW/X82ysNLXylEna
	 uwSISr++vZ1oROigYthFsDGc0IHUYApcFOoevGUhxpwN3GZbJWg2coomug4IyJjc4S
	 p/0Z4/03qOi5koeVNUudR/pPWVgGpP5s+4AxWX3EplyCKcyTluRyXb6BlSrFVwP6Ei
	 PoNTSEsoyVFmrRib8RQxdvOj+UIcerWXzpyDlP4eo2kHloegyNJletnVX4lFZBfGgU
	 bfGLPhckypMTQ==
Date: Thu, 1 Jun 2023 17:57:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Thaler <dthaler@microsoft.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230601-legten-festplatten-fe053c6f16a4@brauner>
References: <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
 <20230601152414.GA71@W11-BEAU-MD.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601152414.GA71@W11-BEAU-MD.localdomain>

On Thu, Jun 01, 2023 at 08:24:14AM -0700, Beau Belgrave wrote:
> On Thu, Jun 01, 2023 at 11:46:13AM +0200, Christian Brauner wrote:
> > On Wed, May 17, 2023 at 05:10:47PM -0700, Alexei Starovoitov wrote:
> > > On Wed, May 17, 2023 at 9:50 AM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > > >
> > > > > >
> > > > > > Looks like user events were designed with intention to be unprivileged.
> > > > > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > > > > I doubt other people reviewed it from security perspective.
> > > > > >
> > > > > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> > > > > >
> > > > > > For example, I think the following is possible:
> > > > > > fd = open("/sys/kernel/tracing/user_events_data")
> > > > > > ioclt(fd, DIAG_IOCSDEL)
> > > > > >   user_events_ioctl_del
> > > > > >      delete_user_event(info->group, name);
> > > > > >
> > > > > > 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> > > > > > because only one global init_group is created.
> > > > > > So one user can unregister other user event by knowing 'name'.
> > > > > > A security hole, no?
> > > 
> > > ...
> > > 
> > > > Regarding deleting events, only users that are given access can delete
> > > > events. They must know the event name, just like users with access to
> > > > delete files must know a path (and have access to it). Since the
> > > > write_index and other details are per-process, unless the user has
> > > > access to either /sys/kernel/tracing/events/user_events/* or
> > > > /sys/kernel/tracing/user_events_status, they do not know which names are
> > > > being used.
> > > >
> > > > If that is not enough, we could require CAP_SYSADMIN to be able to
> > > > delete events even when they have access to the file. Users can also
> > > > apply SELinux policies per-file to achieve further isolation, if
> > > > required.
> > > 
> > > Whether /sys/kernel/tracing/user_events_status gets g+rw
> > > or it gets a+rw (as your documentation recommends)
> > > it is still a security issue.
> > > The "event name" is trivial to find out by looking at the source code
> > > of the target process or just "string target_binary".
> > > Restricting to cap_sysadmin is not the answer, since you want unpriv.
> > > SElinux is not the answer either.
> > > Since it's unpriv, different processes should not be able to mess with
> > > user events of other processes.
> > > It's a fundamental requirement of any kernel api.
> > > This has to be fixed before any bpf discussion.
> > > If it means that you need to redesign user_events do it now and
> > > excuses like "it's uapi now, so we cannot fix it" are not going to fly.
> > 
> > Looking at this a little because I have a few minutes.
> > What's all this unused code?
> > 
> 
> These are stubs to integrate namespace support. I've been working on a
> series that adds a tracing namespace support similiar to the IMA
> namespace work [1]. That series is ending up taking more time than I

Look, this is all well and nice but you've integrated user events with
tracefs. This is currently a single-instance global filesystem. So what
you're effectively implying is that you're namespacing tracefs by
hanging it off of struct user namespace making it mountable by
unprivileged users. Or what's the plan?

That alone is massive work with _wild_ security implications. My
appetite for exposing more stuff under user namespaces is very low given
the amount of CVEs we've had over the years.

> anticipated.

Yet you were confident enough to leave the namespacing stubs for this
functionality in the code. ;)

What is the overall goal here? Letting arbitrary unprivileged containers
define their own custom user event type by mounting tracefs inside
unprivileged containers? If so, what security story is going to
guarantee that writing arbitrary tracepoints from random unprivileged
containers is safe?

> 
> > static inline struct user_event_group
> > *user_event_group_from_user_ns(struct user_namespace *user_ns)
> > {
> >         if (user_ns == &init_user_ns)
> >                 return init_group;
> > 
> >         return NULL;
> > }
> > 
> > static struct user_event_group *current_user_event_group(void)
> > {
> >         struct user_namespace *user_ns = current_user_ns();
> >         struct user_event_group *group = NULL;
> > 
> >         while (user_ns) {
> >                 group = user_event_group_from_user_ns(user_ns);
> > 
> >                 if (group)
> >                         break;
> > 
> >                 user_ns = user_ns->parent;
> >         }
> > 
> >         return group;
> > }
> > 
> > User namespaces form strict hierarchies so you always end up at
> > init_user_ns no matter where you start from in the hierarchy. Return the
> > init_group and delete that code above.
> > 
> 
> This is a good point, I'll delete this code and bring it back as part of
> the namespace support patch series when appropriate.
> 
> > static char *user_event_group_system_name(struct user_namespace *user_ns)
> > {
> >         char *system_name;
> >         int len = sizeof(USER_EVENTS_SYSTEM) + 1;
> > 
> >         if (user_ns != &init_user_ns) {
> >                 /*
> >                  * Unexpected at this point:
> >                  * We only currently support init_user_ns.
> >                  * When we enable more, this will trigger a failure so log.
> >                  */
> >                 pr_warn("user_events: Namespace other than init_user_ns!\n");
> >                 return NULL;
> >         }
> > 
> > Your delegation model is premised on file permissions of a single file
> > in global tracefs. It won't work with user namespaces so let's not give
> > the false impression that this is on the table.
> > 
> 
> Users that are given access to the single file still should be able to
> be isolated for each other. The series I'm working on does this by

How? You currently have a single file that will have to be shared across
all unprivileged containers which ultimately can only mean that you need
to either bind-mount tracefs or bind-mount the single file into each
container. If you have 1000 containers each with isolated idmaps from
each other you're going to have a lot of fun trying to ensure that each
container has access rights to that file.

> changing the system name of user_events on a per-namespace basis.

What is the "system name" and how does it protect against namespaces
messing with each other?

