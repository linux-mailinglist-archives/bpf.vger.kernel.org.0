Return-Path: <bpf+bounces-1568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0F71977F
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC13A2816FF
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB3200B5;
	Thu,  1 Jun 2023 09:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C941F949
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B577C433EF;
	Thu,  1 Jun 2023 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685612780;
	bh=Gg96iZLMK8kzUxxht+t3UCZqIJdqGyKJzoxElzCHMTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G41V2nFtvaFiwye0ois2vOYZ7ldqNDE+p9UzFe0Yk5SdBPDyZTZmJ4y7DYc/ijJUR
	 4OWaxzb1EsWig0l391kuS0m1m5i+kJ4lb2uO2YE1qE1znilIS1Iucyvs34i8H5NGOk
	 bZQRNxOPiwPopXLjSUsXh/Mtf7IrBB87RkWsjll1uHeXcT+5F5BmVTwCBDBTDhR/MP
	 KXK/LC9VvseIWD6nAmkcof7+j+CrvBH1UGzjnh5b3/WVnHrGOV4xuz9SK6eQTlCpT3
	 no61vbYDc29I07HzzxUqml0X76CbqGSH3yCJl0yC+x5RvKqM2rtapFx4twx0u/j4t5
	 AagXuirb/O0SA==
Date: Thu, 1 Jun 2023 11:46:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>

On Wed, May 17, 2023 at 05:10:47PM -0700, Alexei Starovoitov wrote:
> On Wed, May 17, 2023 at 9:50 AM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > >
> > > >
> > > > Looks like user events were designed with intention to be unprivileged.
> > > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > > I doubt other people reviewed it from security perspective.
> > > >
> > > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> > > >
> > > > For example, I think the following is possible:
> > > > fd = open("/sys/kernel/tracing/user_events_data")
> > > > ioclt(fd, DIAG_IOCSDEL)
> > > >   user_events_ioctl_del
> > > >      delete_user_event(info->group, name);
> > > >
> > > > 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> > > > because only one global init_group is created.
> > > > So one user can unregister other user event by knowing 'name'.
> > > > A security hole, no?
> 
> ...
> 
> > Regarding deleting events, only users that are given access can delete
> > events. They must know the event name, just like users with access to
> > delete files must know a path (and have access to it). Since the
> > write_index and other details are per-process, unless the user has
> > access to either /sys/kernel/tracing/events/user_events/* or
> > /sys/kernel/tracing/user_events_status, they do not know which names are
> > being used.
> >
> > If that is not enough, we could require CAP_SYSADMIN to be able to
> > delete events even when they have access to the file. Users can also
> > apply SELinux policies per-file to achieve further isolation, if
> > required.
> 
> Whether /sys/kernel/tracing/user_events_status gets g+rw
> or it gets a+rw (as your documentation recommends)
> it is still a security issue.
> The "event name" is trivial to find out by looking at the source code
> of the target process or just "string target_binary".
> Restricting to cap_sysadmin is not the answer, since you want unpriv.
> SElinux is not the answer either.
> Since it's unpriv, different processes should not be able to mess with
> user events of other processes.
> It's a fundamental requirement of any kernel api.
> This has to be fixed before any bpf discussion.
> If it means that you need to redesign user_events do it now and
> excuses like "it's uapi now, so we cannot fix it" are not going to fly.

Looking at this a little because I have a few minutes.
What's all this unused code?

static inline struct user_event_group
*user_event_group_from_user_ns(struct user_namespace *user_ns)
{
        if (user_ns == &init_user_ns)
                return init_group;

        return NULL;
}

static struct user_event_group *current_user_event_group(void)
{
        struct user_namespace *user_ns = current_user_ns();
        struct user_event_group *group = NULL;

        while (user_ns) {
                group = user_event_group_from_user_ns(user_ns);

                if (group)
                        break;

                user_ns = user_ns->parent;
        }

        return group;
}

User namespaces form strict hierarchies so you always end up at
init_user_ns no matter where you start from in the hierarchy. Return the
init_group and delete that code above.

static char *user_event_group_system_name(struct user_namespace *user_ns)
{
        char *system_name;
        int len = sizeof(USER_EVENTS_SYSTEM) + 1;

        if (user_ns != &init_user_ns) {
                /*
                 * Unexpected at this point:
                 * We only currently support init_user_ns.
                 * When we enable more, this will trigger a failure so log.
                 */
                pr_warn("user_events: Namespace other than init_user_ns!\n");
                return NULL;
        }

Your delegation model is premised on file permissions of a single file
in global tracefs. It won't work with user namespaces so let's not give
the false impression that this is on the table.

Plus, all of this is also called in a single place during
trace_events_user_init() which is called from fs_initcall() so you
couldn't even pass a different user namespace if you wanted to because
only init_user_ns exists.

