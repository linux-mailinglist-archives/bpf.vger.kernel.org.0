Return-Path: <bpf+bounces-797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55662706E99
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACCD1C20EB5
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0EE209BE;
	Wed, 17 May 2023 16:50:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C0442F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:50:38 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E109420B;
	Wed, 17 May 2023 09:50:37 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3515720F2699;
	Wed, 17 May 2023 09:50:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3515720F2699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684342236;
	bh=fj5KKO+rRLmhCSwZFf6yIt3piXlGYxI9+4eHY07uVyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuxkY8BiPsTcAMUQhyaeb3RhZpN5d5IO4NfYAdpy8mk4npZ5DQ8f3cxv/xPs6l7Qa
	 C1/PUMfetPzFbFgveIVQnMzf4KmDbfGpfX/a108nY2E/tdd2G0ZR3qK4Pp49J5yOIW
	 dSYyF5+Dvir9NG2q1kGSkUyfKnRnqlBfoLxEiy2g=
Date: Wed, 17 May 2023 09:50:28 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20230517165028.GA71@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516212658.2f5cc2c6@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 09:26:58PM -0400, Steven Rostedt wrote:
> On Tue, 16 May 2023 17:36:28 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> 
> > "
> > The user that will generate events must have x access to the tracing directory, e.g. chmod a+x /sys/kernel/tracing
> > The user that will generate events must have rw access to the tracing/user_events_data file, e.g. chmod a+rw /sys/kernel/tracing/user_events_data
> > "
> > So any unpriv user can create and operate user events.
> > Including seeing and enabling other user's user_events with 'ls/echo/cat' in tracefs.
> 
> It can see user_events_data, but x only gives you access into the directory.
> It does not get you the contents of the files within the directory. The
> above only gives access to the user_events_data. Which is to create events.
> 
> I recommended using groups and not giving access to all tasks.
> 
> > 
> > Looks like user events were designed with intention to be unprivileged.
> > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > I doubt other people reviewed it from security perspective.
> > 
> > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> > 
> > For example, I think the following is possible:
> > fd = open("/sys/kernel/tracing/user_events_data")
> > ioclt(fd, DIAG_IOCSDEL)
> >   user_events_ioctl_del
> >      delete_user_event(info->group, name);
> > 
> > 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> > because only one global init_group is created.
> > So one user can unregister other user event by knowing 'name'.
> > A security hole, no?
> > 
> > > and libside [2] will also help here.  
> > 
> > > [2] https://github.com/compudj/libside  
> > 
> > That's an interesting project. It doesn't do any user_events access afaict,
> 
> I'll let Beau answer the rest.
> 
> -- Steve

Mathieu and I have talked for the last year to align user_events with
the ability to also run user-space tracers together. I've sent a patch
out to Mathieu to add user_events to libside and was the main reason why
the ABI moved toward remote writes of bits.

Libside uses a binary description of event data that the kernel cannot
handle (yet). We talk about this almost each tracefs meeting, libside
can be used with user_events, however, the kernel side decoding is hard
to describe at the moment. We are working on a way to tell the kernel
about events via a binary format to achieve this.

Regarding deleting events, only users that are given access can delete
events. They must know the event name, just like users with access to
delete files must know a path (and have access to it). Since the
write_index and other details are per-process, unless the user has
access to either /sys/kernel/tracing/events/user_events/* or
/sys/kernel/tracing/user_events_status, they do not know which names are
being used.

If that is not enough, we could require CAP_SYSADMIN to be able to
delete events even when they have access to the file. Users can also
apply SELinux policies per-file to achieve further isolation, if
required.

Thanks,
-Beau

