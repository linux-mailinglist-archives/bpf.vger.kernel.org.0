Return-Path: <bpf+bounces-1589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551AB71A27A
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB071C21022
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82922D4D;
	Thu,  1 Jun 2023 15:24:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02982342E
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 15:24:24 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C76180;
	Thu,  1 Jun 2023 08:24:21 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 615A520FC4F7;
	Thu,  1 Jun 2023 08:24:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 615A520FC4F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1685633060;
	bh=edxnEpFJ4Hj6NmttSexMjCk8JmvOYStgFd1bZIF7afQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSR5eNhcPEhH7MfW1yw1FJwRgl+eKjbWudIV1/WByc4CQc2BPzhqLnKopTO2Sp9tn
	 4mn53BZuLBcByf9kaHrn+aFF8peURqjbB+L/6Tcak83Q/G4STosugNVj8BryLtLZeS
	 AR0kFWIKVCEFco0Lo5+oK/4Ak0KoYEQAdA8QdbuA=
Date: Thu, 1 Jun 2023 08:24:14 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Christian Brauner <brauner@kernel.org>
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
Message-ID: <20230601152414.GA71@W11-BEAU-MD.localdomain>
References: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 01, 2023 at 11:46:13AM +0200, Christian Brauner wrote:
> On Wed, May 17, 2023 at 05:10:47PM -0700, Alexei Starovoitov wrote:
> > On Wed, May 17, 2023 at 9:50 AM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > >
> > > > >
> > > > > Looks like user events were designed with intention to be unprivileged.
> > > > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > > > I doubt other people reviewed it from security perspective.
> > > > >
> > > > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> > > > >
> > > > > For example, I think the following is possible:
> > > > > fd = open("/sys/kernel/tracing/user_events_data")
> > > > > ioclt(fd, DIAG_IOCSDEL)
> > > > >   user_events_ioctl_del
> > > > >      delete_user_event(info->group, name);
> > > > >
> > > > > 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> > > > > because only one global init_group is created.
> > > > > So one user can unregister other user event by knowing 'name'.
> > > > > A security hole, no?
> > 
> > ...
> > 
> > > Regarding deleting events, only users that are given access can delete
> > > events. They must know the event name, just like users with access to
> > > delete files must know a path (and have access to it). Since the
> > > write_index and other details are per-process, unless the user has
> > > access to either /sys/kernel/tracing/events/user_events/* or
> > > /sys/kernel/tracing/user_events_status, they do not know which names are
> > > being used.
> > >
> > > If that is not enough, we could require CAP_SYSADMIN to be able to
> > > delete events even when they have access to the file. Users can also
> > > apply SELinux policies per-file to achieve further isolation, if
> > > required.
> > 
> > Whether /sys/kernel/tracing/user_events_status gets g+rw
> > or it gets a+rw (as your documentation recommends)
> > it is still a security issue.
> > The "event name" is trivial to find out by looking at the source code
> > of the target process or just "string target_binary".
> > Restricting to cap_sysadmin is not the answer, since you want unpriv.
> > SElinux is not the answer either.
> > Since it's unpriv, different processes should not be able to mess with
> > user events of other processes.
> > It's a fundamental requirement of any kernel api.
> > This has to be fixed before any bpf discussion.
> > If it means that you need to redesign user_events do it now and
> > excuses like "it's uapi now, so we cannot fix it" are not going to fly.
> 
> Looking at this a little because I have a few minutes.
> What's all this unused code?
> 

These are stubs to integrate namespace support. I've been working on a
series that adds a tracing namespace support similiar to the IMA
namespace work [1]. That series is ending up taking more time than I
anticipated.

> static inline struct user_event_group
> *user_event_group_from_user_ns(struct user_namespace *user_ns)
> {
>         if (user_ns == &init_user_ns)
>                 return init_group;
> 
>         return NULL;
> }
> 
> static struct user_event_group *current_user_event_group(void)
> {
>         struct user_namespace *user_ns = current_user_ns();
>         struct user_event_group *group = NULL;
> 
>         while (user_ns) {
>                 group = user_event_group_from_user_ns(user_ns);
> 
>                 if (group)
>                         break;
> 
>                 user_ns = user_ns->parent;
>         }
> 
>         return group;
> }
> 
> User namespaces form strict hierarchies so you always end up at
> init_user_ns no matter where you start from in the hierarchy. Return the
> init_group and delete that code above.
> 

This is a good point, I'll delete this code and bring it back as part of
the namespace support patch series when appropriate.

> static char *user_event_group_system_name(struct user_namespace *user_ns)
> {
>         char *system_name;
>         int len = sizeof(USER_EVENTS_SYSTEM) + 1;
> 
>         if (user_ns != &init_user_ns) {
>                 /*
>                  * Unexpected at this point:
>                  * We only currently support init_user_ns.
>                  * When we enable more, this will trigger a failure so log.
>                  */
>                 pr_warn("user_events: Namespace other than init_user_ns!\n");
>                 return NULL;
>         }
> 
> Your delegation model is premised on file permissions of a single file
> in global tracefs. It won't work with user namespaces so let's not give
> the false impression that this is on the table.
> 

Users that are given access to the single file still should be able to
be isolated for each other. The series I'm working on does this by
changing the system name of user_events on a per-namespace basis.

This prevents one namespace from messing with another, such as deleting
their events, etc. I'll reach out to you for some time to discuss this
direction to ensure I'm not off base.

> Plus, all of this is also called in a single place during
> trace_events_user_init() which is called from fs_initcall() so you
> couldn't even pass a different user namespace if you wanted to because
> only init_user_ns exists.

In later series this is also called upon file open of user_events_data
to find the right group, etc. I'll get this code removed for now and
bring it back later.

Thanks,
-Beau

1. https://lore.kernel.org/linux-kernel/20230206140253.3755945-1-stefanb@linux.ibm.com/

