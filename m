Return-Path: <bpf+bounces-64079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBBB0E1E1
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28CE3ADAC8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CC27E043;
	Tue, 22 Jul 2025 16:25:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CF27A90A;
	Tue, 22 Jul 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201550; cv=none; b=ltkwvOOcU65e6hzFxaL6SbWPL5SqrEwwuTYqPq49xTTbRlnVgHKt3D9xRaGM4Sj5d7UDTByqG8crb68Ni90dm+TeoJRAjucFIEqpQ//pzE1jZhZfk+z+Ew7aGhNNliw4s8Orcw09ngX3baFXOcA4MJzsLPuS6OCOvyz7qTvYP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201550; c=relaxed/simple;
	bh=iQ0L7zKGp9vE7yevaZZ7xufM0R/kXL2KFMRA6YVCZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITgm7B8yivhJ5FYh3Va/pruiMRE1ZxuyTuBXkRmmDXMh4sYiNHPLnUAxJD9DOIM0LpwoabQOBWPBsTvBJSMmwCk+Dufh369n7MP7BZgAJcFnS4Ix1CHVec8XBwdj6P3PIXoLSfkHnqKlMDe1yTE65AOohW/W4BMBlKfVox5bR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DCE0980490;
	Tue, 22 Jul 2025 16:25:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id CB3206000A;
	Tue, 22 Jul 2025 16:25:39 +0000 (UTC)
Date: Tue, 22 Jul 2025 12:25:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Brian Robbins
 <brianrob@microsoft.com>, Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-ID: <20250722122538.6ce25ca2@batman.local.home>
In-Reply-To: <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
	<20250721145343.5d9b0f80@gandalf.local.home>
	<e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
	<20250721171559.53ea892f@gandalf.local.home>
	<1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ryndd718dgoaufxffm3zwm8crqeuj3rd
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CB3206000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LpuwOIAPhxCnhK/c1MU3fQFDCY4qIJ0A=
X-HE-Tag: 1753201539-523560
X-HE-Meta: U2FsdGVkX19zubIwvDTsndw7WRIvMZu7CGBsWfzGhpwFuCSxr33qvs/TUJEXKGeshuibdaRejjw1yoD+i7GClP5ki5uYlA7g+QAzn38HeXcahTMxfGMqLiYLe/6+xuZMuin5noAOL+ede5tI/uHytsrpWEgl2MbGJq8+2HUBvdBEI7cTq6nTier36EtvsEMLG1t7B8bjsq/0+O1dSB6F2DEr7I34H98sc+MZM4VEZFpKYRVQBOE4kg8Djmrv1ynOaRbWdGsL6G7aT7h33WaSPrvtVZVY6PP7/wTQOqGU0X/cJL34OgaC8+Kxt929DVz00GD0gUyzYiyZAWxl09RcFer1H4EJlibCWBZiZIMCFlAkAjkz1dkS7IUSHSUoUY9w

On Tue, 22 Jul 2025 09:51:22 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Here's a hypothetical, what if for some reason (say having the sframe
> > sections outside of the elf file) that the linker shares that?  
> 
> So your hypothetical scenario is having sframe provided as a separate
> file. This sframe file (or part of it) would still describe how to
> unwind a given elf file text range. So I would argue that this would

No. It should describe how to get access to an sframe section for some
text that has already been loaded in memory.

I'm looking for a mapping between already loaded text memory to how to
unwind it that will be in an sframe format somewhere on disk.

> still fit into the model of CODE_REGISTER_ELF, it's just that the
> address range from sframe_start to sframe_end would be mapped from
> a different file. This is entirely up to the dynamic loader and should
> not impact the kernel ABI.
> 
> AFAIK the a.out binary support was deprecated in Linux kernel v5.1. So
> being elf specific is not an issue.

Yes, but we are not registering ELF. We are registering how to unwind
something with sframes. If it's not sframes we are registering, what is
it?

> 
> And if for some reason we end up inventing a new model to hand over the
> sframe information in the future, for instance if we choose not to map
> the sframe information in userspace and hand over a sframe-file pathname
> and offset instead, we'll just extend the code_opt enum with a new
> label.

This is not a new model. We could likely do it today without much
effort. We are handing over sframe data regardless if it's in an ELF
file or not.

The systemcall is to let the dynamic linker know where the kernel can
find the sframes for newly loaded text.

> 
> > 
> > For instance, if the sframe sections are downloaded separately as a
> > separate package for a given executable (to make it not mandatory for an
> > install), the linker could be smart enough to see that they exist in some
> > special location and then pass that to the kernel. In other words, this is
> > option is specific for sframe and not ELF. I rather call it by that.  
> 
> As I explained above, if the dynamic loader populates the sframe section
> in userspace memory, this fits within the CODE_REGISTER_ELF ABI. If we

But this isn't about ELF! It's about sframes! Why not name it that?

> eventually choose not to map the sframe section into userspace memory
> (even though this is not an envisioned use-case at the moment), we can
> just extend enum code_opt with a new label.

Why call this at all if you don't plan on mapping sframes?

> 
> >   
> >>
> >> If there are other file types in the future that happen to contain an
> >> sframe section (but are not ELF), then we can simply add a new label to
> >> enum code_opt.
> >>  
> >>>      
> >>>>
> >>>> sys_codectl(2)
> >>>> =================
> >>>>
> >>>> * arg0: unsigned int @option:
> >>>>
> >>>> /* Additional labels can be added to enum code_opt, for extensibility. */
> >>>>
> >>>> enum code_opt {
> >>>>        CODE_REGISTER_ELF,  
> >>>
> >>> Perhaps the above should be: CODE_REGISTER_SFRAME,
> >>>
> >>> as currently SFrame is read only via files.  
> >>
> >> As I pointed out above, on GNU/Linux, sframe is always an allocated,loaded
> >> ELF section. AFAIU, your comment implies that we'd want to support other scenarios
> >> where the sframe is in files outside of elf binary sframe sections. Can you
> >> expand on the use-case you have for this, or is it just for future-proofing ?  
> > 
> > Heh, I just did above (before reading this). But yeah, it could be. As I
> > mentioned above, this is not about ELF files. Sframes just happen to be in
> > an ELF file. CODE_REGISTER_ELF sounds like this is for doing special
> > actions to an ELF file, when in reality it is doing special actions to tell
> > the kernel this is an sframe table. It just happens that sframes are in
> > ELF. Let's call it for what it is used for.  
> 
> I see sframe as one "aspect" of an ELF file. Sure, we could do one
> system call for every aspect of an ELF file that we want to register,
> but that would require many round trips from userspace to the kernel
> every time a library is loaded. In my opinion it makes sense to combine
> all aspects of an elf file that we want the kernel to know about into
> one registration system call. In that sense, we're not registering just
> sframe, but the various aspects of an ELF file, which include sframe.

So you are making this a generic ELF function?  What other functions do
you plan to do with this system call?

> 
> By the way, the sframe section is optional as well. If we allow
> sframe_start and sframe_end to be NULL, this would let libc register
> an sframe-less ELF file with its pathname, build-id, and debug info
> to the kernel. This would be immediately useful on its own for
> distributions that have frame pointers enabled even without sframe
> section.

The above is called mission creep. Looks to me that you are using this
as a way to have LTTng get easier access to build ids and such. We can
add *that* later if needed, as a separate option. This has nothing to
do with the current requirements.


> >>>
> >>> And call it "struct code_sframe_info"
> >>>      
> >>>>        __u64 text_start;
> >>>>        __u64 text_end;  
> >>>      
> >>>>        __u64 sframe_start;
> >>>>        __u64 sframe_end;  
> >>>
> >>> What is the above "sframe" for?  
> > 
> > Still wondering what the above is for.  
> 
> Well we have an sframe section which is mapped into userspace memory
> from sframe_start to sframe_end, which contains the unwind information
> that covers the code from text_start to text_end.

Actually, the sframe section shouldn't be mapped into user space
memory. The kernel will be doing that, not the linker. I would say that
the system call can give a hint of where it would like it mapped, but
it should allow the kernel to decide where to map it as the user space
code doesn't care where it gets mapped.

In the future, if we wants to compress the sframe section, it will not
even be a loadable ELF section. But the system call can tell the
kernel: "there's a sframe compressed section at this offset/size in
this file" for this text address range and then the kernel will do the
rest.

> 
> Am I unknowingly adding some kind of redundancy here ?
> 

Maybe. This systemcall was to add unwinding information for the kernel.
It looks like you are having it be much more than that. I'm not against
that, but that should only be for extensions, and currently, this is
supposed to only make sframes work.

-- Steve

