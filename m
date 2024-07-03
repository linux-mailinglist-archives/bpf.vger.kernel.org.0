Return-Path: <bpf+bounces-33815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38117926AA7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21D0283B01
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE194196D9D;
	Wed,  3 Jul 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AieAwYNE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59419067C;
	Wed,  3 Jul 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043022; cv=none; b=LRP8gk34kYS2tMTVcdvpiI9NjNOvut2TBSKSfR30xtGTOMjG8wsvCnrXU8YhD7IZsFD35mJnwSh/YPrQw1kbPr7X5CX2Ix0IrnkLYMJABCBzJhW/wcavqBRrWnPQXBFkTaTpEjXrsq0QdK52JxGpbr4MjsoLV2MwoTX1ylbIUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043022; c=relaxed/simple;
	bh=htjwUa5RNEv3M7+mYLPEC2uAN5aEhdq9lPGiWiYyoqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIil7W0aDsLRubUwMBT/OMB1CHqJ5dqFTge23fD3uuf1/o8Hhka4BLv1Y0E98huJUfIEZ/KrkBUb5rYE9/O3FljQkA3DX1/KvR5V8cMPobvkpNmLP2Rpa2naBXzonYPkFod4iyBZfMnu3HEGnajTtWnuxRGzRN+GXK2MbX9eCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AieAwYNE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706524adf91so16025b3a.2;
        Wed, 03 Jul 2024 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043020; x=1720647820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceyQzUfW6xG+lrh/FeRvBMM7Wjmc+xQszE5IQGuSSvM=;
        b=AieAwYNEIcnHWCoh3RtW7YYdunX4u2HOr8+0XNj36OLh4dRQ6adwtuwl4ucdYTp/oP
         WYGZuYfcmpOeN4jQL4qhN/3/aEo1wH1+DRhwOfz+fruaPefsIH9/7cZntQogsXj7zU92
         NhDII1+2M9rrKmtXqq81fIwFaNQ/2x0h/Sw+Jz4UuBPVtiAk/r5Dy/h152rGFQKFjNbP
         6xarOSuygq/lbWeYC0vEU2F4EN5ogezyMxwdqo8MH0RBDSiad3REi7sAgY64aw1TZlby
         x+ksogrBffEl9yXWEbns8s8uAAgfHgmYWg2ui19FJQfIVDixyVmK0c5yYeQJUsa8fHzr
         BOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043020; x=1720647820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceyQzUfW6xG+lrh/FeRvBMM7Wjmc+xQszE5IQGuSSvM=;
        b=OaxBMxU/emlgDDTUk//7AAjV2Wtoifoe4VMFSoGzp6HUv3Fb8tS6APmagYZ0qpFe3B
         WzIpyxbcEbkWmRSJNwL3OyxNnb9leXk4qGramZy+fcqwvOHe9G/yeMAN5N99yno095BP
         08OgtVNJoNuC3BC7RxM6HaMm+dhN4jzncVM6/X7wTLrl0au3nqoLJBu+iWpG/ZIbKHZi
         Dz739QpMjYbZtAqh5f3CNJbd+uA3qDPApTOnQj4t8zVZ4wDqbhCg9iaSmZ0VIGjVkbD4
         qRR1DD2BKZUs4WhXseUCXTNqM9Ho9R/O9FI14NTOSODo90EupJdJSOu2XxAzq493VljW
         OlpA==
X-Forwarded-Encrypted: i=1; AJvYcCUOmcNtSFMfU51hwMs60Ux6nzZpL6qtg/zvJITOLXxH/6CCMYpvN4BuyWW9cDx2JkDM6Xo523lLEoEtAqooyRH/vLNKEXPhrtuDgxqAMFIIfTdJLe5Q/FdseVAenJvI+9jUKrUTySOgn/zsyzvio+SFEbblJJqyXXcB5IWxXXLNNGcIsFzb
X-Gm-Message-State: AOJu0YzQi1HEQNdConuHBbntgA9QBJaPuATFBNgxybQiQf+cVccqhTJm
	fvfJba1l287DQpwnKvS3XZAewxhGLG9wxBOEORGrXUSw6Lq7KfSUd8UXCln8qYbNBAfKx8sA3i6
	Uh16701Dio5yjfI9SiX4Bzm/UzC8=
X-Google-Smtp-Source: AGHT+IFVIeMNcge3olmYH7LRONWftZ3oNTJblSpYYF3YYrA0oep9FpzfvcjtJ19ArbiW+3H3bi/2Ew2RUXdWztWiPa0=
X-Received: by 2002:a05:6a00:9290:b0:70a:efd7:ad9b with SMTP id
 d2e1a72fcca58-70aefd7b02amr3146983b3a.17.1720043020062; Wed, 03 Jul 2024
 14:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <20240703085533.820f90544c3fc42edf79468d@kernel.org> <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
 <ZoV3rRUHEdvTmJjG@krava>
In-Reply-To: <ZoV3rRUHEdvTmJjG@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:43:27 -0700
Message-ID: <CAEf4BzYKVbCEGupX47fwM0XSzwwmXs+0sVpcAdp3poFLkjMA6Q@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 9:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Jul 02, 2024 at 05:13:38PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 2, 2024 at 4:55=E2=80=AFPM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > Hi Jiri,
> > >
> > > On Mon,  1 Jul 2024 18:41:07 +0200
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > Adding support for uprobe consumer to be defined as session and hav=
e
> > > > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> > > >
> > > > The session means that 'handler' and 'ret_handler' callbacks are
> > > > connected in a way that allows to:
> > > >
> > > >   - control execution of 'ret_handler' from 'handler' callback
> > > >   - share data between 'handler' and 'ret_handler' callbacks
> > > >
> > > > The session is enabled by setting new 'session' bool field to true
> > > > in uprobe_consumer object.
> > > >
> > > > We keep count of session consumers for uprobe and allocate session_=
consumer
> > > > object for each in return_instance object. This allows us to store
> > > > return values of 'handler' callbacks and data pointers of shared
> > > > data between both handlers.
> > > >
> > > > The session concept fits to our common use case where we do filteri=
ng
> > > > on entry uprobe and based on the result we decide to run the return
> > > > uprobe (or not).
> > > >
> > > > It's also convenient to share the data between session callbacks.
> > > >
> > > > The control of 'ret_handler' callback execution is done via return
> > > > value of the 'handler' callback. If it's 0 we install and execute
> > > > return uprobe, if it's 1 we do not.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  include/linux/uprobes.h     |  16 ++++-
> > > >  kernel/events/uprobes.c     | 129 ++++++++++++++++++++++++++++++++=
+---
> > > >  kernel/trace/bpf_trace.c    |   6 +-
> > > >  kernel/trace/trace_uprobe.c |  12 ++--
> > > >  4 files changed, 144 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > index f46e0ca0169c..903a860a8d01 100644
> > > > --- a/include/linux/uprobes.h
> > > > +++ b/include/linux/uprobes.h
> > > > @@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
> > > >  };
> > > >
> > > >  struct uprobe_consumer {
> > > > -     int (*handler)(struct uprobe_consumer *self, struct pt_regs *=
regs);
> > > > +     int (*handler)(struct uprobe_consumer *self, struct pt_regs *=
regs, __u64 *data);
> > > >       int (*ret_handler)(struct uprobe_consumer *self,
> > > >                               unsigned long func,
> > > > -                             struct pt_regs *regs);
> > > > +                             struct pt_regs *regs, __u64 *data);
> > > >       bool (*filter)(struct uprobe_consumer *self,
> > > >                               enum uprobe_filter_ctx ctx,
> > > >                               struct mm_struct *mm);
> > > >
> > > >       struct uprobe_consumer *next;
> > > > +
> > > > +     bool                    session;        /* marks uprobe sessi=
on consumer */
> > > > +     unsigned int            session_id;     /* set when uprobe_co=
nsumer is registered */
> > >
> > > Hmm, why this has both session and session_id?
> >
> > session is caller's request to establish session semantics. Jiri, I
>
> and session_id is set when uprobe is registered and used when
> return uprobe is executed to find matching uprobe_consumer,
> plz check handle_uretprobe_chain/session_consumer_find
>
> > think it's better to move it higher next to
> > handler/ret_handler/filter, that's the part of uprobe_consumer struct
> > which has read-only caller-provided data (I'm adding offset and
> > ref_ctr_offset there as well).
>
> ok, makes sense
>
> >
> > > I also think we can use the address of uprobe_consumer itself as a un=
ique id.
> >
> > +1
> >
> > >
> > > Also, if we can set session enabled by default, and skip ret_handler =
by handler's
> > > return value, it is more simpler. (If handler returns a specific valu=
e, skip ret_handler)
> >
> > you mean derive if it's a session or not by both handler and
> > ret_handler being set? I guess this works fine for BPF side, because
> > there we never had them both set. If this doesn't regress others, I
> > think it's OK. We just need to make sure we don't unnecessarily
> > allocate session state for consumers that don't set both handler and
> > ret_handler. That would be a waste.
>
> hum.. so the current code installs return uprobe if there's ret_handler
> defined in consumer and also the entry 'handler' needs to return 0
>
> if entry 'handler' returns 1 the uprobe is unregistered
>
> we could define new return value from 'handler' to 'not execute the
> 'ret_handler' and have 'handler' return values:
>
>   0 - execute 'ret_handler' if defined
>   1 - remove the uprobe
>   2 - do NOT execute 'ret_handler'  // this current triggers WARN
>
> we could delay the allocation of 'return_instance' until the first
> consumer returns 0, so there's no perf regression
>
> that way we could treat all consumers the same and we wouldn't need
> the session flag..
>
> ok looks like good idea ;-) will try that

Just please double check that we don't pass through 1 or 2 as a return
result for BPF uprobes/multi-uprobes, so that we don't have any
accidental changes of behavior.

>
> thanks,
> jirka
>
> >
> > >
> > > >  };
> > > >
> > > >  #ifdef CONFIG_UPROBES
> > > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > > >       unsigned int                    depth;
> > > >  };
> > > >
> > > > +struct session_consumer {
> > > > +     __u64           cookie;
> > >
> > > And this cookie looks not scalable. If we can pass a data to handler,=
 I would like to
> > > reuse it to pass the target function parameters to ret_handler as kre=
tprobe/fprobe does.
> > >
> > >         int (*handler)(struct uprobe_consumer *self, struct pt_regs *=
regs, void *data);
> > >
> > > uprobes can collect its uc's required sizes and allocate the memory (=
shadow stack frame)
> > > at handler_chain().
> >
> > The goal here is to keep this simple and fast. I'd prefer to keep it
> > small and fixed size, if possible. I'm thinking about caching and
> > reusing return_instance as one of the future optimizations, so if we
> > can keep this more or less fixed (assuming there is typically not more
> > than 1 or 2 consumers per uprobe, which seems realistic), this will
> > provide a way to avoid excessive memory allocations.
> >
> > >
> > > > +     unsigned int    id;
> > > > +     int             rc;
> > > > +};
> > > > +
> > > >  struct return_instance {
> > > >       struct uprobe           *uprobe;
> > > >       unsigned long           func;
> > > > @@ -88,6 +97,9 @@ struct return_instance {
> > > >       bool                    chained;        /* true, if instance =
is nested */
> > > >
> > > >       struct return_instance  *next;          /* keep as stack */
> > > > +
> > > > +     int                     sessions_cnt;
> > > > +     struct session_consumer sessions[];
> > >
> > > In that case, we don't have this array, but
> > >
> > >         char data[];
> > >
> > > And decode data array, which is a slice of variable length structure;
> > >
> > > struct session_consumer {
> > >         struct uprobe_consumer *uc;
> > >         char data[];
> > > };
> > >
> > > The size of session_consumer is uc->session_data_size + sizeof(uc).
> > >
> > > What would you think?
> > >
> > > Thank you,
> > >
> > > >  };
> > > >
> > > >  enum rp_check {
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 2c83ba776fc7..4da410460f2a 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -63,6 +63,8 @@ struct uprobe {
> > > >       loff_t                  ref_ctr_offset;
> > > >       unsigned long           flags;
> > > >
> > > > +     unsigned int            sessions_cnt;
> >
> > [...]

