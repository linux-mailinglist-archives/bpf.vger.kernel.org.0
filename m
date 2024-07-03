Return-Path: <bpf+bounces-33779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE89265B0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F61AB272E9
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82668187544;
	Wed,  3 Jul 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE4SoZ7l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D61822C8;
	Wed,  3 Jul 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022967; cv=none; b=ENfNk2nw+oUc7qBeAUVD2X4Ebcng9FE0Q9+P2gx/DL4ZnCnRbL5IYVSKkWGHA9lwP1pC/3ZyQwzkKuKoKWwGtzRON8wFjnVDt1cQJDf9rarclja366k0ykQ/q6/7RU9PCejs6mHaAa1tjAw/RxURKvnWfsfM4Cs51a6BeL4QqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022967; c=relaxed/simple;
	bh=t4iW7lBcz3MGBh+u2TsCN4v259jNbuNs7J3WIlww2zM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRFWh7RkUQtoofL4DSpYad8NskzavuAlsEdY3CEMW7y/nGugv5IZHchlQQZW3y+FO9MMV85ny/B0EycasGHcrhhIsxJkYktO52JSWHlVIa1FuyS/CCHPjGEd+qdAGMYTfP+UByKI2Bh8yR9L0ipumBkaOt5M9JjRWdlB/4uE3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE4SoZ7l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so33592355e9.2;
        Wed, 03 Jul 2024 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720022964; x=1720627764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+CHxrZ7qtoT8BKTUaekwlP3cat/UcO3wyY4oAUzx8s=;
        b=HE4SoZ7ltoFhvePSZftpAoSeVgiRR+LuxEme8JJk7+ysQ06TbDp74uL/9HcCSrNLEm
         5l00QWTDFdfXP7NPB2w9e3duDfZtNdknU4d6lkfOap/oWCj8IOikqPlwvNZtUBhagxVJ
         c6JfSjPIVRxOHs1bukFHw57jHpMH6YvemZrXvFf7gh19KfQDn8wh4kAirad4rQYniTQA
         8QAMYo3TH4uc4kNHo4pK8lbgjLL3xpO9O4dXC2QHMyFX2EIYeJF5RevfoT8BNX2znEk4
         ZLca3zuJeQpW6MfTn7PTqV5NbUZvD+ohCt5ETmcsMaIw4pcPcred9nN09MrUWISO70Qs
         CDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022964; x=1720627764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+CHxrZ7qtoT8BKTUaekwlP3cat/UcO3wyY4oAUzx8s=;
        b=OhKCaNhd8NZwkMuD/IdWdrlC0cci7D+hQGkvBylIHjxs0uBZIrAbBTd7z1doSXs2Do
         IDrI9l186yYsvmt0Nri5BvscC4+kT0pPIGSY/9n1rNGVlu1DG6Ga8o8stK74OWKg8NL+
         xlk6AEbfU+eaBqT5RyhwAcMTlIcbdb9m8lKkipHkhEB6L4c+R5Sc1dZKqwVVDH+w7XXV
         JY5uOzSGE9yfYcbwguewuJgW8GzoQReMd/5t2GptCvFKnf3zGOmF6QiYx16N5BVw3v81
         s5hBl8RkB0jHP2qf058mNx33oDJkXO/BLMeJFemMHtRrQuV6vRYCMnQpcnhnDKm5ckyA
         bKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtd8FHQckh2j8EvboZdx3cQNXSKHOd8fKWob9fINg+fukS+kQazH4vzvs/GUs2bDWy81xzbJDCObLmlCPNELb9MqyE1rRGhXVS+KhBe4odWXhMarKeLfeR8meu5NktO9UWAkeKdkHP8j2gqOKjGpogef1fb1gdyzX+6Z2Vx3HlcT3hdIn1
X-Gm-Message-State: AOJu0Yw2y5PcMjvkDwu1bh/sZ7/ZjT14qibf5rRKRBdpyyQbGnu95GyD
	QU3lERZbUc/YPE6/KZgF8QdSTQgOeAtH/FxgP5n7lvgUCG0FyB6M
X-Google-Smtp-Source: AGHT+IFOaHsI2OUQyY5F67H8NM44xcYZe4pbNrjUXpk995cJtsWH9MtvzobpmdfYGMDAq7foffVEuw==
X-Received: by 2002:a05:600c:4f50:b0:425:73ba:e012 with SMTP id 5b1f17b1804b1-42579ffcce8mr97229955e9.7.1720022963234;
        Wed, 03 Jul 2024 09:09:23 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b061eedsm233590495e9.26.2024.07.03.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:09:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 18:09:17 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <ZoV3rRUHEdvTmJjG@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240703085533.820f90544c3fc42edf79468d@kernel.org>
 <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>

On Tue, Jul 02, 2024 at 05:13:38PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 2, 2024 at 4:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jiri,
> >
> > On Mon,  1 Jul 2024 18:41:07 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > > Adding support for uprobe consumer to be defined as session and have
> > > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> > >
> > > The session means that 'handler' and 'ret_handler' callbacks are
> > > connected in a way that allows to:
> > >
> > >   - control execution of 'ret_handler' from 'handler' callback
> > >   - share data between 'handler' and 'ret_handler' callbacks
> > >
> > > The session is enabled by setting new 'session' bool field to true
> > > in uprobe_consumer object.
> > >
> > > We keep count of session consumers for uprobe and allocate session_consumer
> > > object for each in return_instance object. This allows us to store
> > > return values of 'handler' callbacks and data pointers of shared
> > > data between both handlers.
> > >
> > > The session concept fits to our common use case where we do filtering
> > > on entry uprobe and based on the result we decide to run the return
> > > uprobe (or not).
> > >
> > > It's also convenient to share the data between session callbacks.
> > >
> > > The control of 'ret_handler' callback execution is done via return
> > > value of the 'handler' callback. If it's 0 we install and execute
> > > return uprobe, if it's 1 we do not.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/uprobes.h     |  16 ++++-
> > >  kernel/events/uprobes.c     | 129 +++++++++++++++++++++++++++++++++---
> > >  kernel/trace/bpf_trace.c    |   6 +-
> > >  kernel/trace/trace_uprobe.c |  12 ++--
> > >  4 files changed, 144 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index f46e0ca0169c..903a860a8d01 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
> > >  };
> > >
> > >  struct uprobe_consumer {
> > > -     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> > > +     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
> > >       int (*ret_handler)(struct uprobe_consumer *self,
> > >                               unsigned long func,
> > > -                             struct pt_regs *regs);
> > > +                             struct pt_regs *regs, __u64 *data);
> > >       bool (*filter)(struct uprobe_consumer *self,
> > >                               enum uprobe_filter_ctx ctx,
> > >                               struct mm_struct *mm);
> > >
> > >       struct uprobe_consumer *next;
> > > +
> > > +     bool                    session;        /* marks uprobe session consumer */
> > > +     unsigned int            session_id;     /* set when uprobe_consumer is registered */
> >
> > Hmm, why this has both session and session_id?
> 
> session is caller's request to establish session semantics. Jiri, I

and session_id is set when uprobe is registered and used when
return uprobe is executed to find matching uprobe_consumer,
plz check handle_uretprobe_chain/session_consumer_find

> think it's better to move it higher next to
> handler/ret_handler/filter, that's the part of uprobe_consumer struct
> which has read-only caller-provided data (I'm adding offset and
> ref_ctr_offset there as well).

ok, makes sense

> 
> > I also think we can use the address of uprobe_consumer itself as a unique id.
> 
> +1
> 
> >
> > Also, if we can set session enabled by default, and skip ret_handler by handler's
> > return value, it is more simpler. (If handler returns a specific value, skip ret_handler)
> 
> you mean derive if it's a session or not by both handler and
> ret_handler being set? I guess this works fine for BPF side, because
> there we never had them both set. If this doesn't regress others, I
> think it's OK. We just need to make sure we don't unnecessarily
> allocate session state for consumers that don't set both handler and
> ret_handler. That would be a waste.

hum.. so the current code installs return uprobe if there's ret_handler
defined in consumer and also the entry 'handler' needs to return 0

if entry 'handler' returns 1 the uprobe is unregistered

we could define new return value from 'handler' to 'not execute the
'ret_handler' and have 'handler' return values:

  0 - execute 'ret_handler' if defined
  1 - remove the uprobe
  2 - do NOT execute 'ret_handler'  // this current triggers WARN

we could delay the allocation of 'return_instance' until the first
consumer returns 0, so there's no perf regression

that way we could treat all consumers the same and we wouldn't need
the session flag..

ok looks like good idea ;-) will try that

thanks,
jirka

> 
> >
> > >  };
> > >
> > >  #ifdef CONFIG_UPROBES
> > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > >       unsigned int                    depth;
> > >  };
> > >
> > > +struct session_consumer {
> > > +     __u64           cookie;
> >
> > And this cookie looks not scalable. If we can pass a data to handler, I would like to
> > reuse it to pass the target function parameters to ret_handler as kretprobe/fprobe does.
> >
> >         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, void *data);
> >
> > uprobes can collect its uc's required sizes and allocate the memory (shadow stack frame)
> > at handler_chain().
> 
> The goal here is to keep this simple and fast. I'd prefer to keep it
> small and fixed size, if possible. I'm thinking about caching and
> reusing return_instance as one of the future optimizations, so if we
> can keep this more or less fixed (assuming there is typically not more
> than 1 or 2 consumers per uprobe, which seems realistic), this will
> provide a way to avoid excessive memory allocations.
> 
> >
> > > +     unsigned int    id;
> > > +     int             rc;
> > > +};
> > > +
> > >  struct return_instance {
> > >       struct uprobe           *uprobe;
> > >       unsigned long           func;
> > > @@ -88,6 +97,9 @@ struct return_instance {
> > >       bool                    chained;        /* true, if instance is nested */
> > >
> > >       struct return_instance  *next;          /* keep as stack */
> > > +
> > > +     int                     sessions_cnt;
> > > +     struct session_consumer sessions[];
> >
> > In that case, we don't have this array, but
> >
> >         char data[];
> >
> > And decode data array, which is a slice of variable length structure;
> >
> > struct session_consumer {
> >         struct uprobe_consumer *uc;
> >         char data[];
> > };
> >
> > The size of session_consumer is uc->session_data_size + sizeof(uc).
> >
> > What would you think?
> >
> > Thank you,
> >
> > >  };
> > >
> > >  enum rp_check {
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 2c83ba776fc7..4da410460f2a 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -63,6 +63,8 @@ struct uprobe {
> > >       loff_t                  ref_ctr_offset;
> > >       unsigned long           flags;
> > >
> > > +     unsigned int            sessions_cnt;
> 
> [...]

