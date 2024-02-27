Return-Path: <bpf+bounces-22825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BF86A3F4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B41C23FEC
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4596D56745;
	Tue, 27 Feb 2024 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7+iayxK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEBF5732E
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077764; cv=none; b=N30tjAdXaL2QtCYyHJl2VxdYCx7dGrFeReijWLkYydBn6MW1lMBAOzOHXaA51K3afzJHfMmHyqIrwo+9xdoBiWfUf1zP6qgEXN8IeK6pm+ePGmXZh1BpEUhKPRZpmU4WLpy8iw/tE7dwAGQ3frU1CJOly5iL4ApcyUUEB8Ucpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077764; c=relaxed/simple;
	bh=BjSVREnwaKKfnQy0EFg96CDxrUW/Z3xtym2JUrP5j7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOAKopTnGQXLHX72GpDdlo+C2PDSgmm70GRkgkN3LvlQ/2vijnxGC3hq7RhlgjEfewoYEmTnM+Qm5c5jxLtFkve0MNd+L0WxyUg0kS14UWghQ9XvXzw21ls9Xbjp7jtPc1niUvH66bo/DbFJg+mkH35TCLQIaih15xYmFIp5t2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7+iayxK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e7f5e24beso41271cf.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709077762; x=1709682562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB+oDvTegAoqW/a6zO4hY697uXjjJMY31kDG8xh1h4o=;
        b=G7+iayxKJGT6tCK7nTG4kpm3V1iH5N7oOvNYyX/EgR/kEden4sZwdAiCU78+9li9Ry
         TVqEYEaVNV4iAQjBHJi6GxDjVMJkoAKU8753w8Cy0Inct6wmlC6LxsmAPEup/LDL/2jk
         ANeimdvTfIvZe0R3Z+SrwV01+LAIGkdU9BIDPK8O0VyR+hir1aV14KJz0zSeueqamUaM
         dQvyyTNpvccs6VBDY4dQIAWA8DvRTALx+OrhLXW0wfFhwRBxWcqy9w396uAuo4S7hQc+
         XB4nc0T+A72A2yp1w4tJV+5wkzWI4h8zAvsN7hVEhzE2WfSEKCS3xjIf0/jaRvq6/R/O
         u9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077762; x=1709682562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB+oDvTegAoqW/a6zO4hY697uXjjJMY31kDG8xh1h4o=;
        b=mIo2+NfexgrP3JhxffYO6NUx1nEPcV3UL2qX1klgQPJYhYw5q3gx5wUubBMFcV9v9f
         HcyeNAJvwJTctVa9cjQF/MDikQGq52odxghazUg8JztBiwymxgeNVti6MgUWFrQdB9Ia
         oiDSVh5bbfarfw8LY+Pwd7C4ImQIyLQSnAETtrbfDytwlLg4tv4T2YbMQZbOI7hRQZdU
         lYIBX79xpMJkn5GK7bkcz8Np7cnEMQj14oN28CRZmuUQGxvyOszS662p+Ic281tjaKYT
         azj1I73h3zbU3StaSTYYIVApZLZ62kivy/ll5w9VRRAxAmwXuZ2/yHIX+t6iMw9N9144
         kffw==
X-Forwarded-Encrypted: i=1; AJvYcCXOG2a4L5hO1R+LhoYn1yiMwd5zkvTUelE4HI7tSyuJ/3VdoUnC2R/h0BJC+qRc7WB50uoh8KEcNlwljoEAeQSERU2h
X-Gm-Message-State: AOJu0YzAudx2SKEqKLvNKEXxY8qLjrNcyUB/U6ncTcDqMYZOM1xx/M8U
	cY93Va1iXBf/bTkJb1lA6V3C0N5cyQOH2Pl4E5q44QkzsmBGf76EIXspbc/dSHtuyYFA2EpXvr0
	1ziUeq/IuIJST2cIwWxcY2mZXhwesqZ+G1AP7
X-Google-Smtp-Source: AGHT+IHM7TEANHzIYObsHNi671bgtwi0eCmbByAIOUPbycwTPKqBP83wkpna9tjc8pKZoCwpg6kB2WplhLAR5igeWLk=
X-Received: by 2002:a05:622a:104c:b0:42e:8e9e:3a1f with SMTP id
 f12-20020a05622a104c00b0042e8e9e3a1fmr47990qte.10.1709077761778; Tue, 27 Feb
 2024 15:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209230657.1546739-1-namhyung@kernel.org>
In-Reply-To: <20240209230657.1546739-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 15:49:07 -0800
Message-ID: <CAP-5=fWS-5vbX+dF+bjPLf4OkkQg2kV515oLGTwL6C8kU7Gu3g@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf lock contention: Account contending locks too
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Currently it accounts the contention using delta between timestamps in
> lock:contention_begin and lock:contention_end tracepoints.  But it means
> the lock should see the both events during the monitoring period.
>
> Actually there are 4 cases that happen with the monitoring:
>
>                 monitoring period
>             /                       \
>             |                       |
>  1:  B------+-----------------------+--------E
>  2:    B----+-------------E         |
>  3:         |           B-----------+----E
>  4:         |     B-------------E   |
>             |                       |
>             t0                      t1
>
> where B and E mean contention BEGIN and END, respectively.  So it only
> accounts the case 4 for now.  It seems there's no way to handle the case
> 1.  The case 2 might be handled if it saved the timestamp (t0), but it
> lacks the information from the B notably the flags which shows the lock
> types.  Also it could be a nested lock which it currently ignores.  So
> I think we should ignore the case 2.
>
> However we can handle the case 3 if we save the timestamp (t1) at the
> end of the period.  And then it can iterate the map entries in the
> userspace and update the lock stat accordinly.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_lock_contention.c         | 116 ++++++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 +--
>  tools/perf/util/bpf_skel/lock_data.h          |   7 ++
>  3 files changed, 132 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 31ff19afc20c..d6bafd9a3955 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -179,6 +179,119 @@ int lock_contention_prepare(struct lock_contention =
*con)
>         return 0;
>  }
>
> +static void mark_end_timestamp(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +               .flags =3D BPF_F_TEST_RUN_ON_CPU,

It seems strange that this and the raw tracepoint are both test. I see
similar non-test uses in libbpf-tools. It would be worth documenting
that this isn't test code. Everything else LGTM.

Thanks,
Ian

> +       );
> +       int prog_fd =3D bpf_program__fd(skel->progs.end_timestamp);
> +
> +       bpf_prog_test_run_opts(prog_fd, &opts);
> +}
> +
> +static void update_lock_stat(int map_fd, int pid, u64 end_ts,
> +                            enum lock_aggr_mode aggr_mode,
> +                            struct tstamp_data *ts_data)
> +{
> +       u64 delta;
> +       struct contention_key stat_key =3D {};
> +       struct contention_data stat_data;
> +
> +       if (ts_data->timestamp >=3D end_ts)
> +               return;
> +
> +       delta =3D end_ts - ts_data->timestamp;
> +
> +       switch (aggr_mode) {
> +       case LOCK_AGGR_CALLER:
> +               stat_key.stack_id =3D ts_data->stack_id;
> +               break;
> +       case LOCK_AGGR_TASK:
> +               stat_key.pid =3D pid;
> +               break;
> +       case LOCK_AGGR_ADDR:
> +               stat_key.lock_addr_or_cgroup =3D ts_data->lock;
> +               break;
> +       case LOCK_AGGR_CGROUP:
> +               /* TODO */
> +               return;
> +       default:
> +               return;
> +       }
> +
> +       if (bpf_map_lookup_elem(map_fd, &stat_key, &stat_data) < 0)
> +               return;
> +
> +       stat_data.total_time +=3D delta;
> +       stat_data.count++;
> +
> +       if (delta > stat_data.max_time)
> +               stat_data.max_time =3D delta;
> +       if (delta < stat_data.min_time)
> +               stat_data.min_time =3D delta;
> +
> +       bpf_map_update_elem(map_fd, &stat_key, &stat_data, BPF_EXIST);
> +}
> +
> +/*
> + * Account entries in the tstamp map (which didn't see the corresponding
> + * lock:contention_end tracepoint) using end_ts.
> + */
> +static void account_end_timestamp(struct lock_contention *con)
> +{
> +       int ts_fd, stat_fd;
> +       int *prev_key, key;
> +       u64 end_ts =3D skel->bss->end_ts;
> +       int total_cpus;
> +       enum lock_aggr_mode aggr_mode =3D con->aggr_mode;
> +       struct tstamp_data ts_data, *cpu_data;
> +
> +       /* Iterate per-task tstamp map (key =3D TID) */
> +       ts_fd =3D bpf_map__fd(skel->maps.tstamp);
> +       stat_fd =3D bpf_map__fd(skel->maps.lock_stat);
> +
> +       prev_key =3D NULL;
> +       while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> +               if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) =3D=3D 0) =
{
> +                       int pid =3D key;
> +
> +                       if (aggr_mode =3D=3D LOCK_AGGR_TASK && con->owner=
)
> +                               pid =3D ts_data.flags;
> +
> +                       update_lock_stat(stat_fd, pid, end_ts, aggr_mode,
> +                                        &ts_data);
> +               }
> +
> +               prev_key =3D &key;
> +       }
> +
> +       /* Now it'll check per-cpu tstamp map which doesn't have TID. */
> +       if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_AGGR=
_CGROUP)
> +               return;
> +
> +       total_cpus =3D cpu__max_cpu().cpu;
> +       ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
> +
> +       cpu_data =3D calloc(total_cpus, sizeof(*cpu_data));
> +       if (cpu_data =3D=3D NULL)
> +               return;
> +
> +       prev_key =3D NULL;
> +       while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> +               if (bpf_map_lookup_elem(ts_fd, &key, cpu_data) < 0)
> +                       goto next;
> +
> +               for (int i =3D 0; i < total_cpus; i++) {
> +                       update_lock_stat(stat_fd, -1, end_ts, aggr_mode,
> +                                        &cpu_data[i]);
> +               }
> +
> +next:
> +               prev_key =3D &key;
> +       }
> +       free(cpu_data);
> +}
> +
>  int lock_contention_start(void)
>  {
>         skel->bss->enabled =3D 1;
> @@ -188,6 +301,7 @@ int lock_contention_start(void)
>  int lock_contention_stop(void)
>  {
>         skel->bss->enabled =3D 0;
> +       mark_end_timestamp();
>         return 0;
>  }
>
> @@ -301,6 +415,8 @@ int lock_contention_read(struct lock_contention *con)
>         if (stack_trace =3D=3D NULL)
>                 return -1;
>
> +       account_end_timestamp(con);
> +
>         if (con->aggr_mode =3D=3D LOCK_AGGR_TASK) {
>                 struct thread *idle =3D __machine__findnew_thread(machine=
,
>                                                                 /*pid=3D*=
/0,
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 95cd8414f6ef..fb54bd38e7d0 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -19,13 +19,6 @@
>  #define LCB_F_PERCPU   (1U << 4)
>  #define LCB_F_MUTEX    (1U << 5)
>
> -struct tstamp_data {
> -       __u64 timestamp;
> -       __u64 lock;
> -       __u32 flags;
> -       __s32 stack_id;
> -};
> -
>  /* callstack storage  */
>  struct {
>         __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> @@ -140,6 +133,8 @@ int perf_subsys_id =3D -1;
>  /* determine the key of lock stat */
>  int aggr_mode;
>
> +__u64 end_ts;
> +
>  /* error stat */
>  int task_fail;
>  int stack_fail;
> @@ -559,4 +554,11 @@ int BPF_PROG(collect_lock_syms)
>         return 0;
>  }
>
> +SEC("raw_tp/bpf_test_finish")
> +int BPF_PROG(end_timestamp)
> +{
> +       end_ts =3D bpf_ktime_get_ns();
> +       return 0;
> +}
> +
>  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_s=
kel/lock_data.h
> index 08482daf61be..36af11faad03 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -3,6 +3,13 @@
>  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
>  #define UTIL_BPF_SKEL_LOCK_DATA_H
>
> +struct tstamp_data {
> +       u64 timestamp;
> +       u64 lock;
> +       u32 flags;
> +       u32 stack_id;
> +};
> +
>  struct contention_key {
>         u32 stack_id;
>         u32 pid;
> --
> 2.43.0.687.g38aa6559b0-goog
>

