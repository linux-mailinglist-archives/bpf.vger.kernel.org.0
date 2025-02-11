Return-Path: <bpf+bounces-51192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA35A31981
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 00:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E1F7A29F6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B98268FE8;
	Tue, 11 Feb 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLSy9awn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FB268FD6
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316380; cv=none; b=bVjj3E77//qKQroyopQ1UwrNWCL971uhFcJGnUAZ73+ho7+7jJQClLVVoImLtCh5GYPW2UAF+8UB2m8sOq3akvHRrkM7C+xNYMr0ZSNltiw71q0U0O7bDNvLO9ZswGpljlFiKq9TuwJXI295TUlDvwaNvtsFu74t7IMjUalcgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316380; c=relaxed/simple;
	bh=OyjtGZwLB6wJ6XfBuVNVzEH1QJWQax0NAM4q8NVamRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwKk+xoY0X4g5ZsJLH3+OZVUHuPxsnjNo0bQdb6n9+S1yXAO2ri9hzbPtgg3uZelAGPtwQWUKhzCGL29D1p+xrDJRpbuzemwGP6xU6yJKUIRZmwcf2wHjTfRJ4QLDHTA8hp0Kdm02R24YyoCWWCKkzk/kJeTVECngEvyJ4z3abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLSy9awn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7b80326cdso519935266b.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 15:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739316376; x=1739921176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIRgGnZzeL8oyIGuJ6M9YFl5sM6n4F2oqo8yvAi1aFY=;
        b=JLSy9awn1JUz69j4/6bbwnEx2RCwkoiXEVScHomDBRZyNjIjWGQAhLdBP/YlfX3ss4
         a/DYQDzo6Ghra2lYRdhIXiB6FyfzCAcirtB4+nAhjga330KtQxmAHWmMIuDsR0s8r1Ki
         NL32C0rteq4zQvwKVo+tffqEEDbyFjrmDfZFaJtQzzx6xOGXcUt7IibrVJnfi9HbW1mW
         xocd7YEwNQRgPFN3fUw9H0oIyZVHcfjm1+BERSuKhtUW7LkPo3rYybYy+v9Bd8/aEVoP
         KLlup98WwWtEb5QHHTf72yy6vS/FHvvNGdbSEUTStSpTAhgCk+khfRK5MMv5QX8TVPvg
         cxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739316376; x=1739921176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIRgGnZzeL8oyIGuJ6M9YFl5sM6n4F2oqo8yvAi1aFY=;
        b=YbyUPZzqN9pzr8G8EhEQVBjzhF69vmdrODiQdRL5VtWqmhFLxCCEMHc1qayAi+VBaa
         h+QpVtPAovC+5PGyLYB+ehIv03sUcIN/y/jhurKiSweQH/cr9wlUupt9lDqWYLtKhbNW
         IenMkTfsFr2hjoe9Z8ByOGhwMUatuFKgd9MRk9DCCpqgoA9PJf31sdER4GX2u/Mo/bTU
         3eminFoHE90XSRMivy2gsC79LodV1QnIDktaCtE+mEL/crDtuKN4JncLPvKvL4VPAXMt
         Dd/5VvOqJp/Do2qDKgEGghkkH0Eqs/R7tUQFocVAc7Eg2rOqjIZEnD6EZ+g/8x04+1vR
         cxzA==
X-Forwarded-Encrypted: i=1; AJvYcCW+PMs4k0DTTVi2vZ2GdIAjMJPy9WM9ldp62z2QjjgTrqm1HCrJjm90DczMcW9fipBspVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYx6nXA2jBVTsPhZeKAwc3p3qdxVIy0NLvaakysbNDkET516An
	wMcikZ5DBwCASd7jxfBjlSxP8Xw2DjMOLy9z3H8J0v69P1pHc31GNs9BGGikqVA0/QZX0YRVA+x
	GMr3d3ZcHpo9H9ejPh3/uIGjGAvfVBFkKkaLO
X-Gm-Gg: ASbGncuikmlEKko/WJ7oQ4LfcWnSILIJpjG7VGapkSETRedTthz81Fsq5UYzzuJUFI8
	t7h/6uHTbMg5R9zxpT8snUmHtZQr0cUTcsA5hMPvI8OMnmUIChEYXeDWC5j0DbdJqrIm+3acoV/
	Q2u309IsJB5r5XpIO3VEm25xN0KBk1
X-Google-Smtp-Source: AGHT+IH5ncf8/Pf2SP2paLMKOChpAWSifR/hZsZuY37dDWb7AtZS7IH18icpqTVB4dhd4fxpRoPksEd81NBlYsBu9mU=
X-Received: by 2002:a17:906:478f:b0:aa6:84c3:70e2 with SMTP id
 a640c23a62f3a-ab7f33a1c4emr66516166b.20.1739316375863; Tue, 11 Feb 2025
 15:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com> <20250130052510.860318-3-ctshao@google.com>
 <Z51hO-0TCmayVc7F@google.com>
In-Reply-To: <Z51hO-0TCmayVc7F@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 11 Feb 2025 15:26:04 -0800
X-Gm-Features: AWEUYZmwS4p1nqfU1l1INRRMoQ5HH70LwslHH4b1UrkCNvYQj0qVdqXQpwvxwWk
Message-ID: <CAJpZYjVPfWznVm2Zcvk77Np-vfKKNiWH2ipB58QCJ4ZQ6h_afw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] perf lock: Retrieve owner callstack in bpf program
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung, thanks for your review first!


On Fri, Jan 31, 2025 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 29, 2025 at 09:21:36PM -0800, Chun-Tse Shao wrote:
> > Tracks lock contention by tracing owner callstacks in
> > `contention_begin()` and `contention_end()`, storing data in the
> > owner_stat BPF map. `contention_begin()` records the owner and their
> > callstack. `contention_end()` updates contention statistics (count,
> > time), decrements the waiter count, and removes the record when no
> > waiters remain. Statistics are also updated if the owner's callstack
> > changes. Note that owner and its callstack retrieval may fail.
> >
> > To elaborate the process in detail:
> >   /*
> >    * In `contention_begin(), the current task is the lock waiter`. We
> >    * create/update `owner_data` for the given `lock` address.
> >   contention_begin() {
> >     Try to get owner task. Skip entire process if fails.
> >     Try to get owner stack based on task. Use empty stack if fails.
> >     Store owner stack into `owner_stacks` and create `stack_id`. If fai=
l
> >       to store, use negative `stack_id`, which will be ignored while
> >       reporting in usermode.
> >     Retrieve `owner_tracing_data` in `owner_data` with given `lock`
> >       address.
> >
> >     /*
> >      * The first case means contention just happens, or mismatched owne=
r
> >      * infomation so we just drop the previous record.
> >      */
> >     if (`owner_tracing_data` does not exist ||
> >         the recorded owner `pid` does not match with the detected owner=
) {
> >       Create `owner_tracing_data` with info from detected owner, and
> >         store it in `owner_data` with key `lock` address.
> >     }
> >     /*
> >      * The second case means contention is on going. One more waiter is
> >      * joining the lock contention. Both `owner_data` and `owner_stat`
> >      * should be updated.
> >      */
> >     else {
> >       `owner_tracing_data.count`++
> >
> >       Create `contention_key` with owner `stack_id` and lookup
> >         `contention_data` in `owner_stat`.
> >       if (`contention_data` does not exist) {
> >         Create new entry for `contention_key`:`contention_data` in
> >           `owner_stat`.
> >       }
> >       else {
> >         Update the `count` and `total_time` in existing
> >         `contention_data`.
> >       }
> >
> >       Update `timestamp` and `stack_id` in `owner_tracing_data`.
> >     }
> >   }
> >
> >   /*
> >    * In `contention_end()`, the current task will be the new owner of
> >    * the `lock`, if `ctx[1]` is not 0.
> >    */
> >   contention_end() {
> >     Lookup `owner_tracing_data` in `owner_data` with key `lock`.
> >
> >     Create `contention_key` with `owner_tracing_data.stack_id` and
> >       lookup `contention_data` in `owner_stat`.
> >     if (`contention_data` does not exist) {
> >       Create new entry for `contention_key`:`contention_data` in
> >         `owner_stat`.
> >     }
> >     else {
> >       Update the `count` and `total_time` in existing `contention_data`=
.
> >     }
> >
> >     /*
> >      * There is no more waiters, contention is over, delete the record.
> >      */
> >     if (`owner_tracing_data.count` <=3D 1) {
> >       delete this record in `owner_data`.
> >     }
> >     /*
> >      * Contention is still on going.
> >      */
> >     else {
> >       `owner_tracing_data.count`--
> >
> >       if (`!ctx[0]`) {
> >         The current task exits without acquiring the lock. However we
> >           check for the recorded owner if the stack is changed, and
> >           update `onwer_data` and `owner_stat` accordingly.
> >       }
> >       else {
> >         The current task is the new owner, retrieve its stack, store it
> >           in `owner_stack` and update `owner_tracing_data`.
> >       }
> >     }
> >   }
>
> I think this is too much detail. :)
>
> I'd say something like this:
>
> This implements per-callstack aggregation of lock owners in addition to
> per-thread.  The owner callstack is captured using bpf_get_task_stack()
> at contention_begin and it also adds a custom stackid function for the
> owner stacks to be compared easily.
>
> The owner info is kept in a hash map using lock addr as a key to handle
> multiple waiters for the same lock.  At contention_end, it updates the
> owner lock stat based on the info that was saved at contention_begin.
> If there are more waiters, it'd update the owner pid to itself as
> contention_end means it gets the lock now.  But it also needs to check
> the return value of the lock function in case task was killed by a signal
> or something.
>

Thanks, I will just reuse this description. :D

> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 248 +++++++++++++++++-
> >  1 file changed, 247 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 23fe9cc980ae..b12df873379f 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -197,6 +197,9 @@ int data_fail;
> >  int task_map_full;
> >  int data_map_full;
> >
> > +struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
> > +void bpf_task_release(struct task_struct *p) __ksym __weak;
> > +
> >  static inline __u64 get_current_cgroup_id(void)
> >  {
> >       struct task_struct *task;
> > @@ -420,6 +423,26 @@ static inline struct tstamp_data *get_tstamp_elem(=
__u32 flags)
> >       return pelem;
> >  }
> >
> > +static inline s32 get_owner_stack_id(u64 *stacktrace)
> > +{
> > +     s32 *id, new_id;
> > +     static s64 id_gen =3D 1;
> > +
> > +     id =3D bpf_map_lookup_elem(&owner_stacks, stacktrace);
> > +     if (id)
> > +             return *id;
> > +
> > +     new_id =3D (s32)__sync_fetch_and_add(&id_gen, 1);
> > +
> > +     bpf_map_update_elem(&owner_stacks, stacktrace, &new_id, BPF_NOEXI=
ST);
> > +
> > +     id =3D bpf_map_lookup_elem(&owner_stacks, stacktrace);
> > +     if (id)
> > +             return *id;
> > +
> > +     return -1;
> > +}
> > +
> >  SEC("tp_btf/contention_begin")
> >  int contention_begin(u64 *ctx)
> >  {
> > @@ -437,6 +460,97 @@ int contention_begin(u64 *ctx)
> >       pelem->flags =3D (__u32)ctx[1];
> >
> >       if (needs_callstack) {
> > +             u32 i =3D 0;
> > +             u32 id =3D 0;
> > +             int owner_pid;
> > +             u64 *buf;
> > +             struct task_struct *task;
> > +             struct owner_tracing_data *otdata;
> > +
> > +             if (!lock_owner)
> > +                     goto skip_owner_begin;
> > +
> > +             task =3D get_lock_owner(pelem->lock, pelem->flags);
> > +             if (!task)
> > +                     goto skip_owner_begin;
> > +
> > +             owner_pid =3D BPF_CORE_READ(task, pid);
> > +
> > +             buf =3D bpf_map_lookup_elem(&stack_buf, &i);
> > +             if (!buf)
> > +                     goto skip_owner_begin;
> > +             for (i =3D 0; i < max_stack; i++)
> > +                     buf[i] =3D 0x0;
> > +
> > +             if (bpf_task_from_pid) {
>
> I think you can do this instead:
>
>                 if (bpf_task_from_pid =3D=3D NULL)
>                         goto skip_owner_begin;
>
> nit: it can be just 'skip_owner'. :)
>
>
> > +                     task =3D bpf_task_from_pid(owner_pid);
> > +                     if (task) {
> > +                             bpf_get_task_stack(task, buf, max_stack *=
 sizeof(unsigned long), 0);
> > +                             bpf_task_release(task);
> > +                     }
> > +             }
> > +
> > +             otdata =3D bpf_map_lookup_elem(&owner_data, &pelem->lock)=
;
> > +             id =3D get_owner_stack_id(buf);
> > +
> > +             /*
> > +              * Contention just happens, or corner case `lock` is owne=
d by process not
> > +              * `owner_pid`. For the corner case we treat it as unexpe=
cted internal error and
> > +              * just ignore the precvious tracing record.
> > +              */
> > +             if (!otdata || otdata->pid !=3D owner_pid) {
> > +                     struct owner_tracing_data first =3D {
> > +                             .pid =3D owner_pid,
> > +                             .timestamp =3D pelem->timestamp,
> > +                             .count =3D 1,
> > +                             .stack_id =3D id,
> > +                     };
> > +                     bpf_map_update_elem(&owner_data, &pelem->lock, &f=
irst, BPF_ANY);
> > +             }
> > +             /* Contention is ongoing and new waiter joins */
> > +             else {
> > +                     __sync_fetch_and_add(&otdata->count, 1);
> > +
> > +                     /*
> > +                      * The owner is the same, but stacktrace might be=
 changed. In this case we
> > +                      * store/update `owner_stat` based on current own=
er stack id.
> > +                      */
> > +                     if (id !=3D otdata->stack_id) {
> > +                             u64 duration =3D otdata->timestamp - pele=
m->timestamp;
>
> Isn't it the opposite?
>
>         u64 duration =3D pelem->timestamp - otdata->timestamp;
>
>
> > +                             struct contention_key ckey =3D {
> > +                                     .stack_id =3D id,
> > +                                     .pid =3D 0,
> > +                                     .lock_addr_or_cgroup =3D 0,
> > +                             };
> > +                             struct contention_data *cdata =3D
> > +                                     bpf_map_lookup_elem(&owner_stat, =
&ckey);
> > +
> > +                             if (!cdata) {
> > +                                     struct contention_data first =3D =
{
> > +                                             .total_time =3D duration,
> > +                                             .max_time =3D duration,
> > +                                             .min_time =3D duration,
> > +                                             .count =3D 1,
> > +                                             .flags =3D pelem->flags,
> > +                                     };
> > +                                     bpf_map_update_elem(&owner_stat, =
&ckey, &first,
> > +                                                         BPF_NOEXIST);
> > +                             } else {
> > +                                     __sync_fetch_and_add(&cdata->tota=
l_time, duration);
> > +                                     __sync_fetch_and_add(&cdata->coun=
t, 1);
> > +
> > +                                     /* FIXME: need atomic operations =
*/
> > +                                     if (cdata->max_time < duration)
> > +                                             cdata->max_time =3D durat=
ion;
> > +                                     if (cdata->min_time > duration)
> > +                                             cdata->min_time =3D durat=
ion;
> > +                             }
>
> And as I said before, can we move this block out as a function?
>
> > +
> > +                             otdata->timestamp =3D pelem->timestamp;
> > +                             otdata->stack_id =3D id;
> > +                     }
> > +             }
> > +skip_owner_begin:
> >               pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
> >                                                 BPF_F_FAST_STACK_CMP | =
stack_skip);
> >               if (pelem->stack_id < 0)
> > @@ -473,6 +587,7 @@ int contention_end(u64 *ctx)
> >       struct tstamp_data *pelem;
> >       struct contention_key key =3D {};
> >       struct contention_data *data;
> > +     __u64 timestamp;
> >       __u64 duration;
> >       bool need_delete =3D false;
> >
> > @@ -500,12 +615,143 @@ int contention_end(u64 *ctx)
> >               need_delete =3D true;
> >       }
> >
> > -     duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> > +     timestamp =3D bpf_ktime_get_ns();
> > +     duration =3D timestamp - pelem->timestamp;
> >       if ((__s64)duration < 0) {
> >               __sync_fetch_and_add(&time_fail, 1);
> >               goto out;
> >       }
> >
> > +     if (needs_callstack && lock_owner) {
> > +             u64 owner_time;
> > +             struct contention_key ckey =3D {};
> > +             struct contention_data *cdata;
> > +             struct owner_tracing_data *otdata;
> > +
> > +             otdata =3D bpf_map_lookup_elem(&owner_data, &pelem->lock)=
;
> > +             if (!otdata)
> > +                     goto skip_owner_end;
> > +
> > +             /* Update `owner_stat` */
> > +             owner_time =3D timestamp - otdata->timestamp;
> > +             ckey.stack_id =3D otdata->stack_id;
> > +             cdata =3D bpf_map_lookup_elem(&owner_stat, &ckey);
> > +
> > +             if (!cdata) {
> > +                     struct contention_data first =3D {
> > +                             .total_time =3D owner_time,
> > +                             .max_time =3D owner_time,
> > +                             .min_time =3D owner_time,
> > +                             .count =3D 1,
> > +                             .flags =3D pelem->flags,
> > +                     };
> > +                     bpf_map_update_elem(&owner_stat, &ckey, &first, B=
PF_NOEXIST);
> > +             } else {
> > +                     __sync_fetch_and_add(&cdata->total_time, owner_ti=
me);
> > +                     __sync_fetch_and_add(&cdata->count, 1);
> > +
> > +                     /* FIXME: need atomic operations */
> > +                     if (cdata->max_time < owner_time)
> > +                             cdata->max_time =3D owner_time;
> > +                     if (cdata->min_time > owner_time)
> > +                             cdata->min_time =3D owner_time;
> > +             }
> > +
> > +             /* No contention is occurring, delete `lock` entry in `ow=
ner_data` */
> > +             if (otdata->count <=3D 1)
> > +                     bpf_map_delete_elem(&owner_data, &pelem->lock);
> > +             /*
> > +              * Contention is still ongoing, with a new owner (current=
 task). `owner_data`
> > +              * should be updated accordingly.
> > +              */
> > +             else {
> > +                     u32 i =3D 0;
> > +                     u64 *buf;
> > +
> > +                     __sync_fetch_and_add(&otdata->count, -1);
> > +
> > +                     buf =3D bpf_map_lookup_elem(&stack_buf, &i);
> > +                     if (!buf)
> > +                             goto skip_owner_end;
> > +                     for (i =3D 0; i < (u32)max_stack; i++)
> > +                             buf[i] =3D 0x0;
> > +
> > +                     /*
> > +                      * ctx[1] has the return code of the lock functio=
n.
>
> Then I think it's clearer to have a local variable named 'ret' or so.
>
>
> > +                      * If ctx[1] is not 0, the current task terminate=
s lock waiting without
> > +                      * acquiring it. Owner is not changed, but we sti=
ll need to update the owner
> > +                      * stack.
> > +                      */
> > +                     if (!ctx[1]) {
>
> This doesn't match to the comment.  It should be:
>
>                         if (ret < 0) {
>
>
> > +                             s32 id =3D 0;
> > +                             struct task_struct *task =3D NULL;
> > +
> > +                             if (bpf_task_from_pid)
>
> Same as the above.  No need to go down if you cannot get the task and
> stack.
>
>                                 if (bpf_task_from_pid =3D=3D NULL)
>                                         goto skip_owner;
>
>
> > +                                     task =3D bpf_task_from_pid(otdata=
->pid);
> > +
> > +                             if (task) {
> > +                                     bpf_get_task_stack(task, buf,
> > +                                                        max_stack * si=
zeof(unsigned long), 0);
> > +                                     bpf_task_release(task);
> > +                             }
> > +
> > +                             id =3D get_owner_stack_id(buf);
> > +
> > +                             /*
> > +                              * If owner stack is changed, update `own=
er_data` and `owner_stat`
> > +                              * accordingly.
> > +                              */
> > +                             if (id !=3D otdata->stack_id) {
> > +                                     u64 duration =3D otdata->timestam=
p - pelem->timestamp;
> > +                                     struct contention_key ckey =3D {
> > +                                             .stack_id =3D id,
> > +                                             .pid =3D 0,
> > +                                             .lock_addr_or_cgroup =3D =
0,
> > +                                     };
> > +                                     struct contention_data *cdata =3D
> > +                                             bpf_map_lookup_elem(&owne=
r_stat, &ckey);
> > +
> > +                                     if (!cdata) {
> > +                                             struct contention_data fi=
rst =3D {
> > +                                                     .total_time =3D d=
uration,
> > +                                                     .max_time =3D dur=
ation,
> > +                                                     .min_time =3D dur=
ation,
> > +                                                     .count =3D 1,
> > +                                                     .flags =3D pelem-=
>flags,
> > +                                             };
> > +                                             bpf_map_update_elem(&owne=
r_stat, &ckey, &first,
> > +                                                                 BPF_N=
OEXIST);
> > +                                     } else {
> > +                                             __sync_fetch_and_add(&cda=
ta->total_time, duration);
> > +                                             __sync_fetch_and_add(&cda=
ta->count, 1);
> > +
> > +                                             /* FIXME: need atomic ope=
rations */
> > +                                             if (cdata->max_time < dur=
ation)
> > +                                                     cdata->max_time =
=3D duration;
> > +                                             if (cdata->min_time > dur=
ation)
> > +                                                     cdata->min_time =
=3D duration;
> > +                                     }
> > +
> > +                                     otdata->timestamp =3D pelem->time=
stamp;
> > +                                     otdata->stack_id =3D id;
> > +                             }
> > +                     }
> > +                     /*
> > +                      * If ctx[1] is 0, then update tracinng data with=
 the current task, which is
> > +                      * the new owner.
> > +                      */
> > +                     else {
> > +                             otdata->pid =3D pid;
> > +                             otdata->timestamp =3D timestamp;
> > +
> > +                             bpf_get_task_stack(bpf_get_current_task_b=
tf(), buf,
> > +                                                max_stack * sizeof(uns=
igned long), 0);
>
> This would be meaningless since it's still in the contention path.
> Current callstack will be the same as the waiter callstack.  You'd
> better just invalidate callstack here and let the next waiter update
> it.

I wonder why this is meaningless. In this situation, the lock owner is
transferred to the current task, and there is at least one more
waiter, the contention is still ongoing. `otdata` is for tracing the
lock owner, so it should be correctly updated with the new owner,
which is the current task.
>
> Thanks,
> Namhyung
>
>
> > +                             otdata->stack_id =3D get_owner_stack_id(b=
uf);
> > +                     }
> > +             }
> > +     }
> > +skip_owner_end:
> > +
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> >               key.stack_id =3D pelem->stack_id;
> > --
> > 2.48.1.362.g079036d154-goog
> >

