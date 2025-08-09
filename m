Return-Path: <bpf+bounces-65292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5AB1F1FB
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7235C56812A
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D863275B17;
	Sat,  9 Aug 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYLcoxaO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE58376F1
	for <bpf@vger.kernel.org>; Sat,  9 Aug 2025 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754708699; cv=none; b=FeWJ7H0xuBZ+jEoY0ZPPLo//yyg8hukxpGeldURI7no5uHECYM8X156qz1+k2RmfYgAuZWfxNWx3jF0eja0AEje+Soynk/9O1uVfBFUGtlGaEixXeEjFHudAZhoB+7ldMqvtbN7AxFQBq+hs4Oi7XCTMeAz4rl+Fj/AA4PMF9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754708699; c=relaxed/simple;
	bh=IXLHf6W+IAKwUQxhmqECFx+jZbyb0eLsuap+uUTaM2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9A/4+IZNjaOKYJzoYeVsquxonwc0+WTScqOJIxIzVQntxqblo2Z2aK3Z0AD/ZBW7dBffz4OI3UZqsTtitpoJrqAl4NAqaa1lSirAxEH1NWW96MgwYe9wUEjg06/hhVAZ96s1qQPvXDJY8/YY+qJEJ2iw2wiWYt5ZdO8M1B05Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYLcoxaO; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae9c2754a00so530185766b.2
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754708695; x=1755313495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnfWUCWhBML6gyi3XE9KepaEeqDbgdYhgzIG+DcsPmg=;
        b=EYLcoxaO/W/lFlMp8mpVry43QX8osmKzsQSpj7WjR1m6fo2HEU8AiIS9TZ1EIZF0gJ
         omgYNxl/ukELtoeWlZteMB0CcPM2M1LxZyGfzwIgbltNCr5jzU35gVJITFQpiC3lw0RF
         +0P1njQcbBik0cOxMlyg+8ZVLrGn/KLGMzJDTpY/gv9YidYyVqZU6+WHh5coC9TOdwjM
         gR3kGUIGDvBvBrv2gaTXtZd9+SI69dGRsDtCNfBw6kXCCpLkImrk9xRfUj+0vrhctUiF
         /K85kSOopmdiytZmc1VUHBND1tqPdqt1dlqBJPaath4CJeqcVkkXahQcnQpBytsfPpfH
         tDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754708695; x=1755313495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnfWUCWhBML6gyi3XE9KepaEeqDbgdYhgzIG+DcsPmg=;
        b=tmOsl9KbnvDKLf5NGdjy0TmpEwpDNTW0TowgZu3IGotUw28mnf34qpEqCHLIO/ZlQw
         IrP3vU/5R8jArdhNojeJfRmVFE+jq85GfpVBO0OYhQkT+33F8VopSBWd0k4FfXbBZcyY
         BGM/mnKG9Kb2hLWFF4kQb949pJQgw5mK/1Lb2SHXdOEimlMTKxgrYw0I9EMEoUkrEI0x
         V07Wjpusd4OXUPiT8OYZW/Zds35bJ0jQf6Ec9mUe3yHHfftZ9A76ZyhrbZ8TNoW/P8uC
         zIeAQ80PGtanKv9RzIYa7OMcGA/Jot9y+78PPEvAviFxDsE3srg2uOmwZGIG01QLKUje
         Mnow==
X-Gm-Message-State: AOJu0Yx8Dz6W9XmdRBk199yM2HUluztlLd+Rm9pHUM5v9174o7IKsuu0
	mf2djWjYhLiNhMD6rhMuG+Xsi1lgkdroC0F1StMsjSsZamIZ86h0V8Df4Q2oFqPRQrz8H3r73qg
	1/u0FgDYzDETWs1KKn1HW0YX8b6Ac2q8b8sPv
X-Gm-Gg: ASbGncu4vQ088Zblvd3Q1V/yf9fLXbW4604fmWUWdXVh1wN/Dv0UwPIRUvBxAV2TrAX
	BoYh4p6mcZROsGeT+6sT/6/LIBdv5DwZx4C6sXrW0m/6zebbMVo1NIQ+78rB3c4S8dJjhJw+MpY
	Fl4E1PvlTXJhV6opquPdJuu/RpRuDB++9hk8oH0N2YKI1HULwbVQk2QaQ7pHxVnOYVnheSj/6sg
	PqtrSKSbe+sj7Kv6FdB1KkdI4H4QoOfUh+5/ZUs
X-Google-Smtp-Source: AGHT+IHmbhc6GECPNEwUHjw4QQU9yrw9xW1S2CCyoFq/it5QBBC3DFCEznlHIakt6Yo5GR+mZ7/xwL658D8lvoa9bF4=
X-Received: by 2002:a17:907:2d1e:b0:ae0:a483:39bc with SMTP id
 a640c23a62f3a-af9c6542749mr467030466b.46.1754708694835; Fri, 08 Aug 2025
 20:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
 <20250806144554.576706-4-mykyta.yatsenko5@gmail.com> <CAP01T76ZArSz8r8z2q3J-76N=cQrPh_YBcyMog6VVHcfUNssJg@mail.gmail.com>
 <b4f88016-8eaa-4297-9816-e2855817aa8a@gmail.com>
In-Reply-To: <b4f88016-8eaa-4297-9816-e2855817aa8a@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 9 Aug 2025 05:04:18 +0200
X-Gm-Features: Ac12FXygi_T0eN0EZrq2XM6U8dSsGk5lytGKesR9WkNYR8eEpfRGfwwsb6OYDQ4
Message-ID: <CAP01T74foMvntpkj9iTE38WRgiCpGWMK_5XQStb+qkDuv=YMYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 at 02:44, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> w=
rote:
>
> On 8/7/25 19:55, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.co=
m> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Implementation of the bpf_task_work_schedule kfuncs.
> >>
> >> Main components:
> >>   * struct bpf_task_work_context =E2=80=93 Metadata and state manageme=
nt per task
> >> work.
> >>   * enum bpf_task_work_state =E2=80=93 A state machine to serialize wo=
rk
> >>   scheduling and execution.
> >>   * bpf_task_work_schedule() =E2=80=93 The central helper that initiat=
es
> >> scheduling.
> >>   * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_wo=
rk runs.
> >>   * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softir=
q context)
> >> to enqueue task work.
> >>   * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF =
map entries.
> >>
> >> Flow of task work scheduling
> >>   1) bpf_task_work_schedule_* is called from BPF code.
> >>   2) Transition state from STANDBY to PENDING.
> >>   3) irq_work_queue() schedules bpf_task_work_irq().
> >>   4) Transition state from PENDING to SCHEDULING.
> >>   4) bpf_task_work_irq() attempts task_work_add(). If successful, stat=
e
> >>   transitions to SCHEDULED.
> >>   5) Task work calls bpf_task_work_callback(), which transition state =
to
> >>   RUNNING.
> >>   6) BPF callback is executed
> >>   7) Context is cleaned up, refcounts released, state set back to
> >>   STANDBY.
> >>
> >> Map value deletion
> >> If map value that contains bpf_task_work_context is deleted, BPF map
> >> implementation calls bpf_task_work_cancel_and_free().
> >> Deletion is handled by atomically setting state to FREED and
> >> releasing references or letting scheduler do that, depending on the
> >> last state before the deletion:
> >>   * SCHEDULING: release references in bpf_task_work_cancel_and_free(),
> >>   expect bpf_task_work_irq() to cancel task work.
> >>   * SCHEDULED: release references and try to cancel task work in
> >>   bpf_task_work_cancel_and_free().
> >>    * other states: one of bpf_task_work_irq(), bpf_task_work_schedule(=
),
> >>    bpf_task_work_callback() should cleanup upon detecting the state
> >>    switching to FREED.
> >>
> >> The state transitions are controlled with atomic_cmpxchg, ensuring:
> >>   * Only one thread can successfully enqueue work.
> >>   * Proper handling of concurrent deletes (BPF_TW_FREED).
> >>   * Safe rollback if task_work_add() fails.
> >>
> > In general I am not sure why we need so many acquire/release pairs.
> > Why not use test_and_set_bit etc.? Or simply cmpxchg?
> > What ordering of stores are we depending on that merits
> > acquire/release ordering?
> > We should probably document explicitly.
> >
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 188 +++++++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 186 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 516286f67f0d..4c8b1c9be7aa 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -25,6 +25,8 @@
> >>   #include <linux/kasan.h>
> >>   #include <linux/bpf_verifier.h>
> >>   #include <linux/uaccess.h>
> >> +#include <linux/task_work.h>
> >> +#include <linux/irq_work.h>
> >>
> >>   #include "../../lib/kstrtox.h"
> >>
> >> @@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign=
, const char *s2__ign)
> >>
> >>   typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, v=
oid *);
> >>
> >> +enum bpf_task_work_state {
> >> +       /* bpf_task_work is ready to be used */
> >> +       BPF_TW_STANDBY =3D 0,
> >> +       /* bpf_task_work is getting scheduled into irq_work */
> >> +       BPF_TW_PENDING,
> >> +       /* bpf_task_work is in irq_work and getting scheduled into tas=
k_work */
> >> +       BPF_TW_SCHEDULING,
> >> +       /* bpf_task_work is scheduled into task_work successfully */
> >> +       BPF_TW_SCHEDULED,
> >> +       /* callback is running */
> >> +       BPF_TW_RUNNING,
> >> +       /* BPF map value storing this bpf_task_work is deleted */
> >> +       BPF_TW_FREED,
> >> +};
> >> +
> >> +struct bpf_task_work_context {
> >> +       /* map that contains this structure in a value */
> >> +       struct bpf_map *map;
> >> +       /* bpf_task_work_state value, representing the state */
> >> +       atomic_t state;
> >> +       /* bpf_prog that schedules task work */
> >> +       struct bpf_prog *prog;
> >> +       /* task for which callback is scheduled */
> >> +       struct task_struct *task;
> >> +       /* notification mode for task work scheduling */
> >> +       enum task_work_notify_mode mode;
> >> +       /* callback to call from task work */
> >> +       bpf_task_work_callback_t callback_fn;
> >> +       struct callback_head work;
> >> +       struct irq_work irq_work;
> >> +} __aligned(8);
> > I will echo Alexei's comments about the layout. We cannot inline all
> > this in map value.
> > Allocation using an init function or in some control function is
> > probably the only way.
> >
> >> +
> >> +static bool task_work_match(struct callback_head *head, void *data)
> >> +{
> >> +       struct bpf_task_work_context *ctx =3D container_of(head, struc=
t bpf_task_work_context, work);
> >> +
> >> +       return ctx =3D=3D data;
> >> +}
> >> +
> >> +static void bpf_reset_task_work_context(struct bpf_task_work_context =
*ctx)
> >> +{
> >> +       bpf_prog_put(ctx->prog);
> >> +       bpf_task_release(ctx->task);
> >> +       rcu_assign_pointer(ctx->map, NULL);
> >> +}
> >> +
> >> +static void bpf_task_work_callback(struct callback_head *cb)
> >> +{
> >> +       enum bpf_task_work_state state;
> >> +       struct bpf_task_work_context *ctx;
> >> +       struct bpf_map *map;
> >> +       u32 idx;
> >> +       void *key;
> >> +       void *value;
> >> +
> >> +       rcu_read_lock_trace();
> >> +       ctx =3D container_of(cb, struct bpf_task_work_context, work);
> >> +
> >> +       state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULIN=
G, BPF_TW_RUNNING);
> >> +       if (state =3D=3D BPF_TW_SCHEDULED)
> >> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_S=
CHEDULED, BPF_TW_RUNNING);
> >> +       if (state =3D=3D BPF_TW_FREED)
> >> +               goto out;
> > I am leaving out commenting on this, since I expect it to change per
> > later comments.
> >
> >> +
> >> +       map =3D rcu_dereference(ctx->map);
> >> +       if (!map)
> >> +               goto out;
> >> +
> >> +       value =3D (void *)ctx - map->record->task_work_off;
> >> +       key =3D (void *)map_key_from_value(map, value, &idx);
> >> +
> >> +       migrate_disable();
> >> +       ctx->callback_fn(map, key, value);
> >> +       migrate_enable();
> >> +
> >> +       /* State is running or freed, either way reset. */
> >> +       bpf_reset_task_work_context(ctx);
> >> +       atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_STA=
NDBY);
> >> +out:
> >> +       rcu_read_unlock_trace();
> >> +}
> >> +
> >> +static void bpf_task_work_irq(struct irq_work *irq_work)
> >> +{
> >> +       struct bpf_task_work_context *ctx;
> >> +       enum bpf_task_work_state state;
> >> +       int err;
> >> +
> >> +       ctx =3D container_of(irq_work, struct bpf_task_work_context, i=
rq_work);
> >> +
> >> +       rcu_read_lock_trace();
> > What's the idea behind rcu_read_lock_trace? Let's add a comment.
> >
> >> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, =
BPF_TW_SCHEDULING);
> >> +       if (state =3D=3D BPF_TW_FREED) {
> >> +               bpf_reset_task_work_context(ctx);
> >> +               goto out;
> >> +       }
> >> +
> >> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > Racy, SCHEDULING->FREE state claim from cancel_and_free will release ct=
x->task.
> Thanks for pointing this out, I missed that case.
> >
> >> +       if (err) {
> >> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_S=
CHEDULING, BPF_TW_PENDING);
> > Races here look fine, since we don't act on FREED (for this block
> > atleast), cancel_and_free doesn't act on seeing PENDING,
> > so there is interlocking.
> >
> >> +               if (state =3D=3D BPF_TW_SCHEDULING) {
> >> +                       bpf_reset_task_work_context(ctx);
> >> +                       atomic_cmpxchg_release(&ctx->state, BPF_TW_PEN=
DING, BPF_TW_STANDBY);
> >> +               }
> >> +               goto out;
> >> +       }
> >> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDULIN=
G, BPF_TW_SCHEDULED);
> >> +       if (state =3D=3D BPF_TW_FREED)
> >> +               task_work_cancel_match(ctx->task, task_work_match, ctx=
);
> > It looks like there is a similar race condition here.
> > If BPF_TW_SCHEDULING is set, cancel_and_free may invoke and attempt
> > bpf_task_release() from bpf_reset_task_work_context().
> > Meanwhile, we will access ctx->task here directly after seeing BPF_TW_F=
REED.
> Yeah, we should release task_work in this function in case SCHEDULING
> gets transitioned into FREED.
> >
> >> +out:
> >> +       rcu_read_unlock_trace();
> >> +}
> >> +
> >> +static int bpf_task_work_schedule(struct task_struct *task, struct bp=
f_task_work_context *ctx,
> >> +                                 struct bpf_map *map, bpf_task_work_c=
allback_t callback_fn,
> >> +                                 struct bpf_prog_aux *aux, enum task_=
work_notify_mode mode)
> >> +{
> >> +       struct bpf_prog *prog;
> >> +
> >> +       BTF_TYPE_EMIT(struct bpf_task_work);
> >> +
> >> +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> >> +       if (IS_ERR(prog))
> >> +               return -EPERM;
> >> +
> >> +       if (!atomic64_read(&map->usercnt)) {
> >> +               bpf_prog_put(prog);
> >> +               return -EPERM;
> >> +       }
> >> +       task =3D bpf_task_acquire(task);
> >> +       if (!task) {
> >> +               bpf_prog_put(prog);
> >> +               return -EPERM;
> >> +       }
> >> +
> >> +       if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_TW=
_PENDING) !=3D BPF_TW_STANDBY) {
> > If we are reusing map values, wouldn't a freed state stay perpetually f=
reed?
> > I.e. after the first delete of array elements etc. it becomes useless.
> > Every array map update would invoke a cancel_and_free.
> > Who resets it?
> I'm not sure I understand the question, the idea is that if element is
> deleted from map, we
> transition state to FREED and make sure refcounts of the task and prog
> are released.
>
> An element is returned into STANDBY state after task_work is completed
> or failed, so it can be reused.
> Could you please elaborate on the scenario you have in mind?

I guess I am confused about where we will go from FREED to STANDBY, if
we set it to BPF_TW_FREED in cancel_and_free.
When you update an array map element, we always do
bpf_obj_free_fields. Typically, this operation leaves the field in a
reusable state.
I don't see a FREED->STANDBY transition (after going from
[SCHEDULED|SCHEDULING]->FREED, only RUNNING->STANDBY in the callback.

