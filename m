Return-Path: <bpf+bounces-841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35993707759
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 03:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295BB1C2100C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 01:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD8383;
	Thu, 18 May 2023 01:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127117E
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:18:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7454E359D;
	Wed, 17 May 2023 18:18:21 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 885B120F32CC;
	Wed, 17 May 2023 18:18:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 885B120F32CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684372700;
	bh=81K2zFI29GmLblWkf3Bk8py8o8c8dK06HRiAskbTDO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogygos9xC6TT8V6lfbkWYc++EuHALPVh0L8O7UcfRo/qx2FE+nmTlo8Ph4mJoe42+
	 05oD8t7DmFYXewZZeaK8tR/O76zTzRePDNiX9noLNNMq+cfPzidDoJGA/xulRBZM4c
	 DKqleDnl6BOqLFCP6TpwT8m5VxoR4hGMh9SC5c7I=
Date: Wed, 17 May 2023 18:18:14 -0700
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
Message-ID: <20230518011814.GA294@W11-BEAU-MD.localdomain>
References: <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230518001916.GB254@W11-BEAU-MD.localdomain>
 <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 05:56:34PM -0700, Alexei Starovoitov wrote:
> On Wed, May 17, 2023 at 5:19 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >
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
> >
> > I guess, if they have access to the binary, etc.
> > So they need both access to the binary and to the tracefs directory.
> > We would not give them access like this in any normal setup other than a
> > developer environment.
> >
> > > Restricting to cap_sysadmin is not the answer, since you want unpriv.
> >
> > We do not need unpriv to delete events, only to write and create events.
> >
> > We allow unregistering call-sites, which would still work unpriv with
> > this requirement.
> >
> > > SElinux is not the answer either.
> > > Since it's unpriv, different processes should not be able to mess with
> > > user events of other processes.
> >
> > How is this different than uprobes if we give a user access to
> > /sys/kernel/tracing/dynamic_events? Users can delete those as well. I
> > don't see a difference here.
> 
> Because kprobe/uprobe are root only.
> No sane person will do chmod a+rw /sys/kernel/tracing/uprobe_events.
> It's just like chmod a+rw /etc/passwd
> 
> Whereas this is your recommended approach for user_events.
> 

I believe those instructions are for development only. I'll get them
changed to a more secure approach. We don't want to folks leaving it
wide open.

We should tell folks to use a group and give access to the group like
Steven said earlier.

> > In our production environments we are not giving out wide security to
> > this file.
> 
> Fine by me. Keep it insecure and broken. Do not send bpf patches then.
> I refuse to have bpf callable from such subsystems.
> Somebody will inevitably blame bpf for the insecurity of user_events.

The delete IOCTL is different than reg/unreg. I don't see a problem with
adding a CAP_SYSADMIN check on the delete IOCTL (and other delete paths)
to prevent this. It shouldn't affect anything we are doing to add this
and it makes it so non-admins cannot delete any events if they are given
write access to the user_events_data file.

Thanks,
-Beau

