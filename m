Return-Path: <bpf+bounces-55166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B478A79281
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A863B108B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78017E473;
	Wed,  2 Apr 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7/on1jt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203661624E1;
	Wed,  2 Apr 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609430; cv=none; b=eCQb+XIaZgbFjsWWA6OchzDj0JvzsxUXqMhQ6JuvGpZ5GfGcnj8wyeZ+g/SgeEtdW6iBAMPW3btSKl7PfIINLg0eAZnwEOTV+Un+8YU/nRdPGXbr3mNWXYtDzXyl0CuepEyovP2Ul31Cj0JYnnVtD9jyF0lksg2gjM3fsve4p5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609430; c=relaxed/simple;
	bh=MCj2477aea3pzPDsySrEzvJ7KNerHmbsP9waxwQHWDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkPbsjcCNU1aJnO9twmocplfz6hnW11EI6K4SVJxop6aV0QbaBHvNarHQvvRnrNuIprvAdX4FTI/87M2Jsyzqa9Az5hHdG9wabCrbur7/ObAJgJiAwlboWljwVO5nVBqcMDh+gXftxhp9CSe8+cvDYtO9y/eh9SIDE4T1LfFZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7/on1jt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7396f13b750so373171b3a.1;
        Wed, 02 Apr 2025 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743609428; x=1744214228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZu01jZQhh6hZl4PugPaWEhh+6zty4+yoFo513E9J3o=;
        b=K7/on1jtqx1DFI3BgW+SH5OV4v+EU4f+GR+EpnEvbdbiRI4LKNtDi0KaGI5QXviqU9
         5SFbc0CF2i0JI21QzLSBFjf8OmE9WeuzkNkvghlJY7Z6sHeQZ9hzIv26fgWPnRXp8VDe
         IZ98rcxJZmBo/3tRG7jSvQPG7VzPZs1e2T6g3cZ0+0lTpSJJasmpvcIeEc9Q6q1Afzyx
         rafqObg+a4iWcT80d45+dOVuBfg45WFI6F0++BR/hxM3kpm2yWwm6xscAdkJYJcj6rpQ
         O0Gf6XFwbKrAf8cbxdI70IlNPHmpr9x4tkQRowVlQzrv0OI5U6BnYPXNuMMOlF17ZjlV
         NUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743609428; x=1744214228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZu01jZQhh6hZl4PugPaWEhh+6zty4+yoFo513E9J3o=;
        b=eIfwN/HIIynKhjuiUnurbLQK2vanWVMR+Z+nAHq4eRpQuyn1fTV8w68bwyioo+kQj1
         pPDw2j1OqAaB7OZ9DZ81wKHQyXkwDVjEejx6yBA91uD1MefdR39+PYa6PI7vdCHLMTBf
         s8pTI7J28khmXqFkpQjHYBdEJj+ElxiAARvFg61yvw/uDGBplR2pB6HfeR6PML0RpQOz
         b7Arpn+w/gudnWekWaLHLVfxEfjHYuudjEflC46Q1E9PWh9M+AV3puMYRUdtW+N1QAV/
         vOH/Ce4n6Pr4ZcY5v9vE/HAvGjv3z0jukFy0NyTZlxiVvKJChVWgQeOSd/L2CNbz696Z
         XZYA==
X-Forwarded-Encrypted: i=1; AJvYcCUXslMjEkX0tgc9wDz3/v63vHzWD8+NPkbMWVk0HPT46bcGT1ZmMlCxO7JpqzYkvxDredi6y5tYZKIXMSGA@vger.kernel.org, AJvYcCUt/pb9DAcFzvTjolUIkgmxGqT9JkEST0GtzeYyxubSKkKFyHp1MVOgfQgxSk0WzwFW/g0=@vger.kernel.org, AJvYcCXQeblIFQMIDLdXDOW3vHrYT/h1tiIKKw4jhwtSJWEch6M66BwBDBY6PSYbAHy3Q31SZjvPAqE4WTy/tWPhyTNa7NqY@vger.kernel.org
X-Gm-Message-State: AOJu0YwUs6fyG+ljui1m5oY76kXscDdurCNSw0xsWhovabhxLP7SpnVH
	3gsGoOXAztY8e54dx6s6wboSm3gQ64B1ObHvViN2RCWmt+SorSyKOU/EGhK9cjuKlJlzmsRb2TM
	bBrwoj/DwwCpuDUpuzhK3WdszroQ=
X-Gm-Gg: ASbGncs96shDWFlEMbsFGS2onL5KBusKsl/7jWVgoH/mkYp8RzJ489ePYcK03+oZzw3
	uVtEX7NklAXq57FuwuePpG5DEYqJJcFuE8GNwkkFWEc+/Srj5Y+0ZTF52jQJSHYWmOkHksgrrBx
	ihqe2ega7RZWjMtsVlB3oQSyob
X-Google-Smtp-Source: AGHT+IH98E/oH070yhcBgqMI3BtsENUQOk0E1Z4r5x9aKzGnwypDYaJG7O6aEoYWqUOraIf0AMF4pKspFX3npnqt20I=
X-Received: by 2002:a05:6a00:1309:b0:736:fff2:99b with SMTP id
 d2e1a72fcca58-739c796ae23mr3884224b3a.23.1743609428135; Wed, 02 Apr 2025
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401184021.2591443-1-andrii@kernel.org> <20250401173249.42d43a28@gandalf.local.home>
 <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com> <Z-zlRSo6G1xWcd7I@tiehlicka>
In-Reply-To: <Z-zlRSo6G1xWcd7I@tiehlicka>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Apr 2025 08:56:55 -0700
X-Gm-Features: AQ5f1JqT74lXZ5F4Qasah_uABBu8QtGyCJK_rzbVdNXvTrN7aLD0OiklytHR92w
Message-ID: <CAEf4BzbThkFEb88Jj8pMxuMkHeWmJNMnRT5j6SA4HmN4g+-gJA@mail.gmail.com>
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before current->mm
 is reset
To: Michal Hocko <mhocko@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	oleg@redhat.com, brauner@kernel.org, glider@google.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 12:20=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 01-04-25 15:04:11, Andrii Nakryiko wrote:
> > On Tue, Apr 1, 2025 at 2:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue,  1 Apr 2025 11:40:21 -0700
> > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Hi Andrii,
> > >
> > > > It is useful to be able to access current->mm to, say, record a bun=
ch of
> > > > VMA information right before the task exits (e.g., for stack
> > > > symbolization reasons when dealing with short-lived processes that =
exit
> > > > in the middle of profiling session). We currently do have
> > > > trace_sched_process_exit() in the exit path, but it is called a bit=
 too
> > > > late, after exit_mm() resets current->mm to NULL, which makes it
> > > > unsuitable for inspecting and recording task's mm_struct-related da=
ta
> > > > when tracing process lifetimes.
> > >
> > > My fear of adding another task exit trace event is that it will get a
> > > bit confusing as that we now have trace_sched_process_exit() and also
> > > trace_task_exit() with slightly different semantics.
> > >
> > > How about adding a trace_exit_mm()? Add that to the exit_mm() code?
> >
> > This is kind of the worst of both worlds, no? We still have a new
> > tracepoint, but this one can't tell if it's a `group_dead` situation
> > or not... I can pass group_dead into exit_mm(), but it will be just
> > for the sake of that new tracepoint.
>
> Is it important to tell the difference between thread and the
> whole process group exiting?

Yes, it often is important. In the sense that process group exiting
would trigger extra information gathering/aggregation/sending compared
to just process (thread) existing. Both are important to track, but
it's useful to be able to differentiate.

>
> Please keep in mind that even group exit doesn't really imply the mm is
> going away (clone allows CLONE_VM without CLONE_SIGNAL - i.e. mm could
> be shared outside of thread group).

Yep, I realize that, and as Steven said, for cases like that a
dedicated mm-specific tracepoint might be useful. But I'm not really
aware of use cases caring about mm_struct itself, in isolation. It's
all usually in the context of thread/process exit, and mm-related
information is one of a bunch of extra information that's useful at
that point. It's just so that with current sched_process_exit()
tracepoint placement we (e.g., BPF program) gets control a bit too
late.

But it seems like everyone is OK just shifting sched_process_exit() to
before exit_mm(), which should cover the use cases I had in mind. We
can always add mm-specific tracepoint when the need arises.

Thanks everyone for discussion and suggestions!

> --
> Michal Hocko
> SUSE Labs

