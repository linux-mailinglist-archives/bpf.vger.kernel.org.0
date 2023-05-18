Return-Path: <bpf+bounces-837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576007076DA
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1921C2101D
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1650196;
	Thu, 18 May 2023 00:19:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719A376
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 00:19:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 070EAE8;
	Wed, 17 May 2023 17:19:21 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B5A420F32C8;
	Wed, 17 May 2023 17:19:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B5A420F32C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684369160;
	bh=S9M1alb9uVliozl8bLTgpyAqeJ7VivwcVSxNbnWDzAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GO6GItu+7HwEA3QvXmgxHBYe0idt/BW4ZpMAqoNVT5SGXc3SUAJNXSnu3BaT/oiDw
	 pDL3gkCZakdBm0H1FtDO51gaZAuQuI1c7TghktL45OyC9cqESxZalztH+hPhrDw0S7
	 jTSL4AiN2LsFcjxS4c0Y4tb0gFo7/lOMe5PXtXMw=
Date: Wed, 17 May 2023 17:19:16 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230518001916.GB254@W11-BEAU-MD.localdomain>
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
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

I guess, if they have access to the binary, etc.
So they need both access to the binary and to the tracefs directory.
We would not give them access like this in any normal setup other than a
developer environment.

> Restricting to cap_sysadmin is not the answer, since you want unpriv.

We do not need unpriv to delete events, only to write and create events.

We allow unregistering call-sites, which would still work unpriv with
this requirement.

> SElinux is not the answer either.
> Since it's unpriv, different processes should not be able to mess with
> user events of other processes.

How is this different than uprobes if we give a user access to
/sys/kernel/tracing/dynamic_events? Users can delete those as well. I
don't see a difference here.

In our production environments we are not giving out wide security to
this file.

> It's a fundamental requirement of any kernel api.
> This has to be fixed before any bpf discussion.
> If it means that you need to redesign user_events do it now and
> excuses like "it's uapi now, so we cannot fix it" are not going to fly.

Thanks,
-Beau

