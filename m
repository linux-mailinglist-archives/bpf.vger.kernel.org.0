Return-Path: <bpf+bounces-33712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28F924CAB
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222B4B20EA4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C365C;
	Wed,  3 Jul 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvUOzMmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A860391;
	Wed,  3 Jul 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965637; cv=none; b=qmgeOeHZ73OrUOsL/2oWYvIBBYzjyfSXBcFrI5iF/TUDH2n0OzIOvcKxMqsklM11X6UWgbacAAH2+1Z9p1gOmB6+RDK2/o/tGXiYdbhobWlF7YAt58zC/rdoeY0bm6ZFgMGow56lcwiIA/jjooK4NfPNZbSoJR5b1HhcgPeYfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965637; c=relaxed/simple;
	bh=Cy70R95d0TTPnsSurPVknJaO+cLRlCLzRchC6vAVzf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqspU2D5JrkuK2F+aMCHwH9RxtLyNXSWrULxMZMueiIKqBNeXt28iypBJLYFS+XeUgE3nsUu68dDOUyVa+nKHl7X9tU+uGp1RJ6ZOgXJdmsK5KcmreXWhRmJW67Vyr70EfItJlk7PlKLz73mfFcOXCD94kBRlgQKHtGVdm7nU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvUOzMmz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a729d9d7086so17608666b.0;
        Tue, 02 Jul 2024 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719965634; x=1720570434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9207vgNzRRpHmlo3+0pYZ1A8z8WeUNjVTxG9yx+nqJM=;
        b=CvUOzMmzMz4C3Tpx1iu8/ASWqLMSJ5v0w0d5V+1C00wtQufRdJW+o/8WVynE7aPDKx
         cqAXp67ntY9ZJcwDP7WBgFYqLW8TaEzU1vVrgEwHovnAO2jR/oyGcdZu0daqVxPDX2EZ
         aqZLVo6C1sMY/gPCnlDuf6UnHNGRX5gzFexvMhRbth4kYR+VZmt7yuWURg4JMTjTz5xF
         /fcp1kQVRucEY/RcJo0xhs5/aHu0k6SvnfDeE4c+EU7ofa7FRbgtb6EFwmYGw2PpcabF
         wfd+HyDl/lc0gWemGFyobpqPZgNGewdYJJWCcD+vmHZzo4Au7k29X1YMKK9rZ9H3nK4Q
         E2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965634; x=1720570434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9207vgNzRRpHmlo3+0pYZ1A8z8WeUNjVTxG9yx+nqJM=;
        b=O/0+tpiexdHrHFTiQO0/h3o68UjlSugPWJ0h0vaqKB8tDX+tgGonnk4lH2wxZqc/G+
         xyEC3lky1BmCynEjCDVnmDUJO+eP+Ugs1+OArKC2UCtvYjlW9kcPOKnCnP6irlB+GXb9
         XI381hK41sH1jWe+D/UoZL6eLzKNRLht6lvTcLbnZTxQoapmDMNFNk2PcAEXDI0oEZab
         mkQOkxgxeBO1sihXwYVf34mzEA89qh25cWkNJb+xCxIOEcUF0qegWMMuHG67qlF/WNEd
         8bXgyJjU5LK3Us7kseBimx8DfIi9l3CNf7Jp0Xd0sgwHw1D4G8MrCJwVmuLpsZo8I8ri
         Qlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUBI6gY3xgQKGXKeFDdOPUlhIRH9ZokuFUdPuRYChr47zWKzMEC58k+jfWWQnGiuHAROwAnFngmePkoQay9atd9VjgaRzYAjilDTxXpeQI3TnOscYaU7WoGXqmaNV+MWDw/TzMXSHuPm0PUjW+YKG5hAZvn+bGDrQmkGLca0saGIIiN9o3v
X-Gm-Message-State: AOJu0Yza3wVKGH1X/BJqzIKFovMawa0S6nsvFk8JApE0IMxh9ikhIfbx
	0QU/MfHBeJbWcd3/wrmgWvH0Yl8xNckU7/9cGd6TlXhgh3KOG7uWFqe98IfGbdCNxtY2yX/kls6
	UgB9Y89/nJX14XZbcdMHgMg31sj70Ow==
X-Google-Smtp-Source: AGHT+IENVPFB5EcHI1lAyIZKBEFqVrSjPCTSgsm/mC6F0RVndoB0s/2XOFfWi9TsW9akZ+oLPXBF8KeFqp7kkKAEkWw=
X-Received: by 2002:a17:906:230f:b0:a6f:6df5:a264 with SMTP id
 a640c23a62f3a-a77a2411d9dmr9151466b.1.1719965633249; Tue, 02 Jul 2024
 17:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <20240703085533.820f90544c3fc42edf79468d@kernel.org>
In-Reply-To: <20240703085533.820f90544c3fc42edf79468d@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 17:13:38 -0700
Message-ID: <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:55=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> Hi Jiri,
>
> On Mon,  1 Jul 2024 18:41:07 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
> > Adding support for uprobe consumer to be defined as session and have
> > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> >
> > The session means that 'handler' and 'ret_handler' callbacks are
> > connected in a way that allows to:
> >
> >   - control execution of 'ret_handler' from 'handler' callback
> >   - share data between 'handler' and 'ret_handler' callbacks
> >
> > The session is enabled by setting new 'session' bool field to true
> > in uprobe_consumer object.
> >
> > We keep count of session consumers for uprobe and allocate session_cons=
umer
> > object for each in return_instance object. This allows us to store
> > return values of 'handler' callbacks and data pointers of shared
> > data between both handlers.
> >
> > The session concept fits to our common use case where we do filtering
> > on entry uprobe and based on the result we decide to run the return
> > uprobe (or not).
> >
> > It's also convenient to share the data between session callbacks.
> >
> > The control of 'ret_handler' callback execution is done via return
> > value of the 'handler' callback. If it's 0 we install and execute
> > return uprobe, if it's 1 we do not.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h     |  16 ++++-
> >  kernel/events/uprobes.c     | 129 +++++++++++++++++++++++++++++++++---
> >  kernel/trace/bpf_trace.c    |   6 +-
> >  kernel/trace/trace_uprobe.c |  12 ++--
> >  4 files changed, 144 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index f46e0ca0169c..903a860a8d01 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
> >  };
> >
> >  struct uprobe_consumer {
> > -     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
);
> > +     int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
, __u64 *data);
> >       int (*ret_handler)(struct uprobe_consumer *self,
> >                               unsigned long func,
> > -                             struct pt_regs *regs);
> > +                             struct pt_regs *regs, __u64 *data);
> >       bool (*filter)(struct uprobe_consumer *self,
> >                               enum uprobe_filter_ctx ctx,
> >                               struct mm_struct *mm);
> >
> >       struct uprobe_consumer *next;
> > +
> > +     bool                    session;        /* marks uprobe session c=
onsumer */
> > +     unsigned int            session_id;     /* set when uprobe_consum=
er is registered */
>
> Hmm, why this has both session and session_id?

session is caller's request to establish session semantics. Jiri, I
think it's better to move it higher next to
handler/ret_handler/filter, that's the part of uprobe_consumer struct
which has read-only caller-provided data (I'm adding offset and
ref_ctr_offset there as well).

> I also think we can use the address of uprobe_consumer itself as a unique=
 id.

+1

>
> Also, if we can set session enabled by default, and skip ret_handler by h=
andler's
> return value, it is more simpler. (If handler returns a specific value, s=
kip ret_handler)

you mean derive if it's a session or not by both handler and
ret_handler being set? I guess this works fine for BPF side, because
there we never had them both set. If this doesn't regress others, I
think it's OK. We just need to make sure we don't unnecessarily
allocate session state for consumers that don't set both handler and
ret_handler. That would be a waste.

>
> >  };
> >
> >  #ifdef CONFIG_UPROBES
> > @@ -80,6 +83,12 @@ struct uprobe_task {
> >       unsigned int                    depth;
> >  };
> >
> > +struct session_consumer {
> > +     __u64           cookie;
>
> And this cookie looks not scalable. If we can pass a data to handler, I w=
ould like to
> reuse it to pass the target function parameters to ret_handler as kretpro=
be/fprobe does.
>
>         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
, void *data);
>
> uprobes can collect its uc's required sizes and allocate the memory (shad=
ow stack frame)
> at handler_chain().

The goal here is to keep this simple and fast. I'd prefer to keep it
small and fixed size, if possible. I'm thinking about caching and
reusing return_instance as one of the future optimizations, so if we
can keep this more or less fixed (assuming there is typically not more
than 1 or 2 consumers per uprobe, which seems realistic), this will
provide a way to avoid excessive memory allocations.

>
> > +     unsigned int    id;
> > +     int             rc;
> > +};
> > +
> >  struct return_instance {
> >       struct uprobe           *uprobe;
> >       unsigned long           func;
> > @@ -88,6 +97,9 @@ struct return_instance {
> >       bool                    chained;        /* true, if instance is n=
ested */
> >
> >       struct return_instance  *next;          /* keep as stack */
> > +
> > +     int                     sessions_cnt;
> > +     struct session_consumer sessions[];
>
> In that case, we don't have this array, but
>
>         char data[];
>
> And decode data array, which is a slice of variable length structure;
>
> struct session_consumer {
>         struct uprobe_consumer *uc;
>         char data[];
> };
>
> The size of session_consumer is uc->session_data_size + sizeof(uc).
>
> What would you think?
>
> Thank you,
>
> >  };
> >
> >  enum rp_check {
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2c83ba776fc7..4da410460f2a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -63,6 +63,8 @@ struct uprobe {
> >       loff_t                  ref_ctr_offset;
> >       unsigned long           flags;
> >
> > +     unsigned int            sessions_cnt;

[...]

