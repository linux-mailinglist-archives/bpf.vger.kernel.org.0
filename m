Return-Path: <bpf+bounces-52535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F04A44701
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A718657AC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9DA20D4F0;
	Tue, 25 Feb 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBrg/oT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF920AF63
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501883; cv=none; b=HvFZ3pOOgl0P1YxnPL1U9YTomYNENKeltc36F4A4zr4yjQZzJTTDsH15Ul95nfDYs+e2C6bKTPdMb0ugFdSYR41mg4JQAFhCIqb2TWobUgZECFbVwcZClptoaDKkfr99Y7SetRXPU9oSExuKH4tFE39F9dJb9hqXIJA4RTp6sTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501883; c=relaxed/simple;
	bh=kJnD+0JaTLrFOyAxLZ70o0LwwXfWT6yvIZpu36g0Tjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU0bxjGCFAwQLM4yRwcoLa64vuibkOqLP35jmLcNWqhRsrGQtCt0J/FzEIGFb/3Xn+jtaTnmZHu5Yz8eYHoBmVjuQLRj1R9E4RfEysOWshhhxBYoNUjyqYK6p+jrkJok0ZxS5m8YDYOm6L1VoqK0+NuYVWAH4anrMYWBrbxcu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBrg/oT0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22117c396baso194115ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740501879; x=1741106679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGSs/JSI8SEUQCLYMu6kZkdG6dALsaStwDncGnOsLsM=;
        b=HBrg/oT0SRysqSvBRimUWhHwWVeun7nUjcmMyBTrC4j1aXoLOTdnFPmISo7sSUZKMi
         lULcj3dM/oTs6oPbFCoWg7Iunf6D/EMxaszNz0cDEEjmCnkTAEoj1g7R34E+lb7phOJt
         5+L961ZDBABc/8AltUI4a/RsfLb6nV+Eg/U0/FMAoSQ7w1WeyEhB7a9x35Tkt4xSCDrW
         IX7nortNx6hOyuVOC9ykRf5NILqL1yNIejiGSbDoIFB6kjpvd6A9Lhw6C0KBp1IivCbz
         9szwvn16X6KH3VaEv9dI1KA0jtKNWRIZyQ+JLGpQzhzkkAPgjJHlk9pTw3eXkQPQrRAP
         5rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501879; x=1741106679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGSs/JSI8SEUQCLYMu6kZkdG6dALsaStwDncGnOsLsM=;
        b=Jo19okO/+amExdQ7XWdZjY//NdVu+NbKphVlXgz7viJ+90R3LSUfpespqZvxextRCM
         1kcOnDXkG/5t0C5Fb4FFu7h8acdpuKNXX6ZwIRYSPGFhh9zOG2AuH6TfmoNwVAsomTnG
         yJTjJ+P5J87hHJ5Q7uI28URN/Ho7XSOzEpVobDg+9S//V36MS4zFizQmAYngW/yto48H
         hmxEK4JAkviIYz4nChvaRCzzvD50juNrDo9NjzOo+ER19NNzP97bmRdk1mCGwA1l5FZ4
         tUMvVEc20tl5fisnjGimbYt+75AG8uklNm4j9+vCpDCQwW/W/SRrdDDgNpEGSFaXgmZi
         CTqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5vcN4t1Dvq/H+DMULFtcle7Wsf7r0e4E8/eHVlN2Q5nR9nIwoIxFd3BEW2haH0xqj1bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xeF3cO/w6yX2GTKo4HJT2xfXYSniVP7ESmQz9ZF1v2R3LJ9q
	GZXtAYfiZDUpnWoQY46GLWPRSAuPwdZhNtf0LdNu4uz3JqDQo/Hkn2dHwM2a7nWBl8sh63iq8wb
	shRP22PgMNniMCjs004Mt8KpMD15Pknt54uRX
X-Gm-Gg: ASbGncs0wCxpR4qVvOTyf9+vWTUv6/lVPDWpkBIg2jGp1GyjN7DlkAYKOiWcspVrDdn
	5AqaQM4xU3jC6cdv3t3vNhzEIeQ7WWgy7M93ccIvftvC219hoSgLJENrnGbH6d5sN86K18ssiZs
	WkqAieB8roqDj4WAUZQ0p8Xqj61Zb9+Weuq1Y=
X-Google-Smtp-Source: AGHT+IHfLN0CJT0NjsZF0SbQ2PniysFKbdfeS7mbnxQfY/V/txeRKepNOzJvQ9J1WAoiISRI3YrpMOYOm7/Kcuc34Hg=
X-Received: by 2002:a17:902:db10:b0:21f:2306:e453 with SMTP id
 d9443c01a7336-22307a3d994mr3582995ad.7.1740501877848; Tue, 25 Feb 2025
 08:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225075929.900995-1-namhyung@kernel.org>
In-Reply-To: <20250225075929.900995-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 08:44:26 -0800
X-Gm-Features: AWEUYZlyy0R7OVA4dyKqHRMJGSB5LQ4A4TKH9eQBnOo-S1n7wGoFbXKFQtvfQ8M
Message-ID: <CAP-5=fW+48MMa13weoC2FE7Vt1UTVEO7uza5Kyi_NHZKDfZ9vA@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -J/--inject-delay option
To: Namhyung Kim <namhyung@kernel.org>
Cc: emery@cs.umass.edu, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> This is to slow down lock acquistion (on contention locks) deliberately.
> A possible use case is to estimate impact on application performance by
> optimization of kernel locking behavior.  By delaying the lock it can
> simulate the worse condition as a control group, and then compare with
> the current behavior as a optimized condition.

This is great! There are similarities to me with coz (Emery Berger
cc-ed for a headsup and possible input):
https://github.com/plasma-umass/coz

> The syntax is 'time@function' and the time can have unit suffix like
> "us" and "ms".  For example, I ran a simple test like below.
>
>   $ sudo perf lock con -abl -L tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   =
symbol
>
>           92      1.18 ms    199.54 us     12.79 us   ffffffff8a806080   =
tasklist_lock (rwlock)
>
> The contention count was 92 and the average wait time was around 10 us.
> But if I add 100 usec of delay to the tasklist_lock,
>
>   $ sudo perf lock con -abl -L tasklist_lock -J 100us@tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   =
symbol
>
>          190     15.67 ms    230.10 us     82.46 us   ffffffff8a806080   =
tasklist_lock (rwlock)
>
> The contention count increased and the average wait time was up closed
> to 100 usec.  If I increase the delay even more,
>
>   $ sudo perf lock con -abl -L tasklist_lock -J 1ms@tasklist_lock -- \
>     sh -c 'for i in $(seq 1000); do sleep 1 & done; wait'
>    contended   total wait     max wait     avg wait            address   =
symbol
>
>         1002      2.80 s       3.01 ms      2.80 ms   ffffffff8a806080   =
tasklist_lock (rwlock)
>
> Now every sleep process had contention and the wait time was more than 1
> msec.  This is on my 4 CPU laptop so I guess one CPU has the lock while
> other 3 are waiting for it mostly.
>
> For simplicity, it only supports global locks for now.
>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt        | 11 +++
>  tools/perf/builtin-lock.c                     | 74 +++++++++++++++++++
>  tools/perf/util/bpf_lock_contention.c         | 28 +++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 43 +++++++++++
>  tools/perf/util/lock-contention.h             |  8 ++
>  5 files changed, 164 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index d3793054f7d35626..151fc837587b216e 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -215,6 +215,17 @@ CONTENTION OPTIONS
>  --cgroup-filter=3D<value>::
>         Show lock contention only in the given cgroups (comma separated l=
ist).
>
> +-J::
> +--inject-delay=3D<time@function>::
> +       Add delays to the given lock.  It's added to the contention-end p=
art so
> +       that the (new) owner of the lock will be delayed.  But by slowing=
 down
> +       the owner, the waiters will also be delayed as well.  This is wor=
king
> +       only with -b/--use-bpf.
> +
> +       The 'time' is specified in nsec but it can have a unit suffix.  A=
vailable
> +       units are "ms" and "us".  Note that it will busy-wait after it ge=
ts the
> +       lock.  Please use it at your own risk.
> +
>
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 5d405cd8e696d21b..3ef452d5d9f5679d 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -62,6 +62,8 @@ static const char *output_name =3D NULL;
>  static FILE *lock_output;
>
>  static struct lock_filter filters;
> +static struct lock_delay *delays;
> +static int nr_delays;
>
>  static enum lock_aggr_mode aggr_mode =3D LOCK_AGGR_ADDR;
>
> @@ -1971,6 +1973,8 @@ static int __cmd_contention(int argc, const char **=
argv)
>                 .max_stack =3D max_stack_depth,
>                 .stack_skip =3D stack_skip,
>                 .filters =3D &filters,
> +               .delays =3D delays,
> +               .nr_delays =3D nr_delays,
>                 .save_callstack =3D needs_callstack(),
>                 .owner =3D show_lock_owner,
>                 .cgroups =3D RB_ROOT,
> @@ -2474,6 +2478,74 @@ static int parse_cgroup_filter(const struct option=
 *opt __maybe_unused, const ch
>         return ret;
>  }
>
> +static bool add_lock_delay(char *spec)
> +{
> +       char *at, *pos;
> +       struct lock_delay *tmp;
> +       unsigned long duration;
> +
> +       at =3D strchr(spec, '@');
> +       if (at =3D=3D NULL) {
> +               pr_err("lock delay should have '@' sign: %s\n", spec);
> +               return false;
> +       }
> +       if (at =3D=3D spec) {
> +               pr_err("lock delay should have time before '@': %s\n", sp=
ec);
> +               return false;
> +       }
> +
> +       *at =3D '\0';
> +       duration =3D strtoul(spec, &pos, 0);
> +       if (!strcmp(pos, "ns"))
> +               duration *=3D 1;
> +       else if (!strcmp(pos, "us"))
> +               duration *=3D 1000;
> +       else if (!strcmp(pos, "ms"))
> +               duration *=3D 1000 * 1000;
> +       else if (*pos) {
> +               pr_err("invalid delay time: %s@%s\n", spec, at + 1);
> +               return false;
> +       }
> +
> +       tmp =3D realloc(delays, (nr_delays + 1) * sizeof(*delays));
> +       if (tmp =3D=3D NULL) {
> +               pr_err("Memory allocation failure\n");
> +               return false;
> +       }
> +       delays =3D tmp;
> +
> +       delays[nr_delays].sym =3D strdup(at + 1);
> +       if (delays[nr_delays].sym =3D=3D NULL) {
> +               pr_err("Memory allocation failure\n");
> +               return false;
> +       }
> +       delays[nr_delays].time =3D duration;
> +
> +       nr_delays++;
> +       return true;
> +}
> +
> +static int parse_lock_delay(const struct option *opt __maybe_unused, con=
st char *str,
> +                           int unset __maybe_unused)
> +{
> +       char *s, *tmp, *tok;
> +       int ret =3D 0;
> +
> +       s =3D strdup(str);
> +       if (s =3D=3D NULL)
> +               return -1;
> +
> +       for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> +               if (!add_lock_delay(tok)) {
> +                       ret =3D -1;
> +                       break;
> +               }
> +       }
> +
> +       free(s);
> +       return ret;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>         const struct option lock_options[] =3D {
> @@ -2550,6 +2622,8 @@ int cmd_lock(int argc, const char **argv)
>         OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stat=
s by cgroup"),
>         OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
>                      "Filter specific cgroups", parse_cgroup_filter),
> +       OPT_CALLBACK('J', "inject-delay", NULL, "TIME@FUNC",
> +                    "Inject delays to specific locks", parse_lock_delay)=
,
>         OPT_PARENT(lock_options)
>         };
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index fc8666222399c995..99b64f303e761cbc 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -183,6 +183,27 @@ int lock_contention_prepare(struct lock_contention *=
con)
>                 skel->rodata->has_addr =3D 1;
>         }
>
> +       /* resolve lock name in delays */
> +       if (con->nr_delays) {
> +               struct symbol *sym;
> +               struct map *kmap;
> +
> +               for (i =3D 0; i < con->nr_delays; i++) {
> +                       sym =3D machine__find_kernel_symbol_by_name(con->=
machine,
> +                                                                 con->de=
lays[i].sym,
> +                                                                 &kmap);
> +                       if (sym =3D=3D NULL) {
> +                               pr_warning("ignore unknown symbol: %s\n",
> +                                          con->delays[i].sym);
> +                               continue;
> +                       }
> +
> +                       con->delays[i].addr =3D map__unmap_ip(kmap, sym->=
start);
> +               }
> +               skel->rodata->lock_delay =3D 1;
> +               bpf_map__set_max_entries(skel->maps.lock_delays, con->nr_=
delays);
> +       }
> +
>         bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
>         bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
>         bpf_map__set_max_entries(skel->maps.type_filter, ntypes);
> @@ -272,6 +293,13 @@ int lock_contention_prepare(struct lock_contention *=
con)
>                         bpf_map_update_elem(fd, &con->filters->cgrps[i], =
&val, BPF_ANY);
>         }
>
> +       if (con->nr_delays) {
> +               fd =3D bpf_map__fd(skel->maps.lock_delays);
> +
> +               for (i =3D 0; i < con->nr_delays; i++)
> +                       bpf_map_update_elem(fd, &con->delays[i].addr, &co=
n->delays[i].time, BPF_ANY);
> +       }
> +
>         if (con->aggr_mode =3D=3D LOCK_AGGR_CGROUP)
>                 read_all_cgroups(&con->cgroups);
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 6533ea9b044c71d1..0ac9ae2f1711a129 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -11,6 +11,9 @@
>  /* for collect_lock_syms().  4096 was rejected by the verifier */
>  #define MAX_CPUS  1024
>
> +/* for do_lock_delay().  Arbitrarily set to 1 million. */
> +#define MAX_LOOP  (1U << 20)
> +
>  /* lock contention flags from include/trace/events/lock.h */
>  #define LCB_F_SPIN     (1U << 0)
>  #define LCB_F_READ     (1U << 1)
> @@ -114,6 +117,13 @@ struct {
>         __uint(max_entries, 1);
>  } slab_caches SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(key_size, sizeof(__u64));
> +       __uint(value_size, sizeof(__u64));
> +       __uint(max_entries, 1);
> +} lock_delays SEC(".maps");
> +
>  struct rw_semaphore___old {
>         struct task_struct *owner;
>  } __attribute__((preserve_access_index));
> @@ -143,6 +153,7 @@ const volatile int needs_callstack;
>  const volatile int stack_skip;
>  const volatile int lock_owner;
>  const volatile int use_cgroup_v2;
> +const volatile int lock_delay;
>
>  /* determine the key of lock stat */
>  const volatile int aggr_mode;
> @@ -348,6 +359,35 @@ static inline __u32 check_lock_type(__u64 lock, __u3=
2 flags)
>         return 0;
>  }
>
> +static inline long delay_callback(__u64 idx, void *arg)
> +{
> +       __u64 target =3D *(__u64 *)arg;
> +
> +       if (target <=3D bpf_ktime_get_ns())
> +               return 1;
> +
> +       /* just to kill time */
> +       (void)bpf_get_prandom_u32();
> +
> +       return 0;
> +}
> +
> +static inline void do_lock_delay(__u64 duration)
> +{
> +       __u64 target =3D bpf_ktime_get_ns() + duration;
> +
> +       bpf_loop(MAX_LOOP, delay_callback, &target, /*flags=3D*/0);
> +}
> +
> +static inline void check_lock_delay(__u64 lock)
> +{
> +       __u64 *delay;
> +
> +       delay =3D bpf_map_lookup_elem(&lock_delays, &lock);
> +       if (delay)
> +               do_lock_delay(*delay);
> +}
> +
>  static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
>  {
>         __u32 pid;
> @@ -566,6 +606,9 @@ int contention_end(u64 *ctx)
>                 data->min_time =3D duration;
>
>  out:
> +       if (lock_delay)
> +               check_lock_delay(pelem->lock);
> +

So the delay happens when a lock is coming out of contending, ideally
I think the code should slow releasing the lock as you are trying to
see how different tasks are impacted (how sensitive they are) to the
critical sections done when a lock is held. I don't believe there is a
way to do this with a regular kernel and BPF due to not having
tracepoints on the lock fast paths, it may be possible if the LOCKDEP
build option has been enabled for the kernel. Perhaps this work can
motivate the tracepoints on the fast paths.

Thanks,
Ian

>         pelem->lock =3D 0;
>         if (need_delete)
>                 bpf_map_delete_elem(&tstamp, &pid);
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-con=
tention.h
> index a09f7fe877df8184..12f6cb789ada1bc7 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -18,6 +18,12 @@ struct lock_filter {
>         char                    **slabs;
>  };
>
> +struct lock_delay {
> +       char                    *sym;
> +       unsigned long           addr;
> +       unsigned long           time;
> +};
> +
>  struct lock_stat {
>         struct hlist_node       hash_entry;
>         struct rb_node          rb;             /* used for sorting */
> @@ -140,6 +146,7 @@ struct lock_contention {
>         struct machine *machine;
>         struct hlist_head *result;
>         struct lock_filter *filters;
> +       struct lock_delay *delays;
>         struct lock_contention_fails fails;
>         struct rb_root cgroups;
>         unsigned long map_nr_entries;
> @@ -148,6 +155,7 @@ struct lock_contention {
>         int aggr_mode;
>         int owner;
>         int nr_filtered;
> +       int nr_delays;
>         bool save_callstack;
>  };
>
> --
> 2.48.1.658.g4767266eb4-goog
>

