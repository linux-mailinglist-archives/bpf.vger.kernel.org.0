Return-Path: <bpf+bounces-26327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB289E511
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0B6283A8A
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E625158A2B;
	Tue,  9 Apr 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbbBFLRe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CA1EA8F;
	Tue,  9 Apr 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698909; cv=none; b=VpCCXspSHny0MigV8r45txCHw+xszDbzNA7O4zkmPK6ab3nhgrCvB6izUguP4U/Ed7+q7AKZpgjwHWTa18MZ+8qwjW7Ge/jPAIRnYsTRYzPeqWg9IoRUQniH6SORtd5zUgF4SVEpxlZxSHjDm6g8NcTl2dKyQUBBZydfFuxm+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698909; c=relaxed/simple;
	bh=npw5jsj4JmECCp9k4gd6nBA7Md+aThnvZkMcTZwJAnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPTtJ/2TfBf2VZ+CRx7ny3wZtOVmSguguMEJ2RHF3w7+RPjE7BG4Mzefml+jJM08qhnXP6zUqpZtCALASGZJJBOOx8MdRxebwHcJ68bOZxoHQBKxA5ftfutesGv22JP8XeN8nPwqdXBUOPBbpN2NmLNGZy26cytKWBsZtW0kc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbbBFLRe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-416b7f372b3so5489025e9.3;
        Tue, 09 Apr 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712698906; x=1713303706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npw5jsj4JmECCp9k4gd6nBA7Md+aThnvZkMcTZwJAnw=;
        b=GbbBFLRe2qwfQh0sCCYxLMV3qdcsiAssOeD4XuoM9f0KPt4+Y4qJqU/ws3hsBjdjto
         2vdLEZVjUCXcORVvzvmajF9Os0Fi21Gv8kvbY8PnXtkmQH+KtbGT7T6X8iYPkpkG38EY
         +/FpQTLjm+aLw5hmYKugx6aYCYEsj4LLtgxNampFMwCWm7vk6l+YttjM0+7jQVDk2AGc
         G8x1g6Ql5c+MFrxqsuIIUSMUsPsvW08Z16ckrqqdWi5X5Lv+4qCatfgfp80pPxz7iOrN
         AAPEiUue/KUMjAkJpJNWH/JLMgIAFBE3HEoBt/HviXWEnB7ugiu1yWL3mBMxGNbXfXnY
         Yfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698906; x=1713303706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npw5jsj4JmECCp9k4gd6nBA7Md+aThnvZkMcTZwJAnw=;
        b=xTUOVa2WuRK7syvo3TfPP5vrlcgaB/9ldu4d8F8hjFCUns1O+hbb8giXwxUFOx9JoJ
         LPDQTqVMr+hKDQb3sxS209sUBC8XbzrGLz3I9Y7FdmMfEzDsh2aBbG2Xf+yTd7GXdgp6
         Jl3QnYFlQJCzSEP/8nroEytwIPZidsskNGfO4P6JgUSA3kHF6OdtgYYbUHLgMeCVHEVk
         /HA1cNgItIpcpnv4BPM6i5Y9FpRUfM/x5wmTpOgkL8XmuA1pbQEcnTOSSXduefJOa5y/
         xik8LnUImb2VYZNhPT+4gjWF63ARtcj1lVHN8QAKOdMs0NYfCbdLdTApBzrXc892Rff9
         urZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyWyCR0/LEeIcJ1c4Jlmc+gp+GYkJ2HO6PnXwSAhD24uVYyjQnvb2rRTCUbagzhvqQ9GcTRA1nHAIfrgvtYmvY+BgZw4Pwf5ZwWb5DgDnfQiDYtMGCxZaJSi/TPX2Ai5o6NZkd4Qb00UKKItl08mbwBR2fhiZ6tPLiL0P4H7IMmiLt6oTsLVQzZfWzx1ITFKEs0eIcXwlBmhBucD1UM0+g
X-Gm-Message-State: AOJu0YxIcAtcsbcxC1bRchPLHHY2gIrih3LFb9rkNoBp+Awubp1aR5cy
	v5O/f2oFI7GqFcS5lDDgSepgftaGMNbyN/6+jj8kSsFk4/7MNREgKjQ/1jewR0f+j8p1uOy3ueL
	fTcbmJor6tg/yrd2tVW3WbNc3mZc=
X-Google-Smtp-Source: AGHT+IGOqKnauhbhix2OADG+PT4talQH243EsZduMNV6vIWq8+0+Z9hKz2/dZz5bmAmhtxjXAMVtx68irK0Zeb5IVAQ=
X-Received: by 2002:a05:600c:444d:b0:416:9877:e1a2 with SMTP id
 v13-20020a05600c444d00b004169877e1a2mr653244wmn.3.1712698905412; Tue, 09 Apr
 2024 14:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com> <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
 <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
 <CAEf4BzZCj=3hevf+Je=oed9Nisctotp_CX00NrLaO6_7+-0LSQ@mail.gmail.com>
 <CANpmjNMCJwCaGiUpMCukgruNJ9k120sJ8pVkrdpyo-Tonve2Sw@mail.gmail.com>
 <CAADnVQJ68X6NPYtEbQPXPM4pH1ZPg5iSrYi8c3EanL51SAW7zQ@mail.gmail.com> <CANpmjNO3m-f-Yg5EqTL3ktL2CqTw7v0EjHGVth7ssWJRnNz5xQ@mail.gmail.com>
In-Reply-To: <CANpmjNO3m-f-Yg5EqTL3ktL2CqTw7v0EjHGVth7ssWJRnNz5xQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Apr 2024 14:41:33 -0700
Message-ID: <CAADnVQLsro-zYTLQ_0R+it_Uuq9mPZT4MeCe7aHFx67SpSY6Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:11=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Mon, 8 Apr 2024 at 20:24, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 8, 2024 at 2:30=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Fri, 5 Apr 2024 at 22:28, Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > > >
> > > > On Fri, Apr 5, 2024 at 1:28=E2=80=AFAM Marco Elver <elver@google.co=
m> wrote:
> > > > >
> > > > > On Fri, 5 Apr 2024 at 01:23, Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > [...]
> > > > > > and the tasks can use mmaped array shared across all or unique =
to each
> > > > > > process.
> > > > > > And both bpf and user space can read/write them with a single i=
nstruction.
> > > > >
> > > > > That's BPF_F_MMAPABLE, right?
> > > > >
> > > > > That does not work because the mmapped region is global. Our requ=
irements are:
> >
> > It sounds not like "requirements", but a description of the proposed
> > solution.
>
> These requirements can also be implemented differently, e.g. with the
> proposed task-local storage maps if done right (the devil appears to
> be in the implementation-details - these details are currently beyond
> my knowledge of the BPF subsystem internals). They really are the bare
> minimum requirements for the use case. The proposed solution probably
> happens to be the simplest one, and mapping requirements is relatively
> straightforward for it.
>
> > Pls share the actual use case.
> > This "tracing prog" sounds more like a ghost scheduler that
> > wants to interact with known user processes.
>
> It's tcmalloc - we have a BPF program provide a simpler variant of the
> "thread re-scheduling" notifications discussed here:
> https://lore.kernel.org/all/CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSo=
R=3D3m1A@mail.gmail.com/
>
> Various synchronization algorithms can be optimized if they know about
> scheduling events. This has been proposed in [1] to implement an
> adaptive mutex. However, we think that there are many more
> possibilities, but it really depends on the kind of scheduler state
> being exposed ("thread on CPU" as in [1], or more details, like
> details about which thread was switched in, which was switched out,
> where was the thread migrated to, etc.). Committing to these narrow
> use case ABIs and extending the main kernel with more and more such
> information does not scale. Instead, BPF easily allows to expose this
> information where it's required.
>
> [1] https://lore.kernel.org/all/20230529191416.53955-1-mathieu.desnoyers@=
efficios.com/

Thanks for the links. That's very helpful.
I was about to mention rseq.
I think it's a better fit, but Mathieu doesn't want non-uapi bits in it.
Ideally we could have added pointer + size to rseq as a scratch area
that bpf prog can read/write.
User space would register such area, kernel would pin pages,
and bpf would directly access that.
Pretty much the same idea of bpf local storage, but without bpf map.
rseq has its pros and cons.
Having a bpf local storage map to manage such pinned pages provides
separation of concerns. And it's up to tcmalloc whether to use
one such map for all tasks or map for every tcmalloc instance.
Such scratch areas are per-task per-map.
rseq dictates per-task only, but no concerns with setup thanks
to glibc integration.

> > The main issue with bpf_probe_read/write_user() is their non-determinis=
m.
> > They will error when memory is swapped out.
>
> Right. Although, user space mlock'ing and prefaulting the memory
> solves it in the common case (some corner cases like after fork() are
> still tricky).

yeah. gets tricky indeed.
With bpf local storage map managing pinned pages the map_fd with
auto-close property addresses unpinning. No need to hack into
fork-ing exit-ing paths, but tcmalloc would need to re-register
the areas into bpf local storage after fork... guessing.

> > These helpers are ok-ish for observability when consumers understand
> > that some events might be lost, but for 24/7 production use
> > losing reads becomes a problem that bpf prog cannot mitigate.
> > What do bpf prog suppose to do when this safer bpf_probe_write_user err=
ors?
> > Use some other mechanism to communicate with user space?
>
> Right, for use cases where these errors aren't ok it does not work.
> But if the algorithm is tolerant to lossy reads/writes from the BPF
> program side, it's not an issue.

Reading Dmitry Vyukov's comments in that thread... looks like
he's also concerned with the 'probe' part of rseq api.

> > A mechanism with such builtin randomness in behavior is a footgun for
> > bpf users.
> > We have bpf_copy_from_user*() that don't have this non-determinism.
> > We can introduce bpf_copy_to_user(), but it will be usable
> > from sleepable bpf prog.
> > While it sounds you need it somewhere where scheduler makes decisions,
> > so I suspect bpf array or arena is a better fit.
>
> Correct, it can't sleep because it wants scheduler events.
>
> > Or something that extends bpf local storage map.
> > See long discussion:
> > https://lore.kernel.org/bpf/45878586-cc5f-435f-83fb-9a3c39824550@linux.=
dev/
> >
> > I still like the idea to let user tasks register memory in
> > bpf local storage map, the kernel will pin such pages,
> > and then bpf prog can read/write these regions directly.
> > In bpf prog it will be:
> > ptr =3D bpf_task_storage_get(&map, task, ...);
> > if (ptr) { *ptr =3D ... }
> > and direct read/write into the same memory from user space.
>
> I would certainly welcome something like this - I agree this looks
> better than bpf_probe_read/write.

Great to hear. It's on the todo list, but no one started to work on it.
If you have cycles to prototype it would be great.

