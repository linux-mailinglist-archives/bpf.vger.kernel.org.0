Return-Path: <bpf+bounces-13205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9007D60C6
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DC6B211D5
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD18832;
	Wed, 25 Oct 2023 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wwcq/2z8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2479F1
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:15:41 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA3122
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:15:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c9305727so1104e87.1
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207337; x=1698812137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctRYFn6QwBh2oAHRlx6TERi+j/lB4Gy7TQ6m/2T2hwo=;
        b=Wwcq/2z8vxeuWOGH5j0gxQHgg1bLRTUueejt0qRdIFDmGhEhS8znl7npY+yI0Hbyhm
         eEYsiPeXjZr5bWZXsJlSbDuQHq2MdEiwLvDGHTsNoZZqcxumQbVr6NhL4E6mq3YkgK+O
         HhZyCdkoZ8V6MrPyfCCcLRifoDyjpM0sectp/Cb1i0M69MmRCq88i4H3E1l6cADZ8ZF9
         SPw39B7XJf2pG1qdaWJ5EpPh3jXhjEC/mYLSbQttEXwsv2chMbgHqfLM5AhVpHS3spxH
         l43a3BQUSaPGfH9ZzYp0upuu721VVo6vUw7LatjoF9idXIsZ/NHFAcrALj5EOjEwSw5k
         MYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207337; x=1698812137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctRYFn6QwBh2oAHRlx6TERi+j/lB4Gy7TQ6m/2T2hwo=;
        b=AZC9GtDVbQf3niZ6lpUwKXoUJTciqFuKGErHWBP026Uh9DHjF3v/5n39TJNkvR7XZQ
         op7lZjRBoueNumb3Xi5Oyh61sqdtvsZEiv7oAh6eVEKjpg4qnAOD0P8hFHcHQbUdFFqq
         FcDd/Hewc9eJ2CbKBacUVjIKT3BWLuwfxFIro+itmyv6Hq29uwJvu68yW7bHXsqrxipK
         FCCNMA0QSO2zD9Jt9EpZl9VrgL7xYgdUwnjo3ToLXlWcHwU5WYvVidai8Z8fTDYE9XPu
         XnsVx+DVEhR03uSpV+Eb6WGHSYAGsGOFeqj0Ya7SaWdVngLwh4vLR3d/ScGICiZ80zjR
         Nxng==
X-Gm-Message-State: AOJu0Yxn96FQdU8Ypjw5hoiMGn3zgfM/g14VQZ01sZuVsWZUMKKyfiEs
	uq5/IrKI/kL6HyUyfDAGeoA2rxnKI2Kd48NrT48PRA==
X-Google-Smtp-Source: AGHT+IGMYOemUqlb1EgH2Yg/uAcS/ruB92QJgiloJsOwkkh7ZFo7UuoNgfkQXZGS4ZlmHHLAfM1J4pjGwY1yOngmjGc=
X-Received: by 2002:a05:6512:1187:b0:505:6e12:9e70 with SMTP id
 g7-20020a056512118700b005056e129e70mr27744lfr.6.1698207337078; Tue, 24 Oct
 2023 21:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020204741.1869520-1-namhyung@kernel.org> <20231020204741.1869520-3-namhyung@kernel.org>
In-Reply-To: <20231020204741.1869520-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 21:15:25 -0700
Message-ID: <CAP-5=fUeBwzSXqBkSeC3Y9WeH3KsEYM+2o7U7eAVwSodrmt__g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf lock contention: Use per-cpu array map for spinlocks
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently lock contention timestamp is maintained in a hash map keyed by
> pid.  That means it needs to get and release a map element (which is
> proctected by spinlock!) on each contention begin and end pair.  This
> can impact on performance if there are a lot of contention (usually from
> spinlocks).
>
> It used to go with task local storage but it had an issue on memory
> allocation in some critical paths.  Although it's addressed in recent
> kernels IIUC, the tool should support old kernels too.  So it cannot
> simply switch to the task local storage at least for now.
>
> As spinlocks create lots of contention and they disabled preemption
> during the spinning, it can use per-cpu array to keep the timestamp to
> avoid overhead in hashmap update and delete.
>
> In contention_begin, it's easy to check the lock types since it can see
> the flags.  But contention_end cannot see it.  So let's try to per-cpu
> array first (unconditionally) if it has an active element (lock !=3D 0).
> Then it should be used and per-task tstamp map should not be used until
> the per-cpu array element is cleared which means nested spinlock
> contention (if any) was finished and it nows see (the outer) lock.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 89 +++++++++++++++----
>  1 file changed, 72 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 69d31fd77cd0..95cd8414f6ef 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -42,6 +42,14 @@ struct {
>         __uint(max_entries, MAX_ENTRIES);
>  } tstamp SEC(".maps");
>
> +/* maintain per-CPU timestamp at the beginning of contention */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct tstamp_data));
> +       __uint(max_entries, 1);
> +} tstamp_cpu SEC(".maps");
> +
>  /* actual lock contention statistics */
>  struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
> @@ -311,34 +319,57 @@ static inline __u32 check_lock_type(__u64 lock, __u=
32 flags)
>         return 0;
>  }
>
> -SEC("tp_btf/contention_begin")
> -int contention_begin(u64 *ctx)
> +static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
>  {
>         __u32 pid;
>         struct tstamp_data *pelem;
>
> -       if (!enabled || !can_record(ctx))
> -               return 0;
> +       /* Use per-cpu array map for spinlock and rwlock */
> +       if (flags =3D=3D (LCB_F_SPIN | LCB_F_READ) || flags =3D=3D LCB_F_=
SPIN ||
> +           flags =3D=3D (LCB_F_SPIN | LCB_F_WRITE)) {
> +               __u32 idx =3D 0;
> +
> +               pelem =3D bpf_map_lookup_elem(&tstamp_cpu, &idx);
> +               /* Do not update the element for nested locks */
> +               if (pelem && pelem->lock)
> +                       pelem =3D NULL;
> +               return pelem;
> +       }
>
>         pid =3D bpf_get_current_pid_tgid();
>         pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
> +       /* Do not update the element for nested locks */
>         if (pelem && pelem->lock)
> -               return 0;
> +               return NULL;
>
>         if (pelem =3D=3D NULL) {
>                 struct tstamp_data zero =3D {};
>
>                 if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST=
) < 0) {
>                         __sync_fetch_and_add(&task_fail, 1);
> -                       return 0;
> +                       return NULL;
>                 }
>
>                 pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
>                 if (pelem =3D=3D NULL) {
>                         __sync_fetch_and_add(&task_fail, 1);
> -                       return 0;
> +                       return NULL;
>                 }
>         }
> +       return pelem;
> +}
> +
> +SEC("tp_btf/contention_begin")
> +int contention_begin(u64 *ctx)
> +{
> +       struct tstamp_data *pelem;
> +
> +       if (!enabled || !can_record(ctx))
> +               return 0;
> +
> +       pelem =3D get_tstamp_elem(ctx[1]);
> +       if (pelem =3D=3D NULL)
> +               return 0;
>
>         pelem->timestamp =3D bpf_ktime_get_ns();
>         pelem->lock =3D (__u64)ctx[0];
> @@ -377,24 +408,42 @@ int contention_begin(u64 *ctx)
>  SEC("tp_btf/contention_end")
>  int contention_end(u64 *ctx)
>  {
> -       __u32 pid;
> +       __u32 pid =3D 0, idx =3D 0;
>         struct tstamp_data *pelem;
>         struct contention_key key =3D {};
>         struct contention_data *data;
>         __u64 duration;
> +       bool need_delete =3D false;
>
>         if (!enabled)
>                 return 0;
>
> -       pid =3D bpf_get_current_pid_tgid();
> -       pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
> -       if (!pelem || pelem->lock !=3D ctx[0])
> -               return 0;
> +       /*
> +        * For spinlock and rwlock, it needs to get the timestamp for the
> +        * per-cpu map.  However, contention_end does not have the flags
> +        * so it cannot know whether it reads percpu or hash map.
> +        *
> +        * Try per-cpu map first and check if there's active contention.
> +        * If it is, do not read hash map because it cannot go to sleepin=
g
> +        * locks before releasing the spinning locks.
> +        */
> +       pelem =3D bpf_map_lookup_elem(&tstamp_cpu, &idx);
> +       if (pelem && pelem->lock) {
> +               if (pelem->lock !=3D ctx[0])
> +                       return 0;
> +       } else {
> +               pid =3D bpf_get_current_pid_tgid();
> +               pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
> +               if (!pelem || pelem->lock !=3D ctx[0])
> +                       return 0;
> +               need_delete =3D true;
> +       }
>
>         duration =3D bpf_ktime_get_ns() - pelem->timestamp;
>         if ((__s64)duration < 0) {
>                 pelem->lock =3D 0;
> -               bpf_map_delete_elem(&tstamp, &pid);
> +               if (need_delete)
> +                       bpf_map_delete_elem(&tstamp, &pid);
>                 __sync_fetch_and_add(&time_fail, 1);
>                 return 0;
>         }
> @@ -406,8 +455,11 @@ int contention_end(u64 *ctx)
>         case LOCK_AGGR_TASK:
>                 if (lock_owner)
>                         key.pid =3D pelem->flags;
> -               else
> +               else {
> +                       if (!need_delete)
> +                               pid =3D bpf_get_current_pid_tgid();
>                         key.pid =3D pid;
> +               }
>                 if (needs_callstack)
>                         key.stack_id =3D pelem->stack_id;
>                 break;
> @@ -428,7 +480,8 @@ int contention_end(u64 *ctx)
>         if (!data) {
>                 if (data_map_full) {
>                         pelem->lock =3D 0;
> -                       bpf_map_delete_elem(&tstamp, &pid);
> +                       if (need_delete)
> +                               bpf_map_delete_elem(&tstamp, &pid);
>                         __sync_fetch_and_add(&data_fail, 1);
>                         return 0;
>                 }
> @@ -452,7 +505,8 @@ int contention_end(u64 *ctx)
>                         __sync_fetch_and_add(&data_fail, 1);
>                 }
>                 pelem->lock =3D 0;
> -               bpf_map_delete_elem(&tstamp, &pid);
> +               if (need_delete)
> +                       bpf_map_delete_elem(&tstamp, &pid);
>                 return 0;
>         }
>
> @@ -466,7 +520,8 @@ int contention_end(u64 *ctx)
>                 data->min_time =3D duration;
>
>         pelem->lock =3D 0;
> -       bpf_map_delete_elem(&tstamp, &pid);
> +       if (need_delete)
> +               bpf_map_delete_elem(&tstamp, &pid);
>         return 0;
>  }
>
> --
> 2.42.0.655.g421f12c284-goog
>

