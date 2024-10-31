Return-Path: <bpf+bounces-43662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF659B8036
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA7B21B4E
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8611BC092;
	Thu, 31 Oct 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETAoXiwu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6001A76D1;
	Thu, 31 Oct 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392527; cv=none; b=TipWJ0nxaFwri2GELdQIIxHX02FH0g7na/RkxSU566BFHFYjzJawzjSnKKot4BwTfVGDn860cMX8p4O5ihszS85kUOFFq8HtQ/YtNBsf7/iCUM3yfj0ObQC+wN+bJydlUMxOruGG7YmoTBD6eKVFgcy1vh9YYn5qyjmTE/GgAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392527; c=relaxed/simple;
	bh=y7UPaCjN2pG5bT2k2hZl8m/wpg+0Sw6xm37P4p3ePe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfXAyREkMBVcTND5GyXJso6ErKeP5dZMxYcFBg1t4htKp8EFxo30uOBeSY8oa4oX0Qf51tuJO9wR7sQFX0Rt60gvJs+DZ1vIuYIiGzdqFU5ICdU3IkLgA0VYcs2IdNXvYKnRLZFp8GEgv9U+RaaIACdv5DM9AS8Wta11SxlkjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETAoXiwu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so834938a91.1;
        Thu, 31 Oct 2024 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730392524; x=1730997324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQZjHPdQc1Js4W5rgZSXXL43yAZqAF4/KkLoJSshr48=;
        b=ETAoXiwuTWEm9G/S/yfxg8POH+AKyOop1ytRlWyG00AIUcHx814P6RDcToRpdNhC+r
         DkL9OWHq40f8ZQgwv5lmRw/e0HOxoog0DgipGGK2Tlf7UEAU6FROX0fTym32G4lwzNuh
         zOr/UXp3hl4hie4Twko9qtwgyxsrZnLUlStcgK+5SnanWuR3UrfLxmBIXJwjr5yL/laL
         gV1VpTPIMKj0oUJPlz6spxxajt98QAS2dPXBUvtCsy/x+LfuRQnKspA1YkLcjqk2gWE+
         2MyJ0s0Zs6NJegyElHfelqImBIT0zHRHztIrRdE4V351UV0j61J7TwQ+qquA44K5RCyF
         mn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392524; x=1730997324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQZjHPdQc1Js4W5rgZSXXL43yAZqAF4/KkLoJSshr48=;
        b=rVbS+vaRXtrwYU5HIRrFVfplkVhZBXvpQnha5BL4dLA8K5WhN36i1nbkpZlRW+vSsG
         sRA1ojknR5tuJLfNiFJ6n/KlrHWU1AnLanx8t/MZ/vr9JgyjCITGVYtMf0gThItTQxt3
         orfcMyy2qcZLl084FcUO1Ij4zTWZX98q+FrdMxFeS9SLbswRECEILojG+RWlZE6Hw+5E
         XW7NAv64BXjumA5O3FHyb0zjuwDIyU/JfQGEisgDTYqxNbKRUcaUqw0Q0C6Nlqt1tH5e
         CNF+cpcqGl609gLSE7EUC8nfa6PDgWFiZYH0HN9S0VjlLZ2QDj7s2KEk3a51oCTqEV9S
         xIIg==
X-Forwarded-Encrypted: i=1; AJvYcCUATeNTBhm7G1kreaaHrn1W7V7Uj8M8RwSsCcwTupmuYywnaiKX64v9WWhXT7MzDqZswlk=@vger.kernel.org, AJvYcCVRneylxd7CXo5DXedgdysWjoUlXN1YyzGDGxHGxq+joeDDdKetDHViujPDxRwVhLgw51u27tFXu0TL5OLb@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKNmWXKjropaSn1HrMJQsj2JgKTGa60XwVPc/90I6TAYhRCBs
	gT7QBf2y25xAbX+q0C060m6ljrr9Yrc9OEgraylzkvHN7rijVIknbcJCKtzUn44UjqZD2z85Snt
	tskkWyWqkrfPoPCAwklVoQoe8Vmk=
X-Google-Smtp-Source: AGHT+IGct5Z81LnXrpCq5iaq/LuLEXgtvp+LltQofm6TuFzJDBxpvxfF/+6rACkNAg6nnWucRfqkWm2J/39zXua2elY=
X-Received: by 2002:a17:90b:4f44:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-2e93e0768damr4782503a91.5.1730392524531; Thu, 31 Oct 2024
 09:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <20241026154629.593041-3-mathieu.desnoyers@efficios.com> <CAEf4BzaD24V=Z6T3wNh27pv9OV_WaLNQeAPbUANQJYN0h5zHKw@mail.gmail.com>
 <7ef1d403-e6ca-4dee-85c6-e32446e52aa7@efficios.com> <b8e01a00-0405-41af-8316-9cfa28e698db@efficios.com>
In-Reply-To: <b8e01a00-0405-41af-8316-9cfa28e698db@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 31 Oct 2024 09:35:12 -0700
Message-ID: <CAEf4BzYrZZH7uTuBG=feL+AORgxqtAKhG3hJ=vUJvQd1xSOe0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>, syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:44=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-10-28 15:19, Mathieu Desnoyers wrote:
> > On 2024-10-27 21:22, Andrii Nakryiko wrote:
> >> On Sat, Oct 26, 2024 at 8:48=E2=80=AFAM Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >>>
> >>> The grace period used internally within tracepoint.c:release_probes()
> >>> uses call_rcu() to batch waiting for quiescence of old probe arrays,
> >>> rather than using the tracepoint_synchronize_unregister() which block=
s
> >>> while waiting for quiescence.
> >>>
> >>> With the introduction of faultable syscall tracepoints, this causes
> >>> use-after-free issues reproduced with syzkaller.
> >>>
> >>> Fix this by using the appropriate call_rcu() or call_rcu_tasks_trace(=
)
> >>> before invoking the rcu_free_old_probes callback. This can be chosen
> >>> using the tracepoint_is_syscall() API.
> >>>
> >>> A similar issue exists in bpf use of call_rcu(). Fixing this is left =
to
> >>> a separate change.
> >>>
> >>> Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
> >>> Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to
> >>> handle page faults")
> >>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>> Cc: Michael Jeanson <mjeanson@efficios.com>
> >>> Cc: Steven Rostedt <rostedt@goodmis.org>
> >>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Cc: Paul E. McKenney <paulmck@kernel.org>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >>> Cc: Namhyung Kim <namhyung@kernel.org>
> >>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> Cc: bpf@vger.kernel.org
> >>> Cc: Joel Fernandes <joel@joelfernandes.org>
> >>> Cc: Jordan Rife <jrife@google.com>
> >>> ---
> >>> Changes since v0:
> >>> - Introduce tracepoint_call_rcu(),
> >>> - Fix bpf_link_free() use of call_rcu as well.
> >>>
> >>> Changes since v1:
> >>> - Use tracepoint_call_rcu() for bpf_prog_put as well.
> >>>
> >>> Changes since v2:
> >>> - Do not cover bpf changes in the same commit, let bpf developers
> >>>    implement it.
> >>> ---
> >>>   kernel/tracepoint.c | 11 +++++++----
> >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> >>> index 5658dc92f5b5..47569fb06596 100644
> >>> --- a/kernel/tracepoint.c
> >>> +++ b/kernel/tracepoint.c
> >>> @@ -106,13 +106,16 @@ static void rcu_free_old_probes(struct rcu_head
> >>> *head)
> >>>          kfree(container_of(head, struct tp_probes, rcu));
> >>>   }
> >>>
> >>> -static inline void release_probes(struct tracepoint_func *old)
> >>> +static inline void release_probes(struct tracepoint *tp, struct
> >>> tracepoint_func *old)
> >>>   {
> >>>          if (old) {
> >>>                  struct tp_probes *tp_probes =3D container_of(old,
> >>>                          struct tp_probes, probes[0]);
> >>>
> >>> -               call_rcu(&tp_probes->rcu, rcu_free_old_probes);
> >>> +               if (tracepoint_is_syscall(tp))
> >>> +                       call_rcu_tasks_trace(&tp_probes->rcu,
> >>> rcu_free_old_probes);
> >>
> >> should this be call_rcu_tasks_trace() -> call_rcu() chain instead of
> >> just call_rcu_tasks_trace()? While currently call_rcu_tasks_trace()
> >> implies RCU GP (as evidenced by rcu_trace_implies_rcu_gp() being
> >> hardcoded right now to returning true), this might not always be the
> >> case in the future, so it's best to have a guarantee that regardless
> >> of sleepable or not, we'll always have have RCU GP, and for sleepable
> >> tracepoint *also* RCU Tasks Trace GP.
> >
> > Given that faultable tracepoints only use RCU tasks trace for the
> > read-side and do not rely on preempt disable, I don't see why we would
> > need to chain both grace periods there ?
>
> Hi Andrii,
>
> AFAIU, your question above is rooted in the way bpf does its sleepable
> program grace periods (chaining RCU tasks trace + RCU GP), e.g.:
>
> bpf_map_free_mult_rcu_gp
> bpf_link_defer_dealloc_mult_rcu_gp
>
> and
>
> bpf_link_free:
>                  /* schedule BPF link deallocation; if underlying BPF pro=
gram
>                   * is sleepable, we need to first wait for RCU tasks tra=
ce
>                   * sync, then go through "classic" RCU grace period
>                   */
>
> This is introduced in commit 1a80dbcb2db ("bpf: support deferring bpf_lin=
k dealloc to after RCU grace period")
> which has a bit more information in the commit message, but what I'm not =
seeing
> is an explanation of *why* chaining RCU tasks trace and RCU grace periods=
 is
> needed for sleepable bpf programs. What am I missing ?

At least one of the reasons are BPF maps that can be used from both
sleepable and non-sleepable BPF programs *at the same time*. So in BPF
everything is *at least* protected with rcu_read_lock(), and then
sleepable-capable things are *additionally* supported by
rcu_read_tasks_trace(). So on destruction, we chain both RCU GP kinds
to make sure that all users can't see BPF map/prog/(and soon links).

It might not be strictly necessary in general, but you are right that
I asked because of how we do this in BPF. Also, in practice, tasks
trace RCU GP implies RCU GP, so there is no overhead for how we do
this for BPF maps (and progs? didn't check).

Anyways, this might be fine as is.

>
> As far as tracepoint.c release_probes() is concerned, just waiting for
> RCU tasks trace before freeing memory of faultable tracepoints is
> sufficient.
>
> Thanks,
>
> Mathieu
>
> >
> > Thanks,
> >
> > Mathieu
> >
> >>
> >>> +               else
> >>> +                       call_rcu(&tp_probes->rcu, rcu_free_old_probes=
);
> >>>          }
> >>>   }
> >>>
> >>> @@ -334,7 +337,7 @@ static int tracepoint_add_func(struct tracepoint
> >>> *tp,
> >>>                  break;
> >>>          }
> >>>
> >>> -       release_probes(old);
> >>> +       release_probes(tp, old);
> >>>          return 0;
> >>>   }
> >>>
> >>> @@ -405,7 +408,7 @@ static int tracepoint_remove_func(struct
> >>> tracepoint *tp,
> >>>                  WARN_ON_ONCE(1);
> >>>                  break;
> >>>          }
> >>> -       release_probes(old);
> >>> +       release_probes(tp, old);
> >>>          return 0;
> >>>   }
> >>>
> >>> --
> >>> 2.39.5
> >>>
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

