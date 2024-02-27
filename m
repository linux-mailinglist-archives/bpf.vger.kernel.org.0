Return-Path: <bpf+bounces-22819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7186A2E7
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954F028E792
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0855E4F;
	Tue, 27 Feb 2024 22:59:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483955C20;
	Tue, 27 Feb 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074776; cv=none; b=Vn4xbYtbbuQI9W1LIhhdQ07MNgIanYZzOMkHOBnj6HNhhpRdABtb/WOY7TUcks0eLyDGk7plzOKNM3OT97ZNK6WD5VO0NHwZiEGa8ibc9+FtpCra+c2hLznTLvp9awkOd12Gcu9HLafPM8POxJKgsdrOgY4em/AakTU7kiLVbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074776; c=relaxed/simple;
	bh=3eAUqlT0wQJf/+jtfc2ilbcMXftHXIkOzQycF3JRhfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNcWMjGC6fgLZdCNUOnGedUdcH8f9froIRHDOs+OjJNrt3YKz9AEqmlJqDfy+hZQCRgou+ykHAe62MNn+R9Q1lONFC2FpiAQw3MyfZnVpN87rR+4NiMLmedNFWSSJJKMsOY3zyOUVz+oa+TG7xPo2jSDp4nTL+iHYKIh7zl8hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29ad8ef1384so1622022a91.3;
        Tue, 27 Feb 2024 14:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074774; x=1709679574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuCUMb0/dv6ebyslKfhHgXOZ4LoyHSK2csMcnV0iOt8=;
        b=IzHkJ+JevyGtXsy+UjySennmMlIuEyVLL8bLWwn6BMfiVrjbVfip4s0WDtdCCRIYr3
         cAviCnfzvLFx2gSFBTkLDLz5ugkd8H4b8LST7T2nFXnkHHYOz8pG+XfroBnyYCnuTAAz
         a9LjYLbmHJbBL/gRAWF8B/OGHQtV4kCQPwWBVCMazTMyt6FCtVdlt/HZ9GLojFf15WJA
         altXJQWgcedptrxwZDEYjAwje3gzjRFB5flK74IUdU1CNiaECt3AcgaEp0VqBJBsUXJv
         KXiF6wCjpGubEWHd10ympGVPfYOq8/Lal0rPCC+Bxlgf4B/mFKs/3I5hBPBG+85BiX8+
         wbIg==
X-Forwarded-Encrypted: i=1; AJvYcCVdV2rxQOqdr4/Rr3GfkPiuVhUpVd2ox1jnevyF5XdUMXMPFEZt8FYb6eZh56ABjtCh3NvKUGvaDasINAsM4CjsgN+5VpaHLWkW+Z72ChJZn6JwRXc+ShNoqpXP0ujVAba5rDi1sdsuXkcaqCGU3RPFIX8Slf9NG+1taN2GQ/O/dblZjw==
X-Gm-Message-State: AOJu0YyURr3EodMJG78etcsYMF7/1WQIO4QT/0ms0cJq9M7f3muXj1xG
	uW+JWuqtZ4b8K7UOhA2b25eRGGORdKEsAyLbEhlyYWnFVVWkLRHSkNXXpJ3rBl+n52pgSbJ52Sa
	sEJgigTH6KHJcahVX4JvV5na9leXk6cdC
X-Google-Smtp-Source: AGHT+IEC3k8yEDAodSG8V5zdY6ILU0/a/D2QUs3Ug7tboxZWyn5sSiZjS67CmPwsRhf/LJU7fLV+QO5pnM1wlMPNerM=
X-Received: by 2002:a17:90a:1b8f:b0:29a:9093:619a with SMTP id
 w15-20020a17090a1b8f00b0029a9093619amr8775349pjc.20.1709074774466; Tue, 27
 Feb 2024 14:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209230657.1546739-1-namhyung@kernel.org>
In-Reply-To: <20240209230657.1546739-1-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 14:59:22 -0800
Message-ID: <CAM9d7chXmenDZQCXS_z2qbsgHpYDTjOXpWNHkaH7TF56HAe1hw@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf lock contention: Account contending locks too
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping!

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
>

