Return-Path: <bpf+bounces-33947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECDE9283C1
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3D91F2482E
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 08:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EF145A0E;
	Fri,  5 Jul 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq9OZ0of"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310114533A;
	Fri,  5 Jul 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168551; cv=none; b=lBrQ6qd2lXXOq2G6kCehuyOCFMXefRBnW3HXBgEGU/funBgZMNPOGj4Ia04bYjgCntuLjyzm1F/7C/NBRWSFfVrHxzFp6tiEcp9K15x9YOKJivHLXagHLdvRQIbjWZTNURWlavmU37jLNlQC3Uw0BTx32D26GnrbDWiJW2bpy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168551; c=relaxed/simple;
	bh=MNz7b3od2m91SKCPk3ZE24cGHEIwGK1t0o1nU1+jcFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xy0/w/DfUjCzxHsf/JwfWAumMk5oVbJz075K7V/S5UXyN3vSH7zAR6W41jfuV+123PVCSItrcpDF+uVM8i98mK9nvYV81R28HIE89T3YLeuhasuqU+XOypGw9KsveNY7ozYdNHzeVlXXT2EP03mwqTjcWKpltI2k7K3jwp0hu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq9OZ0of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52407C116B1;
	Fri,  5 Jul 2024 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720168550;
	bh=MNz7b3od2m91SKCPk3ZE24cGHEIwGK1t0o1nU1+jcFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rq9OZ0ofPLJmjTIoBCd5CVKHpFFerQqDFHtMzXUmsRMIj1dKCfG6Gm+1Omcf5aogy
	 U5igp8YmSgCneI+jKUlDtVClH3yU8c+g7XjY6HhFd0lkpV3rIfQzspPaSxU+QoOJIf
	 xSfxP5jjvALRgtV3m5+Gji8vlsi0FX1BSNT4owFxkabG+YAs7EHW1Vo5mgFA/ga7SX
	 kZSEdUSxAjpS9xWLMbea51vZMpLCC4Zo9iG9gv4Tnev71Vcg16G3VhxC1lbdk0bmqh
	 pjfxprBTKIRIEYl1OdTN7gacNIscQf6zIQFtwFEMhr3TK582cr4kyLDDaBi+xCJYAn
	 sGlvb3pEk0kLQ==
Date: Fri, 5 Jul 2024 17:35:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-Id: <20240705173544.9ef034c30ae93c52164ecc1b@kernel.org>
In-Reply-To: <CAEf4BzYKVbCEGupX47fwM0XSzwwmXs+0sVpcAdp3poFLkjMA6Q@mail.gmail.com>
References: <20240701164115.723677-1-jolsa@kernel.org>
	<20240701164115.723677-2-jolsa@kernel.org>
	<20240703085533.820f90544c3fc42edf79468d@kernel.org>
	<CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
	<ZoV3rRUHEdvTmJjG@krava>
	<CAEf4BzYKVbCEGupX47fwM0XSzwwmXs+0sVpcAdp3poFLkjMA6Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 14:43:27 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Jul 3, 2024 at 9:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jul 02, 2024 at 05:13:38PM -0700, Andrii Nakryiko wrote:
> > > On Tue, Jul 2, 2024 at 4:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > Hi Jiri,
> > > >
> > > > On Mon,  1 Jul 2024 18:41:07 +0200
> > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > > Adding support for uprobe consumer to be defined as session and have
> > > > > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> > > > >
> > > > > The session means that 'handler' and 'ret_handler' callbacks are
> > > > > connected in a way that allows to:
> > > > >
> > > > >   - control execution of 'ret_handler' from 'handler' callback
> > > > >   - share data between 'handler' and 'ret_handler' callbacks
> > > > >
> > > > > The session is enabled by setting new 'session' bool field to true
> > > > > in uprobe_consumer object.
> > > > >
> > > > > We keep count of session consumers for uprobe and allocate session_consumer
> > > > > object for each in return_instance object. This allows us to store
> > > > > return values of 'handler' callbacks and data pointers of shared
> > > > > data between both handlers.
> > > > >
> > > > > The session concept fits to our common use case where we do filtering
> > > > > on entry uprobe and based on the result we decide to run the return
> > > > > uprobe (or not).
> > > > >
> > > > > It's also convenient to share the data between session callbacks.
> > > > >
> > > > > The control of 'ret_handler' callback execution is done via return
> > > > > value of the 'handler' callback. If it's 0 we install and execute
> > > > > return uprobe, if it's 1 we do not.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  include/linux/uprobes.h     |  16 ++++-
> > > > >  kernel/events/uprobes.c     | 129 +++++++++++++++++++++++++++++++++---
> > > > >  kernel/trace/bpf_trace.c    |   6 +-
> > > > >  kernel/trace/trace_uprobe.c |  12 ++--
> > > > >  4 files changed, 144 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > > index f46e0ca0169c..903a860a8d01 100644
> > > > > --- a/include/linux/uprobes.h
> > > > > +++ b/include/linux/uprobes.h
> > > > > @@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
> > > > >  };
> > > > >
> > > > >  struct uprobe_consumer {
> > > > > -     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> > > > > +     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
> > > > >       int (*ret_handler)(struct uprobe_consumer *self,
> > > > >                               unsigned long func,
> > > > > -                             struct pt_regs *regs);
> > > > > +                             struct pt_regs *regs, __u64 *data);
> > > > >       bool (*filter)(struct uprobe_consumer *self,
> > > > >                               enum uprobe_filter_ctx ctx,
> > > > >                               struct mm_struct *mm);
> > > > >
> > > > >       struct uprobe_consumer *next;
> > > > > +
> > > > > +     bool                    session;        /* marks uprobe session consumer */
> > > > > +     unsigned int            session_id;     /* set when uprobe_consumer is registered */
> > > >
> > > > Hmm, why this has both session and session_id?
> > >
> > > session is caller's request to establish session semantics. Jiri, I
> >
> > and session_id is set when uprobe is registered and used when
> > return uprobe is executed to find matching uprobe_consumer,
> > plz check handle_uretprobe_chain/session_consumer_find
> >
> > > think it's better to move it higher next to
> > > handler/ret_handler/filter, that's the part of uprobe_consumer struct
> > > which has read-only caller-provided data (I'm adding offset and
> > > ref_ctr_offset there as well).
> >
> > ok, makes sense
> >
> > >
> > > > I also think we can use the address of uprobe_consumer itself as a unique id.
> > >
> > > +1
> > >
> > > >
> > > > Also, if we can set session enabled by default, and skip ret_handler by handler's
> > > > return value, it is more simpler. (If handler returns a specific value, skip ret_handler)
> > >
> > > you mean derive if it's a session or not by both handler and
> > > ret_handler being set? I guess this works fine for BPF side, because
> > > there we never had them both set. If this doesn't regress others, I
> > > think it's OK. We just need to make sure we don't unnecessarily
> > > allocate session state for consumers that don't set both handler and
> > > ret_handler. That would be a waste.
> >
> > hum.. so the current code installs return uprobe if there's ret_handler
> > defined in consumer and also the entry 'handler' needs to return 0
> >
> > if entry 'handler' returns 1 the uprobe is unregistered
> >
> > we could define new return value from 'handler' to 'not execute the
> > 'ret_handler' and have 'handler' return values:
> >
> >   0 - execute 'ret_handler' if defined
> >   1 - remove the uprobe
> >   2 - do NOT execute 'ret_handler'  // this current triggers WARN
> >
> > we could delay the allocation of 'return_instance' until the first
> > consumer returns 0, so there's no perf regression
> >
> > that way we could treat all consumers the same and we wouldn't need
> > the session flag..
> >
> > ok looks like good idea ;-) will try that
> 
> Just please double check that we don't pass through 1 or 2 as a return
> result for BPF uprobes/multi-uprobes, so that we don't have any
> accidental changes of behavior.

Agreed. BTW, even if the uprobe is removed, the ret_handler should be called?
I think both 1 and 2 case, we should skip ret_handler.

> > > > >
> > > > >  #ifdef CONFIG_UPROBES
> > > > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > > > >       unsigned int                    depth;
> > > > >  };
> > > > >
> > > > > +struct session_consumer {
> > > > > +     __u64           cookie;
> > > >
> > > > And this cookie looks not scalable. If we can pass a data to handler, I would like to
> > > > reuse it to pass the target function parameters to ret_handler as kretprobe/fprobe does.
> > > >
> > > >         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, void *data);
> > > >
> > > > uprobes can collect its uc's required sizes and allocate the memory (shadow stack frame)
> > > > at handler_chain().
> > >
> > > The goal here is to keep this simple and fast. I'd prefer to keep it
> > > small and fixed size, if possible. I'm thinking about caching and
> > > reusing return_instance as one of the future optimizations, so if we
> > > can keep this more or less fixed (assuming there is typically not more
> > > than 1 or 2 consumers per uprobe, which seems realistic), this will
> > > provide a way to avoid excessive memory allocations.

Hmm, so you mean user will allocate another "data map" and use cookie as
a key to access the data? That is possible but sounds a bit redundant.
If such "data map" allocation is also provided, it is more useful.


Thank you,




-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

