Return-Path: <bpf+bounces-65383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442BAB21656
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D11A2292A
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7E2D9EF5;
	Mon, 11 Aug 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBB8TRyL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A91F9A89
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943465; cv=none; b=LSIjNN5J0UC9e4AgKStHVGa1EBTICwzfnL8BXR8g0VD3/TpWK8TdEqStWd+youbcPS1x54W/JXYnm0LUR6+okC6cFdTMMN02BQtM9eQRI0JDQyySOsZ+UnWnJNoRr1VtHcRBPNztdMB5kLyy2tDMjQwuPR0DbUPfuiwf41SJq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943465; c=relaxed/simple;
	bh=BEfRdWR+0k9vwTRIcoNpwgKfBwTfi3pzuOWmAYko0WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPdxl8Ud7qXSp2G2XwOtpNUXMwrSShrl+BhdjcBqNvukmbg50KiCXqKhSqjTbQQUCaqRTLvp8ncUpbXS86bNzBKF0/U102wXEXqWBaGjD+rTrrVNSQZz7hWjz/b7mH8RVmIutBJIzZ4TH5axa+YPBDfUiefOXCMh1ZRLLU/qg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBB8TRyL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so6577756a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943461; x=1755548261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnpcKb0Cu2M1Ro3+uXpps7z21brTht265HO8+WGBHRc=;
        b=FBB8TRyLP2mmrXJtmWlLw3/W7NuwCHE1E/e7SvCenc2wNnkCcGyQQDiY7u6seICz41
         3lg/fZX+1DFsKuOpGxxT9NN95XA5WFXXQhBbrDzd1NLpNmv2RH3YZ5Vc74TBHpUZ5Rke
         6NGmB6BnUMu9uAnnsx6g9QB4zirOJpmNPybx3vBvruKFMhjisiJ4I4S2hiZ/AUPxqGcK
         m9NPhvONPX/k5mhMS/wTur5QJWRIOxXtrgt7zf6AYHiyNZoeMRglVDpCyVW/1PolIUPx
         rrIC+28+wOSWeEC9YzyfuJTqSemhfTA/8bOmoyXatrkwPmsybkEM6Hj9E2CGGzSH41ls
         2+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943461; x=1755548261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnpcKb0Cu2M1Ro3+uXpps7z21brTht265HO8+WGBHRc=;
        b=P0/ivSLvcMPFfVmiwGZTHZBT4Tul3l/Gq7syP1Jtp9uZfKBzsz8DHBQaxNRodcphT2
         7ToP4e3ApjdRuSJ5tTIkl5YPoimdxXrHATADDdt/3Bxz7XLnTixJtzfBgxcPSoWi3wdR
         1r7HXPvar5eIQKAWfWIdn7do8QQpaR5EmE/UMZ4TwlaGVmrtu4BO4+lLCZUFV9kO+uzB
         JgBpRYZ/VMJ4ky60K6cyiWjMjVYhBW9+39lNZrRAJ6M8l858FlCKRcZEChCi8fp1kcpF
         imfMPvhSO2VxnSkrbLH4H3MwhN4puj2xhVhBHD4xjBYBWW3IFJwDi90BMxnONneAw5oP
         smzA==
X-Gm-Message-State: AOJu0Yy0QDmibTBjXv9LfEMvfvkuHSW0hKYQbz5SdNrbArpiuukfi75P
	nn9GTTG0T99GBWAgExo3GXdr0tnNtftnMP4qQJd49Mq8Bpos+sKWiO614l0s2MFaYJTB9tYV6s2
	JOc0j315uFuXU1VePTCE/Jl6IPb9T2+E=
X-Gm-Gg: ASbGnct1jY+DGzDKkKsjHQAyZc+05xhe6c485OxwxcPEatQ1o4e7MR9JB8/rVFMS1hy
	rFWpJ0GsCOFyjMDmyzIfFvnpuIoFu2Z8C6j8pTHv2q5s2yQdALnX0/OiP8O6kaBS0FLOGsGeaxz
	MEpuEc9hIY+2afjdRi0OmXwH7JDyYex5MK0MqMidl+jNA9dPQwCFHd0YtpcyNxaN5oHqd2obkL+
	1h80FfRYbWVRB9AAePT7u9wi0ss+hTtfOithLm8
X-Google-Smtp-Source: AGHT+IGfg8IVqyXI2aqnMNIct3A3F6KUCTSBkSVcw8ZCvReHS1pXs6KpLyU3ZGovCIV3L78mNo4/M0fjpOigw6kMKJc=
X-Received: by 2002:a17:907:6d14:b0:ae0:cadc:e745 with SMTP id
 a640c23a62f3a-af9c6517586mr1487484866b.40.1754943460901; Mon, 11 Aug 2025
 13:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
 <20250806144554.576706-4-mykyta.yatsenko5@gmail.com> <CAP01T76ZArSz8r8z2q3J-76N=cQrPh_YBcyMog6VVHcfUNssJg@mail.gmail.com>
 <b4f88016-8eaa-4297-9816-e2855817aa8a@gmail.com> <CAP01T74foMvntpkj9iTE38WRgiCpGWMK_5XQStb+qkDuv=YMYA@mail.gmail.com>
 <38e750e0-9bdf-461f-b270-79cbe5c121df@gmail.com>
In-Reply-To: <38e750e0-9bdf-461f-b270-79cbe5c121df@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 Aug 2025 22:17:04 +0200
X-Gm-Features: Ac12FXx_aB7cOUr-PH7WF3eCi_o4-FpwI8GDN4eK7rjNkJNU195moWB3dIMYsBM
Message-ID: <CAP01T754c-HZS9ZyNwn5y0424oKvMpO88A=JgEnknwYUbAJE9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 at 22:13, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 8/9/25 04:04, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 8 Aug 2025 at 02:44, Mykyta Yatsenko <mykyta.yatsenko5@gmail.co=
m> wrote:
> >> On 8/7/25 19:55, Kumar Kartikeya Dwivedi wrote:
> >>> On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.=
com> wrote:
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Implementation of the bpf_task_work_schedule kfuncs.
> >>>>
> >>>> Main components:
> >>>>    * struct bpf_task_work_context =E2=80=93 Metadata and state manag=
ement per task
> >>>> work.
> >>>>    * enum bpf_task_work_state =E2=80=93 A state machine to serialize=
 work
> >>>>    scheduling and execution.
> >>>>    * bpf_task_work_schedule() =E2=80=93 The central helper that init=
iates
> >>>> scheduling.
> >>>>    * bpf_task_work_callback() =E2=80=93 Invoked when the actual task=
_work runs.
> >>>>    * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in sof=
tirq context)
> >>>> to enqueue task work.
> >>>>    * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted B=
PF map entries.
> >>>>
> >>>> Flow of task work scheduling
> >>>>    1) bpf_task_work_schedule_* is called from BPF code.
> >>>>    2) Transition state from STANDBY to PENDING.
> >>>>    3) irq_work_queue() schedules bpf_task_work_irq().
> >>>>    4) Transition state from PENDING to SCHEDULING.
> >>>>    4) bpf_task_work_irq() attempts task_work_add(). If successful, s=
tate
> >>>>    transitions to SCHEDULED.
> >>>>    5) Task work calls bpf_task_work_callback(), which transition sta=
te to
> >>>>    RUNNING.
> >>>>    6) BPF callback is executed
> >>>>    7) Context is cleaned up, refcounts released, state set back to
> >>>>    STANDBY.
> >>>>
> >>>> Map value deletion
> >>>> If map value that contains bpf_task_work_context is deleted, BPF map
> >>>> implementation calls bpf_task_work_cancel_and_free().
> >>>> Deletion is handled by atomically setting state to FREED and
> >>>> releasing references or letting scheduler do that, depending on the
> >>>> last state before the deletion:
> >>>>    * SCHEDULING: release references in bpf_task_work_cancel_and_free=
(),
> >>>>    expect bpf_task_work_irq() to cancel task work.
> >>>>    * SCHEDULED: release references and try to cancel task work in
> >>>>    bpf_task_work_cancel_and_free().
> >>>>     * other states: one of bpf_task_work_irq(), bpf_task_work_schedu=
le(),
> >>>>     bpf_task_work_callback() should cleanup upon detecting the state
> >>>>     switching to FREED.
> >>>>
> >>>> The state transitions are controlled with atomic_cmpxchg, ensuring:
> >>>>    * Only one thread can successfully enqueue work.
> >>>>    * Proper handling of concurrent deletes (BPF_TW_FREED).
> >>>>    * Safe rollback if task_work_add() fails.
> >>>>
> >>> In general I am not sure why we need so many acquire/release pairs.
> >>> Why not use test_and_set_bit etc.? Or simply cmpxchg?
> >>> What ordering of stores are we depending on that merits
> >>> acquire/release ordering?
> >>> We should probably document explicitly.
> >>>
> >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>> ---
> >>>>    kernel/bpf/helpers.c | 188 ++++++++++++++++++++++++++++++++++++++=
++++-
> >>>>    1 file changed, 186 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>> index 516286f67f0d..4c8b1c9be7aa 100644
> >>>> --- a/kernel/bpf/helpers.c
> >>>> +++ b/kernel/bpf/helpers.c
> >>>> @@ -25,6 +25,8 @@
> >>>>    #include <linux/kasan.h>
> >>>>    #include <linux/bpf_verifier.h>
> >>>>    #include <linux/uaccess.h>
> >>>> +#include <linux/task_work.h>
> >>>> +#include <linux/irq_work.h>
> >>>>
> >>>>    #include "../../lib/kstrtox.h"
> >>>>
> >>>> @@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__i=
gn, const char *s2__ign)
> >>>>
> >>>>    typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *=
, void *);
> >>>>
> >>>> +enum bpf_task_work_state {
> >>>> +       /* bpf_task_work is ready to be used */
> >>>> +       BPF_TW_STANDBY =3D 0,
> >>>> +       /* bpf_task_work is getting scheduled into irq_work */
> >>>> +       BPF_TW_PENDING,
> >>>> +       /* bpf_task_work is in irq_work and getting scheduled into t=
ask_work */
> >>>> +       BPF_TW_SCHEDULING,
> >>>> +       /* bpf_task_work is scheduled into task_work successfully */
> >>>> +       BPF_TW_SCHEDULED,
> >>>> +       /* callback is running */
> >>>> +       BPF_TW_RUNNING,
> >>>> +       /* BPF map value storing this bpf_task_work is deleted */
> >>>> +       BPF_TW_FREED,
> >>>> +};
> >>>> +
> >>>> +struct bpf_task_work_context {
> >>>> +       /* map that contains this structure in a value */
> >>>> +       struct bpf_map *map;
> >>>> +       /* bpf_task_work_state value, representing the state */
> >>>> +       atomic_t state;
> >>>> +       /* bpf_prog that schedules task work */
> >>>> +       struct bpf_prog *prog;
> >>>> +       /* task for which callback is scheduled */
> >>>> +       struct task_struct *task;
> >>>> +       /* notification mode for task work scheduling */
> >>>> +       enum task_work_notify_mode mode;
> >>>> +       /* callback to call from task work */
> >>>> +       bpf_task_work_callback_t callback_fn;
> >>>> +       struct callback_head work;
> >>>> +       struct irq_work irq_work;
> >>>> +} __aligned(8);
> >>> I will echo Alexei's comments about the layout. We cannot inline all
> >>> this in map value.
> >>> Allocation using an init function or in some control function is
> >>> probably the only way.
> >>>
> >>>> +
> >>>> +static bool task_work_match(struct callback_head *head, void *data)
> >>>> +{
> >>>> +       struct bpf_task_work_context *ctx =3D container_of(head, str=
uct bpf_task_work_context, work);
> >>>> +
> >>>> +       return ctx =3D=3D data;
> >>>> +}
> >>>> +
> >>>> +static void bpf_reset_task_work_context(struct bpf_task_work_contex=
t *ctx)
> >>>> +{
> >>>> +       bpf_prog_put(ctx->prog);
> >>>> +       bpf_task_release(ctx->task);
> >>>> +       rcu_assign_pointer(ctx->map, NULL);
> >>>> +}
> >>>> +
> >>>> +static void bpf_task_work_callback(struct callback_head *cb)
> >>>> +{
> >>>> +       enum bpf_task_work_state state;
> >>>> +       struct bpf_task_work_context *ctx;
> >>>> +       struct bpf_map *map;
> >>>> +       u32 idx;
> >>>> +       void *key;
> >>>> +       void *value;
> >>>> +
> >>>> +       rcu_read_lock_trace();
> >>>> +       ctx =3D container_of(cb, struct bpf_task_work_context, work)=
;
> >>>> +
> >>>> +       state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDUL=
ING, BPF_TW_RUNNING);
> >>>> +       if (state =3D=3D BPF_TW_SCHEDULED)
> >>>> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW=
_SCHEDULED, BPF_TW_RUNNING);
> >>>> +       if (state =3D=3D BPF_TW_FREED)
> >>>> +               goto out;
> >>> I am leaving out commenting on this, since I expect it to change per
> >>> later comments.
> >>>
> >>>> +
> >>>> +       map =3D rcu_dereference(ctx->map);
> >>>> +       if (!map)
> >>>> +               goto out;
> >>>> +
> >>>> +       value =3D (void *)ctx - map->record->task_work_off;
> >>>> +       key =3D (void *)map_key_from_value(map, value, &idx);
> >>>> +
> >>>> +       migrate_disable();
> >>>> +       ctx->callback_fn(map, key, value);
> >>>> +       migrate_enable();
> >>>> +
> >>>> +       /* State is running or freed, either way reset. */
> >>>> +       bpf_reset_task_work_context(ctx);
> >>>> +       atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_S=
TANDBY);
> >>>> +out:
> >>>> +       rcu_read_unlock_trace();
> >>>> +}
> >>>> +
> >>>> +static void bpf_task_work_irq(struct irq_work *irq_work)
> >>>> +{
> >>>> +       struct bpf_task_work_context *ctx;
> >>>> +       enum bpf_task_work_state state;
> >>>> +       int err;
> >>>> +
> >>>> +       ctx =3D container_of(irq_work, struct bpf_task_work_context,=
 irq_work);
> >>>> +
> >>>> +       rcu_read_lock_trace();
> >>> What's the idea behind rcu_read_lock_trace? Let's add a comment.
> >>>
> >>>> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING=
, BPF_TW_SCHEDULING);
> >>>> +       if (state =3D=3D BPF_TW_FREED) {
> >>>> +               bpf_reset_task_work_context(ctx);
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> >>> Racy, SCHEDULING->FREE state claim from cancel_and_free will release =
ctx->task.
> >> Thanks for pointing this out, I missed that case.
> >>>> +       if (err) {
> >>>> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW=
_SCHEDULING, BPF_TW_PENDING);
> >>> Races here look fine, since we don't act on FREED (for this block
> >>> atleast), cancel_and_free doesn't act on seeing PENDING,
> >>> so there is interlocking.
> >>>
> >>>> +               if (state =3D=3D BPF_TW_SCHEDULING) {
> >>>> +                       bpf_reset_task_work_context(ctx);
> >>>> +                       atomic_cmpxchg_release(&ctx->state, BPF_TW_P=
ENDING, BPF_TW_STANDBY);
> >>>> +               }
> >>>> +               goto out;
> >>>> +       }
> >>>> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDUL=
ING, BPF_TW_SCHEDULED);
> >>>> +       if (state =3D=3D BPF_TW_FREED)
> >>>> +               task_work_cancel_match(ctx->task, task_work_match, c=
tx);
> >>> It looks like there is a similar race condition here.
> >>> If BPF_TW_SCHEDULING is set, cancel_and_free may invoke and attempt
> >>> bpf_task_release() from bpf_reset_task_work_context().
> >>> Meanwhile, we will access ctx->task here directly after seeing BPF_TW=
_FREED.
> >> Yeah, we should release task_work in this function in case SCHEDULING
> >> gets transitioned into FREED.
> >>>> +out:
> >>>> +       rcu_read_unlock_trace();
> >>>> +}
> >>>> +
> >>>> +static int bpf_task_work_schedule(struct task_struct *task, struct =
bpf_task_work_context *ctx,
> >>>> +                                 struct bpf_map *map, bpf_task_work=
_callback_t callback_fn,
> >>>> +                                 struct bpf_prog_aux *aux, enum tas=
k_work_notify_mode mode)
> >>>> +{
> >>>> +       struct bpf_prog *prog;
> >>>> +
> >>>> +       BTF_TYPE_EMIT(struct bpf_task_work);
> >>>> +
> >>>> +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> >>>> +       if (IS_ERR(prog))
> >>>> +               return -EPERM;
> >>>> +
> >>>> +       if (!atomic64_read(&map->usercnt)) {
> >>>> +               bpf_prog_put(prog);
> >>>> +               return -EPERM;
> >>>> +       }
> >>>> +       task =3D bpf_task_acquire(task);
> >>>> +       if (!task) {
> >>>> +               bpf_prog_put(prog);
> >>>> +               return -EPERM;
> >>>> +       }
> >>>> +
> >>>> +       if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_=
TW_PENDING) !=3D BPF_TW_STANDBY) {
> >>> If we are reusing map values, wouldn't a freed state stay perpetually=
 freed?
> >>> I.e. after the first delete of array elements etc. it becomes useless=
.
> >>> Every array map update would invoke a cancel_and_free.
> >>> Who resets it?
> >> I'm not sure I understand the question, the idea is that if element is
> >> deleted from map, we
> >> transition state to FREED and make sure refcounts of the task and prog
> >> are released.
> >>
> >> An element is returned into STANDBY state after task_work is completed
> >> or failed, so it can be reused.
> >> Could you please elaborate on the scenario you have in mind?
> > I guess I am confused about where we will go from FREED to STANDBY, if
> > we set it to BPF_TW_FREED in cancel_and_free.
> > When you update an array map element, we always do
> > bpf_obj_free_fields. Typically, this operation leaves the field in a
> > reusable state.
> > I don't see a FREED->STANDBY transition (after going from
> > [SCHEDULED|SCHEDULING]->FREED, only RUNNING->STANDBY in the callback.
> I see your point, arraymap does not overwrite those special fields on
> update, thanks!
>

Right, it won't just be array maps though. Hash maps also have memory
reuse, without any reinitialization.
What you want in bpf_obj_free_fields is to claim the field in a way
that it's ready for reuse.
It must be left in a state that if a new program obtains a pointer to
the map value after that, it can reinit the object and begin using it
like if it were allocated anew.

