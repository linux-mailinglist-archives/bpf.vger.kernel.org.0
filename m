Return-Path: <bpf+bounces-42459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A199A45CC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA4628253B
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9E212D2F;
	Fri, 18 Oct 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD8anW5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B490205AC5;
	Fri, 18 Oct 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275744; cv=none; b=MkCKti9GDlP7F+nCJS4h+gMdUPAijpRH+nmqL5AICwqSD+/rG/c6V4avhTLtQcNiLHJz/XzTAn1w6Me1FQeh0OwuHwbiU+HCDZKbUllCTZAdOjXi3CNmNDaRiUryJK42UtpI72+ZZSEZdtGbVRsQKyux+d8RfITOAyfhw6zB7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275744; c=relaxed/simple;
	bh=Kn3q0G4yy+okseMcYvBth/+B4AOC5SrWaIHgjZ7H2Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H15fg2d1To4XHlNZOi+Un5t18wsBU/MmQsZGJUqbJ2x0vCC0X7KK4R9SBrMxY1WPIdUsxeA5fExUafC1lPrFHixtYCHhn9VuNJKU5xCPjlaYJy8EqRwk+BOJUqY02ePMIC4CAsySrAvl61fBdTlNrKVhZWa97iePdTC7cpTtA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD8anW5K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e580256c2so1822973b3a.3;
        Fri, 18 Oct 2024 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729275742; x=1729880542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnT9l2FzL2zeIgdsXhHjT897jOS1j1fl9uDS6ZwUPb8=;
        b=QD8anW5KYNAFDNljv97IqfgUJtttpfKjMRWEzsF9PGcIWfFJc3IdyBpN67/SUnbhwP
         /JEHJYT/NOjEjr7kwbW/N82qCn7gmSolekWq34fouvNYtKhjOeU8KqbRCQk8MMzFInnH
         85mP+mlS9+bX7siCBPdtKdCVMP2OsS8kBYkZzM6MtrE13/noae51lifnE4n9PDs26osZ
         HaKfYvFcfh+k/GS1CpGJ486+i6A6S91+XxlHAwoI/6/WrIcJrpfsne1imFhPS7CxnaxD
         SP1dXw0hRbXNTfMcgaR/ZtPapgWIQAZRESwtg2HhjuXoeGATU5QXeDtHF6FQhCkeJMm2
         7Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275742; x=1729880542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnT9l2FzL2zeIgdsXhHjT897jOS1j1fl9uDS6ZwUPb8=;
        b=sf4ain+5m7AY6QvtpQwJ4Igw8y0inqYvxrnecd5NqIc1ilyCoV/ex3ZdfMv2p5zlGy
         4TPZRwUab84relLx6KrB0NNS142ndNoHmRIDM2Eoyb8H/O1fqlhLUqb44tSCNLuo0SFP
         QvZQirKXBks4qLqt9bNG5IyaIRjWUYerWXD6E84Qx9oFeljjZilOC+UNIXLU1cSOj8tQ
         SyGbraZ02fTLRkB/w+cYuUEGogOciKtcatyI8WthPrCMVUX8e/Bh1HlhxeDPOXZ8fIOh
         s32cjgC4XTKhKxjfM3JGSqGtfc2XrWtPyeK4ZF4O/pKGpN7PGoDu01coYbdcDV20eMIb
         QyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0xKAxR57aHxTOTvgXHKpPv5VSbP2oXWsevpdraT7HfWvs5nTO1SjJr6OHnDU6AnvxipN7uHMFeR3fUKDR@vger.kernel.org, AJvYcCVw4FmdjBO7xJoTTe2eHLy8SpqL0BSueAy3I6qtUZhuHCWVHw4AGZxpS13m2DSH3Xfv5pjLLgt5j91omdIB6k5SANzH@vger.kernel.org, AJvYcCXjJAycfbJf4Ek4mFJOIGLXF4IsNyr1VwgCnv6f4dVAeb8Nehq1xtm/AIOJqjwVcBRn2dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdCCJG1NYG5WcpY9JMYanaSM7Jn89kAwa9KC/ou3Ljep4U7k4
	yqeozMTt6YwIzf7GkIZaxIzMzS6mMKECfP0yTn3hUXJiYVuCBbXaL9AzzHFzfI4DPeGiiFvZUnf
	qQmxIlKdKVBEFCcsBrowfSZG7rnc=
X-Google-Smtp-Source: AGHT+IHBZV0r+vu4DnrjR2kQzoW5WBuT8+Z+xXMQMMGrHSP0gEmDa1QAIFYM7JiejV5QqoHW+Hx38NDx9Sa8ZdZL9Yg=
X-Received: by 2002:aa7:8896:0:b0:71e:587d:f268 with SMTP id
 d2e1a72fcca58-71ea31d7a52mr4521678b3a.4.1729275741548; Fri, 18 Oct 2024
 11:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008002556.2332835-1-andrii@kernel.org> <20241008002556.2332835-3-andrii@kernel.org>
 <20241018101647.GA36494@noisy.programming.kicks-ass.net>
In-Reply-To: <20241018101647.GA36494@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 18 Oct 2024 11:22:09 -0700
Message-ID: <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:16=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 07, 2024 at 05:25:56PM -0700, Andrii Nakryiko wrote:
>

[...]

> > +
> > +             /* We lost the race, undo refcount bump (if it ever happe=
ned) */
> > +             if (uprobe)
> > +                     put_uprobe(uprobe);
> > +             /*
> > +              * Even if hprobe_consume() or another hprobe_expire() wi=
ns
> > +              * the state update race and unlocks SRCU from under us, =
we
> > +              * still have a guarantee that underyling uprobe won't be
> > +              * freed due to ongoing caller's SRCU lock region, so we =
can
> > +              * return it regardless. The caller then can attempt its =
own
> > +              * try_get_uprobe() to preserve the instance, if necessar=
y.
> > +              * This is used in dup_utask().
> > +              */
> > +             return uprobe;
> > +     }
> > +     default:
> > +             WARN(1, "unknown hprobe state %d", hstate);
> > +             return NULL;
> > +     }
> > +}
>
> So... after a few readings I think I'm mostly okay with this. But I got
> annoyed by the whole HPROBE_STABLE with uprobe=3DNULL weirdness. Also,
> that data_race() usage is weird, what is that about?

People keep saying that evil KCSAN will come after me if I don't add
data_race() for values that can change under me, so I add it to make
it explicit that it's fine. But I can of course just drop data_race(),
as it has no bearing on correctness.

>
> And then there's the case where we end up doing:
>
>   try_get_uprobe()
>   put_uprobe()
>   try_get_uprobe()
>
> in the dup path. Yes, it's unlikely, but gah.
>
>
> So how about something like this?

Yep, it makes sense to start with HPROBE_GONE if it's already NULL, no
problem. I'll roll those changes in.

I'm fine with the `bool get` flag as well. Will incorporate all that
into the next revision, thanks!

The only problem I can see is in the assumption that `srcu_idx < 0` is
never going to be returned by srcu_read_lock(). Paul says that it can
only be 0 or 1, but it's not codified as part of a contract. So until
we change that, probably safer to pass an extra bool specifying
whether srcu_idx is valid or not, is that OK?

(and I assume you want me to drop verbose comments for various states, righ=
t?)



>
> ---
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 06ec41c75c45..efb4f5ee6212 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -657,20 +657,19 @@ static void put_uprobe(struct uprobe *uprobe)
>         call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
>  }
>
> -/* Initialize hprobe as SRCU-protected "leased" uprobe */
> -static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *upr=
obe, int srcu_idx)
> +static void hprobe_init(struct hprobe *hprobe, struct uprobe *uprobe, in=
t srcu_idx)
>  {
> -       hprobe->state =3D HPROBE_LEASED;
> -       hprobe->uprobe =3D uprobe;
> -       hprobe->srcu_idx =3D srcu_idx;
> -}
> +       enum hprobe_state state =3D HPROBE_GONE;
>
> -/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL=
). */
> -static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *upr=
obe)
> -{
> -       hprobe->state =3D HPROBE_STABLE;
> +       if (uprobe) {
> +               state =3D HPROBE_LEASED;
> +               if (srcu_idx < 0)
> +                       state =3D HPROBE_STABLE;
> +       }
> +
> +       hprobe->state =3D state;
>         hprobe->uprobe =3D uprobe;
> -       hprobe->srcu_idx =3D -1;
> +       hprobe->srcu_idx =3D srcu_idx;
>  }
>
>  /*
> @@ -713,8 +712,7 @@ static void hprobe_finalize(struct hprobe *hprobe, en=
um hprobe_state hstate)
>                 __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
>                 break;
>         case HPROBE_STABLE:
> -               if (hprobe->uprobe)
> -                       put_uprobe(hprobe->uprobe);
> +               put_uprobe(hprobe->uprobe);
>                 break;
>         case HPROBE_GONE:
>         case HPROBE_CONSUMED:
> @@ -739,8 +737,9 @@ static void hprobe_finalize(struct hprobe *hprobe, en=
um hprobe_state hstate)
>   * refcount, so caller has to attempt try_get_uprobe(), if it needs to
>   * preserve uprobe beyond current SRCU lock region. See dup_utask().
>   */
> -static struct uprobe* hprobe_expire(struct hprobe *hprobe)
> +static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
>  {
> +       struct uprobe *uprobe =3D NULL;
>         enum hprobe_state hstate;
>
>         /*
> @@ -749,25 +748,18 @@ static struct uprobe* hprobe_expire(struct hprobe *=
hprobe)
>          */
>         lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretp=
robes_srcu));
>
> -       hstate =3D data_race(READ_ONCE(hprobe->state));
> +       hstate =3D READ_ONCE(hprobe->state);
>         switch (hstate) {
>         case HPROBE_STABLE:
> -               /* uprobe is properly refcounted, return it */
> -               return hprobe->uprobe;
> +               uprobe =3D hprobe->uprobe;
> +               break;
> +
>         case HPROBE_GONE:
> -               /*
> -                * SRCU was unlocked earlier and we didn't manage to take
> -                * uprobe refcnt, so it's effectively NULL
> -                */
> -               return NULL;
>         case HPROBE_CONSUMED:
> -               /*
> -                * uprobe was consumed, so it's effectively NULL as far a=
s
> -                * uretprobe processing logic is concerned
> -                */
> -               return NULL;
> -       case HPROBE_LEASED: {
> -               struct uprobe *uprobe =3D try_get_uprobe(hprobe->uprobe);
> +               break;
> +
> +       case HPROBE_LEASED:
> +               uprobe =3D try_get_uprobe(hprobe->uprobe);
>                 /*
>                  * Try to switch hprobe state, guarding against
>                  * hprobe_consume() or another hprobe_expire() racing wit=
h us.
> @@ -778,27 +770,26 @@ static struct uprobe* hprobe_expire(struct hprobe *=
hprobe)
>                 if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_=
STABLE : HPROBE_GONE)) {
>                         /* We won the race, we are the ones to unlock SRC=
U */
>                         __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu=
_idx);
> -                       return uprobe;
> +                       break;
>                 }
>
>                 /* We lost the race, undo refcount bump (if it ever happe=
ned) */
> -               if (uprobe)
> +               if (uprobe && !get) {
>                         put_uprobe(uprobe);
> -               /*
> -                * Even if hprobe_consume() or another hprobe_expire() wi=
ns
> -                * the state update race and unlocks SRCU from under us, =
we
> -                * still have a guarantee that underyling uprobe won't be
> -                * freed due to ongoing caller's SRCU lock region, so we =
can
> -                * return it regardless. The caller then can attempt its =
own
> -                * try_get_uprobe() to preserve the instance, if necessar=
y.
> -                * This is used in dup_utask().
> -                */
> +                       uprobe =3D NULL;
> +               }
> +
>                 return uprobe;
> -       }
> +
>         default:
>                 WARN(1, "unknown hprobe state %d", hstate);
>                 return NULL;
>         }
> +
> +       if (uprobe && get)
> +               return try_get_uprobe(uprobe);
> +
> +       return uprobe;
>  }
>
>  static __always_inline
> @@ -1920,9 +1911,8 @@ static void ri_timer(struct timer_list *timer)
>         /* RCU protects return_instance from freeing. */
>         guard(rcu)();
>
> -       for_each_ret_instance_rcu(ri, utask->return_instances) {
> -               hprobe_expire(&ri->hprobe);
> -       }
> +       for_each_ret_instance_rcu(ri, utask->return_instances)
> +               hprobe_expire(&ri->hprobe, false);
>  }
>
>  static struct uprobe_task *alloc_utask(void)
> @@ -1975,10 +1965,7 @@ static int dup_utask(struct task_struct *t, struct=
 uprobe_task *o_utask)
>
>                 *n =3D *o;
>
> -               /* see hprobe_expire() comments */
> -               uprobe =3D hprobe_expire(&o->hprobe);
> -               if (uprobe) /* refcount bump for new utask */
> -                       uprobe =3D try_get_uprobe(uprobe);
> +               uprobe =3D hprobe_expire(&o->hprobe, true);
>
>                 /*
>                  * New utask will have stable properly refcounted uprobe =
or
> @@ -1986,7 +1973,7 @@ static int dup_utask(struct task_struct *t, struct =
uprobe_task *o_utask)
>                  * need to preserve full set of return_instances for prop=
er
>                  * uretprobe handling and nesting in forked task.
>                  */
> -               hprobe_init_stable(&n->hprobe, uprobe);
> +               hprobe_init(&n->hprobe, uprobe, -1);
>
>                 n->next =3D NULL;
>                 rcu_assign_pointer(*p, n);
> @@ -2131,7 +2118,7 @@ static void prepare_uretprobe(struct uprobe *uprobe=
, struct pt_regs *regs)
>
>         utask->depth++;
>
> -       hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
> +       hprobe_init(&ri->hprobe, uprobe, srcu_idx);
>         ri->next =3D utask->return_instances;
>         rcu_assign_pointer(utask->return_instances, ri);
>

