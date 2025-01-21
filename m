Return-Path: <bpf+bounces-49415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF6A187C6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FAD163610
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9C1F8AF3;
	Tue, 21 Jan 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+B5Pyii"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F11F7064
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498963; cv=none; b=l3dty+gQz46VqXkT5ZrmthxoAFnl0DxoJHC/WUAfgFaHTzKqkDMe+6uoqjpF2CJDIJ4e13Mqa4PB+eUY5TzeHlaOwJpph8FB9gFoUag05e42PkmgBfcfJNTkREmqFjmJHWpidMXf691nt4CCSRkE8qtfU4y1wWsQZqBZglxZpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498963; c=relaxed/simple;
	bh=06Hh2+UAEpneh6HfJH3Ll28Wf+x1/JghZ6f5pl9BOek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0CEVpREla0T/f4iZyzK2B0s+XcglZ9c/P3el5pC7YBraTi26EraHHZ9wM0LCOftKfusLW5ZYb61iAxhsK6mshSgZd7dOG6f4yq55ratD6gNka6C7w/5Eywbnv6+KH1UihbJRQctTFP7glrCy5+4IHGS/w2rlopA75wwpLfusEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+B5Pyii; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so9904010a12.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737498958; x=1738103758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWvQ57s5WLieNo1sliCfgXAQCkGzy3GzVR5mbefurH0=;
        b=M+B5Pyiilwayg0tUh/v4jkOfWP3OMZKU8emv+ETIXNI4mXaaXtnbdZkjxvHyA0EbXC
         pLHyhw9esBn2vt1GfWAuqwd1u4+3HI1WlM6q4Y/cSFPsGVvvkC06STsP6BCOxeJqrJPY
         p+lU44j+30ZSM4bKzgubseEbi5/hrUqMYf09yPmSEs+s1KprNTDDH+XZaVYNOeWJDpfW
         AuYpWMSLNbwfy42/Pm87pJW1jCNiUaeHJ9fr7vy6zq6BbxeoOq8hK02Q0wNglKEhPXvO
         4JZyu4hlX/KfJKgY7eZt7BvncOhb5PSxQsj4qWvfaZmW9shmKyahAkTODoladSkTn07v
         vLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737498958; x=1738103758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWvQ57s5WLieNo1sliCfgXAQCkGzy3GzVR5mbefurH0=;
        b=JajWyZFo7CZ7XmvL8KJ+nbgMGBX/q/Fha0Z5IAlFE6d5enDSFwbHGUU/JxRg8ZhpEC
         cnWisynsE9Ovl7dfgrh5dk9fmjIBg03z3FXgM1LxbzNp415/EGVfwR96P2JBv9ARifDY
         1hfl0kej6S9hu+QL80wLP7Zo9cXoGmHZ11y3kO1c+SjhRWGhpFOFbCpZDHvs/XMInvLw
         UJtcVPSbi5e/jt3z7e91nYOaPyXxcqBDPRkaicl1khhVnpX2pU9k5TNRW/P70qWn4sq8
         8g4vvSMe/FPlR/ETNSS4g+4E5kF6QfxGizE9Mpx/gzED+5m77rplzhAvcMPULCFji2+A
         fb3A==
X-Forwarded-Encrypted: i=1; AJvYcCX3FenQgk86UuQWq3a9egitB/xaFVUxEWboFNDGo1XyFmaTdh9ysOb61hTMfad0R74yqH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTgak+h296byJ1RdpnQLkTBV4KmZBNiqjcTMY+Hrg8AmNxZQj
	pQOML7qqxbzBNMgxJ+K/vcDv8ywgU/jLSk+XOeBrpg79GXUdmA1FLtCGrZHC70AL+W9sPaX6rCF
	4XXdbZ38rmkh1J7kHofU9h/5xwTPOFea0+dG3
X-Gm-Gg: ASbGncslWQMxTsHOTyoDdYj5HkDzk6OSs9NSA18b+2Nvlc6LG87LyRRrGspAGcz5vi8
	5wjuOXQF1a1Dibwep6rcR5hDMqnik0j0Wsi8fPzNUIUgIp5DYqLWM+ez9rOK2FTOgQQQQhpXIG4
	xei3PQyA==
X-Google-Smtp-Source: AGHT+IGt0OMy7B4oot6v84WB08lfnc/QRZCDU+KLiGjyKu7W62PqcoeuptE013G66TBd117SgsxqzMkgh51s4sdqzTU=
X-Received: by 2002:a05:6402:4406:b0:5d9:84ee:ff31 with SMTP id
 4fb4d7f45d1cf-5db7d2dc6d2mr41461629a12.3.1737498958162; Tue, 21 Jan 2025
 14:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com> <20250113052220.2105645-3-ctshao@google.com>
 <Z4XbdVKyXgjUqZcP@google.com>
In-Reply-To: <Z4XbdVKyXgjUqZcP@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 21 Jan 2025 14:35:46 -0800
X-Gm-Features: AbW1kvZ6SGeDznqhE4nXMvbzFFvd_WAlQ0gHHFXPNtYPjNsTqI5NxSw61i6S2z4
Message-ID: <CAJpZYjWvuzrwViWqi3Oet2agXkJP6T=82HZ_YeKNYV2KKioWdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf lock: Retrieve owner callstack in bpf program
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Jan 12, 2025 at 09:20:15PM -0800, Chun-Tse Shao wrote:
> > Tracing owner callstack in `contention_begin()` and `contention_end()`,
> > and storing in `owner_lock_stat` bpf map.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 152 +++++++++++++++++-
> >  1 file changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 05da19fdab23..3f47fbfa237c 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -7,6 +7,7 @@
> >  #include <asm-generic/errno-base.h>
> >
> >  #include "lock_data.h"
> > +#include <time.h>
> >
> >  /* for collect_lock_syms().  4096 was rejected by the verifier */
> >  #define MAX_CPUS  1024
> > @@ -178,6 +179,9 @@ int data_fail;
> >  int task_map_full;
> >  int data_map_full;
> >
> > +struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> > +void bpf_task_release(struct task_struct *p) __ksym;
>
> To support old (ancient?) kernels, you can declare them as __weak and
> check if one of them is defined and ignore owner stacks on them.  Also
> you can check them in user space and turn off the option before loading.
>
> > +
> >  static inline __u64 get_current_cgroup_id(void)
> >  {
> >       struct task_struct *task;
> > @@ -407,6 +411,60 @@ int contention_begin(u64 *ctx)
> >       pelem->flags =3D (__u32)ctx[1];
> >
> >       if (needs_callstack) {
> > +             u32 i =3D 0;
> > +             int owner_pid;
> > +             unsigned long *entries;
> > +             struct task_struct *task;
> > +             cotd *data;
> > +
> > +             if (!lock_owner)
> > +                     goto contention_begin_skip_owner_callstack;
>
> Can be it 'skip_owner'?
>
> > +
> > +             task =3D get_lock_owner(pelem->lock, pelem->flags);
> > +             if (!task)
> > +                     goto contention_begin_skip_owner_callstack;
> > +
> > +             owner_pid =3D BPF_CORE_READ(task, pid);
> > +
> > +             entries =3D bpf_map_lookup_elem(&owner_stacks_entries, &i=
);
> > +             if (!entries)
> > +                     goto contention_begin_skip_owner_callstack;
> > +             for (i =3D 0; i < max_stack; i++)
> > +                     entries[i] =3D 0x0;
> > +
> > +             task =3D bpf_task_from_pid(owner_pid);
> > +             if (task) {
> > +                     bpf_get_task_stack(task, entries,
> > +                                        max_stack * sizeof(unsigned lo=
ng),
> > +                                        0);
> > +                     bpf_task_release(task);
> > +             }
> > +
> > +             data =3D bpf_map_lookup_elem(&contention_owner_tracing,
> > +                                        &(pelem->lock));
>
> No need for parenthesis.
>
> > +
> > +             // Contention just happens, or corner case `lock` is owne=
d by
> > +             // process not `owner_pid`.
> > +             if (!data || data->pid !=3D owner_pid) {
> > +                     cotd first =3D {
> > +                             .pid =3D owner_pid,
> > +                             .timestamp =3D pelem->timestamp,
> > +                             .count =3D 1,
> > +                     };
> > +                     bpf_map_update_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock), &first, BPF_A=
NY);
> > +                     bpf_map_update_elem(&contention_owner_stacks,
> > +                                         &(pelem->lock), entries, BPF_=
ANY);
>
> Hmm.. it just discard the old owner data if it comes from a new owner?
> Why not save the data into the result for the old lock/callstack?

There are two conditions which enter this if statement:
1. (!data) contention just started, `&pelem->lock` entry in
`contetion_owner_tracing` is empty.
2. (data->pid !=3D owner_pid) Some internal errors so `data->pid` is
misaligned with `owner_pid`. In this case the timestamp would be
incorrect so I prefer to drop it.
WDYT?

>
>
> > +             }
> > +             // Contention is going on and new waiter joins.
> > +             else {
> > +                     __sync_fetch_and_add(&data->count, 1);
> > +                     // TODO: Since for owner the callstack would chan=
ge at
> > +                     // different time, We should check and report if =
the
> > +                     // callstack is different with the recorded one i=
n
> > +                     // `contention_owner_stacks`.
> > +             }
> > +contention_begin_skip_owner_callstack:
> >               pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
> >                                                 BPF_F_FAST_STACK_CMP | =
stack_skip);
> >               if (pelem->stack_id < 0)
> > @@ -443,6 +501,7 @@ int contention_end(u64 *ctx)
> >       struct tstamp_data *pelem;
> >       struct contention_key key =3D {};
> >       struct contention_data *data;
> > +     __u64 timestamp;
> >       __u64 duration;
> >       bool need_delete =3D false;
> >
> > @@ -469,12 +528,103 @@ int contention_end(u64 *ctx)
> >                       return 0;
> >               need_delete =3D true;
> >       }
> > -     duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> > +     timestamp =3D bpf_ktime_get_ns();
> > +     duration =3D timestamp - pelem->timestamp;
> >       if ((__s64)duration < 0) {
> >               __sync_fetch_and_add(&time_fail, 1);
> >               goto out;
> >       }
> >
> > +     if (needs_callstack && lock_owner) {
> > +             u64 owner_contention_time;
> > +             unsigned long *owner_stack;
> > +             struct contention_data *cdata;
> > +             cotd *otdata;
> > +
> > +             otdata =3D bpf_map_lookup_elem(&contention_owner_tracing,
> > +                                          &(pelem->lock));
> > +             owner_stack =3D bpf_map_lookup_elem(&contention_owner_sta=
cks,
> > +                                               &(pelem->lock));
> > +             if (!otdata || !owner_stack)
> > +                     goto contention_end_skip_owner_callstack;
> > +
> > +             owner_contention_time =3D timestamp - otdata->timestamp;
> > +
> > +             // Update `owner_lock_stat` if `owner_stack` is
> > +             // available.
> > +             if (owner_stack[0] !=3D 0x0) {
> > +                     cdata =3D bpf_map_lookup_elem(&owner_lock_stat,
> > +                                                 owner_stack);
> > +                     if (!cdata) {
> > +                             struct contention_data first =3D {
> > +                                     .total_time =3D owner_contention_=
time,
> > +                                     .max_time =3D owner_contention_ti=
me,
> > +                                     .min_time =3D owner_contention_ti=
me,
> > +                                     .count =3D 1,
> > +                                     .flags =3D pelem->flags,
> > +                             };
> > +                             bpf_map_update_elem(&owner_lock_stat,
> > +                                                 owner_stack, &first,
> > +                                                 BPF_ANY);
> > +                     } else {
> > +                             __sync_fetch_and_add(&cdata->total_time,
> > +                                                  owner_contention_tim=
e);
> > +                             __sync_fetch_and_add(&cdata->count, 1);
> > +
> > +                             /* FIXME: need atomic operations */
> > +                             if (cdata->max_time < owner_contention_ti=
me)
> > +                                     cdata->max_time =3D owner_content=
ion_time;
> > +                             if (cdata->min_time > owner_contention_ti=
me)
> > +                                     cdata->min_time =3D owner_content=
ion_time;
> > +                     }
> > +             }
> > +
> > +             //  No contention is going on, delete `lock` in
> > +             //  `contention_owner_tracing` and
> > +             //  `contention_owner_stacks`
> > +             if (otdata->count <=3D 1) {
> > +                     bpf_map_delete_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock));
> > +                     bpf_map_delete_elem(&contention_owner_stacks,
> > +                                         &(pelem->lock));
> > +             }
> > +             // Contention is still going on, with a new owner
> > +             // (current task). `otdata` should be updated accordingly=
.
> > +             else {
> > +                     (otdata->count)--;
>
> No need for parenthesis, and it needs to be atomic dec.
>
> > +
> > +                     // If ctx[1] is not 0, the current task terminate=
s lock
> > +                     // waiting without acquiring it. Owner is not cha=
nged.
>
> Please add a comment that ctx[1] has the return code of the lock
> function.  Maybe it's better to use a local variable.
>
> Also I think you need to say about the normal case too.  Returing 0
> means the waiter now gets the lock and becomes a new owner.  So it needs
> to update the owner information.
>
>
> > +                     if (ctx[1] =3D=3D 0) {
> > +                             u32 i =3D 0;
> > +                             unsigned long *entries =3D bpf_map_lookup=
_elem(
> > +                                     &owner_stacks_entries, &i);
> > +                             if (entries) {
> > +                                     for (i =3D 0; i < (u32)max_stack;=
 i++)
> > +                                             entries[i] =3D 0x0;
> > +
> > +                                     bpf_get_task_stack(
> > +                                             bpf_get_current_task_btf(=
),
>
> Same as bpf_get_stack(), right?
>
> > +                                             entries,
> > +                                             max_stack *
> > +                                                     sizeof(unsigned l=
ong),
> > +                                             0);
> > +                                     bpf_map_update_elem(
> > +                                             &contention_owner_stacks,
> > +                                             &(pelem->lock), entries,
> > +                                             BPF_ANY);
>
> Please factor out the code if it indents too much.  Or you can use goto
> or something to reduce the indentation level.

I will reindent it with `ColumnLimit=3D100`. I was using 80 since it was
predefined in `.clang-format`, looks outdated but no one updated it..

>
>   if (ret !=3D 0)
>         goto skip_update;
>
>   ...
>
>   if (entries =3D=3D NULL)
>         goto skip_stack;
>
>   ...
>
> Thanks,
> Namhyung
>
> > +                             }
> > +
> > +                             otdata->pid =3D pid;
> > +                             otdata->timestamp =3D timestamp;
> > +                     }
> > +
> > +                     bpf_map_update_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock), otdata, BPF_A=
NY);
> > +             }
> > +     }
> > +contention_end_skip_owner_callstack:
> > +
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> >               key.stack_id =3D pelem->stack_id;
> > --
> > 2.47.1.688.g23fc6f90ad-goog
> >

