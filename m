Return-Path: <bpf+bounces-22844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6986A85B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7C21F23043
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB622619;
	Wed, 28 Feb 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFlYRe1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189B1CFB9
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101954; cv=none; b=jLZnDjsO/TcBuqO4+FW1TSjLdrwJisrIJdaEsb8P598NQOGm495KyrYpx21W82yDT7H6ejxcFDGcwAFK7rSBEOhdIXWMdK8rnTguczaykAdYaCsu4O/8luljya5Kar3AOVAZnz1A/RV57jzATfNGKY3P7oKGV2g99shfMKB0c/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101954; c=relaxed/simple;
	bh=QcQL8W30rO/wVOY4BowBdqac0u0A3vahCxu4ucWjwmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNp3OkHUQMgkSE27oARZKonZHeVGnZHHOa4NeBrFQZot8JdTiktx+7KwaTM4QDGT4wnhW+0+FaASj6SURIJ/uqYCpeFRvXB6X9HDBLfhRzaYx3Drc2oFK31YvOTdKe+gKnqqkj9BmU8Y1T68KKXKoSe3c6qNWZAeGz9McrPX7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aFlYRe1M; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e7f5e24beso104041cf.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709101951; x=1709706751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kfropls9BSDYywJcFgAsbuoKFtsZgwR3FdIR6FHl8M=;
        b=aFlYRe1MCnA/UlzLsUj6aOXS0Ib37A8sSREoPu0QqSj9VEXwYlaIcqnv3SpwRzcHUk
         QUO7NzePXz9TvdZMlb1M3fIm/c2/elNKq2Lq1noE9GDbIEcf5mikmhAZhzI7j4KIg+Of
         9RxWrMGcKEbcBnYDwyNbrictCIyOiZgSIb1s7ehKGTFtToasNTTyIhIT40u43/KNjJ1x
         b9TtdwWgv4TFwuS1fzS/IUua7tKP2k+gZtVa/Z1d5ANoau1Dwpn/k4gAbTHn9UkuGvcU
         SD4C7vx+FXBtnduKTL1VVE0Bi7PPwdL1/cScEsGntoCmM/7Q2K0nuvgMOI+r6DlGKNqL
         0KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709101951; x=1709706751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kfropls9BSDYywJcFgAsbuoKFtsZgwR3FdIR6FHl8M=;
        b=DpOKxsNurEVmeanWHf5MHx8PaM9afGw0k5NjTxRU8eqFjqYcIFtL4019eb+pSi2iAi
         5ETVMNtn9hOpJm2WtUvHkFB2fxTZOTdkQYnW0rhd+0PAyMPDoTq7z9rFVyZtIamh/Hvq
         4jPzFvGDOOx0Rv0vKnCHVIkqzN+I1JHmknlEwrIOeOp3kd1o/qjGMmch8/cYOdT+81IS
         c/KxdIC6Q93+VJ9VBy13I/WZWc8XxF2E920lYKenk1J24EE92f+QAO0AXZ29utITjoF9
         Q78sVjbbuFQZf8q4HzDHqY12bxDLUa+mni7oJA/LHyHnzxt4anSM47DcJf5CfpulGDks
         2nDA==
X-Forwarded-Encrypted: i=1; AJvYcCVcRoR6W16tpTC+zEdKsosKP2vTjKRJcXjkjm3p2gYz/20ZIEnzK7rXIyffmvvy13ja9G9VsAccoghwXf/qpFfqBBeZ
X-Gm-Message-State: AOJu0YyJjtR1fQVE6209HeyPVUo1pGMmkknqMjzxm39AzpTYMpV+1BZV
	AuUbVW2PilKach/S9SCDcESVw2prbs93DvATeHlv9KkPvzNWPecHjHdtGvbGDXklAq/yLRbGYXu
	3XZo4Z/GQLVBOBk4S0GOH4dBiV6OLLMs5LAQF
X-Google-Smtp-Source: AGHT+IFr70f+civQ/3UgYuEXfwZtiYoi7vW1i3oKDsuea3RfDA2ANF593blcGYeON7f3wUylYfBeXlmyZCY2Y/AiKTE=
X-Received: by 2002:a05:622a:4c6:b0:42e:3233:4924 with SMTP id
 q6-20020a05622a04c600b0042e32334924mr56931qtx.26.1709101951306; Tue, 27 Feb
 2024 22:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228053335.312776-1-namhyung@kernel.org>
In-Reply-To: <20240228053335.312776-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 22:32:17 -0800
Message-ID: <CAP-5=fVzYnn1wV1H6Uxv9ZSy2S+5yCC_DCvj6e0YueLpXmmx8A@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2: add a comment on mark_end_timestamp  (Ian)
>
>  tools/perf/util/bpf_lock_contention.c         | 120 ++++++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 ++-
>  tools/perf/util/bpf_skel/lock_data.h          |   7 +
>  3 files changed, 136 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 31ff19afc20c..9af76c6b2543 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -179,6 +179,123 @@ int lock_contention_prepare(struct lock_contention =
*con)
>         return 0;
>  }
>
> +/*
> + * Run the BPF program directly using BPF_PROG_TEST_RUN to update the en=
d
> + * timestamp in ktime so that it can calculate delta easily.
> + */
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
> @@ -188,6 +305,7 @@ int lock_contention_start(void)
>  int lock_contention_stop(void)
>  {
>         skel->bss->enabled =3D 0;
> +       mark_end_timestamp();
>         return 0;
>  }
>
> @@ -301,6 +419,8 @@ int lock_contention_read(struct lock_contention *con)
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
> 2.44.0.rc1.240.g4c46232300-goog
>

