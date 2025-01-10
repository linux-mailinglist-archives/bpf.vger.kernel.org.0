Return-Path: <bpf+bounces-48584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F7A09C2E
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DF57A3852
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC4215179;
	Fri, 10 Jan 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHjuzORg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8E206F09
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539637; cv=none; b=jy1YqxQxs8DUxzo9/+NG5IXj1hw5KMFFYWZdVnNA/3YGZenaOCCr2KMapjrik9MlKKFaCymLYaYyxxIqLWoxSGLFXXyPZbbo16TzK+w7d/K5R/uPShLPtwqZ/yPvYT1lqQkhdx4Nc/nLiyECgY9mYd0PnjFxNA+/vekJZ1seo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539637; c=relaxed/simple;
	bh=wIygmx8zAIDTvLXG/w2wENiBhC+xajY46C6DLTZlr7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/VXkxagSTX110xsJulHki4KMRiaxqzhgcnpOBL2RAW7UHH/HzAZtWczzqBsT1rBBqUPUcFiHD/0IOx4KXTKQbz2dzaVzXm/7+p43mo0D2V5Tm9lhIWKLsmnROz8uWp1uKe9YkordPt4Gy51MVrTGBlgnkjCBzNs44Ht5V3f/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHjuzORg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso26083695e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736539633; x=1737144433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w3M3FDqcBiRNcGIjU217Q8iIGiQxBn4AmPygsVUYso=;
        b=yHjuzORg47CZ8ToctwkU4w0QqTHLZBdge+lo/cAeC2OMZ2AH6d1fRM7xvCusSP/m/j
         bM9r+yyCj+RJIN5GmQM+9iXV98xQCCPMrB8mIZYnefNOkWvnoTIX9X0HwRkzvi3QRUOA
         rFQT5sjtG/TJkQcll3RaHAvmXL/dCbc3nLB7OW2ARie4HBTyvR2+QK13l3c9gsZ7Az/T
         OGtGdAGxNiApN18+41PeBa0/8NHFVwm68yeu3C7iOwfGdF7vGoi6lgW08RPjVRHC1r74
         E4LiMVaEcv/wuqRIqPq+/FSBRnXYxNr0p302Xvq8zegew+qcYa77sMQZCgbGDSwymooe
         BQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736539633; x=1737144433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w3M3FDqcBiRNcGIjU217Q8iIGiQxBn4AmPygsVUYso=;
        b=bdvaQIdfa8bZbNunO4t7o4eRrxPpI/NOkA5Jdxn9mYzMLqu3W7LnfDmKtg/dIz0gx9
         mpM+K45RB0E+B5fkBRBGT/J4tZSDgpMe3pMnJWHHYypt7A7SqsE5SEWkLp8yJfXZBPqC
         QZ6JUqVGBzvZC34sSTHfGE239Kxf+3nBSaocKR3Gv/1Z8qou9c7Bxw93+IBjgxIxFLol
         IP87o7kRR64MI1WWZmc8aGIkeTjWkEYuZmag9Z+A7r2ZQ/EEFlxQAAWFNeeaEYihGdWu
         RsLvxtcrazHqXBfZTJqfXrWf2N6l/3BIEDDxGU7c2pOEyzKsCaiH60KSbGrmPInnOOta
         R8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUqPzL21KI7ALg+G+l2BfIcGbHw4PHoVY9W7X/d2f7KBWGU+r4389DKFva8xgbwosoYAQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKSMdYTcq/iHDg1XEOfTHVhDo9VQyGX526fRg7AB7vnehAKPE
	kV+fdsdJ/rPKJ/AH8iPGgUOlX7mfShBf6ay5N+7z34kDvOr11JKuFXeF+y+/5RD58ZZr7TkZAEf
	zC9wagV0SP907ZBkzv1alEmoJ6K34j/dP3JFy
X-Gm-Gg: ASbGncvop3t3jHnWK5OvwC71zQJWOV6NHi3eQk3QITbrjCr5UgcgcnZi87aOfiBrdSS
	oHeDP56Jy0LtC35+8hfvb5L05T89vgljVmVK5
X-Google-Smtp-Source: AGHT+IFXsXs67kGFEBjB8Z5uBXQUDTqb+Qyyv9p526ClwJdY89UoJ2/9SR4r22xrevit3XGDTiLDZACVgU3KpJrnV+s=
X-Received: by 2002:a05:6000:1a8a:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-38a872fc363mr9932735f8f.7.1736539632507; Fri, 10 Jan 2025
 12:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com> <20250110051346.1507178-3-ctshao@google.com>
In-Reply-To: <20250110051346.1507178-3-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 10 Jan 2025 12:07:01 -0800
X-Gm-Features: AbW1kva__7ETBk2gIIKyku2gD_XVtK8f14RCkPzN3x3e7ZJJBwb3sKttLFL5iDw
Message-ID: <CAJpZYjUcvSD_11gZY5GUNf7zsCAszXc+5B1eHuuh-qVShT1bHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf lock: Retrieve owner callstack in bpf program
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:14=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> Tracing owner callstack in `contention_begin()` and `contention_end()`,
> and storing in `owner_lock_stat` bpf map.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 149 +++++++++++++++++-
>  1 file changed, 148 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 05da19fdab23..79b641d7beb2 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -7,6 +7,7 @@
>  #include <asm-generic/errno-base.h>
>
>  #include "lock_data.h"
> +#include <time.h>
>
>  /* for collect_lock_syms().  4096 was rejected by the verifier */
>  #define MAX_CPUS  1024
> @@ -178,6 +179,9 @@ int data_fail;
>  int task_map_full;
>  int data_map_full;
>
> +struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;
> +
>  static inline __u64 get_current_cgroup_id(void)
>  {
>         struct task_struct *task;
> @@ -407,6 +411,60 @@ int contention_begin(u64 *ctx)
>         pelem->flags =3D (__u32)ctx[1];
>
>         if (needs_callstack) {
> +               u32 i =3D 0;
> +               int owner_pid;
> +               unsigned long *entries;
> +               struct task_struct *task;
> +               cotd *data;
> +
> +               if (!lock_owner)
> +                       goto contention_begin_skip_owner_callstack;
> +
> +               task =3D get_lock_owner(pelem->lock, pelem->flags);
> +               if (!task)
> +                       goto contention_begin_skip_owner_callstack;
> +
> +               owner_pid =3D BPF_CORE_READ(task, pid);
> +
> +               entries =3D bpf_map_lookup_elem(&owner_stacks_entries, &i=
);
> +               if (!entries)
> +                       goto contention_begin_skip_owner_callstack;
> +               for (i =3D 0; i < max_stack; i++)
> +                       entries[i] =3D 0x0;
> +
> +               task =3D bpf_task_from_pid(owner_pid);
> +               if (task) {
> +                       bpf_get_task_stack(task, entries,
> +                                          max_stack * sizeof(unsigned lo=
ng),
> +                                          0);
> +                       bpf_task_release(task);
> +               }
> +
> +               data =3D bpf_map_lookup_elem(&contention_owner_tracing,
> +                                          &(pelem->lock));
> +
> +               // Contention just happens, or corner case `lock` is owne=
d by
> +               // process not `owner_pid`.
> +               if (!data || data->pid !=3D owner_pid) {
> +                       cotd first =3D {
> +                               .pid =3D owner_pid,
> +                               .timestamp =3D pelem->timestamp,
> +                               .count =3D 1,
> +                       };
> +                       bpf_map_update_elem(&contention_owner_tracing,
> +                                           &(pelem->lock), &first, BPF_A=
NY);
> +                       bpf_map_update_elem(&contention_owner_stacks,
> +                                           &(pelem->lock), entries, BPF_=
ANY);
> +               }
> +               // Contention is going on and new waiter joins.
> +               else {
> +                       __sync_fetch_and_add(&data->count, 1);
> +                       // TODO: Since for owner the callstack would chan=
ge at
> +                       // different time, We should check and report if =
the
> +                       // callstack is different with the recorded one i=
n
> +                       // `contention_owner_stacks`.
> +               }
> +contention_begin_skip_owner_callstack:
>                 pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
>                                                   BPF_F_FAST_STACK_CMP | =
stack_skip);
>                 if (pelem->stack_id < 0)
> @@ -443,6 +501,7 @@ int contention_end(u64 *ctx)
>         struct tstamp_data *pelem;
>         struct contention_key key =3D {};
>         struct contention_data *data;
> +       __u64 timestamp;
>         __u64 duration;
>         bool need_delete =3D false;
>
> @@ -469,12 +528,100 @@ int contention_end(u64 *ctx)
>                         return 0;
>                 need_delete =3D true;
>         }
> -       duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> +       timestamp =3D bpf_ktime_get_ns();
> +       duration =3D timestamp - pelem->timestamp;
>         if ((__s64)duration < 0) {
>                 __sync_fetch_and_add(&time_fail, 1);
>                 goto out;
>         }
>
> +       if (needs_callstack && lock_owner) {
> +               u64 owner_contention_time;
> +               unsigned long *owner_stack;
> +               struct contention_data *cdata;
> +               cotd *otdata;
> +
> +               otdata =3D bpf_map_lookup_elem(&contention_owner_tracing,
> +                                            &(pelem->lock));
> +               owner_stack =3D bpf_map_lookup_elem(&contention_owner_sta=
cks,
> +                                                 &(pelem->lock));
> +               if (!otdata || !owner_stack)
> +                       goto contention_end_skip_owner_callstack;
> +
> +               owner_contention_time =3D timestamp - otdata->timestamp;
> +
> +               // Update `owner_lock_stat` if `owner_stack` is
> +               // available.
> +               if (owner_stack[0] !=3D 0x0) {
> +                       cdata =3D bpf_map_lookup_elem(&owner_lock_stat,
> +                                                   owner_stack);
> +                       if (!cdata) {
> +                               struct contention_data first =3D {
> +                                       .total_time =3D owner_contention_=
time,
> +                                       .max_time =3D owner_contention_ti=
me,
> +                                       .min_time =3D owner_contention_ti=
me,
> +                                       .count =3D 1,
> +                                       .flags =3D pelem->flags,
> +                               };
> +                               bpf_map_update_elem(&owner_lock_stat,
> +                                                   owner_stack, &first,
> +                                                   BPF_ANY);
> +                       } else {
> +                               __sync_fetch_and_add(&cdata->total_time,
> +                                                    owner_contention_tim=
e);
> +                               __sync_fetch_and_add(&cdata->count, 1);
> +
> +                               /* FIXME: need atomic operations */
> +                               if (cdata->max_time < owner_contention_ti=
me)
> +                                       cdata->max_time =3D owner_content=
ion_time;
> +                               if (cdata->min_time > owner_contention_ti=
me)
> +                                       cdata->min_time =3D owner_content=
ion_time;
> +                       }
> +               }
> +
> +               // `pid` in `otdata` is not lock owner anymore, delete
> +               // this entry.
> +               bpf_map_delete_elem(&contention_owner_stacks, &(otdata->p=
id));

I just realized the above three lines are unnecessary and should be
deleted, please ignore them and I will fix them in my next patch.

> +
> +               //  No contention is going on, delete `lock` in
> +               //  `contention_owner_tracing` and
> +               //  `contention_owner_stacks`
> +               if (otdata->count <=3D 1) {
> +                       bpf_map_delete_elem(&contention_owner_tracing,
> +                                           &(pelem->lock));
> +                       bpf_map_delete_elem(&contention_owner_stacks,
> +                                           &(pelem->lock));
> +               }
> +               // Contention is still going on, with a new owner
> +               // (current task). `otdata` should be updated accordingly=
.
> +               // If ctx[1] is not 0, the current task terminate lock wa=
iting
> +               // without acquiring it.
> +               else if (ctx[1] =3D=3D 0) {
> +                       unsigned long *entries;
> +                       u32 i =3D 0;
> +
> +                       otdata->pid =3D pid;
> +                       otdata->timestamp =3D timestamp;
> +                       (otdata->count)--;
> +                       bpf_map_update_elem(&contention_owner_tracing,
> +                                           &(pelem->lock), otdata, BPF_A=
NY);
> +
> +                       entries =3D
> +                               bpf_map_lookup_elem(&owner_stacks_entries=
, &i);
> +                       if (!entries)
> +                               goto contention_end_skip_owner_callstack;
> +                       for (i =3D 0; i < (u32)max_stack; i++)
> +                               entries[i] =3D 0x0;
> +
> +                       bpf_get_task_stack(bpf_get_current_task_btf(), en=
tries,
> +                                          max_stack * sizeof(unsigned lo=
ng),
> +                                          0);
> +                       bpf_map_update_elem(&contention_owner_stacks,
> +                                           &(pelem->lock), entries, BPF_=
ANY);
> +               }

The logic above is a bit flawed. It should be:
                // Contention is still going on, with a new owner
                // (current task). `otdata` should be updated accordingly.
                else {
                        (otdata->count)--;

                        // If ctx[1] is not 0, the current task
terminates lock waiting
                        // without acquiring it. Owner is not changed.
                        if (ctx[1] =3D=3D 0) {
                                u32 i =3D 0;
                                otdata->pid =3D pid;
                                otdata->timestamp =3D timestamp;

                                entries =3D

bpf_map_lookup_elem(&owner_stacks_entries, &i);
                                if (!entries) {

bpf_map_update_elem(&contention_owner_tracing,

       &(pelem->lock), otdata, BPF_ANY);
                                        goto
contention_end_skip_owner_callstack;
                                }
                                for (i =3D 0; i < (u32)max_stack; i++)
                                        entries[i] =3D 0x0;


bpf_get_task_stack(bpf_get_current_task_btf(), entries,
                                                   max_stack *
sizeof(unsigned long),
                                                   0);
                                bpf_map_update_elem(&contention_owner_stack=
s,
                                                    &(pelem->lock),
entries, BPF_ANY);
                        }

                        bpf_map_update_elem(&contention_owner_tracing,
                                            &(pelem->lock), otdata, BPF_ANY=
);
                }
I will update this in my next patch.

> +       }
> +contention_end_skip_owner_callstack:
> +
>         switch (aggr_mode) {
>         case LOCK_AGGR_CALLER:
>                 key.stack_id =3D pelem->stack_id;
> --
> 2.47.1.688.g23fc6f90ad-goog
>

