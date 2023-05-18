Return-Path: <bpf+bounces-882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8E7086C7
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 19:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47562818FC
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908F27204;
	Thu, 18 May 2023 17:28:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5818C15
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 17:28:10 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA276E46;
	Thu, 18 May 2023 10:28:08 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB99A20FB193;
	Thu, 18 May 2023 10:28:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB99A20FB193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684430888;
	bh=Z+BpnlCktMUYP6DQ/MtmLt1ScIRlrfnbfip3prrS7PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLHhwpYSirb2eD7DNpwsVlAn2BQVhRLG+MIjzJpEeSXJ2XbORdIPcoJUw3TNNxqN9
	 acvSEFaQQdorx3Fdp85Ifvuo3cjVkimxp8nkRY8IqrsKLX+Njat1z+/c7tsUcHQoNw
	 I4grDO3ClzegD+ry3i5gENKby74D1fS4gx2zQ02Q=
Date: Thu, 18 May 2023 10:28:02 -0700
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
	Dave Thaler <dthaler@microsoft.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230518172802.GA71@W11-BEAU-MD.localdomain>
References: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230518001916.GB254@W11-BEAU-MD.localdomain>
 <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
 <20230518011814.GA294@W11-BEAU-MD.localdomain>
 <20230517220800.3d4cbad2@gandalf.local.home>
 <CAADnVQLtTOjHG=k5uwP_zrM_af4RdS8d5zgmLnVFSmq_=5m0Cg@mail.gmail.com>
 <20230518093600.3f119d68@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518093600.3f119d68@rorschach.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 09:36:00AM -0400, Steven Rostedt wrote:
> On Wed, 17 May 2023 20:14:31 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Wed, May 17, 2023 at 7:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > The delete IOCTL is different than reg/unreg. I don't see a problem with
> > > adding a CAP_SYSADMIN check on the delete IOCTL (and other delete paths)
> > > to prevent this. It shouldn't affect anything we are doing to add this
> > > and it makes it so non-admins cannot delete any events if they are given
> > > write access to the user_events_data file.  
> > 
> > sysadmin for delete is a pointless.
> > user_events_ioctl_reg() has the same issue.
> > Two different processes using you fancy TRACELOGGING_DEFINE_PROVIDER()
> > macro and picking the same name will race.
> > 
> > TRACELOGGING_DEFINE_PROVIDER( // defines the MyProvider symbol
> >     MyProvider, // Name of the provider symbol to define
> >     "MyCompany_MyComponent_MyProvider", // Human-readable provider
> > name, no ' ' or ':' chars.
> >     // {d5b90669-1aad-5db8-16c9-6286a7fcfe33} // Provider guid
> > (ignored on Linux)
> >     (0xd5b90669,0x1aad,0x5db8,0x16,0xc9,0x62,0x86,0xa7,0xfc,0xfe,0x33));
> > 
> > I totally get it that Beau is copy pasting these ideas from windows,
> > but windows is likely similarly broken if it's registering names
> > globally.
> > 
> > FD should be the isolation boundary.
> > fd = open("/sys/kernel/tracing/user_event")
> > and make sure all events are bound to that file.
> > when file is closed the events _should be auto deleted_.
> > 
> > That's another issue I just spotted.
> > Looks like user_events_release() is leaking memory.
> > user_event_refs are just lost.
> > 
> > tbh the more I look into the code the more I want to suggest to mark it
> > depends on BROKEN
> > and go back to redesign.
> 
> I don't think these changes require a redesign. I do like the idea that
> the events live with the fd. That is, when the fd dies, so does the event.
> 
> Although, we may keep it around for a bit (no new events, but being
> able to parse it. That is, the event itself isn't deleted until the fd
> is closed, and so is the tracing files being read are closed.
> 
> Beau,
> 
> How hard is it to give the event an owner, but not for task or user,
> but with the fd. That way you don't need to worry about other tasks
> deleting the event. And it also automatically cleans itself up. If we
> leave it to the sysadmin to clean up, it's going to cause leaks,
> because it's not something the sysadmin will want to do, as they will
> need to keep track of what events are created.
> 

We need to ensure that multiple processes can use the same event name:
Example we have shared libraries that processes use to publish events.

We need to ensure that if the original FD closes and other processes/FDs
are using it, those don't get ripped out from underneath it:
Example we have perf attached and then the process exits.

I think we can accomodate that all neatly if we just make the event
self-delete upon the last ref-count decrement. That way no one needs
the delete IOCTL and we can prevent things piling up.

We have flags in the struct, so we could either make this optional or
default. I like this approach Steven.

Thanks,
-Beau

> -- Steve
> 
> PS. I missed my connection due to unseasonal freezing temperatures, and
> my little airport didn't have a driver for the deicer, making my flight
> 2 hours delayed (had to wait for the sun to come up and deice the
> plane!). Thus, instead of enjoying myself by the pool, I'm in an
> airport lounge without much to do.

