Return-Path: <bpf+bounces-52406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70673A42B38
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33103B88C1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD7265630;
	Mon, 24 Feb 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1JBiy/H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C4144304
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421547; cv=none; b=lREHEkxDU1XrgUaOze624vZ4CM8u3V8HiZW0lJBGtgOFTjFDZBICDVB1Pu94+WF4QhXGIMpxepzuCscSmGVv1pEJV67kKGa6Yf+9nDavTSUpig9h26HMMCC/ZajhSczfgDuw/6caW2sUHjbHuseWlVoVsbWcbg0Ra9nvN/VJroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421547; c=relaxed/simple;
	bh=3+C2XFdM+MiYotwwfZEDFJk1wvC+PN5AwApJ/krQf7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1VQT5aY9CVUy/wAnyKjeGpx0R8eMz4e8xH8sT/fpsVb7uuj/o5Er1r3Qo5JIiMTki+pJ1oC3d3D8S58Tagjx7UmpATdyVBq8qsQylfVGJ8NIEoo2FgWQyI2FY7Ze4q38HpW1oYbDuJzHx4mw06ztRoQmI1K+rh88hqKid/RC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1JBiy/H; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so8354587a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740421543; x=1741026343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ13OakhDUivH0BDgUnrZutLZIWGOFNbCv3bleOX4H4=;
        b=I1JBiy/HwmcdZayxK19EtnljJ9UjYjNtIPn9y4diMi92zMhZSu44hOEKCjxxR8cGmD
         QB3nos4bjX8kwdXviqj8fE9G2X2x+BhwINKKyXcpRGkMGGNiM2bt+kw/XXkk2iiWwjVy
         nuLuwu6bbUg46SwESN81F8RCKPVWW20KD+kM7IXUMT+0vyTzJcVlNkQ337lOBtQ+dMv/
         dwjQqIJ3q6cByVcsAs7PWnjh53Ov2We95mGawKAD4IbjJ4P5sHoshm4a4ePDahNve1Wb
         iRUuykxhMyUBMzADJoUrWnPhXgFZfMH11bM22L9faW1sW+nqocvsNeMI4+UONisSPMno
         ZCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421543; x=1741026343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ13OakhDUivH0BDgUnrZutLZIWGOFNbCv3bleOX4H4=;
        b=lnqOWVSBuhhEtIsNnLSnl/n6lWCjFSi+UjMIyUIjppNn1bLwkxXp09ml7UVkP3QYBc
         HzD8sWr1JSEn7zPGAF61YrSsd5mnNKIfetbNDPd3DwB39tdQBq6iGu2sUIYXytfMzI0B
         WveG1OvZFpIEEWpaooc4s2DOR+QPVIc0Ze1Mx8psxqxdIp5itIgjV7QO6srtRfTq++oY
         YugC8g0OAYOIgCCSuDMsg9LGF+LjN2Rs5Qgjz9+iGxZxuLQlWhezlki+OlZQijPF3JMx
         P4pQMshOtsreaot22QXakIWtRsXuAVw8vAMIUpoaOtmxLhAV5Bq5rz/Tw/ibogsazzoo
         Ny3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRv7Mv1fkZkysY7ZGoNhq4Vb7l3fTRGHd01LKsBn03jCT7xEFhxGqgn5xzj+yJmFROBo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMa1MMJbnGwqcrJQOINn0FsnyVk8DwkGXBatB7wxTAJwX8tnx
	tpG/EaNDyJjFkCWkfCWy+Xc/a99F2GHzOXQpKfpnW1+t6Y1zNYa6ZpbPz2Y+dtbf+xbdOSvb3pM
	b+E5OmrcWGURZmuMDwui0NOUHUsSID2tFFUXk
X-Gm-Gg: ASbGncvt4TmqZ03FPKKoCFJr2SO7dCZJBwoLAXIxrQGW/Qbb1VmUeKSEHplT3NthWs6
	TO4VxzIrkzaUtTmzS/JD9VZOz2/LG52ehk07XfZfWx8LGU+i/r/3HJC5lxw2y5OvqgD7yT13XnR
	R3aQFDEF5ucXmK7+476Vaa8+ZUrBKz2rH/KfDTtjs=
X-Google-Smtp-Source: AGHT+IEo6+baBz3VcUCA7Q2SFKGdLj5HZA/OctDZcIALo2lnD7bq8eH0kgZ+waVoSvj87h7QqRl3hxkZJEe1GU67+tk=
X-Received: by 2002:a17:907:6ea1:b0:abe:c11e:29d8 with SMTP id
 a640c23a62f3a-abec11e2a27mr302759266b.33.1740421542774; Mon, 24 Feb 2025
 10:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219214400.3317548-1-ctshao@google.com> <20250219214400.3317548-3-ctshao@google.com>
 <Z7ghWIq8wXCJ2Y8T@google.com>
In-Reply-To: <Z7ghWIq8wXCJ2Y8T@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 24 Feb 2025 10:25:30 -0800
X-Gm-Features: AWEUYZkaqFbzyjKWs6DYYjfrLZ0yUlTWGqSBzwl0SUsjfGyEQSozOobzwp4K6dY
Message-ID: <CAJpZYjUj1un3pnxQWp1r3fS235WnCHZU94agiV3FCs5Ph8uJWw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] perf lock: Retrieve owner callstack in bpf program
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review, Namhyung.

On Thu, Feb 20, 2025 at 10:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Feb 19, 2025 at 01:40:01PM -0800, Chun-Tse Shao wrote:
> > This implements per-callstack aggregation of lock owners in addition to
> > per-thread.  The owner callstack is captured using `bpf_get_task_stack(=
)`
> > at `contention_begin()` and it also adds a custom stackid function for =
the
> > owner stacks to be compared easily.
> >
> > The owner info is kept in a hash map using lock addr as a key to handle
> > multiple waiters for the same lock.  At `contention_end()`, it updates =
the
> > owner lock stat based on the info that was saved at `contention_begin()=
`.
> > If there are more waiters, it'd update the owner pid to itself as
> > `contention_end()` means it gets the lock now.  But it also needs to ch=
eck
> > the return value of the lock function in case task was killed by a sign=
al
> > or something.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 218 +++++++++++++++++-
> >  1 file changed, 209 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 23fe9cc980ae..e8b113d5802a 100644
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
> > @@ -420,6 +423,61 @@ static inline struct tstamp_data *get_tstamp_elem(=
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
> > +static inline void update_contention_data(struct contention_data *data=
, u64 duration, u32 count)
> > +{
> > +     __sync_fetch_and_add(&data->total_time, duration);
> > +     __sync_fetch_and_add(&data->count, count);
> > +
> > +     /* FIXME: need atomic operations */
> > +     if (data->max_time < duration)
> > +             data->max_time =3D duration;
> > +     if (data->min_time > duration)
> > +             data->min_time =3D duration;
> > +}
> > +
> > +static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
> > +{
> > +     struct contention_key key =3D {
> > +             .stack_id =3D id,
> > +             .pid =3D 0,
> > +             .lock_addr_or_cgroup =3D 0,
> > +     };
> > +     struct contention_data *data =3D bpf_map_lookup_elem(&owner_stat,=
 &key);
> > +
> > +     if (!data) {
> > +             struct contention_data first =3D {
> > +                     .total_time =3D duration,
> > +                     .max_time =3D duration,
> > +                     .min_time =3D duration,
> > +                     .count =3D 1,
> > +                     .flags =3D flags,
> > +             };
> > +             bpf_map_update_elem(&owner_stat, &key, &first, BPF_NOEXIS=
T);
> > +     } else {
> > +             update_contention_data(data, duration, 1);
> > +     }
> > +}
> > +
> >  SEC("tp_btf/contention_begin")
> >  int contention_begin(u64 *ctx)
> >  {
> > @@ -437,6 +495,72 @@ int contention_begin(u64 *ctx)
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
> > +                     goto skip_owner;
> > +
> > +             task =3D get_lock_owner(pelem->lock, pelem->flags);
> > +             if (!task)
> > +                     goto skip_owner;
> > +
> > +             owner_pid =3D BPF_CORE_READ(task, pid);
> > +
> > +             buf =3D bpf_map_lookup_elem(&stack_buf, &i);
> > +             if (!buf)
> > +                     goto skip_owner;
> > +             for (i =3D 0; i < max_stack; i++)
> > +                     buf[i] =3D 0x0;
> > +
> > +             if (!bpf_task_from_pid)
> > +                     goto skip_owner;
> > +
> > +             task =3D bpf_task_from_pid(owner_pid);
> > +             if (!task)
> > +                     goto skip_owner;
> > +
> > +             bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned=
 long), 0);
> > +             bpf_task_release(task);
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
> > +                             update_owner_stat(id, pelem->timestamp - =
otdata->timestamp,
> > +                                               pelem->flags);
> > +
> > +                             otdata->timestamp =3D pelem->timestamp;
> > +                             otdata->stack_id =3D id;
> > +                     }
> > +             }
> > +skip_owner:
> >               pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
> >                                                 BPF_F_FAST_STACK_CMP | =
stack_skip);
> >               if (pelem->stack_id < 0)
> > @@ -473,6 +597,7 @@ int contention_end(u64 *ctx)
> >       struct tstamp_data *pelem;
> >       struct contention_key key =3D {};
> >       struct contention_data *data;
> > +     __u64 timestamp;
> >       __u64 duration;
> >       bool need_delete =3D false;
> >
> > @@ -500,12 +625,94 @@ int contention_end(u64 *ctx)
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
> > +             struct owner_tracing_data *otdata =3D bpf_map_lookup_elem=
(&owner_data, &pelem->lock);
> > +
> > +             if (!otdata)
> > +                     goto skip_owner;
> > +
> > +             /* Update `owner_stat` */
> > +             update_owner_stat(otdata->stack_id, timestamp - otdata->t=
imestamp, pelem->flags);
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
> > +                     s32 ret =3D (s32)ctx[1];
> > +                     u64 *buf;
> > +
> > +                     __sync_fetch_and_add(&otdata->count, -1);
> > +
> > +                     buf =3D bpf_map_lookup_elem(&stack_buf, &i);
> > +                     if (!buf)
> > +                             goto skip_owner;
> > +                     for (i =3D 0; i < (u32)max_stack; i++)
> > +                             buf[i] =3D 0x0;
> > +
> > +                     /*
> > +                      * `ret` has the return code of the lock function=
.
> > +                      * If `ret` is negative, the current task termina=
tes lock waiting without
> > +                      * acquiring it. Owner is not changed, but we sti=
ll need to update the owner
> > +                      * stack.
> > +                      */
> > +                     if (ret < 0) {
> > +                             s32 id =3D 0;
> > +                             struct task_struct *task;
> > +
> > +                             if (!bpf_task_from_pid)
> > +                                     goto skip_owner;
> > +
> > +                             task =3D bpf_task_from_pid(otdata->pid);
> > +                             if (!task)
> > +                                     goto skip_owner;
> > +
> > +                             bpf_get_task_stack(task, buf,
> > +                                                max_stack * sizeof(uns=
igned long), 0);
> > +                             bpf_task_release(task);
> > +
> > +                             id =3D get_owner_stack_id(buf);
> > +
> > +                             /*
> > +                              * If owner stack is changed, update `own=
er_data` and `owner_stat`
> > +                              * accordingly.
> > +                              */
> > +                             if (id !=3D otdata->stack_id) {
> > +                                     update_owner_stat(id, pelem->time=
stamp - otdata->timestamp,
>
> Shouldn't it be 'timestamp' instead of 'pelem->timestamp'?

I just realized that `update_owner_stat` is unnecessary. The previous
contention duration, `timestamp - otdata->timestamp`, belongs to
`otdata->stack_id` and is already recorded in the code above. Here we
are retrieving the current stack and updating `otdata->stack_id` for
future tracing, but not the previous contention duration. I will
submit a new patchset with this change.

>
>
> > +                                                       pelem->flags);
> > +
> > +                                     otdata->timestamp =3D pelem->time=
stamp;
>
> Ditto.
>
> Thanks,
> Namhyung
>
>
> > +                                     otdata->stack_id =3D id;
> > +                             }
> > +                     }
> > +                     /*
> > +                      * Otherwise, update tracing data with the curren=
t task, which is the new
> > +                      * owner.
> > +                      */
> > +                     else {
> > +                             otdata->pid =3D pid;
> > +                             otdata->timestamp =3D timestamp;
> > +                             /*
> > +                              * We don't want to retrieve callstack he=
re, since it is where the
> > +                              * current task acquires the lock and pro=
vides no additional
> > +                              * information. We simply assign -1 to in=
validate it.
> > +                              */
> > +                             otdata->stack_id =3D -1;
> > +                     }
> > +             }
> > +     }
> > +skip_owner:
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> >               key.stack_id =3D pelem->stack_id;
> > @@ -589,14 +796,7 @@ int contention_end(u64 *ctx)
> >       }
> >
> >  found:
> > -     __sync_fetch_and_add(&data->total_time, duration);
> > -     __sync_fetch_and_add(&data->count, 1);
> > -
> > -     /* FIXME: need atomic operations */
> > -     if (data->max_time < duration)
> > -             data->max_time =3D duration;
> > -     if (data->min_time > duration)
> > -             data->min_time =3D duration;
> > +     update_contention_data(data, duration, 1);
> >
> >  out:
> >       pelem->lock =3D 0;
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >

