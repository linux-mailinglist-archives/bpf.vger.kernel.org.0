Return-Path: <bpf+bounces-39214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4A970B25
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784D31F21317
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF9BA42;
	Mon,  9 Sep 2024 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga2ywylX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90CA932;
	Mon,  9 Sep 2024 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844580; cv=none; b=jbbI43oIg4rI12F7/jx0MO7oLQs4hWnQoEzQHfsvCLcmzlfm74VeM5toHyFPsIs2VdGK13dvmCTzi5VYzchvLghyR+MpWdDsyJgd8vYyYQA9bmsEpk1xOEszowOFajmwC0OtCJWhVv4cHClfui0uLljCyUsJTgvMd4qM7OIoEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844580; c=relaxed/simple;
	bh=pxT3oOxWGgVpJPRjBnfXZxKXiKLlvTBU7omzCE7Fe2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6qCnSMGDqgrV3f/o4PdBUDne01N83vvmafmlYWWpBG0Y0xCgWICqmiv6V8tA0EcTvTePQvq0ksaT9aGfFTk3yp0HIqBQqfXUpt06l1TPgxyoXw569/mn2rioNPizlLWlH5QKZ+bx/oGDcJWDKUEV+N48DScMeupuLG+99EwkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga2ywylX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so2974337a91.2;
        Sun, 08 Sep 2024 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725844579; x=1726449379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3/Gr9/co9U0VWal9bzGMLcvU/lVNFTzOwyJM/bVLy4=;
        b=Ga2ywylXooJvigGBz1nxgmhoSyOwYcFfuCZxPQJs7Qj0zSGNkttu6i1d0mLhMUelO/
         10FlZr+rp1yzQtonKROnv6Vg9uaFsTJFGUhjS8xKSiJWcHzv9dvbnRMHiBBcQg5Ktjeq
         PDgQ2E9eA+sqjnlPB6SdR1VZ+6EMa7VaR15KDMkyfs90E6pGUxeQlOIfRZQiboy/z/9p
         iVIXsQvLkN0v0cyjlD1hyMxZ6uSW7Uug82G6rlyAiQ1f/mi/acvvzCH69EyJY58Jji+q
         AmaIK6+VsiQ+xGkBOAFu925z5gAKCEyekZRHLqA6u07/CNlpSlGJFdZu2nKg1Vwtkv3B
         DLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725844579; x=1726449379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3/Gr9/co9U0VWal9bzGMLcvU/lVNFTzOwyJM/bVLy4=;
        b=GkTEnmRQeXhpbcsf3WTLENw3zrzfwT0RvKVyVyF7e2xvaKHQ9mdLgCP/3YkbKB1hJ2
         Wm70hQhfaCo1evnmV3C75DkseVDq7OJ5u5yaqOgDd0EB0Qe8gJ57eY6IfyB7KzrKlYMm
         Wf+3xYpEQuWMK3EwHSgGdZncf7zlSnXaBsiGspkHrm0TZhdnZfVLrZL5jAwKEP5exCOG
         LFNDw7AWveTvCHFhejnPvCWHjNwsZMP3dNUG9tCf9WBIvILXtwRU+erP3xUF9UtDGgKo
         ynoQ0j5WSsxZ++hhHlhcTJkruYblwdB9MEtLM5lgTHuCp0iFl22XZtkxsmDCSa5xFEVx
         FOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxWVsoq5TZpl+jzfHv1Oc2H7AMa1KFUdLSZ5IFbrwENI9TaxaN6FOnmJYl1nqN6St33AeR0qiKOVegw7K9Dbx/JOfY@vger.kernel.org, AJvYcCWZ/DyTZXl4n3/5WlyAVjvbLraOcb8zgd+rzf5XswH0j7BKjNovK3tSAZfTQkVlu60h5x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgN7MVuqnpJQwjC9kzFQS+rOaG4tVPujNSv+SS5HMM+PxYQFvx
	kcDpok/ZNx7H6sy/Z5qi/gI8UOq6E+ep19caytumYYrC6ZuflRofw1i5hx8+1SWl3SpiU1aI4+H
	SFMPSYDXHjntC+XRDMCm5K1gmKS0=
X-Google-Smtp-Source: AGHT+IGNf30WersMVO1Rnxjak8g9Q+GFqEOZYWWoyIJp32NMnU5KS80gtJ3zwrTmeSyJtmVZGNAYjzDyRMcxjxlv4LU=
X-Received: by 2002:a17:90a:c70a:b0:2d8:7a29:838f with SMTP id
 98e67ed59e1d1-2dad4ef210cmr13704953a91.10.1725844578574; Sun, 08 Sep 2024
 18:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Ztrc6eJ14M26xmvr@krava> <ME0P300MB0416A96545165A39507DF6429D9F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240908131519.GA21236@redhat.com>
In-Reply-To: <20240908131519.GA21236@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 8 Sep 2024 18:16:06 -0700
Message-ID: <CAEf4BzbaikV5YMTRLaz8PntJkDH3+=+pGemmFWcebEA8Jqsb-Q@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tianyi Liu <i.pear@outlook.com>, olsajiri@gmail.com, ajor@meta.com, 
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org, 
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org, 
	linux@jordanrome.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 6:15=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 09/08, Tianyi Liu wrote:
> >
> > On Mon, Sep 06, 2024 at 18:43:00AM +0800, Jiri Olsa wrote:
> >
> > > would you consider sending another version addressing Oleg's points
> > > for changelog above?
> >
> > My pleasure, I'll resend the updated patch in a new thread.
> >
> > Based on previous discussions, `uprobe_perf_filter` acts as a prelimina=
ry
> > filter that removes breakpoints when they are no longer needed.
>
> Well. Not only. See the usage of consumer_filter() and filter_chain() in
> register_for_each_vma().
>
> > More complex filtering mechanisms related to perf are implemented in
> > perf-specific paths.
>
> The perf paths in __uprobe_perf_func() do the filtering based on
> perf_event->hw.target, that is all.
>
> But uprobe_perf_filter() or any other consumer->filter() simply can't rel=
y
> on pid/task, it has to check ->mm.
>
> > From my understanding, the original patch attempted to partially implem=
ent
> > UPROBE_HANDLER_REMOVE (since it didn't actually remove the breakpoint b=
ut
> > only prevented it from entering the BPF-related code).
>
> Confused...
>
> Your patch can help bpftrace although it (or any other change in
> trace_uprobe.c) can't not actually fix all the problems with bpf/filterin=
g
> even if we forget about ret-probes.
>
> And I don't understand how this relates to UPROBE_HANDLER_REMOVE...
>
> > I'm trying to provide a complete implementation, i.e., removing the
> > breakpoint when `uprobe_perf_filter` returns false, similar to how upro=
be
> > functions. However, this would require merging the following functions,
> > because they will almost be the same:
> >
> > uprobe_perf_func / uretprobe_perf_func
> > uprobe_dispatcher / uretprobe_dispatcher
> > handler_chain / handle_uretprobe_chain
>
> Sorry, I don't understand... Yes, uprobe_dispatcher and uretprobe_dispatc=
her
> can share more code or even unified, but
>
> > I suspect that uretprobe might have been implemented later than uprobe
>
> Yes,
>
> > and was only partially implemented.
>
> what do you mean?
>
> But whatever you meant, I agree that this code doesn't look pretty and ca=
n
> be cleanuped.
>
> > In your opinion, does uretprobe need UPROBE_HANDLER_REMOVE?
>
> Probably. But this has absolutely nothing to do with the filtering proble=
m?
> Can we discuss this separately?
>
> > I'm aware that using `uprobe_perf_filter` in `uretprobe_perf_func` is n=
ot
> > the solution for BPF filtering. I'm just trying to alleviate the issue
> > in some simple cases.
>
> Agreed.
>
> -------------------------------------------------------------------------=
------
> To summarise.
>
> This code is very old, and it was written for /usr/bin/perf which attache=
s
> to the tracepoint. So multiple instances of perf-record will share the sa=
me
> consumer/trace_event_call/filter. uretprobe_perf_func() doesn't call
> uprobe_perf_filter() because (if /usr/bin/perf is the only user) in the l=
ikely
> case it would burn CPU and return true. Quite possibly this design was no=
t
> optimal from the very beginning, I simply can't recall why the is_ret_pro=
be()
> consumer has ->handler !=3D NULL, but it was not buggy.
>
> Now we have bpf, create_local_trace_uprobe(), etc. So lets add another
> uprobe_perf_filter() into uretprobe_perf_func() as your patch did.
>
> Then we can probably change uprobe_handle_trampoline() to do
> unapply_uprobe() if all the ret-handlers return UPROBE_HANDLER_REMOVE, li=
ke
> handler_chain() does.
>
> Then we can probably cleanup/simplify trace_uprobe.c, in partucular we ca=
n
> change alloc_trace_uprobe()
>
> -       tu->consumer.handler =3D uprobe_dispatcher;
> -       if (is_ret)
> -               tu->consumer.ret_handler =3D uretprobe_dispatcher;
> +       if (is_ret)
> +               tu->consumer.ret_handler =3D uretprobe_dispatcher;
> +       else
> +               tu->consumer.handler =3D uprobe_dispatcher;
>
> and do more (including unrelated) cleanups.
>
> But lets do this step-by-step.
>
> And lets not mix the filtering issues with the UPROBE_HANDLER_REMOVE logi=
c,
> to me this adds the unnecessary confusion.

+100 to all of the above. This has been a very long and winding
thread, but uretprobes are still being triggered unnecessarily :)
Let's fix the bleeding and talk and work on improving all of the other
issues in separate efforts.

>
> Oleg.
>

